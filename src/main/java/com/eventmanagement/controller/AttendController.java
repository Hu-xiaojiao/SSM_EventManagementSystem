package com.eventmanagement.controller;

import com.eventmanagement.domain.Attend;
import com.eventmanagement.domain.User;
import com.eventmanagement.entity.PageResult;
import com.eventmanagement.service.AttendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/attend")
public class AttendController {
    @Autowired
    private AttendService attendService;

    @RequestMapping("/search")
    public ModelAndView search(Attend attend, Integer pageNum, Integer pageSize, HttpServletRequest request) {
        if (pageNum == null) {
            pageNum = 1;
        }
        if (pageSize == null) {
            pageSize = 10;
        }
        System.out.println(attend.getUserId());
        PageResult pageResult = attendService.search(attend, pageNum, pageSize);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("attends.jsp");
        //将查询到的数据存放在 ModelAndView的对象中
        modelAndView.addObject("pageResult", pageResult);
        //将查询的参数返回到页面，用于回显到查询的输入框中
        modelAndView.addObject("search", attend);
        //将当前页码返回到页面，用于分页插件的分页显示
        modelAndView.addObject("pageNum", pageNum);
        //将当前查询的控制器路径返回到页面，页码变化时继续向该路径发送请求
        modelAndView.addObject("gourl", request.getRequestURI());
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping(value = "/addattend", method = RequestMethod.POST)
    public ResponseEntity<Map<String, Object>> addAttend(String eventId, String userId) {
        Map<String, Object> response = new HashMap<>();
        try {
            attendService.addAttend(eventId, userId);

            response.put("success", true);
            return new ResponseEntity<>(response, HttpStatus.OK);
        }catch (DuplicateKeyException e) {
            // 处理重复键异常，例如记录日志或返回特定信息
            response.put("success", false);
            response.put("errorMsg", "您已报名该活动");
            return new ResponseEntity<>(response, HttpStatus.CONFLICT);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            response.put("errorMsg", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private String formatTimeStamp(String date) {
        // 检查输入长度是否为16
        if (date.length() == 16) {
            // 分离日期和时间部分
            String datePart = date.substring(0, 10);
            String timePart = date.substring(11, 16);

            // 将时间部分补全到完整格式
            String formattedTimePart = timePart + ":00";

            // 拼接成最终格式
            String formattedTimestamp = datePart + " " + formattedTimePart;
            return formattedTimestamp;
        } else {
            return "Invalid input format";
        }
    }

    @ResponseBody
    @RequestMapping("/findattendbyattendid")
    public ResponseEntity<Map<String, Object>> findAttendbyAttendid(String attendId) {
        Map<String, Object> response = new HashMap<>();
        try {
            Attend attend = attendService.findAttendByAttendId(attendId);

            response.put("success", true);
            response.put("Attend", attend);
            return new ResponseEntity<>(response, HttpStatus.OK);
        }catch (Exception e) {
            response.put("errorMsg", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @ResponseBody
    @RequestMapping("/updateattend")
    public ResponseEntity<Map<String, Object>> updateAttend(Attend Attend) {
        Map<String, Object> response = new HashMap<>();
        try {
            attendService.updateAttend(Attend);

            response.put("success", true);
            response.put("Attend", Attend);
            return new ResponseEntity<>(response, HttpStatus.OK);
        }catch (Exception e) {
            response.put("success", false);
            response.put("errorMsg", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping("/myattend")
    public ModelAndView myAttend(Integer pageNum, Integer pageSize,HttpServletRequest request) {
        if (pageNum == null) {
        pageNum = 1;
        }
        if (pageSize == null) {
            pageSize = 10;
        }

        User u = (User) request.getSession().getAttribute("USER_SESSION");
        System.out.println(u.getUserId());

        Attend attend = new Attend();
        attend.setUserId(u.getUserId());

        PageResult pageResult = attendService.search(attend, pageNum, pageSize);

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("myattend.jsp");
        //将查询到的数据存放在 ModelAndView的对象中
        modelAndView.addObject("pageResult", pageResult);
        //将查询的参数返回到页面，用于回显到查询的输入框中
        modelAndView.addObject("search", attend);
        //将当前页码返回到页面，用于分页插件的分页显示
        modelAndView.addObject("pageNum", pageNum);
        //将当前查询的控制器路径返回到页面，页码变化时继续向该路径发送请求
        modelAndView.addObject("gourl", request.getRequestURI());
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/delattend")
    public ResponseEntity<Map<String, Object>> delAttend(String attendId) {
        Map<String, Object> response = new HashMap<>();
        try {
            attendService.delAttend(attendId);

            response.put("success", true);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            response.put("errorMsg", e.getMessage());
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
