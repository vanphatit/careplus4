package gr.careplus4.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Review")
public class Review implements Serializable {

    @Id
    @Column(name = "ID", length = 7)
    private String id;

    @ManyToOne
    @JoinColumn(name = "PhoneNumber", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "IDBill", nullable = false)
    private Bill bill;

    @Column(name = "Date", nullable = false)
    private Date date;
}