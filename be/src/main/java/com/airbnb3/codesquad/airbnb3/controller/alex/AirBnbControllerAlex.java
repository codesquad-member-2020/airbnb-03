package com.airbnb3.codesquad.airbnb3.controller.alex;

import com.airbnb3.codesquad.airbnb3.dto.alex.DetailDtoAlex;
import com.airbnb3.codesquad.airbnb3.dto.alex.PropertiesDtoAlex;
import com.airbnb3.codesquad.airbnb3.dto.ReservationDto;
import com.airbnb3.codesquad.airbnb3.service.alex.AirBnbServiceAlex;
import com.airbnb3.codesquad.airbnb3.service.alex.ReservationServiceAlex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/alex")
public class AirBnbControllerAlex {
//
//    @Autowired
//    private AirBnbServiceAlex airBnbServiceAlex;
//
//    @Autowired
//    private ReservationServiceAlex reservationService;
//
//    @GetMapping("/properties")
//    public ResponseEntity<List<PropertiesDtoAlex>> stayedPage(
//            @RequestParam(value = "offset", required = false, defaultValue = "1") String offset,
//            @RequestParam(value = "adults", required = false, defaultValue = "1") String adults,
//            @RequestParam(value = "children", required = false, defaultValue = "0") String children,
//            @RequestParam(value = "check_in", required = false) String checkIn,
//            @RequestParam(value = "check_out", required = false) String checkOut,
//            @RequestParam(value = "min_price", required = false, defaultValue = "min") String minRange,
//            @RequestParam(value = "max_price", required = false, defaultValue = "max") String maxRange,
//            @RequestParam(value = "min_lat", required = false, defaultValue = "min_lat") String minLatitude,
//            @RequestParam(value = "min_long", required = false, defaultValue = "min_long") String minLongitude,
//            @RequestParam(value = "max_lat", required = false, defaultValue = "max_lat") String maxLatitude,
//            @RequestParam(value = "max_long", required = false, defaultValue = "max_long") String maxLongitude
//    ) {
//        return new ResponseEntity<>(airBnbServiceAlex.stayedProperties(offset, adults, children, checkIn, checkOut,
//                minRange, maxRange, minLatitude, maxLatitude, minLongitude, maxLongitude), HttpStatus.OK);
//    }
//
//    @GetMapping("/properties/{id}")
//    public ResponseEntity<DetailDtoAlex> detailPage(@PathVariable("id") Long id) {
//        return new ResponseEntity<>(airBnbServiceAlex.detailProperties(id), HttpStatus.OK);
//    }
//
//    //@PutMapping("/reservations/{id}")
//    @GetMapping("/reservations/{id}")
//    public ResponseEntity<Object> reservationRequest(@PathVariable("id") Long id,
//                                                     @RequestParam(value = "check_in") String checkIn,
//                                                     @RequestParam(value = "check_out") String checkOut,
//                                                     @RequestParam(value = "adults") String adults,
//                                                     @RequestParam(value = "children") String children,
//                                                     @CookieValue(value = "name", defaultValue = "None", required = false) String name
//    ) {
//        // 내부 로직 수정
//        ReservationDto result = reservationService.propertyReservation(id, checkIn, checkOut, guests, name);
//        if (result == null) {
//            return new ResponseEntity<>("Already Booked!!!!!!!!!!!!!!!!", HttpStatus.OK);
//        }
//        return new ResponseEntity<>(result, HttpStatus.OK);
//    }
//
//    //@DeleteMapping("/reservations/{id}")
//    @GetMapping("/reservations/{id}")
//    public ResponseEntity<Object> cancelReservationRequest(@PathVariable("id") Long reservationId) {
//        //내부 로직 수정
//        reservationService.cancelReservation(reservationId, propertiesId);
//        return new ResponseEntity<>("Cancel Reservation", HttpStatus.OK);
//    }
//
//    //@PutMapping("/saved/{id}")
//    @GetMapping("/saved/{id}")
//    public void savedProperties(@PathVariable("id") Long id, @CookieValue(value = "name", defaultValue = "Alex") String name) {
//        airBnbServiceAlex.saveProperties(id, name);
//    }
}
