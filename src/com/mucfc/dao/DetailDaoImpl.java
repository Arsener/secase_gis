package com.mucfc.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mucfc.mapper.DetailMapper;
import com.mucfc.model.Detail;

@Component
public class DetailDaoImpl implements DetailDao {
	@Autowired
	private DetailMapper detailMapper;
	
	@Override
	public Detail showDetail(int case_id) {
		// TODO Auto-generated method stub
		Detail detail = detailMapper.showDetail(case_id);
		return detail;
	}

}
