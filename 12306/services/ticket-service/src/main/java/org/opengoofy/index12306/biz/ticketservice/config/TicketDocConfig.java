package org.opengoofy.index12306.biz.ticketservice.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import static org.springdoc.core.utils.Constants.SPRINGDOC_ENABLED;

@Configuration
@ConditionalOnProperty(name = SPRINGDOC_ENABLED, matchIfMissing = true)
public class TicketDocConfig {
    @Qualifier("ticketOpenApi")
    public OpenAPI ticketOpenApi() {
        return new OpenAPI().info(new Info().title("Shop API")
                .description("Shop API")
                .version("v1.0.0")
                .contact(new Contact()
                        .name("姓名")
                        .email("邮箱")));
    }
}
