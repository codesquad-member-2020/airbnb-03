package com.airbnb3.codesquad.airbnb3.service.hamill;

import com.airbnb3.codesquad.airbnb3.dao.hamill.ReservationDaoHamill;
import com.airbnb3.codesquad.airbnb3.dto.hamill.BookingsDtoHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.Period;
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
    public void reserveTheProperties(Long propertyId, Date checkIn, Date checkOut, Integer guests, String name) {

        Period period = Period.between(checkIn.toLocalDate(), checkOut.toLocalDate());
        reservationDaoHamill.insertReservationInformation(propertyId, checkIn, checkOut, guests, period.getDays(), name);
        reservationDaoHamill.insertReservationDate(propertyId, checkIn, period.getDays());
        reservationDaoHamill.updateReservableIsFalse(propertyId);
    }

    // 숙소 예약 취소
    public void cancelTheProperties(Long propertiesId) {
        reservationDaoHamill.deleteReservationInformation(propertiesId);
        reservationDaoHamill.deleteReservationDate(propertiesId);
        reservationDaoHamill.updateReservableIsTrue(propertiesId);
    }
}
