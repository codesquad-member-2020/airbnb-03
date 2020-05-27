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
    AirBnbService airBnbService;

    @GetMapping("/main")
    public ResponseEntity<List<PropertiesDtoAlex>> stayedPage(
            @RequestParam(value = "offset", required = false, defaultValue = "1") Integer pageNum,
            @RequestParam(value = "adults", required = false, defaultValue = "1") Integer adults,
            @RequestParam(value = "children", required = false, defaultValue = "0") Integer children,
            // 값을 받고는 있지만, 사용 하지 않는 변수 infants(신생아)
            @RequestParam(value = "infants", required = false, defaultValue = "0") Integer infants,
            @RequestParam(value = "checkin", required = false) String checkIn,
            @RequestParam(value = "checkout", required = false) String checkOut,
            @RequestParam(value = "price_min", required = false, defaultValue = "min") String minRange,
            @RequestParam(value = "price_max", required = false, defaultValue = "max") String maxRange
//            @RequestParam(value = "min_lat", required = false, defaultValue = "max") String maxRange
//            @RequestParam(value = "min_long", required = false, defaultValue = "max") String maxRange
//            @RequestParam(value = "max_lat", required = false, defaultValue = "max") String maxRange
//            @RequestParam(value = "max_long", required = false, defaultValue = "max") String maxRange

    ) {
        return new ResponseEntity<>(airBnbService.stayedProperties(pageNum, adults, children, checkIn, checkOut, minRange, maxRange), HttpStatus.OK);
    }

    @GetMapping("/detail/{id}")
    public ResponseEntity<DetailDtoAlex> detailPage(@PathVariable("id") Long id) {
        return new ResponseEntity<>(airBnbService.detailProperties(id),HttpStatus.OK);
    }

    @GetMapping("/map")
    public ResponseEntity<Object> mapRequest(@RequestParam(value = "latitude") String latitude, @RequestParam(value = "longitude") String longitude) {
        return new ResponseEntity<>("TEST",HttpStatus.OK);
    }

    @GetMapping("/booking")
    public ResponseEntity<Object> bookingRequest() {
        return new ResponseEntity<>("TEST",HttpStatus.OK);
    }
}
