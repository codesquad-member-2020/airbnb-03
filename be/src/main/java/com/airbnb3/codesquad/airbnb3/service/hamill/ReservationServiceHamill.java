package com.airbnb3.codesquad.airbnb3.service.hamill;

import com.airbnb3.codesquad.airbnb3.dao.hamill.ReservationDaoHamill;
import com.airbnb3.codesquad.airbnb3.dto.hamill.BookingsDtoHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Service
public class ReservationServiceHamill {

    private static final Logger logger = LoggerFactory.getLogger(AirbnbServiceHamill.class);

    private final ReservationDaoHamill reservationDaoHamill;

    public ReservationServiceHamill(ReservationDaoHamill reservationDaoHamill) {
        this.reservationDaoHamill = reservationDaoHamill;
    }

    // 모든 예약 목록 반환
    public List<BookingsDtoHamill> findAllReservations() {

        return reservationDaoHamill.findAllReservations();
    }

    // 숙소 예약
    public BookingsDtoHamill reserveTheProperties(Long propertyId, Date checkIn, Date checkOut, Integer adults, Integer children, String name) {

        Integer nights = (int)ChronoUnit.DAYS.between(checkIn.toLocalDate(), checkOut.toLocalDate());
        Integer guests = adults + children;
        reservationDaoHamill.insertReservationInformation(propertyId, checkIn, checkOut, guests, nights, name);
        reservationDaoHamill.insertReservationDate(propertyId, checkIn, nights);
        reservationDaoHamill.updateReservableIsFalse(propertyId);
        return reservationDaoHamill.findByPropertyId(propertyId);
    }

    // 숙소 예약 취소
    public void cancelTheProperties(Long propertyId) {

        reservationDaoHamill.deleteReservationInformation(propertyId);
        reservationDaoHamill.deleteReservationDate(propertyId);
        reservationDaoHamill.updateReservableIsTrue(propertyId);
    }
}
