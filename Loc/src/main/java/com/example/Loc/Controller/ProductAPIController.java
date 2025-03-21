package com.example.Loc.Controller;


import com.example.Loc.Modal.Category;
import com.example.Loc.Modal.Product;
import com.example.Loc.Modal.Response;
import com.example.Loc.Service.ICategoryService;
import com.example.Loc.Service.IProductService;
import com.example.Loc.Service.IStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping(path = "/api/product")
public class ProductAPIController {
    @Autowired
    IProductService productService;
    @Autowired
    IStorageService storageService;
    @Autowired
    private ICategoryService categoryService;
    @GetMapping
    public ResponseEntity<?> getAllProducts() {
        return new ResponseEntity<Response>(new Response(true, "Thành công",
                productService.findAll()), HttpStatus.OK);
    }
    @PostMapping(path = "/getProduct")
    public ResponseEntity<?> getCategory(@Validated @RequestParam("id") Long id) {
        Optional<Product> product = productService.findById(id);
        if (product.isPresent()) {
            return new ResponseEntity<Response>(new Response(true, "Thành công",
                    product.get()), HttpStatus.OK);
        } else {
            return new ResponseEntity<Response>(new Response(false, "Thất bại", null), HttpStatus.NOT_FOUND);
        }
    }
    @PostMapping(path = "/addProduct")
    public ResponseEntity<?> addProduct(@Validated @RequestParam("productName") String categoryName,
                                         @Validated @RequestParam("price") Long price,
                                         @Validated @RequestParam("stockCount") Long stockCount,
                                         @Validated @RequestParam("image") MultipartFile image,
                                        @Validated @RequestParam("status") Short status
                                        ) {
        Product product = new Product();
        if (!image.isEmpty()) {
            UUID uuid = UUID.randomUUID();
            String uuString = uuid.toString();
            product.setImageUrl(storageService.getSorageFilename(image,
                    uuString));
            storageService.store(image, product.getImageUrl());
        }
        product.setProductName(categoryName);
        product.setPrice(price);
        product.setStockCount(stockCount);
        product.setStatus(status);
        productService.save(product);
        return new ResponseEntity<Response>(new Response(true, "Thêm Thành công", product), HttpStatus.OK);
    }
    @PutMapping(path = "/updateProduct")
    public ResponseEntity<?> updateProduct(@Validated @RequestParam("productID") Long productID,
                                           @Validated @RequestParam("categoryID") Long categoryID,
                                            @Validated @RequestParam("productName") String productName,
                                           @Validated @RequestParam("salesCount") Long stockCount,
                                           @Validated @RequestParam("soldCount") Long soldCount,
                                           @Validated @RequestParam("status") short status,
                                            @Validated @RequestParam("image") MultipartFile image) {
        Optional<Product> optProduct = productService.findById(productID);
        if (optProduct.isEmpty()) {
            return new ResponseEntity<Response>(new Response(false, "Không tìm thấy Product", null), HttpStatus.BAD_REQUEST);
        }else if(optProduct.isPresent()) {
//kiểm tra tồn tại file, lưu file
            if(!image.isEmpty()) {
                UUID uuid = UUID.randomUUID();
                String uuString = uuid.toString();
//lưu file vào trường Images
                optProduct.get().setImageUrl(storageService.getSorageFilename(image, uuString));
                storageService.store(image,
                        optProduct.get().getImageUrl());
            }
            if (categoryID!=null) {
                Optional<Category> category = categoryService.findById(categoryID);
                optProduct.get().setCategory(category.get());
            }
            if (stockCount<=0) {
                optProduct.get().setStatus((short) 2);
            }
            optProduct.get().setProductName(productName);
            optProduct.get().setStockCount(stockCount);
            optProduct.get().setSoldCount(soldCount);
            optProduct.get().setStatus(status);
            productService.save(optProduct.get());
            return new ResponseEntity<Response>(new
                    Response(true, "Cập nhật Thành công", optProduct.get()), HttpStatus.OK);
        }
        return null;
    }
    @DeleteMapping(path = "/deleteProduct")
    public ResponseEntity<?> deleteProduct(@Validated @RequestParam("productId") Long productID) {
        Optional<Product> optProduct = productService.findById(productID);
        if (optProduct.isEmpty()) {
            return new ResponseEntity<Response>(new Response(false, "Không tìm thấy Product", null), HttpStatus.BAD_REQUEST);
        }else if(optProduct.isPresent()) {
            optProduct.get().setStatus((short) 0);
            return new ResponseEntity<Response>(new Response(true, "Xóa Thành công", optProduct.get()), HttpStatus.OK);
        }
        return null;
    }

    @PostMapping(path = "/getProductsByCategoryID")
    public ResponseEntity<?> getProductsByID_Category(@Validated @RequestParam("categoryID") Long categoryID){
        List<Product> listProduct = productService.findByCategory_Id(categoryID);
        return new ResponseEntity<Response>(new Response(true, "Thành công", listProduct), HttpStatus.OK);
    }

    @PostMapping(path = "/getTopProductBestSell")
    public ResponseEntity<?> getTopProductBestSell(){
        List<Product> listProduct = productService.getTop10BestSellingProducts();
        return new ResponseEntity<Response>(new Response(true, "Thành công", listProduct), HttpStatus.OK);
    }

    @PostMapping(path = "/getPageNewProduct")
    public ResponseEntity<?> getPageNewProduct(@Validated @RequestParam("page") int page,
                                               @Validated @RequestParam("size") int size){
        Page<Product> pageProduct = productService.getRecentProducts( page,size);
        return new ResponseEntity<Response>(new Response(true, "Thành công", pageProduct), HttpStatus.OK);
    }
}
