package com.eventmanagement.dao;

import com.eventmanagement.domain.Event;
import com.github.pagehelper.Page;

public interface EventMapper {
    Page<Event> getNewEvents();

    Page<Event> search(Event event);

    Integer addEvent(Event event);

    Event findEventByEventId(String eventId);
}
