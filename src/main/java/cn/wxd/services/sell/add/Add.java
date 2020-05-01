package cn.wxd.services.sell.add;

import cn.wxd.DAO.BaseDAO;
import cn.wxd.entity.SellBillBodyVO;
import cn.wxd.entity.SellBillHeadVO;
import cn.wxd.utils.JDBCUtils;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
@WebServlet(name = "sell_add",urlPatterns = "/sell_add")
public class Add extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String jsonString = req.getParameter("json").substring(1,req.getParameter("json").length()-1);
        JSONObject jsonHead  = (JSONObject) JSON.parse(jsonString.substring(0,jsonString.indexOf("}",1)+1));
        JSONArray jsonBody  = (JSONArray) JSON.parse(jsonString.substring(jsonString.indexOf("}",1)+2,jsonString.length()));

        SellBillHeadVO headVO = new SellBillHeadVO();

        headVO.setBILL_MAKER((String) jsonHead.get("BILLMAKER"));
        headVO.setCREATIONTIME((String) jsonHead.get("CREATIONDATE"));
        headVO.setMONEY((String) jsonHead.get("MONEY"));
        headVO.setCUSTOMER((String) jsonHead.get("CUSTOMER"));
        headVO.setCUSTOMER_PHONE((String) jsonHead.get("CUSTOMER_PHONE"));
        headVO.setPK_SALE_HEAD((String) jsonHead.get("PK_SALE_HEAD"));
        headVO.setADDRESS((String) jsonHead.get("ADDRESS"));
        headVO.setROWCOUNT( String.valueOf(jsonHead.get("ROWCOUNT")));
        String result = JDBCUtils.saveVO(headVO);

        for(Object temp :jsonBody){
            SellBillBodyVO bodyVO = new SellBillBodyVO();
            JSONObject tempjson = (JSONObject)temp;
            bodyVO.setMATERIAL_NAME((String) tempjson.get("MATERIAL_NAME"));
            bodyVO.setDETAIL_NUM((String) tempjson.get("NUMBER"));
            bodyVO.setUNIT((String) tempjson.get("UNIT"));
            bodyVO.setPRICE((String) tempjson.get("PRICE"));
            bodyVO.setPK_SALE_HEAD((String) tempjson.get("PK_SALE_HEAD"));
            bodyVO.setPK_SALE_BODY((String) tempjson.get("PK_SALE_BODY"));
            bodyVO.setNOTE((String) tempjson.get("NOTE"));
            bodyVO.setMONEY(String.valueOf(tempjson.get("MONEY")));
            result += JDBCUtils.saveVO(bodyVO);
        }
        if(!result.contains("ORA")){
            resp.getWriter().write("SUCCESS");
        }else {
            resp.getWriter().write(result);
        }
    }
}
