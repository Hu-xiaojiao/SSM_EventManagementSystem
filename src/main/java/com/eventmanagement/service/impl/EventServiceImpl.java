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

@Service
@Transactional
public class EventServiceImpl implements EventService {
    @Autowired
    private EventMapper eventMapper;

    /**
     * 根据当前页码和每页需要展示的数据条数，查询最新上架的图书信息
     * @param pageNo 当前页码
     * @param pageSize 每页显示数量
     */
    @Override
    public PageResult getNewEvents(Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        Page<Event> page = eventMapper.selectNewBooks();
        return new PageResult(page.getTotal(), page.getResult());
    }
}
