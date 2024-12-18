package com.eventmanagement.service.impl;

import com.eventmanagement.dao.AttendMapper;
import com.eventmanagement.domain.Attend;
import com.eventmanagement.entity.PageResult;
import com.eventmanagement.service.AttendService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AttendServiceImpl implements AttendService {
    @Autowired
    private AttendMapper attendMapper;

    /**
     * 根据当前页码和每页需要展示的数据条数，查询最新上架的图书信息
     * @param pageNum 当前页码
     * @param pageSize 每页显示数量
     */

    @Override
    public PageResult search(Attend attend, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        Page<Attend> page = attendMapper.search(attend);
        return new PageResult(page.getTotal(), page.getResult());
    }

    public void addAttend(String eventId, String userId) {
        attendMapper.addAttend(eventId, userId);
    }

    public Attend findAttendByAttendId(String attendId) {
        return attendMapper.findAttendByAttendId(attendId);
    }

    public Integer updateAttend(Attend attend) {
        return attendMapper.updateAttend(attend);
    }

    public void delAttend(String attendId) {
        attendMapper.delAttend(attendId);
    }
}