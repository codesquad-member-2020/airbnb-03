package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.ReservationDao;
import com.airbnb3.codesquad.airbnb3.dto.hamill.BookingsDtoHamill;
import com.airbnb3.codesquad.airbnb3.service.hamill.AirbnbServiceHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.Period;
import java.util.List;


@Service
public class ReservationService {

    private static final Logger logger = LoggerFactory.getLogger(AirbnbServiceHamill.class);

    private final ReservationDao reservationDao;

    public ReservationService(ReservationDao reservationDao) {
        this.reservationDao = reservationDao;
    }

    // 모든 예약 목록 반환
    public List<BookingsDtoHamill> findAllReservations() {

        return reservationDao.findAllReservations();
    }

    // 숙소 예약
    public void reserveTheProperties(Long reservationId, Date checkIn, Date checkOut, Integer guests, String name) {

        Period period = Period.between(checkIn.toLocalDate(), checkOut.toLocalDate());
        reservationDao.insertReservationInformation(reservationId, checkIn, checkOut, guests, period.getDays(), name);
    }

    // 숙소 예약 취소
    public void cancelTheProperties(Long propertiesId) {
        reservationDao.deleteReservationInformation(propertiesId);
    }
}
