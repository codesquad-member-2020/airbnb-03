package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.DetailDaoAlex;
import com.airbnb3.codesquad.airbnb3.dao.PropertiesDaoAlex;
import com.airbnb3.codesquad.airbnb3.dto.DetailDtoAlex;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoAlex;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsProperties.*;

@Service
public class AirBnbService {

    private static final Logger logger = LoggerFactory.getLogger(AirBnbService.class);

    @Autowired
    PropertiesDaoAlex propertiesDao;

    @Autowired
    DetailDaoAlex detailDao;

    public List<PropertiesDtoAlex> stayedProperties(Integer pageNumber, Integer adults, Integer children,
                                                    String checkIn, String checkOut, String minRange, String maxRange) {
        int propertyRange = pageNumber * PAGE_VIEW_ITEM_COUNT;
        int accommodates = adults + children;
        Map<String, Date> reservationDates = dateCompare(checkIn, checkOut);
        Date checkInDate = reservationDates.get("checkInDate");
        Date checkOutDate = reservationDates.get("checkOutDate");
        Double minPrice = parseStringToMinDouble(minRange);
        Double maxPrice = parseStringToMaxDouble(maxRange);
        logger.info("----------------- Main Query ---------------------");
        logger.info("propertyRange : {}", propertyRange);
        logger.info("accommodates : {}", accommodates);
        logger.info("checkInDate : {}", checkInDate);
        logger.info("checkOutDate : {}", checkOutDate);
        logger.info("minPrice : {}", minPrice);
        logger.info("maxPrice : {}", maxPrice);
        logger.info("--------------------------------------------------");
        return propertiesDao.getStayedProperties(propertyRange, accommodates, checkInDate, checkOutDate, minPrice, maxPrice);
    }

    public DetailDtoAlex detailProperties(Long id) {
        return detailDao.getDetailProperties(id);
    }

    private Map<String, Date> dateCompare(String checkIn, String checkOut) {

        Map<String, Date> tempMap = new HashMap<>();
        Date checkInDate = parseStringToCheckInDate(checkIn);
        Date checkOutDate = parseStringToCheckOutDate(checkOut);

        if (checkInDate.compareTo(checkOutDate) > 0) {
            Date temp = checkInDate;
            checkInDate = checkOutDate;
            checkOutDate = temp;
        }
        tempMap.put("checkInDate", checkInDate);
        tempMap.put("checkOutDate", checkOutDate);
        return tempMap;
    }

    private Date parseStringToCheckInDate(String date) {
        try {
            return Date.valueOf(date);
        } catch (IllegalArgumentException e) {
            return Date.valueOf(LocalDate.now());
        }
    }

    private Date parseStringToCheckOutDate(String date) {
        try {
            return Date.valueOf(date);
        } catch (IllegalArgumentException e) {
            return Date.valueOf(LocalDate.now().plusDays(2));
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
