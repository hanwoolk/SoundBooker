package com.lec.soundbooker.dto;

import java.sql.Date;

public class ProjectDto {
	private		int		pnum;
	private		String	pname;
	private		Date	pstartdate;
	private		Date	penddate;
	private		int		pmember;
	private		int		pop;
	private		String	pcontent;
	private		Date	prdate;
	public ProjectDto() {}
	public ProjectDto(String pname, Date pstartdate, Date penddate, int pmember, int pop, String pcontent) {
		this.pname = pname;
		this.pstartdate = pstartdate;
		this.penddate = penddate;
		this.pmember = pmember;
		this.pop = pop;
		this.pcontent = pcontent;
	}
	public ProjectDto(int pnum, String pname, Date pstartdate, Date penddate, int pmember, int pop, String pcontent,
			Date prdate) {
		this.pnum = pnum;
		this.pname = pname;
		this.pstartdate = pstartdate;
		this.penddate = penddate;
		this.pmember = pmember;
		this.pop = pop;
		this.pcontent = pcontent;
		this.prdate = prdate;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public Date getPstartdate() {
		return pstartdate;
	}
	public void setPstartdate(Date pstartdate) {
		this.pstartdate = pstartdate;
	}
	public Date getPenddate() {
		return penddate;
	}
	public void setPenddate(Date penddate) {
		this.penddate = penddate;
	}
	public int getPmember() {
		return pmember;
	}
	public void setPmember(int pmember) {
		this.pmember = pmember;
	}
	public int getPop() {
		return pop;
	}
	public void setPop(int pop) {
		this.pop = pop;
	}
	public String getPcontent() {
		return pcontent;
	}
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	public Date getPrdate() {
		return prdate;
	}
	public void setPrdate(Date prdate) {
		this.prdate = prdate;
	}
	@Override
	public String toString() {
		return "ProjectDto [pnum=" + pnum + ", pname=" + pname + ", pstartdate=" + pstartdate + ", penddate=" + penddate
				+ ", pmember=" + pmember + ", pop=" + pop + ", pcontent=" + pcontent + ", prdate=" + prdate + "]";
	}
	
}
