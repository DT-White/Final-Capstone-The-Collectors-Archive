package com.techelevator.dao;

import com.techelevator.model.Profile;

import java.util.List;

public interface ProfileDao {
    Profile getProfileByUserId(int userId);
    List<Profile> getProfiles();
    void addProfile(int userId);
    void updateProfile(Profile profile);
    List<Profile> getFriendsProfile(String username);
    Profile getFriendsProfileById(int friendId);
}
