package servlets;

import java.util.*;

public class OrderDetail {

    private List<Integer> bookIds;
	private List<Double> price;
	private List<Integer> quantity;

	public OrderDetail(List<Integer> bookId, double price, int quantity) {
        this.bookIds = new ArrayList<>();
        this.price = new ArrayList<>();
        this.quantity = new ArrayList<>();
	}

	public OrderDetail() {
	}

	public List<Integer> getBookIds() {
		return bookIds;
	}

	public void setBookIds(List<Integer> bookIds) {
		this.bookIds = bookIds;
	}

	public List<Double> getPrice() {
		return price;
	}

	public void setPrice(List<Double> price) {
		this.price = price;
	}

	public List<Integer> getQuantity() {
		return quantity;
	}

	public void setQuantity(List<Integer> quantity) {
		this.quantity = quantity;
	}




}
