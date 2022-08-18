package com.techelevator.controller;

import com.techelevator.dao.ProfileDao;
import com.techelevator.dao.UserDao;
import com.techelevator.model.Friend;
import com.techelevator.model.Profile;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@CrossOrigin
@RestController
public class ProfileController {

    private final ProfileDao profileDao;
    private final UserDao userDao;

    public ProfileController(ProfileDao profileDao, UserDao userDao){
        this.profileDao = profileDao;
        this.userDao = userDao;
    }

    @RequestMapping (path = "/profiles", method = RequestMethod.GET)
    public List<Profile> getProfiles(){
        return profileDao.getProfiles();
    }

    @RequestMapping (path = "/profile", method = RequestMethod.GET)
    public Profile getProfileByUserId(Principal principal){
        int userId = userDao.findIdByUsername(principal.getName());
        return profileDao.getProfileByUserId(userId);
    }

    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path = "/profiles", method = RequestMethod.POST)
    public void createProfile(Principal principal){
        int userId = userDao.findIdByUsername(principal.getName());
        profileDao.addProfile(userId);
    }

    @RequestMapping(path = "/profiles", method = RequestMethod.PUT)
    public void updateProfile(Principal principal, @RequestBody Profile profile){
        int userId = userDao.findIdByUsername(principal.getName());
        profile.setUserId(userId);
        profileDao.updateProfile(profile);
    }
    @ResponseStatus(HttpStatus.CREATED)
    @RequestMapping(path = "/friends", method = RequestMethod.POST)
    public void addFriends(Principal principal, @RequestBody Friend friend){
        userDao.addFriends(principal.getName(), friend.getFriendUserId());
    }

    @RequestMapping(path="/friends", method = RequestMethod.GET)
    public List<Profile> getFriendsProfile(Principal principal) {
        return profileDao.getFriendsProfile(principal.getName());
    }

    @RequestMapping (path = "/profile/{id}", method = RequestMethod.GET)
    public Profile getFriendsProfileById(@PathVariable("id") int friendId){
        return profileDao.getFriendsProfileById(friendId);
    }
}
