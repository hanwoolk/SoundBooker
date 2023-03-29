package com.lec.soundbooker.dto;

public class RecTeamDto {
	private		String	rid;
	private		String	rpw;
	private		String	rname;
	private		String	rjob;
	private		int		pnum;
	public RecTeamDto() {}
	public RecTeamDto(String rid, String rname, String rjob) {
		this.rid = rid;
		this.rname = rname;
		this.rjob = rjob;
	}
	public RecTeamDto(String rid, String rpw, String rname, String rjob, int pnum) {
		this.rid = rid;
		this.rpw = rpw;
		this.rname = rname;
		this.rjob = rjob;
		this.pnum = pnum;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRpw() {
		return rpw;
	}
	public void setRpw(String rpw) {
		this.rpw = rpw;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public String getRjob() {
		return rjob;
	}
	public void setRjob(String rjob) {
		this.rjob = rjob;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	@Override
	public String toString() {
		return "RecTeamDto [rid=" + rid + ", rpw=" + rpw + ", rname=" + rname + ", rjob=" + rjob + ", pnum=" + pnum
				+ "]";
	}
	
}
