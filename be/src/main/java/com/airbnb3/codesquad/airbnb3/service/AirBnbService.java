package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.PropertiesDaoAlex;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoAlex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsProperties.*;

@Service
public class AirBnbService {
    @Autowired
    PropertiesDaoAlex propertiesDao;

    public List<PropertiesDtoAlex> stayedProperties(int pageNumber) {
        int propertyRange = pageNumber * PAGE_VIEW_ITEM_COUNT;
        return propertiesDao.getStayedProperties(propertyRange);
    }
}
