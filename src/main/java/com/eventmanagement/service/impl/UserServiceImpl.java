package com.eventmanagement.service.impl;

import com.eventmanagement.dao.UserMapper;
import com.eventmanagement.domain.User;
import com.eventmanagement.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(User user) {
        return userMapper.login(user);
    }

    public void updateUserInfo(User user) {
        userMapper.updateUserInfo(user);
    }
}
