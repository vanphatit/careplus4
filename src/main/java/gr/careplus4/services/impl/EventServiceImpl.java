package gr.careplus4.services.impl;

import gr.careplus4.entities.Event;
import gr.careplus4.repositories.BillRepository;
import gr.careplus4.repositories.EventRepository;
import gr.careplus4.services.GeneratedId;
import gr.careplus4.services.iEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class EventServiceImpl implements iEventService {

    @Autowired
    EventRepository eventRepository;

    @Autowired
    BillRepository billRepository;

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
        if (entity.getId() == null || entity.getId().trim().isEmpty()) //Loại bỏ mọi khoảng trắng ở đầu và cuối chuỗi id.
        {
            Event lastEvent = findTopByOrderByIdDesc();
            String previousEventId = (lastEvent != null) ? lastEvent.getId() : "E000001";
            entity.setId(generateEventId(previousEventId));
        }
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

    @Override
    public String generateEventId(String previousId) {
        return GeneratedId.getGeneratedId(previousId);
    }

    @Override
    public Event findTopByOrderByIdDesc() {
        return eventRepository.findTopByOrderByIdDesc();

    }
    @Override
    public boolean checkUsed(String id){
        if(billRepository.existsByEventId(id)){
            return true;
        }
        return false;
    }

    @Override
    public Page<Event> findAllSorted(Pageable pageable) {
        Date now = new Date(); // Lấy ngày hiện tại
        List<Event> allEvents = eventRepository.findAll(); // Lấy toàn bộ sự kiện

        List<Event> sortedEvents = allEvents.stream()
                .sorted((e1, e2) -> {
                    boolean e1Ongoing = now.after(e1.getDateStart()) && now.before(e1.getDateEnd());
                    boolean e2Ongoing = now.after(e2.getDateStart()) && now.before(e2.getDateEnd());

                    if (e1Ongoing && !e2Ongoing) {
                        return -1; // e1 lên trước
                    } else if (!e1Ongoing && e2Ongoing) {
                        return 1; // e2 lên trước
                    } else {
                        return e1.getDateStart().compareTo(e2.getDateStart()); // Sắp xếp theo ngày bắt đầu
                    }
                })
                .collect(Collectors.toList());

        // Chuyển danh sách thành đối tượng Page
        int start = (int) pageable.getOffset();
        int end = Math.min((start + pageable.getPageSize()), sortedEvents.size());
        List<Event> pageContent = sortedEvents.subList(start, end);

        return new PageImpl<>(pageContent, pageable, sortedEvents.size());
    }

}
