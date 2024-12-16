package com.eventmanagement.service;

import com.eventmanagement.domain.Event;
import com.eventmanagement.entity.PageResult;

public interface EventService {
    PageResult getNewEvents(Integer pageNum, Integer pageSize);

    PageResult search(Event event, Integer pageNum, Integer pageSize);
}
