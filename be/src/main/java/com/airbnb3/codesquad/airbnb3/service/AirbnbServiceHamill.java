package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.PropertiesDaoHamill;
import com.airbnb3.codesquad.airbnb3.dto.BookingsDtoHamill;
import com.airbnb3.codesquad.airbnb3.dto.DetailDtoHamill;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
import java.util.List;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsPropertiesHamill.*;

@Service
public class AirbnbServiceHamill {

    private static final Logger logger = LoggerFactory.getLogger(AirbnbServiceHamill.class);

    private final PropertiesDaoHamill propertiesDaoHamill;

    public AirbnbServiceHamill(PropertiesDaoHamill propertiesDaoHamill) {
        this.propertiesDaoHamill = propertiesDaoHamill;
    }

    public List<PropertiesDtoHamill> findAllProperties(String offset, String priceMin, String priceMax,
                                                       String checkIn, String checkOut, String adults, String children,
                                                       String minLatitude, String minLongitude, String maxLatitude, String maxLongitude) {

        Integer integerTypeOffset = parseStringToIntegerOffset(offset);
        Double doubleTypePriceMin = parseStringToDoublePriceMin(priceMin);
        Double doubleTypePriceMax = parseStringToDoublePriceMax(priceMax);
        Date dateTypeCheckIn = parseStringToDateCheckIn(checkIn);
        Date dateTypeCheckOut = parseStringToDateCheckOut(checkOut);
        Integer guests = parseStringToIntegerAdults(adults) + parseStringToIntegerChildren(children);
        Double doubleTypeMinLatitude = parseStringToDoubleMinLatitude(minLatitude);
        Double doubleTypeMinLongitude = parseStringToDoubleMinLongitude(minLongitude);
        Double doubleTypeMaxLatitude = parseStringToDoubleMaxLatitude(maxLatitude);
        Double doubleTypeMaxLongitude = parseStringToDoubleMaxLongitude(maxLongitude);

        if (doubleTypePriceMin > doubleTypePriceMax) {
            Double tmp = doubleTypePriceMax;
            doubleTypePriceMax = doubleTypePriceMin;
            doubleTypePriceMin = tmp;
        }

        if (dateTypeCheckIn.compareTo(dateTypeCheckOut) > 0) {
            Date tmp = dateTypeCheckOut;
            dateTypeCheckOut = dateTypeCheckIn;
            dateTypeCheckIn = tmp;
        }

        return propertiesDaoHamill.findAllProperties(integerTypeOffset, doubleTypePriceMin, doubleTypePriceMax,
                dateTypeCheckIn, dateTypeCheckOut, guests, doubleTypeMinLatitude, doubleTypeMinLongitude,
                doubleTypeMaxLatitude, doubleTypeMaxLongitude);
    }

    public DetailDtoHamill findByPropertiesId(Long propertiesId) {
        return propertiesDaoHamill.findByPropertiesId(propertiesId);
    }

    // 모든 예약 목록 반환
    public List<BookingsDtoHamill> findAllReservations() {

        return propertiesDaoHamill.findAllReservations();
    }

    // 숙소 예약
    public void reserveTheProperties(Long reservationId, Date checkIn, Date checkOut, Integer guests, String name) {

        Period period = Period.between(checkIn.toLocalDate(), checkOut.toLocalDate());
        propertiesDaoHamill.insertReservationInformation(reservationId, checkIn, checkOut, guests, period.getDays(), name);
        propertiesDaoHamill.insertReservationDate(reservationId, checkIn, period.getDays());
    }

    // 숙소 예약 취소
    public void cancelTheProperties(Long propertiesId) {
        propertiesDaoHamill.deleteReservationInformation(propertiesId);
        propertiesDaoHamill.deleteReservationDate(propertiesId);
    }

    public void savedTheProperties(Long propertyId, Long userId) {

        propertiesDaoHamill.savedTheProperties(propertyId, userId);
    }

    private Integer parseStringToIntegerOffset(String offset) {

        if (offset == null) {
            return Integer.parseInt(DEFAULT_OFFSET);
        }

        try {
            if (Integer.parseInt(offset) < 0) {
                return Integer.parseInt(DEFAULT_OFFSET);
            }
            return Integer.parseInt(offset) * 20;
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
            return Date.valueOf(LocalDate.now());
        }

        try {
            return Date.valueOf(date);
        } catch (IllegalArgumentException e) {
            return Date.valueOf(LocalDate.now());
        }
    }

    private Date parseStringToDateCheckOut(String date) {

        if (date == null) {
            return Date.valueOf(LocalDate.of(2021, 6, 4));
        }

        try {
            return Date.valueOf(date);
        } catch (IllegalArgumentException e) {
            return Date.valueOf(LocalDate.now().plusDays(2));
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

    private Double parseStringToDoubleMinLatitude(String minLatitude) {

        if (minLatitude == null) {
            return Double.parseDouble(DEFAULT_MIN_LATITUDE);
        }

        try {
            return Double.parseDouble(minLatitude);
        } catch (IllegalArgumentException e) {
            return Double.parseDouble(DEFAULT_MIN_LATITUDE);
        }
    }

    private Double parseStringToDoubleMinLongitude(String minLongitude) {

        if (minLongitude == null) {
            return Double.parseDouble(DEFAULT_MIN_LONGITUDE);
        }

        try {
            return Double.parseDouble(minLongitude);
        } catch (IllegalArgumentException e) {
            return Double.parseDouble(DEFAULT_MIN_LONGITUDE);
        }
    }

    private Double parseStringToDoubleMaxLatitude(String maxLatitude) {

        if (maxLatitude == null) {
            return Double.parseDouble(DEFAULT_MAX_LATITUDE);
        }

        try {
            return Double.parseDouble(maxLatitude);
        } catch (IllegalArgumentException e) {
            return Double.parseDouble(DEFAULT_MAX_LATITUDE);
        }
    }

    private Double parseStringToDoubleMaxLongitude(String maxLongitude) {

        if (maxLongitude == null) {
            return Double.parseDouble(DEFAULT_MAX_LONGITUDE);
        }

        try {
            return Double.parseDouble(maxLongitude);
        } catch (IllegalArgumentException e) {
            return Double.parseDouble(DEFAULT_MAX_LONGITUDE);
        }
    }


}

