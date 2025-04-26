package com.WeddingPlanner.services;

import com.WeddingPlanner.model.User;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import javax.servlet.ServletContext;
import java.io.*;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

public class UserAuthService {
    private static final String USERS_FILE = "WEB-INF/data/users.json";
    private final Gson gson = new Gson();

    public User authenticateUser(String username, String password, ServletContext context) throws IOException {
        List<User> users = loadUsers(context);
        
        for (User user : users) {
            if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
                // Update last login time
                user.setLastLogin("2025-04-26 20:38:12");
                saveUsers(users, context);
                return user;
            }
        }
        
        return null;
    }

    private List<User> loadUsers(ServletContext context) throws IOException {
        String fullPath = context.getRealPath(USERS_FILE);
        File file = new File(fullPath);
        
        if (!file.exists()) {
            return new ArrayList<>();
        }

        try (Reader reader = new FileReader(file)) {
            Type userListType = new TypeToken<List<User>>(){}.getType();
            List<User> users = gson.fromJson(reader, userListType);
            return users != null ? users : new ArrayList<>();
        }
    }

    private void saveUsers(List<User> users, ServletContext context) throws IOException {
        String fullPath = context.getRealPath(USERS_FILE);
        File file = new File(fullPath);
        file.getParentFile().mkdirs();

        try (Writer writer = new FileWriter(file)) {
            gson.toJson(users, writer);
        }
    }

    public boolean registerUser(User newUser, ServletContext context) throws IOException {
        List<User> users = loadUsers(context);
        
        // Check for existing username or email
        for (User user : users) {
            if (user.getUsername().equals(newUser.getUsername()) || 
                user.getEmail().equals(newUser.getEmail())) {
                return false;
            }
        }
        
        users.add(newUser);
        saveUsers(users, context);
        return true;
    }
}