# Minimal Wiz API client stub
# Replace with real token/env handling and pagination
import os, requests
WIZ_API = os.getenv('WIZ_API','https://api.wiz.io/graphql')
WIZ_TOKEN = os.getenv('WIZ_TOKEN','')
def get_findings(query=''):
    return {'data': [], 'query_used': query}
