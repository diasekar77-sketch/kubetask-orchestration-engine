#!/bin/bash

echo "=== Task API Testing Script ==="
echo "Author: Vivek Kumar"
echo "Date: $(date)"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}1. Testing GET /tasks (should return empty array)${NC}"
curl -X GET http://localhost:8081/tasks
echo -e "\n"

echo -e "${BLUE}2. Creating a new task${NC}"
curl -X PUT http://localhost:8081/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "id": "123",
    "name": "Print Hello",
    "owner": "John Smith",
    "command": "echo Hello World!"
  }'
echo -e "\n"

echo -e "${BLUE}3. Creating another task${NC}"
curl -X PUT http://localhost:8081/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "id": "456",
    "name": "List Files",
    "owner": "Jane Doe",
    "command": "ls -la"
  }'
echo -e "\n"

echo -e "${BLUE}4. Getting all tasks${NC}"
curl -X GET http://localhost:8081/tasks
echo -e "\n"

echo -e "${BLUE}5. Getting specific task by ID${NC}"
curl -X GET "http://localhost:8081/tasks?id=123"
echo -e "\n"

echo -e "${BLUE}6. Searching tasks by name${NC}"
curl -X GET "http://localhost:8081/tasks/search?name=Hello"
echo -e "\n"

echo -e "${BLUE}7. Executing task 123${NC}"
curl -X PUT http://localhost:8081/tasks/123/execute
echo -e "\n"

echo -e "${BLUE}8. Executing task 456${NC}"
curl -X PUT http://localhost:8081/tasks/456/execute
echo -e "\n"

echo -e "${BLUE}9. Getting task 123 with execution history${NC}"
curl -X GET "http://localhost:8081/tasks?id=123"
echo -e "\n"

echo -e "${BLUE}10. Testing security validation (should fail)${NC}"
curl -X PUT http://localhost:8081/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "id": "999",
    "name": "Dangerous Task",
    "owner": "Test User",
    "command": "rm -rf /"
  }'
echo -e "\n"

echo -e "${BLUE}11. Testing another dangerous command${NC}"
curl -X PUT http://localhost:8081/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "id": "888",
    "name": "Another Dangerous Task",
    "owner": "Test User",
    "command": "sudo shutdown -h now"
  }'
echo -e "\n"

echo -e "${BLUE}12. Deleting task 123${NC}"
curl -X DELETE "http://localhost:8081/tasks?id=123"
echo -e "\n"

echo -e "${BLUE}13. Verifying task 123 is deleted${NC}"
curl -X GET "http://localhost:8081/tasks?id=123"
echo -e "\n"

echo -e "${BLUE}14. Final task list${NC}"
curl -X GET http://localhost:8081/tasks
echo -e "\n"

echo -e "${GREEN}=== Testing Complete ===${NC}"
