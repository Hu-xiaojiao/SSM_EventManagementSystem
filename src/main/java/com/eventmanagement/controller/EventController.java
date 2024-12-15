package com.eventmanagement.controller;

import com.eventmanagement.entity.PageResult;
import com.eventmanagement.service.EventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
        System.out.println(pageResult.getRows());
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("events_new.jsp");
        modelAndView.addObject("pageResult", pageResult);
        return modelAndView;
    }
}
