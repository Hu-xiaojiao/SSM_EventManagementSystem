package com.eventmanagement.service.impl;

import com.eventmanagement.dao.EventMapper;
import com.eventmanagement.domain.Event;
import com.eventmanagement.entity.PageResult;
import com.eventmanagement.service.EventService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@Service
@Transactional
public class EventServiceImpl implements EventService {
    @Autowired
    private EventMapper eventMapper;

    /**
     * 根据当前页码和每页需要展示的数据条数，查询最新上架的图书信息
     * @param pageNum 当前页码
     * @param pageSize 每页显示数量
     */
    @Override
    public PageResult getNewEvents(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        Page<Event> page = eventMapper.getNewEvents();
        return new PageResult(page.getTotal(), page.getResult());
    }

    @Override
    public PageResult search(Event event, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        Page<Event> page = eventMapper.search(event);
        return new PageResult(page.getTotal(), page.getResult());
    }

    public Integer addEvent(Event event) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        event.setUpdatedAt(Timestamp.valueOf(dateFormat.format(new Date())));
        event.setCreatedAt(Timestamp.valueOf(dateFormat.format(new Date())));
        return eventMapper.addEvent(event);
    }

    public Event findEventByEventId(String eventId) {
        return eventMapper.findEventByEventId(eventId);
    }

    public Integer updateEvent(Event event) {
        return eventMapper.updateEvent(event);
    }
}
