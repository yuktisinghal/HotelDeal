/** 
 * @file	HomeController.java
 * @brief	HomeController.java is used to create from of home controllers
 *
 * @see	

 * @user y.singhal
 *
 */
package com.hotelDeals.server.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hotelDeals.common.model.Response;
import com.hotelDeals.server.model.HotelDealData;
import com.hotelDeals.server.service.HotelDealService;

@Controller
public class HotelDealController {
	
	@Autowired
	HotelDealService hotelDealService;
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 *
	 * @param locale the locale
	 * @param model the model
	 * @param request the request
	 * @return the string
	 */
	@RequestMapping(value = "/")
	@ResponseBody
	public ModelAndView homeLogin() {
		List<HotelDealData> hotelDealsList = hotelDealService.getHotelDealsList();
		
		ModelAndView model= new ModelAndView("index");
		model.addObject("hotelDealsList", hotelDealsList);
		return model;
	}
	
}
