-- Migration V11: Insert Sample Data for Invoice System
-- This migration adds sample data to test the invoice, shipment, and audit microservices

-- ============================================
-- SHIPMENTS - 4 sample records
-- ============================================

INSERT INTO shipments (client_name, origin_address, destination_address, total_weight, total_volume, shipment_status, tracking_number, created_by, created_at, updated_at)
VALUES
    ('Acme Corporation', 'Calle 50 #123, Medellín, Antioquia', 'Carrera 7 #45-67, Bogotá, Cundinamarca', 150.50, 2.35, 'DELIVERED', 'TRK-2024-001', 1, '2024-01-15 08:30:00', '2024-01-20 14:45:00'),
    ('Tech Solutions SAS', 'Avenida El Poblado #234, Medellín', 'Calle 100 #18-90, Barranquilla, Atlántico', 85.75, 1.20, 'IN_TRANSIT', 'TRK-2024-002', 1, '2024-01-18 10:15:00', '2024-01-18 10:15:00'),
    ('Distribuidora del Valle', 'Carrera 5 #78-12, Cali, Valle del Cauca', 'Avenida 19 #104-55, Cali, Valle del Cauca', 220.00, 4.50, 'PENDING', 'TRK-2024-003', 2, '2024-01-22 09:00:00', '2024-01-22 09:00:00'),
    ('Importadora Andina Ltda', 'Zona Franca, Cartagena, Bolívar', 'Calle 72 #10-34, Manizales, Caldas', 500.25, 8.75, 'PROCESSING', 'TRK-2024-004', 2, '2024-01-25 11:30:00', '2024-01-26 08:20:00');

-- ============================================
-- INVOICES - 4 sample records
-- ============================================

INSERT INTO invoices (fiscal_folio, invoice_number, client_name, client_nit, client_address, client_email, invoice_date, due_date, payment_method, subtotal, tax_amount, total_amount, currency, invoice_status, pdf_url, observations, created_by, created_at, updated_at, version)
VALUES
    ('FE-2024-000001', 'INV-2024-0001', 'Acme Corporation', '900123456-1', 'Calle 50 #123, Medellín, Antioquia', 'facturacion@acmecorp.com', '2024-01-20', '2024-02-20', 'TRANSFERENCIA BANCARIA', 2500000.00, 475000.00, 2975000.00, 'COP', 'ISSUED', 'https://storage.example.com/invoices/2024/INV-2024-0001.pdf', 'Factura por servicio de transporte completado', 1, '2024-01-20 15:00:00', '2024-01-20 15:00:00', 1),
    ('FE-2024-000002', 'INV-2024-0002', 'Tech Solutions SAS', '900234567-2', 'Avenida El Poblado #234, Medellín', 'cuentaspagar@techsolutions.co', '2024-01-18', '2024-02-18', 'EFECTIVO', 1800000.00, 342000.00, 2142000.00, 'COP', 'PAID', 'https://storage.example.com/invoices/2024/INV-2024-0002.pdf', 'Pago recibido el 2024-01-25', 1, '2024-01-18 16:30:00', '2024-01-25 10:00:00', 2),
    ('FE-2024-000003', 'INV-2024-0003', 'Distribuidora del Valle', '900345678-3', 'Carrera 5 #78-12, Cali, Valle del Cauca', 'contabilidad@distvalle.com', '2024-01-22', '2024-02-22', 'EFECTIVO', 3200000.00, 608000.00, 3808000.00, 'COP', 'ISSUED', NULL, 'Envío pendiente de despacho', 2, '2024-01-22 09:45:00', '2024-01-22 09:45:00', 1),
    (NULL, 'INV-2024-0004', 'Importadora Andina Ltda', '900456789-4', 'Zona Franca, Cartagena, Bolívar', 'finanzas@impandina.com.co', '2024-01-26', '2024-02-26', 'TRANSFERENCIA BANCARIA', 5500000.00, 1045000.00, 6545000.00, 'COP', 'DRAFT', NULL, 'Borrador - Pendiente de revisión y aprobación', 2, '2024-01-26 14:20:00', '2024-01-26 14:20:00', 1);

-- ============================================
-- INVOICE_ITEMS - 4 items per invoice (16 total)
-- ============================================

-- Items for Invoice 1 (INV-2024-0001)
INSERT INTO invoice_items (invoice_id, shipment_id, description, quantity, unit_price, total_price, created_at)
VALUES
    (1, 1, 'Servicio de transporte terrestre - Medellín a Bogotá', 1, 1500000.00, 1500000.00, '2024-01-20 15:00:00'),
    (1, 1, 'Seguro de mercancía en tránsito', 1, 500000.00, 500000.00, '2024-01-20 15:00:00'),
    (1, 1, 'Manipulación y carga de mercancía', 3, 150000.00, 450000.00, '2024-01-20 15:00:00'),
    (1, NULL, 'Documentación y trámites aduaneros', 1, 50000.00, 50000.00, '2024-01-20 15:00:00');

-- Items for Invoice 2 (INV-2024-0002)
INSERT INTO invoice_items (invoice_id, shipment_id, description, quantity, unit_price, total_price, created_at)
VALUES
    (2, 2, 'Transporte express - Medellín a Barranquilla', 1, 1200000.00, 1200000.00, '2024-01-18 16:30:00'),
    (2, 2, 'Embalaje especializado para equipos electrónicos', 2, 200000.00, 400000.00, '2024-01-18 16:30:00'),
    (2, NULL, 'Servicio de rastreo GPS en tiempo real', 1, 150000.00, 150000.00, '2024-01-18 16:30:00'),
    (2, NULL, 'Tarifa de gestión administrativa', 1, 50000.00, 50000.00, '2024-01-18 16:30:00');

-- Items for Invoice 3 (INV-2024-0003)
INSERT INTO invoice_items (invoice_id, shipment_id, description, quantity, unit_price, total_price, created_at)
VALUES
    (3, 3, 'Transporte local - Cali zona norte a zona sur', 1, 800000.00, 800000.00, '2024-01-22 09:45:00'),
    (3, 3, 'Almacenamiento temporal (5 días)', 5, 80000.00, 400000.00, '2024-01-22 09:45:00'),
    (3, 3, 'Carga y descarga con montacargas', 4, 250000.00, 1000000.00, '2024-01-22 09:45:00'),
    (3, 3, 'Servicio de reparto en horario extendido', 1, 1000000.00, 1000000.00, '2024-01-22 09:45:00');

-- Items for Invoice 4 (INV-2024-0004)
INSERT INTO invoice_items (invoice_id, shipment_id, description, quantity, unit_price, total_price, created_at)
VALUES
    (4, 4, 'Transporte de carga pesada - Cartagena a Manizales', 1, 3500000.00, 3500000.00, '2024-01-26 14:20:00'),
    (4, 4, 'Seguro de carga de alto valor', 1, 800000.00, 800000.00, '2024-01-26 14:20:00'),
    (4, 4, 'Escolta de seguridad durante el trayecto', 2, 500000.00, 1000000.00, '2024-01-26 14:20:00'),
    (4, NULL, 'Gestión documental y certificados de origen', 1, 200000.00, 200000.00, '2024-01-26 14:20:00');

-- ============================================
-- INVOICE_SHIPMENTS - 4 sample records
-- ============================================

INSERT INTO invoice_shipments (invoice_id, shipment_id, created_at)
VALUES
    (1, 1, '2024-01-20 15:00:00'),
    (2, 2, '2024-01-18 16:30:00'),
    (3, 3, '2024-01-22 09:45:00'),
    (4, 4, '2024-01-26 14:20:00');

-- ============================================
-- AUDIT_LOGS - 4 sample records
-- ============================================

INSERT INTO audit_logs (entity_type, entity_id, action, changed_by, old_data, new_data, change_summary, ip_address, user_agent, created_at)
VALUES
    ('INVOICE', 1, 'CREATE', 1, NULL,
     '{"invoice_number": "INV-2024-0001", "client_name": "Acme Corporation", "total_amount": 2975000.00, "status": "DRAFT"}'::jsonb,
     'Factura creada inicialmente en estado DRAFT', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', '2024-01-20 15:00:00'),

    ('INVOICE', 1, 'ISSUE', 1,
     '{"status": "DRAFT", "pdf_url": null}'::jsonb,
     '{"status": "ISSUED", "pdf_url": "https://storage.example.com/invoices/2024/INV-2024-0001.pdf"}'::jsonb,
     'Factura emitida y PDF generado', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', '2024-01-20 15:05:00'),

    ('INVOICE', 2, 'UPDATE', 1,
     '{"status": "ISSUED", "total_amount": 2142000.00}'::jsonb,
     '{"status": "PAID", "total_amount": 2142000.00}'::jsonb,
     'Factura marcada como pagada - Pago recibido', '192.168.1.105', 'Mozilla/5.0 (Macintosh; Intel Mac OS X)', '2024-01-25 10:00:00'),

    ('SHIPMENT', 1, 'UPDATE', 1,
     '{"shipment_status": "IN_TRANSIT", "tracking_number": "TRK-2024-001"}'::jsonb,
     '{"shipment_status": "DELIVERED", "tracking_number": "TRK-2024-001"}'::jsonb,
     'Envío marcado como entregado exitosamente', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)', '2024-01-20 14:45:00');

-- ============================================
-- INVOICE_HISTORY - 4 sample records
-- ============================================

INSERT INTO invoice_history (invoice_id, version, fiscal_folio, invoice_number, invoice_data, created_by, created_at, is_reverted)
VALUES
    (1, 1, NULL, 'INV-2024-0001',
     '{"client_name": "Acme Corporation", "total_amount": 2975000.00, "status": "DRAFT", "items": []}'::jsonb,
     1, '2024-01-20 15:00:00', FALSE),

    (2, 1, 'FE-2024-000002', 'INV-2024-0002',
     '{"client_name": "Tech Solutions SAS", "total_amount": 2142000.00, "status": "ISSUED"}'::jsonb,
     1, '2024-01-18 16:30:00', FALSE),

    (2, 2, 'FE-2024-000002', 'INV-2024-0002',
     '{"client_name": "Tech Solutions SAS", "total_amount": 2142000.00, "status": "PAID", "payment_date": "2024-01-25"}'::jsonb,
     1, '2024-01-25 10:00:00', FALSE),

    (3, 1, 'FE-2024-000003', 'INV-2024-0003',
     '{"client_name": "Distribuidora del Valle", "total_amount": 3808000.00, "status": "ISSUED"}'::jsonb,
     2, '2024-01-22 09:45:00', FALSE);

-- ============================================
-- PDF_LOGS - 4 sample records
-- ============================================

INSERT INTO pdf_logs (invoice_id, pdf_url, generation_status, error_message, template_type, generated_by, generated_at)
VALUES
    (1, 'https://storage.example.com/invoices/2024/INV-2024-0001.pdf', 'SUCCESS', NULL, 'STANDARD_INVOICE', 1, '2024-01-20 15:05:00'),
    (2, 'https://storage.example.com/invoices/2024/INV-2024-0002.pdf', 'SUCCESS', NULL, 'STANDARD_INVOICE', 1, '2024-01-18 16:35:00'),
    (3, NULL, 'PENDING', NULL, 'STANDARD_INVOICE', 2, '2024-01-22 09:50:00'),
    (1, 'https://storage.example.com/invoices/2024/INV-2024-0001-v2.pdf', 'FAILED', 'Template rendering error: Missing client logo', 'PREMIUM_INVOICE', 1, '2024-01-21 10:15:00');
