package com.airbnb3.codesquad.airbnb3.common;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class CommonMessage {
    private String statusCode;
    private String message;
}
