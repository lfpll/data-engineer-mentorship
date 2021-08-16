import time
from datetime import datetime
import os
import requests
from pydantic import HttpUrl


def request_by_retries(request, retries:int,
                        req_args:dict,
                        wait:int=2) -> requests.Response:

    for _ in range(retries):
        resp = request(**req_args)
        
        # If 200 return
        if resp.status_code == 200:
            return resp
        
        # Sleep 2 seconds if wrong status
        time.sleep(wait)

    raise Exception("Unable to respond data with 404")
    
def pull_api(api:HttpUrl,querystring:str,retries:int=5,*kwargs) -> dict:
    # Remove last backspace
    if api[-1] == '/':
        api = api[:-1]
    
    url = '{0}/{1}'.format(api,querystring)
    resp = request_by_retries(requests.get,retries,
                              req_args={'url':url},*kwargs)
    
    import pdb;pdb.set_trace()
    return resp.json()

def json_array_max_date(data:list,col_name:str,
                        date_format:str="%Y-%m-%dT%H:%M:%S"):

    timestamps = [datetime.strptime(d[col_name],date_format)
                         for d in data if col_name in d]
    return str(max(timestamps))


def insert_data(api:HttpUrl,data,retries:int =5,*kwargs) -> requests.Response:
    # Remove last backspace
    if api[-1] == '/':
        api = api[:-1]
    
    resp = request_by_retries(requests.post,retries,
                                req_args={'url':api,'data':data},*kwargs)

    return resp
    


if __name__ == "__main__":

    api_url     = os.environ['API_URL']
    wait_time   = os.environ['WAIT_TIME']
    output_url  = os.environ['OUTPUT_URL']
    date_column = os.environ['DATE_COLUMN']
    date_query  = os.environ['DATE_QUERY']
    
    query =  ( date_query + 
                    datetime.now().strftime("%Y-%m-%dT%H:%M:%S"))

    if 'DATE' in os.environ:
        query = date_query + os.environ['DATE']

    while True:
        # Pull json data
        rsp = pull_api(api=api_url,
                            querystring=query,wait=wait_time)
        
        # Send data to queue api
        rsp = insert_data(api=output_url,
                        data=rsp,wait=wait_time)
        
        query = date_query + json_array_max_date(rsp)

        time.sleep(wait_time)