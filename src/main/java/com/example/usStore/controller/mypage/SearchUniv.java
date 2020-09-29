package com.example.usStore.controller.mypage;

import java.io.Serializable;

public class SearchUniv implements Serializable {

    private String region;
    private String univName;

    public SearchUniv() {
    }

    public SearchUniv(String region, String univName) {
        this.region = region;
        this.univName = univName;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getUnivName() {
        return univName;
    }

    public void setUnivName(String univName) {
        this.univName = univName;
    }

}
