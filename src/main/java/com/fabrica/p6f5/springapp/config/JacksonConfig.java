package com.fabrica.p6f5.springapp.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.hibernate6.Hibernate6Module;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Configuración de Jackson para manejar correctamente los proxies de Hibernate
 * y evitar errores de serialización en el sistema de auditoría.
 */
@Configuration
public class JacksonConfig {

    @Bean("auditObjectMapper")
    public ObjectMapper objectMapper() {
        ObjectMapper mapper = new ObjectMapper();

        // Registrar módulo de Hibernate para manejar lazy loading
        Hibernate6Module hibernate6Module = new Hibernate6Module();

        // No serializar propiedades lazy que no están cargadas
        hibernate6Module.configure(Hibernate6Module.Feature.FORCE_LAZY_LOADING, false);

        // Serializar identificadores de entidades lazy
        hibernate6Module.configure(Hibernate6Module.Feature.SERIALIZE_IDENTIFIER_FOR_LAZY_NOT_LOADED_OBJECTS, true);

        mapper.registerModule(hibernate6Module);

        return mapper;
    }
}