package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.PropertiesDaoAlex;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoAlex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsProperties.*;

@Service
public class AirBnbService {

    @Autowired
    PropertiesDaoAlex propertiesDao;
//Date checkIn, Date checkOut, Double minPrice, Double maxPrice
    public List<PropertiesDtoAlex> stayedProperties(Integer pageNumber, Integer adult, Integer children, Integer infants) {
        Integer propertyRange = pageNumber * PAGE_VIEW_ITEM_COUNT;
        Integer accommodates = adult + children;
        return propertiesDao.getStayedProperties(propertyRange,accommodates);
    }
//
//    public List<PropertiesDtoAlex> filterdProperties() {
//
//    }
}
