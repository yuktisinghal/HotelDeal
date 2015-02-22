/**
 * 
 */
package com.hotelDeals.common.model;

import java.awt.print.Book;
import java.util.ArrayList;
import java.util.List;

import com.hotelDeals.server.model.DropDown;

/**
 * @author yukti singhal
 * 
 */
public class ModelWrapper {

	List<DropDown> algoList = new ArrayList<DropDown>();
	List<DropDown> domainList = new ArrayList<DropDown>();
	List<DropDown> bookGenreList = new ArrayList<DropDown>();
	List<DropDown> movieGenreList = new ArrayList<DropDown>();
	int booklistSize;
	int listSize;
	String imagesPath;

	/**
	 * @return the algoList
	 */
	public List<DropDown> getAlgoList() {
		return algoList;
	}

	/**
	 * @param algoList
	 *            the algoList to set
	 */
	public void setAlgoList(List<DropDown> algoList) {
		this.algoList = algoList;
	}

	/**
	 * @return the domainList
	 */
	public List<DropDown> getDomainList() {
		return domainList;
	}

	/**
	 * @param domainList
	 *            the domainList to set
	 */
	public void setDomainList(List<DropDown> domainList) {
		this.domainList = domainList;
	}

	/**
	 * @return the bookGenreList
	 */
	public List<DropDown> getBookGenreList() {
		return bookGenreList;
	}

	/**
	 * @param bookGenreList
	 *            the bookGenreList to set
	 */
	public void setBookGenreList(List<DropDown> bookGenreList) {
		this.bookGenreList = bookGenreList;
	}

	/**
	 * @return the movieGenreList
	 */
	public List<DropDown> getMovieGenreList() {
		return movieGenreList;
	}

	/**
	 * @param movieGenreList
	 *            the movieGenreList to set
	 */
	public void setMovieGenreList(List<DropDown> movieGenreList) {
		this.movieGenreList = movieGenreList;
	}


	/**
	 * @return the booklistSize
	 */
	public int getBooklistSize() {
		return booklistSize;
	}

	/**
	 * @param booklistSize
	 *            the booklistSize to set
	 */
	public void setBooklistSize(int booklistSize) {
		this.booklistSize = booklistSize;
	}

	/**
	 * @return the listSize
	 */
	public int getListSize() {
		return listSize;
	}

	/**
	 * @param listSize
	 *            the listSize to set
	 */
	public void setListSize(int listSize) {
		this.listSize = listSize;
	}

	/**
	 * @return the imagesPath
	 */
	public String getImagesPath() {
		return imagesPath;
	}

	/**
	 * @param imagesPath
	 *            the imagesPath to set
	 */
	public void setImagesPath(String imagesPath) {
		this.imagesPath = imagesPath;
	}

}
