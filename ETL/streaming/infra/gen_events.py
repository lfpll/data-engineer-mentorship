from fake_web_events import Simulation
import requests 
from itertools import chain,islice
import os


simulation = Simulation(user_pool_size=100, sessions_per_day=1000)
events = simulation.run(duration_seconds=300)

API = os.environ['API']

i = 0
tmp = []
for event in events:
    i += 1
    tmp.append(event)

    if i%100 == 0:
        resp = requests.post(API,json=tmp)
        print(resp.status_code)
        print(resp.text)
        tmp = []

resp = requests.post(API,json=tmp)
print(resp.status_code)
print(resp.text)
    

