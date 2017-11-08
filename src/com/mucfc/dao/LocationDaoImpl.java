package com.mucfc.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mucfc.mapper.LocationMapper;
import com.mucfc.model.Location;

@Component
public class LocationDaoImpl implements LocationDao{
	@Autowired
	private LocationMapper locationMapper;
	
	@Override
	public Location findLocation(String case_place){
		return locationMapper.findLocation(case_place);
	}
}
