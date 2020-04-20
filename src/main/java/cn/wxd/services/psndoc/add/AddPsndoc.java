package cn.wxd.services.psndoc.add;

import cn.wxd.entity.PsndocVO;
import cn.wxd.entity.UserVO;
import cn.wxd.utils.GlobleUtils;
import cn.wxd.utils.JDBCUtils;
import cn.wxd.utils.TokenUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@WebServlet(name="add",urlPatterns="/add_psndoc")
public class AddPsndoc extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JSONObject json  = JSON.parseObject(req.getParameter("json"));
        PsndocVO VO = new PsndocVO();
        VO.setSCHOOL((String)json.get("SCHOOL"));
        VO.setBIRTHDATE((String)json.get("BIRDAY"));
        VO.setBLOODTYPE((String)json.get("BLOOD"));
        VO.setPHONE((String)json.get("PHONE"));
        VO.setEDU((String)json.get("EDU"));
        VO.setID((String)json.get("ID"));
        VO.setIDTYPE("大陆身份证");
        VO.setSEX((String)json.get("SEX"));
        VO.setNAME((String)json.get("NAME"));
        VO.setJOB_CODE((String)json.get("JOB"));
        VO.setPK_PSNDOC("ry"+json.get("ID"));
        VO.setCREATOR(GlobleUtils.getCreatorCode(req));
        String result = JDBCUtils.saveVO(VO);
        UserVO userVO = new UserVO();
        userVO.setCUSERID("yh"+json.get("ID"));
        userVO.setDISABLEDATE(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        userVO.setPK_PSNDOC("ry"+json.get("ID"));
        userVO.setUSER_CODE((String)json.get("PHONE"));
        userVO.setUSER_NAME((String)json.get("NAME"));
        userVO.setUSER_PASSWORD("123456");
        userVO.setCREATOR(GlobleUtils.getCreatorCode(req));
        result = result+ JDBCUtils.saveVO(userVO);
        resp.getWriter().write(result);

    }


}
