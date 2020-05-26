package com.airbnb3.codesquad.airbnb3.dto.component;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class HostDto {
    private String hostType;
    private String notes;
    private String hostName;
    private String hostSince;
    private String hostLocatison;
    private String hostAbout;

    @Builder
    public HostDto(String hostType, String notes, String hostName, String hostSince, String hostLocatison, String hostAbout) {
        this.hostType = hostType;
        this.notes = notes;
        this.hostName = hostName;
        this.hostSince = hostSince;
        this.hostLocatison = hostLocatison;
        this.hostAbout = hostAbout;
    }
}
