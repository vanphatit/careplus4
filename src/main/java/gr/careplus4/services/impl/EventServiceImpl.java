package gr.careplus4.services.impl;

import gr.careplus4.entities.Event;
import gr.careplus4.repositories.EventRepository;
import gr.careplus4.services.iEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class EventServiceImpl implements iEventService {

    @Autowired
    EventRepository eventRepository;

    public EventServiceImpl(EventRepository eventRepository) {
        this.eventRepository = eventRepository;
    }

    @Override
    public void deleteById(String id) {
        eventRepository.deleteById(id);
    }

    @Override
    public List<Event> findAll() {
        return eventRepository.findAll();
    }

    @Override
    public Optional<Event> findByName(String name) {
        return eventRepository.findByNameLike(name);
    }

    @Override
    public <S extends Event> S save(S entity) {
        return eventRepository.save(entity);
    }

    @Override
    public Optional<Event> findById(String id) {
        return eventRepository.findById(id);
    }

    @Override
    public boolean existsByName(String name) {
        return eventRepository.existsByName(name);
    }

    @Override
    public boolean existsById(String id) {
        return eventRepository.existsById(id);
    }

    @Override
    public Page<Event> findAll(Pageable pageable) {
        return eventRepository.findAll(pageable);
    }

    @Override
    public Page<Event> findByNameContaining(String name, Pageable pageable) {
        return eventRepository.findByNameContaining(name, pageable);
    }

    @Override
    public Page<Event> findById(String id, Pageable pageable) {
        return eventRepository.findById(id, pageable);
    }

    @Override
    public List<Event> getActiveEvents(Date inputDate) {
        return eventRepository.findActiveEvents(inputDate);
    }

}
