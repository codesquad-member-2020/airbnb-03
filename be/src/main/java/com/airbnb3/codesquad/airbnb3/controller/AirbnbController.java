package com.airbnb3.codesquad.airbnb3.controller;

import com.airbnb3.codesquad.airbnb3.common.CommonMessage;
import com.airbnb3.codesquad.airbnb3.config.jwt.JwtService;
import com.airbnb3.codesquad.airbnb3.dto.DetailDto;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDto;
import com.airbnb3.codesquad.airbnb3.dto.ReservationsDto;
import com.airbnb3.codesquad.airbnb3.service.AirbnbService;
import com.airbnb3.codesquad.airbnb3.service.ReservationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.sql.Date;
import java.util.List;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsPropertiesHamill.*;


@RestController
public class AirbnbController {

    private static final Logger logger = LoggerFactory.getLogger(AirbnbController.class);
    private final AirbnbService airbnbService;
    private final ReservationService reservationService;
    private final JwtService jwtService;

    public AirbnbController(AirbnbService airbnbService, ReservationService reservationService, JwtService jwtService) {
        this.airbnbService = airbnbService;
        this.reservationService = reservationService;
        this.jwtService = jwtService;
    }

    @GetMapping("/properties")
    public ResponseEntity<List<PropertiesDto>> stayedPage(
            @RequestParam(value = "offset", required = false, defaultValue = DEFAULT_OFFSET) Integer offset,
            @RequestParam(value = "adults", required = false, defaultValue = DEFAULT_ADULTS_COUNT) Integer adults,
            @RequestParam(value = "children", required = false, defaultValue = DEFAULT_CHILDREN_COUNT) Integer children,
            @RequestParam(value = "min_price", required = false, defaultValue = DEFAULT_MIN_PRICE) String minPrice,
            @RequestParam(value = "max_price", required = false, defaultValue = DEFAULT_MAX_PRICE) String maxPrice,
            @RequestParam(value = "check_in", required = false) Date checkIn,
            @RequestParam(value = "check_out", required = false) Date checkOut,
            @RequestParam(value = "min_lat", required = false, defaultValue = DEFAULT_MIN_LATITUDE) String minLatitude,
            @RequestParam(value = "min_long", required = false, defaultValue = DEFAULT_MIN_LONGITUDE) String minLongitude,
            @RequestParam(value = "max_lat", required = false, defaultValue = DEFAULT_MAX_LATITUDE) String maxLatitude,
            @RequestParam(value = "max_long", required = false, defaultValue = DEFAULT_MAX_LONGITUDE) String maxLongitude,
            @RequestParam(value = "name", required = false, defaultValue = DEFAULT_NAME) String name,
            @RequestParam(value = "search", required = false, defaultValue = "%") String searchData
    ) {

        return new ResponseEntity<>(airbnbService.stayedProperties(offset, adults, children, checkIn, checkOut, name,
                minPrice, maxPrice, searchData, minLatitude, maxLatitude, minLongitude, maxLongitude), HttpStatus.OK);
    }

    @GetMapping("/properties/{id}")
    public ResponseEntity<DetailDto> detailPage(@PathVariable("id") Long id, HttpServletRequest request) {
        return new ResponseEntity<>(airbnbService.detailProperties(id), HttpStatus.OK);
    }

    @GetMapping("/reservations")
    public ResponseEntity<List<ReservationsDto>> findAllReservations() {
        return new ResponseEntity<>(reservationService.findAllReservations(), HttpStatus.OK);
    }

    @PutMapping("/reservations/{propertyId}")
    public ResponseEntity<Object> reserveTheProperties(
            @PathVariable Long propertyId,
            @RequestParam(value = "check_in") Date checkIn,
            @RequestParam(value = "check_out") Date checkOut,
            @RequestParam(value = "adults", required = false, defaultValue = DEFAULT_ADULTS_COUNT) Integer adults,
            @RequestParam(value = "children", required = false, defaultValue = DEFAULT_CHILDREN_COUNT) Integer children,
            @CookieValue(value = "name", required = false, defaultValue = DEFAULT_NAME) String name) {

        ReservationsDto result = reservationService.reserveTheProperties(propertyId, checkIn, checkOut, adults, children, name);

        if (result == null) {
            return new ResponseEntity<>(getMessage("400", "이미 예약되어 있는 상품입니다"), HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @DeleteMapping("/reservations/{propertyId}")
    public ResponseEntity<CommonMessage> cancelTheProperties(@PathVariable Long propertyId) {

        reservationService.cancelTheProperties(propertyId);
        return new ResponseEntity<>(getMessage("200", "예약 취소"), HttpStatus.OK);
    }

    @PutMapping("/saved/{propertyId}")
    public ResponseEntity<CommonMessage> savedProperties(@PathVariable("propertyId") Long propertyId, @RequestParam(value = "name", defaultValue = "Alex") String name) {
        airbnbService.saveProperties(propertyId, name);
        return new ResponseEntity<>(getMessage("200", "즐겨찾기 성공"), HttpStatus.OK);
    }

    @DeleteMapping("/saved/{propertyId}")
    public ResponseEntity<CommonMessage> unSavedProperties(@PathVariable("propertyId") Long propertyId, @RequestParam(value = "name", defaultValue = "Alex") String name) {
        airbnbService.unSaveProperties(propertyId, name);
        return new ResponseEntity<>(getMessage("200", "즐겨찾기 삭제"), HttpStatus.OK);
    }

    @GetMapping("/saved")
    public ResponseEntity<List<PropertiesDto>> savedPropertiesList(@RequestParam(value = "name", defaultValue = DEFAULT_NAME) String name) {
        return new ResponseEntity<>(airbnbService.savedPropertiesList(name), HttpStatus.OK);
    }

    private CommonMessage getMessage(String statusCode, String message) {

        return CommonMessage.builder()
                .statusCode(statusCode)
                .message(message)
                .build();
    }
}
