package com.lec.soundbooker.dto;

import java.sql.Date;

public class FreeboardDto {
	private		int		fnum;
	private		String	mid;
	private		String	rid;
	private		String	ftitle;
	private		String	fcontent;
	private		Date	frdate;
	private		String	fip;
	public FreeboardDto() {}
	public FreeboardDto(int fnum, String mid, String rid, String ftitle, String fcontent, Date frdate, String fip) {
		this.fnum = fnum;
		this.mid = mid;
		this.rid = rid;
		this.ftitle = ftitle;
		this.fcontent = fcontent;
		this.frdate = frdate;
		this.fip = fip;
	}
	public int getFnum() {
		return fnum;
	}
	public void setFnum(int fnum) {
		this.fnum = fnum;
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
	public String getFtitle() {
		return ftitle;
	}
	public void setFtitle(String ftitle) {
		this.ftitle = ftitle;
	}
	public String getFcontent() {
		return fcontent;
	}
	public void setFcontent(String fcontent) {
		this.fcontent = fcontent;
	}
	public Date getFrdate() {
		return frdate;
	}
	public void setFrdate(Date frdate) {
		this.frdate = frdate;
	}
	public String getFip() {
		return fip;
	}
	public void setFip(String fip) {
		this.fip = fip;
	}
	@Override
	public String toString() {
		return "FreeboardDto [fnum=" + fnum + ", mid=" + mid + ", rid=" + rid + ", ftitle=" + ftitle + ", fcontent="
				+ fcontent + ", frdate=" + frdate + ", fip=" + fip + "]";
	}
	
}
