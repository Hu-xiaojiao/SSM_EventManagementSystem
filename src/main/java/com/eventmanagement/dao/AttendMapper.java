package com.eventmanagement.dao;

import com.eventmanagement.domain.Attend;
import com.github.pagehelper.Page;

public interface AttendMapper {
    void addAttend(String eventId, String userId);

    Attend findAttendByAttendId(String attendId);

    Integer updateAttend(Attend attend);

    Page<Attend> search(Attend attend);

    void delAttend(String attendId);
}
