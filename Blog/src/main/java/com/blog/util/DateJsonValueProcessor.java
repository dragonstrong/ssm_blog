package com.blog.util;

import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;


/**时间格式转换*/
public class DateJsonValueProcessor implements JsonValueProcessor
{

    private String format;

    public DateJsonValueProcessor(String format) {
        this.format = format;
    }

    @Override
    public Object processArrayValue(Object o, JsonConfig jsonConfig) {
        return null;
    }

    @Override
    public Object processObjectValue(String key, Object value, JsonConfig jsonConfig) {
        if(value==null)
        return null;
        //类型转换
        if(value instanceof Timestamp)
            return new SimpleDateFormat(this.format).format((Timestamp)value);
        if(value instanceof Date)
            return new SimpleDateFormat(this.format).format((Date)value);

        return value.toString();





    }
}
