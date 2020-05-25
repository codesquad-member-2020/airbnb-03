package com.airbnb3.codesquad.airbnb3.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AirbnbControllerHamill {

    @GetMapping("/index")
    public String index() {

        return "index";
    }


}
