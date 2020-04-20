package cn.wxd.crawl;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BangumiCrawl {
    public static void main(String args[]){
        System.out.println("helloworld");
        String url = "http://www.anitama.cn/bangumi";
        List<List<Map<String,Object>>> fengzhuang = bangumiCrawl(url);
        System.out.println(fengzhuang);
    }

    /**
     * 爬取指定url的内容
     * @param url
     * @return
     */
    public static List<List<Map<String,Object>>> bangumiCrawl(String url){

        Document html = new Crawl().getHTMLResourceByUrl(url);

        //存储所有信息，中间list为一天，map为一天之内不同的
        List<List<Map<String,Object>>> list = new ArrayList<>();
        //解析html，按照什么编码进行解析html

        Elements groupElement = html.getElementById("mainer").getElementsByClass("group");
        Elements groupAfterElement = html.getElementById("mainer").getElementsByClass("status-after");
        for (Element element : groupElement) {
            //判断group是否group status-after
            int flag = 0;
            for(Element element1 :groupAfterElement){
                if(element1.equals(element)){
                    flag=1;
                    break;
                }
            }
            if(flag==1){
                continue;
            }
            //存放某一天的信息
            List<Map<String,Object>> listT = new ArrayList<>();
            //从anitama获取的某一天的信息列表
            Elements itemElements = element.getElementsByClass("item");
            for (Element info :itemElements){
                Map<String,Object> map = new HashMap<>();
                map.put("date",element.getElementsByClass("month").get(0).text()+element.getElementsByClass("date").get(0).text());
                //获取动漫的图片
                String imgSrc = info.getElementsByClass("thumb").attr("data-background-image");
                //获取动漫名称
                String title = info.getElementsByClass("title").attr("title");
                //获取集数
                String desc = info.getElementsByClass("ep").text();
                //获取播放地址
                Elements playPlaces = info.getElementsByClass("area-bottom").get(0).getElementsByTag("p");
                for(int i =0;i<playPlaces.size();i++){
                    Element element1 = playPlaces.get(i);
                    String place = element1.text();
                    map.put("place"+i,place);
                }
                map.put("imgSrc", imgSrc);
                map.put("title",title);
                map.put("desc",desc);
                listT.add(map);
            }
            list.add(listT);
        }
        return list;
    }
}
