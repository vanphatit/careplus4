package gr.careplus4.services;

import gr.careplus4.entities.BillDetail;
import gr.careplus4.entities.Medicine;
import gr.careplus4.entities.MedicineCopy;

import java.util.List;

public interface iMedicineCopy {
    void copyMedicineFromBillDetails(Medicine currentMedicine, BillDetail billDetails);

    MedicineCopy findMedicineCopyByBillDetail_Id(long billDetailId);

    MedicineCopy findMedicineCopyById(long id);
}
