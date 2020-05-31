package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.DetailDao;
import com.airbnb3.codesquad.airbnb3.dao.PropertiesDao;
import com.airbnb3.codesquad.airbnb3.dto.alex.DetailDtoAlex;
import com.airbnb3.codesquad.airbnb3.dto.alex.PropertiesDtoAlex;
import com.airbnb3.codesquad.airbnb3.service.alex.AirBnbServiceAlex;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsProperties.*;

@Service
public class AirbnbService {

    private static final Logger logger = LoggerFactory.getLogger(AirBnbServiceAlex.class);

    private final PropertiesDao propertiesDao;
    private final DetailDao detailDao;

    public AirbnbService(PropertiesDao propertiesDao, DetailDao detailDao) {
        this.propertiesDao = propertiesDao;
        this.detailDao = detailDao;
    }

    public List<PropertiesDtoAlex> stayedProperties(Integer offset, Integer adults, Integer children,
                                                    Date checkIn, Date checkOut, String minPrice, String maxPrice,
                                                    String minLatitude, String maxLatitude, String minLongitude, String maxLongitude) {

        Integer propertyRange = PAGE_VIEW_ITEM_COUNT * offset;
        Integer accommodates = adults + children;
        BigDecimal minPriceRange = new BigDecimal(String.valueOf(minPrice));
        BigDecimal maxPriceRange = new BigDecimal(String.valueOf(maxPrice));
        BigDecimal minLatitudeRange = new BigDecimal(String.valueOf(maxPrice));
        BigDecimal maxLatitudeRange = new BigDecimal(String.valueOf(maxPrice));
        BigDecimal minLongitudeRange = new BigDecimal(String.valueOf(maxPrice));
        BigDecimal maxLongitudeRange = new BigDecimal(String.valueOf(maxPrice));
        return propertiesDao.getStayedProperties(propertyRange, accommodates, checkIn, checkOut, minPriceRange,maxPriceRange,minLatitudeRange,maxLatitudeRange,minLongitudeRange,maxLongitudeRange);
    }

    public DetailDtoAlex detailProperties(Long id) {
        return detailDao.getDetailProperties(id);
    }

    public void saveProperties(Long id, String name) {

    }

    private Map<String, Date> dateCompare(String checkIn, String checkOut) {

        Map<String, Date> tempMap = new HashMap<>();
        Date checkInDate = parseStringToCheckInDate(checkIn);
        Date checkOutDate = parseStringToCheckOutDate(checkOut);

        if (checkInDate.after(checkOutDate)) {
            Date temp = checkInDate;
            checkInDate = checkOutDate;
            checkOutDate = temp;
        }

        if (checkInDate.before(Date.valueOf(LocalDate.now()))) checkInDate = Date.valueOf(LocalDate.now());

        tempMap.put("checkInDate", checkInDate);
        tempMap.put("checkOutDate", checkOutDate);
        return tempMap;
    }

    private Integer parseStringToAccommodatesInteger(String adults, String children) {
        Integer adult;
        Integer child;
        try {
            adult = Integer.parseInt(adults);
        } catch (IllegalArgumentException e) {
            adult = 1;
        }

        try {
            child = Integer.parseInt(children);
        } catch (IllegalArgumentException e) {
            child = 0;
        }
        return adult + child;
    }

    private Map<String, Double> parseStringToLocationDouble(String minLatitude, String maxLatitude, String minLongitude, String maxLongitude) {
        Map<String, Double> temp = new HashMap<>();
        try {
            temp.put("minLatitude", Double.parseDouble(minLatitude));
        } catch (IllegalArgumentException e) {
            temp.put("minLatitude", DEFAULT_MIN_LATITUDE);
        }

        try {
            temp.put("maxLatitude", Double.parseDouble(maxLatitude));
        } catch (IllegalArgumentException e) {
            temp.put("maxLatitude", DEFAULT_MAX_LATITUDE);
        }

        try {
            temp.put("minLongitude", Double.parseDouble(minLongitude));
        } catch (IllegalArgumentException e) {
            temp.put("minLongitude", DEFAULT_MIN_LONGITUDE);
        }

        try {
            temp.put("maxLongitude", Double.parseDouble(maxLongitude));
        } catch (IllegalArgumentException e) {
            temp.put("maxLongitude", DEFAULT_MAX_LONGITUDE);
        }
        return temp;
    }
}
