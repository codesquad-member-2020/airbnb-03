package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.PropertiesDaoAlex;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoAlex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AirBnbService {
    @Autowired
    PropertiesDaoAlex propertiesDao;

    public List<PropertiesDtoAlex> stayedProperties(int pageNumber) {
        int propertyRange = pageNumber*20;
        return propertiesDao.getStayedProperties(propertyRange);
    }
}
