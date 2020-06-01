package com.airbnb3.codesquad.airbnb3.service.alex;

import com.airbnb3.codesquad.airbnb3.dao.alex.DetailDaoAlex;
import com.airbnb3.codesquad.airbnb3.dao.alex.ReservationDaoAlex;
import com.airbnb3.codesquad.airbnb3.dao.alex.UserDaoAlex;
import com.airbnb3.codesquad.airbnb3.dto.ReservationDto;
import com.airbnb3.codesquad.airbnb3.dto.composition.PriceDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsProperties.*;

@Service
public class ReservationServiceAlex {

    private static final Logger logger = LoggerFactory.getLogger(AirBnbServiceAlex.class);

    @Autowired
    private ReservationDaoAlex reservationDao;

    @Autowired
    private DetailDaoAlex detailDao;

    @Autowired
    private UserDaoAlex userDao;

    public ReservationDto propertyReservation(Long id, String checkIn, String checkOut, String guest, String name) {
        Map<String, Date> reservationDates = dateCompare(checkIn, checkOut);
        Integer nights = (int) ChronoUnit.DAYS.between(reservationDates.get("checkInDate").toLocalDate(), reservationDates.get("checkOutDate").toLocalDate());

        if (reservationDao.checkReservation(reservationDates)) return null;

        Integer guestCount = parseStringToAccommodatesInteger(guest);
        PriceDto prices = detailDao.getPrices(id);
        Long userId = userDao.getIdFromUserId(name);
        Double roomTotalPrice = prices.getPrice() * nights;
        Double totalPrice = roomTotalPrice + prices.getCleaningFee() + prices.getServiceFee() + prices.getTax();

        ReservationDto reservation = ReservationDto.builder()
                .checkInDate(reservationDates.get("checkInDate"))
                .checkOutDate(reservationDates.get("checkOutDate"))
                .bookingDate(Date.valueOf(LocalDate.now()))
                .nights(nights)
                .cleaningFee(prices.getCleaningFee())
                .serviceFee(prices.getServiceFee())
                .tax(prices.getTax())
                .price(prices.getPrice())
                .totalPrice(roomTotalPrice)
                .totalPrice(totalPrice)
                .propertiesId(id)
                .userId(userId)
                .guests(guestCount)
                .build();

        propertiesCalendarUpdate(id, reservationDates.get("checkInDate"), reservationDates.get("checkOutDate"));
        return reservationDao.reservationProperties(reservation);
    }

    public void cancelReservation(Long reservationId, Long propertiesId) {
        String[] date = reservationDao.deleteReservation(reservationId);
        Date checkInDate = Date.valueOf(date[0]);
        Date checkOutDate = Date.valueOf(date[1]);
        reservationDao.deleteCalendar(propertiesId, checkInDate, checkOutDate);
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
        // 현재 이전(과거)의 날짜로 예약을 하려는 경우 현재 날짜 부터 예약을 진행 하도록 변수 변경
        if (checkInDate.before(Date.valueOf(LocalDate.now()))) checkInDate = Date.valueOf(LocalDate.now());

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

    private void propertiesCalendarUpdate(Long id, Date checkInDate, Date checkOutDate) {
        LocalDate checkIn = checkInDate.toLocalDate();
        LocalDate checkOut = checkOutDate.toLocalDate();
        reservationDao.reservationCalendar(id, checkInDate);
        while (!checkIn.isEqual(checkOut)) {
            checkIn = checkIn.plusDays(1L);
            Date reservationDate = Date.valueOf(checkIn);
            reservationDao.reservationCalendar(id, reservationDate);
        }
    }
}
