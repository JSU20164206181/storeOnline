/**
 * 
 */
package com.qst.pojo;

import java.io.Serializable;

import org.springframework.stereotype.Repository;

/**
 * @ClassName: ReceiveAddress.java
 * @version: v1.0.0
 * @author: ZYL
 * @date: 2019年8月9日 下午9:45:25
 * @Description: 该类的功能描述
 */
@Repository
public class ReceiveAddress implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5569386895153102297L;
	private int graId;
	private int graUid;
	private String graProvince;
	private String graCity;
	private String graDistrict;
	private String graStreet;
	private String graName;
	private String graPhone;

	/**
	 * 获取完整收货地址
	 * @return
	 */
	public String getCompleteAddress(){
         StringBuilder sb = new StringBuilder();
         sb.append(graProvince);
         sb.append(" "+graCity);
         if(this.graDistrict!=null) {
			 sb.append(" "+graDistrict);
			 if(this.graStreet!=null)
			 	sb.append(" "+graStreet);
		 }
         return sb.toString();
	}

	/**
	 * @return the graId
	 */
	public int getGraId() {
		return graId;
	}

	/**
	 * @param graId the graId to set
	 */
	public void setGraId(int graId) {
		this.graId = graId;
	}

	/**
	 * @return the graUid
	 */
	public int getGraUid() {
		return graUid;
	}

	/**
	 * @param graUid the graUid to set
	 */
	public void setGraUid(int graUid) {
		this.graUid = graUid;
	}

	/**
	 * @return the graProvince
	 */
	public String getGraProvince() {
		return graProvince;
	}

	/**
	 * @param graProvince the graProvince to set
	 */
	public void setGraProvince(String graProvince) {
		this.graProvince = graProvince;
	}

	/**
	 * @return the graCity
	 */
	public String getGraCity() {
		return graCity;
	}

	/**
	 * @param graCity the graCity to set
	 */
	public void setGraCity(String graCity) {
		this.graCity = graCity;
	}

	/**
	 * @return the graDistrict
	 */
	public String getGraDistrict() {
		return graDistrict;
	}

	/**
	 * @param graDistrict the graDistrict to set
	 */
	public void setGraDistrict(String graDistrict) {
		this.graDistrict = graDistrict;
	}

	/**
	 * @return the graStreet
	 */
	public String getGraStreet() {
		return graStreet;
	}

	/**
	 * @param graStreet the graStreet to set
	 */
	public void setGraStreet(String graStreet) {
		this.graStreet = graStreet;
	}

	/**
	 * @return the graName
	 */
	public String getGraName() {
		return graName;
	}

	/**
	 * @param graName the graName to set
	 */
	public void setGraName(String graName) {
		this.graName = graName;
	}

	/**
	 * @return the graPhone
	 */
	public String getGraPhone() {
		return graPhone;
	}

	/**
	 * @param graPhone the graPhone to set
	 */
	public void setGraPhone(String graPhone) {
		this.graPhone = graPhone;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "ReceiveAddress [graId=" + graId + ", graUid=" + graUid + ", graProvince=" + graProvince + ", graCity="
				+ graCity + ", graDistrict=" + graDistrict + ", graStreet=" + graStreet + ", graName=" + graName
				+ ", graPhone=" + graPhone + "]";
	}

}
