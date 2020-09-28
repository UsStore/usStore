package com.example.usStore.controller.mypage;

import java.io.Serializable;

public class DataSearch implements Serializable {

    private Content content;

    public DataSearch() {
    }

    public DataSearch(Content content) {
        this.content = content;
    }

    public Content getContent() {
        return content;
    }

    public void setContent(Content content) {
        this.content = content;
    }

}
