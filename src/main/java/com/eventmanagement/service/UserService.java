package com.eventmanagement.service;

import com.eventmanagement.domain.Event;
import com.eventmanagement.domain.User;
import com.eventmanagement.entity.PageResult;

public interface UserService {
    User login(User user);

    void updateUserInfo(User user);

    PageResult search(User user, Integer pageNum, Integer pageSize);

    Integer addUser(User user);

    User findUserByUserId(String userId);

    Integer updateUser(User user);

    void delUser(String userId);
}
