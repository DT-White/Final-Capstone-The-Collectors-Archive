package com.techelevator.dao;

import com.techelevator.model.Profile;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

public class JdbcProfileDao implements ProfileDao{

    private final JdbcTemplate jdbcTemplate;

    public JdbcProfileDao(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Profile getProfileByUserId(String userId) {
        Profile profile = new Profile();
//        String sql =
                return null;
    }

    @Override
    public List<Profile> getProfiles() {
        return null;
    }

    @Override
    public void addProfile() {

    }

    @Override
    public void updateProfile() {

    }

    @Override
    public void deleteProfile() {

    }
}
