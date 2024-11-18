package gr.careplus4.repositories;

import gr.careplus4.entities.Event;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
@Repository
public interface EventRepository extends JpaRepository<Event, String> {
    Optional<Event> findByNameLike(String name);
    Page <Event> findByNameContaining(String name, Pageable pageable);
    Page <Event> findById(String id, Pageable pageable);
    boolean existsByName(String name);
    boolean existsById(String id);

}
