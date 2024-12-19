package com.eventmanagement.controller;

import com.eventmanagement.domain.User;
import com.eventmanagement.entity.PageResult;
import com.eventmanagement.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/login")
    public String login(User user, HttpServletRequest request) {
        try {
            User u = userService.login(user);
            /*
            用户账号和密码是否查询出用户信息
                是：将用户信息存入Session，并跳转到后台首页
                否：Request域中添加提示信息，并转发到登录页面
             */
            if (u != null) {
                request.getSession().setAttribute("USER_SESSION", u);
                String role = u.getRole();
                System.out.println(role);
                if ("Admin".equals(role)) {
                    return "redirect:/admin/admin.jsp";
                } else {
                    return "redirect:/admin/participant.jsp";
                }

            }
            request.setAttribute("msg", "用户名或密码错误");
            return "forward:/admin/login.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "系统错误");
            return "forward:/admin/login.jsp";
        }
    }

    /*
    注销登录
     */
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        try {
            HttpSession session = request.getSession();
            //销毁Session
            session.invalidate();
            return "forward:/admin/login.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "系统错误");
            return "forward:/admin/login.jsp";
        }
    }

    @RequestMapping("/info")
    public ModelAndView info(User user) {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("user", user);
        modelAndView.setViewName("forward:/admin/info.jsp");
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/updateUserInfo")
    public ResponseEntity<Map<String, Object>> updateUserInfo(User user) {
        Map<String, Object> response = new HashMap<>();
        try{
            userService.updateUserInfo(user);

            response.put("status", "success");
            return new ResponseEntity<>(response, HttpStatus.OK);
        }catch (Exception e) {
            response.put("status", "error");
            response.put("msg", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    
    @RequestMapping("/search")
    public ModelAndView search(User user, Integer pageNum, Integer pageSize, HttpServletRequest request) {
        if (pageNum == null) {
            pageNum = 1;
        }
        if (pageSize == null) {
            pageSize = 10;
        }
        //查询到的图书信息
        PageResult pageResult = userService.search(user, pageNum, pageSize);
        ModelAndView modelAndView = new ModelAndView();
        String contextPath = request.getContextPath();
        modelAndView.setViewName(contextPath + "/admin/account.jsp");
        //将查询到的数据存放在 ModelAndView的对象中
        modelAndView.addObject("pageResult", pageResult);
        System.out.println(pageResult.getRows());
        //将查询的参数返回到页面，用于回显到查询的输入框中
        modelAndView.addObject("search", user);
        //将当前页码返回到页面，用于分页插件的分页显示
        modelAndView.addObject("pageNum", pageNum);
        //将当前查询的控制器路径返回到页面，页码变化时继续向该路径发送请求
        modelAndView.addObject("gourl", request.getRequestURI());
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping(value = "/addUser", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> addUser(String name, String email, String password, String role) {
        Map<String, Object> response = new HashMap<>();
        try {
            User user = new User();

            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            userService.addUser(user);
            response.put("success", true);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            response.put("errorMsg", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ResponseBody
    @RequestMapping("/finduserbyuserid")
    public ResponseEntity<Map<String, Object>> finduserbyuserid(String userId) {
        Map<String, Object> response = new HashMap<>();
        try {
            User user = userService.findUserByUserId(userId);

            response.put("success", true);
            response.put("user", user);
            return new ResponseEntity<>(response, HttpStatus.OK);
        }catch (Exception e) {
            response.put("errorMsg", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ResponseBody
    @RequestMapping("/updateuser")
    public ResponseEntity<Map<String, Object>> updateUser(User user) {
        Map<String, Object> response = new HashMap<>();
        try {
            userService.updateUser(user);

            response.put("success", true);
            response.put("user", user);
            return new ResponseEntity<>(response, HttpStatus.OK);
        }catch (Exception e) {
            response.put("errorMsg", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ResponseBody
    @RequestMapping("/deluser")
    public ResponseEntity<Map<String, Object>> delEvnent(String userId) {
        Map<String, Object> response = new HashMap<>();
        try {
            userService.delUser(userId);

            response.put("success", true);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            response.put("errorMsg", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
