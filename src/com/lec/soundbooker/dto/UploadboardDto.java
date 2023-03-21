package com.lec.soundbooker.dto;

import java.sql.Date;

public class UploadboardDto {
	private		int		unum;
	private		String	rid;
	private		String	utitle;
	private		String	ucontent;
	private		String	ufilename;
	private		Date	urdate;
	private		String	fip;
	private		String	ugroup;
	private		String	ustep;
	private		String	uindent;
	public UploadboardDto() {}
	public UploadboardDto(int unum, String rid, String utitle, String ucontent, String ufilename, Date urdate,
			String fip, String ugroup, String ustep, String uindent) {
		this.unum = unum;
		this.rid = rid;
		this.utitle = utitle;
		this.ucontent = ucontent;
		this.ufilename = ufilename;
		this.urdate = urdate;
		this.fip = fip;
		this.ugroup = ugroup;
		this.ustep = ustep;
		this.uindent = uindent;
	}
	public int getUnum() {
		return unum;
	}
	public void setUnum(int unum) {
		this.unum = unum;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getUtitle() {
		return utitle;
	}
	public void setUtitle(String utitle) {
		this.utitle = utitle;
	}
	public String getUcontent() {
		return ucontent;
	}
	public void setUcontent(String ucontent) {
		this.ucontent = ucontent;
	}
	public String getUfilename() {
		return ufilename;
	}
	public void setUfilename(String ufilename) {
		this.ufilename = ufilename;
	}
	public Date getUrdate() {
		return urdate;
	}
	public void setUrdate(Date urdate) {
		this.urdate = urdate;
	}
	public String getFip() {
		return fip;
	}
	public void setFip(String fip) {
		this.fip = fip;
	}
	public String getUgroup() {
		return ugroup;
	}
	public void setUgroup(String ugroup) {
		this.ugroup = ugroup;
	}
	public String getUstep() {
		return ustep;
	}
	public void setUstep(String ustep) {
		this.ustep = ustep;
	}
	public String getUindent() {
		return uindent;
	}
	public void setUindent(String uindent) {
		this.uindent = uindent;
	}
	@Override
	public String toString() {
		return "UploadboardDto [unum=" + unum + ", rid=" + rid + ", utitle=" + utitle + ", ucontent=" + ucontent
				+ ", ufilename=" + ufilename + ", urdate=" + urdate + ", fip=" + fip + ", ugroup=" + ugroup + ", ustep="
				+ ustep + ", uindent=" + uindent + "]";
	}
	
}
