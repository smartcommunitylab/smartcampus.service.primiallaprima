/*******************************************************************************
 * Copyright 2012-2013 Trento RISE
 * 
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 * 
 *        http://www.apache.org/licenses/LICENSE-2.0
 * 
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 ******************************************************************************/
package eu.trentorise.smartcampus.services.primiallaprima.impl;

import it.sayservice.platform.core.common.util.StringUtil;
import it.sayservice.platform.core.message.Core.TimeData;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

import eu.trentorise.smartcampus.services.primiallaprima.data.message.Primiallaprima.Event;
import eu.trentorise.smartcampus.services.primiallaprima.data.message.Primiallaprima.EventDetail;

public class GetEventsScript {
	
	public Event addEventDetail(Event event, EventDetail detail){
		
		// Constructs a builder initialized with the current message.
		Event.Builder eventBuilder = event.toBuilder();
		
		eventBuilder.setDetail(detail);
				
		return eventBuilder.build();
	}
	
	public Event setTimeData(Event event){
		
		// Constructs a builder initialized with the current message.
		Event.Builder eventBuilder = event.toBuilder();
		
		TimeData.Builder pointTimeData = TimeData.newBuilder();

		Date date = getDate(event);
		
		Date now = new Date();
		if (date.before(now)) {
			Calendar cal = new GregorianCalendar();
			cal.setTime(date);
			cal.add(Calendar.YEAR, 1);
			date = cal.getTime();
		}
		
		

		// String dateFormat = "EEE MMM dd HH:mm:ss zzzz yyyy";
//		try {
//			pointTimeData.setRecurrence(DateUtil.generateICal(event.getTitle(), date.toString(), null, dateFormat, null));
//			eventBuilder.setTime(pointTimeData);
//		} catch (ParseException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		pointTimeData.setStart(date.getTime());
		pointTimeData.setDuration(1000 * 60 * 60 * 2);
		pointTimeData.setAllDay(false);
		eventBuilder.setTime(pointTimeData);
		
		
		String format = "EEEE dd/MM/yyyy 'ore' HH:mm";
		SimpleDateFormat sdf = new SimpleDateFormat(format, Locale.ITALIAN);
				
		eventBuilder.setEventDate(sdf.format(date));
		
		return eventBuilder.build();
	}
	
	public Event setEventId(Event event) {
		Event.Builder eventBuilder = event.toBuilder();

		String title = StringUtil.cleanString(event.getTitle());
		String id = StringUtil.cleanString(title + "_" + event.getCity() + "_"
				+ event.getEventDate());

		eventBuilder.setTitle(title);
		eventBuilder.setId(id);
		// eventBuilder.setId(id + "_" + XSLTUtil.timestamp());

		return eventBuilder.build();
	}
	
	
private Date getDate(Event event) {
		
		java.util.Calendar c = java.util.Calendar.getInstance();
		
	    int hour = 0;
		int minute = 0;
		int day, month, year;
		
		if(event.hasHour() && !event.getHour().equals("")) {
			String [] timeProto = event.getHour().split(":");
			hour = Integer.parseInt(timeProto[0]);
			minute = Integer.parseInt(timeProto[1]);
		}
		
		String[] protoDate = event.getDay().split(" ");
		
		if(protoDate[0].equals("Domani")){
			c.set(java.util.Calendar.DAY_OF_MONTH,
					c.get(java.util.Calendar.DAY_OF_MONTH) + 1);
		}
		else if (!protoDate[0].equals("Oggi") && (protoDate.length > 1)){
			String[] protoDays = protoDate[1].split("/");
			
			day = Integer.parseInt(protoDays[0]);
			month = Integer.parseInt(protoDays[1]);
			
			c.set(java.util.Calendar.DAY_OF_MONTH, day);
			c.set(java.util.Calendar.MONTH, month - 1);
			
			if(protoDate.length > 2) {
				year = Integer.parseInt(protoDays[2]);
				c.set(java.util.Calendar.YEAR, year);
			}
		}
		
		c.set(java.util.Calendar.HOUR_OF_DAY, hour);
		c.set(java.util.Calendar.MINUTE, minute);
		c.set(java.util.Calendar.SECOND, 0);
		c.set(java.util.Calendar.MILLISECOND, 0);
		
		Date date = new Date(c.getTimeInMillis());
		
		return date;
	}
}
