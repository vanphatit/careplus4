package gr.careplus4.repositories;

import gr.careplus4.entities.Import;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;
import java.util.Optional;
@Repository
public interface ImportRepository extends JpaRepository<Import, String> {
   // @EntityGraph(attributePaths = {"Provider"})
    Page<Import> findAll(Pageable pageable);
    Page<Import> findByIdContaining(String id, Pageable pageable);
    @Query("SELECT i FROM Import i WHERE i.provider.id = :providerId")
    Page<Import> findByProviderIdContaining(@Param("providerId") String providerId, Pageable pageable);
    List<Import> findImportByDate(java.sql.Date date);
    List<Import> findImportByDateBetween(java.sql.Date startDate, java.sql.Date endDate);
    Import findTopByOrderByIdDesc();
}
