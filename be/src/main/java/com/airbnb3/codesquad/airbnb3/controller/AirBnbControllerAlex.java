package com.airbnb3.codesquad.airbnb3.controller;

import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoAlex;
import com.airbnb3.codesquad.airbnb3.service.AirBnbService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/alex")
public class AirBnbControllerAlex {

    @Autowired
    AirBnbService airBnbService;

    @GetMapping("/main/{pageNum}")
    public ResponseEntity<List<PropertiesDtoAlex>> stayedPage(@PathVariable("pageNum") int pageNum) {
        return new ResponseEntity<>(airBnbService.stayedProperties(pageNum), HttpStatus.OK);
    }

//    @GetMapping()
//    public void filterdPage(@PathVariable(value = "guest_count",required = false) Integer guestCount,
//                            @PathVariable(value = "min_price")) {
//
//    }
}
