import requests

class ReqResAPI:
    BASE_URL = "https://reqres.in/api"

    def create_user(self, name, job):
        url = f"{self.BASE_URL}/users"
        payload = {"name": name, "job": job}
        response = requests.post(url, json=payload)
        return response
