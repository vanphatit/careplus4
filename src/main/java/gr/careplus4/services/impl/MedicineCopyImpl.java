package gr.careplus4.services.impl;

import gr.careplus4.entities.BillDetail;
import gr.careplus4.entities.Medicine;
import gr.careplus4.entities.MedicineCopy;
import gr.careplus4.models.CustomMultipartFileForMedicine;
import gr.careplus4.repositories.MedicineCopyRepository;
import gr.careplus4.services.iMedicineCopy;
import gr.careplus4.ultilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Service;
import gr.careplus4.ultilities.Constants.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

@Service
public class MedicineCopyImpl implements iMedicineCopy {

    @Autowired
    private MedicineCopyRepository medicineCopyRepository;

    @Autowired
    private MedicineServicesImpl medicineServices;

    private CustomMultipartFileForMedicine customMultipartFileForMedicine = new CustomMultipartFileForMedicine();

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

        // Lay file anh tu thu muc thuoc
        MultipartFile file = customMultipartFileForMedicine.handleGetImageFile(currentMedicine.getImage(), Constants.MEDICINE_UPLOAD_DIR);

        String name = currentMedicine.getName() + "_MedicineCopy_" + billDetails.getId();

        String newFileInDir = medicineServices.handleSaveUploadImage(file, Constants.MEDICINE_UPLOAD_DIR, name);

        saveMedicine.setImage(newFileInDir);

        this.medicineCopyRepository.save(saveMedicine);
    }

    @Override
    public MedicineCopy findMedicineCopyByBillDetail_Id(long billDetailId) {
        return medicineCopyRepository.findMedicineCopyByBillDetail_Id(billDetailId);
    }

    @Override
    public MedicineCopy findMedicineCopyById(long id) {
        return medicineCopyRepository.findMedicineCopyById(id);
    }
}
