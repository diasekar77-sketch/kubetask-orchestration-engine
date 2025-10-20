package com.example.taskapi.task_api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String home() {
        return "Spring Boot is running!";
    }

    @GetMapping("/test")
    public String test() {
        return "Test endpoint working!";
    }
}
