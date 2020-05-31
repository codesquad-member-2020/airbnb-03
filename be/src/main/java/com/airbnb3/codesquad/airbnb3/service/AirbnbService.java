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
        BigDecimal minLatitudeRange = new BigDecimal(String.valueOf(minLatitude));
        BigDecimal maxLatitudeRange = new BigDecimal(String.valueOf(maxLatitude));
        BigDecimal minLongitudeRange = new BigDecimal(String.valueOf(minLongitude));
        BigDecimal maxLongitudeRange = new BigDecimal(String.valueOf(maxLongitude));

        logger.info("minPrice : {} , maxPrice : {}",minPriceRange,maxPriceRange);
        logger.info("minLat : {} , maxLat : {}",minLatitudeRange,maxLatitudeRange);
        logger.info("minLong : {} , maxLong : {}",minLongitudeRange,maxLongitudeRange);

        if (checkIn == null) {
            checkIn = Date.valueOf(LocalDate.now());
        }
        if (checkOut == null) {
            checkOut = Date.valueOf(checkIn.toLocalDate().plusDays(2));
        }
        logger.info("checkIn : {} , checkOut : {}",checkIn,checkOut);

        return propertiesDao.getStayedProperties(propertyRange, accommodates, checkIn, checkOut, minPriceRange,maxPriceRange,minLatitudeRange,maxLatitudeRange,minLongitudeRange,maxLongitudeRange);
    }

    public DetailDtoAlex detailProperties(Long id) {
        return detailDao.getDetailProperties(id);
    }

    public void saveProperties(Long id, String name) {

    }
}
