package com.ansbeno.controllers;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;

import com.ansbeno.dao.CategoryDao;
import com.ansbeno.dao.ProductDao;
import com.ansbeno.entities.Category;
import com.ansbeno.entities.Product;

import jakarta.inject.Inject;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet("/products")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
            maxFileSize = 1024 * 1024 * 10, // 10 MB
            maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class ProductController extends HttpServlet {

      private final transient ProductDao productDao;
      private final transient CategoryDao categoryDao;

      @Inject
      public ProductController(ProductDao productDao, CategoryDao categoryDao) {
            this.productDao = productDao;
            this.categoryDao = categoryDao;
      }

      @Override
      protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            try {
                  String category = req.getParameter("category");
                  String keyword = req.getParameter("keyword");
                  HttpSession session = req.getSession();
                  List<Product> products;

                  if (category != null && !"".equals(category)) {
                        products = productDao.findByCategory(category);
                  } else if (keyword != null) {
                        products = productDao.findByKeyword(keyword);
                  } else {
                        products = productDao.findAll();
                  }

                  List<String> categories = categoryDao.getNames();
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
                        productDao.deleteById(Long.parseLong(idToDelete));

                  } else if (productName != null) {
                        Optional<Category> category = categoryDao.findByName(req.getParameter("category"));
                        Part imagePart = req.getPart("image");
                        String imageFileName = imagePart != null
                                    ? Paths.get(imagePart.getSubmittedFileName()).getFileName().toString()
                                    : null;

                        // Define the upload path
                        String uploadFilePath = getServletContext().getRealPath("") + File.separator + "images"
                                    + File.separator
                                    + "products";

                        // Create the directory if it doesn't exist
                        File uploadDir = new File(uploadFilePath);
                        if (!uploadDir.exists()) {
                              log.info("Creating upload directory at: {}", uploadFilePath);
                              uploadDir.mkdirs();
                        }

                        if (imagePart != null && imageFileName != null) {
                              String imagePath = uploadFilePath + File.separator + imageFileName;
                              log.debug("Saving image file at: {}", imagePath);
                              // Save image
                              this.saveUploadedImage(imagePath, imagePart);
                        }

                        Product product = Product.builder()
                                    .name(productName)
                                    .price(Double.parseDouble(req.getParameter("price")))
                                    .description(req.getParameter("description"))
                                    .quantity(Integer.parseInt(req.getParameter("quantity")))
                                    .image("images"
                                                + File.separator
                                                + "products" + File.separator + imageFileName)
                                    .category(category.orElse(null))
                                    .build();
                        log.info("Saving new product: {}", product);
                        this.productDao.save(product);
                  }

                  this.doGet(req, resp);
            } catch (NumberFormatException | ServletException | IOException e) {
                  e.printStackTrace();
            }

      }

      private void saveUploadedImage(String imagePath, Part imagePart) throws IOException {
            try (InputStream inputStream = imagePart.getInputStream();
                        FileOutputStream outputStream = new FileOutputStream(imagePath)) {

                  byte[] buffer = new byte[1024];
                  int bytesRead;
                  while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                  }

                  log.debug("Successfully saved image file at: {}", imagePath);
            } catch (IOException e) {
                  log.error("Failed to save image file at: {}", imagePath, e);
                  throw e;
            }
      }

}
