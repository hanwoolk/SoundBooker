package com.lec.soundbooker.dto;

import java.sql.Date;

public class UploadboardReplyDto {
	private		int		urnum;
	private		String	rid;
	private		String	urcontent;
	private		Date	urrdate;
	private		String	urip;
	private		int		unum;
	public UploadboardReplyDto() {}
	public UploadboardReplyDto(int urnum, String rid, String urcontent, Date urrdate, String urip, int unum) {
		this.urnum = urnum;
		this.rid = rid;
		this.urcontent = urcontent;
		this.urrdate = urrdate;
		this.urip = urip;
		this.unum = unum;
	}
	public int getUrnum() {
		return urnum;
	}
	public void setUrnum(int urnum) {
		this.urnum = urnum;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getUrcontent() {
		return urcontent;
	}
	public void setUrcontent(String urcontent) {
		this.urcontent = urcontent;
	}
	public Date getUrrdate() {
		return urrdate;
	}
	public void setUrrdate(Date urrdate) {
		this.urrdate = urrdate;
	}
	public String getUrip() {
		return urip;
	}
	public void setUrip(String urip) {
		this.urip = urip;
	}
	public int getUnum() {
		return unum;
	}
	public void setUnum(int unum) {
		this.unum = unum;
	}
	@Override
	public String toString() {
		return "UploadboardReplyDto [urnum=" + urnum + ", rid=" + rid + ", urcontent=" + urcontent + ", urrdate="
				+ urrdate + ", urip=" + urip + ", unum=" + unum + "]";
	}
	
}
