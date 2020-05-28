package com.airbnb3.codesquad.airbnb3.controller;

import com.airbnb3.codesquad.airbnb3.dto.DetailDtoAlex;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoAlex;
import com.airbnb3.codesquad.airbnb3.service.AirBnbService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsProperties.*;

@RestController
@RequestMapping("/alex")
public class AirBnbControllerAlex {

    @Autowired
    private AirBnbService airBnbService;

    @GetMapping("/properties")
    public ResponseEntity<List<PropertiesDtoAlex>> stayedPage(
            @RequestParam(value = "offset", required = false, defaultValue = "1") String pageNum,
            @RequestParam(value = "adults", required = false, defaultValue = "1") String adults,
            @RequestParam(value = "children", required = false, defaultValue = "0") String children,
            @RequestParam(value = "checkin", required = false) String checkIn,
            @RequestParam(value = "checkout", required = false) String checkOut,
            @RequestParam(value = "price_min", required = false, defaultValue = "min") String minRange,
            @RequestParam(value = "price_max", required = false, defaultValue = "max") String maxRange,
            @RequestParam(value = "min_lat", required = false, defaultValue = "min_lat") String minLatitude,
            @RequestParam(value = "min_long", required = false, defaultValue = "min_long") String minLongitude,
            @RequestParam(value = "max_lat", required = false, defaultValue = "max_lat") String maxLatitude,
            @RequestParam(value = "max_long", required = false, defaultValue = "max_long") String maxLongitude
    ) {
        return new ResponseEntity<>(airBnbService.stayedProperties(pageNum, adults, children, checkIn, checkOut,
                minRange, maxRange, minLatitude, maxLatitude, minLongitude, maxLongitude), HttpStatus.OK);
    }

    @GetMapping("/properties/{id}")
    public ResponseEntity<DetailDtoAlex> detailPage(@PathVariable("id") Long id) {
        return new ResponseEntity<>(airBnbService.detailProperties(id), HttpStatus.OK);
    }

    @PutMapping("/reservations/{id}")
    public ResponseEntity<Object> bookingRequest(@PathVariable("id") Long id,
                                                 @RequestParam(value = "checkin") String checkIn,
                                                 @RequestParam(value = "checkout") String checkOut,
                                                 @RequestParam(value = "guests") String guests
    ) {

        return new ResponseEntity<>("TEST", HttpStatus.OK);
    }
}
