package gr.careplus4.services;

import gr.careplus4.entities.BillDetail;
import gr.careplus4.entities.Medicine;

public interface iMedicineCopy {
    void copyMedicineFromBillDetails(Medicine currentMedicine, BillDetail billDetails);
}
