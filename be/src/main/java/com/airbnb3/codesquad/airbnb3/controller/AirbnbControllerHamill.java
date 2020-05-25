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

@RestController
public class AirbnbControllerHamill {

    private static final Logger logger = LoggerFactory.getLogger(AirbnbControllerHamill.class);
    private final AirbnbServiceHamill airbnbServiceHamill;

    public AirbnbControllerHamill(AirbnbServiceHamill airbnbServiceHamill) {
        this.airbnbServiceHamill = airbnbServiceHamill;
    }

    @GetMapping("/main")
    public ResponseEntity<List<PropertiesDtoHamill>> findAllProperties(
            @RequestParam(value = "offset", required = false) Integer offset,
            @RequestParam(value = "price_min", required = false) Double priceMin,
            @RequestParam(value = "price_max", required = false) Double priceMax,
            @RequestParam(value = "adults", required = false) Integer adults,
            @RequestParam(value = "children", required = false) Integer children) {
        return new ResponseEntity<>(airbnbServiceHamill.findAllProperties(offset,priceMin, priceMax, adults, children), HttpStatus.OK);
    }

    @GetMapping("/detail/{propertiesId}")
    public ResponseEntity<PropertiesDetailDtoHamill> findByPropertiesId(@PathVariable int propertiesId) {
        return new ResponseEntity<>(airbnbServiceHamill.findByPropertiesId(propertiesId), HttpStatus.OK);
    }
}
