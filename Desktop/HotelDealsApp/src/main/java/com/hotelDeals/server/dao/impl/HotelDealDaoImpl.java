/** 
 * @file	HotelDealDaoImpl.java
 * @brief	HotelDealDaoImpl.java is used to create data access objects for hotel deals 
 *
 * @see	

 * @user yukti singhal
 *
 */
package com.hotelDeals.server.dao.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.hotelDeals.server.dao.HotelDealDao;
import com.hotelDeals.server.model.HotelDealData;
/**
 * @author yukti singhal
 * 
 */
@Repository
public class HotelDealDaoImpl implements HotelDealDao {

	@Cacheable("hotelDeals")
	public List<HotelDealData> getHotelDealsList(){

		StringBuffer output = new StringBuffer();
		try {
			URL url = new URL("http://deals.expedia.com/beta/deals/hotels.json");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Accept", "application/json");

			if (conn.getResponseCode() != 200) {
				throw new RuntimeException("Failed : HTTP error code : "
						+ conn.getResponseCode());
			}

			BufferedReader br = new BufferedReader(new InputStreamReader(
					(conn.getInputStream())));

			
			String data ;
			while ((data = br.readLine()) != null) {
				output.append(data);
			}

			conn.disconnect();

		} catch (MalformedURLException e) {

			e.printStackTrace();

		} catch (IOException e) {

			e.printStackTrace();

		}
	
		TypeToken<List<HotelDealData>> token = new TypeToken<List<HotelDealData>>(){};
		List<HotelDealData> hotelDealsList = new Gson().fromJson(output.toString(), token.getType());	
		return hotelDealsList;
	}
	

}
