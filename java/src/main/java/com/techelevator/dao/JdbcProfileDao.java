package com.techelevator.dao;

import com.techelevator.model.Profile;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcProfileDao implements ProfileDao{

    private final JdbcTemplate jdbcTemplate;

    public JdbcProfileDao(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Profile getProfileByUserId(int userId) {
        Profile profile = null;
        String sql = "select profile_id, first_name, last_name, email, profile_picture_url, user_id " +
                "from profiles where user_id = ?";
        SqlRowSet sqlRowSet = jdbcTemplate.queryForRowSet(sql, userId);
        if (sqlRowSet.next()){
            profile = mapRowToProfile(sqlRowSet);
        }
        return profile;
    }

    @Override
    public List<Profile> getProfiles() {
        List<Profile> profiles = new ArrayList<>();
        String sql = "select profile_id, first_name, last_name, email, profile_picture_url, user_id " +
                "from profiles";
        SqlRowSet sqlRowSet = jdbcTemplate.queryForRowSet(sql);
        while (sqlRowSet.next()){
            profiles.add(mapRowToProfile(sqlRowSet));
        }
        return profiles;
    }

    @Override
    public void addProfile(int userId) {
<<<<<<< HEAD
        String sql = "insert into profiles (user_id) " +
                "values(?)";
        jdbcTemplate.update(sql, userId);
=======
      try {
          String sql = "insert into profiles (user_id) " +
                  "values(?)";
          jdbcTemplate.update(sql, userId);
      } catch (Exception ignore) {}

>>>>>>> ff1888b87dfefc110e373ca607ed32dbff92cd12
    }

    @Override
    public void updateProfile(Profile profile) {
        String sql = "update profiles " +
                "set first_name = ?, last_name = ?, email = ?, profile_picture_url = ? " +
                "where user_id = ?";
        jdbcTemplate.update(sql, profile.getFirstName(), profile.getLastName(), profile.getEmail(),
                profile.getProfilePictureUrl(), profile.getUserId());
    }

    private Profile mapRowToProfile(SqlRowSet sqlRowSet){
        Profile profile = new Profile();
        profile.setProfileId(sqlRowSet.getInt("profile_id"));
        profile.setFirstName(sqlRowSet.getString("first_name"));
        profile.setLastName(sqlRowSet.getString("last_name"));
        profile.setUserId(sqlRowSet.getInt("user_id"));
        profile.setEmail(sqlRowSet.getString("email"));
        profile.setProfilePictureUrl(sqlRowSet.getString("profile_picture_url"));
        return profile;
    }
}
