package com.inventory.util;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


public class DateFormatUtil {
    private static final DateTimeFormatter DATE_TIME_FORMATTER =
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    public static String format(LocalDateTime dateTime){
        if(dateTime == null){
            return "";
        }
        return dateTime.format(DATE_TIME_FORMATTER);
    }
}
