package com.example.usStore.controller.mypage;

import java.io.Serializable;
import java.util.List;

public class Content implements Serializable{

    private List<UnivInfo> uniInfo;

    public Content() {
    }

    public Content(List<UnivInfo> uniInfo) {
        this.uniInfo = uniInfo;
    }

    public List<UnivInfo> getUniInfo() {
        return uniInfo;
    }

    public void setUniInfo(List<UnivInfo> uniInfo) {
        this.uniInfo = uniInfo;
    }

}
