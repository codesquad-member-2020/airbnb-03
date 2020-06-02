package com.airbnb3.codesquad.airbnb3.controller.hamill;

import com.airbnb3.codesquad.airbnb3.common.CommonMessage;
import com.airbnb3.codesquad.airbnb3.dto.hamill.BookingsDtoHamill;
import com.airbnb3.codesquad.airbnb3.dto.hamill.DetailDtoHamill;
import com.airbnb3.codesquad.airbnb3.dto.hamill.PropertiesDtoHamill;
import com.airbnb3.codesquad.airbnb3.service.hamill.AirbnbServiceHamill;
import com.airbnb3.codesquad.airbnb3.service.hamill.ReservationServiceHamill;
import com.airbnb3.codesquad.airbnb3.service.hamill.SavedServiceHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.List;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsPropertiesHamill.*;

@RestController
@RequestMapping("/hamill")
public class AirbnbControllerHamill {

    private static final Logger logger = LoggerFactory.getLogger(AirbnbControllerHamill.class);
    private final AirbnbServiceHamill airbnbServiceHamill;
    private final ReservationServiceHamill reservationServiceHamill;
    private final SavedServiceHamill savedServiceHamill;

    public AirbnbControllerHamill(AirbnbServiceHamill airbnbServiceHamill, ReservationServiceHamill reservationServiceHamill, SavedServiceHamill savedServiceHamill) {
        this.airbnbServiceHamill = airbnbServiceHamill;
        this.reservationServiceHamill = reservationServiceHamill;
        this.savedServiceHamill = savedServiceHamill;
    }

    @GetMapping("/properties")
    public ResponseEntity<List<PropertiesDtoHamill>> findAllProperties(
            @RequestParam(value = "offset", required = false) String offset,
            @RequestParam(value = "price_min", required = false, defaultValue = DEFAULT_MIN_PRICE) String priceMin,
            @RequestParam(value = "price_max", required = false, defaultValue = DEFAULT_MAX_PRICE) String priceMax,
            @RequestParam(value = "check_in", required = false) String checkIn,
            @RequestParam(value = "check_out", required = false) String checkOut,
            @RequestParam(value = "adults", required = false, defaultValue = DEFAULT_ADULTS_COUNT) String adults,
            @RequestParam(value = "children", required = false, defaultValue = DEFAULT_CHILDREN_COUNT) String children,
            @RequestParam(value = "min_lat", required = false, defaultValue = DEFAULT_MIN_LATITUDE) String minLatitude,
            @RequestParam(value = "min_long", required = false, defaultValue = DEFAULT_MIN_LONGITUDE) String minLongitude,
            @RequestParam(value = "max_lat", required = false, defaultValue = DEFAULT_MAX_LATITUDE) String maxLatitude,
            @RequestParam(value = "max_long", required = false, defaultValue = DEFAULT_MAX_LONGITUDE) String maxLongitude) {

        return new ResponseEntity<>(
                airbnbServiceHamill.findAllProperties(
                        offset, priceMin, priceMax, checkIn, checkOut, adults, children,
                        minLatitude, minLongitude, maxLatitude, maxLongitude),
                HttpStatus.OK);
    }

    @GetMapping("/properties/{propertiesId}")
    public ResponseEntity<DetailDtoHamill> findByPropertiesId(@PathVariable Long propertiesId) {
        return new ResponseEntity<>(airbnbServiceHamill.findByPropertiesId(propertiesId), HttpStatus.OK);
    }

    @GetMapping("/reservations")
    public ResponseEntity<List<BookingsDtoHamill>> findAllReservations() {

        return new ResponseEntity<>(reservationServiceHamill.findAllReservations(), HttpStatus.OK);
    }

    @PutMapping("/reservations/{propertyId}")
    public ResponseEntity<CommonMessage> reserveTheProperties(
            @PathVariable Long propertyId,
            @RequestParam(value = "check_in") Date checkIn,
            @RequestParam(value = "check_out") Date checkOut,
            @RequestParam(value = "adults") Integer adults,
            @RequestParam(value = "children") Integer children,
            @CookieValue(value = "name", required = false, defaultValue = "None") String name) {

        reservationServiceHamill.reserveTheProperties(propertyId, checkIn, checkOut, adults, children, name);
        return new ResponseEntity<>(getMessage("200", "예약 성공"), HttpStatus.OK);
    }

    @DeleteMapping("/reservations/{reservationId}")
    public ResponseEntity<CommonMessage> cancelTheProperties(@PathVariable Long reservationId) {

        reservationServiceHamill.cancelTheProperties(reservationId);
        return new ResponseEntity<>(getMessage("200", "예약 취소"), HttpStatus.OK);
    }

    @GetMapping("/saved")
    public ResponseEntity<List<PropertiesDtoHamill>> findAllSaved(@RequestParam Long userId) {

        return new ResponseEntity<>(savedServiceHamill.findAllSaved(userId), HttpStatus.OK);
    }

    @PutMapping("/saved/{propertyId}")
    public ResponseEntity<CommonMessage> savedTheProperties(
            @PathVariable Long propertyId,
            @RequestParam Long userId) {

        savedServiceHamill.savedTheProperties(propertyId, userId);
        return new ResponseEntity<>(getMessage("200", "즐겨찾기 추가"), HttpStatus.OK);
    }

    @DeleteMapping("/saved/{propertyId}")
    public ResponseEntity<CommonMessage> cancelThePropertiesSaved(
            @PathVariable Long propertyId) {

        savedServiceHamill.cancelThePropertiesSaved(propertyId);
        return new ResponseEntity<>(getMessage("200", "즐겨찾기 취소"), HttpStatus.OK);
    }

    private CommonMessage getMessage(String statusCode, String message) {

        return CommonMessage.builder()
                            .statusCode(statusCode)
                            .message(message)
                            .build();
    }
}
