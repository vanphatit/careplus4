package gr.careplus4.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "ReviewDetail")
public class ReviewDetail implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @JoinColumn(name = "IDReview", nullable = false)
    private Review review;

    @ManyToOne
    @JoinColumn(name = "IDMedicine", nullable = false)
    private Medicine medicine;

    @Column(name = "Text")
    private String text;

    @Column(name = "Rating", nullable = false)
    @DecimalMin("0.0")
    @DecimalMax("5.0")
    private float rating;
}