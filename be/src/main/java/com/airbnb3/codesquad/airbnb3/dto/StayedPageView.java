package com.airbnb3.codesquad.airbnb3.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class StayedPageView {
    private Object result;

    public StayedPageView(Object result) {
        this.result = result;
    }
}
