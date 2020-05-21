package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.PropertiesDao;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AirBnbService {
    @Autowired
    PropertiesDao propertiesDao;

    public List<PropertiesDto> stayedProperties(int pageNumber) {
        int propertyRange = pageNumber*20;
        return propertiesDao.getStayedProperties(propertyRange);
    }
}
