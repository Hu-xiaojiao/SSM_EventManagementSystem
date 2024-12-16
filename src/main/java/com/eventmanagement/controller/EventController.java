package com.eventmanagement.controller;

import com.eventmanagement.domain.Event;
import com.eventmanagement.domain.User;
import com.eventmanagement.entity.PageResult;
import com.eventmanagement.entity.Result;
import com.eventmanagement.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.time.temporal.ChronoField;
import java.util.Date;
import java.util.TimeZone;

@Controller
@RequestMapping("/event")
public class EventController {
    @Autowired
    private EventService eventService;

    @RequestMapping("/getNewEvents")
    public ModelAndView getNewEvents() {
        int pageNum = 1;
        int pageSize = 5;
        PageResult pageResult = eventService.getNewEvents(pageNum, pageSize);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("events_new.jsp");
        modelAndView.addObject("pageResult", pageResult);
        return modelAndView;
    }

    @RequestMapping("/search")
    public ModelAndView search(Event event, Integer pageNum, Integer pageSize, HttpServletRequest request) {
        if (pageNum == null) {
            pageNum = 1;
        }
        if (pageSize == null) {
            pageSize = 10;
        }
        //查询到的图书信息
        PageResult pageResult = eventService.search(event, pageNum, pageSize);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("events.jsp");
        //将查询到的数据存放在 ModelAndView的对象中
        modelAndView.addObject("pageResult", pageResult);
        System.out.println(pageResult.getRows());
        //将查询的参数返回到页面，用于回显到查询的输入框中
        modelAndView.addObject("search", event);
        //将当前页码返回到页面，用于分页插件的分页显示
        modelAndView.addObject("pageNum", pageNum);
        //将当前查询的控制器路径返回到页面，页码变化时继续向该路径发送请求
        modelAndView.addObject("gourl", request.getRequestURI());
        return modelAndView;
    }

    @ResponseBody
    @RequestMapping("/addEvent")
    public ResponseEntity addEvent(String eventName, String location, String eventStartDate, String eventEndDate, String state, String eventDescription, HttpServletRequest request) {
        Event event = new Event();
        event.setEventName(eventName);
        event.setLocation(location);

        event.setEventStartDate(Timestamp.valueOf(formatTimeStamp(eventStartDate)));
        event.setEventEndDate(Timestamp.valueOf(formatTimeStamp(eventEndDate)));

        event.setStatus(state);
        event.setEventDescription(eventDescription);

        eventService.addEvent(event);

        return new ResponseEntity(HttpStatus.ACCEPTED);
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

}
