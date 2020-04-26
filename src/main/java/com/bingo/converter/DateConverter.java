package com.bingo.converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

/**
 * 
 * @ClassName: DateConverter
 * @Description: TODO(日期转换器)
 * @author 25865
 * @date 2018年11月25日 下午6:12:33 <br/>
 *       注意：本内容仅限于学习参考，禁止外泄以及用于其他的商业目
 */
public class DateConverter implements Converter<String, Date> {

	@Override
	public Date convert(String source) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = format.parse(source);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

}
