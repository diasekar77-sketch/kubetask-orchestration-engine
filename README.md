# Task API - Java Spring Boot REST API

## Overview
This is a Java Spring Boot application that provides a REST API for managing and executing shell command tasks. The application stores task data in MongoDB and includes security validation to prevent execution of dangerous commands.

## Features
- **Task Management**: Create, read, update, and delete tasks
- **Command Execution**: Execute shell commands safely with output capture
- **Search Functionality**: Find tasks by name
- **Security**: Command validation to prevent malicious operations
- **MongoDB Integration**: Persistent storage with task execution history

## API Endpoints

### 1. Get All Tasks
```bash
GET /tasks
```
Returns all tasks in the database.

### 2. Get Task by ID
```bash
GET /tasks?id={taskId}
```
Returns a specific task by its ID.

### 3. Create/Update Task
```bash
PUT /tasks
Content-Type: application/json

{
  "id": "123",
  "name": "Print Hello",
  "owner": "John Smith",
  "command": "echo Hello World!"
}
```

### 4. Search Tasks by Name
```bash
GET /tasks/search?name={searchTerm}
```
Returns tasks whose names contain the search term.

### 5. Delete Task
```bash
DELETE /tasks?id={taskId}
```
Deletes a task by its ID.

### 6. Execute Task
```bash
PUT /tasks/{taskId}/execute
```
Executes the command associated with the task and stores the execution details.

## Data Models

### Task Object
```json
{
  "id": "123",
  "name": "Print Hello",
  "owner": "John Smith",
  "command": "echo Hello World!",
  "taskExecutions": [
    {
      "startTime": "2023-04-21T15:51:42.276Z",
      "endTime": "2023-04-21T15:51:43.276Z",
      "output": "Hello World!"
    }
  ]
}
```

### TaskExecution Object
```json
{
  "startTime": "2023-04-21T15:51:42.276Z",
  "endTime": "2023-04-21T15:51:43.276Z",
  "output": "Hello World!"
}
```

## Security Features
The application includes command validation to prevent execution of dangerous operations:
- Blocks commands like `rm -rf`, `del /`, `format`, `shutdown`, etc.
- Only allows safe commands like `echo`, `ls`, `cat`, `grep`, `head`, `tail`, `wc`, `sort`, `uniq`, `date`, `whoami`, `pwd`
- Validates commands before both task creation and execution

## Prerequisites
- Java 8 or higher
- Maven 3.6 or higher
- MongoDB 4.0 or higher

## Installation and Setup

### 1. Install MongoDB
```bash
# Using Homebrew (macOS)
brew tap mongodb/brew
brew install mongodb-community
brew services start mongodb/brew/mongodb-community
```

### 2. Clone and Build
```bash
git clone <repository-url>
cd task-api
mvn clean compile
```

### 3. Run the Application
```bash
mvn spring-boot:run
```

The application will start on port 8081.

## Testing the API

### 1. Create a Task
```bash
curl -X PUT http://localhost:8081/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "id": "123",
    "name": "Print Hello",
    "owner": "John Smith",
    "command": "echo Hello World!"
  }'
```

### 2. Get All Tasks
```bash
curl -X GET http://localhost:8081/tasks
```

### 3. Execute a Task
```bash
curl -X PUT http://localhost:8081/tasks/123/execute
```

### 4. Search Tasks
```bash
curl -X GET "http://localhost:8081/tasks/search?name=Hello"
```

### 5. Delete a Task
```bash
curl -X DELETE "http://localhost:8081/tasks?id=123"
```

## Screenshots

### Application Startup
![Application Startup](screenshots/startup.png)
*Application successfully started on port 8081*

### Task Creation
![Task Creation](screenshots/create_task.png)
*Creating a new task with curl command*

### Task Execution
![Task Execution](screenshots/execute_task.png)
*Executing a task and capturing output*

### Security Validation
![Security Validation](screenshots/security_validation.png)
*Blocking dangerous commands for security*

### Task Search
![Task Search](screenshots/search_tasks.png)
*Searching tasks by name*

## Project Structure
```
src/
├── main/
│   ├── java/com/example/taskapi/task_api/
│   │   ├── controller/
│   │   │   ├── HelloController.java
│   │   │   └── TaskController.java
│   │   ├── model/
│   │   │   ├── Task.java
│   │   │   └── TaskExecution.java
│   │   ├── repository/
│   │   │   └── TaskRepository.java
│   │   └── TaskApiApplication.java
│   └── resources/
│       └── application.properties
└── test/
    └── java/com/example/taskapi/task_api/
        └── SpringBootTest.java
```




