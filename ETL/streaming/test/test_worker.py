from requests.models import HTTPError
import requests_mock
import pytest
import json
from ETL.streaming.pull_worker import pull_api,insert_data,json_array_max_date
class TestWorkerFunctions:
    
    
    def test_pull_api(self):
        api  = 'http://test.api'
        date = "date>2015-01-01"
        url = '%s/%s'%(api,date)
        
        #Mock GET
        exp_data = [{'data':'requests','time':'2021-01-1'},{'data':'requests','time':'2021-01-1'}]
        with requests_mock.Mocker() as m:
            m.get(url,json=exp_data)
            data = pull_api(querystring=date,api=api)
        
        assert data == exp_data
        
    def test_insert_data(self):
        url  = 'http://test.api'
        tst  = [{'data':'requests','time':'2021-01-1'}]

        #Mock POST
        with requests_mock.Mocker() as m:
            m.post(url,json=tst)
            resp = insert_data(api=url,data=tst)

        assert resp.status_code == 200

    def test_json_max_date(self):
        data = [{'timestamp':'2021-01-01'},
                {'timestamp':'2021-01-03'},
                {'timestamp':'2021-03-03'}]

        col  = 'timestamp'
        assert json_array_max_date(data=data,
                                   col_name = col,
                                   date_format='%Y-%m-%d') == '2021-03-03 00:00:00'

class TestWorkerErrors:
    
    def test_error_insert(self):
        url  = 'http://test.api'
        tst  = {'data':'requests','time':'2021-01-1'}

        with requests_mock.Mocker() as m:
            m.post(url,json=tst,status_code=404)
            with pytest.raises(Exception) as e:                
                resp = insert_data(api=url,data=tst,retries=5,wait=0)
                assert str(e.value) == "Unable to respond data with 404"

    def test_date_wrong_format(self):
        data = [{'timestamp':'2021-01-01'},
                {'timestamp':'2021-01-03'},
                {'timestamp':'xxxx'}]

        col  = 'timestamp'
        with pytest.raises(Exception) as e:
            json_array_max_date(data=data,
                                   col_name = col)
            assert str(e.value) == 'Incorrect timestamp on column %s'%col
        

    def test_pull_error(self):
        api  = 'http://test.api'
        date = "date>2015-01-01"
        url = ('%s/%s',api,date)

        exp_data  = {'data':'requests','time':'2021-01-1'}

        with requests_mock.Mocker() as m:
            m.get(url,json=exp_data)
            with pytest.raises(Exception) as e:                
                data = pull_api(date_query=date,api=api,retries=5,wait=0)
                assert str(e.value) == "Unable to pull data with 404"