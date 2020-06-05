package com.airbnb3.codesquad.airbnb3.dto.composition;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class HostDto {
    private Boolean isSuperHost;
    private String notes;
    private String name;
    private String since;
    private String location;
    private String about;
}
