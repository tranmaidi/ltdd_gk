package com.example.Loc.Controller;

import com.example.Loc.Modal.Account;
import com.example.Loc.Modal.OTP_Token;
import com.example.Loc.Modal.Response;
import com.example.Loc.Service.IAccountService;
import com.example.Loc.Service.IEmailService;
import com.example.Loc.Service.IOTP_TokenService;
import com.example.Loc.Untils.EmailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.xml.crypto.Data;
import java.util.Date;
import java.util.Optional;

@RestController
@RequestMapping(path = "/api/otp_token")
public class OTP_TokenController {
    @Autowired
    EmailUtil emailUtil;
    @Autowired
    IEmailService iEmailService;
    @Autowired
    IAccountService iAccountService;
    @Autowired
    IOTP_TokenService iotpTokenService;
    @GetMapping
    public ResponseEntity<?> getAllProducts() {
        return new ResponseEntity<Response>(new Response(true, "Thành công",
                iotpTokenService.findAll()), HttpStatus.OK);
    }
    @PostMapping(path = "/sendOTP_CreateAccount")
    public ResponseEntity<?> sendOTP_Create(
            @Validated @RequestParam("email") String email
    ){
        String OTP =iotpTokenService.gen_OTP(5);
        Optional<Account> account = iAccountService.findByEmail(email);
        if (account.isEmpty()){
            return new ResponseEntity<Response>(new Response(false, "Khong tim thay tai khoan", null), HttpStatus.BAD_REQUEST);
        }
        if (account.get().getAccount_status()!=0L){
            return new ResponseEntity<Response>(new Response(false, "Tai khoan nay dang hoa dong", null), HttpStatus.BAD_REQUEST);
        }
        OTP_Token token = new OTP_Token();
        Date now = new Date();
        long expiresInMillis = now.getTime() + 10 * 60 * 1000;
        OTP_Token otpToken = new OTP_Token();
        otpToken.setIdAccount(account.get().getId());
        otpToken.setOtp_code(OTP);
        otpToken.setCreated_at(now);
        otpToken.setExpires_at(new Date(expiresInMillis));
        otpToken.setType(1L);
        otpToken.set_verified(false);
        iotpTokenService.save(otpToken);
        iEmailService.SentOTP_Confirm(email,OTP);
        return new ResponseEntity<Response>(new Response(true
                , "Gui Thanh Cong", account.get()), HttpStatus.OK);
    }

    @PostMapping(path = "/sendOTP_Reset")
    public ResponseEntity<?> sendOTP_Reset(
            @Validated @RequestParam("email") String email
    ){
        String OTP =iotpTokenService.gen_OTP(5);
        Optional<Account> account = iAccountService.findByEmail(email);
        if (account.isEmpty()){
            return new ResponseEntity<Response>(new Response(false, "Khong tim thay tai khoan", null), HttpStatus.BAD_REQUEST);
        }
        if (account.get().getAccount_status()!=1L){
            return new ResponseEntity<Response>(new Response(false, "Tai khoan nay khong hoa dong", null), HttpStatus.BAD_REQUEST);
        }
        OTP_Token token = new OTP_Token();
        Date now = new Date();
        long expiresInMillis = now.getTime() + 10 * 60 * 1000;
        OTP_Token otpToken = new OTP_Token();
        otpToken.setIdAccount(account.get().getId());
        otpToken.setOtp_code(OTP);
        otpToken.setCreated_at(now);
        otpToken.setExpires_at(new Date(expiresInMillis));
        otpToken.setType(2L);
        otpToken.set_verified(false);
        iotpTokenService.save(otpToken);
        iEmailService.SendOTP_ResetPassword(email,OTP);
        return new ResponseEntity<Response>(new Response(true
                , "Gui Thanh Cong", account.get()), HttpStatus.OK);
    }
    @PostMapping(path = "/comfirm_OTP")
    public ResponseEntity<?> verifyOTP_comfirm_create(
            @Validated @RequestParam("idAccount") Long idAccount,
            @Validated @RequestParam("otp") String otp
    ){
        Optional<Account> account = iAccountService.findById(idAccount);
        if (account.isEmpty()){
            return new ResponseEntity<Response>(new Response(false
                    , "Không tìm thấy Account", account.get()), HttpStatus.OK);
        }
        if (iotpTokenService.verifyOTP(idAccount,otp)){
            account.get().setAccount_status(1L);
            iAccountService.save(account.get());
            return new ResponseEntity<Response>(new Response(true
                    , "Xác thực thành công", account.get()), HttpStatus.OK);
        }
        return new ResponseEntity<Response>(new Response(false
                , "Xác sai mã OTP", account.get()), HttpStatus.OK);
    }
    @PostMapping(path = "/reset_OTP")
    public ResponseEntity<?> verifyOTP_resetPassword(
            @Validated @RequestParam("idAccount") Long idAccount,
            @Validated @RequestParam("otp") String otp
    ){
        Optional<Account> account = iAccountService.findById(idAccount);
        if (account.isEmpty()){
            return new ResponseEntity<Response>(new Response(false
                    , "Không tìm thấy Account", account.get()), HttpStatus.OK);
        }
        if (iotpTokenService.verifyOTP_reset(idAccount,otp)){
            return new ResponseEntity<Response>(new Response(true
                    , "Xác thực thành công", account.get()), HttpStatus.OK);
        }
        return new ResponseEntity<Response>(new Response(false
                , "Xác sai mã OTP", account.get()), HttpStatus.OK);
    }
}
