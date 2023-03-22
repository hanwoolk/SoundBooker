package com.lec.soundbooker.dto;

import java.sql.Date;

public class UploadBoardDto {
	private		int		unum;
	private		String	rid;
	private		String	utitle;
	private		String	ucontent;
	private		String	ufilename;
	private		Date	urdate;
	private		String	uip;
	private		int	ugroup;
	private		int	ustep;
	private		int	uindent;
	public UploadBoardDto() {}
	public UploadBoardDto(int unum, String rid, String utitle, String ucontent, String ufilename, Date urdate,
			String uip, int ugroup, int ustep, int uindent) {
		this.unum = unum;
		this.rid = rid;
		this.utitle = utitle;
		this.ucontent = ucontent;
		this.ufilename = ufilename;
		this.urdate = urdate;
		this.uip = uip;
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
	public String getUip() {
		return uip;
	}
	public void setUip(String uip) {
		this.uip = uip;
	}
	public int getUgroup() {
		return ugroup;
	}
	public void setUgroup(int ugroup) {
		this.ugroup = ugroup;
	}
	public int getUstep() {
		return ustep;
	}
	public void setUstep(int ustep) {
		this.ustep = ustep;
	}
	public int getUindent() {
		return uindent;
	}
	public void setUindent(int uindent) {
		this.uindent = uindent;
	}
	@Override
	public String toString() {
		return "UploadboardDto [unum=" + unum + ", rid=" + rid + ", utitle=" + utitle + ", ucontent=" + ucontent
				+ ", ufilename=" + ufilename + ", urdate=" + urdate + ", uip=" + uip + ", ugroup=" + ugroup + ", ustep="
				+ ustep + ", uindent=" + uindent + "]";
	}
	
}
