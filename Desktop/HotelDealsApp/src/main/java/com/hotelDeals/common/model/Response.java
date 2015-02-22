/** 
 *

 * @user y.singhal
 * 
 */
package com.hotelDeals.common.model;

import java.util.List;


/**
 * The Class Response is used to create structure for response from server.
 *
 * @param <T> the generic type
 * @user y.singhal
 *
 */
public class Response<T> {

	/** The count. */
	private int count;
    
    /** The data. */
    private List<T> data;
    
    

    /**
     * Instantiates a new response.
     *
     * @param count the count
     * @param data the data
     */
    public Response(int count, List<T> data) {
        this.count = count;
        this.data = data;
    }

	/**
	 * Gets the count.
	 *
	 * @return the count
	 */
	public int getCount() {
		return count;
	}

	/**
	 * Sets the count.
	 *
	 * @param count the new count
	 */
	public void setCount(int count) {
		this.count = count;
	}

	/**
	 * Gets the data.
	 *
	 * @return the data
	 */
	public List<T> getData() {
		return data;
	}

	/**
	 * Sets the data.
	 *
	 * @param data the new data
	 */
	public void setData(List<T> data) {
		this.data = data;
	}  

}