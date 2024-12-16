package com.evenetmangement;

import com.eventmanagement.domain.User;
import com.eventmanagement.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:application-service.xml", "classpath:application-dao.xml"})
public class UserLoginTest {
    @Autowired
    private UserService userService;
    @Test
    public void login(){
        User adminUser = new User();
        adminUser.setName("superadmin");
        adminUser.setPassword("123456");
        User user = userService.login(adminUser);
    }
}