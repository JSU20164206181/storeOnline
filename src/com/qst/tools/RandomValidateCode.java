package com.qst.tools;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * @Auther: CGL
 * @Date: 2019/7/29 20:51
 * @Description: 产生并绘制图片验证码
 */
public class RandomValidateCode {
    private static Random random = new Random();
    private static String randString = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";// 随机产生的字符串

    private static final int WIDTH = 100;
    private static final int HEIGHT = 30;
    private static final int LINE_SIZE = 40;
    private static final int STRING_NUM = 4;
    /*
     * 获得字体
     */
    private static Font getFont() {
        return new Font("Fixedsys", Font.CENTER_BASELINE, 20);
    }

    /*
     * 获得颜色
     */
    private static Color getRandColor(int fc, int bc) {
        if (fc > 255)
            fc = 255;
        if (bc > 255)
            bc = 255;
        int r = fc + random.nextInt(bc - fc - 16);
        int g = fc + random.nextInt(bc - fc - 14);
        int b = fc + random.nextInt(bc - fc - 18);
        return new Color(r, g, b);
    }

    /*
     * 绘制字符串
     */
    private static String drowString(Graphics g, String randomString, int i) {
        g.setFont(getFont());
        g.setColor(new Color(random.nextInt(101), random.nextInt(111), random.nextInt(121)));
        String rand = String.valueOf(getRandomString(random.nextInt(randString.length())));
        randomString += rand;
        g.translate(random.nextInt(3), random.nextInt(3));
        g.drawString(rand, 13 * i, 16);
        return randomString;
    }

    /*
     * 绘制干扰线
     */
    private static void drowLine(Graphics g) {
        int x = random.nextInt(WIDTH);
        int y = random.nextInt(HEIGHT);
        int xl = random.nextInt(13);
        int yl = random.nextInt(15);
        g.drawLine(x, y, x + xl, y + yl);
    }

    /*
     * 获取随机的字符
     */
    public static String getRandomString(int num) {
        return String.valueOf(randString.charAt(num));
    }

    /**
     * 生成随机图片
     * @throws IOException
     */
    public static Map<String, BufferedImage> getRandcode() throws IOException {

        // BufferedImage类是具有缓冲区的Image类,Image类是用于描述图像信息的类
        BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_BGR);
        Graphics g = image.getGraphics();// 产生Image对象的Graphics对象,改对象可以在图像上进行各种绘制操作
        g.fillRect(0, 0, WIDTH, HEIGHT);
        g.setFont(new Font("Times New Roman", Font.ROMAN_BASELINE, 20));
        g.setColor(getRandColor(110, 133));
        // 绘制干扰线
        for (int i = 0; i <= LINE_SIZE; i++) {
            drowLine(g);
        }
        // 绘制随机字符
        String randomString = "";
        for (int i = 1; i <= STRING_NUM; i++) {
            randomString = drowString(g, randomString, i);
        }

        g.dispose();
        Map<String,BufferedImage> map = new HashMap<String,BufferedImage>();
        map.put(randomString,image);
        return map;
    }

    public static InputStream getInputStream(BufferedImage image) throws IOException {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ImageIO.write(image, "jpg", bos);
        InputStream input = new ByteArrayInputStream(bos.toByteArray());
        return input;
    }
}
