package com.example.taskapi.task_api;

import com.example.taskapi.task_api.model.Task;
import com.example.taskapi.task_api.model.TaskExecution;
import com.example.taskapi.task_api.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/tasks")
public class TaskController {

    @Autowired
    private TaskRepository taskRepository;

    // GET all tasks or by id or by name
    @GetMapping
    public ResponseEntity<List<Task>> getTasks(
            @RequestParam(required = false) String id,
            @RequestParam(required = false) String name
    ) {
        if (id != null) {
            Optional<Task> taskOpt = taskRepository.findById(id);
            return taskOpt.map(task -> ResponseEntity.ok(List.of(task)))
                          .orElseGet(() -> ResponseEntity.notFound().build());
        }

        if (name != null) {
            List<Task> tasks = taskRepository.findByNameContainingIgnoreCase(name);
            if (tasks.isEmpty()) return ResponseEntity.notFound().build();
            return ResponseEntity.ok(tasks);
        }

        List<Task> allTasks = taskRepository.findAll();
        return ResponseEntity.ok(allTasks);
    }

    // PUT: create or update a task
    @PutMapping
    public ResponseEntity<Task> createOrUpdateTask(@RequestBody Task task) {
        if (task == null) return ResponseEntity.badRequest().build();
        Task savedTask = taskRepository.save(task);
        return ResponseEntity.ok(savedTask);
    }

    // DELETE a task by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTask(@PathVariable String id) {
        if (!taskRepository.existsById(id)) return ResponseEntity.notFound().build();
        taskRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }

    // PUT: Add TaskExecution to an existing task
    @PutMapping("/{id}/execute")
    public ResponseEntity<Task> addTaskExecution(@PathVariable String id,
                                                 @RequestBody TaskExecution execution) {
        Optional<Task> taskOpt = taskRepository.findById(id);
        if (taskOpt.isEmpty()) return ResponseEntity.notFound().build();

        Task task = taskOpt.get();
        if (task.getTaskExecutions() == null) task.setTaskExecutions(List.of());
        task.getTaskExecutions().add(execution);
        Task savedTask = taskRepository.save(task);

        return ResponseEntity.ok(savedTask);
    }
}
