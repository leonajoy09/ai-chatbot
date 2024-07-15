import httpx
import certifi

# HTTPX Client with increased timeout and SSL verification
client = httpx.Client(timeout=httpx.Timeout(60.0), verify=certifi.where())