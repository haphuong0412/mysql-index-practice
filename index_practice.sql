-- Bước 1: Chọn cơ sở dữ liệu mẫu classicmodels
USE classicmodels;

-- Bước 2: Kiểm tra kế hoạch thực thi (Execution Plan) khi CHƯA tạo Index
-- Mức độ truy vấn sẽ là type = ALL (Full Table Scan)
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- Bước 3: Tạo Index đơn (Single-column Index) cho cột customerName
ALTER TABLE customers ADD INDEX idx_customerName(customerName);

-- Kiểm tra lại kế hoạch thực thi sau khi tạo Index
-- Kết quả type chuyển sang 'ref', key được sử dụng là 'idx_customerName' và số rows quét giảm còn 1
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';

-- Bước 4: Tạo Composite Index (Index kết hợp) cho cặp cột contactFirstName và contactLastName
ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);

-- Kiểm tra kế hoạch thực thi khi truy vấn sử dụng Composite Index
EXPLAIN SELECT * FROM customers WHERE contactFirstName = 'Jean' OR contactFirstName = 'King';

-- Bước 5: Xóa chỉ mục (Drop Index) khi không sử dụng
ALTER TABLE customers DROP INDEX idx_full_name;
