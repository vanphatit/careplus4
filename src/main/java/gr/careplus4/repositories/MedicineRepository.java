package gr.careplus4.repositories;

import gr.careplus4.entities.Medicine;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface MedicineRepository extends JpaRepository<Medicine, String>, JpaSpecificationExecutor<Medicine> {
    List<Medicine> findByNameContaining(String name); // Tìm kiếm theo tên thuốc
    List<Medicine> findByNameContaining(String name, Pageable pageable); // Tìm kiếm theo tên thuốc và phân trang

    List<Medicine> findByDescriptionContaining(String description); // Tìm kiếm theo mô tả
    List<Medicine> findByDescriptionContaining(String description, Pageable pageable); // Tìm kiếm theo mô tả và phân trang

    List<Medicine> findByUnitCostBetween(BigDecimal min, BigDecimal max); // Tìm kiếm theo giá thuốc
    List<Medicine> findByUnitCostBetween(BigDecimal min, BigDecimal max, Pageable pageable); // Tìm kiếm theo giá thuốc và phân trang

    List<Medicine> findByManufacturer_Name(String nameManufacture); // Tìm kiếm theo tên nhà sản xuất
    List<Medicine> findByManufacturer_Name(String nameManufacture, Pageable pageable); // Tìm kiếm theo tên nhà sản xuất và phân trang

    List<Medicine> findByCategory_Name(String nameCategory); // Tìm kiếm theo tên loại thuốc
    List<Medicine> findByCategory_Name(String nameCategory, Pageable pageable); // Tìm kiếm theo tên loại thuốc và phân trang

    List<Medicine> findByRatingBetween(BigDecimal min, BigDecimal max); // Tìm kiếm theo rating
    List<Medicine> findByRatingBetween(BigDecimal min, BigDecimal max, Pageable pageable); // Tìm kiếm theo rating và phân trang

    List<Medicine> findByStockQuantityBetween(Integer min, Integer max); // Tìm kiếm theo số lượng trong kho
    List<Medicine> findByStockQuantityBetween(Integer min, Integer max, Pageable pageable); // Tìm kiếm theo số lượng trong kho và phân trang

    List<Medicine> findByExpiryDateBetween(Date min, Date max); // Tìm kiếm theo ngày hết hạn
    List<Medicine> findByExpiryDateBetween(Date min, Date max, Pageable pageable); // Tìm kiếm theo ngày hết hạn và phân trang

    List<Medicine> findByImportDateBetween(Date min, Date max); // Tìm kiếm theo ngày nhập
    List<Medicine> findByImportDateBetween(Date min, Date max, Pageable pageable); // Tìm kiếm theo ngày nhập và phân trang

    Boolean existsByNameAndExpiryDateAndManufacturer_NameAndImportDate(String name, Date expiryDate, String manufacturerName, Date importDate); // Kiểm tra xem thuốc đã tồn tại chưa

    Optional<Medicine> findByNameAndExpiryDateAndManufacturer_NameAndImportDate(String name, Date expiryDate, String manufacturerName, Date importDate); // Tìm kiếm theo tên, ngày hết hạn, tên nhà sản xuất và ngày nhập

    List<Medicine> findByNameAndManufacturer_Name(String name, String manufacturerName); // Tìm kiếm theo tên, ngày hết hạn và tên nhà sản xuất

    List<Medicine> findMedicinesByNameAndManufacturer_NameAndDosage (String name, String manufacturerName, String dosage); // Tìm kiếm theo tên, tên nhà sản xuất và liều lượng

    Medicine findTopByOrderByIdDesc(); // Lấy ra co ID lớn nhất
}
