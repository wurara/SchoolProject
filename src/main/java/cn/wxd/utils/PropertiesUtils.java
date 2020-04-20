package cn.wxd.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class PropertiesUtils {
    /**
     * 按照指定的文件名读取读取配置文件
     * @param name
     * @return
     */
    public static Map<String,String> propertiesMapReader(String name){
        java.util.Properties properties = new java.util.Properties();
        Map<String,String> propertiesMap = new HashMap<>();
        try {
            properties.load(new FileInputStream(GlobleUtils.getProjectRootPath()+"/src/main/resources/properties/"+name+".properties"));
            Enumeration<Object> enumeration =  properties.keys();
            while (enumeration.hasMoreElements()){
                Object s =enumeration.nextElement();
                propertiesMap.put(s.toString(),properties.getProperty(s.toString()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return propertiesMap;
    }

    /**
     * 读取所有的配置文件并从中找出传入的配置key
     * @param propertieesName
     * @return
     */
    public static String allPropertiesMapReader(String propertieesName){
        Properties metaproperties = new Properties();
        Properties properties = new Properties();
        String property = "";
        try {
            metaproperties.load(new FileInputStream(GlobleUtils.getProjectRootPath()+"/WEB-INF/classes/properties/metadata.properties"));
            String[] names = metaproperties.getProperty("names").split(",");
            for (String name:names){
                properties.load(new FileInputStream(GlobleUtils.getProjectRootPath()+"/WEB-INF/classes/properties"+name+".properties"));
                Enumeration<Object> enumeration =  properties.keys();
                while (enumeration.hasMoreElements()){
                    Object s =enumeration.nextElement();
                    if(s.toString().equals(propertieesName)){
                        property=properties.getProperty(s.toString());
                        break;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return property;
    }
}
