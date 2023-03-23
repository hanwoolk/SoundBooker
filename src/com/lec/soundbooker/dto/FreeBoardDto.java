package com.lec.soundbooker.dto;

import java.sql.Date;

public class FreeBoardDto {
	private		int		fnum;
	private		String	mid;
	private		String	rid;
	private		String	ftitle;
	private		String	fcontent;
	private		Date	frdate;
	private		String	fip;
	private		int		fbCommentCnt;
	public FreeBoardDto(int fnum, String mid, String rid, String ftitle, String fcontent, Date frdate, String fip,
			int fbCommentCnt) {
		this.fnum = fnum;
		this.mid = mid;
		this.rid = rid;
		this.ftitle = ftitle;
		this.fcontent = fcontent;
		this.frdate = frdate;
		this.fip = fip;
		this.fbCommentCnt = fbCommentCnt;
	}
	public FreeBoardDto() {}
	public FreeBoardDto(int fnum, String mid, String rid, String ftitle, String fcontent, Date frdate, String fip) {
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
	public int getFbCommentCnt() {
		return fbCommentCnt;
	}
	public void setFbCommentCnt(int fbCommentCnt) {
		this.fbCommentCnt = fbCommentCnt;
	}
	@Override
	public String toString() {
		return "FreeBoardDto [fnum=" + fnum + ", mid=" + mid + ", rid=" + rid + ", ftitle=" + ftitle + ", fcontent="
				+ fcontent + ", frdate=" + frdate + ", fip=" + fip + "]";
	}
}
