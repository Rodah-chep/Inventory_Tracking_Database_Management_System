-- =====================================================================
-- COMPREHENSIVE MANUFACTURING COMPANY INVENTORY TRACKING DATABASE MANAGEMENT SYSTEM
-- =====================================================================

-- Creatind database manufacturing_inventory;
CREATE DATABASE manufacturing_inventory;
USE manufacturing_inventory;

-- =====================================================================
-- 1. MASTER DATA TABLES (Reference Tables)
-- =====================================================================

-- Companies and Organizational Structure
CREATE TABLE companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(255) NOT NULL,
    company_code VARCHAR(20) UNIQUE NOT NULL,
    company_type ENUM('main', 'subsidiary', 'division') DEFAULT 'main',
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100),
    tax_id VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Locations and Warehouses
CREATE TABLE locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    location_code VARCHAR(20) UNIQUE NOT NULL,
    location_name VARCHAR(255) NOT NULL,
    location_type ENUM('warehouse', 'production_floor', 'staging_area', 'quality_lab', 'shipping_dock', 'receiving_dock') NOT NULL,
    company_id INT NOT NULL,
    parent_location_id INT NULL, -- For hierarchical locations (building > floor > room)
    address TEXT,
    capacity_cubic_meters DECIMAL(10,2),
    temperature_controlled BOOLEAN DEFAULT FALSE,
    temperature_min DECIMAL(5,2),
    temperature_max DECIMAL(5,2),
    humidity_controlled BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (company_id) REFERENCES companies(company_id),
    FOREIGN KEY (parent_location_id) REFERENCES locations(location_id)
);

-- Storage Bins/Zones within Locations
CREATE TABLE storage_bins (
    bin_id INT PRIMARY KEY AUTO_INCREMENT,
    bin_code VARCHAR(30) UNIQUE NOT NULL,
    location_id INT NOT NULL,
    bin_type ENUM('shelf', 'floor', 'rack', 'tank', 'silo') DEFAULT 'shelf',
    aisle VARCHAR(10),
    row_number VARCHAR(10),
    level_number VARCHAR(10),
    capacity_kg DECIMAL(10,2),
    capacity_cubic_meters DECIMAL(10,2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

-- Product Categories
CREATE TABLE product_categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_code VARCHAR(20) UNIQUE NOT NULL,
    category_name VARCHAR(255) NOT NULL,
    parent_category_id INT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_category_id) REFERENCES product_categories(category_id)
);

-- Units of Measure
CREATE TABLE units_of_measure (
    uom_id INT PRIMARY KEY AUTO_INCREMENT,
    uom_code VARCHAR(10) UNIQUE NOT NULL,
    uom_name VARCHAR(50) NOT NULL,
    uom_type ENUM('weight', 'volume', 'length', 'area', 'count', 'time') NOT NULL,
    base_unit_id INT NULL, -- For unit conversions
    conversion_factor DECIMAL(15,6) DEFAULT 1.000000,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (base_unit_id) REFERENCES units_of_measure(uom_id)
);

-- Suppliers/Vendors
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_code VARCHAR(30) UNIQUE NOT NULL,
    supplier_name VARCHAR(255) NOT NULL,
    supplier_type ENUM('material', 'service', 'equipment', 'packaging') NOT NULL,
    contact_person VARCHAR(100),
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100),
    tax_id VARCHAR(50),
    payment_terms VARCHAR(100),
    lead_time_days INT DEFAULT 0,
    quality_rating DECIMAL(3,2) DEFAULT 0.00,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_code VARCHAR(30) UNIQUE NOT NULL,
    customer_name VARCHAR(255) NOT NULL,
    customer_type ENUM('retail', 'wholesale', 'distributor', 'oem') NOT NULL,
    contact_person VARCHAR(100),
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100),
    credit_limit DECIMAL(12,2) DEFAULT 0.00,
    payment_terms VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Users and Employees
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    employee_id VARCHAR(30) UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'production_manager', 'inventory_clerk', 'quality_inspector', 'operator', 'viewer') NOT NULL,
    department VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    last_login TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =====================================================================
-- 2. PRODUCT AND MATERIAL MASTER DATA
-- =====================================================================

-- Raw Materials and Components
CREATE TABLE raw_materials (
    material_id INT PRIMARY KEY AUTO_INCREMENT,
    material_code VARCHAR(50) UNIQUE NOT NULL,
    material_name VARCHAR(255) NOT NULL,
    material_description TEXT,
    category_id INT NOT NULL,
    primary_uom_id INT NOT NULL,
    secondary_uom_id INT NULL, -- For dual unit materials
    conversion_factor DECIMAL(10,4) DEFAULT 1.0000,
    material_type ENUM('raw_material', 'component', 'packaging', 'consumable', 'tool') NOT NULL,
    supplier_id INT NULL, -- Primary supplier
    standard_cost DECIMAL(12,4) NOT NULL DEFAULT 0.0000,
    current_cost DECIMAL(12,4) NOT NULL DEFAULT 0.0000,
    reorder_level DECIMAL(12,3) DEFAULT 0.000,
    reorder_quantity DECIMAL(12,3) DEFAULT 0.000,
    safety_stock DECIMAL(12,3) DEFAULT 0.000,
    lead_time_days INT DEFAULT 0,
    shelf_life_days INT NULL,
    storage_temperature_min DECIMAL(5,2) NULL,
    storage_temperature_max DECIMAL(5,2) NULL,
    storage_humidity_min DECIMAL(5,2) NULL,
    storage_humidity_max DECIMAL(5,2) NULL,
    hazardous_material BOOLEAN DEFAULT FALSE,
    quality_control_required BOOLEAN DEFAULT FALSE,
    lot_controlled BOOLEAN DEFAULT TRUE,
    serial_controlled BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES product_categories(category_id),
    FOREIGN KEY (primary_uom_id) REFERENCES units_of_measure(uom_id),
    FOREIGN KEY (secondary_uom_id) REFERENCES units_of_measure(uom_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- Finished Products
CREATE TABLE finished_products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_code VARCHAR(50) UNIQUE NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    product_description TEXT,
    category_id INT NOT NULL,
    primary_uom_id INT NOT NULL,
    secondary_uom_id INT NULL,
    conversion_factor DECIMAL(10,4) DEFAULT 1.0000,
    product_family VARCHAR(100),
    standard_cost DECIMAL(12,4) NOT NULL DEFAULT 0.0000,
    current_cost DECIMAL(12,4) NOT NULL DEFAULT 0.0000,
    selling_price DECIMAL(12,4) NOT NULL DEFAULT 0.0000,
    production_time_minutes INT DEFAULT 0,
    batch_size DECIMAL(12,3) DEFAULT 1.000,
    shelf_life_days INT NULL,
    quality_control_required BOOLEAN DEFAULT TRUE,
    lot_controlled BOOLEAN DEFAULT TRUE,
    serial_controlled BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES product_categories(category_id),
    FOREIGN KEY (primary_uom_id) REFERENCES units_of_measure(uom_id),
    FOREIGN KEY (secondary_uom_id) REFERENCES units_of_measure(uom_id)
);

-- Bill of Materials (BOM) Header
CREATE TABLE bom_header (
    bom_id INT PRIMARY KEY AUTO_INCREMENT,
    bom_code VARCHAR(50) UNIQUE NOT NULL,
    product_id INT NOT NULL,
    bom_version VARCHAR(20) DEFAULT '1.0',
    bom_type ENUM('manufacturing', 'engineering', 'planning') DEFAULT 'manufacturing',
    base_quantity DECIMAL(12,3) DEFAULT 1.000, -- BOM for this quantity of finished product
    effective_date DATE NOT NULL,
    expiry_date DATE NULL,
    status ENUM('draft', 'active', 'inactive', 'obsolete') DEFAULT 'draft',
    created_by INT NOT NULL,
    approved_by INT NULL,
    approved_date DATE NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES finished_products(product_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    FOREIGN KEY (approved_by) REFERENCES users(user_id)
);

-- Bill of Materials (BOM) Lines
CREATE TABLE bom_lines (
    bom_line_id INT PRIMARY KEY AUTO_INCREMENT,
    bom_id INT NOT NULL,
    line_number INT NOT NULL,
    material_id INT NOT NULL,
    quantity_required DECIMAL(12,6) NOT NULL,
    uom_id INT NOT NULL,
    scrap_percentage DECIMAL(5,2) DEFAULT 0.00,
    operation_sequence INT DEFAULT 10,
    is_critical_component BOOLEAN DEFAULT FALSE,
    substitute_allowed BOOLEAN DEFAULT FALSE,
    notes TEXT,
    effective_date DATE NOT NULL,
    expiry_date DATE NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bom_id) REFERENCES bom_header(bom_id) ON DELETE CASCADE,
    FOREIGN KEY (material_id) REFERENCES raw_materials(material_id),
    FOREIGN KEY (uom_id) REFERENCES units_of_measure(uom_id),
    UNIQUE KEY unique_bom_line (bom_id, line_number)
);

-- Product Substitutes/Alternatives
CREATE TABLE product_substitutes (
    substitute_id INT PRIMARY KEY AUTO_INCREMENT,
    primary_material_id INT NOT NULL,
    substitute_material_id INT NOT NULL,
    substitution_ratio DECIMAL(10,4) DEFAULT 1.0000,
    priority INT DEFAULT 1,
    notes TEXT,
    effective_date DATE NOT NULL,
    expiry_date DATE NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (primary_material_id) REFERENCES raw_materials(material_id),
    FOREIGN KEY (substitute_material_id) REFERENCES raw_materials(material_id)
);

-- =====================================================================
-- 3. INVENTORY MASTER AND TRACKING
-- =====================================================================

-- Inventory Master (All Items)
CREATE TABLE inventory_master (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    item_type ENUM('raw_material', 'work_in_progress', 'finished_product', 'packaging', 'tool', 'consumable') NOT NULL,
    item_id INT NOT NULL, -- References raw_materials.material_id or finished_products.product_id
    location_id INT NOT NULL,
    bin_id INT NULL,
    lot_number VARCHAR(50) NOT NULL,
    serial_number VARCHAR(100) NULL,
    quantity_on_hand DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    quantity_reserved DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    quantity_allocated DECIMAL(15,6) NOT NULL DEFAULT 0.000000,
    quantity_available AS (quantity_on_hand - quantity_reserved - quantity_allocated) STORED,
    unit_cost DECIMAL(12,4) NOT NULL DEFAULT 0.0000,
    total_value AS (quantity_on_hand * unit_cost) STORED,
    manufacturing_date DATE NULL,
    expiration_date DATE NULL,
    received_date DATE NOT NULL,
    last_movement_date TIMESTAMP NULL,
    status ENUM('available', 'quarantine', 'rejected', 'expired', 'damaged') DEFAULT 'available',
    quality_status ENUM('pending', 'approved', 'rejected', 'hold') DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (location_id) REFERENCES locations(location_id),
    FOREIGN KEY (bin_id) REFERENCES storage_bins(bin_id),
    INDEX idx_item_lookup (item_type, item_id),
    INDEX idx_lot_lookup (lot_number),
    INDEX idx_location_lookup (location_id),
    UNIQUE KEY unique_inventory_item (item_type, item_id, location_id, lot_number, serial_number)
);

-- Inventory Transactions (All Movements)
CREATE TABLE inventory_transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_number VARCHAR(50) UNIQUE NOT NULL,
    inventory_id INT NOT NULL,
    transaction_type ENUM(
        'receipt', 'issue', 'transfer', 'adjustment', 'production_receipt', 
        'production_issue', 'shipment', 'return', 'scrap', 'cycle_count'
    ) NOT NULL,
    reference_type ENUM(
        'purchase_order', 'production_order', 'sales_order', 'transfer_order', 
        'adjustment', 'cycle_count', 'return', 'scrap'
    ) NOT NULL,
    reference_number VARCHAR(50) NOT NULL,
    quantity_change DECIMAL(15,6) NOT NULL, -- Positive for receipts, negative for issues
    unit_cost DECIMAL(12,4) NOT NULL DEFAULT 0.0000,
    total_value AS (quantity_change * unit_cost) STORED,
    from_location_id INT NULL,
    to_location_id INT NULL,
    from_bin_id INT NULL,
    to_bin_id INT NULL,
    reason_code VARCHAR(50),
    notes TEXT,
    transaction_date DATETIME NOT NULL,
    created_by INT NOT NULL,
    approved_by INT NULL,
    approved_date DATETIME NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (inventory_id) REFERENCES inventory_master(inventory_id),
    FOREIGN KEY (from_location_id) REFERENCES locations(location_id),
    FOREIGN KEY (to_location_id) REFERENCES locations(location_id),
    FOREIGN KEY (from_bin_id) REFERENCES storage_bins(bin_id),
    FOREIGN KEY (to_bin_id) REFERENCES storage_bins(bin_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    FOREIGN KEY (approved_by) REFERENCES users(user_id),
    INDEX idx_transaction_date (transaction_date),
    INDEX idx_reference (reference_type, reference_number)
);

-- Lot Master for Traceability
CREATE TABLE lot_master (
    lot_id INT PRIMARY KEY AUTO_INCREMENT,
    lot_number VARCHAR(50) UNIQUE NOT NULL,
    item_type ENUM('raw_material', 'finished_product') NOT NULL,
    item_id INT NOT NULL,
    supplier_lot VARCHAR(50) NULL, -- Supplier's lot number
    manufacturing_date DATE NULL,
    expiration_date DATE NULL,
    quantity_produced DECIMAL(15,6) NULL,
    quality_status ENUM('pending', 'approved', 'rejected', 'hold') DEFAULT 'pending',
    created_date DATE NOT NULL,
    created_by INT NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    INDEX idx_lot_item (item_type, item_id)
);

-- Lot Genealogy for Complete Traceability
CREATE TABLE lot_genealogy (
    genealogy_id INT PRIMARY KEY AUTO_INCREMENT,
    parent_lot_id INT NOT NULL, -- Raw material lot
    child_lot_id INT NOT NULL,  -- Finished product lot
    production_order_id INT NOT NULL,
    quantity_consumed DECIMAL(15,6) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_lot_id) REFERENCES lot_master(lot_id),
    FOREIGN KEY (child_lot_id) REFERENCES lot_master(lot_id),
    INDEX idx_parent_child (parent_lot_id, child_lot_id)
);

-- =====================================================================
-- 4. PRODUCTION MANAGEMENT
-- =====================================================================

-- Production Orders
CREATE TABLE production_orders (
    production_order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_number VARCHAR(50) UNIQUE NOT NULL,
    product_id INT NOT NULL,
    bom_id INT NOT NULL,
    planned_quantity DECIMAL(12,3) NOT NULL,
    actual_quantity_produced DECIMAL(12,3) DEFAULT 0.000,
    actual_quantity_scrapped DECIMAL(12,3) DEFAULT 0.000,
    order_status ENUM('planned', 'released', 'in_progress', 'completed', 'cancelled', 'hold') DEFAULT 'planned',
    priority ENUM('low', 'normal', 'high', 'urgent') DEFAULT 'normal',
    production_line VARCHAR(100),
    scheduled_start_date DATETIME,
    scheduled_end_date DATETIME,
    actual_start_date DATETIME NULL,
    actual_end_date DATETIME NULL,
    lot_number VARCHAR(50) NOT NULL,
    quality_status ENUM('pending', 'approved', 'rejected', 'rework') DEFAULT 'pending',
    standard_cost DECIMAL(12,4) DEFAULT 0.0000,
    actual_cost DECIMAL(12,4) DEFAULT 0.0000,
    created_by INT NOT NULL,
    released_by INT NULL,
    completed_by INT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES finished_products(product_id),
    FOREIGN KEY (bom_id) REFERENCES bom_header(bom_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    FOREIGN KEY (released_by) REFERENCES users(user_id),
    FOREIGN KEY (completed_by) REFERENCES users(user_id),
    INDEX idx_order_status_date (order_status, scheduled_start_date),
    INDEX idx_product_date (product_id, scheduled_start_date)
);

-- Material Reservations
CREATE TABLE material_reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    production_order_id INT NOT NULL,
    material_id INT NOT NULL,
    inventory_id INT NOT NULL,
    quantity_reserved DECIMAL(15,6) NOT NULL,
    quantity_issued DECIMAL(15,6) DEFAULT 0.000000,
    reservation_date DATETIME NOT NULL,
    required_date DATETIME NOT NULL,
    status ENUM('active', 'partial_issued', 'fully_issued', 'cancelled') DEFAULT 'active',
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (production_order_id) REFERENCES production_orders(production_order_id),
    FOREIGN KEY (material_id) REFERENCES raw_materials(material_id),
    FOREIGN KEY (inventory_id) REFERENCES inventory_master(inventory_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- Material Consumption
CREATE TABLE material_consumption (
    consumption_id INT PRIMARY KEY AUTO_INCREMENT,
    production_order_id INT NOT NULL,
    material_id INT NOT NULL,
    inventory_id INT NOT NULL,
    quantity_planned DECIMAL(15,6) NOT NULL,
    quantity_issued DECIMAL(15,6) NOT NULL,
    unit_cost DECIMAL(12,4) NOT NULL,
    total_cost AS (quantity_issued * unit_cost) STORED,
    issue_date DATETIME NOT NULL,
    issued_by INT NOT NULL,
    operation_sequence INT DEFAULT 10,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (production_order_id) REFERENCES production_orders(production_order_id),
    FOREIGN KEY (material_id) REFERENCES raw_materials(material_id),
    FOREIGN KEY (inventory_id) REFERENCES inventory_master(inventory_id),
    FOREIGN KEY (issued_by) REFERENCES users(user_id)
);

-- Production Receipts
CREATE TABLE production_receipts (
    receipt_id INT PRIMARY KEY AUTO_INCREMENT,
    production_order_id INT NOT NULL,
    quantity_produced DECIMAL(12,3) NOT NULL,
    quantity_scrapped DECIMAL(12,3) DEFAULT 0.000,
    lot_number VARCHAR(50) NOT NULL,
    location_id INT NOT NULL,
    bin_id INT NULL,
    production_date DATETIME NOT NULL,
    quality_status ENUM('pending', 'approved', 'rejected', 'rework') DEFAULT 'pending',
    received_by INT NOT NULL,
    inspected_by INT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (production_order_id) REFERENCES production_orders(production_order_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id),
    FOREIGN KEY (bin_id) REFERENCES storage_bins(bin_id),
    FOREIGN KEY (received_by) REFERENCES users(user_id),
    FOREIGN KEY (inspected_by) REFERENCES users(user_id)
);

-- =====================================================================
-- 5. QUALITY CONTROL AND INSPECTION
-- =====================================================================

-- Quality Control Plans
CREATE TABLE quality_control_plans (
    qc_plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_code VARCHAR(50) UNIQUE NOT NULL,
    item_type ENUM('raw_material', 'finished_product') NOT NULL,
    item_id INT NOT NULL,
    inspection_type ENUM('incoming', 'in_process', 'final', 'supplier_audit') NOT NULL,
    sampling_method ENUM('100_percent', 'statistical', 'random') DEFAULT 'statistical',
    sample_size INT DEFAULT 1,
    frequency VARCHAR(100), -- e.g., "Every lot", "Daily", "Weekly"
    effective_date DATE NOT NULL,
    expiry_date DATE NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    INDEX idx_item_inspection (item_type, item_id, inspection_type)
);

-- Quality Control Tests
CREATE TABLE quality_control_tests (
    test_id INT PRIMARY KEY AUTO_INCREMENT,
    qc_plan_id INT NOT NULL,
    test_code VARCHAR(50) NOT NULL,
    test_name VARCHAR(255) NOT NULL,
    test_method VARCHAR(255),
    specification_min DECIMAL(12,6) NULL,
    specification_max DECIMAL(12,6) NULL,
    target_value DECIMAL(12,6) NULL,
    uom_id INT NULL,
    test_order INT DEFAULT 10,
    is_critical BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (qc_plan_id) REFERENCES quality_control_plans(qc_plan_id) ON DELETE CASCADE,
    FOREIGN KEY (uom_id) REFERENCES units_of_measure(uom_id)
);

-- Quality Inspections
CREATE TABLE quality_inspections (
    inspection_id INT PRIMARY KEY AUTO_INCREMENT,
    inspection_number VARCHAR(50) UNIQUE NOT NULL,
    qc_plan_id INT NOT NULL,
    item_type ENUM('raw_material', 'finished_product') NOT NULL,
    item_id INT NOT NULL,
    lot_number VARCHAR(50) NOT NULL,
    quantity_inspected DECIMAL(12,3) NOT NULL,
    inspection_date DATETIME NOT NULL,
    inspector_id INT NOT NULL,
    overall_result ENUM('pass', 'fail', 'conditional_pass', 'pending') DEFAULT 'pending',
    reference_type ENUM('purchase_order', 'production_order', 'inventory') NOT NULL,
    reference_number VARCHAR(50) NOT NULL,
    notes TEXT,
    approved_by INT NULL,
    approved_date DATETIME NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (qc_plan_id) REFERENCES quality_control_plans(qc_plan_id),
    FOREIGN KEY (inspector_id) REFERENCES users(user_id),
    FOREIGN KEY (approved_by) REFERENCES users(user_id),
    INDEX idx_lot_inspection (lot_number, inspection_date)
);

-- Quality Test Results
CREATE TABLE quality_test_results (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    inspection_id INT NOT NULL,
    test_id INT NOT NULL,
    measured_value DECIMAL(12,6) NULL,
    text_result TEXT NULL,
    result_status ENUM('pass', 'fail', 'na', 'pending') NOT NULL,
    deviation_percentage DECIMAL(8,4) NULL,
    notes TEXT,
    tested_by INT NOT NULL,
    test_date DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (inspection_id) REFERENCES quality_inspections(inspection_id) ON DELETE CASCADE,
    FOREIGN KEY (test_id) REFERENCES quality_control_tests(test_id),
    FOREIGN KEY (tested_by) REFERENCES users(user_id)
);

-- Non-Conformance Reports
CREATE TABLE non_conformances (
    ncr_id INT PRIMARY KEY AUTO_INCREMENT,
    ncr_number VARCHAR(50) UNIQUE NOT NULL,
    item_type ENUM('raw_material', 'finished_product') NOT NULL,
    item_id INT NOT NULL,
    lot_number VARCHAR(50) NOT NULL,
    quantity_affected DECIMAL(12,3) NOT NULL,
    nonconformance_type ENUM('quality', 'packaging', 'labeling', 'documentation', 'other') NOT NULL,
    severity ENUM('minor', 'major', 'critical') NOT NULL,
    description TEXT NOT NULL,
    root_cause TEXT,
    corrective_action TEXT,
    preventive_action TEXT,
    status ENUM('open', 'investigating', 'corrective_action', 'closed', 'rejected') DEFAULT 'open',
    reported_by INT NOT NULL,
    assigned_to INT NULL,
    reported_date DATETIME NOT NULL,
    target_close_date DATE NULL,
    actual_close_date DATE NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (reported_by) REFERENCES users(user_id),
    FOREIGN KEY (assigned_to) REFERENCES users(user_id)
);

-- =====================================================================
-- 6. PURCHASING AND RECEIVING
-- =====================================================================

-- Purchase Orders
CREATE TABLE purchase_orders (
    po_id INT PRIMARY KEY AUTO_INCREMENT,
    po_number VARCHAR(50) UNIQUE NOT NULL,
    supplier_id INT NOT NULL,
    po_date DATE NOT NULL,
    required_date DATE NOT NULL,
    po_status ENUM('draft', 'sent', 'acknowledged', 'partial_received', 'completed', 'cancelled') DEFAULT 'draft',
    payment_terms VARCHAR(100),
    delivery_terms VARCHAR(100),
    currency_code VARCHAR(3) DEFAULT 'USD',
    exchange_rate DECIMAL(10,6) DEFAULT 1.000000,
    subtotal DECIMAL(12,2) DEFAULT 0.00,
    tax_amount DECIMAL(12,2) DEFAULT 0.00,
    total_amount DECIMAL(12,2) DEFAULT 0.00,
    created_by INT NOT NULL,
    approved_by INT NULL,
    approved_date DATE NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    FOREIGN KEY (approved_by) REFERENCES users(user_id)
);

-- Purchase Order Lines
CREATE TABLE purchase_order_lines (
    po_line_id INT PRIMARY KEY AUTO_INCREMENT,
    po_id INT NOT NULL,
    line_number INT NOT NULL,
    material_id INT NOT NULL,
    quantity_ordered DECIMAL(12,3) NOT NULL,
    quantity_received DECIMAL(12,3) DEFAULT 0.000,
    quantity_cancelled DECIMAL(12,3) DEFAULT 0.000,
    unit_price DECIMAL(12,4) NOT NULL,
    total_price AS (quantity_ordered * unit_price) STORED,
    uom_id INT NOT NULL,
    required_date DATE NOT NULL,
    line_status ENUM('open', 'partial_received', 'completed', 'cancelled') DEFAULT 'open',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (po_id) REFERENCES purchase_orders(po_id) ON DELETE CASCADE,
    FOREIGN KEY (material_id) REFERENCES raw_materials(material_id),
    FOREIGN KEY (uom_id) REFERENCES units_of_measure(uom_id),
    UNIQUE KEY unique_po_line (po_id, line_number)
);

-- Goods Receipts
CREATE TABLE goods_receipts (
    receipt_id INT PRIMARY KEY AUTO_INCREMENT,
    receipt_number VARCHAR(50) UNIQUE NOT NULL,
    po_id INT NOT NULL,
    supplier_id INT NOT NULL,
    receipt_date DATETIME NOT NULL,
    delivery_note VARCHAR(50),
    vehicle_number VARCHAR(20),
    driver_name VARCHAR(100),
    received_by INT NOT NULL,
    receipt_status ENUM('draft', 'completed', 'cancelled') DEFAULT 'draft',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (po_id) REFERENCES purchase_orders(po_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (received_by) REFERENCES users(user_id)
);

-- Goods Receipt Lines
CREATE TABLE goods_receipt_lines (
    receipt_line_id INT PRIMARY KEY AUTO_INCREMENT,
    receipt_id INT NOT NULL,
    po_line_id INT NOT NULL,
    material_id INT NOT NULL,
    quantity_received DECIMAL(12,3) NOT NULL,
    quantity_rejected DECIMAL(12,3) DEFAULT 0.000,
    lot_number VARCHAR(50) NOT NULL,
    expiry_date DATE NULL,
    unit_cost DECIMAL(12,4) NOT NULL,
    total_cost AS (quantity_received * unit_cost) STORED,
    location_id INT NOT NULL,
    bin_id INT NULL,
    quality_status ENUM('pending', 'approved', 'rejected', 'quarantine') DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (receipt_id) REFERENCES goods_receipts(receipt_id) ON DELETE CASCADE,
    FOREIGN KEY (po_line_id) REFERENCES purchase_order_lines(po_line_id),
    FOREIGN KEY (material_id) REFERENCES raw_materials(material_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id),
    FOREIGN KEY (bin_id) REFERENCES storage_bins(bin_id)
);

-- =====================================================================
-- 7. SALES AND SHIPPING
-- =====================================================================

-- Sales Orders
CREATE TABLE sales_orders (
    so_id INT PRIMARY KEY AUTO_INCREMENT,
    so_number VARCHAR(50) UNIQUE NOT NULL,
    customer_id INT NOT NULL,
    so_date DATE NOT NULL,
    required_date DATE NOT NULL,
    so_status ENUM('draft', 'confirmed', 'in_production', 'ready_to_ship', 'shipped', 'delivered', 'cancelled') DEFAULT 'draft',
    priority ENUM('low', 'normal', 'high', 'urgent') DEFAULT 'normal',
    payment_terms VARCHAR(100),
    delivery_terms VARCHAR(100),
    shipping_address TEXT,
    currency_code VARCHAR(3) DEFAULT 'USD',
    exchange_rate DECIMAL(10,6) DEFAULT 1.000000,
    subtotal DECIMAL(12,2) DEFAULT 0.00,
    tax_amount DECIMAL(12,2) DEFAULT 0.00,
    total_amount DECIMAL(12,2) DEFAULT 0.00,
    created_by INT NOT NULL,
    approved_by INT NULL,
    approved_date DATE NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    FOREIGN KEY (approved_by) REFERENCES users(user_id)
);

-- Sales Order Lines
CREATE TABLE sales_order_lines (
    so_line_id INT PRIMARY KEY AUTO_INCREMENT,
    so_id INT NOT NULL,
    line_number INT NOT NULL,
    product_id INT NOT NULL,
    quantity_ordered DECIMAL(12,3) NOT NULL,
    quantity_shipped DECIMAL(12,3) DEFAULT 0.000,
    quantity_cancelled DECIMAL(12,3) DEFAULT 0.000,
    unit_price DECIMAL(12,4) NOT NULL,
    total_price AS (quantity_ordered * unit_price) STORED,
    uom_id INT NOT NULL,
    required_date DATE NOT NULL,
    line_status ENUM('open', 'allocated', 'partial_shipped', 'completed', 'cancelled') DEFAULT 'open',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (so_id) REFERENCES sales_orders(so_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES finished_products(product_id),
    FOREIGN KEY (uom_id) REFERENCES units_of_measure(uom_id),
    UNIQUE KEY unique_so_line (so_id, line_number)
);

-- Shipments
CREATE TABLE shipments (
    shipment_id INT PRIMARY KEY AUTO_INCREMENT,
    shipment_number VARCHAR(50) UNIQUE NOT NULL,
    so_id INT NOT NULL,
    customer_id INT NOT NULL,
    shipment_date DATETIME NOT NULL,
    carrier VARCHAR(100),
    tracking_number VARCHAR(100),
    vehicle_number VARCHAR(20),
    driver_name VARCHAR(100),
    shipping_address TEXT,
    shipment_status ENUM('planned', 'in_transit', 'delivered', 'returned', 'cancelled') DEFAULT 'planned',
    shipped_by INT NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (so_id) REFERENCES sales_orders(so_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (shipped_by) REFERENCES users(user_id)
);

-- Shipment Lines
CREATE TABLE shipment_lines (
    shipment_line_id INT PRIMARY KEY AUTO_INCREMENT,
    shipment_id INT NOT NULL,
    so_line_id INT NOT NULL,
    product_id INT NOT NULL,
    inventory_id INT NOT NULL,
    quantity_shipped DECIMAL(12,3) NOT NULL,
    lot_number VARCHAR(50) NOT NULL,
    serial_numbers TEXT, -- JSON array for serialized items
    expiry_date DATE NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id) ON DELETE CASCADE,
    FOREIGN KEY (so_line_id) REFERENCES sales_order_lines(so_line_id),
    FOREIGN KEY (product_id) REFERENCES finished_products(product_id),
    FOREIGN KEY (inventory_id) REFERENCES inventory_master(inventory_id)
);

-- =====================================================================
-- 8. INVENTORY PLANNING AND MRP
-- =====================================================================

-- Demand Forecast
CREATE TABLE demand_forecast (
    forecast_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    forecast_period VARCHAR(20) NOT NULL, -- YYYY-MM or YYYY-WW
    forecast_quantity DECIMAL(12,3) NOT NULL,
    actual_quantity DECIMAL(12,3) DEFAULT 0.000,
    forecast_type ENUM('statistical', 'manual', 'customer_forecast') NOT NULL,
    confidence_level DECIMAL(5,2) DEFAULT 50.00,
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES finished_products(product_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    UNIQUE KEY unique_product_period (product_id, forecast_period)
);

-- MRP Master Schedule
CREATE TABLE master_production_schedule (
    mps_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    period_start_date DATE NOT NULL,
    period_end_date DATE NOT NULL,
    planned_production DECIMAL(12,3) NOT NULL,
    actual_production DECIMAL(12,3) DEFAULT 0.000,
    committed_orders DECIMAL(12,3) DEFAULT 0.000,
    available_to_promise DECIMAL(12,3) DEFAULT 0.000,
    schedule_status ENUM('draft', 'firm', 'released') DEFAULT 'draft',
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES finished_products(product_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- Material Requirements Planning
CREATE TABLE material_requirements (
    requirement_id INT PRIMARY KEY AUTO_INCREMENT,
    material_id INT NOT NULL,
    requirement_date DATE NOT NULL,
    gross_requirement DECIMAL(12,3) NOT NULL,
    scheduled_receipts DECIMAL(12,3) DEFAULT 0.000,
    projected_on_hand DECIMAL(12,3) DEFAULT 0.000,
    net_requirement DECIMAL(12,3) DEFAULT 0.000,
    planned_order_release DECIMAL(12,3) DEFAULT 0.000,
    source_type ENUM('sales_order', 'production_order', 'forecast', 'safety_stock') NOT NULL,
    source_reference VARCHAR(50),
    mrp_run_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (material_id) REFERENCES raw_materials(material_id),
    INDEX idx_material_date (material_id, requirement_date)
);

-- Inventory Reorder Suggestions
CREATE TABLE reorder_suggestions (
    suggestion_id INT PRIMARY KEY AUTO_INCREMENT,
    item_type ENUM('raw_material', 'finished_product') NOT NULL,
    item_id INT NOT NULL,
    current_stock DECIMAL(12,3) NOT NULL,
    reorder_level DECIMAL(12,3) NOT NULL,
    suggested_quantity DECIMAL(12,3) NOT NULL,
    supplier_id INT NULL,
    lead_time_days INT DEFAULT 0,
    required_date DATE NOT NULL,
    suggestion_date DATE NOT NULL,
    status ENUM('pending', 'approved', 'po_created', 'rejected') DEFAULT 'pending',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- =====================================================================
-- 9. COST ACCOUNTING AND VARIANCE ANALYSIS
-- =====================================================================

-- Standard Costs
CREATE TABLE standard_costs (
    cost_id INT PRIMARY KEY AUTO_INCREMENT,
    item_type ENUM('raw_material', 'finished_product') NOT NULL,
    item_id INT NOT NULL,
    cost_type ENUM('material', 'labor', 'overhead', 'total') NOT NULL,
    cost_element VARCHAR(100), -- Specific cost component
    standard_cost DECIMAL(12,4) NOT NULL,
    uom_id INT NOT NULL,
    effective_date DATE NOT NULL,
    expiry_date DATE NULL,
    costing_method ENUM('standard', 'average', 'fifo', 'lifo') DEFAULT 'standard',
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (uom_id) REFERENCES units_of_measure(uom_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    INDEX idx_item_cost_date (item_type, item_id, cost_type, effective_date)
);

-- Production Cost Variance
CREATE TABLE production_variances (
    variance_id INT PRIMARY KEY AUTO_INCREMENT,
    production_order_id INT NOT NULL,
    variance_type ENUM('material_price', 'material_usage', 'labor_rate', 'labor_efficiency', 'overhead') NOT NULL,
    material_id INT NULL,
    standard_cost DECIMAL(12,4) NOT NULL,
    actual_cost DECIMAL(12,4) NOT NULL,
    variance_amount AS (actual_cost - standard_cost) STORED,
    variance_percentage AS ((actual_cost - standard_cost) / NULLIF(standard_cost, 0) * 100) STORED,
    quantity_standard DECIMAL(12,3) DEFAULT 0.000,
    quantity_actual DECIMAL(12,3) DEFAULT 0.000,
    analysis_date DATE NOT NULL,
    analyzed_by INT NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (production_order_id) REFERENCES production_orders(production_order_id),
    FOREIGN KEY (material_id) REFERENCES raw_materials(material_id),
    FOREIGN KEY (analyzed_by) REFERENCES users(user_id)
);

-- =====================================================================
-- 10. CYCLE COUNTING AND PHYSICAL INVENTORY
-- =====================================================================

-- Cycle Count Plans
CREATE TABLE cycle_count_plans (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    plan_name VARCHAR(255) NOT NULL,
    count_frequency ENUM('daily', 'weekly', 'monthly', 'quarterly', 'annual') NOT NULL,
    count_type ENUM('abc_analysis', 'location_based', 'random', 'exception_based') NOT NULL,
    location_id INT NULL, -- NULL for all locations
    category_id INT NULL, -- NULL for all categories
    last_count_date DATE NULL,
    next_count_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (location_id) REFERENCES locations(location_id),
    FOREIGN KEY (category_id) REFERENCES product_categories(category_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- Cycle Count Headers
CREATE TABLE cycle_count_headers (
    count_header_id INT PRIMARY KEY AUTO_INCREMENT,
    count_number VARCHAR(50) UNIQUE NOT NULL,
    plan_id INT NULL,
    count_date DATE NOT NULL,
    count_type ENUM('cycle', 'physical', 'spot') NOT NULL,
    location_id INT NULL,
    count_status ENUM('planned', 'in_progress', 'completed', 'cancelled') DEFAULT 'planned',
    counted_by INT NOT NULL,
    reviewed_by INT NULL,
    approved_by INT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (plan_id) REFERENCES cycle_count_plans(plan_id),
    FOREIGN KEY (location_id) REFERENCES locations(location_id),
    FOREIGN KEY (counted_by) REFERENCES users(user_id),
    FOREIGN KEY (reviewed_by) REFERENCES users(user_id),
    FOREIGN KEY (approved_by) REFERENCES users(user_id)
);

-- Cycle Count Details
CREATE TABLE cycle_count_details (
    count_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    count_header_id INT NOT NULL,
    inventory_id INT NOT NULL,
    item_type ENUM('raw_material', 'finished_product', 'wip') NOT NULL,
    item_id INT NOT NULL,
    lot_number VARCHAR(50),
    book_quantity DECIMAL(15,6) NOT NULL,
    counted_quantity DECIMAL(15,6) NULL,
    variance_quantity AS (counted_quantity - book_quantity) STORED,
    variance_value AS (variance_quantity * unit_cost) STORED,
    unit_cost DECIMAL(12,4) NOT NULL,
    count_status ENUM('not_counted', 'counted', 'recounted', 'adjusted') DEFAULT 'not_counted',
    recount_required BOOLEAN DEFAULT FALSE,
    reason_code VARCHAR(50),
    notes TEXT,
    counted_at DATETIME NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (count_header_id) REFERENCES cycle_count_headers(count_header_id) ON DELETE CASCADE,
    FOREIGN KEY (inventory_id) REFERENCES inventory_master(inventory_id)
);

-- =====================================================================
-- 11. SYSTEM CONFIGURATION AND AUDIT
-- =====================================================================

-- System Parameters
CREATE TABLE system_parameters (
    parameter_id INT PRIMARY KEY AUTO_INCREMENT,
    parameter_name VARCHAR(100) UNIQUE NOT NULL,
    parameter_value TEXT NOT NULL,
    parameter_type ENUM('string', 'number', 'boolean', 'date', 'json') NOT NULL,
    description TEXT,
    is_system BOOLEAN DEFAULT FALSE, -- System parameters cannot be deleted
    updated_by INT NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (updated_by) REFERENCES users(user_id)
);

-- Audit Log
CREATE TABLE audit_log (
    audit_id BIGINT PRIMARY KEY AUTO_INCREMENT,
    table_name VARCHAR(100) NOT NULL,
    record_id VARCHAR(50) NOT NULL,
    action ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    old_values JSON NULL,
    new_values JSON NULL,
    user_id INT NOT NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    INDEX idx_table_record (table_name, record_id),
    INDEX idx_user_date (user_id, created_at),
    INDEX idx_date (created_at)
);

-- Number Sequences (for auto-generating document numbers)
CREATE TABLE number_sequences (
    sequence_id INT PRIMARY KEY AUTO_INCREMENT,
    sequence_name VARCHAR(100) UNIQUE NOT NULL,
    prefix VARCHAR(20) DEFAULT '',
    current_number BIGINT DEFAULT 1,
    increment_by INT DEFAULT 1,
    min_value BIGINT DEFAULT 1,
    max_value BIGINT DEFAULT 999999999,
    padding_length INT DEFAULT 6,
    reset_frequency ENUM('never', 'daily', 'monthly', 'yearly') DEFAULT 'never',
    last_reset_date DATE NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =====================================================================
-- 12. COMPREHENSIVE INDEXES FOR PERFORMANCE
-- =====================================================================

-- Critical Business Process Indexes
CREATE INDEX idx_inventory_available ON inventory_master(item_type, item_id, status, quantity_available);
CREATE INDEX idx_inventory_expiry ON inventory_master(expiration_date, status);
CREATE INDEX idx_transactions_date_type ON inventory_transactions(transaction_date, transaction_type);
CREATE INDEX idx_production_schedule ON production_orders(scheduled_start_date, order_status);
CREATE INDEX idx_materials_reorder ON raw_materials(reorder_level, is_active);
CREATE INDEX idx_quality_pending ON quality_inspections(overall_result, inspection_date);
CREATE INDEX idx_po_status_date ON purchase_orders(po_status, po_date);
CREATE INDEX idx_so_status_date ON sales_orders(so_status, required_date);
CREATE INDEX idx_lot_expiry ON lot_master(expiration_date, quality_status);

-- Traceability Indexes
CREATE INDEX idx_lot_genealogy_parent ON lot_genealogy(parent_lot_id);
CREATE INDEX idx_lot_genealogy_child ON lot_genealogy(child_lot_id);
CREATE INDEX idx_consumption_production ON material_consumption(production_order_id, material_id);

-- Financial and Costing Indexes
CREATE INDEX idx_variance_analysis ON production_variances(variance_type, analysis_date);
CREATE INDEX idx_standard_costs_effective ON standard_costs(item_type, item_id, effective_date DESC);

-- =====================================================================
-- 13. VIEWS FOR COMMON BUSINESS QUERIES
-- =====================================================================

-- Current Inventory Summary
CREATE VIEW v_current_inventory AS
SELECT 
    im.item_type,
    im.item_id,
    CASE 
        WHEN im.item_type = 'raw_material' THEN rm.material_name
        WHEN im.item_type = 'finished_product' THEN fp.product_name
    END as item_name,
    CASE 
        WHEN im.item_type = 'raw_material' THEN rm.material_code
        WHEN im.item_type = 'finished_product' THEN fp.product_code
    END as item_code,
    l.location_name,
    im.lot_number,
    im.quantity_on_hand,
    im.quantity_reserved,
    im.quantity_allocated,
    im.quantity_available,
    im.unit_cost,
    im.total_value,
    im.expiration_date,
    im.status,
    im.quality_status
FROM inventory_master im
LEFT JOIN raw_materials rm ON im.item_type = 'raw_material' AND im.item_id = rm.material_id
LEFT JOIN finished_products fp ON im.item_type = 'finished_product' AND im.item_id = fp.product_id
JOIN locations l ON im.location_id = l.location_id
WHERE im.quantity_on_hand > 0;

-- Materials Below Reorder Level
CREATE VIEW v_reorder_alerts AS
SELECT 
    rm.material_id,
    rm.material_code,
    rm.material_name,
    rm.reorder_level,
    COALESCE(SUM(im.quantity_available), 0) as current_stock,
    rm.reorder_quantity,
    s.supplier_name,
    rm.lead_time_days
FROM raw_materials rm
LEFT JOIN inventory_master im ON im.item_type = 'raw_material' 
    AND im.item_id = rm.material_id 
    AND im.status = 'available'
LEFT JOIN suppliers s ON rm.supplier_id = s.supplier_id
WHERE rm.is_active = TRUE
GROUP BY rm.material_id, rm.material_code, rm.material_name, rm.reorder_level, 
         rm.reorder_quantity, s.supplier_name, rm.lead_time_days
HAVING current_stock <= rm.reorder_level;

-- Production Order Status Summary
CREATE VIEW v_production_status AS
SELECT 
    po.order_number,
    fp.product_name,
    po.planned_quantity,
    po.actual_quantity_produced,
    po.order_status,
    po.scheduled_start_date,
    po.scheduled_end_date,
    po.actual_start_date,
    po.actual_end_date,
    DATEDIFF(COALESCE(po.actual_end_date, CURRENT_DATE), po.scheduled_end_date) as days_variance,
    po.quality_status,
    u.first_name + ' ' + u.last_name as created_by_name
FROM production_orders po
JOIN finished_products fp ON po.product_id = fp.product_id
LEFT JOIN users u ON po.created_by = u.user_id
WHERE po.order_status != 'cancelled';

-- =====================================================================
-- 14. ESSENTIAL STORED PROCEDURES
-- =====================================================================

DELIMITER //

-- Procedure to calculate MRP requirements
CREATE PROCEDURE sp_calculate_mrp_requirements(
    IN p_planning_horizon_days INT DEFAULT 90,
    IN p_run_date DATE DEFAULT NULL
)
BEGIN
    DECLARE v_run_date DATE DEFAULT COALESCE(p_run_date, CURRENT_DATE);
    
    -- Clear existing MRP data for this run
    DELETE FROM material_requirements WHERE mrp_run_date = v_run_date;
    
    -- Insert gross requirements from production orders
    INSERT INTO material_requirements (
        material_id, requirement_date, gross_requirement, 
        source_type, source_reference, mrp_run_date
    )
    SELECT 
        bl.material_id,
        po.scheduled_start_date as requirement_date,
        (bl.quantity_required * po.planned_quantity) * (1 + bl.scrap_percentage/100) as gross_requirement,
        'production_order' as source_type,
        po.order_number as source_reference,
        v_run_date as mrp_run_date
    FROM production_orders po
    JOIN bom_lines bl ON po.bom_id = bl.bom_id
    WHERE po.order_status IN ('planned', 'released')
    AND po.scheduled_start_date <= DATE_ADD(v_run_date, INTERVAL p_planning_horizon_days DAY);
    
    -- Add requirements from sales orders (for finished products sold directly)
    INSERT INTO material_requirements (
        material_id, requirement_date, gross_requirement,
        source_type, source_reference, mrp_run_date
    )
    SELECT 
        sol.product_id as material_id,
        sol.required_date,
        (sol.quantity_ordered - sol.quantity_shipped) as gross_requirement,
        'sales_order' as source_type,
        so.so_number as source_reference,
        v_run_date as mrp_run_date
    FROM sales_order_lines sol
    JOIN sales_orders so ON sol.so_id = so.so_id
    WHERE so.so_status IN ('confirmed', 'in_production')
    AND sol.required_date <= DATE_ADD(v_run_date, INTERVAL p_planning_horizon_days DAY)
    AND (sol.quantity_ordered - sol.quantity_shipped) > 0;
    
END //

-- Procedure to create inventory transactions
CREATE PROCEDURE sp_create_inventory_transaction(
    IN p_inventory_id INT,
    IN p_transaction_type VARCHAR(50),
    IN p_reference_type VARCHAR(50),
    IN p_reference_number VARCHAR(50),
    IN p_quantity_change DECIMAL(15,6),
    IN p_unit_cost DECIMAL(12,4),
    IN p_reason_code VARCHAR(50),
    IN p_notes TEXT,
    IN p_created_by INT,
    OUT p_transaction_id INT,
    OUT p_success BOOLEAN,
    OUT p_error_message VARCHAR(500)
)
BEGIN
    DECLARE v_current_quantity DECIMAL(15,6);
    DECLARE v_transaction_number VARCHAR(50);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_success = FALSE;
        SET p_error_message = 'Database error occurred during transaction creation';
    END;
    
    START TRANSACTION;
    
    -- Check current inventory quantity
    SELECT quantity_on_hand INTO v_current_quantity
    FROM inventory_master 
    WHERE inventory_id = p_inventory_id;
    
    -- Validate sufficient quantity for negative transactions
    IF p_quantity_change < 0 AND (v_current_quantity + p_quantity_change) < 0 THEN
        SET p_success = FALSE;
        SET p_error_message = 'Insufficient inventory quantity available';
        ROLLBACK;
    ELSE
        -- Generate transaction number
        SELECT CONCAT('TXN-', LPAD(current_number, padding_length, '0'))
        INTO v_transaction_number
        FROM number_sequences 
        WHERE sequence_name = 'INVENTORY_TRANSACTION';
        
        -- Update sequence
        UPDATE number_sequences 
        SET current_number = current_number + increment_by
        WHERE sequence_name = 'INVENTORY_TRANSACTION';
        
        -- Create transaction record
        INSERT INTO inventory_transactions (
            transaction_number, inventory_id, transaction_type, reference_type,
            reference_number, quantity_change, unit_cost, reason_code,
            notes, transaction_date, created_by
        ) VALUES (
            v_transaction_number, p_inventory_id, p_transaction_type, p_reference_type,
            p_reference_number, p_quantity_change, p_unit_cost, p_reason_code,
            p_notes, NOW(), p_created_by
        );
        
        SET p_transaction_id = LAST_INSERT_ID();
        
        -- Update inventory master
        UPDATE inventory_master 
        SET quantity_on_hand = quantity_on_hand + p_quantity_change,
            last_movement_date = NOW(),
            updated_at = NOW()
        WHERE inventory_id = p_inventory_id;
        
        SET p_success = TRUE;
        SET p_error_message = NULL;
        COMMIT;
    END IF;
    
END //

DELIMITER ;

-- =====================================================================
-- 15. INITIAL DATA SETUP
-- =====================================================================

-- Insert default company
INSERT INTO companies (company_name, company_code, company_type, created_at) 
VALUES ('Manufacturing Company Ltd', 'MFG001', 'main', NOW());

-- Insert basic units of measure
INSERT INTO units_of_measure (uom_code, uom_name, uom_type) VALUES
('KG', 'Kilogram', 'weight'),
('G', 'Gram', 'weight'),
('L', 'Liter', 'volume'),
('ML', 'Milliliter', 'volume'),
('PCS', 'Pieces', 'count'),
('M', 'Meter', 'length'),
('CM', 'Centimeter', 'length'),
('HR', 'Hour', 'time'),
('MIN', 'Minute', 'time');

-- Insert number sequences
INSERT INTO number_sequences (sequence_name, prefix, current_number, padding_length) VALUES
('PRODUCTION_ORDER', 'PO-', 1000, 6),
('PURCHASE_ORDER', 'PUR-', 1000, 6),
('SALES_ORDER', 'SO-', 1000, 6),
('INVENTORY_TRANSACTION', 'TXN-', 1, 8),
('QUALITY_INSPECTION', 'QI-', 1000, 6),
('GOODS_RECEIPT', 'GR-', 1000, 6),
('SHIPMENT', 'SHIP-', 1000, 6);

-- Insert system parameters
INSERT INTO system_parameters (parameter_name, parameter_value, parameter_type, description, is_system) VALUES
('DEFAULT_CURRENCY', 'USD', 'string', 'Default system currency', TRUE),
('INVENTORY_VALUATION_METHOD', 'FIFO', 'string', 'Default inventory valuation method', TRUE),
('AUTO_CREATE_LOTS', 'true', 'boolean', 'Automatically create lot numbers for new inventory', TRUE),
('DEFAULT_LEAD_TIME_DAYS', '30', 'number', 'Default lead time for materials without specified lead time', TRUE),
('QUALITY_CONTROL_MANDATORY', 'true', 'boolean', 'Require quality control for all receipts', TRUE);

-- =====================================================================
-- END OF SCHEMA
-- =====================================================================