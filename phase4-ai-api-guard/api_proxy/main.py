# minimal FastAPI proxy stub
from fastapi import FastAPI, Request
app = FastAPI()

@app.post('/v1/chat')
async def guard(req: Request):
    body = await req.json()
    # TODO: evaluate via OPA/Rego before forwarding to LLM API
    return {"status": "checked", "input": body}
