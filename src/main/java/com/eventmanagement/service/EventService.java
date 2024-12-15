package com.eventmanagement.service;

import com.eventmanagement.entity.PageResult;

public interface EventService {
    PageResult getNewEvents(Integer pageNum, Integer pageSize);
}
