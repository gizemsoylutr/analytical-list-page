entity Orders {
    key purchaseOrder             : String(10);
        supplier                  : String(10);
        supplierName              : String(50);
        purchaseOrderItem         : String(5);
        material                  : String(10);
        materialDescription       : String(40);
        orderQuantity             : Decimal(13, 3);
        purchaseOrderQuantityUnit : String(3);
};
