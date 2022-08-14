package com.techelevator.dao;

import com.techelevator.model.Profile;

import java.util.List;

public interface ProfileDao {
    Profile getProfileByUserId(String userId);
    List<Profile> getProfiles();
    void addProfile();
    void updateProfile();
    void deleteProfile();
}
