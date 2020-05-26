package com.airbnb3.codesquad.airbnb3.controller;

import com.airbnb3.codesquad.airbnb3.dto.PropertiesDetailDtoHamill;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoHamill;
import com.airbnb3.codesquad.airbnb3.service.AirbnbServiceHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsPropertiesHamill.*;

@RestController
public class AirbnbControllerHamill {

    private static final Logger logger = LoggerFactory.getLogger(AirbnbControllerHamill.class);
    private final AirbnbServiceHamill airbnbServiceHamill;

    public AirbnbControllerHamill(AirbnbServiceHamill airbnbServiceHamill) {
        this.airbnbServiceHamill = airbnbServiceHamill;
    }

    @GetMapping("/main")
    public ResponseEntity<List<PropertiesDtoHamill>> findAllProperties(
            @RequestParam(value = "offset", required = false, defaultValue = DEFAULT_OFFSET) String offset,
            @RequestParam(value = "price_min", required = false, defaultValue = DEFAULT_MIN_PRICE ) String priceMin,
            @RequestParam(value = "price_max", required = false, defaultValue = DEFAULT_MAX_PRICE) String priceMax,
            @RequestParam(value = "checkin", required = false) String checkIn,
            @RequestParam(value = "checkout", required = false) String checkOut,
            @RequestParam(value = "adults", required = false, defaultValue = DEFAULT_ADULTS_COUNT) String adults,
            @RequestParam(value = "children", required = false, defaultValue = DEFAULT_CHILDREN_COUNT) String children) {

        return new ResponseEntity<>(
                airbnbServiceHamill.findAllProperties(offset,priceMin, priceMax, checkIn, checkOut, adults, children),
                HttpStatus.OK);
    }

    @GetMapping("/detail/{propertiesId}")
    public ResponseEntity<PropertiesDetailDtoHamill> findByPropertiesId(@PathVariable int propertiesId) {
        return new ResponseEntity<>(airbnbServiceHamill.findByPropertiesId(propertiesId), HttpStatus.OK);
    }
}
