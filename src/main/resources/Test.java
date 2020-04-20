import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

import java.io.IOException;
import java.util.*;

public class Test {
    public  static int two=0;
    public static void main(String[] args) {
/*        Key key = new SecretKeySpec(PropertiesUtils.allPropertiesMapReader("secret_key").getBytes(),"HmacSHA256");
        Key key1 = new SecretKeySpec(PropertiesUtils.propertiesMapReader("token").get("secret_key").getBytes(),"HmacSHA256");
        Key key2 = new SecretKeySpec("wu_xiao_dong_first_Base64_Blog_secret_key".getBytes(),"HmacSHA256");

        Scanner sca = new Scanner(System.in);
        System.out.println(sca.next());
        System.out.println(sca.next());
        while (sca.hasNext()){
            System.out.println(sca.toString());
        }*/
        String responseMsg = "";
        HttpClient httpClient = new HttpClient();
        PostMethod method = new PostMethod("http://localhost:9090/login");
        Header header = new Header();
        header.setName("contentType");
        header.setValue("text/html;charset=UTF-8");
        method.setRequestHeader(header);
        method.addParameter("requestBody", "123,123,123");
        method.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");
        method.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=" + "UTF-8");
        try
        {
            httpClient.executeMethod(method);
            responseMsg = method.getResponseBodyAsString().trim();
        } catch (HttpException e)
        {
            e.printStackTrace();
        } catch (IOException e)
        {
            e.printStackTrace();
        }finally
        {
            // 释放连接
            method.releaseConnection();
        }
    }

    private static long getmax(long a) {
        long r=a;
        for(int i=2;i<=a/2;i++){
            if(a%i==0){
                r=i;
            }
        }
        return r;
    }


    public static String createJWT() {
        //指定签名的时候使用的签名算法，也就是header那部分，jjwt已经将这部分内容封装好了。
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;

        //生成JWT的时间
        long nowMillis = System.currentTimeMillis();
        Date now = new Date(nowMillis);

        //创建payload的私有声明（根据特定的业务需要添加，如果要拿这个做验证，一般是需要和jwt的接收方提前沟通好验证方式的）
        Map<String, Object> claims = new HashMap<String, Object>();
        claims.put("id", "123");
        claims.put("username", "1223");
        claims.put("password", "122223");

        //生成签名的时候使用的秘钥secret,这个方法本地封装了的，一般可以从本地配置文件中读取，切记这个秘钥不能外露哦。它就是你服务端的私钥，在任何场景都不应该流露出去。一旦客户端得知这个secret, 那就意味着客户端是可以自我签发jwt了。
        String key = "122223";

        //生成签发人
        String subject = "122223";



        //下面就是在为payload添加各种标准声明和私有声明了
        //这里其实就是new一个JwtBuilder，设置jwt的body
        JwtBuilder builder = Jwts.builder()
                //如果有私有声明，一定要先设置这个自己创建的私有的声明，这个是给builder的claim赋值，一旦写在标准的声明赋值之后，就是覆盖了那些标准的声明的
                .setClaims(claims)
                //设置jti(JWT ID)：是JWT的唯一标识，根据业务需要，这个可以设置为一个不重复的值，主要用来作为一次性token,从而回避重放攻击。
                .setId(UUID.randomUUID().toString())
                //iat: jwt的签发时间t
                .setIssuedAt(now)
                //代表这个JWT的主体，即它的所有人，这个是一个json格式的字符串，可以存放什么userid，roldid之类的，作为什么用户的唯一标志。
                .setSubject(subject)
                //设置签名使用的签名算法和签名使用的秘钥
                .signWith(signatureAlgorithm, key);
        return builder.compact();
    }


    /**
     * Token的解密
     * @param token 加密后的token
     * @param user  用户的对象
     * @return
     */
    public static Claims parseJWT(String token, User user) {
        //签名秘钥，和生成的签名的秘钥一模一样
        String key = user.getPassword();

        //得到DefaultJwtParser
        Claims claims = Jwts.parser()
                //设置签名的秘钥
                .setSigningKey(key)
                //设置需要解析的jwt
                .parseClaimsJws(token).getBody();
        return claims;
    }


    /**
     * 校验token
     * 在这里可以使用官方的校验，我这里校验的是token中携带的密码于数据库一致的话就校验通过
     * @param token
     * @param user
     * @return
     */
    public static Boolean isVerify(String token, User user) {
        //签名秘钥，和生成的签名的秘钥一模一样
        String key = user.getPassword();

        //得到DefaultJwtParser
        Claims claims = Jwts.parser()
                //设置签名的秘钥
                .setSigningKey(key)
                //设置需要解析的jwt
                .parseClaimsJws(token).getBody();

        if (claims.get("password").equals(user.getPassword())) {
            return true;
        }

        return false;
    }
}
