package gr.careplus4.services;

import gr.careplus4.entities.Event;
import gr.careplus4.entities.Provider;
import gr.careplus4.models.EventModel;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public interface iEventService {

    void deleteById(String id);

    List<Event> findAll();

    Optional<Event> findByName(String name);

    <S extends Event> S save(S entity);

    Optional<Event> findById(String id);

    boolean existsByName(String name);

    boolean existsById(String id);

    Page<Event> findAll(Pageable pageable);

    Page<Event> findByNameContaining(String name, Pageable pageable);

    Page<Event> findById(String id, Pageable pageable);

    List<Event> getActiveEvents(Date inputDate);

    String generateEventId(String previousId);

    Event findTopByOrderByIdDesc ();

    public boolean checkUsed(String id);
}
