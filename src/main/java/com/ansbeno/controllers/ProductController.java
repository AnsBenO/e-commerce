package com.ansbeno.controllers;

import java.io.IOException;
import java.util.List;

import com.ansbeno.entities.Category;
import com.ansbeno.entities.Product;
import com.ansbeno.services.CategoryService;
import com.ansbeno.services.ProductService;

import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/products")
public class ProductController extends HttpServlet {

      private final transient ProductService productService;
      private final transient CategoryService categoryService;

      @Inject
      public ProductController(ProductService productService, CategoryService categoryService) {
            this.productService = productService;
            this.categoryService = categoryService;
      }

      @Override
      protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                  String category = req.getParameter("category");
                  String keyword = req.getParameter("keyword");
                  HttpSession session = req.getSession();
                  List<Product> products;

                  if (req.getParameter("category") != null) {
                        products = productService.findByCategory(category);
                  } else if (keyword != null) {
                        products = productService.findByKeyword(keyword);
                  } else {
                        products = productService.findAll();
                  }

                  List<String> categories = categoryService.getNames();
                  session.setAttribute("categories", categories);
                  session.setAttribute("products", products);
                  RequestDispatcher dispatcher = getServletContext()
                              .getRequestDispatcher("/WEB-INF/views/products/products.jsp");

                  dispatcher.forward(req, resp);

            } catch (ServletException | IOException e) {
                  e.printStackTrace();
            }
      }

      @Override
      protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String idToDelete = req.getParameter("deleteId");
            String productName = req.getParameter("productName");

            try {
                  if (idToDelete != null) {
                        productService.deleteById(Long.parseLong(idToDelete));

                  } else if (productName != null) {
                        Product product = Product.builder()
                                    .name(productName)
                                    .price(Double.parseDouble(req.getParameter("price")))
                                    .description(req.getParameter("description"))
                                    .quantity(Integer.parseInt(req.getParameter("quantity")))
                                    .image(req.getParameter("image"))
                                    .build();

                        this.productService.save(product);

                  }

                  this.doGet(req, resp);
            } catch (NumberFormatException | ServletException | IOException e) {
                  e.printStackTrace();
            }

      }

}
