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

    @RequestMapping("/getNewBooks")
    public ModelAndView getNewBooks() {
        int pageNo = 1;
        int pageSize = 10;
        PageResult pageResult = eventService.getNewEvents(pageNo, pageSize);
        System.out.println(pageResult.getRows());
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("events_new.jsp");
        modelAndView.addObject("pageResult", pageResult);
        return modelAndView;
    }
}
