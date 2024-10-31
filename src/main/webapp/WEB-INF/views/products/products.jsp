<%@ page import="com.ansbeno.entities.Product, java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Products</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/output.css">

</head>
<body>
  <%@ include file="/WEB-INF/fragments/nav.jsp" %>
  
  <div class="container mt-20 max-w-4xl mx-auto bg-white shadow-md rounded-lg p-6">
    <h1 class="text-2xl font-bold text-center mb-6 text-gray-800">
    <c:choose>
      <c:when test="${param.category != null && not empty param.category}">
        Products for category: <span class="text-teal-600">${param.category}</span>
      </c:when>
      <c:otherwise>All Products</c:otherwise>
    </c:choose>
    </h1>

    <!-- Create product Form -->
    <form action="products" method="post" enctype="multipart/form-data" class="space-y-4" >
      <div>
        <label class="block text-sm font-medium text-gray-700" for="productName" >Name</label>
        <input type="text" name="productName" 
               class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
               placeholder="Enter product name" />
      </div>
      
      <div>
        <label class="block text-sm font-medium text-gray-700" for="price">Price</label>
        <input type="text" name="price" 
               class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
               placeholder="Enter price" />
      </div>
      
      <div>
        <label class="block text-sm font-medium text-gray-700" for="quantity">Quantity</label>
        <input type="text" name="quantity" 
               class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
               placeholder="Enter quantity" />
      </div>

      <div>
        <label class="block text-sm font-medium text-gray-700" for="description">Description</label>
        <input type="text" name="description" 
               class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" 
               placeholder="Enter description" />
      </div>
      
      <div>
        <label class="block text-sm font-medium text-gray-700" for="image">Image</label>
        <input type="file" name="image" 
               class="w-full p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" />
      </div>

      <div>
      
      <select name="category" class="w-full h-full p-2 text-center">
        <option value="" ${param.category == null ? 'selected' : ''}>select category</option>
        <c:forEach var="category" items="${categories}">
          <option value="${category}" >${category}</option>
        </c:forEach>
      </select>
      
      </div>

      <button type="submit" 
              class="w-full bg-teal-600 text-white py-2 px-4 rounded-md hover:bg-teal-700 transition">Create</button>
    </form>

  </div>
   <!-- Search Form -->
    <div class="pt-9 pl-9 pr-9 pb-0 mt-6 flex gap-2">
      <form action="products" method="get" class="basis-9/12 flex space-x-2">
        <input type="text" name="keyword" placeholder="Search..."
                  value="${param.keyword}" 
               class="flex-1 p-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" />
        <button type="submit" 
                class="bg-teal-500 text-white px-4 py-2 rounded-md hover:bg-teal-600 transition">Search</button>
      </form>

      <form class="basis-3/12 flex space-x-2" action="products" method="get" onchange="this.submit()">
        <c:set var="categories" value="${sessionScope.categories}" />
        
      <select name="category" class="w-full text-center text-black">
      <option value="" ${param.category == null ? 'selected' : ''}>All categories</option>
        <c:forEach var="category" items="${categories}">
          <option value="${category}" 
            <c:if test="${param.category == category}">selected</c:if>>
            ${category}
          </option>
        </c:forEach>
      </select>

      </form>
    </div>
    <!-- Products Grid -->
    <div class="pt-9 pl-9 pr-9 pb-9 grid gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
      <c:forEach items="${products}" var="product">
        <div class="bg-white border border-gray-200 rounded-lg shadow-sm overflow-hidden">
          <img src="${product.getImage()}" alt="${product.getName()}" class="w-full h-48 object-cover" />
          <div class="p-4">
            <h3 class="text-lg font-semibold text-gray-800">${product.getName()}</h3>
            <p class="text-sm text-gray-600">${product.getDescription()}</p>
            <p class="text-teal-600 font-bold mt-2">Price: $${product.getPrice()}</p>
            <p class="text-gray-600">Quantity: ${product.getQuantity()}</p>
          </div>
          <div class="flex justify-between items-center p-4">
            <form action="products" method="post">
              <input name="deleteId" type="hidden" value="${product.id}" />
              <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded-md hover:bg-red-600 transition">Delete</button>
            </form>
          </div>
        </div>
      </c:forEach>
    </div>
</body>
</html>

