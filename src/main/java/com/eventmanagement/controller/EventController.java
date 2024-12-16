package com.eventmanagement.controller;

import com.eventmanagement.domain.Event;
import com.eventmanagement.entity.PageResult;
import com.eventmanagement.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

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
}
