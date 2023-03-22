package com.lec.soundbooker.dto;

import java.sql.Date;

public class FreeBoardCommentDto {
	private		int		frnum;
	private		String	mid;
	private		String	rid;
	private		String	frcontent;
	private		Date	frrdate;
	private		String	frip;
	private		int		fnum;
	public FreeBoardCommentDto() {}
	public FreeBoardCommentDto(int frnum, String mid, String rid, String frcontent, Date frrdate, String frip, int fnum) {
		this.frnum = frnum;
		this.mid = mid;
		this.rid = rid;
		this.frcontent = frcontent;
		this.frrdate = frrdate;
		this.frip = frip;
		this.fnum = fnum;
	}
	public int getFrnum() {
		return frnum;
	}
	public void setFrnum(int frnum) {
		this.frnum = frnum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getFrcontent() {
		return frcontent;
	}
	public void setFrcontent(String frcontent) {
		this.frcontent = frcontent;
	}
	public Date getFrrdate() {
		return frrdate;
	}
	public void setFrrdate(Date frrdate) {
		this.frrdate = frrdate;
	}
	public String getFrip() {
		return frip;
	}
	public void setFrip(String frip) {
		this.frip = frip;
	}
	public int getFnum() {
		return fnum;
	}
	public void setFnum(int fnum) {
		this.fnum = fnum;
	}
	@Override
	public String toString() {
		return "FreeBoardReplyDto [frnum=" + frnum + ", mid=" + mid + ", rid=" + rid + ", frcontent=" + frcontent
				+ ", frrdate=" + frrdate + ", frip=" + frip + ", fnum=" + fnum + "]";
	}
	
}
