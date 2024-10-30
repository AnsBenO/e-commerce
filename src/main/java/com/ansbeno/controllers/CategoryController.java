package com.ansbeno.controllers;

import java.io.IOException;
import java.util.List;

import com.ansbeno.entities.Category;
import com.ansbeno.services.CategoryService;

import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/categories")
public class CategoryController extends HttpServlet {

      private final transient CategoryService categoryService;

      @Inject
      public CategoryController(CategoryService categoryService) {
            this.categoryService = categoryService;
      }

      @Override
      protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

            try {
                  String keyword = req.getParameter("keyword");
                  List<Category> categories = keyword == null
                              ? categoryService.findAll()
                              : categoryService.findByKeyword(keyword);

                  HttpSession session = req.getSession();
                  session.setAttribute("categories", categories);
                  RequestDispatcher dispatcher = getServletContext()
                              .getRequestDispatcher("/WEB-INF/views/categories/categories.jsp");

                  dispatcher.forward(req, resp);
            } catch (IOException | IllegalStateException e) {
                  e.printStackTrace();
            }

      }

      @Override
      protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                  String idToDelete = req.getParameter("deleteId");
                  String categoryName = req.getParameter("categoryName");
                  if (idToDelete != null) {
                        categoryService.deleteById(Long.parseLong(idToDelete));
                  } else if (categoryName != null) {
                        Category category = Category.builder()
                                    .name(categoryName)
                                    .description(req.getParameter("description"))
                                    .build();
                        this.categoryService.save(category);
                  }

                  this.doGet(req, resp);

            } catch (NumberFormatException | IOException | ServletException e) {
                  e.printStackTrace();
            }
      }

}
