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
    private final UserDao userDao;

    public JdbcProfileDao(JdbcTemplate jdbcTemplate, UserDao userDao){
        this.jdbcTemplate = jdbcTemplate;
        this.userDao = userDao;
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

      try {
          String sql = "insert into profiles (user_id) " +
                  "values(?)";
          jdbcTemplate.update(sql, userId);
      } catch (Exception ignore) {}
    }

    @Override
    public void updateProfile(Profile profile) {
        String sql = "update profiles " +
                "set first_name = ?, last_name = ?, email = ?, profile_picture_url = ? " +
                "where user_id = ?";
        jdbcTemplate.update(sql, profile.getFirstName(), profile.getLastName(), profile.getEmail(),
                profile.getProfilePictureUrl(), profile.getUserId());
    }

    @Override
    public List<Profile> getFriendsProfile(String username) {
        List<Profile> friendsProfiles = new ArrayList<>();
        List<Integer> friendsIds = userDao.getFriendsUserIds(username);

        for(int friendId : friendsIds) {
            String sql = "Select profile_id, first_name, last_name, profile_picture_url, email, user_id from profiles " +
                    "Where user_id = ?";
            SqlRowSet rowSet = jdbcTemplate.queryForRowSet(sql, friendId);
            while (rowSet.next()){
                friendsProfiles.add(mapRowToProfile(rowSet));
            }
        }
        return friendsProfiles;
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
