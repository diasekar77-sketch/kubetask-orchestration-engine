# Task 1: Java Backend and REST API

**Analyst:** Divya K S  
**Email:** divya.sekar4428@gmail.com  
**Date:** 2025-10-20

## Overview
This is a Spring Boot REST API application for managing tasks that can be executed in Kubernetes pods. The application provides endpoints for CRUD operations on task objects and execution of shell commands.

## Features
- **Task Management**: Create, read, update, and delete tasks
- **Task Execution**: Execute shell commands in Kubernetes pods
- **MongoDB Integration**: Persistent storage for tasks and executions
- **Input Validation**: Command validation to prevent malicious code execution
- **RESTful API**: Clean REST endpoints with proper HTTP status codes

## API Endpoints

### GET /api/tasks
- **Description**: Retrieve all tasks or a specific task by ID
- **Parameters**: 
  - `id` (optional): Task ID to retrieve a specific task
- **Response**: List of tasks or single task object

### PUT /api/tasks
- **Description**: Create or update a task
- **Request Body**: Task object (JSON)
- **Validation**: Command must not contain unsafe characters

### DELETE /api/tasks/{id}
- **Description**: Delete a task by ID
- **Parameters**: `id` - Task ID to delete

### GET /api/tasks/search?name={name}
- **Description**: Search tasks by name (case-insensitive)
- **Parameters**: `name` - Search string
- **Response**: List of matching tasks or 404 if none found

### PUT /api/tasks/{id}/execute
- **Description**: Execute a task command in a Kubernetes pod
- **Parameters**: `id` - Task ID to execute
- **Response**: TaskExecution object with execution details

## Data Models

### Task
```json
{
  "id": "123",
  "name": "Print Hello",
  "owner": "John Smith",
  "command": "echo Hello World!",
  "taskExecutions": []
}
```

### TaskExecution
```json
{
  "startTime": "2023-04-21 15:51:42.276Z",
  "endTime": "2023-04-21 15:51:43.276Z",
  "output": "Hello World!"
}
```

## Prerequisites
- Java 17 or higher
- Maven 3.6 or higher
- MongoDB 4.4 or higher
- Kubernetes cluster (for task execution)

## Installation and Setup

### 1. Clone the Repository
```bash
git clone <repository-url>
cd task1-java-backend
```

### 2. Install Dependencies
```bash
mvn clean install
```

### 3. Configure MongoDB
Update `src/main/resources/application.properties` with your MongoDB connection details:
```properties
spring.data.mongodb.host=localhost
spring.data.mongodb.port=27017
spring.data.mongodb.database=taskmanagement
```

### 4. Run the Application
```bash
mvn spring-boot:run
```

The application will start on `http://localhost:8080`

## Testing the API

### Using cURL

#### Create a Task
```bash
curl -X PUT http://localhost:8080/api/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "id": "123",
    "name": "Print Hello",
    "owner": "John Smith",
    "command": "echo Hello World!"
  }'
```

#### Get All Tasks
```bash
curl http://localhost:8080/api/tasks
```

#### Execute a Task
```bash
curl -X PUT http://localhost:8080/api/tasks/123/execute
```

#### Search Tasks
```bash
curl "http://localhost:8080/api/tasks/search?name=Hello"
```

### Using Postman
Import the following collection or create requests manually:

1. **Create Task** (PUT)
   - URL: `http://localhost:8080/api/tasks`
   - Body: JSON with task details

2. **Get All Tasks** (GET)
   - URL: `http://localhost:8080/api/tasks`

3. **Get Task by ID** (GET)
   - URL: `http://localhost:8080/api/tasks/{id}`

4. **Execute Task** (PUT)
   - URL: `http://localhost:8080/api/tasks/{id}/execute`

5. **Search Tasks** (GET)
   - URL: `http://localhost:8080/api/tasks/search?name={searchTerm}`

6. **Delete Task** (DELETE)
   - URL: `http://localhost:8080/api/tasks/{id}`

## Screenshots

### API Testing with Postman
![Postman API Testing](screenshots/postman-testing.png)
*Testing the API endpoints using Postman with current date/time and candidate name visible*

### Task Creation
![Task Creation](screenshots/task-creation.png)
*Creating a new task with validation showing successful API response*

### Task Execution
![Task Execution](screenshots/task-execution.png)
*Executing a task and viewing the output with execution history*

### MongoDB Data
![MongoDB Data](screenshots/mongodb-data.png)
*Viewing stored data in MongoDB with persistent storage*

### Application Logs
![Application Logs](screenshots/application-logs.png)
*Spring Boot application running with startup logs and API request logs*

## Security Features
- **Command Validation**: Only allows safe characters in commands (alphanumeric, spaces, hyphens, underscores, dots, slashes)
- **Input Sanitization**: Prevents injection of malicious shell commands
- **MongoDB Security**: Uses parameterized queries to prevent NoSQL injection

## Error Handling
- **404 Not Found**: When task ID doesn't exist
- **400 Bad Request**: When validation fails
- **500 Internal Server Error**: When execution fails

## Performance Considerations
- **Connection Pooling**: MongoDB connection pooling for better performance
- **Async Processing**: Task execution is handled asynchronously
- **Resource Management**: Proper cleanup of Kubernetes resources

## Monitoring and Logging
- **Application Logs**: Detailed logging for debugging
- **Execution Tracking**: Complete audit trail of task executions
- **Performance Metrics**: Execution time tracking

## Troubleshooting

### Common Issues
1. **MongoDB Connection Failed**
   - Ensure MongoDB is running
   - Check connection string in application.properties

2. **Kubernetes Execution Failed**
   - Ensure Kubernetes cluster is accessible
   - Check RBAC permissions for pod creation

3. **Command Validation Failed**
   - Ensure command contains only allowed characters
   - Check for special characters that might be blocked

### Logs
Check application logs for detailed error information:
```bash
tail -f logs/application.log
```

## Future Enhancements
- **Authentication**: JWT-based authentication
- **Authorization**: Role-based access control
- **Rate Limiting**: API rate limiting
- **Monitoring**: Prometheus metrics integration
- **Caching**: Redis caching for better performance

