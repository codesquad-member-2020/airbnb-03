package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.PropertiesDaoAlex;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoAlex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsProperties.*;

@Service
public class AirBnbService {

    @Autowired
    PropertiesDaoAlex propertiesDao;

    //, Double minPrice, Double maxPrice
    public List<PropertiesDtoAlex> stayedProperties(Integer pageNumber, Integer adult, Integer children, Integer infants, String checkIn, String checkOut) {
        int propertyRange = pageNumber * PAGE_VIEW_ITEM_COUNT;
        int accommodates = adult + children;
        Date checkInDate = parseStringToDate(checkIn);
        Date checkOutDate = parseStringToDate(checkOut);
        return propertiesDao.getStayedProperties(propertyRange, accommodates,checkInDate,checkOutDate);
    }

    private Date parseStringToDate(String date) {
        try {
            return Date.valueOf(date);
        } catch (IllegalArgumentException e) {
            return Date.valueOf(LocalDate.now());
        }
    }
}
