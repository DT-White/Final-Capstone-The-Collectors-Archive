package com.techelevator.dao;

import com.techelevator.model.User;

import java.time.LocalDateTime;
import java.util.List;

public interface UserDao {

    List<User> findAll();

    User getUserById(Long userId);

    User findByUsername(String username);

    int findIdByUsername(String username);

    boolean create(String username, String password, String role);

    void addFriends (String username, int friendUserId);

    //void addTimeAccessed(String username);

    //void updateTimeAccessed(String username);

    List<Integer> getFriendsUserIds (String username);


}
