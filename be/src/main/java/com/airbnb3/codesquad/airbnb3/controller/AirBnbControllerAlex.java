package com.airbnb3.codesquad.airbnb3.controller;

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
            @RequestParam(value = "adult", required = false, defaultValue = "1") Integer adult,
            @RequestParam(value = "children", required = false, defaultValue = "0") Integer children,
            @RequestParam(value = "infants", required = false, defaultValue = "0") Integer infants,
            @RequestParam(value = "checkin", required = false) Date checkIn,
            @RequestParam(value = "checkout", required = false) Date checkOut,
            @RequestParam(value = "price_min", required = false) Double minPrice,
            @RequestParam(value = "price_max", required = false) Double maxPrice
    ) {
        return new ResponseEntity<>(airBnbService.stayedProperties(pageNum,adult,children,infants), HttpStatus.OK);
    }
//    @GetMapping()
//    public void filterdPage(@PathVariable(value = "guest_count",required = false) Integer guestCount,
//                            @PathVariable(value = "min_price")) {
//
//    }
}
