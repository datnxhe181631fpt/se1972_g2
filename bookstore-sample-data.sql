-- ============================================
-- SAMPLE DATA FOR BOOKSTORE POS SYSTEM
-- Date: 2026-01-30
-- ============================================

USE BookstorePOSSystem;
GO

-- ============================================
-- 1. MASTER DATA
-- ============================================

-- Categories
SET IDENTITY_INSERT Categories ON;
INSERT INTO Categories (CategoryID, CategoryName, Description, Icon, DisplayOrder, IsActive) VALUES
(1, N'Văn học Việt Nam', N'Tiểu thuyết, truyện ngắn, thơ văn Việt Nam', 'book-vn.png', 1, 1),
(2, N'Văn học nước ngoài', N'Tiểu thuyết, truyện dịch từ nước ngoài', 'book-foreign.png', 2, 1),
(3, N'Sách thiếu nhi', N'Truyện tranh, sách giáo dục cho trẻ em', 'kids.png', 3, 1),
(4, N'Sách giáo khoa', N'SGK các cấp, sách tham khảo', 'education.png', 4, 1),
(5, N'Sách kỹ năng', N'Kỹ năng sống, phát triển bản thân', 'skill.png', 5, 1),
(6, N'Sách kinh tế', N'Kinh doanh, tài chính, marketing', 'business.png', 6, 1),
(7, N'Sách khoa học', N'Khoa học tự nhiên, công nghệ', 'science.png', 7, 1),
(8, N'Văn phòng phẩm', N'Bút, vở, dụng cụ học tập', 'stationery.png', 8, 1);
SET IDENTITY_INSERT Categories OFF;

-- Brands (NXB)
SET IDENTITY_INSERT Brands ON;
INSERT INTO Brands (BrandID, BrandName, Logo, Description, IsActive) VALUES
(1, N'NXB Kim Đồng', 'kimdong.png', N'Nhà xuất bản Kim Đồng', 1),
(2, N'NXB Trẻ', 'nxbtre.png', N'Nhà xuất bản Trẻ', 1),
(3, N'NXB Tổng hợp TPHCM', 'tonghop.png', N'Nhà xuất bản Tổng hợp TP.HCM', 1),
(4, N'First News', 'firstnews.png', N'Công ty First News - Trí Việt', 1),
(5, N'Alpha Books', 'alphabooks.png', N'Công ty Alpha Books', 1),
(6, N'Nhã Nam', 'nhanam.png', N'Công ty Nhã Nam', 1),
(7, N'Thái Hà Books', 'thaiha.png', N'Công ty Thái Hà Books', 1),
(8, N'Thiên Long', 'thienlong.png', N'Tập đoàn Thiên Long', 1);
SET IDENTITY_INSERT Brands OFF;

-- Suppliers
INSERT INTO Suppliers (SupplierCode, SupplierName, ContactPerson, Phone, Email, Address, IsActive) VALUES
('SUP-001', N'Nhà sách Kim Đồng', N'Nguyễn Văn An', '0901234567', 'contact@kimdong.vn', N'55 Quang Trung, Hà Nội', 1),
('SUP-002', N'First News Trí Việt', N'Trần Thị Bình', '0912345678', 'order@firstnews.com.vn', N'11 Nguyễn Thị Minh Khai, Q.1, TP.HCM', 1),
('SUP-003', N'Alpha Books', N'Lê Văn Cường', '0923456789', 'sales@alphabooks.vn', N'Tầng 3, 129 Đinh Tiên Hoàng, Q.1, TP.HCM', 1),
('SUP-004', N'Nhã Nam', N'Phạm Thị Dung', '0934567890', 'info@nhanam.vn', N'59 Đỗ Quang, Cầu Giấy, Hà Nội', 1),
('SUP-005', N'Thiên Long Group', N'Hoàng Văn Em', '0945678901', 'b2b@thienlong.com.vn', N'Lô C14 KCN Tân Bình, TP.HCM', 1);

-- ============================================
-- 2. ROLES & EMPLOYEES
-- ============================================

-- Roles
INSERT INTO Roles (RoleID, RoleName, Permissions) VALUES
(1, 'Admin', '{"all": true}'),
(2, 'Manager', '{"inventory": true, "sales": true, "reports": true, "approve": true}'),
(3, 'Staff', '{"inventory.create": true, "sales": true}'),
(4, 'Cashier', '{"sales": true}');

-- Employees
INSERT INTO Employees (EmployeeID, FullName, Email, Phone, RoleID, HireDate, Status) VALUES
(1, N'Nguyễn Admin', 'admin@bookstore.vn', '0901111111', 1, '2024-01-01', 'ACTIVE'),
(2, N'Trần Quản Lý', 'manager@bookstore.vn', '0902222222', 2, '2024-03-15', 'ACTIVE'),
(3, N'Lê Nhân Viên A', 'staffa@bookstore.vn', '0903333333', 3, '2024-06-01', 'ACTIVE'),
(4, N'Phạm Nhân Viên B', 'staffb@bookstore.vn', '0904444444', 3, '2024-08-15', 'ACTIVE'),
(5, N'Hoàng Thu Ngân', 'cashier@bookstore.vn', '0905555555', 4, '2025-01-01', 'ACTIVE'),
(6, N'Vũ Quản Lý Phụ', 'manager2@bookstore.vn', '0906666666', 2, '2024-05-01', 'ACTIVE');

-- Shifts
INSERT INTO Shifts (ShiftID, ShiftName, StartTime, EndTime) VALUES
(1, N'Ca sáng', '07:00', '14:00'),
(2, N'Ca chiều', '14:00', '21:00'),
(3, N'Ca hành chính', '08:00', '17:00');

-- ============================================
-- 3. PRODUCTS
-- ============================================

INSERT INTO Products (ProductName, CategoryID, BrandID, SupplierID, SKU, Description, CostPrice, SellingPrice, Stock, ReorderLevel, IsActive) VALUES
-- Văn học Việt Nam
(N'Dế Mèn Phiêu Lưu Ký', 1, 1, 1, 'VN-001', N'Tác phẩm kinh điển của Tô Hoài', 35000, 55000, 150, 20, 1),
(N'Tắt Đèn', 1, 2, 1, 'VN-002', N'Tiểu thuyết của Ngô Tất Tố', 40000, 65000, 80, 15, 1),
(N'Số Đỏ', 1, 6, 4, 'VN-003', N'Tác phẩm của Vũ Trọng Phụng', 45000, 75000, 60, 10, 1),
(N'Chí Phèo', 1, 2, 1, 'VN-004', N'Truyện ngắn Nam Cao', 30000, 48000, 120, 25, 1),

-- Văn học nước ngoài
(N'Đắc Nhân Tâm', 2, 4, 2, 'NN-001', N'Dale Carnegie - Bản dịch First News', 50000, 86000, 200, 30, 1),
(N'Nhà Giả Kim', 2, 6, 4, 'NN-002', N'Paulo Coelho - Bản dịch Nhã Nam', 45000, 79000, 180, 25, 1),
(N'Hai Số Phận', 2, 2, 1, 'NN-003', N'Jeffrey Archer', 60000, 98000, 90, 15, 1),
(N'1984', 2, 6, 4, 'NN-004', N'George Orwell', 55000, 89000, 70, 12, 1),
(N'Hoàng Tử Bé', 2, 6, 4, 'NN-005', N'Antoine de Saint-Exupéry', 35000, 58000, 250, 40, 1),

-- Sách thiếu nhi
(N'Doraemon Tập 1', 3, 1, 1, 'TN-001', N'Truyện tranh Doraemon', 20000, 32000, 300, 50, 1),
(N'Doraemon Tập 2', 3, 1, 1, 'TN-002', N'Truyện tranh Doraemon', 20000, 32000, 280, 50, 1),
(N'Conan Tập 100', 3, 1, 1, 'TN-003', N'Thám tử lừng danh Conan', 25000, 40000, 200, 40, 1),
(N'Shin - Cậu bé bút chì Tập 50', 3, 1, 1, 'TN-004', N'Truyện tranh Shin', 22000, 35000, 150, 30, 1),

-- Sách kỹ năng
(N'Đời Ngắn Đừng Ngủ Dài', 5, 4, 2, 'KN-001', N'Robin Sharma', 48000, 79000, 100, 20, 1),
(N'Tuần Làm Việc 4 Giờ', 5, 5, 3, 'KN-002', N'Tim Ferriss', 55000, 95000, 85, 15, 1),
(N'Atomic Habits', 5, 5, 3, 'KN-003', N'James Clear - Thói quen nguyên tử', 65000, 109000, 120, 20, 1),
(N'Deep Work', 5, 5, 3, 'KN-004', N'Cal Newport', 60000, 99000, 75, 12, 1),

-- Sách kinh tế
(N'Cha Giàu Cha Nghèo', 6, 4, 2, 'KT-001', N'Robert Kiyosaki', 55000, 89000, 150, 25, 1),
(N'Nghĩ Giàu Làm Giàu', 6, 4, 2, 'KT-002', N'Napoleon Hill', 50000, 85000, 130, 20, 1),
(N'Khởi Nghiệp Tinh Gọn', 6, 5, 3, 'KT-003', N'Eric Ries', 70000, 119000, 60, 10, 1),

-- Văn phòng phẩm
(N'Bút bi Thiên Long TL-027', 8, 8, 5, 'VP-001', N'Bút bi cao cấp', 5000, 8000, 500, 100, 1),
(N'Vở Campus 120 trang', 8, 8, 5, 'VP-002', N'Vở kẻ ngang', 12000, 18000, 400, 80, 1),
(N'Bút dạ quang Thiên Long', 8, 8, 5, 'VP-003', N'Set 6 màu', 25000, 38000, 200, 40, 1);

-- ============================================
-- 4. CUSTOMERS
-- ============================================

INSERT INTO Customers (CustomerID, FullName, Email, Birthday, Status, Note) VALUES
('KH001', N'Nguyễn Thị Mai', 'mai.nguyen@gmail.com', '1990-05-15', 'ACTIVE', N'Khách VIP'),
('KH002', N'Trần Văn Nam', 'nam.tran@yahoo.com', '1985-08-20', 'ACTIVE', NULL),
('KH003', N'Lê Hoàng Anh', 'anh.le@hotmail.com', '1995-12-01', 'ACTIVE', N'Học sinh'),
('KH004', N'Phạm Minh Tuấn', 'tuan.pham@gmail.com', '1988-03-10', 'ACTIVE', NULL),
('KH005', N'Hoàng Thị Lan', 'lan.hoang@gmail.com', '1992-07-25', 'ACTIVE', N'Giáo viên');

-- Customer Tiers
SET IDENTITY_INSERT CustomerTiers ON;
INSERT INTO CustomerTiers (TierID, TierName, MinTotalSpent, PointRate, DiscountRate) VALUES
(1, N'Thành viên', 0, 1.00, 0),
(2, N'Bạc', 2000000, 1.50, 3.00),
(3, N'Vàng', 5000000, 2.00, 5.00),
(4, N'Kim cương', 10000000, 3.00, 10.00);
SET IDENTITY_INSERT CustomerTiers OFF;

-- Customer Points
INSERT INTO CustomerPoints (CustomerID, TotalPoints) VALUES
('KH001', 5200),
('KH002', 1500),
('KH003', 800),
('KH004', 3200),
('KH005', 2100);

-- ============================================
-- 5. PROMOTIONS
-- ============================================

SET IDENTITY_INSERT Promotions ON;
INSERT INTO Promotions (PromotionID, PromotionCode, PromotionName, PromotionType, StartDate, EndDate, Priority, Status, IsStackable) VALUES
(1, 'TET2026', N'Khuyến mãi Tết 2026', 'PERCENT', '2026-01-15', '2026-02-15', 1, 'ACTIVE', 0),
(2, 'SACH50K', N'Giảm 50K đơn từ 500K', 'FIXED', '2026-01-01', '2026-12-31', 2, 'ACTIVE', 1),
(3, 'THIEUNHI', N'Giảm 20% sách thiếu nhi', 'PERCENT', '2026-01-01', '2026-06-30', 3, 'ACTIVE', 0);
SET IDENTITY_INSERT Promotions OFF;

-- Promotion Conditions
INSERT INTO PromotionConditions (PromotionID, ConditionType, Operator, ConditionValue, LogicalGroup) VALUES
(1, 'MIN_ORDER_VALUE', '>=', '200000', 'AND'),
(2, 'MIN_ORDER_VALUE', '>=', '500000', 'AND'),
(3, 'CATEGORY', '=', '3', 'AND');

-- Promotion Applicable Categories
INSERT INTO PromotionApplicableCategories (PromotionID, CategoryID) VALUES
(3, 3);  -- Áp dụng cho sách thiếu nhi

-- ============================================
-- 6. ATTENDANCE
-- ============================================

INSERT INTO Attendance (EmployeeID, ShiftID, WorkDate, CheckIn, CheckOut, Status) VALUES
(3, 1, '2026-01-28', '06:55', '14:05', 'Present'),
(4, 2, '2026-01-28', '13:58', '21:02', 'Present'),
(5, 1, '2026-01-28', '07:10', '14:00', 'Late'),
(3, 1, '2026-01-29', '06:50', '14:00', 'Present'),
(4, 2, '2026-01-29', '14:00', '21:00', 'Present'),
(5, 2, '2026-01-29', '14:00', NULL, 'Present'),
(3, 1, '2026-01-30', '06:55', NULL, 'Present'),
(4, 2, '2026-01-30', NULL, NULL, 'Absent');

-- ============================================
-- 7. SALES INVOICES
-- ============================================

-- Invoice 1: Khách VIP mua nhiều sách
INSERT INTO SalesInvoice (InvoiceCode, StaffID, CustomerID, ShiftID, TotalAmount, DiscountAmount, FinalAmount, PaymentStatus, Note)
VALUES ('INV-20260128-001', 5, 'KH001', 1, 350000, 35000, 315000, 'PAID', N'Khách VIP giảm 10%');

INSERT INTO SalesInvoiceDetail (InvoiceID, ProductID, Quantity, UnitPrice, Discount, TotalPrice) VALUES
(1, 5, 2, 86000, 0, 172000),   -- 2 cuốn Đắc Nhân Tâm
(1, 6, 1, 79000, 0, 79000),    -- 1 cuốn Nhà Giả Kim
(1, 17, 1, 109000, 10900, 98100); -- 1 cuốn Atomic Habits (giảm 10%)

INSERT INTO Payments (InvoiceID, PaymentMethod, Amount, PaidAt, Status)
VALUES (1, 'CASH', 315000, '2026-01-28 10:30:00', 'COMPLETED');

-- Invoice 2: Mua sách thiếu nhi
INSERT INTO SalesInvoice (InvoiceCode, StaffID, CustomerID, ShiftID, TotalAmount, DiscountAmount, FinalAmount, PaymentStatus, Note)
VALUES ('INV-20260128-002', 5, 'KH003', 1, 139000, 27800, 111200, 'PAID', N'KM sách thiếu nhi 20%');

INSERT INTO SalesInvoiceDetail (InvoiceID, ProductID, Quantity, UnitPrice, Discount, TotalPrice) VALUES
(2, 10, 2, 32000, 6400, 57600),   -- 2 Doraemon tập 1
(2, 12, 1, 40000, 8000, 32000),   -- 1 Conan
(2, 13, 1, 35000, 7000, 28000);   -- 1 Shin

INSERT INTO Payments (InvoiceID, PaymentMethod, Amount, PaidAt, Status)
VALUES (2, 'CARD', 111200, '2026-01-28 11:45:00', 'COMPLETED');

-- Invoice 3: Mua văn phòng phẩm
INSERT INTO SalesInvoice (InvoiceCode, StaffID, CustomerID, ShiftID, TotalAmount, DiscountAmount, FinalAmount, PaymentStatus, Note)
VALUES ('INV-20260129-001', 5, NULL, 2, 98000, 0, 98000, 'PAID', N'Khách lẻ');

INSERT INTO SalesInvoiceDetail (InvoiceID, ProductID, Quantity, UnitPrice, Discount, TotalPrice) VALUES
(3, 21, 5, 8000, 0, 40000),    -- 5 bút bi
(3, 22, 2, 18000, 0, 36000),   -- 2 vở
(3, 23, 1, 38000, 16000, 22000); -- 1 bút dạ quang (có giảm)

INSERT INTO Payments (InvoiceID, PaymentMethod, Amount, PaidAt, Status)
VALUES (3, 'CASH', 98000, '2026-01-29 15:20:00', 'COMPLETED');

-- Invoice Promotions
INSERT INTO InvoicePromotions (InvoiceID, PromotionID, DiscountAmount) VALUES
(2, 3, 27800);  -- Invoice 2 áp dụng KM thiếu nhi

-- ============================================
-- 8. INVENTORY - PURCHASE ORDERS
-- ============================================

-- PO 1: Đã hoàn thành (COMPLETED)
INSERT INTO PurchaseOrders (PONumber, SupplierID, OrderDate, ExpectedDate, Status, Subtotal, TotalDiscount, TotalAmount, ApprovedBy, ApprovedAt, CreatedBy, CreatedAt)
VALUES ('PO-2026-0001', 1, '2026-01-10', '2026-01-15', 'COMPLETED', 5000000, 0, 5000000, 2, '2026-01-10 14:00:00', 3, '2026-01-10 09:00:00');

INSERT INTO PurchaseOrderItems (POID, ProductID, QuantityOrdered, QuantityReceived, UnitPrice, DiscountType, DiscountValue, LineTotal) VALUES
(1, 1, 100, 100, 35000, 'AMOUNT', 0, 3500000),  -- Dế Mèn
(1, 4, 50, 50, 30000, 'AMOUNT', 0, 1500000);    -- Chí Phèo

-- PO 2: Đã duyệt, chưa nhận hàng (APPROVED)
INSERT INTO PurchaseOrders (PONumber, SupplierID, OrderDate, ExpectedDate, Status, Subtotal, TotalDiscount, TotalAmount, ApprovedBy, ApprovedAt, CreatedBy, CreatedAt)
VALUES ('PO-2026-0002', 2, '2026-01-20', '2026-01-25', 'APPROVED', 7500000, 500000, 7000000, 2, '2026-01-20 16:00:00', 4, '2026-01-20 10:00:00');

INSERT INTO PurchaseOrderItems (POID, ProductID, QuantityOrdered, QuantityReceived, UnitPrice, DiscountType, DiscountValue, LineTotal) VALUES
(2, 5, 100, 0, 50000, 'PERCENT', 5, 4750000),   -- Đắc Nhân Tâm
(2, 14, 50, 0, 48000, 'AMOUNT', 0, 2400000);   -- Đời Ngắn Đừng Ngủ Dài

-- PO 3: Chờ duyệt (PENDING_APPROVAL)
INSERT INTO PurchaseOrders (PONumber, SupplierID, OrderDate, ExpectedDate, Status, Subtotal, TotalDiscount, TotalAmount, CreatedBy, CreatedAt, Notes)
VALUES ('PO-2026-0003', 3, '2026-01-28', '2026-02-05', 'PENDING_APPROVAL', 6500000, 0, 6500000, 3, '2026-01-28 11:00:00', N'Bổ sung sách kỹ năng bán chạy');

INSERT INTO PurchaseOrderItems (POID, ProductID, QuantityOrdered, QuantityReceived, UnitPrice, DiscountType, DiscountValue, LineTotal) VALUES
(3, 16, 50, 0, 65000, 'AMOUNT', 0, 3250000),   -- Atomic Habits
(3, 17, 50, 0, 60000, 'AMOUNT', 0, 3000000);   -- Deep Work

-- PO 4: Đã từ chối (REJECTED)
INSERT INTO PurchaseOrders (PONumber, SupplierID, OrderDate, ExpectedDate, Status, Subtotal, TotalDiscount, TotalAmount, ApprovedBy, ApprovedAt, RejectionReason, CreatedBy, CreatedAt)
VALUES ('PO-2026-0004', 4, '2026-01-25', '2026-02-01', 'REJECTED', 3000000, 0, 3000000, 2, '2026-01-25 17:00:00', N'Giá cao hơn thị trường, cần thương lượng lại', 4, '2026-01-25 09:00:00');

INSERT INTO PurchaseOrderItems (POID, ProductID, QuantityOrdered, QuantityReceived, UnitPrice, DiscountType, DiscountValue, LineTotal) VALUES
(4, 6, 50, 0, 60000, 'AMOUNT', 0, 3000000);   -- Nhà Giả Kim - giá cao

-- PO 5: Nhận một phần (PARTIAL_RECEIVED)
INSERT INTO PurchaseOrders (PONumber, SupplierID, OrderDate, ExpectedDate, Status, Subtotal, TotalDiscount, TotalAmount, ApprovedBy, ApprovedAt, CreatedBy, CreatedAt)
VALUES ('PO-2026-0005', 1, '2026-01-15', '2026-01-20', 'PARTIAL_RECEIVED', 4000000, 0, 4000000, 2, '2026-01-15 14:00:00', 3, '2026-01-15 08:00:00');

INSERT INTO PurchaseOrderItems (POID, ProductID, QuantityOrdered, QuantityReceived, UnitPrice, DiscountType, DiscountValue, LineTotal) VALUES
(5, 10, 100, 70, 20000, 'AMOUNT', 0, 2000000),  -- Doraemon 1 - nhận 70/100
(5, 11, 100, 80, 20000, 'AMOUNT', 0, 2000000);  -- Doraemon 2 - nhận 80/100

-- ============================================
-- 9. INVENTORY - GOODS RECEIPTS
-- ============================================

-- GR 1: Hoàn thành cho PO-0001
INSERT INTO GoodsReceipts (ReceiptNumber, POID, ReceiptDate, Status, TotalQuantity, TotalAmount, ReceivedBy, CompletedAt)
VALUES ('GR-2026-0001', 1, '2026-01-15 09:00:00', 'COMPLETED', 150, 5000000, 3, '2026-01-15 09:30:00');

INSERT INTO GoodsReceiptDetails (ReceiptID, POLineItemID, ProductID, QuantityReceived, UnitCost, LineTotal, OldQty, OldCost, NewAvgCost) VALUES
(1, 1, 1, 100, 35000, 3500000, 50, 35000, 35000),   -- Dế Mèn
(1, 2, 4, 50, 30000, 1500000, 70, 30000, 30000);    -- Chí Phèo

-- GR 2: Nhận một phần cho PO-0005 (lần 1)
INSERT INTO GoodsReceipts (ReceiptNumber, POID, ReceiptDate, Status, TotalQuantity, TotalAmount, ReceivedBy, CompletedAt)
VALUES ('GR-2026-0002', 5, '2026-01-20 10:00:00', 'COMPLETED', 100, 2000000, 4, '2026-01-20 10:30:00');

INSERT INTO GoodsReceiptDetails (ReceiptID, POLineItemID, ProductID, QuantityReceived, UnitCost, LineTotal, OldQty, OldCost, NewAvgCost) VALUES
(2, 9, 10, 50, 20000, 1000000, 300, 20000, 20000),  -- Doraemon 1
(2, 10, 11, 50, 20000, 1000000, 280, 20000, 20000); -- Doraemon 2

-- GR 3: Nhận một phần cho PO-0005 (lần 2)
INSERT INTO GoodsReceipts (ReceiptNumber, POID, ReceiptDate, Status, TotalQuantity, TotalAmount, ReceivedBy, CompletedAt)
VALUES ('GR-2026-0003', 5, '2026-01-25 14:00:00', 'COMPLETED', 50, 1000000, 3, '2026-01-25 14:30:00');

INSERT INTO GoodsReceiptDetails (ReceiptID, POLineItemID, ProductID, QuantityReceived, UnitCost, LineTotal, OldQty, OldCost, NewAvgCost) VALUES
(3, 9, 10, 20, 20000, 400000, 350, 20000, 20000),   -- Doraemon 1
(3, 10, 11, 30, 20000, 600000, 330, 20000, 20000);  -- Doraemon 2

-- GR 4: Đang nhập (PENDING) - cho PO-0002
INSERT INTO GoodsReceipts (ReceiptNumber, POID, ReceiptDate, Status, TotalQuantity, TotalAmount, ReceivedBy)
VALUES ('GR-2026-0004', 2, '2026-01-30 08:00:00', 'PENDING', 0, 0, 3);

-- ============================================
-- 10. INVENTORY - STOCK TAKES
-- ============================================

-- Stock Take 1: Hoàn thành (COMPLETED)
INSERT INTO StockTakes (StockTakeNumber, ScopeType, ScopeValue, StockTakeDate, Status, TotalItems, TotalVarianceQty, TotalVarianceValue, ApprovedBy, ApprovedAt, CreatedBy, CreatedAt, SubmittedAt)
VALUES ('ST-2026-0001', 'CATEGORY', '3', '2026-01-20', 'COMPLETED', 4, -5, -100000, 2, '2026-01-21 10:00:00', 3, '2026-01-20 08:00:00', '2026-01-20 17:00:00');

INSERT INTO StockTakeDetails (StockTakeID, ProductID, SystemQuantity, ActualQuantity, UnitCost, VarianceReason, Notes) VALUES
(1, 10, 300, 298, 20000, 'LOSS', N'Mất 2 cuốn không rõ nguyên nhân'),
(1, 11, 280, 278, 20000, 'DAMAGE', N'2 cuốn bị rách bìa'),
(1, 12, 200, 200, 25000, NULL, NULL),
(1, 13, 150, 149, 22000, 'ERROR', N'Lỗi nhập liệu trước đó');

-- Stock Take 2: Chờ duyệt (PENDING_APPROVAL)
INSERT INTO StockTakes (StockTakeNumber, ScopeType, ScopeValue, StockTakeDate, Status, TotalItems, TotalVarianceQty, TotalVarianceValue, CreatedBy, CreatedAt, SubmittedAt, Notes)
VALUES ('ST-2026-0002', 'ALL', NULL, '2026-01-28', 'PENDING_APPROVAL', 5, -8, -380000, 4, '2026-01-28 08:00:00', '2026-01-28 17:00:00', N'Kiểm kê định kỳ cuối tháng');

INSERT INTO StockTakeDetails (StockTakeID, ProductID, SystemQuantity, ActualQuantity, UnitCost, VarianceReason, Notes) VALUES
(2, 5, 200, 195, 50000, 'LOSS', N'Thiếu 5 cuốn Đắc Nhân Tâm'),
(2, 6, 180, 178, 45000, 'DAMAGE', N'2 cuốn bị ẩm'),
(2, 16, 120, 119, 65000, 'ERROR', NULL),
(2, 21, 500, 500, 5000, NULL, NULL),
(2, 22, 400, 400, 12000, NULL, NULL);

-- Stock Take 3: Đang thực hiện (IN_PROGRESS)
INSERT INTO StockTakes (StockTakeNumber, ScopeType, ScopeValue, StockTakeDate, Status, TotalItems, CreatedBy, CreatedAt, Notes)
VALUES ('ST-2026-0003', 'CATEGORY', '8', '2026-01-30', 'IN_PROGRESS', 3, 3, '2026-01-30 09:00:00', N'Kiểm kê văn phòng phẩm');

INSERT INTO StockTakeDetails (StockTakeID, ProductID, SystemQuantity, ActualQuantity, UnitCost) VALUES
(3, 21, 495, 0, 5000),   -- Chưa đếm
(3, 22, 398, 0, 12000),  -- Chưa đếm
(3, 23, 199, 0, 25000);  -- Chưa đếm

-- ============================================
-- 11. INVENTORY - STOCK DISPOSALS
-- ============================================

-- Disposal 1: Hoàn thành (COMPLETED)
INSERT INTO StockDisposals (DisposalNumber, DisposalDate, DisposalReason, Status, TotalQuantity, TotalValue, ApprovedBy, ApprovedAt, PhysicalDisposalConfirmed, DisposedBy, DisposedAt, CreatedBy, CreatedAt)
VALUES ('DIS-2026-0001', '2026-01-18', 'DAMAGED', 'COMPLETED', 10, 200000, 2, '2026-01-18 14:00:00', 1, 3, '2026-01-19 09:00:00', 3, '2026-01-18 10:00:00');

INSERT INTO StockDisposalDetails (DisposalID, ProductID, Quantity, UnitCost, LineTotal, SpecificReason, Notes) VALUES
(1, 10, 5, 20000, 100000, N'Bìa rách, không bán được', N'Hư do vận chuyển'),
(1, 11, 5, 20000, 100000, N'Trang bị ẩm mốc', N'Do kho ẩm');

-- Disposal 2: Đã duyệt, chờ hủy vật lý (APPROVED)
INSERT INTO StockDisposals (DisposalNumber, DisposalDate, DisposalReason, Status, TotalQuantity, TotalValue, ApprovedBy, ApprovedAt, CreatedBy, CreatedAt, Notes)
VALUES ('DIS-2026-0002', '2026-01-25', 'EXPIRED', 'APPROVED', 8, 400000, 2, '2026-01-26 10:00:00', 4, '2026-01-25 11:00:00', N'Sách cũ quá 2 năm, bìa ố vàng');

INSERT INTO StockDisposalDetails (DisposalID, ProductID, Quantity, UnitCost, LineTotal, SpecificReason) VALUES
(2, 2, 5, 40000, 200000, N'Sách cũ, bìa ố'),
(2, 3, 3, 45000, 135000, N'Sách cũ, giấy vàng');

-- Disposal 3: Chờ duyệt (PENDING_APPROVAL)
INSERT INTO StockDisposals (DisposalNumber, DisposalDate, DisposalReason, Status, TotalQuantity, TotalValue, CreatedBy, CreatedAt, Notes)
VALUES ('DIS-2026-0003', '2026-01-29', 'DEFECTIVE', 'PENDING_APPROVAL', 15, 270000, 3, '2026-01-29 14:00:00', N'Lô văn phòng phẩm lỗi');

INSERT INTO StockDisposalDetails (DisposalID, ProductID, Quantity, UnitCost, LineTotal, SpecificReason) VALUES
(3, 21, 10, 5000, 50000, N'Bút không ra mực'),
(3, 23, 5, 25000, 125000, N'Bút dạ quang bị khô');

-- Disposal 4: Từ chối (REJECTED)
INSERT INTO StockDisposals (DisposalNumber, DisposalDate, DisposalReason, Status, TotalQuantity, TotalValue, ApprovedBy, ApprovedAt, RejectionReason, CreatedBy, CreatedAt)
VALUES ('DIS-2026-0004', '2026-01-22', 'OTHER', 'REJECTED', 20, 640000, 2, '2026-01-22 16:00:00', N'Sách vẫn còn mới, có thể giảm giá bán được. Không cần hủy.', 4, '2026-01-22 10:00:00');

INSERT INTO StockDisposalDetails (DisposalID, ProductID, Quantity, UnitCost, LineTotal, SpecificReason) VALUES
(4, 10, 20, 20000, 400000, N'Bìa hơi cũ');

-- ============================================
-- 12. INVENTORY TRANSACTIONS
-- ============================================

-- Transactions từ Goods Receipt
INSERT INTO InventoryTransactions (ProductID, TransactionType, ReferenceType, ReferenceID, ReferenceCode, QuantityChange, StockBefore, StockAfter, UnitCost, CreatedBy, TransactionDate) VALUES
(1, 'IN', 'GOODS_RECEIPT', 1, 'GR-2026-0001', 100, 50, 150, 35000, 3, '2026-01-15 09:30:00'),
(4, 'IN', 'GOODS_RECEIPT', 1, 'GR-2026-0001', 50, 70, 120, 30000, 3, '2026-01-15 09:30:00'),
(10, 'IN', 'GOODS_RECEIPT', 2, 'GR-2026-0002', 50, 250, 300, 20000, 4, '2026-01-20 10:30:00'),
(11, 'IN', 'GOODS_RECEIPT', 2, 'GR-2026-0002', 50, 230, 280, 20000, 4, '2026-01-20 10:30:00'),
(10, 'IN', 'GOODS_RECEIPT', 3, 'GR-2026-0003', 20, 300, 320, 20000, 3, '2026-01-25 14:30:00'),
(11, 'IN', 'GOODS_RECEIPT', 3, 'GR-2026-0003', 30, 280, 310, 20000, 3, '2026-01-25 14:30:00');

-- Transactions từ Sales
INSERT INTO InventoryTransactions (ProductID, TransactionType, ReferenceType, ReferenceID, ReferenceCode, QuantityChange, StockBefore, StockAfter, UnitCost, CreatedBy, TransactionDate) VALUES
(5, 'OUT', 'SALE', 1, 'INV-20260128-001', -2, 202, 200, 50000, 5, '2026-01-28 10:30:00'),
(6, 'OUT', 'SALE', 1, 'INV-20260128-001', -1, 181, 180, 45000, 5, '2026-01-28 10:30:00'),
(16, 'OUT', 'SALE', 1, 'INV-20260128-001', -1, 121, 120, 65000, 5, '2026-01-28 10:30:00'),
(10, 'OUT', 'SALE', 2, 'INV-20260128-002', -2, 302, 300, 20000, 5, '2026-01-28 11:45:00'),
(12, 'OUT', 'SALE', 2, 'INV-20260128-002', -1, 201, 200, 25000, 5, '2026-01-28 11:45:00'),
(13, 'OUT', 'SALE', 2, 'INV-20260128-002', -1, 151, 150, 22000, 5, '2026-01-28 11:45:00'),
(21, 'OUT', 'SALE', 3, 'INV-20260129-001', -5, 505, 500, 5000, 5, '2026-01-29 15:20:00'),
(22, 'OUT', 'SALE', 3, 'INV-20260129-001', -2, 402, 400, 12000, 5, '2026-01-29 15:20:00'),
(23, 'OUT', 'SALE', 3, 'INV-20260129-001', -1, 201, 200, 25000, 5, '2026-01-29 15:20:00');

-- Transactions từ Stock Take Adjustment
INSERT INTO InventoryTransactions (ProductID, TransactionType, ReferenceType, ReferenceID, ReferenceCode, QuantityChange, StockBefore, StockAfter, UnitCost, Notes, CreatedBy, TransactionDate) VALUES
(10, 'ADJUSTMENT', 'STOCK_TAKE', 1, 'ST-2026-0001', -2, 300, 298, 20000, N'Điều chỉnh kiểm kê', 2, '2026-01-21 10:00:00'),
(11, 'ADJUSTMENT', 'STOCK_TAKE', 1, 'ST-2026-0001', -2, 280, 278, 20000, N'Điều chỉnh kiểm kê', 2, '2026-01-21 10:00:00'),
(13, 'ADJUSTMENT', 'STOCK_TAKE', 1, 'ST-2026-0001', -1, 150, 149, 22000, N'Điều chỉnh kiểm kê', 2, '2026-01-21 10:00:00');

-- Transactions từ Disposal
INSERT INTO InventoryTransactions (ProductID, TransactionType, ReferenceType, ReferenceID, ReferenceCode, QuantityChange, StockBefore, StockAfter, UnitCost, Notes, CreatedBy, TransactionDate) VALUES
(10, 'OUT', 'DISPOSAL', 1, 'DIS-2026-0001', -5, 303, 298, 20000, N'Xuất hủy sách hỏng', 3, '2026-01-19 09:00:00'),
(11, 'OUT', 'DISPOSAL', 1, 'DIS-2026-0001', -5, 283, 278, 20000, N'Xuất hủy sách ẩm mốc', 3, '2026-01-19 09:00:00');

-- ============================================
-- 13. NOTIFICATIONS
-- ============================================

-- Low stock alerts
INSERT INTO Notifications (RecipientID, Type, Title, Message, ReferenceType, ReferenceID, IsRead, CreatedAt) VALUES
(2, 'LOW_STOCK', N'Cảnh báo tồn kho thấp', N'Sản phẩm "1984" sắp hết hàng (Tồn: 70, Ngưỡng: 12)', 'PRODUCT', 8, 0, '2026-01-30 08:00:00'),
(2, 'LOW_STOCK', N'Cảnh báo tồn kho thấp', N'Sản phẩm "Khởi Nghiệp Tinh Gọn" sắp hết hàng (Tồn: 60, Ngưỡng: 10)', 'PRODUCT', 20, 0, '2026-01-30 08:00:00');

-- Approval requests
INSERT INTO Notifications (RecipientID, Type, Title, Message, ReferenceType, ReferenceID, IsRead, CreatedAt) VALUES
(2, 'APPROVAL_REQUEST', N'Đơn đặt hàng cần duyệt', N'Đơn PO-2026-0003 từ Alpha Books (6.500.000đ) cần được duyệt', 'PO', 3, 0, '2026-01-28 11:00:00'),
(2, 'APPROVAL_REQUEST', N'Phiếu kiểm kê cần duyệt', N'Phiếu ST-2026-0002 có chênh lệch -8 sản phẩm cần được duyệt', 'STOCK_TAKE', 2, 0, '2026-01-28 17:00:00'),
(2, 'APPROVAL_REQUEST', N'Phiếu xuất hủy cần duyệt', N'Phiếu DIS-2026-0003 (15 sản phẩm - 270.000đ) cần được duyệt', 'DISPOSAL', 3, 0, '2026-01-29 14:00:00');

-- Approval results
INSERT INTO Notifications (RecipientID, Type, Title, Message, ReferenceType, ReferenceID, IsRead, ReadAt, CreatedAt) VALUES
(3, 'APPROVED', N'Đơn đặt hàng đã duyệt', N'Đơn PO-2026-0001 đã được Manager phê duyệt', 'PO', 1, 1, '2026-01-10 15:00:00', '2026-01-10 14:00:00'),
(4, 'APPROVED', N'Đơn đặt hàng đã duyệt', N'Đơn PO-2026-0002 đã được Manager phê duyệt', 'PO', 2, 1, '2026-01-20 17:00:00', '2026-01-20 16:00:00'),
(4, 'REJECTED', N'Đơn đặt hàng bị từ chối', N'Đơn PO-2026-0004 bị từ chối. Lý do: Giá cao hơn thị trường', 'PO', 4, 1, '2026-01-25 18:00:00', '2026-01-25 17:00:00'),
(3, 'APPROVED', N'Phiếu kiểm kê đã duyệt', N'Phiếu ST-2026-0001 đã được duyệt và điều chỉnh tồn kho', 'STOCK_TAKE', 1, 1, '2026-01-21 11:00:00', '2026-01-21 10:00:00'),
(4, 'REJECTED', N'Phiếu xuất hủy bị từ chối', N'Phiếu DIS-2026-0004 bị từ chối. Có thể giảm giá bán được', 'DISPOSAL', 4, 0, '2026-01-22 16:00:00', '2026-01-22 16:00:00');

-- ============================================
-- 14. HR AUDIT LOGS
-- ============================================

INSERT INTO HRAuditLogs (EmployeeID, Action, PerformedBy, LogTime) VALUES
(3, 'CHECK_IN', 3, '2026-01-28 06:55:00'),
(3, 'CHECK_OUT', 3, '2026-01-28 14:05:00'),
(4, 'CHECK_IN', 4, '2026-01-28 13:58:00'),
(4, 'CHECK_OUT', 4, '2026-01-28 21:02:00'),
(3, 'CHECK_IN', 3, '2026-01-30 06:55:00');

GO

-- ============================================
-- SUMMARY
-- ============================================
/*
SAMPLE DATA CREATED:

MASTER DATA:
- Categories: 8 records
- Brands: 8 records (NXB)
- Suppliers: 5 records

EMPLOYEES:
- Roles: 4 records (Admin, Manager, Staff, Cashier)
- Employees: 6 records
- Shifts: 3 records
- Attendance: 8 records

PRODUCTS: 23 records across all categories

CUSTOMERS:
- Customers: 5 records
- CustomerTiers: 4 records
- CustomerPoints: 5 records

PROMOTIONS:
- Promotions: 3 records
- Conditions & applicable items

SALES:
- SalesInvoice: 3 invoices
- SalesInvoiceDetail: 9 line items
- Payments: 3 records

INVENTORY:
- PurchaseOrders: 5 records (various statuses)
- PurchaseOrderItems: 10 line items
- GoodsReceipts: 4 records (3 completed, 1 pending)
- GoodsReceiptDetails: 8 line items
- StockTakes: 3 records (various statuses)
- StockTakeDetails: 12 line items
- StockDisposals: 4 records (various statuses)
- StockDisposalDetails: 7 line items
- InventoryTransactions: 20 records
- Notifications: 10 records

STATUS DISTRIBUTION:
- PO: 1 COMPLETED, 1 APPROVED, 1 PENDING_APPROVAL, 1 REJECTED, 1 PARTIAL_RECEIVED
- GR: 3 COMPLETED, 1 PENDING
- StockTake: 1 COMPLETED, 1 PENDING_APPROVAL, 1 IN_PROGRESS
- Disposal: 1 COMPLETED, 1 APPROVED, 1 PENDING_APPROVAL, 1 REJECTED
*/
