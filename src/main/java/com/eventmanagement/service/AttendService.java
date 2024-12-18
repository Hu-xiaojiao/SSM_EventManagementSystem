package com.eventmanagement.service;

import com.eventmanagement.domain.Attend;
import com.eventmanagement.entity.PageResult;

public interface AttendService {

    PageResult search(Attend attend, Integer pageNum, Integer pageSize);

    Attend findAttendByAttendId(String attendId);

    Integer updateAttend(Attend attend);

    void addAttend(String eventId, String userId);

    void delAttend(String attendId);
}
