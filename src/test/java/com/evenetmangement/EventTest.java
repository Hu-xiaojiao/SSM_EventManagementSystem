package com.evenetmangement;

import com.eventmanagement.entity.PageResult;
import com.eventmanagement.service.EventService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:application-service.xml", "classpath:application-dao.xml"})
public class EventTest {
    @Autowired
    private EventService eventService;
    @Test
    public void getNewEvent(){
        int pageNo = 1;
        int pageSize = 10;
        PageResult pageResult = eventService.getNewEvents(pageNo, pageSize);
        System.out.println(pageResult.getRows());
    }
}