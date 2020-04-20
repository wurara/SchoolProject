package cn.wxd.crawl;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

public class Crawl {

    //获取html的document对象
    public static Document getHTMLResourceByUrl(String url){
        boolean flag = true;
        //最终返回的爬取页面的document对象
        Document parse = new Document(url);
        //页面内容的StringBuffer
        StringBuffer sb = new StringBuffer();
        //页面编码
        String encoding ="utf8";
        //爬取地址
        URL urlObj =null;
        URLConnection openConnection =null;
        InputStreamReader isr = null;
        BufferedReader br = null;
        try {
            urlObj = new URL(url);
            openConnection = urlObj.openConnection();
            encoding = (openConnection.getContentType().split("="))[1];
            isr = new InputStreamReader(openConnection.getInputStream(),encoding);
            //建立文件缓冲流
            br = new BufferedReader(isr);
            //建立临时文件
            String temp = null;
            while((temp=br.readLine())!=null){
                sb.append(temp+"\n");
            }
        } catch (MalformedURLException e) {
            System.out.println("error message"+e);
            flag=false;
        } catch (IOException e) {
            System.out.println("error message"+e);
            flag=false;
        }finally{
            try {
                if(isr !=null){
                    isr.close();
                }
            } catch (IOException e) {
                System.out.println("error message"+e);
            }
        }
        if(flag==true){
            parse = Jsoup.parse(sb.toString(),encoding);
        }
        return parse;
    }
}
