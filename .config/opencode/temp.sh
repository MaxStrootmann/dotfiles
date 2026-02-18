curl -X POST \
  -H "Authorization: Bearer 6ccd5533-e12d-4a84-9312-298f13ed2754" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d '{
    "jsonrpc": "2.0",
    "id": 1,
    "method": "tools/call",
    "params": {
      "name": "posts_list",
      "arguments": {
        "where": { "status": { "equals": "published" } },
        "limit": 5
      }
    }
  }' \
  http://localhost:3000/api/mcp

