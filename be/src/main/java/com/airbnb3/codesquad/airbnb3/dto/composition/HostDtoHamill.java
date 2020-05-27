package com.airbnb3.codesquad.airbnb3.dto.composition;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
public class HostDtoHamill {
    private Boolean isSuperHost;
    private String notes;
    private String hostName;
    private String hostSince;
    private String hostLocation;
    private String hostAbout;
}
