package com.mucfc.model;

public class Place {
	private String place_name;
	private Integer case_count;
	private double place_lon, place_lat;
	
	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public Integer getCase_count() {
		return case_count;
	}
	public void setCase_count(Integer case_count) {
		this.case_count = case_count;
	}
	public double getPlace_lon() {
		return place_lon;
	}
	public void setPlace_lon(double place_lon) {
		this.place_lon = place_lon;
	}
	public double getPlace_lat() {
		return place_lat;
	}
	public void setPlace_lat(double place_lat) {
		this.place_lat = place_lat;
	}

	
}
