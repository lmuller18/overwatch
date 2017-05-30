package com.overwatch;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet for searching Overwatch players
 */
@WebServlet("/search")
public class SearchServlet  extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String username = request.getParameter("playerName");
    String playerCode = request.getParameter("playerCode");
    String region = request.getParameter("region");
    String platform = request.getParameter("platform");
    String view = request.getParameter("view");
    Overwatch overwatchPlayer = new Overwatch();
    Boolean valid = true;
    if(!overwatchPlayer.getPlayer(username, playerCode, region, platform)){
        request.setAttribute("notFound", true);
    } else {
        try{
            request.setAttribute("player", overwatchPlayer);
            request.setAttribute("searched", true);
            request.setAttribute("view", view);
        } catch (NullPointerException e){
            request.setAttribute("error", true);
            valid = false;
        }
    }
    request.getRequestDispatcher("/index.jsp").forward(request, response);
}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}