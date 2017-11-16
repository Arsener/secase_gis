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
	private LevelMapper levelMapper;
	@Resource
	private TypeNewsMapper typeNewsMapper;
	@Resource
	private LevelNewsMapper levelNewsMapper;
	@Resource
	private PlaceNewsMapper placeNewsMapper;
	@Resource
	private DetailMapper detailMapper;
	@Resource
	private IndexNewsMapper indexNewsMapper;
	
	private List<String> place_list = new ArrayList<String>();
	
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String getIndex(HttpServletRequest request, Model model){

		place_list.add("广东");
		place_list.add("北京");
		place_list.add("山西");
		place_list.add("吉林");
		place_list.add("江苏");
		place_list.add("安徽");
		place_list.add("湖南");
		place_list.add("四川");
		place_list.add("天津");
		place_list.add("黑龙江"); 
		place_list.add("辽宁");
		place_list.add("内蒙古"); 
		place_list.add("新疆");
		place_list.add("西藏");
		place_list.add("青海");
		place_list.add("甘肃");
		place_list.add("宁夏");
		place_list.add("陕西");
		place_list.add("河南");
		place_list.add("河北");
		place_list.add("山东");
		place_list.add("上海");
		place_list.add("湖北");
		place_list.add("重庆");
		place_list.add("云南");
		place_list.add("广西");
		place_list.add("海南");
		place_list.add("台湾");
		place_list.add("福建");
		place_list.add("江西");
		place_list.add("贵州");
		place_list.add("浙江");
		place_list.add("香港");
		place_list.add("澳门");
		
		List<News> news = indexNewsMapper.selectNewsByNeither();
		HttpSession session = request.getSession();
		session.setAttribute("news", news);
		session.setAttribute("case_place", "全部");
		session.setAttribute("case_type", "全部");
		
		model.addAttribute("news", news);
		
		return "index";
	}
	
	@RequestMapping(value="/", method = RequestMethod.POST)
	public String getIndexNews(HttpServletRequest request, Model model){
		String case_place = request.getParameter("case_place");
		String case_type = request.getParameter("case_type");

		
		List<News> news = new ArrayList<News>();
		if (case_place.equals("全部") && case_type.equals("全部")){
			news = indexNewsMapper.selectNewsByNeither();
		}
		else if(case_place.equals("全部")){
			news = indexNewsMapper.selectNewsByType(case_type);
		}
		else if(case_type.equals("全部")){
			news = indexNewsMapper.selectNewsByPlace(case_place);
		}
		else{
			news = indexNewsMapper.selectNewsByBoth(case_place, case_type);
		}

		HttpSession session = request.getSession();
		session.setAttribute("case_place", case_place);
		session.setAttribute("case_type", case_type);
		session.setAttribute("news", news);
		model.addAttribute("news", news);
		
		return "index";
	}

	@RequestMapping(value="/showCounts", method = RequestMethod.POST)
	public ModelAndView showCounts(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();	
		List<Place> places = placeMapper.showByPlace();
		
		List<Place> placesAll = new ArrayList<Place>();
		for(int i = 0; i < place_list.size(); i++){
			placesAll.add(new Place());
			placesAll.get(i).setPlace_name(place_list.get(i));
			
			boolean in = false;
			int index = -1;
			for(int j = 0; j < places.size(); j++){
				if(place_list.get(i).equals(places.get(j).getPlace_name())){
					in = true;
					index = j;
					break;
				}
			}
			
			if (in){
				placesAll.get(i).setCase_count(places.get(index).getCase_count());
			}
			else{
				placesAll.get(i).setCase_count(0);
			}

		}
		
        HttpSession session = request.getSession();
        System.out.println(placesAll.size());
		session.setAttribute("places", places);
		session.setAttribute("placesAll", placesAll);
		
		String case_place = request.getParameter("case_place");
		if(case_place == null){
			case_place = "北京";
		}
		
		List<News> news = placeNewsMapper.showPlaceNews(case_place);
		session.setAttribute("case_place", case_place);
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
	
	@RequestMapping(value="/showLevels", method = RequestMethod.POST)
	public ModelAndView showLevels(HttpServletRequest request){	
		ModelAndView mav = new ModelAndView();
		List<Level> levels = levelMapper.selectByLevel();
		
        HttpSession session = request.getSession();
		session.setAttribute("levels", levels);
		
		String case_level = request.getParameter("case_level");
		
		if(case_level == null){
			case_level = "一般事故";
		}
		
//		System.out.println(case_type);
		
		List<News> news = levelNewsMapper.showLevelNews(case_level);
		session.setAttribute("news", news);
		
		mav.addObject("news", news);
		session.setAttribute("case_level", case_level);
		mav.setViewName("showLevels");
		
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
