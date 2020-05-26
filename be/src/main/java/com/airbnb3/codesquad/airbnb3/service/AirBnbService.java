package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.DetailDaoAlex;
import com.airbnb3.codesquad.airbnb3.dao.PropertiesDaoAlex;
import com.airbnb3.codesquad.airbnb3.dto.DetailDtoAlex;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoAlex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsProperties.*;

@Service
public class AirBnbService {

    @Autowired
    PropertiesDaoAlex propertiesDao;

    @Autowired
    DetailDaoAlex detailDao;

    public List<PropertiesDtoAlex> stayedProperties(Integer pageNumber, Integer adults, Integer children,
                                                    String checkIn, String checkOut, String minRange, String maxRange) {
        int propertyRange = pageNumber * PAGE_VIEW_ITEM_COUNT;
        int accommodates = adults + children;
        Date checkInDate = parseStringToDate(checkIn);
        Date checkOutDate = parseStringToDate(checkOut);
        Double minPrice = parseStringToMinDouble(minRange);
        Double maxPrice = parseStringToMaxDouble(maxRange);
        return propertiesDao.getStayedProperties(propertyRange, accommodates, checkInDate, checkOutDate, minPrice, maxPrice);
    }

    public DetailDtoAlex detailProperties(Long id) {
        return detailDao.getDetailProperties(id);
    }

    private Date parseStringToDate(String date) {
        try {
            return Date.valueOf(date);
        } catch (IllegalArgumentException e) {
            return Date.valueOf(LocalDate.now());
        }
    }

    private Double parseStringToMinDouble(String price) {
        try {
            return Double.parseDouble(price);
        } catch (IllegalArgumentException e) {
            return DEFAULT_MIN_PRICE;
        }
    }

    private Double parseStringToMaxDouble(String price) {
        try {
            return Double.parseDouble(price);
        } catch (IllegalArgumentException e) {
            return DEFAULT_MAX_PRICE;
        }
    }
}
