package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.PropertiesDaoHamill;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDetailDtoHamill;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsPropertiesHamill.*;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Service
public class AirbnbServiceHamill {

    private static final Logger logger = LoggerFactory.getLogger(AirbnbServiceHamill.class);

    private final PropertiesDaoHamill propertiesDaoHamill;

    public AirbnbServiceHamill(PropertiesDaoHamill propertiesDaoHamill) {
        this.propertiesDaoHamill = propertiesDaoHamill;
    }

    public List<PropertiesDtoHamill> findAllProperties(String offset, String priceMin, String priceMax, String checkIn,
                                                       String checkOut, String adults, String children) {

        Double DoubleTypePriceMin = parseStringToDoublePriceMin(priceMin);
        Double DoubleTypePriceMax = parseStringToDoublePriceMax(priceMax);
        Integer accommodates = parseStringToIntegerAdults(adults) + parseStringToIntegerChildren(children);

        if (DoubleTypePriceMin > DoubleTypePriceMax) {
            Double tmp = DoubleTypePriceMax;
            DoubleTypePriceMax = DoubleTypePriceMin;
            DoubleTypePriceMin = tmp;
        }

        return propertiesDaoHamill.findAllProperties(
                parseStringToIntegerOffset(offset),
                DoubleTypePriceMin,
                DoubleTypePriceMax,
                parseStringToDateCheckIn(checkIn),
                parseStringToDateCheckOut(checkOut),
                accommodates);
    }

    public PropertiesDetailDtoHamill findByPropertiesId(int propertiesId) {
        return propertiesDaoHamill.findByPropertiesId(propertiesId);
    }

    private Integer parseStringToIntegerOffset(String offset) {

        if (offset == null) {
            return Integer.parseInt(DEFAULT_OFFSET);
        }

        try {
            if (Integer.parseInt(offset) < 0) {
                return Integer.parseInt(DEFAULT_OFFSET);
            }
            return Integer.parseInt(offset);
        } catch (IllegalArgumentException e) {
            return Integer.parseInt(DEFAULT_OFFSET);
        }
    }
    private Double parseStringToDoublePriceMin(String priceMin) {

        if (priceMin == null) {
            return Double.parseDouble(DEFAULT_MIN_PRICE);
        }

        try {
            if (Double.parseDouble(priceMin) < 0) {
                return Double.parseDouble(DEFAULT_MIN_PRICE);
            }
            return Double.parseDouble(priceMin);
        } catch (IllegalArgumentException e) {
            return Double.parseDouble(DEFAULT_MIN_PRICE);
        }
    }
    private Double parseStringToDoublePriceMax(String priceMax) {

        if (priceMax == null) {
            return Double.parseDouble(DEFAULT_MAX_PRICE);
        }

        try {
            if (Double.parseDouble(priceMax) < 0) {
                return Double.parseDouble(DEFAULT_MAX_PRICE);
            }
            return Double.parseDouble(priceMax);
        } catch (IllegalArgumentException e) {
            return Double.parseDouble(DEFAULT_MAX_PRICE);
        }
    }
    private Date parseStringToDateCheckIn(String date) {

        if (date == null) {
            logger.info("##### current time: {}",Date.valueOf(LocalDate.now()));
            return Date.valueOf(LocalDate.now());
        }

        try {
            return Date.valueOf(date);
        } catch(IllegalArgumentException e) {
            return Date.valueOf(LocalDate.now());
        }
    }
    private Date parseStringToDateCheckOut(String date) {

        if (date == null) {
            logger.info("##### end time: {}",Date.valueOf(LocalDate.of(2021,6,4)));
            return Date.valueOf(LocalDate.of(2021,6,4));
        }

        try {
            return Date.valueOf(date);
        } catch(IllegalArgumentException e) {
            return Date.valueOf(LocalDate.of(2021,6,4));
        }
    }
    private Integer parseStringToIntegerAdults(String adults) {

        if (adults == null) {
            return Integer.parseInt(DEFAULT_ADULTS_COUNT);
        }

        try {
            if (Integer.parseInt(adults) < 0) {
                Integer.parseInt(DEFAULT_ADULTS_COUNT);
            }
            return Integer.parseInt(adults);
        } catch (IllegalArgumentException e) {
            return Integer.parseInt(DEFAULT_ADULTS_COUNT);
        }
    }
    private Integer parseStringToIntegerChildren(String children) {

        if (children == null) {
            return Integer.parseInt(DEFAULT_CHILDREN_COUNT);
        }

        try {
            if (Integer.parseInt(children) < 0) {
                return Integer.parseInt(DEFAULT_CHILDREN_COUNT);
            }
            return Integer.parseInt(children);
        } catch (IllegalArgumentException e) {
            return Integer.parseInt(DEFAULT_CHILDREN_COUNT);
        }
    }
}

