package com.eventmanagement.dao;

import com.eventmanagement.domain.User;
import com.github.pagehelper.Page;

public interface UserMapper {
    public User login(User user);

    void updateUserInfo(User user);

    Page<User> search(User user);

    Integer addUser(User user);

    User findUserByUserId(String userId);

    Integer updateUser(User user);

    void delUser(String userId);
}
