package gr.careplus4.repositories;

import gr.careplus4.entities.Medicine;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

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

    Boolean existsByNameAndExpiryDateAndManufacturer_Name(String name, Date expiryDate, String manufacturerName); // Kiểm tra xem thuốc đã tồn tại chưa

}
