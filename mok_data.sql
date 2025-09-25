-- =====================================================================
-- COMPREHENSIVE DUMMY DATA FOR MANUFACTURING INVENTORY SYSTEM
-- =====================================================================

-- =====================================================================
-- 1. MASTER DATA - FOUNDATION
-- =====================================================================

-- Companies
INSERT INTO companies (company_id, company_name, company_code, company_type, address, phone, email, tax_id) VALUES
(1, 'ABC Manufacturing Ltd', 'ABC001', 'main', '123 Industrial Park, Manufacturing City, MC 12345', '+1-555-0100', 'info@abcmanufacturing.com', 'TX123456789'),
(2, 'ABC Raw Materials Division', 'ABC002', 'division', '456 Supply Chain Blvd, Manufacturing City, MC 12346', '+1-555-0200', 'materials@abcmanufacturing.com', 'TX123456790');

-- Locations
INSERT INTO locations (location_id, location_code, location_name, location_type, company_id, address, capacity_cubic_meters, temperature_controlled, temperature_min, temperature_max, is_active) VALUES
(1, 'WH001', 'Main Warehouse', 'warehouse', 1, 'Building A, Industrial Park', 5000.00, FALSE, NULL, NULL, TRUE),
(2, 'WH002', 'Cold Storage', 'warehouse', 1, 'Building B, Industrial Park', 1000.00, TRUE, 2.00, 8.00, TRUE),
(3, 'PROD01', 'Production Floor 1', 'production_floor', 1, 'Building C, Industrial Park', 2000.00, FALSE, NULL, NULL, TRUE),
(4, 'PROD02', 'Production Floor 2', 'production_floor', 1, 'Building C, Industrial Park', 2000.00, FALSE, NULL, NULL, TRUE),
(5, 'QC001', 'Quality Control Lab', 'quality_lab', 1, 'Building D, Industrial Park', 200.00, TRUE, 18.00, 25.00, TRUE),
(6, 'SHIP01', 'Shipping Dock', 'shipping_dock', 1, 'Building E, Industrial Park', 500.00, FALSE, NULL, NULL, TRUE),
(7, 'REC001', 'Receiving Dock', 'receiving_dock', 1, 'Building E, Industrial Park', 500.00, FALSE, NULL, NULL, TRUE);

-- Storage Bins
INSERT INTO storage_bins (bin_id, bin_code, location_id, bin_type, aisle, row_number, level_number, capacity_kg, is_active) VALUES
(1, 'WH001-A01-01-01', 1, 'rack', 'A01', '01', '01', 1000.00, TRUE),
(2, 'WH001-A01-01-02', 1, 'rack', 'A01', '01', '02', 1000.00, TRUE),
(3, 'WH001-A01-02-01', 1, 'rack', 'A01', '02', '01', 1000.00, TRUE),
(4, 'WH001-B01-01-01', 1, 'rack', 'B01', '01', '01', 1000.00, TRUE),
(5, 'WH001-B01-02-01', 1, 'rack', 'B01', '02', '01', 1000.00, TRUE),
(6, 'WH002-C01-01-01', 2, 'shelf', 'C01', '01', '01', 500.00, TRUE),
(7, 'WH002-C01-02-01', 2, 'shelf', 'C01', '02', '01', 500.00, TRUE),
(8, 'PROD01-FLOOR-01', 3, 'floor', NULL, NULL, NULL, 5000.00, TRUE),
(9, 'PROD02-FLOOR-01', 4, 'floor', NULL, NULL, NULL, 5000.00, TRUE),
(10, 'SHIP01-STAGE-01', 6, 'floor', NULL, NULL, NULL, 2000.00, TRUE);

-- Product Categories
INSERT INTO product_categories (category_id, category_code, category_name, parent_category_id, description, is_active) VALUES
(1, 'RAW', 'Raw Materials', NULL, 'All raw materials and components', TRUE),
(2, 'CHEM', 'Chemicals', 1, 'Chemical compounds and solutions', TRUE),
(3, 'METAL', 'Metals', 1, 'Metal components and alloys', TRUE),
(4, 'PACK', 'Packaging', 1, 'Packaging materials', TRUE),
(5, 'FG', 'Finished Goods', NULL, 'Completed products ready for sale', TRUE),
(6, 'PHARM', 'Pharmaceuticals', 5, 'Pharmaceutical products', TRUE),
(7, 'COSM', 'Cosmetics', 5, 'Cosmetic products', TRUE);

-- Units of Measure (already inserted in schema, adding more)
INSERT INTO units_of_measure (uom_id, uom_code, uom_name, uom_type, base_unit_id, conversion_factor) VALUES
(10, 'TON', 'Metric Ton', 'weight', 1, 1000.0000),
(11, 'OZ', 'Ounce', 'weight', 2, 28.3495),
(12, 'GAL', 'Gallon', 'volume', 3, 3.78541),
(13, 'BOX', 'Box', 'count', 5, 1.0000),
(14, 'PAL', 'Pallet', 'count', 5, 1.0000);

-- Suppliers
INSERT INTO suppliers (supplier_id, supplier_code, supplier_name, supplier_type, contact_person, address, phone, email, payment_terms, lead_time_days, quality_rating, is_active) VALUES
(1, 'SUP001', 'ChemCorp Industries', 'material', 'John Smith', '789 Chemical Ave, Industrial Zone', '+1-555-1001', 'sales@chemcorp.com', 'NET 30', 14, 95.50, TRUE),
(2, 'SUP002', 'MetalWorks Ltd', 'material', 'Sarah Johnson', '321 Steel Street, Metal District', '+1-555-1002', 'orders@metalworks.com', 'NET 15', 7, 98.20, TRUE),
(3, 'SUP003', 'PackagePro Solutions', 'packaging', 'Mike Wilson', '654 Package Blvd, Pack City', '+1-555-1003', 'info@packagepro.com', 'NET 45', 21, 92.80, TRUE),
(4, 'SUP004', 'GlobalChem Supplies', 'material', 'Lisa Chen', '987 Global Way, Chem Town', '+1-555-1004', 'purchasing@globalchem.com', 'NET 30', 10, 94.70, TRUE),
(5, 'SUP005', 'Premium Packaging Inc', 'packaging', 'Robert Davis', '147 Premium Lane, Pack District', '+1-555-1005', 'sales@premiumpacking.com', 'NET 60', 28, 89.60, TRUE);

-- Customers
INSERT INTO customers (customer_id, customer_code, customer_name, customer_type, contact_person, address, phone, email, credit_limit, payment_terms, is_active) VALUES
(1, 'CUST001', 'PharmaCare Distributors', 'distributor', 'Jennifer Adams', '111 Healthcare Plaza, Medical City', '+1-555-2001', 'orders@pharmacare.com', 500000.00, 'NET 30', TRUE),
(2, 'CUST002', 'BeautyChain Retail', 'retail', 'David Brown', '222 Beauty Boulevard, Retail Zone', '+1-555-2002', 'purchasing@beautychain.com', 250000.00, 'NET 45', TRUE),
(3, 'CUST003', 'MedSupply Wholesale', 'wholesale', 'Emily Taylor', '333 Medical Supply St, Health District', '+1-555-2003', 'sales@medsupply.com', 750000.00, 'NET 15', TRUE),
(4, 'CUST004', 'CosmoPro Manufacturing', 'oem', 'Thomas Wilson', '444 Manufacturing Rd, Industrial Park', '+1-555-2004', 'procurement@cosmopro.com', 1000000.00, 'NET 60', TRUE),
(5, 'CUST005', 'HealthMart Chains', 'retail', 'Amanda Garcia', '555 Retail Center, Shopping District', '+1-555-2005', 'buying@healthmart.com', 300000.00, 'NET 30', TRUE);

-- Users
INSERT INTO users (user_id, username, employee_id, first_name, last_name, email, password_hash, role, department, is_active) VALUES
(1, 'admin', 'EMP001', 'System', 'Administrator', 'admin@abcmanufacturing.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin', 'IT', TRUE),
(2, 'jdoe', 'EMP002', 'John', 'Doe', 'jdoe@abcmanufacturing.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'production_manager', 'Production', TRUE),
(3, 'msmith', 'EMP003', 'Mary', 'Smith', 'msmith@abcmanufacturing.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'inventory_clerk', 'Inventory', TRUE),
(4, 'bwilson', 'EMP004', 'Bob', 'Wilson', 'bwilson@abcmanufacturing.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'quality_inspector', 'Quality', TRUE),
(5, 'sgarcia', 'EMP005', 'Sofia', 'Garcia', 'sgarcia@abcmanufacturing.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'operator', 'Production', TRUE),
(6, 'ajohnson', 'EMP006', 'Alex', 'Johnson', 'ajohnson@abcmanufacturing.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'inventory_clerk', 'Warehouse', TRUE);

-- =====================================================================
-- 2. MATERIALS AND PRODUCTS
-- =====================================================================

-- Raw Materials
INSERT INTO raw_materials (material_id, material_code, material_name, material_description, category_id, primary_uom_id, material_type, supplier_id, standard_cost, current_cost, reorder_level, reorder_quantity, safety_stock, lead_time_days, shelf_life_days, hazardous_material, quality_control_required, lot_controlled, is_active) VALUES
(1, 'RM001', 'Sodium Chloride USP', 'Pharmaceutical grade sodium chloride', 2, 1, 'raw_material', 1, 2.50, 2.75, 1000.000, 5000.000, 500.000, 14, 1825, FALSE, TRUE, TRUE, TRUE),
(2, 'RM002', 'Aluminum Sheet 1mm', '1mm thickness aluminum sheeting', 3, 1, 'raw_material', 2, 15.25, 16.80, 200.000, 1000.000, 100.000, 7, NULL, FALSE, TRUE, TRUE, TRUE),
(3, 'RM003', 'Polyethylene Bottles 100ml', 'HDPE bottles for liquid products', 4, 5, 'packaging', 3, 0.85, 0.92, 5000.000, 10000.000, 1000.000, 21, NULL, FALSE, FALSE, TRUE, TRUE),
(4, 'RM004', 'Magnesium Stearate', 'Pharmaceutical excipient', 2, 1, 'raw_material', 4, 8.50, 9.20, 50.000, 200.000, 25.000, 10, 1095, FALSE, TRUE, TRUE, TRUE),
(5, 'RM005', 'Titanium Dioxide', 'White pigment for cosmetics', 2, 1, 'raw_material', 1, 12.75, 13.45, 100.000, 500.000, 50.000, 14, 730, FALSE, TRUE, TRUE, TRUE),
(6, 'RM006', 'Stainless Steel Rod 10mm', '10mm diameter stainless steel rod', 3, 8, 'raw_material', 2, 25.60, 27.15, 500.000, 2000.000, 200.000, 7, NULL, FALSE, TRUE, TRUE, TRUE),
(7, 'RM007', 'Glass Vials 5ml', 'Borosilicate glass vials', 4, 5, 'packaging', 5, 1.25, 1.35, 2000.000, 5000.000, 500.000, 28, NULL, TRUE, TRUE, TRUE, TRUE),
(8, 'RM008', 'Propylene Glycol', 'Cosmetic grade propylene glycol', 2, 3, 'raw_material', 4, 4.80, 5.20, 500.000, 2000.000, 250.000, 10, 1095, FALSE, TRUE, TRUE, TRUE);

-- Finished Products
INSERT INTO finished_products (product_id, product_code, product_name, product_description, category_id, primary_uom_id, product_family, standard_cost, current_cost, selling_price, production_time_minutes, batch_size, shelf_life_days, quality_control_required, lot_controlled, is_active) VALUES
(1, 'FG001', 'Pain Relief Tablets 500mg', 'Over-the-counter pain relief tablets', 6, 5, 'Pharmaceuticals', 25.50, 27.80, 45.00, 120, 1000.000, 1095, TRUE, TRUE, TRUE),
(2, 'FG002', 'Anti-Wrinkle Serum 30ml', 'Premium anti-aging facial serum', 7, 5, 'Skincare', 18.75, 20.25, 89.99, 90, 500.000, 730, TRUE, TRUE, TRUE),
(3, 'FG003', 'Vitamin C Tablets 1000mg', 'High potency vitamin C supplement', 6, 5, 'Supplements', 12.30, 13.95, 24.99, 60, 2000.000, 1095, TRUE, TRUE, TRUE),
(4, 'FG004', 'Moisturizing Cream 50ml', 'Daily moisturizing face cream', 7, 5, 'Skincare', 8.90, 9.85, 19.99, 45, 1000.000, 545, TRUE, TRUE, TRUE),
(5, 'FG005', 'Antibiotic Capsules 250mg', 'Prescription antibiotic capsules', 6, 5, 'Pharmaceuticals', 45.80, 48.50, 125.00, 150, 500.000, 730, TRUE, TRUE, TRUE);

-- BOM Headers
INSERT INTO bom_header (bom_id, bom_code, product_id, bom_version, base_quantity, effective_date, status, created_by, approved_by, approved_date) VALUES
(1, 'BOM-FG001-V1.0', 1, '1.0', 1000.000, '2024-01-01', 'active', 2, 2, '2024-01-15'),
(2, 'BOM-FG002-V1.0', 2, '1.0', 500.000, '2024-01-01', 'active', 2, 2, '2024-01-15'),
(3, 'BOM-FG003-V1.0', 3, '1.0', 2000.000, '2024-01-01', 'active', 2, 2, '2024-01-15'),
(4, 'BOM-FG004-V1.0', 4, '1.0', 1000.000, '2024-01-01', 'active', 2, 2, '2024-01-15'),
(5, 'BOM-FG005-V1.0', 5, '1.0', 500.000, '2024-01-01', 'active', 2, 2, '2024-01-15');

-- BOM Lines
INSERT INTO bom_lines (bom_line_id, bom_id, line_number, material_id, quantity_required, uom_id, scrap_percentage, operation_sequence, is_critical_component) VALUES
-- BOM for Pain Relief Tablets (FG001)
(1, 1, 10, 1, 450.000000, 1, 2.00, 10, TRUE),  -- Sodium Chloride
(2, 1, 20, 4, 25.000000, 1, 1.00, 10, TRUE),   -- Magnesium Stearate
(3, 1, 30, 3, 1000.000000, 5, 0.50, 20, FALSE), -- Bottles

-- BOM for Anti-Wrinkle Serum (FG002)
(4, 2, 10, 5, 15.000000, 1, 1.50, 10, TRUE),    -- Titanium Dioxide
(5, 2, 20, 8, 12.000000, 3, 1.00, 10, TRUE),    -- Propylene Glycol
(6, 2, 30, 7, 500.000000, 5, 0.20, 20, FALSE),  -- Glass Vials

-- BOM for Vitamin C Tablets (FG003)
(7, 3, 10, 1, 800.000000, 1, 2.50, 10, TRUE),   -- Sodium Chloride
(8, 3, 20, 4, 45.000000, 1, 1.00, 10, TRUE),    -- Magnesium Stearate
(9, 3, 30, 3, 2000.000000, 5, 0.25, 20, FALSE), -- Bottles

-- BOM for Moisturizing Cream (FG004)
(10, 4, 10, 8, 40.000000, 3, 1.00, 10, TRUE),   -- Propylene Glycol
(11, 4, 20, 5, 8.000000, 1, 1.50, 10, TRUE),    -- Titanium Dioxide
(12, 4, 30, 3, 1000.000000, 5, 0.30, 20, FALSE), -- Bottles

-- BOM for Antibiotic Capsules (FG005)
(13, 5, 10, 1, 180.000000, 1, 3.00, 10, TRUE),  -- Sodium Chloride
(14, 5, 20, 4, 15.000000, 1, 1.00, 10, TRUE),   -- Magnesium Stearate
(15, 5, 30, 7, 500.000000, 5, 0.40, 20, FALSE); -- Glass Vials

-- =====================================================================
-- 3. INVENTORY DATA
-- =====================================================================

-- Lot Master
INSERT INTO lot_master (lot_id, lot_number, item_type, item_id, supplier_lot, manufacturing_date, expiration_date, quantity_produced, quality_status, created_date, created_by) VALUES
(1, 'LOT-RM001-240301', 'raw_material', 1, 'SUP001-240215', NULL, '2029-02-28', NULL, 'approved', '2024-03-01', 3),
(2, 'LOT-RM002-240305', 'raw_material', 2, 'SUP002-240228', NULL, NULL, NULL, 'approved', '2024-03-05', 3),
(3, 'LOT-RM003-240310', 'raw_material', 3, 'SUP003-240305', NULL, NULL, NULL, 'approved', '2024-03-10', 3),
(4, 'LOT-RM004-240312', 'raw_material', 4, 'SUP004-240308', NULL, '2027-03-08', NULL, 'approved', '2024-03-12', 3),
(5, 'LOT-RM005-240315', 'raw_material', 5, 'SUP001-240310', NULL, '2026-03-10', NULL, 'approved', '2024-03-15', 3),
(6, 'LOT-FG001-240320', 'finished_product', 1, NULL, '2024-03-20', '2027-03-20', 1000.000, 'approved', '2024-03-20', 2),
(7, 'LOT-FG002-240322', 'finished_product', 2, NULL, '2024-03-22', '2026-03-22', 500.000, 'approved', '2024-03-22', 2),
(8, 'LOT-FG003-240325', 'finished_product', 3, NULL, '2024-03-25', '2027-03-25', 2000.000, 'approved', '2024-03-25', 2);

-- Inventory Master
INSERT INTO inventory_master (inventory_id, item_type, item_id, location_id, bin_id, lot_number, quantity_on_hand, quantity_reserved, quantity_allocated, unit_cost, manufacturing_date, expiration_date, received_date, status, quality_status) VALUES
-- Raw Materials Inventory
(1, 'raw_material', 1, 1, 1, 'LOT-RM001-240301', 2500.000000, 450.000000, 0.000000, 2.75, NULL, '2029-02-28', '2024-03-01', 'available', 'approved'),
(2, 'raw_material', 2, 1, 2, 'LOT-RM002-240305', 750.000000, 0.000000, 0.000000, 16.80, NULL, NULL, '2024-03-05', 'available', 'approved'),
(3, 'raw_material', 3, 1, 4, 'LOT-RM003-240310', 8500.000000, 1000.000000, 0.000000, 0.92, NULL, NULL, '2024-03-10', 'available', 'approved'),
(4, 'raw_material', 4, 1, 1, 'LOT-RM004-240312', 125.000000, 25.000000, 0.000000, 9.20, NULL, '2027-03-08', '2024-03-12', 'available', 'approved'),
(5, 'raw_material', 5, 2, 6, 'LOT-RM005-240315', 285.000000, 15.000000, 0.000000, 13.45, NULL, '2026-03-10', '2024-03-15', 'available', 'approved'),
(6, 'raw_material', 6, 1, 3, 'LOT-RM006-240318', 1200.000000, 0.000000, 0.000000, 27.15, NULL, NULL, '2024-03-18', 'available', 'approved'),
(7, 'raw_material', 7, 2, 7, 'LOT-RM007-240320', 3500.000000, 500.000000, 0.000000, 1.35, NULL, NULL, '2024-03-20', 'available', 'approved'),
(8, 'raw_material', 8, 2, 6, 'LOT-RM008-240322', 980.000000, 52.000000, 0.000000, 5.20, NULL, '2027-03-22', '2024-03-22', 'available', 'approved'),

-- Finished Products Inventory
(9, 'finished_product', 1, 1, 5, 'LOT-FG001-240320', 750.000000, 100.000000, 0.000000, 27.80, '2024-03-20', '2027-03-20', '2024-03-20', 'available', 'approved'),
(10, 'finished_product', 2, 2, 6, 'LOT-FG002-240322', 380.000000, 50.000000, 0.000000, 20.25, '2024-03-22', '2026-03-22', '2024-03-22', 'available', 'approved'),
(11, 'finished_product', 3, 1, 4, 'LOT-FG003-240325', 1650.000000, 200.000000, 0.000000, 13.95, '2024-03-25', '2027-03-25', '2024-03-25', 'available', 'approved'),
(12, 'finished_product', 4, 1, 5, 'LOT-FG004-240328', 820.000000, 100.000000, 0.000000, 9.85, '2024-03-28', '2025-10-25', '2024-03-28', 'available', 'approved'),
(13, 'finished_product', 5, 2, 7, 'LOT-FG005-240330', 285.000000, 50.000000, 0.000000, 48.50, '2024-03-30', '2026-03-30', '2024-03-30', 'available', 'approved');

-- =====================================================================
-- 4. PRODUCTION ORDERS
-- =====================================================================

-- Production Orders
INSERT INTO production_orders (production_order_id, order_number, product_id, bom_id, planned_quantity, actual_quantity_produced, order_status, priority, production_line, scheduled_start_date, scheduled_end_date, actual_start_date, actual_end_date, lot_number, quality_status, created_by) VALUES
(1, 'PO-001001', 1, 1, 1000.000, 1000.000, 'completed', 'normal', 'Line-01', '2024-03-18 08:00:00', '2024-03-20 17:00:00', '2024-03-18 08:15:00', '2024-03-20 16:30:00', 'LOT-FG001-240320', 'approved', 2),
(2, 'PO-001002', 2, 2, 500.000, 500.000, 'completed', 'high', 'Line-02', '2024-03-20 09:00:00', '2024-03-22 16:00:00', '2024-03-20 09:10:00', '2024-03-22 15:45:00', 'LOT-FG002-240322', 'approved', 2),
(3, 'PO-001003', 3, 3, 2000.000, 2000.000, 'completed', 'normal', 'Line-01', '2024-03-23 08:00:00', '2024-03-25 17:00:00', '2024-03-23 08:20:00', '2024-03-25 16:50:00', 'LOT-FG003-240325', 'approved', 2),
(4, 'PO-001004', 4, 4, 1000.000, 0.000, 'in_progress', 'normal', 'Line-02', '2024-09-25 08:00:00', '2024-09-26 17:00:00', '2024-09-25 08:00:00', NULL, 'LOT-FG004-240925', 'pending', 2),
(5, 'PO-001005', 5, 5, 500.000, 0.000, 'planned', 'urgent', 'Line-01', '2024-09-26 08:00:00', '2024-09-27 18:00:00', NULL, NULL, 'LOT-FG005-240926', 'pending', 2);

-- Material Reservations
INSERT INTO material_reservations (reservation_id, production_order_id, material_id, inventory_id, quantity_reserved, quantity_issued, reservation_date, required_date, status, created_by) VALUES
-- Reservations for PO-001001 (completed)
(1, 1, 1, 1, 450.000000, 450.000000, '2024-03-17 10:00:00', '2024-03-18 08:00:00', 'fully_issued', 3),
(2, 1, 4, 4, 25.000000, 25.000000, '2024-03-17 10:00:00', '2024-03-18 08:00:00', 'fully_issued', 3),
(3, 1, 3, 3, 1000.000000, 1000.000000, '2024-03-17 10:00:00', '2024-03-20 15:00:00', 'fully_issued', 3),

-- Reservations for PO-001002 (completed)
(4, 2, 5, 5, 15.000000, 15.000000, '2024-03-19 11:00:00', '2024-03-20 09:00:00', 'fully_issued', 3),
(5, 2, 8, 8, 12.000000, 12.000000, '2024-03-19 11:00:00', '2024-03-20 09:00:00', 'fully_issued', 3),
(6, 2, 7, 7, 500.000000, 500.000000, '2024-03-19 11:00:00', '2024-03-22 14:00:00', 'fully_issued', 3),

-- Reservations for PO-001003 (completed)
(7, 3, 1, 1, 800.000000, 800.000000, '2024-03-22 12:00:00', '2024-03-23 08:00:00', 'fully_issued', 3),
(8, 3, 4, 4, 45.000000, 45.000000, '2024-03-22 12:00:00', '2024-03-23 08:00:00', 'fully_issued', 3),
(9, 3, 3, 3, 2000.000000, 2000.000000, '2024-03-22 12:00:00', '2024-03-25 15:00:00', 'fully_issued', 3),

-- Active reservations for current production
(10, 4, 8, 8, 40.000000, 0.000000, '2024-09-24 10:00:00', '2024-09-25 08:00:00', 'active', 3),
(11, 4, 5, 5, 8.000000, 0.000000, '2024-09-24 10:00:00', '2024-09-25 08:00:00', 'active', 3),
(12, 4, 3, 3, 1000.000000, 0.000000, '2024-09-24 10:00:00', '2024-09-26 15:00:00', 'active', 3);

-- Material Consumption (for completed orders)
INSERT INTO material_consumption (consumption_id, production_order_id, material_id, inventory_id, quantity_planned, quantity_issued, unit_cost, issue_date, issued_by, operation_sequence) VALUES
-- Consumption for PO-001001
(1, 1, 1, 1, 450.000000, 459.000000, 2.75, '2024-03-18 08:30:00', 5, 10),
(2, 1, 4, 4, 25.000000, 25.300000, 9.20, '2024-03-18 08:35:00', 5, 10),
(3, 1, 3, 3, 1000.000000, 1005.000000, 0.92, '2024-03-20 15:30:00', 5, 20),

-- Consumption for PO-001002
(4, 2, 5, 5, 15.000000, 15.200000, 13.45, '2024-03-20 09:15:00', 5, 10),
(5, 2, 8, 8, 12.000000, 12.100000, 5.20, '2024-03-20 09:20:00', 5, 10),
(6, 2, 7, 7, 500.000000, 502.000000, 1.35, '2024-03-22 14:15:00', 5, 20),

-- Consumption for PO-001003
(7, 3, 1, 1, 800.000000, 820.000000, 2.75, '2024-03-23 08:45:00', 5, 10),
(8, 3, 4, 4, 45.000000, 45.500000, 9.20, '2024-03-23 08:50:00', 5, 10),
(9, 3, 3, 3, 2000.000000, 2005.000000, 0.92, '2024-03-25 15:45:00', 5, 20);

-- Production Receipts
INSERT INTO production_receipts (receipt_id, production_order_id, quantity_produced, quantity_scrapped, lot_number, location_id, bin_id, production_date, quality_status, received_by, inspected_by) VALUES
(1, 1, 1000.000, 0.000, 'LOT-FG001-240320', 1, 5, '2024-03-20 16:30:00', 'approved', 6, 4),
(2, 2, 500.000, 0.000, 'LOT-FG002-240322', 2, 6, '2024-03-22 15:45:00', 'approved', 6, 4),
(3, 3, 2000.000, 0.000, 'LOT-FG003-240325', 1, 4, '2024-03-25 16:50:00', 'approved', 6, 4);

-- =====================================================================
-- 5. PURCHASE ORDERS AND RECEIVING
-- =====================================================================

-- Purchase Orders
INSERT INTO purchase_orders (po_id, po_number, supplier_id, po_date, required_date, po_status, payment_terms, currency_code, subtotal, tax_amount, total_amount, created_by, approved_by, approved_date) VALUES
(1, 'PUR-001001', 1, '2024-02-25', '2024-03-10', 'completed', 'NET 30', 'USD', 13750.00, 1375.00, 15125.00, 3, 2, '2024-02-26'),
(2, 'PUR-001002', 2, '2024-02-28', '2024-03-07', 'completed', 'NET 15', 'USD', 16800.00, 1680.00, 18480.00, 3, 2, '2024-03-01'),
(3, 'PUR-001003', 3, '2024-03-05', '2024-03-26', 'completed', 'NET 45', 'USD', 9200.00, 920.00, 10120.00, 3, 2, '2024-03-06'),
(4, 'PUR-001004', 4, '2024-03-08', '2024-03-18', 'completed', 'NET 30', 'USD', 1840.00, 184.00, 2024.00, 3, 2, '2024-03-09'),
(5, 'PUR-001005', 1, '2024-03-12', '2024-03-26', 'completed', 'NET 30', 'USD', 6725.00, 672.50, 7397.50, 3, 2, '2024-03-13'),
(6, 'PUR-001006', 3, '2024-09-20', '2024-10-11', 'sent', 'NET 45', 'USD', 15000.00, 1500.00, 16500.00, 3, 2, '2024-09-21');

-- Purchase Order Lines
INSERT INTO purchase_order_lines (po_line_id, po_id, line_number, material_id, quantity_ordered, quantity_received, unit_price, uom_id, required_date, line_status) VALUES
-- PO-001001 lines
(1, 1, 10, 1, 5000.000, 5000.000, 2.75, 1, '2024-03-01', 'completed'),
(2, 1, 20, 4, 200.000, 200.000, 9.20, 1, '2024-03-01', 'completed'),

-- PO-001002 lines  
(3, 2, 10, 2, 1000.000, 1000.000, 16.80, 1, '2024-03-05', 'completed'),

-- PO-001003 lines
(4, 3, 10, 3, 10000.000, 10000.000, 0.92, 5, '2024-03-10', 'completed'),

-- PO-001004 lines
(5, 4, 10, 4, 200.000, 200.000, 9.20, 1, '2024-03-12', 'completed'),

-- PO-001005 lines
(6, 5, 10, 5, 500.000, 500.000, 13.45, 1, '2024-03-15', 'completed'),

-- PO-001006 lines (pending)
(7, 6, 10, 3, 15000.000, 0.000, 1.00, 5, '2024-10-11', 'open'),
(8, 6, 20, 7, 5000.000, 0.000, 1.40, 5, '2024-10-11', 'open');

-- Goods Receipts
INSERT INTO goods_receipts (receipt_id, receipt_number, po_id, supplier_id, receipt_date, delivery_note, vehicle_number, driver_name, received_by) VALUES
(1, 'GR-001001', 1, 1, '2024-03-01 10:30:00', 'DEL-001', 'TRK-101', 'Mike Delivery', 6),
(2, 'GR-001002', 2, 2, '2024-03-05 11:15:00', 'DEL-002', 'TRK-205', 'Susan Transport', 6),
(3, 'GR-001003', 3, 3, '2024-03-10 14:20:00', 'DEL-003', 'VAN-301', 'Carlos Logistics', 6),
(4, 'GR-001004', 4, 4, '2024-03-12 09:45:00', 'DEL-004', 'TRK-401', 'Jennifer Freight', 6),
(5, 'GR-001005', 5, 1, '2024-03-15 13:30:00', 'DEL-005', 'TRK-102', 'Mike Delivery', 6);

-- Goods Receipt Lines
INSERT INTO goods_receipt_lines (receipt_line_id, receipt_id, po_line_id, material_id, quantity_received, lot_number, unit_cost, location_id, bin_id, quality_status) VALUES
(1, 1, 1, 1, 5000.000, 'LOT-RM001-240301', 2.75, 1, 1, 'approved'),
(2, 1, 2, 4, 200.000, 'LOT-RM004-240312', 9.20, 1, 1, 'approved'),
(3, 2, 3, 2, 1000.000, 'LOT-RM002-240305', 16.80, 1, 2, 'approved'),
(4, 3, 4, 3, 10000.000, 'LOT-RM003-240310', 0.92, 1, 4, 'approved'),
(5, 4, 5, 4, 200.000, 'LOT-RM004-240312B', 9.20, 1, 1, 'approved'),
(6, 5, 6, 5, 500.000, 'LOT-RM005-240315', 13.45, 2, 6, 'approved');

-- =====================================================================
-- 6. SALES ORDERS AND SHIPPING
-- =====================================================================

-- Sales Orders
INSERT INTO sales_orders (so_id, so_number, customer_id, so_date, required_date, so_status, priority, payment_terms, shipping_address, currency_code, subtotal, tax_amount, total_amount, created_by, approved_by, approved_date) VALUES
(1, 'SO-001001', 1, '2024-03-15', '2024-03-25', 'shipped', 'normal', 'NET 30', '111 Healthcare Plaza, Medical City', 'USD', 4500.00, 450.00, 4950.00, 3, 2, '2024-03-16'),
(2, 'SO-001002', 2, '2024-03-18', '2024-03-28', 'shipped', 'high', 'NET 45', '222 Beauty Boulevard, Retail Zone', 'USD', 4499.50, 449.95, 4949.45, 3, 2, '2024-03-19'),
(3, 'SO-001003', 3, '2024-03-22', '2024-04-01', 'delivered', 'normal', 'NET 15', '333 Medical Supply St, Health District', 'USD', 4997.50, 499.75, 5497.25, 3, 2, '2024-03-23'),
(4, 'SO-001004', 4, '2024-09-20', '2024-10-05', 'confirmed', 'urgent', 'NET 60', '444 Manufacturing Rd, Industrial Park', 'USD', 12500.00, 1250.00, 13750.00, 3, 2, '2024-09-21'),
(5, 'SO-001005', 5, '2024-09-23', '2024-10-08', 'draft', 'normal', 'NET 30', '555 Retail Center, Shopping District', 'USD', 1999.50, 199.95, 2199.45, 3, NULL, NULL);

-- Sales Order Lines
INSERT INTO sales_order_lines (so_line_id, so_id, line_number, product_id, quantity_ordered, quantity_shipped, unit_price, uom_id, required_date, line_status) VALUES
-- SO-001001 lines
(1, 1, 10, 1, 100.000, 100.000, 45.00, 5, '2024-03-25', 'completed'),

-- SO-001002 lines
(2, 2, 10, 2, 50.000, 50.000, 89.99, 5, '2024-03-28', 'completed'),

-- SO-001003 lines
(3, 3, 10, 3, 200.000, 200.000, 24.99, 5, '2024-04-01', 'completed'),

-- SO-001004 lines (pending)
(4, 4, 10, 5, 100.000, 0.000, 125.00, 5, '2024-10-05', 'open'),

-- SO-001005 lines (draft)
(5, 5, 10, 4, 100.000, 0.000, 19.99, 5, '2024-10-08', 'open');

-- Shipments
INSERT INTO shipments (shipment_id, shipment_number, so_id, customer_id, shipment_date, carrier, tracking_number, vehicle_number, driver_name, shipping_address, shipment_status, shipped_by) VALUES
(1, 'SHIP-001001', 1, 1, '2024-03-24 14:30:00', 'FastShip Express', 'FS123456789', 'SHIP-101', 'Tom Shipper', '111 Healthcare Plaza, Medical City', 'delivered', 6),
(2, 'SHIP-001002', 2, 2, '2024-03-27 15:45:00', 'QuickLogistics', 'QL987654321', 'SHIP-202', 'Linda Freight', '222 Beauty Boulevard, Retail Zone', 'delivered', 6),
(3, 'SHIP-001003', 3, 3, '2024-03-30 11:20:00', 'ReliableTransport', 'RT456789123', 'SHIP-303', 'David Logistics', '333 Medical Supply St, Health District', 'delivered', 6);

-- Shipment Lines
INSERT INTO shipment_lines (shipment_line_id, shipment_id, so_line_id, product_id, inventory_id, quantity_shipped, lot_number, expiry_date) VALUES
(1, 1, 1, 1, 9, 100.000, 'LOT-FG001-240320', '2027-03-20'),
(2, 2, 2, 2, 10, 50.000, 'LOT-FG002-240322', '2026-03-22'),
(3, 3, 3, 3, 11, 200.000, 'LOT-FG003-240325', '2027-03-25');

-- =====================================================================
-- 7. QUALITY CONTROL DATA
-- =====================================================================

-- Quality Control Plans
INSERT INTO quality_control_plans (qc_plan_id, plan_code, item_type, item_id, inspection_type, sampling_method, sample_size, frequency, effective_date, is_active, created_by) VALUES
(1, 'QCP-RM001', 'raw_material', 1, 'incoming', 'statistical', 5, 'Every lot', '2024-01-01', TRUE, 4),
(2, 'QCP-RM004', 'raw_material', 4, 'incoming', '100_percent', 10, 'Every lot', '2024-01-01', TRUE, 4),
(3, 'QCP-FG001', 'finished_product', 1, 'final', 'statistical', 10, 'Every batch', '2024-01-01', TRUE, 4),
(4, 'QCP-FG002', 'finished_product', 2, 'final', 'statistical', 5, 'Every batch', '2024-01-01', TRUE, 4),
(5, 'QCP-FG003', 'finished_product', 3, 'final', 'statistical', 20, 'Every batch', '2024-01-01', TRUE, 4);

-- Quality Control Tests
INSERT INTO quality_control_tests (test_id, qc_plan_id, test_code, test_name, test_method, specification_min, specification_max, target_value, uom_id, test_order, is_critical) VALUES
-- Tests for Sodium Chloride (RM001)
(1, 1, 'PURITY', 'Purity Test', 'HPLC Analysis', 99.50, 100.00, 99.80, NULL, 10, TRUE),
(2, 1, 'MOISTURE', 'Moisture Content', 'Karl Fischer', 0.00, 0.50, 0.10, NULL, 20, TRUE),
(3, 1, 'HEAVY_METALS', 'Heavy Metals', 'ICP-MS', 0.00, 10.00, 2.00, NULL, 30, TRUE),

-- Tests for Magnesium Stearate (RM004)
(4, 2, 'ASSAY', 'Assay', 'Titration', 98.00, 102.00, 100.00, NULL, 10, TRUE),
(5, 2, 'PARTICLE_SIZE', 'Particle Size', 'Sieve Analysis', 90.00, 250.00, 150.00, NULL, 20, FALSE),

-- Tests for Pain Relief Tablets (FG001)
(6, 3, 'CONTENT', 'Active Content', 'HPLC', 475.00, 525.00, 500.00, NULL, 10, TRUE),
(7, 3, 'DISSOLUTION', 'Dissolution Rate', 'USP Method', 80.00, 100.00, 95.00, NULL, 20, TRUE),
(8, 3, 'HARDNESS', 'Tablet Hardness', 'Hardness Tester', 4.00, 10.00, 7.00, NULL, 30, FALSE),

-- Tests for Anti-Wrinkle Serum (FG002)
(9, 4, 'VISCOSITY', 'Viscosity', 'Brookfield', 1000.00, 5000.00, 3000.00, NULL, 10, TRUE),
(10, 4, 'PH', 'pH Level', 'pH Meter', 6.50, 7.50, 7.00, NULL, 20, TRUE),

-- Tests for Vitamin C Tablets (FG003)
(11, 5, 'VITAMIN_C', 'Vitamin C Content', 'HPLC', 950.00, 1050.00, 1000.00, NULL, 10, TRUE),
(12, 5, 'DISINTEGRATION', 'Disintegration Time', 'USP Method', 0.00, 15.00, 10.00, NULL, 20, TRUE);

-- Quality Inspections
INSERT INTO quality_inspections (inspection_id, inspection_number, qc_plan_id, item_type, item_id, lot_number, quantity_inspected, inspection_date, inspector_id, overall_result, reference_type, reference_number, approved_by, approved_date) VALUES
(1, 'QI-001001', 1, 'raw_material', 1, 'LOT-RM001-240301', 5.000, '2024-03-01 11:00:00', 4, 'pass', 'purchase_order', 'PUR-001001', 4, '2024-03-01 16:30:00'),
(2, 'QI-001002', 2, 'raw_material', 4, 'LOT-RM004-240312', 10.000, '2024-03-12 10:30:00', 4, 'pass', 'purchase_order', 'PUR-001001', 4, '2024-03-12 15:45:00'),
(3, 'QI-001003', 3, 'finished_product', 1, 'LOT-FG001-240320', 10.000, '2024-03-20 17:00:00', 4, 'pass', 'production_order', 'PO-001001', 4, '2024-03-21 09:00:00'),
(4, 'QI-001004', 4, 'finished_product', 2, 'LOT-FG002-240322', 5.000, '2024-03-22 16:15:00', 4, 'pass', 'production_order', 'PO-001002', 4, '2024-03-23 08:30:00'),
(5, 'QI-001005', 5, 'finished_product', 3, 'LOT-FG003-240325', 20.000, '2024-03-25 17:30:00', 4, 'pass', 'production_order', 'PO-001003', 4, '2024-03-26 10:00:00');

-- Quality Test Results
INSERT INTO quality_test_results (result_id, inspection_id, test_id, measured_value, result_status, tested_by, test_date) VALUES
-- Results for Sodium Chloride inspection
(1, 1, 1, 99.75, 'pass', 4, '2024-03-01 12:00:00'),
(2, 1, 2, 0.15, 'pass', 4, '2024-03-01 13:00:00'),
(3, 1, 3, 3.50, 'pass', 4, '2024-03-01 14:30:00'),

-- Results for Magnesium Stearate inspection
(4, 2, 4, 99.80, 'pass', 4, '2024-03-12 11:00:00'),
(5, 2, 5, 145.00, 'pass', 4, '2024-03-12 12:00:00'),

-- Results for Pain Relief Tablets inspection
(6, 3, 6, 498.50, 'pass', 4, '2024-03-20 18:00:00'),
(7, 3, 7, 92.30, 'pass', 4, '2024-03-20 19:00:00'),
(8, 3, 8, 6.80, 'pass', 4, '2024-03-20 19:30:00'),

-- Results for Anti-Wrinkle Serum inspection
(9, 4, 9, 2850.00, 'pass', 4, '2024-03-22 17:00:00'),
(10, 4, 10, 6.95, 'pass', 4, '2024-03-22 17:30:00'),

-- Results for Vitamin C Tablets inspection
(11, 5, 11, 1015.00, 'pass', 4, '2024-03-25 18:00:00'),
(12, 5, 12, 8.50, 'pass', 4, '2024-03-25 18:30:00');

-- =====================================================================
-- 8. INVENTORY TRANSACTIONS
-- =====================================================================

-- Sample Inventory Transactions (key movements)
INSERT INTO inventory_transactions (transaction_id, transaction_number, inventory_id, transaction_type, reference_type, reference_number, quantity_change, unit_cost, from_location_id, to_location_id, reason_code, transaction_date, created_by, approved_by, approved_date) VALUES
-- Raw material receipts
(1, 'TXN-00000001', 1, 'receipt', 'purchase_order', 'PUR-001001', 5000.000000, 2.75, NULL, 1, 'PO_RECEIPT', '2024-03-01 11:00:00', 6, 6, '2024-03-01 11:00:00'),
(2, 'TXN-00000002', 2, 'receipt', 'purchase_order', 'PUR-001002', 1000.000000, 16.80, NULL, 1, 'PO_RECEIPT', '2024-03-05 11:15:00', 6, 6, '2024-03-05 11:15:00'),
(3, 'TXN-00000003', 3, 'receipt', 'purchase_order', 'PUR-001003', 10000.000000, 0.92, NULL, 1, 'PO_RECEIPT', '2024-03-10 14:20:00', 6, 6, '2024-03-10 14:20:00'),

-- Production issues
(4, 'TXN-00000004', 1, 'production_issue', 'production_order', 'PO-001001', -459.000000, 2.75, 1, 3, 'PRODUCTION', '2024-03-18 08:30:00', 5, 5, '2024-03-18 08:30:00'),
(5, 'TXN-00000005', 4, 'production_issue', 'production_order', 'PO-001001', -25.300000, 9.20, 1, 3, 'PRODUCTION', '2024-03-18 08:35:00', 5, 5, '2024-03-18 08:35:00'),
(6, 'TXN-00000006', 3, 'production_issue', 'production_order', 'PO-001001', -1005.000000, 0.92, 1, 3, 'PRODUCTION', '2024-03-20 15:30:00', 5, 5, '2024-03-20 15:30:00'),

-- Production receipts
(7, 'TXN-00000007', 9, 'production_receipt', 'production_order', 'PO-001001', 1000.000000, 27.80, 3, 1, 'PRODUCTION', '2024-03-20 16:30:00', 6, 6, '2024-03-20 16:30:00'),
(8, 'TXN-00000008', 10, 'production_receipt', 'production_order', 'PO-001002', 500.000000, 20.25, 3, 2, 'PRODUCTION', '2024-03-22 15:45:00', 6, 6, '2024-03-22 15:45:00'),
(9, 'TXN-00000009', 11, 'production_receipt', 'production_order', 'PO-001003', 2000.000000, 13.95, 3, 1, 'PRODUCTION', '2024-03-25 16:50:00', 6, 6, '2024-03-25 16:50:00'),

-- Sales shipments
(10, 'TXN-00000010', 9, 'shipment', 'sales_order', 'SO-001001', -100.000000, 27.80, 1, NULL, 'SHIPMENT', '2024-03-24 14:30:00', 6, 6, '2024-03-24 14:30:00'),
(11, 'TXN-00000011', 10, 'shipment', 'sales_order', 'SO-001002', -50.000000, 20.25, 2, NULL, 'SHIPMENT', '2024-03-27 15:45:00', 6, 6, '2024-03-27 15:45:00'),
(12, 'TXN-00000012', 11, 'shipment', 'sales_order', 'SO-001003', -200.000000, 13.95, 1, NULL, 'SHIPMENT', '2024-03-30 11:20:00', 6, 6, '2024-03-30 11:20:00'),

-- Cycle count adjustments
(13, 'TXN-00000013', 2, 'adjustment', 'cycle_count', 'CC-001001', -5.000000, 16.80, NULL, NULL, 'CYCLE_COUNT', '2024-09-15 10:00:00', 3, 3, '2024-09-15 10:00:00'),
(14, 'TXN-00000014', 5, 'adjustment', 'cycle_count', 'CC-001002', 2.000000, 13.45, NULL, NULL, 'CYCLE_COUNT', '2024-09-18 14:30:00', 3, 3, '2024-09-18 14:30:00');

-- =====================================================================
-- 9. PLANNING AND FORECASTING DATA
-- =====================================================================

-- Demand Forecast
INSERT INTO demand_forecast (forecast_id, product_id, forecast_period, forecast_quantity, actual_quantity, forecast_type, confidence_level, created_by) VALUES
(1, 1, '2024-03', 950.000, 1000.000, 'statistical', 85.00, 2),
(2, 2, '2024-03', 480.000, 500.000, 'statistical', 78.50, 2),
(3, 3, '2024-03', 1800.000, 2000.000, 'customer_forecast', 92.00, 2),
(4, 4, '2024-09', 1200.000, 0.000, 'manual', 70.00, 2),
(5, 5, '2024-09', 600.000, 0.000, 'statistical', 80.00, 2),
(6, 1, '2024-10', 1100.000, 0.000, 'statistical', 82.00, 2),
(7, 2, '2024-10', 550.000, 0.000, 'statistical', 75.50, 2),
(8, 3, '2024-10', 2200.000, 0.000, 'manual', 85.00, 2),
(9, 4, '2024-10', 1000.000, 0.000, 'customer_forecast', 90.00, 2),
(10, 5, '2024-10', 450.000, 0.000, 'statistical', 77.00, 2);

-- Master Production Schedule
INSERT INTO master_production_schedule (mps_id, product_id, period_start_date, period_end_date, planned_production, actual_production, committed_orders, available_to_promise, schedule_status, created_by) VALUES
(1, 1, '2024-03-18', '2024-03-24', 1000.000, 1000.000, 100.000, 900.000, 'firm', 2),
(2, 2, '2024-03-20', '2024-03-22', 500.000, 500.000, 50.000, 450.000, 'firm', 2),
(3, 3, '2024-03-23', '2024-03-25', 2000.000, 2000.000, 200.000, 1800.000, 'firm', 2),
(4, 4, '2024-09-25', '2024-09-26', 1000.000, 0.000, 100.000, 900.000, 'released', 2),
(5, 5, '2024-09-26', '2024-09-27', 500.000, 0.000, 100.000, 400.000, 'draft', 2),
(6, 1, '2024-10-01', '2024-10-03', 1200.000, 0.000, 0.000, 1200.000, 'draft', 2),
(7, 2, '2024-10-07', '2024-10-09', 600.000, 0.000, 0.000, 600.000, 'draft', 2);

-- Material Requirements Planning
INSERT INTO material_requirements (requirement_id, material_id, requirement_date, gross_requirement, scheduled_receipts, projected_on_hand, net_requirement, planned_order_release, source_type, source_reference, mrp_run_date) VALUES
-- Current requirements for active production
(1, 1, '2024-09-25', 450.000, 0.000, 2050.000, 0.000, 0.000, 'production_order', 'PO-001004', '2024-09-24'),
(2, 4, '2024-09-25', 8.000, 0.000, 100.000, 0.000, 0.000, 'production_order', 'PO-001004', '2024-09-24'),
(3, 5, '2024-09-25', 8.000, 0.000, 270.000, 0.000, 0.000, 'production_order', 'PO-001004', '2024-09-24'),
(4, 3, '2024-09-26', 1000.000, 0.000, 7495.000, 0.000, 0.000, 'production_order', 'PO-001004', '2024-09-24'),

-- Future requirements
(5, 1, '2024-09-26', 180.000, 0.000, 1870.000, 0.000, 0.000, 'production_order', 'PO-001005', '2024-09-24'),
(6, 4, '2024-09-26', 15.000, 0.000, 92.000, 0.000, 0.000, 'production_order', 'PO-001005', '2024-09-24'),
(7, 7, '2024-09-27', 500.000, 5000.000, 3000.000, 0.000, 0.000, 'production_order', 'PO-001005', '2024-09-24'),

-- October planning
(8, 1, '2024-10-01', 540.000, 0.000, 1330.000, 0.000, 0.000, 'forecast', 'OCT-FORECAST', '2024-09-24'),
(9, 3, '2024-10-01', 1200.000, 15000.000, 21295.000, 0.000, 0.000, 'forecast', 'OCT-FORECAST', '2024-09-24');

-- Reorder Suggestions
INSERT INTO reorder_suggestions (suggestion_id, item_type, item_id, current_stock, reorder_level, suggested_quantity, supplier_id, lead_time_days, required_date, suggestion_date, status) VALUES
(1, 'raw_material', 6, 1200.000, 500.000, 2000.000, 2, 7, '2024-10-05', '2024-09-25', 'pending'),
(2, 'raw_material', 8, 928.000, 500.000, 2000.000, 4, 10, '2024-10-08', '2024-09-25', 'pending');

-- =====================================================================
-- 10. CYCLE COUNTING DATA
-- =====================================================================

-- Cycle Count Plans
INSERT INTO cycle_count_plans (plan_id, plan_name, count_frequency, count_type, location_id, last_count_date, next_count_date, is_active, created_by) VALUES
(1, 'Main Warehouse Monthly Count', 'monthly', 'location_based', 1, '2024-08-15', '2024-10-15', TRUE, 3),
(2, 'Cold Storage Weekly Count', 'weekly', 'location_based', 2, '2024-09-18', '2024-09-25', TRUE, 3),
(3, 'High Value Items ABC Count', 'weekly', 'abc_analysis', NULL, '2024-09-20', '2024-09-27', TRUE, 3);

-- Cycle Count Headers
INSERT INTO cycle_count_headers (count_header_id, count_number, plan_id, count_date, count_type, location_id, count_status, counted_by, reviewed_by, approved_by) VALUES
(1, 'CC-001001', 1, '2024-09-15', 'cycle', 1, 'completed', 3, 3, 2),
(2, 'CC-001002', 2, '2024-09-18', 'cycle', 2, 'completed', 3, 3, 2),
(3, 'CC-001003', 3, '2024-09-20', 'cycle', NULL, 'completed', 6, 3, 2),
(4, 'CC-001004', 2, '2024-09-25', 'cycle', 2, 'in_progress', 3, NULL, NULL);

-- Cycle Count Details
INSERT INTO cycle_count_details (count_detail_id, count_header_id, inventory_id, item_type, item_id, lot_number, book_quantity, counted_quantity, unit_cost, count_status, reason_code) VALUES
-- CC-001001 details (Main Warehouse)
(1, 1, 1, 'raw_material', 1, 'LOT-RM001-240301', 2955.000000, 2950.000000, 2.75, 'counted', 'MINOR_VARIANCE'),
(2, 1, 2, 'raw_material', 2, 'LOT-RM002-240305', 755.000000, 750.000000, 16.80, 'adjusted', 'COUNT_ERROR'),
(3, 1, 3, 'raw_material', 3, 'LOT-RM003-240310', 8500.000000, 8500.000000, 0.92, 'counted', NULL),
(4, 1, 9, 'finished_product', 1, 'LOT-FG001-240320', 850.000000, 850.000000, 27.80, 'counted', NULL),

-- CC-001002 details (Cold Storage)
(5, 2, 5, 'raw_material', 5, 'LOT-RM005-240315', 268.000000, 270.000000, 13.45, 'adjusted', 'FOUND_STOCK'),
(6, 2, 7, 'raw_material', 7, 'LOT-RM007-240320', 3000.000000, 3000.000000, 1.35, 'counted', NULL),
(7, 2, 10, 'finished_product', 2, 'LOT-FG002-240322', 430.000000, 430.000000, 20.25, 'counted', NULL),

-- CC-001003 details (High Value ABC)
(8, 3, 2, 'raw_material', 2, 'LOT-RM002-240305', 750.000000, 750.000000, 16.80, 'counted', NULL),
(9, 3, 6, 'raw_material', 6, 'LOT-RM006-240318', 1200.000000, 1200.000000, 27.15, 'counted', NULL),
(10, 3, 9, 'finished_product', 1, 'LOT-FG001-240320', 850.000000, 850.000000, 27.80, 'counted', NULL);

-- =====================================================================
-- 11. COST ACCOUNTING DATA
-- =====================================================================

-- Standard Costs
INSERT INTO standard_costs (cost_id, item_type, item_id, cost_type, cost_element, standard_cost, uom_id, effective_date, costing_method, created_by) VALUES
-- Raw Material Standard Costs
(1, 'raw_material', 1, 'material', 'Purchase Cost', 2.50, 1, '2024-01-01', 'standard', 2),
(2, 'raw_material', 2, 'material', 'Purchase Cost', 15.25, 1, '2024-01-01', 'standard', 2),
(3, 'raw_material', 3, 'material', 'Purchase Cost', 0.85, 5, '2024-01-01', 'standard', 2),
(4, 'raw_material', 4, 'material', 'Purchase Cost', 8.50, 1, '2024-01-01', 'standard', 2),
(5, 'raw_material', 5, 'material', 'Purchase Cost', 12.75, 1, '2024-01-01', 'standard', 2),

-- Finished Product Standard Costs
(6, 'finished_product', 1, 'material', 'Raw Materials', 15.50, 5, '2024-01-01', 'standard', 2),
(7, 'finished_product', 1, 'labor', 'Direct Labor', 5.80, 5, '2024-01-01', 'standard', 2),
(8, 'finished_product', 1, 'overhead', 'Manufacturing Overhead', 4.20, 5, '2024-01-01', 'standard', 2),
(9, 'finished_product', 1, 'total', 'Total Cost', 25.50, 5, '2024-01-01', 'standard', 2),

(10, 'finished_product', 2, 'material', 'Raw Materials', 12.25, 5, '2024-01-01', 'standard', 2),
(11, 'finished_product', 2, 'labor', 'Direct Labor', 3.50, 5, '2024-01-01', 'standard', 2),
(12, 'finished_product', 2, 'overhead', 'Manufacturing Overhead', 3.00, 5, '2024-01-01', 'standard', 2),
(13, 'finished_product', 2, 'total', 'Total Cost', 18.75, 5, '2024-01-01', 'standard', 2);

-- Production Variances
INSERT INTO production_variances (variance_id, production_order_id, variance_type, material_id, standard_cost, actual_cost, quantity_standard, quantity_actual, analysis_date, analyzed_by) VALUES
-- Variances for completed production orders
(1, 1, 'material_usage', 1, 2.50, 2.75, 450.000, 459.000, '2024-03-21', 2),
(2, 1, 'material_usage', 4, 8.50, 9.20, 25.000, 25.300, '2024-03-21', 2),
(3, 1, 'material_usage', 3, 0.85, 0.92, 1000.000, 1005.000, '2024-03-21', 2),

(4, 2, 'material_usage', 5, 12.75, 13.45, 15.000, 15.200, '2024-03-23', 2),
(5, 2, 'material_usage', 8, 4.80, 5.20, 12.000, 12.100, '2024-03-23', 2),

(6, 3, 'material_usage', 1, 2.50, 2.75, 800.000, 820.000, '2024-03-26', 2),
(7, 3, 'material_usage', 4, 8.50, 9.20, 45.000, 45.500, '2024-03-26', 2);

-- =====================================================================
-- 12. SYSTEM CONFIGURATION
-- =====================================================================

-- Number Sequences (updating current numbers based on usage)
UPDATE number_sequences SET current_number = 1006 WHERE sequence_name = 'PRODUCTION_ORDER';
UPDATE number_sequences SET current_number = 1007 WHERE sequence_name = 'PURCHASE_ORDER';
UPDATE number_sequences SET current_number = 1006 WHERE sequence_name = 'SALES_ORDER';
UPDATE number_sequences SET current_number = 15 WHERE sequence_name = 'INVENTORY_TRANSACTION';
UPDATE number_sequences SET current_number = 1006 WHERE sequence_name = 'QUALITY_INSPECTION';
UPDATE number_sequences SET current_number = 1006 WHERE sequence_name = 'GOODS_RECEIPT';
UPDATE number_sequences SET current_number = 1004 WHERE sequence_name = 'SHIPMENT';

-- Audit Log (sample entries)
INSERT INTO audit_log (audit_id, table_name, record_id, action, old_values, new_values, user_id, ip_address, created_at) VALUES
(1, 'inventory_master', '2', 'UPDATE', '{"quantity_on_hand": 755.000000}', '{"quantity_on_hand": 750.000000}', 3, '192.168.1.100', '2024-09-15 10:00:00'),
(2, 'inventory_master', '5', 'UPDATE', '{"quantity_on_hand": 268.000000}', '{"quantity_on_hand": 270.000000}', 3, '192.168.1.100', '2024-09-18 14:30:00'),
(3, 'production_orders', '4', 'UPDATE', '{"order_status": "planned"}', '{"order_status": "in_progress", "actual_start_date": "2024-09-25 08:00:00"}', 2, '192.168.1.50', '2024-09-25 08:00:00'),
(4, 'sales_orders', '4', 'UPDATE', '{"so_status": "draft"}', '{"so_status": "confirmed"}', 2, '192.168.1.50', '2024-09-21 14:30:00');

-- =====================================================================
-- 13. VIEWS DATA VERIFICATION QUERIES
-- =====================================================================

-- Query to verify current inventory view
SELECT 
    'Current Inventory Summary' as report_name,
    COUNT(*) as total_items,
    SUM(quantity_on_hand) as total_quantity,
    SUM(total_value) as total_value
FROM v_current_inventory;

-- Query to verify reorder alerts
SELECT 
    'Reorder Alerts' as report_name,
    COUNT(*) as items_below_reorder_level
FROM v_reorder_alerts;

-- Query to verify production status
SELECT 
    'Production Status' as report_name,
    order_status,
    COUNT(*) as order_count,
    SUM(planned_quantity) as total_planned,
    SUM(actual_quantity_produced) as total_produced
FROM v_production_status
GROUP BY order_status;

-- =====================================================================
-- 14. ADDITIONAL REFERENCE DATA
-- =====================================================================

-- Product Substitutes
INSERT INTO product_substitutes (substitute_id, primary_material_id, substitute_material_id, substitution_ratio, priority, effective_date) VALUES
(1, 1, 4, 0.8500, 1, '2024-01-01'),  -- Magnesium Stearate can substitute Sodium Chloride at 85% ratio
(2, 5, 1, 1.2000, 2, '2024-01-01');  -- Sodium Chloride can substitute Titanium Dioxide at 120% ratio (lower priority)

-- Lot Genealogy (traceability)
INSERT INTO lot_genealogy (genealogy_id, parent_lot_id, child_lot_id, production_order_id, quantity_consumed) VALUES
(1, 1, 6, 1, 459.000000),  -- Sodium Chloride lot used in Pain Relief Tablets
(2, 4, 6, 1, 25.300000),   -- Magnesium Stearate lot used in Pain Relief Tablets
(3, 5, 7, 2, 15.200000),   -- Titanium Dioxide lot used in Anti-Wrinkle Serum
(4, 8, 7, 2, 12.100000),   -- Propylene Glycol lot used in Anti-Wrinkle Serum
(5, 1, 8, 3, 820.000000),  -- Sodium Chloride lot used in Vitamin C Tablets
(6, 4, 8, 3, 45.500000);   -- Magnesium Stearate lot used in Vitamin C Tablets

-- Non-Conformance Reports (sample)
INSERT INTO non_conformances (ncr_id, ncr_number, item_type, item_id, lot_number, quantity_affected, nonconformance_type, severity, description, root_cause, corrective_action, status, reported_by, assigned_to, reported_date, target_close_date) VALUES
(1, 'NCR-001001', 'raw_material', 7, 'LOT-RM007-240320', 50.000, 'packaging', 'minor', 'Glass vials have minor cosmetic defects on 50 units', 'Supplier packaging process variation', 'Contacted supplier for process review', 'closed', 4, 3, '2024-03-20 16:00:00', '2024-03-25'),
(2, 'NCR-001002', 'finished_product', 1, 'LOT-FG001-240320', 10.000, 'quality', 'minor', 'Tablet hardness slightly below specification on 10 tablets', 'Compression force variation', 'Adjusted compression settings for next batch', 'closed', 4, 2, '2024-03-21 09:30:00', '2024-03-28');

-- =====================================================================
-- END OF DUMMY DATA
-- =====================================================================

-- Final verification queries
SELECT 'Data Load Summary' as summary_type, 'Raw Materials' as category, COUNT(*) as record_count FROM raw_materials
UNION ALL
SELECT 'Data Load Summary', 'Finished Products', COUNT(*) FROM finished_products
UNION ALL
SELECT 'Data Load Summary', 'BOM Headers', COUNT(*) FROM bom_header
UNION ALL
SELECT 'Data Load Summary', 'BOM Lines', COUNT(*) FROM bom_lines
UNION ALL
SELECT 'Data Load Summary', 'Inventory Records', COUNT(*) FROM inventory_master
UNION ALL
SELECT 'Data Load Summary', 'Production Orders', COUNT(*) FROM production_orders
UNION ALL
SELECT 'Data Load Summary', 'Purchase Orders', COUNT(*) FROM purchase_orders
UNION ALL
SELECT 'Data Load Summary', 'Sales Orders', COUNT(*) FROM sales_orders
UNION ALL
SELECT 'Data Load Summary', 'Quality Inspections', COUNT(*) FROM quality_inspections
UNION ALL
SELECT 'Data Load Summary', 'Inventory Transactions', COUNT(*) FROM inventory_transactions
ORDER BY category;