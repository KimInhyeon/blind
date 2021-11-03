package com.ksinfo.blind.book;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.inject.Inject;

@Controller
public class BookController {
    @Inject
    BookDAO bookDAO;

    /*
    @RequestMapping("book_list.do")
    public String book_list_xml(Model model){
        String result = bookDAO.list_xml();
        model.addAttribute("result",result);
        return "book/list";
    }
    */

    @RequestMapping("book_list.do")
    public String book_list_xml(Model model){
        String result = bookDAO.list_xml();
        model.addAttribute("result",result);
        return "book/list";
    }

    @RequestMapping("book_list_json.do")
    @ResponseBody
    public JSONObject book_list_json(Model model){
        return bookDAO.list_json();
    }
}
/*
@Controller
public class BookController {
    @Inject
    BookDAO bookDAO;

    @RequestMapping("book_list.do")
    public String book_list_xml(Model model){
        String result = bookDAO.list_xml();
        model.addAttribute("result",result);
        return "book/list";
    }

    @RequestMapping("book_list_json.do")
    @ResponseBody
    public JSONObject book_list_json(Model model){
        return bookDAO.list_json();
    }
}
 */
