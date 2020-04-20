package cn.wxd.utils;

import io.jsonwebtoken.Jwt;
import io.jsonwebtoken.Jwts;
import javax.crypto.spec.SecretKeySpec;
import java.security.Key;
import java.util.HashMap;
import java.util.Map;

public class TokenUtils {
    //tocken的解码key
    private static Key key = new SecretKeySpec(PropertiesUtils.propertiesMapReader("token").get("secret_key").getBytes(),"HmacSHA256");

    /**
     * 按照传入的用户code、用户name、用户code签发token
     * @param userInfo
     * @return 加密的用户信息
     */
    public static String createToken(Map userInfo){
        //token体的数据
        Map clasims = new HashMap<String,Object>();
        clasims.put("USER_CODE",userInfo.get("USER_CODE"));
        clasims.put("USER_NAME",userInfo.get("USER_NAME"));
        clasims.put("JOB_NAME",userInfo.get("JOB_NAME"));
        //token头的数据
        Map header = new HashMap<String,Object>();
        //加密算法
        header.put("alg","HS256");
        header.put("typ","JWT");
        //Issuer签发者
        return Jwts.builder().setSubject("123").setIssuer("wxd").addClaims(clasims).setHeader(header).signWith(key).compact();
    }

    /**  token解析
     *
     * @param token
     * @return
     */
    public static Jwt parseToken(String token){
        return Jwts.parser().setSigningKey(key).parse(token);
    }

    /**
     * 获取加密token的key值
     * @return
     */
    public static Key getKey(){
        return key;
    }
}
