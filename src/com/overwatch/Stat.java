package com.overwatch;

/**
 * Created by Liam on 4/30/2017.
 */
public class Stat {

    private String title;
    private String value;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title.replace("\"", "");
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value.replace("\"", "");
    }
}
