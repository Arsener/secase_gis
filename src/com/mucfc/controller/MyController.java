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

		place_list.add("�㶫");
		place_list.add("����");
		place_list.add("ɽ��");
		place_list.add("����");
		place_list.add("����");
		place_list.add("����");
		place_list.add("����");
		place_list.add("�Ĵ�");
		place_list.add("���");
		place_list.add("������"); 
		place_list.add("����");
		place_list.add("���ɹ�"); 
		place_list.add("�½�");
		place_list.add("����");
		place_list.add("�ຣ");
		place_list.add("����");
		place_list.add("����");
		place_list.add("����");
		place_list.add("����");
		place_list.add("�ӱ�");
		place_list.add("ɽ��");
		place_list.add("�Ϻ�");
		place_list.add("����");
		place_list.add("����");
		place_list.add("����");
		place_list.add("����");
		place_list.add("����");
		place_list.add("̨��");
		place_list.add("����");
		place_list.add("����");
		place_list.add("����");
		place_list.add("�㽭");
		place_list.add("���");
		place_list.add("����");
		
		List<News> news = indexNewsMapper.selectNewsByNeither();
		HttpSession session = request.getSession();
		session.setAttribute("news", news);
		session.setAttribute("case_place", "ȫ��");
		session.setAttribute("case_type", "ȫ��");
		
		model.addAttribute("news", news);
		
		return "index";
	}
	
	@RequestMapping(value="/", method = RequestMethod.POST)
	public String getIndexNews(HttpServletRequest request, Model model){
		String case_place = request.getParameter("case_place");
		String case_type = request.getParameter("case_type");

		
		List<News> news = new ArrayList<News>();
		if (case_place.equals("ȫ��") && case_type.equals("ȫ��")){
			news = indexNewsMapper.selectNewsByNeither();
		}
		else if(case_place.equals("ȫ��")){
			news = indexNewsMapper.selectNewsByType(case_type);
		}
		else if(case_type.equals("ȫ��")){
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
			case_place = "����";
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
			case_type = "����������ʩ";
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
			case_level = "һ���¹�";
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
