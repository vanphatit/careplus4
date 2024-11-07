package gr.careplus4.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategoryModel {
    private String id;
    private String name;
    private String parentCategoryId; // ID của danh mục cha nếu có
}
