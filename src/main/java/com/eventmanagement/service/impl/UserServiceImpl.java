package com.eventmanagement.service.impl;

import com.eventmanagement.dao.UserMapper;
import com.eventmanagement.domain.User;
import com.eventmanagement.entity.PageResult;
import com.eventmanagement.service.UserService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

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

    @Override
    public PageResult search(User user, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        Page<User> page = userMapper.search(user);
        return new PageResult(page.getTotal(), page.getResult());
    }

    public Integer addUser(User user) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        user.setUpdatedAt(Timestamp.valueOf(dateFormat.format(new Date())));
        user.setCreatedAt(Timestamp.valueOf(dateFormat.format(new Date())));
        return userMapper.addUser(user);
    }

    public User findUserByUserId(String userId) {
        return userMapper.findUserByUserId(userId);
    }

    public Integer updateUser(User user) {
        return userMapper.updateUser(user);
    }

    public void delUser(String userId) {
        userMapper.delUser(userId);
    }
}
