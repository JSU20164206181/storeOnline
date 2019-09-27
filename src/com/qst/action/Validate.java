package com.qst.action;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class Validate{
       
	public static Map<String,BufferedImage> createImage(){
		/*
		 * 创建一个在缓存中的图像  其中width表示图像的宽度，
		 * height表示图像的高度，
		 * 最后一个参数表示图像字节灰度图像
		 */
		
		BufferedImage image=new BufferedImage(100, 30,BufferedImage.TYPE_INT_RGB);
		//获取画笔 对图像进行填充
		Graphics g=image.getGraphics();
		Random r=new Random();
		//设置颜色 随机产生颜色
		 g.setColor(new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255)));
		//指的是坐标 左上角的坐标 画一个矩形
	      g.fillRect(0,0, 100, 30);
	      
	      //获取验证码字符串
	      String number=getNumber(4);
	      
	      //设置字体的颜色和字体的大小
	      /*
	       *    Font.PLAIN（普通）
                Font.BOLD（加粗）
                Font.ITALIC（斜体）
                Font.BOLD+ Font.ITALIC（粗斜体） 
                                        第一个值为字体
                                        字后一个字体的大小
	       * 
	       */
	      g.setColor(new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255)));
	      g.setFont(new Font("",Font.BOLD+Font.ITALIC,25));
	      //将字符串写入  参照的坐标 是左下角的坐标 写的字符串的左下角的坐标
	       g.drawString(number, 5,25);
	       
	       //加干扰线 两个坐标构成一个参数
	       for(int i=0;i<6;i++){
	    	   g.setColor(new Color(r.nextInt(255),r.nextInt(255),r.nextInt(255)));
	    	   g.drawLine(r.nextInt(100), r.nextInt(30), r.nextInt(100), r.nextInt(30));
	       }
	       
	       Map<String,BufferedImage>map=new HashMap<String,BufferedImage>();
	       map.put(number, image);
	       return map;
	}
	
	  /*
	   * ByteArrayOutputStream
     * 字节数组输出流在内存中创建一个字节数组缓冲区，
     * 所有发送到输出流的数据保存在该字节数组缓冲区中。
     * 
     */
	
	  public static InputStream getInputStream(BufferedImage image) throws Exception{
		    ByteArrayOutputStream bos=new ByteArrayOutputStream();
		    JPEGImageEncoder en=JPEGCodec.createJPEGEncoder(bos);
		    en.encode(image);
		       
		     
		     //创建一个新分配的字节数组。数组的大小和当前输出流的大小，内容是当前输出流的拷贝。
		       byte[] bts=bos.toByteArray();
		       ByteArrayInputStream bis=new ByteArrayInputStream(bts);
		  return bis;
	  }
	
	   public static  String getNumber(int n){
		   
		    String str="0123456789";
		      Random r=new Random();
		       String ss="";
		       for(int i=0;i<n;i++){
		    	 char c=str.charAt(r.nextInt(str.length()));
		    	 ss=ss+c;
		       }
		   return ss;
	   }

}

