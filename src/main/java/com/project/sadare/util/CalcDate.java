package com.project.sadare.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CalcDate {

	public static final int SEC = 60;
	public static final int MIN = 60;
	public static final int HOUR = 24;
	public static final int DAY = 30;
	public static final int MONTH = 12;

	public static String txtDate(Date tempDate) {
		long curTime = System.currentTimeMillis();
		long regTime = tempDate.getTime();
		long diffTime = (curTime - regTime) / 1000;
		String msg = null;
		if (diffTime < SEC) {
			msg = diffTime + "초 전";
		} else if ((diffTime /= SEC) < MIN) {
			msg = diffTime + "분 전";
		} else if ((diffTime /= MIN) < HOUR) {
			msg = (diffTime) + "시간 전";
		} else if ((diffTime /= HOUR) < DAY) {
			msg = (diffTime) + "일 전";
		} else if ((diffTime /= DAY) < MONTH) {
			msg = (diffTime) + "개월 전";
		} else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
			msg = sdf.format(tempDate);
		}
		return msg;
	}

}
