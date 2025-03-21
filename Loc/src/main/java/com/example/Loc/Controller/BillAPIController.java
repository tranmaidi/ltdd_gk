package com.example.Loc.Controller;

import com.example.Loc.Modal.Response;
import com.example.Loc.Service.IBillDetailService;
import com.example.Loc.Service.IBillService;
import com.example.Loc.Service.ICategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/api/bill")
public class BillAPIController {
    @Autowired
    private IBillService billService;
    @Autowired
    private ICategoryService categoryService;
    @Autowired
    private IBillDetailService billDetailService;

    @GetMapping
    public ResponseEntity<?> getAllBill() {
        return new ResponseEntity<Response>(new Response(true, "Thành công",
                billService.findAll()), HttpStatus.OK);
    }

}
