package com.WeddingPlanner.services;

import com.WeddingPlanner.model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;
import javax.servlet.ServletContext;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;

public class UserAuthService {
    private static final String DATA_DIR = "F:\\project\\WeddingPlanner\\src\\main\\webapp\\WEB-INF\\lib";
    private static final String USERS_FILE = "\\users.json";
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    public User authenticateUser(String username, String password, ServletContext context) throws IOException {
        System.out.println("Attempting to authenticate user: " + username); // Debug log
        
        File usersFile = getUsersFile(context);
        if (!usersFile.exists()) {
            System.out.println("Users file not found at: " + usersFile.getAbsolutePath());
            return null;
        }

        try {
            String jsonContent = new String(Files.readAllBytes(usersFile.toPath()));
            System.out.println("Read JSON content: " + jsonContent); // Debug log

            JsonObject rootObject = gson.fromJson(jsonContent, JsonObject.class);
            JsonArray users = rootObject.getAsJsonArray("users");

            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                if (userJson.get("username").getAsString().equals(username) && 
                    userJson.get("password").getAsString().equals(password)) {
                    
                    User user = gson.fromJson(userJson, User.class);
                    user.setLastLogin("2025-04-26 21:27:52");
                    updateUserLastLogin(user, usersFile);
                    return user;
                }
            }
        } catch (Exception e) {
            System.err.println("Error reading users file: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    private File getUsersFile(ServletContext context) {
        String webInfPath = context.getRealPath(DATA_DIR);
        if (webInfPath == null) {
            // Try alternative path resolution
            String contextPath = context.getRealPath("/");
            webInfPath = Paths.get(contextPath, "WEB-INF", "data").toString();
        }
        
        File dataDir = new File(webInfPath);
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }
        
        return new File(dataDir, USERS_FILE);
    }

    private void updateUserLastLogin(User user, File usersFile) throws IOException {
        try {
            String jsonContent = new String(Files.readAllBytes(usersFile.toPath()));
            JsonObject rootObject = gson.fromJson(jsonContent, JsonObject.class);
            JsonArray users = rootObject.getAsJsonArray("users");

            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                if (userJson.get("username").getAsString().equals(user.getUsername())) {
                    userJson.addProperty("lastLogin", "2025-04-26 21:27:52");
                    break;
                }
            }

            rootObject.addProperty("lastUpdated", "2025-04-26 21:27:52");
            
            try (Writer writer = new FileWriter(usersFile)) {
                gson.toJson(rootObject, writer);
            }
        } catch (Exception e) {
            System.err.println("Error updating last login: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public boolean registerUser(User newUser, ServletContext context) throws IOException {
        File usersFile = getUsersFile(context);
        if (!usersFile.exists()) {
            // Initialize with empty users array
            JsonObject rootObject = new JsonObject();
            rootObject.add("users", new JsonArray());
            rootObject.addProperty("lastUpdated", "2025-04-26 21:27:52");
            try (Writer writer = new FileWriter(usersFile)) {
                gson.toJson(rootObject, writer);
            }
        }

        try {
            String jsonContent = new String(Files.readAllBytes(usersFile.toPath()));
            JsonObject rootObject = gson.fromJson(jsonContent, JsonObject.class);
            JsonArray users = rootObject.getAsJsonArray("users");

            // Check for existing username
            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                if (userJson.get("username").getAsString().equals(newUser.getUsername())) {
                    return false;
                }
            }

            // Add new user
            users.add(gson.toJsonTree(newUser));
            rootObject.addProperty("lastUpdated", "2025-04-26 21:27:52");

            try (Writer writer = new FileWriter(usersFile)) {
                gson.toJson(rootObject, writer);
                return true;
            }
        } catch (Exception e) {
            System.err.println("Error registering user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}