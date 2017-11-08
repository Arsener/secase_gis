package com.mucfc.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mucfc.mapper.PlaceMapper;
import com.mucfc.model.Place;

@Component
public class PlaceDaoImpl implements PlaceDao{
	@Autowired
	private PlaceMapper placeMapper;
	@Override
	public List<Place> showByPlace() {
		List<Place> place = placeMapper.showByPlace();
		return place; 
	}
	
}
