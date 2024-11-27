package gr.careplus4.configs;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class CustomSiteMeshFilter extends ConfigurableSiteMeshFilter {
    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.addDecoratorPath("/*", "web.jsp")
                .addDecoratorPath("/user/*", "web.jsp")
                .addDecoratorPath("/admin/*", "admin.jsp")
                .addDecoratorPath("/au/*", "login-up.jsp")
                //.addExcludedPath("/au/*")
                .addExcludedPath("/v1/api/*")
                .addExcludedPath("assets/**")
                .addExcludedPath("css/**")
                .addExcludedPath("images/**")
                .addExcludedPath("js/**");
    }
}