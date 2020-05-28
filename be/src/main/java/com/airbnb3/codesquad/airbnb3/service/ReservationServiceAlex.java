package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.DetailDaoAlex;
import com.airbnb3.codesquad.airbnb3.dao.ReservationDaoAlex;
import com.airbnb3.codesquad.airbnb3.dao.UserDaoAlex;
import com.airbnb3.codesquad.airbnb3.dto.ReservationDto;
import com.airbnb3.codesquad.airbnb3.dto.composition.PriceDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsProperties.*;

@Service
public class ReservationServiceAlex {

    private static final Logger logger = LoggerFactory.getLogger(AirBnbService.class);

    @Autowired
    private ReservationDaoAlex reservationDao;

    @Autowired
    private DetailDaoAlex detailDao;

    @Autowired
    private UserDaoAlex userDao;

    public void propertyReservation(Long id, String checkIn, String checkOut, String guest, String name) {
        Map<String, Date> reservationDates = dateCompare(checkIn, checkOut);
        Integer guestCount = parseStringToAccommodatesInteger(guest);
        PriceDto prices = detailDao.getPrices(id);
        Long userId = userDao.getIdFromUserId(name).orElse(-1L);
        Date checkInDate = reservationDates.get("checkInDate");
        Date checkOutDate = reservationDates.get("checkOutDate");
        int nights = (int) ((checkOutDate.getTime() - checkInDate.getTime()) / DEFAULT_ONE_DAY);
        Double roomTotalPrice = prices.getPrice()*nights;
        Double totalPrice = roomTotalPrice + prices.getCleaningFee() + prices.getServiceFee() + prices.getTax();
        ReservationDto reservationDto = ReservationDto.builder()
                .checkInDate(checkInDate)
                .checkOutDate(checkOutDate)
                .bookingDate(Date.valueOf(LocalDate.now()))
                .nights(nights)
                .cleaningFee(prices.getCleaningFee())
                .serviceFee(prices.getServiceFee())
                .tax(prices.getTax())
                .roomPrice(prices.getPrice())
                .roomTotalPrice(roomTotalPrice)
                .totalPrice(totalPrice)
                .propertiesId(id)
                .userId(userId)
                .build();
    }

    private Map<String, Date> dateCompare(String checkIn, String checkOut) {

        Map<String, Date> tempMap = new HashMap<>();
        Date checkInDate = parseStringToCheckInDate(checkIn);
        Date checkOutDate = parseStringToCheckOutDate(checkOut);

        if (checkInDate.before(checkOutDate)) {
            Date temp = checkInDate;
            checkInDate = checkOutDate;
            checkOutDate = temp;
        }
        tempMap.put("checkInDate", checkInDate);
        tempMap.put("checkOutDate", checkOutDate);
        return tempMap;
    }

    private Date parseStringToCheckOutDate(String date) {
        try {
            return Date.valueOf(date);
        } catch (IllegalArgumentException e) {
            return Date.valueOf(LocalDate.now().plusDays(1));
        }
    }

    private Date parseStringToCheckInDate(String date) {
        try {
            return Date.valueOf(date);
        } catch (IllegalArgumentException e) {
            return Date.valueOf(LocalDate.now());
        }
    }

    private Integer parseStringToAccommodatesInteger(String guest) {
        try {
            return Integer.parseInt(guest);
        } catch (IllegalArgumentException e) {
            return DEFAULT_GUESTS_NUM;
        }
    }


}
