package com.airbnb3.codesquad.airbnb3;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AirbnbController {

    @GetMapping("/index")
    public String index() {

        return "index";
    }


}
