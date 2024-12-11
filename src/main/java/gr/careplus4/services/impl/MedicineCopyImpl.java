package gr.careplus4.services.impl;

import gr.careplus4.entities.BillDetail;
import gr.careplus4.entities.Medicine;
import gr.careplus4.entities.MedicineCopy;
import gr.careplus4.repositories.MedicineCopyRepository;
import gr.careplus4.services.iMedicineCopy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MedicineCopyImpl implements iMedicineCopy {

    @Autowired
    private MedicineCopyRepository medicineCopyRepository;

    @Override
    public void copyMedicineFromBillDetails(Medicine currentMedicine, BillDetail billDetails) {
        MedicineCopy saveMedicine = new MedicineCopy();
        saveMedicine.setName(currentMedicine.getName());
        saveMedicine.setDescription(currentMedicine.getDescription());
        saveMedicine.setUnitCost(currentMedicine.getUnitCost());
        saveMedicine.setExpiryDate(currentMedicine.getExpiryDate());
        saveMedicine.setStockQuantity(currentMedicine.getStockQuantity());
        saveMedicine.setDosage(currentMedicine.getDosage());
        saveMedicine.setRating(currentMedicine.getRating());
        saveMedicine.setImportDate(currentMedicine.getImportDate());
        saveMedicine.setImage(currentMedicine.getImage());
        saveMedicine.setManufacturerName(currentMedicine.getManufacturer().getName());
        saveMedicine.setCategoryName(currentMedicine.getCategory().getName());
        saveMedicine.setUnitName(currentMedicine.getUnit().getName());
        saveMedicine.setBillDetail(billDetails);
        this.medicineCopyRepository.save(saveMedicine);
    }
}
