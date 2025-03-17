import requests

class JSONPlaceholderAPI:
    BASE_URL = "https://jsonplaceholder.typicode.com"

    def create_post(self, title, body, user_id):
        url = f"{self.BASE_URL}/posts"
        payload = {"title": title, "body": body, "userId": user_id}
        response = requests.post(url, json=payload)
        return response
