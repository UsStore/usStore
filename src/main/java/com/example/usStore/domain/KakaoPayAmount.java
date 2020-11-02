package com.example.usStore.domain;

import lombok.Data;
 
@Data
public class KakaoPayAmount {
 
    private Integer total, tax_free, vat, point, discount;
}