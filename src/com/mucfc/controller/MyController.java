package com.mucfc.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSpinnerUI;
import javax.websocket.Session;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.portlet.ModelAndView;

import com.mucfc.mapper.*;
import com.mucfc.model.*;
import com.sun.media.sound.SoftSynthesizer;
import com.sun.org.apache.xpath.internal.operations.And;
import com.sun.org.apache.xpath.internal.operations.Mod;

@Controller
public class MyController {
	@Resource
	private PlaceMapper placeMapper;
	@Resource
	private TypeMapper typeMapper;
	@Resource
	private TypeNewsMapper typeNewsMapper;
	@Resource
	private PlaceNewsMapper placeNewsMapper;
	@Resource
	private DetailMapper detailMapper;
	@Resource
	private LocationMapper locationMapper;
	@Resource
	private IndexNewsMapper indexNewsMapper;
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String getIndex(HttpServletRequest request, Model model){
		List<News> news = indexNewsMapper.selectNewsByNeither();
		Location location = locationMapper.findLocation("北京市");
		HttpSession session = request.getSession();
		session.setAttribute("news", news);
		session.setAttribute("case_place", "全部");
		session.setAttribute("case_type", "全部");
		session.setAttribute("location", location);
		
		model.addAttribute("news", news);
		
		return "index";
	}
	
	@RequestMapping(value="/", method = RequestMethod.POST)
	public String getIndexNews(HttpServletRequest request, Model model){
		String case_place = request.getParameter("case_place");
		String case_type = request.getParameter("case_type");

		Location location = new Location();
		location = locationMapper.findLocation("北京市");
		
		List<News> news = new ArrayList<News>();
		if (case_place.equals("全部") && case_type.equals("全部")){
			news = indexNewsMapper.selectNewsByNeither();
			location = locationMapper.findLocation("北京市");
		}
		else if(case_place.equals("全部")){
			news = indexNewsMapper.selectNewsByType(case_type);
			location = locationMapper.findLocation("北京市");
		}
		else if(case_type.equals("全部")){
			news = indexNewsMapper.selectNewsByPlace(case_place);
			location = locationMapper.findLocation(case_place);
		}
		else{
			news = indexNewsMapper.selectNewsByBoth(case_place, case_type);
			location = locationMapper.findLocation(case_place);
		}

		HttpSession session = request.getSession();
		session.setAttribute("case_place", case_place);
		session.setAttribute("case_type", case_type);
		session.setAttribute("news", news);
		session.setAttribute("location", location);
		model.addAttribute("news", news);
		
		return "index";
	}

	@RequestMapping(value="/showCounts", method = RequestMethod.POST)
	public ModelAndView showCounts(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();	
		List<Place> places = placeMapper.showByPlace();
		
        HttpSession session = request.getSession();
		session.setAttribute("places", places);
		
		String case_place = request.getParameter("case_place");
		
		if(case_place == null){
//			System.out.println("null");
			case_place = "北京市";
		}
		Location location = locationMapper.findLocation(case_place);
		
//		System.out.println(case_place);
		
		List<News> news = placeNewsMapper.showPlaceNews(case_place);
		session.setAttribute("case_place", case_place);
		session.setAttribute("location", location);
		session.setAttribute("news", news);
		mav.addObject("news", news);
		mav.setViewName("showCounts");
		
		return mav;
	}
	
	@RequestMapping(value="/showTypes", method = RequestMethod.POST)
	public ModelAndView showTypes(HttpServletRequest request){	
		ModelAndView mav = new ModelAndView();
		List<Type> types = typeMapper.selectByType();
		
        HttpSession session = request.getSession();
		session.setAttribute("types", types);
		
		String case_type = request.getParameter("case_type");
		
		if(case_type == null){
			case_type = "大型游乐设施";
		}
		
//		System.out.println(case_type);
		
		List<News> news = typeNewsMapper.showTypeNews(case_type);
		session.setAttribute("news", news);
		
		mav.addObject("news", news);
		session.setAttribute("case_type", case_type);
		mav.setViewName("showTypes");
		
		return mav;
	}
	
	@RequestMapping(value="/newsDetail")
	public String newsDetail(HttpServletRequest request){
		int case_id = Integer.parseInt(request.getParameter("case_id"));
//		System.out.println(case_id);
		
		Detail detail = detailMapper.showDetail(case_id);
		HttpSession session = request.getSession();
		session.setAttribute("detail", detail);
		
		return "newsDetail";
	}
}
