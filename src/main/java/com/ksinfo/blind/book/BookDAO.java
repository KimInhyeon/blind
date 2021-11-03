package com.ksinfo.blind.book;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

@Repository
public class BookDAO {
    @Inject
    SqlSession sqlSession;

    public String list_xml() {
        String result="";
        List<BookDTO> items=sqlSession.selectList("book.list");

        Element root = new Element("books");
        Document doc = new Document(root);
        doc.setRootElement(root);
        for(BookDTO dto : items){
            Element data = new Element("book");
            Element book_code = new Element("book_code");
            book_code.setText(dto.getBook_code()+"");
            Element book_name = new Element("book_name");
            book_name.setText(dto.getBook_name());
            Element press = new Element("press");
            press.setText(dto.getPress());
            Element price = new Element("price");
            price.setText(dto.getPrice()+"");
            Element amount = new Element("amount");
            amount.setText(dto.getAmount()+"");

            data.addContent(book_code);
            data.addContent(book_name);
            data.addContent(press);
            data.addContent(price);
            data.addContent(amount);
            data.addContent(data);
        }
        XMLOutputter xout = new XMLOutputter();
        Format f=xout.getFormat();
        f.setEncoding("utf-8");
        f.setIndent("\t");           //들여쓰기 옵션
        f.setLineSeparator("\r\n");  //줄바꾸기 옵션
        f.setTextMode(Format.TextMode.TRIM);
        xout.setFormat(f);
        result=xout.outputString(doc);
        return result;
    }

    public JSONObject list_json(){
        List<BookDTO> items = sqlSession.selectList("book.list");
        JSONObject jsonMain = new JSONObject();
        JSONArray jArray = new JSONArray();
        int count=0;
        for(BookDTO dto : items){
            JSONObject jsonObj = new JSONObject();
            jsonObj.put("book_code", dto.getBook_code() );
            jsonObj.put("book_code", dto.getBook_name() );
            jsonObj.put("book_code", dto.getPress() );
            jsonObj.put("book_code", dto.getPrice() );
            jsonObj.put("book_code", dto.getAmount() );
            jArray.add(count,jsonObj);
            count++;
        }
        jsonMain.put("sendData",jArray);
        return jsonMain;
    }

}
