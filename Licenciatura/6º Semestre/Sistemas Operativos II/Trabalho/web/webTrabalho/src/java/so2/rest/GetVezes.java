/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package so2.rest;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author joaoc
 */
public class GetVezes extends HttpServlet {
    
     NewJerseyClient client = new NewJerseyClient();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Delete</title>");
            out.println("<meta charset=\"UTF-8\">");
            out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            out.println("<link rel=\"stylesheet\" href=\"style.css\" type=\"text/css\"/>");
            out.println("</head>");
            out.println("<body>");
            out.println("<ul>");
            out.println("<li><a href=\"index.html\"><font size=\"5\">Menu</font></a></li>");
            out.println("<li><a href=\"Listar\"><font size=\"5\">Listar</font></a></li>");
            out.println("<li><a href=\"responder.html\"><font size=\"5\">Responder</font></a></li>");
            out.println("<li><a href=\"media.html\"><font size=\"5\">Consultar Média</font></a></li>");
            out.println("<li><a class=\"active\" href=\"#vezes\"><font size=\"5\">Consultar Vezes</font></a></li>");
            out.println("<li><a href=\"criar.html\"><font size=\"5\">Criar</font></a></li>");
            out.println("<li><a href=\"remover.html\"><font size=\"5\">Remover</font></a></li>");
            out.println("</ul>");
            out.println("<div Style=\"margin-left:25%; padding:1px 16px; height: 1000px;\">");
            out.println("<h1 align=\"center\">Vezes que os questionários foram respondidos</h1>");
            ListaQuest l = new ListaQuest();
            l = client.getQuestList_JSON(l.getClass());
            int i = 0;
            for(QuestImpl q : l.getLista()) {
                out.println("<p><font size=\"4\">" + q.getNome() + " foi respondido " + q.getPerg().get(0).getTotal() + "</font></p>");
                i++;
            }
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
