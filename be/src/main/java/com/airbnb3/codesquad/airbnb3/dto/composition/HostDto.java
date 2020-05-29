package com.airbnb3.codesquad.airbnb3.dto.composition;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class HostDto {
    private Boolean isSuperHost;
    private String notes;
    private String hostName;
    private String hostSince;
    private String hostLocation;
    private String hostAbout;

    @Builder
    public HostDto(Boolean isSuperHost, String notes, String hostName, String hostSince, String hostLocation, String hostAbout) {
        this.isSuperHost = isSuperHost;
        this.notes = notes;
        this.hostName = hostName;
        this.hostSince = hostSince;
        this.hostLocation = hostLocation;
        this.hostAbout = hostAbout;
    }
}
