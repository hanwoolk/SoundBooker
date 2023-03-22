package com.lec.soundbooker.dto;

import java.sql.Date;

public class MemberDto {
	private		String	mid;
	private		String	mpw;
	private		String	mname;
	private		int		pnum;
	private		int		pnumreg;
	private		Date	mbirth;
	private		String	mgender;
	private		String	mphone;
	private		String	morigin;
	private		String	maddress;
	private		String	mdrive;
	private		String	mprefer1;
	private		String	mprefer2;
	private		String	mprefer3;
	private		int		rcnt;
	private		String	mbank;
	private		String	maccount;
	private		String	mactivate;
	private		String	pname;
	private		int		mpnum;
	public MemberDto(String mid, String mname, int pnumreg, Date mbirth, String mgender, String mphone, String morigin,
			String maddress, String mdrive, String mprefer1, String mprefer2, String mprefer3, int rcnt, String mbank,
			String maccount, String pname, int mpnum) {
		super();
		this.mid = mid;
		this.mname = mname;
		this.pnumreg = pnumreg;
		this.mbirth = mbirth;
		this.mgender = mgender;
		this.mphone = mphone;
		this.morigin = morigin;
		this.maddress = maddress;
		this.mdrive = mdrive;
		this.mprefer1 = mprefer1;
		this.mprefer2 = mprefer2;
		this.mprefer3 = mprefer3;
		this.rcnt = rcnt;
		this.mbank = mbank;
		this.maccount = maccount;
		this.pname = pname;
		this.mpnum = mpnum;
	}
	public MemberDto() {}
	public MemberDto(String mid, String mpw, String mname, int pnum, int pnumreg, Date mbirth, String mgender,
			String mphone, String morigin, String maddress, String mdrive, String mprefer1, String mprefer2,
			String mprefer3, int rcnt, String mbank, String maccount, String mactivate) {
		this.mid = mid;
		this.mpw = mpw;
		this.mname = mname;
		this.pnum = pnum;
		this.pnumreg = pnumreg;
		this.mbirth = mbirth;
		this.mgender = mgender;
		this.mphone = mphone;
		this.morigin = morigin;
		this.maddress = maddress;
		this.mdrive = mdrive;
		this.mprefer1 = mprefer1;
		this.mprefer2 = mprefer2;
		this.mprefer3 = mprefer3;
		this.rcnt = rcnt;
		this.mbank = mbank;
		this.maccount = maccount;
		this.mactivate = mactivate;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMpw() {
		return mpw;
	}
	public void setMpw(String mpw) {
		this.mpw = mpw;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public int getPnumreg() {
		return pnumreg;
	}
	public void setPnumreg(int pnumreg) {
		this.pnumreg = pnumreg;
	}
	public Date getMbirth() {
		return mbirth;
	}
	public void setMbirth(Date mbirth) {
		this.mbirth = mbirth;
	}
	public String getMgender() {
		return mgender;
	}
	public void setMgender(String mgender) {
		this.mgender = mgender;
	}
	public String getMphone() {
		return mphone;
	}
	public void setMphone(String mphone) {
		this.mphone = mphone;
	}
	public String getMorigin() {
		return morigin;
	}
	public void setMorigin(String morigin) {
		this.morigin = morigin;
	}
	public String getMaddress() {
		return maddress;
	}
	public void setMaddress(String maddress) {
		this.maddress = maddress;
	}
	public String getMdrive() {
		return mdrive;
	}
	public void setMdrive(String mdrive) {
		this.mdrive = mdrive;
	}
	public String getMprefer1() {
		return mprefer1;
	}
	public void setMprefer1(String mprefer1) {
		this.mprefer1 = mprefer1;
	}
	public String getMprefer2() {
		return mprefer2;
	}
	public void setMprefer2(String mprefer2) {
		this.mprefer2 = mprefer2;
	}
	public String getMprefer3() {
		return mprefer3;
	}
	public void setMprefer3(String mprefer3) {
		this.mprefer3 = mprefer3;
	}
	public int getRcnt() {
		return rcnt;
	}
	public void setRcnt(int rcnt) {
		this.rcnt = rcnt;
	}
	public String getMbank() {
		return mbank;
	}
	public void setMbank(String mbank) {
		this.mbank = mbank;
	}
	public String getMaccount() {
		return maccount;
	}
	public void setMaccount(String maccount) {
		this.maccount = maccount;
	}
	public String getMactivate() {
		return mactivate;
	}
	public void setMactivate(String mactivate) {
		this.mactivate = mactivate;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getMpnum() {
		return mpnum;
	}
	public void setMpnum(int mpnum) {
		this.mpnum = mpnum;
	}
	@Override
	public String toString() {
		return "MemberDto [mid=" + mid + ", mpw=" + mpw + ", mname=" + mname + ", pnum=" + pnum + ", pnumreg=" + pnumreg
				+ ", mbirth=" + mbirth + ", mgender=" + mgender + ", mphone=" + mphone + ", morigin=" + morigin
				+ ", maddress=" + maddress + ", mdrive=" + mdrive + ", mprefer1=" + mprefer1 + ", mprefer2=" + mprefer2
				+ ", mprefer3=" + mprefer3 + ", rcnt=" + rcnt + ", mbank=" + mbank + ", maccount=" + maccount + ", mactivate=" + mactivate +  "]";
	}
}
