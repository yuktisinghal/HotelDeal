/**
 * 
 */
package com.hotelDeals.server.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotelDeals.server.dao.HotelDealDao;
import com.hotelDeals.server.model.HotelDealData;
import com.hotelDeals.server.service.HotelDealService;

/**
 * @author yukti singhal
 *
 */
@Service
public class HotelDealServiceImpl implements HotelDealService {

	@Autowired
	HotelDealDao hotelDealDao;
	
	public List<HotelDealData> getHotelDealsList() {
		return hotelDealDao.getHotelDealsList();
	}

	
	
}
