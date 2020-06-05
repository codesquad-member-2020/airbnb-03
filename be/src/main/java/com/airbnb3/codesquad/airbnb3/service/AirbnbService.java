package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.DetailDao;
import com.airbnb3.codesquad.airbnb3.dao.PropertiesDao;
import com.airbnb3.codesquad.airbnb3.dao.UserDao;
import com.airbnb3.codesquad.airbnb3.dto.DetailDto;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDto;
import com.airbnb3.codesquad.airbnb3.dto.alex.DetailDtoAlex;
import com.airbnb3.codesquad.airbnb3.dto.alex.PropertiesDtoAlex;
import com.airbnb3.codesquad.airbnb3.dto.hamill.DetailDtoHamill;
import com.airbnb3.codesquad.airbnb3.service.alex.AirBnbServiceAlex;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.Date;

import java.time.LocalDate;
import java.util.List;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsProperties.*;

@Service
public class AirbnbService {

    private static final Logger logger = LoggerFactory.getLogger(AirBnbServiceAlex.class);

    private final PropertiesDao propertiesDao;
    private final DetailDao detailDao;
    private final UserDao userDao;

    public AirbnbService(PropertiesDao propertiesDao, DetailDao detailDao, UserDao userDao) {
        this.propertiesDao = propertiesDao;
        this.detailDao = detailDao;
        this.userDao = userDao;
    }

    public List<PropertiesDto> stayedProperties(Integer offset, Integer adults, Integer children, Date checkIn, Date checkOut,
                                                String name, String minPrice, String maxPrice, String searchData,
                                                String minLatitude, String maxLatitude, String minLongitude, String maxLongitude) {

        Integer propertyRange = PAGE_VIEW_ITEM_COUNT * offset;
        Integer guests = adults + children;
        BigDecimal minPriceRange = new BigDecimal(String.valueOf(minPrice));
        BigDecimal maxPriceRange = new BigDecimal(String.valueOf(maxPrice));
        BigDecimal minLatitudeRange = new BigDecimal(String.valueOf(minLatitude));
        BigDecimal maxLatitudeRange = new BigDecimal(String.valueOf(maxLatitude));
        BigDecimal minLongitudeRange = new BigDecimal(String.valueOf(minLongitude));
        BigDecimal maxLongitudeRange = new BigDecimal(String.valueOf(maxLongitude));
        String search = "%" + searchData.replace(" ", "%") + "%";

        if (checkIn == null) {
            checkIn = Date.valueOf(LocalDate.now());
        }
        if (checkOut == null) {
            checkOut = Date.valueOf(checkIn.toLocalDate().plusDays(2));
        }
        logger.info("checkIn : {} , checkOut : {}", checkIn, checkOut);
        Long userId = userDao.findUserIdByUserName(name);
        return propertiesDao.getStayedProperties(propertyRange, guests, checkIn, checkOut, userId, minPriceRange, maxPriceRange, search, minLatitudeRange, maxLatitudeRange, minLongitudeRange, maxLongitudeRange);
    }

    public DetailDto detailProperties(Long id) {
        return detailDao.getDetailProperties(id);
    }


    public void saveProperties(Long propertyId, String name) {
        Long userId = userDao.findUserIdByUserName(name);
        propertiesDao.saveProperties(propertyId, userId);
    }

    public void unSaveProperties(Long propertyId, String name) {
        Long userId = userDao.findUserIdByUserName(name);
        propertiesDao.unSaveProperties(propertyId, userId);
    }

    public List<PropertiesDto> savedPropertiesList(String name) {
        Long userId = userDao.findUserIdByUserName(name);
        return propertiesDao.savedPropertiesList(userId);
    }
}
