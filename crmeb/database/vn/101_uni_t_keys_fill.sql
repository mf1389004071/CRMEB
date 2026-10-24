-- 由 scripts/i18n_extract_uni_t_keys.py 生成；幂等。
SET NAMES utf8mb4;
SET @t_zh := (SELECT id FROM eb_lang_type WHERE file_name='zh-CN' AND is_del=0 LIMIT 1);
SET @t_vi := (SELECT id FROM eb_lang_type WHERE file_name='vi-VN' AND is_del=0 LIMIT 1);
SET @t_en := (SELECT id FROM eb_lang_type WHERE file_name='en-US' AND is_del=0 LIMIT 1);

INSERT INTO eb_lang_code (type_id, code, remarks, lang_explain, is_admin)
SELECT v.tid, v.code, v.remarks, v.explain_, v.is_admin FROM (
  SELECT @t_zh AS tid, '(可为空)' AS code, '(可为空)' AS remarks, '(可为空)' AS explain_, 0 AS is_admin, '(可为空)' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '(可为空)' AS code, '[待审](可为空)' AS remarks, '(có thể trống)' AS explain_, 0 AS is_admin, '(可为空)' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '(可为空)' AS code, '(可为空)' AS remarks, '(can be empty)' AS explain_, 0 AS is_admin, '(可为空)' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '7天无理由退换货·放心购' AS code, '7天无理由退换货·放心购' AS remarks, '7天无理由退换货·放心购' AS explain_, 0 AS is_admin, '7天无理由退换货·放心购' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '7天无理由退换货·放心购' AS code, '[待审]7天无理由退换货·放心购' AS remarks, '7 ngày không có lý do để trả lại hoặc trao đổi hàng · Yên tâm mua hàng' AS explain_, 0 AS is_admin, '7天无理由退换货·放心购' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '7天无理由退换货·放心购' AS code, '7天无理由退换货·放心购' AS remarks, '7 days no reason to return or exchange goods·Buy with confidence' AS explain_, 0 AS is_admin, '7天无理由退换货·放心购' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'h5与app端不支持跳转外部小程序' AS code, 'h5与app端不支持跳转外部小程序' AS remarks, 'h5与app端不支持跳转外部小程序' AS explain_, 0 AS is_admin, 'h5与app端不支持跳转外部小程序' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'h5与app端不支持跳转外部小程序' AS code, '[待审]h5与app端不支持跳转外部小程序' AS remarks, 'h5 và ứng dụng không hỗ trợ chuyển sang các chương trình nhỏ bên ngoài' AS explain_, 0 AS is_admin, 'h5与app端不支持跳转外部小程序' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'h5与app端不支持跳转外部小程序' AS code, 'h5与app端不支持跳转外部小程序' AS remarks, 'h5 and app do not support jumping to external mini programs' AS explain_, 0 AS is_admin, 'h5与app端不支持跳转外部小程序' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '一' AS code, '一' AS remarks, '一' AS explain_, 0 AS is_admin, '一' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '一' AS code, '[待审]一' AS remarks, 'một' AS explain_, 0 AS is_admin, '一' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '一' AS code, '一' AS remarks, 'one' AS explain_, 0 AS is_admin, '一' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '一个月内' AS code, '一个月内' AS remarks, '一个月内' AS explain_, 0 AS is_admin, '一个月内' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '一个月内' AS code, '[待审]一个月内' AS remarks, 'trong vòng một tháng' AS explain_, 0 AS is_admin, '一个月内' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '一个月内' AS code, '一个月内' AS remarks, 'within a month' AS explain_, 0 AS is_admin, '一个月内' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '一级分佣比例' AS code, '一级分佣比例' AS remarks, '一级分佣比例' AS explain_, 0 AS is_admin, '一级分佣比例' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '一级分佣比例' AS code, '[待审]一级分佣比例' AS remarks, 'Tỷ lệ hoa hồng cấp đầu tiên' AS explain_, 0 AS is_admin, '一级分佣比例' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '一级分佣比例' AS code, '一级分佣比例' AS remarks, 'First level commission ratio' AS explain_, 0 AS is_admin, '一级分佣比例' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '一级分类' AS code, '一级分类' AS remarks, '一级分类' AS explain_, 0 AS is_admin, '一级分类' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '一级分类' AS code, '[待审]一级分类' AS remarks, 'Phân loại cấp độ đầu tiên' AS explain_, 0 AS is_admin, '一级分类' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '一级分类' AS code, '一级分类' AS remarks, 'First level classification' AS explain_, 0 AS is_admin, '一级分类' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '一键' AS code, '一键' AS remarks, '一键' AS explain_, 0 AS is_admin, '一键' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '一键' AS code, '[待审]一键' AS remarks, 'Một cú nhấp chuột' AS explain_, 0 AS is_admin, '一键' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '一键' AS code, '一键' AS remarks, 'One click' AS explain_, 0 AS is_admin, '一键' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '一键领取' AS code, '一键领取' AS remarks, '一键领取' AS explain_, 0 AS is_admin, '一键领取' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '一键领取' AS code, '[待审]一键领取' AS remarks, 'Nhận nó với một cú nhấp chuột' AS explain_, 0 AS is_admin, '一键领取' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '一键领取' AS code, '一键领取' AS remarks, 'Get it with one click' AS explain_, 0 AS is_admin, '一键领取' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '七' AS code, '七' AS remarks, '七' AS explain_, 0 AS is_admin, '七' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '七' AS code, '[待审]七' AS remarks, 'bảy' AS explain_, 0 AS is_admin, '七' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '七' AS code, '七' AS remarks, 'seven' AS explain_, 0 AS is_admin, '七' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '三' AS code, '三' AS remarks, '三' AS explain_, 0 AS is_admin, '三' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '三' AS code, '[待审]三' AS remarks, 'ba' AS explain_, 0 AS is_admin, '三' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '三' AS code, '三' AS remarks, 'three' AS explain_, 0 AS is_admin, '三' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '三个月内' AS code, '三个月内' AS remarks, '三个月内' AS explain_, 0 AS is_admin, '三个月内' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '三个月内' AS code, '[待审]三个月内' AS remarks, 'trong vòng ba tháng' AS explain_, 0 AS is_admin, '三个月内' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '三个月内' AS code, '三个月内' AS remarks, 'within three months' AS explain_, 0 AS is_admin, '三个月内' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '三天内' AS code, '三天内' AS remarks, '三天内' AS explain_, 0 AS is_admin, '三天内' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '三天内' AS code, '[待审]三天内' AS remarks, 'trong vòng ba ngày' AS explain_, 0 AS is_admin, '三天内' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '三天内' AS code, '三天内' AS remarks, 'within three days' AS explain_, 0 AS is_admin, '三天内' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '上架' AS code, '上架' AS remarks, '上架' AS explain_, 0 AS is_admin, '上架' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '上架' AS code, '[待审]上架' AS remarks, 'Trên kệ' AS explain_, 0 AS is_admin, '上架' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '上架' AS code, '上架' AS remarks, 'On the shelves' AS explain_, 0 AS is_admin, '上架' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '下架' AS code, '下架' AS remarks, '下架' AS explain_, 0 AS is_admin, '下架' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '下架' AS code, '[待审]下架' AS remarks, 'Đã xóa khỏi kệ' AS explain_, 0 AS is_admin, '下架' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '下架' AS code, '下架' AS remarks, 'Removed from shelves' AS explain_, 0 AS is_admin, '下架' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '下载出错' AS code, '下载出错' AS remarks, '下载出错' AS explain_, 0 AS is_admin, '下载出错' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '下载出错' AS code, '[待审]下载出错' AS remarks, 'Lỗi tải xuống' AS explain_, 0 AS is_admin, '下载出错' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '下载出错' AS code, '下载出错' AS remarks, 'Download error' AS explain_, 0 AS is_admin, '下载出错' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '下载更新文件...' AS code, '下载更新文件...' AS remarks, '下载更新文件...' AS explain_, 0 AS is_admin, '下载更新文件...' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '下载更新文件...' AS code, '[待审]下载更新文件...' AS remarks, 'Tải file cập nhật...' AS explain_, 0 AS is_admin, '下载更新文件...' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '下载更新文件...' AS code, '下载更新文件...' AS remarks, 'Download update files...' AS explain_, 0 AS is_admin, '下载更新文件...' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '不能输入0喔' AS code, '不能输入0喔' AS remarks, '不能输入0喔' AS explain_, 0 AS is_admin, '不能输入0喔' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '不能输入0喔' AS code, '[待审]不能输入0喔' AS remarks, 'Bạn không thể nhập 0' AS explain_, 0 AS is_admin, '不能输入0喔' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '不能输入0喔' AS code, '不能输入0喔' AS remarks, 'You cannot enter 0' AS explain_, 0 AS is_admin, '不能输入0喔' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '专属优惠券' AS code, '专属优惠券' AS remarks, '专属优惠券' AS explain_, 0 AS is_admin, '专属优惠券' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '专属优惠券' AS code, '[待审]专属优惠券' AS remarks, 'Phiếu giảm giá độc quyền' AS explain_, 0 AS is_admin, '专属优惠券' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '专属优惠券' AS code, '专属优惠券' AS remarks, 'Exclusive coupons' AS explain_, 0 AS is_admin, '专属优惠券' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '个人仅支持普通发票' AS code, '个人仅支持普通发票' AS remarks, '个人仅支持普通发票' AS explain_, 0 AS is_admin, '个人仅支持普通发票' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '个人仅支持普通发票' AS code, '[待审]个人仅支持普通发票' AS remarks, 'Cá nhân chỉ hỗ trợ hóa đơn thông thường' AS explain_, 0 AS is_admin, '个人仅支持普通发票' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '个人仅支持普通发票' AS code, '个人仅支持普通发票' AS remarks, 'Individuals only support ordinary invoices' AS explain_, 0 AS is_admin, '个人仅支持普通发票' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '主播' AS code, '主播' AS remarks, '主播' AS explain_, 0 AS is_admin, '主播' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '主播' AS code, '[待审]主播' AS remarks, 'Neo' AS explain_, 0 AS is_admin, '主播' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '主播' AS code, '主播' AS remarks, 'Anchor' AS explain_, 0 AS is_admin, '主播' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '九' AS code, '九' AS remarks, '九' AS explain_, 0 AS is_admin, '九' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '九' AS code, '[待审]九' AS remarks, 'Chín' AS explain_, 0 AS is_admin, '九' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '九' AS code, '九' AS remarks, 'Nine' AS explain_, 0 AS is_admin, '九' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '买家备注' AS code, '买家备注' AS remarks, '买家备注' AS explain_, 0 AS is_admin, '买家备注' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '买家备注' AS code, '[待审]买家备注' AS remarks, 'Ghi chú của người mua' AS explain_, 0 AS is_admin, '买家备注' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '买家备注' AS code, '买家备注' AS remarks, 'Buyer''s Notes' AS explain_, 0 AS is_admin, '买家备注' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '二' AS code, '二' AS remarks, '二' AS explain_, 0 AS is_admin, '二' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '二' AS code, '[待审]二' AS remarks, 'hai' AS explain_, 0 AS is_admin, '二' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '二' AS code, '二' AS remarks, 'two' AS explain_, 0 AS is_admin, '二' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '二级分佣比例' AS code, '二级分佣比例' AS remarks, '二级分佣比例' AS explain_, 0 AS is_admin, '二级分佣比例' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '二级分佣比例' AS code, '[待审]二级分佣比例' AS remarks, 'Tỷ lệ hoa hồng cấp hai' AS explain_, 0 AS is_admin, '二级分佣比例' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '二级分佣比例' AS code, '二级分佣比例' AS remarks, 'Second level commission ratio' AS explain_, 0 AS is_admin, '二级分佣比例' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '二级分类' AS code, '二级分类' AS remarks, '二级分类' AS explain_, 0 AS is_admin, '二级分类' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '二级分类' AS code, '[待审]二级分类' AS remarks, 'Phân loại thứ cấp' AS explain_, 0 AS is_admin, '二级分类' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '二级分类' AS code, '二级分类' AS remarks, 'Secondary classification' AS explain_, 0 AS is_admin, '二级分类' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '二维码保存成功' AS code, '二维码保存成功' AS remarks, '二维码保存成功' AS explain_, 0 AS is_admin, '二维码保存成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '二维码保存成功' AS code, '[待审]二维码保存成功' AS remarks, 'Đã lưu mã QR thành công' AS explain_, 0 AS is_admin, '二维码保存成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '二维码保存成功' AS code, '二维码保存成功' AS remarks, 'QR code saved successfully' AS explain_, 0 AS is_admin, '二维码保存成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '二维码内容不能为空' AS code, '二维码内容不能为空' AS remarks, '二维码内容不能为空' AS explain_, 0 AS is_admin, '二维码内容不能为空' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '二维码内容不能为空' AS code, '[待审]二维码内容不能为空' AS remarks, 'Nội dung mã QR không được để trống' AS explain_, 0 AS is_admin, '二维码内容不能为空' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '二维码内容不能为空' AS code, '二维码内容不能为空' AS remarks, 'The QR code content cannot be empty' AS explain_, 0 AS is_admin, '二维码内容不能为空' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '二维码生成中' AS code, '二维码生成中' AS remarks, '二维码生成中' AS explain_, 0 AS is_admin, '二维码生成中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '二维码生成中' AS code, '[待审]二维码生成中' AS remarks, 'Mã QR đang được tạo' AS explain_, 0 AS is_admin, '二维码生成中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '二维码生成中' AS code, '二维码生成中' AS remarks, 'QR code is being generated' AS explain_, 0 AS is_admin, '二维码生成中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '五' AS code, '五' AS remarks, '五' AS explain_, 0 AS is_admin, '五' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '五' AS code, '[待审]五' AS remarks, 'năm' AS explain_, 0 AS is_admin, '五' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '五' AS code, '五' AS remarks, 'five' AS explain_, 0 AS is_admin, '五' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '人参与拼团' AS code, '人参与拼团' AS remarks, '人参与拼团' AS explain_, 0 AS is_admin, '人参与拼团' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '人参与拼团' AS code, '[待审]人参与拼团' AS remarks, 'Mọi người tham gia vào các cuộc chiến nhóm' AS explain_, 0 AS is_admin, '人参与拼团' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '人参与拼团' AS code, '人参与拼团' AS remarks, 'People participate in group fights' AS explain_, 0 AS is_admin, '人参与拼团' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '仅支持到店' AS code, '仅支持到店' AS remarks, '仅支持到店' AS explain_, 0 AS is_admin, '仅支持到店' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '仅支持到店' AS code, '[待审]仅支持到店' AS remarks, 'Chỉ có tại cửa hàng' AS explain_, 0 AS is_admin, '仅支持到店' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '仅支持到店' AS code, '仅支持到店' AS remarks, 'Only available in store' AS explain_, 0 AS is_admin, '仅支持到店' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '仅支持配送' AS code, '仅支持配送' AS remarks, '仅支持配送' AS explain_, 0 AS is_admin, '仅支持配送' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '仅支持配送' AS code, '[待审]仅支持配送' AS remarks, 'Chỉ hỗ trợ giao hàng' AS explain_, 0 AS is_admin, '仅支持配送' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '仅支持配送' AS code, '仅支持配送' AS remarks, 'Only supports delivery' AS explain_, 0 AS is_admin, '仅支持配送' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '今日' AS code, '今日' AS remarks, '今日' AS explain_, 0 AS is_admin, '今日' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '今日' AS code, '[待审]今日' AS remarks, 'Hôm nay' AS explain_, 0 AS is_admin, '今日' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '今日' AS code, '今日' AS remarks, 'today' AS explain_, 0 AS is_admin, '今日' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '今日已签到，明日再来吧' AS code, '今日已签到，明日再来吧' AS remarks, '今日已签到，明日再来吧' AS explain_, 0 AS is_admin, '今日已签到，明日再来吧' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '今日已签到，明日再来吧' AS code, '[待审]今日已签到，明日再来吧' AS remarks, 'Hôm nay tôi đã đăng nhập, ngày mai quay lại' AS explain_, 0 AS is_admin, '今日已签到，明日再来吧' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '今日已签到，明日再来吧' AS code, '今日已签到，明日再来吧' AS remarks, 'I''ve signed in today, come back tomorrow' AS explain_, 0 AS is_admin, '今日已签到，明日再来吧' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '仓库中' AS code, '仓库中' AS remarks, '仓库中' AS explain_, 0 AS is_admin, '仓库中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '仓库中' AS code, '[待审]仓库中' AS remarks, 'Trong kho' AS explain_, 0 AS is_admin, '仓库中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '仓库中' AS code, '仓库中' AS remarks, 'In warehouse' AS explain_, 0 AS is_admin, '仓库中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '付款码' AS code, '付款码' AS remarks, '付款码' AS explain_, 0 AS is_admin, '付款码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '付款码' AS code, '[待审]付款码' AS remarks, 'mã thanh toán' AS explain_, 0 AS is_admin, '付款码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '付款码' AS code, '付款码' AS remarks, 'payment code' AS explain_, 0 AS is_admin, '付款码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '付费会员优惠' AS code, '付费会员优惠' AS remarks, '付费会员优惠' AS explain_, 0 AS is_admin, '付费会员优惠' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '付费会员优惠' AS code, '[待审]付费会员优惠' AS remarks, 'Lợi ích thành viên trả phí' AS explain_, 0 AS is_admin, '付费会员优惠' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '付费会员优惠' AS code, '付费会员优惠' AS remarks, 'Paid membership benefits' AS explain_, 0 AS is_admin, '付费会员优惠' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '代付头像' AS code, '代付头像' AS remarks, '代付头像' AS explain_, 0 AS is_admin, '代付头像' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '代付头像' AS code, '[待审]代付头像' AS remarks, 'Trả tiền cho hình đại diện' AS explain_, 0 AS is_admin, '代付头像' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '代付头像' AS code, '代付头像' AS remarks, 'Pay for avatar' AS explain_, 0 AS is_admin, '代付头像' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '份' AS code, '份' AS remarks, '份' AS explain_, 0 AS is_admin, '份' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '份' AS code, '[待审]份' AS remarks, 'chia sẻ' AS explain_, 0 AS is_admin, '份' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '份' AS code, '份' AS remarks, 'share' AS explain_, 0 AS is_admin, '份' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '会员' AS code, '会员' AS remarks, '会员' AS explain_, 0 AS is_admin, '会员' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '会员' AS code, '[待审]会员' AS remarks, 'thành viên' AS explain_, 0 AS is_admin, '会员' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '会员' AS code, '会员' AS remarks, 'member' AS explain_, 0 AS is_admin, '会员' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '会员到期日' AS code, '会员到期日' AS remarks, '会员到期日' AS explain_, 0 AS is_admin, '会员到期日' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '会员到期日' AS code, '[待审]会员到期日' AS remarks, 'Ngày hết hạn thành viên' AS explain_, 0 AS is_admin, '会员到期日' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '会员到期日' AS code, '会员到期日' AS remarks, 'Membership expiration date' AS explain_, 0 AS is_admin, '会员到期日' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '会员码' AS code, '会员码' AS remarks, '会员码' AS explain_, 0 AS is_admin, '会员码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '会员码' AS code, '[待审]会员码' AS remarks, 'Mã thành viên' AS explain_, 0 AS is_admin, '会员码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '会员码' AS code, '会员码' AS remarks, 'Member code' AS explain_, 0 AS is_admin, '会员码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '低至' AS code, '低至' AS remarks, '低至' AS explain_, 0 AS is_admin, '低至' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '低至' AS code, '[待审]低至' AS remarks, 'thấp như' AS explain_, 0 AS is_admin, '低至' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '低至' AS code, '低至' AS remarks, 'as low as' AS explain_, 0 AS is_admin, '低至' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '余额抵扣' AS code, '余额抵扣' AS remarks, '余额抵扣' AS explain_, 0 AS is_admin, '余额抵扣' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '余额抵扣' AS code, '[待审]余额抵扣' AS remarks, 'Khấu trừ số dư' AS explain_, 0 AS is_admin, '余额抵扣' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '余额抵扣' AS code, '余额抵扣' AS remarks, 'Balance deduction' AS explain_, 0 AS is_admin, '余额抵扣' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '你的微信版本过低，请更新至最新版本。' AS code, '你的微信版本过低，请更新至最新版本。' AS remarks, '你的微信版本过低，请更新至最新版本。' AS explain_, 0 AS is_admin, '你的微信版本过低，请更新至最新版本。' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '你的微信版本过低，请更新至最新版本。' AS code, '[待审]你的微信版本过低，请更新至最新版本。' AS remarks, 'Phiên bản WeChat của bạn quá thấp, vui lòng cập nhật lên phiên bản mới nhất.' AS explain_, 0 AS is_admin, '你的微信版本过低，请更新至最新版本。' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '你的微信版本过低，请更新至最新版本。' AS code, '你的微信版本过低，请更新至最新版本。' AS remarks, 'Your WeChat version is too low, please update to the latest version.' AS explain_, 0 AS is_admin, '你的微信版本过低，请更新至最新版本。' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '佣金冻结中' AS code, '佣金冻结中' AS remarks, '佣金冻结中' AS explain_, 0 AS is_admin, '佣金冻结中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '佣金冻结中' AS code, '[待审]佣金冻结中' AS remarks, 'Hoa hồng bị đóng băng' AS explain_, 0 AS is_admin, '佣金冻结中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '佣金冻结中' AS code, '佣金冻结中' AS remarks, 'Commission is frozen' AS explain_, 0 AS is_admin, '佣金冻结中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '使用通联支付付款' AS code, '使用通联支付付款' AS remarks, '使用通联支付付款' AS explain_, 0 AS is_admin, '使用通联支付付款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '使用通联支付付款' AS code, '[待审]使用通联支付付款' AS remarks, 'Thanh toán bằng Tonglian Pay' AS explain_, 0 AS is_admin, '使用通联支付付款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '使用通联支付付款' AS code, '使用通联支付付款' AS remarks, 'Pay using Tonglian Pay' AS explain_, 0 AS is_admin, '使用通联支付付款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '例如' AS code, '例如' AS remarks, '例如' AS explain_, 0 AS is_admin, '例如' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '例如' AS code, '[待审]例如' AS remarks, 'Ví dụ' AS explain_, 0 AS is_admin, '例如' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '例如' AS code, '例如' AS remarks, 'For example' AS explain_, 0 AS is_admin, '例如' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '保存图片' AS code, '保存图片' AS remarks, '保存图片' AS explain_, 0 AS is_admin, '保存图片' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '保存图片' AS code, '[待审]保存图片' AS remarks, 'lưu hình ảnh' AS explain_, 0 AS is_admin, '保存图片' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '保存图片' AS code, '保存图片' AS remarks, 'save image' AS explain_, 0 AS is_admin, '保存图片' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '修改' AS code, '修改' AS remarks, '修改' AS explain_, 0 AS is_admin, '修改' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '修改' AS code, '[待审]修改' AS remarks, 'Ôn lại' AS explain_, 0 AS is_admin, '修改' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '修改' AS code, '修改' AS remarks, 'Revise' AS explain_, 0 AS is_admin, '修改' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '修改价格/库存' AS code, '修改价格/库存' AS remarks, '修改价格/库存' AS explain_, 0 AS is_admin, '修改价格/库存' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '修改价格/库存' AS code, '[待审]修改价格/库存' AS remarks, 'Sửa đổi giá/cổ phiếu' AS explain_, 0 AS is_admin, '修改价格/库存' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '修改价格/库存' AS code, '修改价格/库存' AS remarks, 'Modify price/stock' AS explain_, 0 AS is_admin, '修改价格/库存' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '修改余额' AS code, '修改余额' AS remarks, '修改余额' AS explain_, 0 AS is_admin, '修改余额' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '修改余额' AS code, '[待审]修改余额' AS remarks, 'Sửa đổi số dư' AS explain_, 0 AS is_admin, '修改余额' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '修改余额' AS code, '修改余额' AS remarks, 'Modify balance' AS explain_, 0 AS is_admin, '修改余额' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '修改内容至少填写一项' AS code, '修改内容至少填写一项' AS remarks, '修改内容至少填写一项' AS explain_, 0 AS is_admin, '修改内容至少填写一项' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '修改内容至少填写一项' AS code, '[待审]修改内容至少填写一项' AS remarks, 'Vui lòng điền ít nhất một mục cho nội dung sửa đổi' AS explain_, 0 AS is_admin, '修改内容至少填写一项' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '修改内容至少填写一项' AS code, '修改内容至少填写一项' AS remarks, 'Please fill in at least one item for modification content' AS explain_, 0 AS is_admin, '修改内容至少填写一项' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '修改分类' AS code, '修改分类' AS remarks, '修改分类' AS explain_, 0 AS is_admin, '修改分类' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '修改分类' AS code, '[待审]修改分类' AS remarks, 'Sửa đổi phân loại' AS explain_, 0 AS is_admin, '修改分类' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '修改分类' AS code, '修改分类' AS remarks, 'Modify classification' AS explain_, 0 AS is_admin, '修改分类' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '修改分组' AS code, '修改分组' AS remarks, '修改分组' AS explain_, 0 AS is_admin, '修改分组' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '修改分组' AS code, '[待审]修改分组' AS remarks, 'Sửa đổi nhóm' AS explain_, 0 AS is_admin, '修改分组' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '修改分组' AS code, '修改分组' AS remarks, 'Modify group' AS explain_, 0 AS is_admin, '修改分组' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '修改积分' AS code, '修改积分' AS remarks, '修改积分' AS explain_, 0 AS is_admin, '修改积分' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '修改积分' AS code, '[待审]修改积分' AS remarks, 'Sửa đổi điểm' AS explain_, 0 AS is_admin, '修改积分' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '修改积分' AS code, '修改积分' AS remarks, 'Modify points' AS explain_, 0 AS is_admin, '修改积分' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '修改等级' AS code, '修改等级' AS remarks, '修改等级' AS explain_, 0 AS is_admin, '修改等级' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '修改等级' AS code, '[待审]修改等级' AS remarks, 'Sửa đổi cấp độ' AS explain_, 0 AS is_admin, '修改等级' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '修改等级' AS code, '修改等级' AS remarks, 'Modify level' AS explain_, 0 AS is_admin, '修改等级' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '元，最高500元' AS code, '元，最高500元' AS remarks, '元，最高500元' AS explain_, 0 AS is_admin, '元，最高500元' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '元，最高500元' AS code, '[待审]元，最高500元' AS remarks, 'nhân dân tệ, lên tới 500 nhân dân tệ' AS explain_, 0 AS is_admin, '元，最高500元' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '元，最高500元' AS code, '元，最高500元' AS remarks, 'yuan, up to 500 yuan' AS explain_, 0 AS is_admin, '元，最高500元' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '先领券 再购物' AS code, '先领券 再购物' AS remarks, '先领券 再购物' AS explain_, 0 AS is_admin, '先领券 再购物' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '先领券 再购物' AS code, '[待审]先领券 再购物' AS remarks, 'Nhận phiếu giảm giá trước rồi mua sắm' AS explain_, 0 AS is_admin, '先领券 再购物' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '先领券 再购物' AS code, '先领券 再购物' AS remarks, 'Get coupons first and then shop' AS explain_, 0 AS is_admin, '先领券 再购物' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '全部商品' AS code, '全部商品' AS remarks, '全部商品' AS explain_, 0 AS is_admin, '全部商品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '全部商品' AS code, '[待审]全部商品' AS remarks, 'Tất cả sản phẩm' AS explain_, 0 AS is_admin, '全部商品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '全部商品' AS code, '全部商品' AS remarks, 'All products' AS explain_, 0 AS is_admin, '全部商品' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '八' AS code, '八' AS remarks, '八' AS explain_, 0 AS is_admin, '八' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '八' AS code, '[待审]八' AS remarks, 'tám' AS explain_, 0 AS is_admin, '八' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '八' AS code, '八' AS remarks, 'eight' AS explain_, 0 AS is_admin, '八' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '六' AS code, '六' AS remarks, '六' AS explain_, 0 AS is_admin, '六' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '六' AS code, '[待审]六' AS remarks, 'sáu' AS explain_, 0 AS is_admin, '六' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '六' AS code, '六' AS remarks, 'six' AS explain_, 0 AS is_admin, '六' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '关注公众号' AS code, '关注公众号' AS remarks, '关注公众号' AS explain_, 0 AS is_admin, '关注公众号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '关注公众号' AS code, '[待审]关注公众号' AS remarks, 'Theo dõi tài khoản công khai' AS explain_, 0 AS is_admin, '关注公众号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '关注公众号' AS code, '关注公众号' AS remarks, 'Follow the public account' AS explain_, 0 AS is_admin, '关注公众号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '其他设置' AS code, '其他设置' AS remarks, '其他设置' AS explain_, 0 AS is_admin, '其他设置' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '其他设置' AS code, '[待审]其他设置' AS remarks, 'Các cài đặt khác' AS explain_, 0 AS is_admin, '其他设置' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '其他设置' AS code, '其他设置' AS remarks, 'Other settings' AS explain_, 0 AS is_admin, '其他设置' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '再累计签到' AS code, '再累计签到' AS remarks, '再累计签到' AS explain_, 0 AS is_admin, '再累计签到' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '再累计签到' AS code, '[待审]再累计签到' AS remarks, 'Tích lũy lại số lần đăng nhập' AS explain_, 0 AS is_admin, '再累计签到' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '再累计签到' AS code, '再累计签到' AS remarks, 'Accumulate sign-ins again' AS explain_, 0 AS is_admin, '再累计签到' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '再连续签到' AS code, '再连续签到' AS remarks, '再连续签到' AS explain_, 0 AS is_admin, '再连续签到' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '再连续签到' AS code, '[待审]再连续签到' AS remarks, 'Đăng nhập lại' AS explain_, 0 AS is_admin, '再连续签到' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '再连续签到' AS code, '再连续签到' AS remarks, 'Sign in again' AS explain_, 0 AS is_admin, '再连续签到' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '冻结中' AS code, '冻结中' AS remarks, '冻结中' AS explain_, 0 AS is_admin, '冻结中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '冻结中' AS code, '[待审]冻结中' AS remarks, 'Đóng băng' AS explain_, 0 AS is_admin, '冻结中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '冻结中' AS code, '冻结中' AS remarks, 'Freezing' AS explain_, 0 AS is_admin, '冻结中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '减少余额' AS code, '减少余额' AS remarks, '减少余额' AS explain_, 0 AS is_admin, '减少余额' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '减少余额' AS code, '[待审]减少余额' AS remarks, 'Giảm số dư' AS explain_, 0 AS is_admin, '减少余额' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '减少余额' AS code, '减少余额' AS remarks, 'Reduce balance' AS explain_, 0 AS is_admin, '减少余额' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '减少积分' AS code, '减少积分' AS remarks, '减少积分' AS explain_, 0 AS is_admin, '减少积分' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '减少积分' AS code, '[待审]减少积分' AS remarks, 'Giảm điểm' AS explain_, 0 AS is_admin, '减少积分' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '减少积分' AS code, '减少积分' AS remarks, 'Reduce points' AS explain_, 0 AS is_admin, '减少积分' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '出售中' AS code, '出售中' AS remarks, '出售中' AS explain_, 0 AS is_admin, '出售中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '出售中' AS code, '[待审]出售中' AS remarks, 'Cần bán' AS explain_, 0 AS is_admin, '出售中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '出售中' AS code, '出售中' AS remarks, 'For sale' AS explain_, 0 AS is_admin, '出售中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '出生年月' AS code, '出生年月' AS remarks, '出生年月' AS explain_, 0 AS is_admin, '出生年月' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '出生年月' AS code, '[待审]出生年月' AS remarks, 'Ngày sinh' AS explain_, 0 AS is_admin, '出生年月' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '出生年月' AS code, '出生年月' AS remarks, 'Date of birth' AS explain_, 0 AS is_admin, '出生年月' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '分享' AS code, '分享' AS remarks, '分享' AS explain_, 0 AS is_admin, '分享' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '分享' AS code, '[待审]分享' AS remarks, 'chia sẻ' AS explain_, 0 AS is_admin, '分享' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '分享' AS code, '分享' AS remarks, 'share' AS explain_, 0 AS is_admin, '分享' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '分单发货' AS code, '分单发货' AS remarks, '分单发货' AS explain_, 0 AS is_admin, '分单发货' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '分单发货' AS code, '[待审]分单发货' AS remarks, 'Vận chuyển theo đơn đặt hàng riêng biệt' AS explain_, 0 AS is_admin, '分单发货' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '分单发货' AS code, '分单发货' AS remarks, 'Ship in separate orders' AS explain_, 0 AS is_admin, '分单发货' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '分单退款' AS code, '分单退款' AS remarks, '分单退款' AS explain_, 0 AS is_admin, '分单退款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '分单退款' AS code, '[待审]分单退款' AS remarks, 'Hoàn tiền đơn hàng' AS explain_, 0 AS is_admin, '分单退款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '分单退款' AS code, '分单退款' AS remarks, 'Split order refund' AS explain_, 0 AS is_admin, '分单退款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '分组' AS code, '分组' AS remarks, '分组' AS explain_, 0 AS is_admin, '分组' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '分组' AS code, '[待审]分组' AS remarks, 'Nhóm' AS explain_, 0 AS is_admin, '分组' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '分组' AS code, '分组' AS remarks, 'Group' AS explain_, 0 AS is_admin, '分组' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '分销员协议' AS code, '分销员协议' AS remarks, '分销员协议' AS explain_, 0 AS is_admin, '分销员协议' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '分销员协议' AS code, '[待审]分销员协议' AS remarks, 'Thỏa thuận phân phối' AS explain_, 0 AS is_admin, '分销员协议' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '分销员协议' AS code, '分销员协议' AS remarks, 'Distributor Agreement' AS explain_, 0 AS is_admin, '分销员协议' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '分销员姓名' AS code, '分销员姓名' AS remarks, '分销员姓名' AS explain_, 0 AS is_admin, '分销员姓名' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '分销员姓名' AS code, '[待审]分销员姓名' AS remarks, 'Tên nhà phân phối' AS explain_, 0 AS is_admin, '分销员姓名' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '分销员姓名' AS code, '分销员姓名' AS remarks, 'Distributor name' AS explain_, 0 AS is_admin, '分销员姓名' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '分销说明' AS code, '分销说明' AS remarks, '分销说明' AS explain_, 0 AS is_admin, '分销说明' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '分销说明' AS code, '[待审]分销说明' AS remarks, 'Hướng dẫn phân phối' AS explain_, 0 AS is_admin, '分销说明' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '分销说明' AS code, '分销说明' AS remarks, 'Distribution instructions' AS explain_, 0 AS is_admin, '分销说明' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '切换地址' AS code, '切换地址' AS remarks, '切换地址' AS explain_, 0 AS is_admin, '切换地址' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '切换地址' AS code, '[待审]切换地址' AS remarks, 'Chuyển đổi địa chỉ' AS explain_, 0 AS is_admin, '切换地址' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '切换地址' AS code, '切换地址' AS remarks, 'Switch address' AS explain_, 0 AS is_admin, '切换地址' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '切换门店' AS code, '切换门店' AS remarks, '切换门店' AS explain_, 0 AS is_admin, '切换门店' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '切换门店' AS code, '[待审]切换门店' AS remarks, 'Chuyển đổi cửa hàng' AS explain_, 0 AS is_admin, '切换门店' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '切换门店' AS code, '切换门店' AS remarks, 'Switch store' AS explain_, 0 AS is_admin, '切换门店' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '创建订单中' AS code, '创建订单中' AS remarks, '创建订单中' AS explain_, 0 AS is_admin, '创建订单中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '创建订单中' AS code, '[待审]创建订单中' AS remarks, 'Tạo đơn hàng' AS explain_, 0 AS is_admin, '创建订单中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '创建订单中' AS code, '创建订单中' AS remarks, 'Creating order' AS explain_, 0 AS is_admin, '创建订单中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '到店' AS code, '到店' AS remarks, '到店' AS explain_, 0 AS is_admin, '到店' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '到店' AS code, '[待审]到店' AS remarks, 'Đến cửa hàng' AS explain_, 0 AS is_admin, '到店' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '到店' AS code, '到店' AS remarks, 'Arrive at the store' AS explain_, 0 AS is_admin, '到店' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '到手价' AS code, '到手价' AS remarks, '到手价' AS explain_, 0 AS is_admin, '到手价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '到手价' AS code, '[待审]到手价' AS remarks, 'Giá thực trả' AS explain_, 0 AS is_admin, '到手价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '到手价' AS code, '到手价' AS remarks, 'Final price' AS explain_, 0 AS is_admin, '到手价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '刷新支付状态' AS code, '刷新支付状态' AS remarks, '刷新支付状态' AS explain_, 0 AS is_admin, '刷新支付状态' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '刷新支付状态' AS code, '[待审]刷新支付状态' AS remarks, 'Làm mới trạng thái thanh toán' AS explain_, 0 AS is_admin, '刷新支付状态' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '刷新支付状态' AS code, '刷新支付状态' AS remarks, 'Refresh payment status' AS explain_, 0 AS is_admin, '刷新支付状态' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '剩余天数' AS code, '剩余天数' AS remarks, '剩余天数' AS explain_, 0 AS is_admin, '剩余天数' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '剩余天数' AS code, '[待审]剩余天数' AS remarks, 'Số ngày còn lại' AS explain_, 0 AS is_admin, '剩余天数' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '剩余天数' AS code, '剩余天数' AS remarks, 'Days remaining' AS explain_, 0 AS is_admin, '剩余天数' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '剩余抽奖次数为0' AS code, '剩余抽奖次数为0' AS remarks, '剩余抽奖次数为0' AS explain_, 0 AS is_admin, '剩余抽奖次数为0' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '剩余抽奖次数为0' AS code, '[待审]剩余抽奖次数为0' AS remarks, 'Số lần rút còn lại là 0' AS explain_, 0 AS is_admin, '剩余抽奖次数为0' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '剩余抽奖次数为0' AS code, '剩余抽奖次数为0' AS remarks, 'The remaining number of draws is 0' AS explain_, 0 AS is_admin, '剩余抽奖次数为0' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '加载中...' AS code, '加载中...' AS remarks, '加载中...' AS explain_, 0 AS is_admin, '加载中...' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '加载中...' AS code, '[待审]加载中...' AS remarks, 'đang tải...' AS explain_, 0 AS is_admin, '加载中...' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '加载中...' AS code, '加载中...' AS remarks, 'loading...' AS explain_, 0 AS is_admin, '加载中...' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '半年内' AS code, '半年内' AS remarks, '半年内' AS explain_, 0 AS is_admin, '半年内' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '半年内' AS code, '[待审]半年内' AS remarks, 'Trong vòng nửa năm' AS explain_, 0 AS is_admin, '半年内' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '半年内' AS code, '半年内' AS remarks, 'Within half a year' AS explain_, 0 AS is_admin, '半年内' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '卡密发货' AS code, '卡密发货' AS remarks, '卡密发货' AS explain_, 0 AS is_admin, '卡密发货' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '卡密发货' AS code, '[待审]卡密发货' AS remarks, 'Giao hàng bí mật thẻ' AS explain_, 0 AS is_admin, '卡密发货' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '卡密发货' AS code, '卡密发货' AS remarks, 'Card secret delivery' AS explain_, 0 AS is_admin, '卡密发货' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '原价' AS code, '原价' AS remarks, '原价' AS explain_, 0 AS is_admin, '原价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '原价' AS code, '[待审]原价' AS remarks, 'Giá gốc' AS explain_, 0 AS is_admin, '原价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '原价' AS code, '原价' AS remarks, 'Original price' AS explain_, 0 AS is_admin, '原价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '去抢购' AS code, '去抢购' AS remarks, '去抢购' AS explain_, 0 AS is_admin, '去抢购' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '去抢购' AS code, '[待审]去抢购' AS remarks, 'Đi mua sắm' AS explain_, 0 AS is_admin, '去抢购' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '去抢购' AS code, '去抢购' AS remarks, 'Go shopping' AS explain_, 0 AS is_admin, '去抢购' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '去授权' AS code, '去授权' AS remarks, '去授权' AS explain_, 0 AS is_admin, '去授权' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '去授权' AS code, '[待审]去授权' AS remarks, 'ủy quyền' AS explain_, 0 AS is_admin, '去授权' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '去授权' AS code, '去授权' AS remarks, 'to authorize' AS explain_, 0 AS is_admin, '去授权' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '去看看' AS code, '去看看' AS remarks, '去看看' AS explain_, 0 AS is_admin, '去看看' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '去看看' AS code, '[待审]去看看' AS remarks, 'Đi và nhìn xem' AS explain_, 0 AS is_admin, '去看看' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '去看看' AS code, '去看看' AS remarks, 'Go and have a look' AS explain_, 0 AS is_admin, '去看看' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '去评价' AS code, '去评价' AS remarks, '去评价' AS explain_, 0 AS is_admin, '去评价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '去评价' AS code, '[待审]去评价' AS remarks, 'để đánh giá' AS explain_, 0 AS is_admin, '去评价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '去评价' AS code, '去评价' AS remarks, 'to evaluate' AS explain_, 0 AS is_admin, '去评价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '去逛逛' AS code, '去逛逛' AS remarks, '去逛逛' AS explain_, 0 AS is_admin, '去逛逛' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '去逛逛' AS code, '[待审]去逛逛' AS remarks, 'Đi mua sắm' AS explain_, 0 AS is_admin, '去逛逛' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '去逛逛' AS code, '去逛逛' AS remarks, 'Go shopping' AS explain_, 0 AS is_admin, '去逛逛' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '去预定' AS code, '去预定' AS remarks, '去预定' AS explain_, 0 AS is_admin, '去预定' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '去预定' AS code, '[待审]去预定' AS remarks, 'Đi và đặt chỗ' AS explain_, 0 AS is_admin, '去预定' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '去预定' AS code, '去预定' AS remarks, 'Go and book' AS explain_, 0 AS is_admin, '去预定' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '去领取' AS code, '去领取' AS remarks, '去领取' AS explain_, 0 AS is_admin, '去领取' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '去领取' AS code, '[待审]去领取' AS remarks, 'Đi và lấy nó' AS explain_, 0 AS is_admin, '去领取' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '去领取' AS code, '去领取' AS remarks, 'Go and get it' AS explain_, 0 AS is_admin, '去领取' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '参数' AS code, '参数' AS remarks, '参数' AS explain_, 0 AS is_admin, '参数' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '参数' AS code, '[待审]参数' AS remarks, 'tham số' AS explain_, 0 AS is_admin, '参数' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '参数' AS code, '参数' AS remarks, 'parameter' AS explain_, 0 AS is_admin, '参数' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '发送' AS code, '发送' AS remarks, '发送' AS explain_, 0 AS is_admin, '发送' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '发送' AS code, '[待审]发送' AS remarks, 'gửi' AS explain_, 0 AS is_admin, '发送' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '发送' AS code, '发送' AS remarks, 'send' AS explain_, 0 AS is_admin, '发送' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '发送优惠券' AS code, '发送优惠券' AS remarks, '发送优惠券' AS explain_, 0 AS is_admin, '发送优惠券' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '发送优惠券' AS code, '[待审]发送优惠券' AS remarks, 'Gửi phiếu giảm giá' AS explain_, 0 AS is_admin, '发送优惠券' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '发送优惠券' AS code, '发送优惠券' AS remarks, 'Send coupon' AS explain_, 0 AS is_admin, '发送优惠券' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '发送货' AS code, '发送货' AS remarks, '发送货' AS explain_, 0 AS is_admin, '发送货' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '发送货' AS code, '[待审]发送货' AS remarks, 'Gửi hàng' AS explain_, 0 AS is_admin, '发送货' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '发送货' AS code, '发送货' AS remarks, 'Send the goods' AS explain_, 0 AS is_admin, '发送货' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '取消登录' AS code, '取消登录' AS remarks, '取消登录' AS explain_, 0 AS is_admin, '取消登录' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '取消登录' AS code, '[待审]取消登录' AS remarks, 'Hủy đăng nhập' AS explain_, 0 AS is_admin, '取消登录' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '取消登录' AS code, '取消登录' AS remarks, 'Cancel login' AS explain_, 0 AS is_admin, '取消登录' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '可在“微信支付-服务-钱包-账单”查看明细' AS code, '可在“微信支付-服务-钱包-账单”查看明细' AS remarks, '可在“微信支付-服务-钱包-账单”查看明细' AS explain_, 0 AS is_admin, '可在“微信支付-服务-钱包-账单”查看明细' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '可在“微信支付-服务-钱包-账单”查看明细' AS code, '[待审]可在“微信支付-服务-钱包-账单”查看明细' AS remarks, 'Thông tin chi tiết có thể được xem trong "WeChat Payment-Service-Wallet-Hóa đơn"' AS explain_, 0 AS is_admin, '可在“微信支付-服务-钱包-账单”查看明细' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '可在“微信支付-服务-钱包-账单”查看明细' AS code, '可在“微信支付-服务-钱包-账单”查看明细' AS remarks, 'Details can be viewed in "WeChat Payment-Service-Wallet-Bill"' AS explain_, 0 AS is_admin, '可在“微信支付-服务-钱包-账单”查看明细' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '可提现(元)' AS code, '可提现(元)' AS remarks, '可提现(元)' AS explain_, 0 AS is_admin, '可提现(元)' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '可提现(元)' AS code, '[待审]可提现(元)' AS remarks, 'Tiền mặt sẵn có (nhân dân tệ)' AS explain_, 0 AS is_admin, '可提现(元)' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '可提现(元)' AS code, '可提现(元)' AS remarks, 'Cash available (yuan)' AS explain_, 0 AS is_admin, '可提现(元)' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '可选' AS code, '可选' AS remarks, '可选' AS explain_, 0 AS is_admin, '可选' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '可选' AS code, '[待审]可选' AS remarks, 'có thể chọn' AS explain_, 0 AS is_admin, '可选' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '可选' AS code, '可选' AS remarks, 'available' AS explain_, 0 AS is_admin, '可选' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '可额外获得惊喜礼包' AS code, '可额外获得惊喜礼包' AS remarks, '可额外获得惊喜礼包' AS explain_, 0 AS is_admin, '可额外获得惊喜礼包' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '可额外获得惊喜礼包' AS code, '[待审]可额外获得惊喜礼包' AS remarks, 'Nhận thêm gói quà bất ngờ' AS explain_, 0 AS is_admin, '可额外获得惊喜礼包' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '可额外获得惊喜礼包' AS code, '可额外获得惊喜礼包' AS remarks, 'Receive additional surprise gift packs' AS explain_, 0 AS is_admin, '可额外获得惊喜礼包' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '同意并继续' AS code, '同意并继续' AS remarks, '同意并继续' AS explain_, 0 AS is_admin, '同意并继续' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '同意并继续' AS code, '[待审]同意并继续' AS remarks, 'Đồng ý và tiếp tục' AS explain_, 0 AS is_admin, '同意并继续' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '同意并继续' AS code, '同意并继续' AS remarks, 'Agree and continue' AS explain_, 0 AS is_admin, '同意并继续' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '名称' AS code, '名称' AS remarks, '名称' AS explain_, 0 AS is_admin, '名称' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '名称' AS code, '[待审]名称' AS remarks, 'tên' AS explain_, 0 AS is_admin, '名称' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '名称' AS code, '名称' AS remarks, 'name' AS explain_, 0 AS is_admin, '名称' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '向右滑动完成验证' AS code, '向右滑动完成验证' AS remarks, '向右滑动完成验证' AS explain_, 0 AS is_admin, '向右滑动完成验证' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '向右滑动完成验证' AS code, '[待审]向右滑动完成验证' AS remarks, 'Vuốt sang phải để hoàn tất xác minh' AS explain_, 0 AS is_admin, '向右滑动完成验证' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '向右滑动完成验证' AS code, '向右滑动完成验证' AS remarks, 'Swipe right to complete verification' AS explain_, 0 AS is_admin, '向右滑动完成验证' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '周一' AS code, '周一' AS remarks, '周一' AS explain_, 0 AS is_admin, '周一' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '周一' AS code, '[待审]周一' AS remarks, 'vào thứ Hai' AS explain_, 0 AS is_admin, '周一' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '周一' AS code, '周一' AS remarks, 'on Monday' AS explain_, 0 AS is_admin, '周一' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '周三' AS code, '周三' AS remarks, '周三' AS explain_, 0 AS is_admin, '周三' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '周三' AS code, '[待审]周三' AS remarks, 'Thứ Tư' AS explain_, 0 AS is_admin, '周三' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '周三' AS code, '周三' AS remarks, 'Wednesday' AS explain_, 0 AS is_admin, '周三' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '周二' AS code, '周二' AS remarks, '周二' AS explain_, 0 AS is_admin, '周二' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '周二' AS code, '[待审]周二' AS remarks, 'Thứ ba' AS explain_, 0 AS is_admin, '周二' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '周二' AS code, '周二' AS remarks, 'Tuesday' AS explain_, 0 AS is_admin, '周二' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '周五' AS code, '周五' AS remarks, '周五' AS explain_, 0 AS is_admin, '周五' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '周五' AS code, '[待审]周五' AS remarks, 'Thứ sáu' AS explain_, 0 AS is_admin, '周五' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '周五' AS code, '周五' AS remarks, 'Friday' AS explain_, 0 AS is_admin, '周五' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '周六' AS code, '周六' AS remarks, '周六' AS explain_, 0 AS is_admin, '周六' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '周六' AS code, '[待审]周六' AS remarks, 'Thứ bảy' AS explain_, 0 AS is_admin, '周六' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '周六' AS code, '周六' AS remarks, 'Saturday' AS explain_, 0 AS is_admin, '周六' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '周四' AS code, '周四' AS remarks, '周四' AS explain_, 0 AS is_admin, '周四' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '周四' AS code, '[待审]周四' AS remarks, 'Thứ năm' AS explain_, 0 AS is_admin, '周四' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '周四' AS code, '周四' AS remarks, 'Thursday' AS explain_, 0 AS is_admin, '周四' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '周日' AS code, '周日' AS remarks, '周日' AS explain_, 0 AS is_admin, '周日' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '周日' AS code, '[待审]周日' AS remarks, 'Chủ nhật' AS explain_, 0 AS is_admin, '周日' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '周日' AS code, '周日' AS remarks, 'Sunday' AS explain_, 0 AS is_admin, '周日' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '品牌券' AS code, '品牌券' AS remarks, '品牌券' AS explain_, 0 AS is_admin, '品牌券' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '品牌券' AS code, '[待审]品牌券' AS remarks, 'Phiếu giảm giá thương hiệu' AS explain_, 0 AS is_admin, '品牌券' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '品牌券' AS code, '品牌券' AS remarks, 'Brand coupon' AS explain_, 0 AS is_admin, '品牌券' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '品类优惠券' AS code, '品类优惠券' AS remarks, '品类优惠券' AS explain_, 0 AS is_admin, '品类优惠券' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '品类优惠券' AS code, '[待审]品类优惠券' AS remarks, 'Danh mục Phiếu giảm giá' AS explain_, 0 AS is_admin, '品类优惠券' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '品类优惠券' AS code, '品类优惠券' AS remarks, 'Category Coupons' AS explain_, 0 AS is_admin, '品类优惠券' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '售价' AS code, '售价' AS remarks, '售价' AS explain_, 0 AS is_admin, '售价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '售价' AS code, '[待审]售价' AS remarks, 'giá bán' AS explain_, 0 AS is_admin, '售价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '售价' AS code, '售价' AS remarks, 'selling price' AS explain_, 0 AS is_admin, '售价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '售后单号' AS code, '售后单号' AS remarks, '售后单号' AS explain_, 0 AS is_admin, '售后单号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '售后单号' AS code, '[待审]售后单号' AS remarks, 'Số đơn hàng sau bán hàng' AS explain_, 0 AS is_admin, '售后单号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '售后单号' AS code, '售后单号' AS remarks, 'After-sales order number' AS explain_, 0 AS is_admin, '售后单号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '售后类型' AS code, '售后类型' AS remarks, '售后类型' AS explain_, 0 AS is_admin, '售后类型' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '售后类型' AS code, '[待审]售后类型' AS remarks, 'Loại hậu mãi' AS explain_, 0 AS is_admin, '售后类型' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '售后类型' AS code, '售后类型' AS remarks, 'After-sales type' AS explain_, 0 AS is_admin, '售后类型' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '售后订单' AS code, '售后订单' AS remarks, '售后订单' AS explain_, 0 AS is_admin, '售后订单' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '售后订单' AS code, '[待审]售后订单' AS remarks, 'Đơn hàng sau bán hàng' AS explain_, 0 AS is_admin, '售后订单' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '售后订单' AS code, '售后订单' AS remarks, 'After-sales orders' AS explain_, 0 AS is_admin, '售后订单' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商品优惠券' AS code, '商品优惠券' AS remarks, '商品优惠券' AS explain_, 0 AS is_admin, '商品优惠券' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商品优惠券' AS code, '[待审]商品优惠券' AS remarks, 'Phiếu giảm giá sản phẩm' AS explain_, 0 AS is_admin, '商品优惠券' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商品优惠券' AS code, '商品优惠券' AS remarks, 'Product coupons' AS explain_, 0 AS is_admin, '商品优惠券' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商品名称' AS code, '商品名称' AS remarks, '商品名称' AS explain_, 0 AS is_admin, '商品名称' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商品名称' AS code, '[待审]商品名称' AS remarks, 'Tên sản phẩm' AS explain_, 0 AS is_admin, '商品名称' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商品名称' AS code, '商品名称' AS remarks, 'Product name' AS explain_, 0 AS is_admin, '商品名称' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商品图' AS code, '商品图' AS remarks, '商品图' AS explain_, 0 AS is_admin, '商品图' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商品图' AS code, '[待审]商品图' AS remarks, 'Hình ảnh sản phẩm' AS explain_, 0 AS is_admin, '商品图' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商品图' AS code, '商品图' AS remarks, 'Product picture' AS explain_, 0 AS is_admin, '商品图' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商品图片' AS code, '商品图片' AS remarks, '商品图片' AS explain_, 0 AS is_admin, '商品图片' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商品图片' AS code, '[待审]商品图片' AS remarks, 'Hình ảnh sản phẩm' AS explain_, 0 AS is_admin, '商品图片' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商品图片' AS code, '商品图片' AS remarks, 'Product pictures' AS explain_, 0 AS is_admin, '商品图片' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商品未上架' AS code, '商品未上架' AS remarks, '商品未上架' AS explain_, 0 AS is_admin, '商品未上架' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商品未上架' AS code, '[待审]商品未上架' AS remarks, 'Sản phẩm không có trên kệ' AS explain_, 0 AS is_admin, '商品未上架' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商品未上架' AS code, '商品未上架' AS remarks, 'The product is not on the shelves' AS explain_, 0 AS is_admin, '商品未上架' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商品标签' AS code, '商品标签' AS remarks, '商品标签' AS explain_, 0 AS is_admin, '商品标签' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商品标签' AS code, '[待审]商品标签' AS remarks, 'Thẻ sản phẩm' AS explain_, 0 AS is_admin, '商品标签' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商品标签' AS code, '商品标签' AS remarks, 'Product tag' AS explain_, 0 AS is_admin, '商品标签' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商品核销' AS code, '商品核销' AS remarks, '商品核销' AS explain_, 0 AS is_admin, '商品核销' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商品核销' AS code, '[待审]商品核销' AS remarks, 'Xóa sổ sản phẩm' AS explain_, 0 AS is_admin, '商品核销' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商品核销' AS code, '商品核销' AS remarks, 'Product write-off' AS explain_, 0 AS is_admin, '商品核销' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商品管理' AS code, '商品管理' AS remarks, '商品管理' AS explain_, 0 AS is_admin, '商品管理' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商品管理' AS code, '[待审]商品管理' AS remarks, 'Quản lý sản phẩm' AS explain_, 0 AS is_admin, '商品管理' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商品管理' AS code, '商品管理' AS remarks, 'Product management' AS explain_, 0 AS is_admin, '商品管理' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商城登录' AS code, '商城登录' AS remarks, '商城登录' AS explain_, 0 AS is_admin, '商城登录' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商城登录' AS code, '[待审]商城登录' AS remarks, 'đăng nhập trung tâm mua sắm' AS explain_, 0 AS is_admin, '商城登录' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商城登录' AS code, '商城登录' AS remarks, 'Mall login' AS explain_, 0 AS is_admin, '商城登录' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商城配送' AS code, '商城配送' AS remarks, '商城配送' AS explain_, 0 AS is_admin, '商城配送' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商城配送' AS code, '[待审]商城配送' AS remarks, 'Trung tâm giao hàng' AS explain_, 0 AS is_admin, '商城配送' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商城配送' AS code, '商城配送' AS remarks, 'Mall delivery' AS explain_, 0 AS is_admin, '商城配送' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商家已发货，等待用户收货' AS code, '商家已发货，等待用户收货' AS remarks, '商家已发货，等待用户收货' AS explain_, 0 AS is_admin, '商家已发货，等待用户收货' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商家已发货，等待用户收货' AS code, '[待审]商家已发货，等待用户收货' AS remarks, 'Người bán đã chuyển hàng và đang chờ người dùng nhận hàng.' AS explain_, 0 AS is_admin, '商家已发货，等待用户收货' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商家已发货，等待用户收货' AS code, '商家已发货，等待用户收货' AS remarks, 'The merchant has shipped the goods and is waiting for the user to receive the goods.' AS explain_, 0 AS is_admin, '商家已发货，等待用户收货' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '四' AS code, '四' AS remarks, '四' AS explain_, 0 AS is_admin, '四' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '四' AS code, '[待审]四' AS remarks, 'bốn' AS explain_, 0 AS is_admin, '四' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '四' AS code, '四' AS remarks, 'Four' AS explain_, 0 AS is_admin, '四' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '回到当天' AS code, '回到当天' AS remarks, '回到当天' AS explain_, 0 AS is_admin, '回到当天' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '回到当天' AS code, '[待审]回到当天' AS remarks, 'trở lại ngày hôm đó' AS explain_, 0 AS is_admin, '回到当天' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '回到当天' AS code, '回到当天' AS remarks, 'back to the day' AS explain_, 0 AS is_admin, '回到当天' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '团长' AS code, '团长' AS remarks, '团长' AS explain_, 0 AS is_admin, '团长' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '团长' AS code, '[待审]团长' AS remarks, 'lãnh đạo' AS explain_, 0 AS is_admin, '团长' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '团长' AS code, '团长' AS remarks, 'leader' AS explain_, 0 AS is_admin, '团长' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '固定邮费' AS code, '固定邮费' AS remarks, '固定邮费' AS explain_, 0 AS is_admin, '固定邮费' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '固定邮费' AS code, '[待审]固定邮费' AS remarks, 'Bưu phí cố định' AS explain_, 0 AS is_admin, '固定邮费' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '固定邮费' AS code, '固定邮费' AS remarks, 'Fixed postage' AS explain_, 0 AS is_admin, '固定邮费' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '图片' AS code, '图片' AS remarks, '图片' AS explain_, 0 AS is_admin, '图片' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '图片' AS code, '[待审]图片' AS remarks, 'hình ảnh' AS explain_, 0 AS is_admin, '图片' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '图片' AS code, '图片' AS remarks, 'picture' AS explain_, 0 AS is_admin, '图片' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '图片加载中' AS code, '图片加载中' AS remarks, '图片加载中' AS explain_, 0 AS is_admin, '图片加载中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '图片加载中' AS code, '[待审]图片加载中' AS remarks, 'Đang tải hình ảnh' AS explain_, 0 AS is_admin, '图片加载中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '图片加载中' AS code, '图片加载中' AS remarks, 'Picture loading' AS explain_, 0 AS is_admin, '图片加载中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '图片尺寸为750*750px，最多上传10张' AS code, '图片尺寸为750*750px，最多上传10张' AS remarks, '图片尺寸为750*750px，最多上传10张' AS explain_, 0 AS is_admin, '图片尺寸为750*750px，最多上传10张' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '图片尺寸为750*750px，最多上传10张' AS code, '[待审]图片尺寸为750*750px，最多上传10张' AS remarks, 'Kích thước hình ảnh là 750*750px và có thể tải lên tối đa 10 hình ảnh.' AS explain_, 0 AS is_admin, '图片尺寸为750*750px，最多上传10张' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '图片尺寸为750*750px，最多上传10张' AS code, '图片尺寸为750*750px，最多上传10张' AS remarks, 'The image size is 750*750px, and a maximum of 10 images can be uploaded.' AS explain_, 0 AS is_admin, '图片尺寸为750*750px，最多上传10张' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '图片尺寸为750*750px，最多上传9张' AS code, '图片尺寸为750*750px，最多上传9张' AS remarks, '图片尺寸为750*750px，最多上传9张' AS explain_, 0 AS is_admin, '图片尺寸为750*750px，最多上传9张' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '图片尺寸为750*750px，最多上传9张' AS code, '[待审]图片尺寸为750*750px，最多上传9张' AS remarks, 'Kích thước hình ảnh là 750*750px và có thể tải lên tối đa 9 hình ảnh' AS explain_, 0 AS is_admin, '图片尺寸为750*750px，最多上传9张' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '图片尺寸为750*750px，最多上传9张' AS code, '图片尺寸为750*750px，最多上传9张' AS remarks, 'The image size is 750*750px, and a maximum of 9 images can be uploaded' AS explain_, 0 AS is_admin, '图片尺寸为750*750px，最多上传9张' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '地址' AS code, '地址' AS remarks, '地址' AS explain_, 0 AS is_admin, '地址' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '地址' AS code, '[待审]地址' AS remarks, 'Địa chỉ' AS explain_, 0 AS is_admin, '地址' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '地址' AS code, '地址' AS remarks, 'address' AS explain_, 0 AS is_admin, '地址' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '填写图片验证码' AS code, '填写图片验证码' AS remarks, '填写图片验证码' AS explain_, 0 AS is_admin, '填写图片验证码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '填写图片验证码' AS code, '[待审]填写图片验证码' AS remarks, 'Điền mã xác minh hình ảnh' AS explain_, 0 AS is_admin, '填写图片验证码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '填写图片验证码' AS code, '填写图片验证码' AS remarks, 'Fill in the image verification code' AS explain_, 0 AS is_admin, '填写图片验证码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '填写好友留言，最多40字' AS code, '填写好友留言，最多40字' AS remarks, '填写好友留言，最多40字' AS explain_, 0 AS is_admin, '填写好友留言，最多40字' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '填写好友留言，最多40字' AS code, '[待审]填写好友留言，最多40字' AS remarks, 'Điền tin nhắn của bạn bè, tối đa 40 từ' AS explain_, 0 AS is_admin, '填写好友留言，最多40字' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '填写好友留言，最多40字' AS code, '填写好友留言，最多40字' AS remarks, 'Fill in the friend’s message, up to 40 words' AS explain_, 0 AS is_admin, '填写好友留言，最多40字' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '填写物流单号' AS code, '填写物流单号' AS remarks, '填写物流单号' AS explain_, 0 AS is_admin, '填写物流单号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '填写物流单号' AS code, '[待审]填写物流单号' AS remarks, 'Điền số đơn hàng hậu cần' AS explain_, 0 AS is_admin, '填写物流单号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '填写物流单号' AS code, '填写物流单号' AS remarks, 'Fill in the logistics order number' AS explain_, 0 AS is_admin, '填写物流单号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '增加余额' AS code, '增加余额' AS remarks, '增加余额' AS explain_, 0 AS is_admin, '增加余额' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '增加余额' AS code, '[待审]增加余额' AS remarks, 'tăng số dư' AS explain_, 0 AS is_admin, '增加余额' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '增加余额' AS code, '增加余额' AS remarks, 'increase balance' AS explain_, 0 AS is_admin, '增加余额' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '增加积分' AS code, '增加积分' AS remarks, '增加积分' AS explain_, 0 AS is_admin, '增加积分' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '增加积分' AS code, '[待审]增加积分' AS remarks, 'tăng điểm' AS explain_, 0 AS is_admin, '增加积分' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '增加积分' AS code, '增加积分' AS remarks, 'increase points' AS explain_, 0 AS is_admin, '增加积分' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '处理失败' AS code, '处理失败' AS remarks, '处理失败' AS explain_, 0 AS is_admin, '处理失败' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '处理失败' AS code, '[待审]处理失败' AS remarks, 'Xử lý không thành công' AS explain_, 0 AS is_admin, '处理失败' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '处理失败' AS code, '处理失败' AS remarks, 'Processing failed' AS explain_, 0 AS is_admin, '处理失败' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '复制中' AS code, '复制中' AS remarks, '复制中' AS explain_, 0 AS is_admin, '复制中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '复制中' AS code, '[待审]复制中' AS remarks, 'Sao chép' AS explain_, 0 AS is_admin, '复制中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '复制中' AS code, '复制中' AS remarks, 'Copying' AS explain_, 0 AS is_admin, '复制中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '复制礼物链接' AS code, '复制礼物链接' AS remarks, '复制礼物链接' AS explain_, 0 AS is_admin, '复制礼物链接' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '复制礼物链接' AS code, '[待审]复制礼物链接' AS remarks, 'Sao chép liên kết quà tặng' AS explain_, 0 AS is_admin, '复制礼物链接' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '复制礼物链接' AS code, '复制礼物链接' AS remarks, 'Copy gift link' AS explain_, 0 AS is_admin, '复制礼物链接' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '失败' AS code, '失败' AS remarks, '失败' AS explain_, 0 AS is_admin, '失败' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '失败' AS code, '[待审]失败' AS remarks, 'thất bại' AS explain_, 0 AS is_admin, '失败' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '失败' AS code, '失败' AS remarks, 'fail' AS explain_, 0 AS is_admin, '失败' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '好友留言' AS code, '好友留言' AS remarks, '好友留言' AS explain_, 0 AS is_admin, '好友留言' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '好友留言' AS code, '[待审]好友留言' AS remarks, 'Tin nhắn của bạn bè' AS explain_, 0 AS is_admin, '好友留言' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '好友留言' AS code, '好友留言' AS remarks, 'Friend''s message' AS explain_, 0 AS is_admin, '好友留言' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '如遇到扫码失败请将屏幕调至最亮重新扫码' AS code, '如遇到扫码失败请将屏幕调至最亮重新扫码' AS remarks, '如遇到扫码失败请将屏幕调至最亮重新扫码' AS explain_, 0 AS is_admin, '如遇到扫码失败请将屏幕调至最亮重新扫码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '如遇到扫码失败请将屏幕调至最亮重新扫码' AS code, '[待审]如遇到扫码失败请将屏幕调至最亮重新扫码' AS remarks, 'Nếu quét không thành công, vui lòng điều chỉnh màn hình về cài đặt sáng nhất và quét lại mã QR.' AS explain_, 0 AS is_admin, '如遇到扫码失败请将屏幕调至最亮重新扫码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '如遇到扫码失败请将屏幕调至最亮重新扫码' AS code, '如遇到扫码失败请将屏幕调至最亮重新扫码' AS remarks, 'If scanning fails, please adjust the screen to the brightest setting and scan the QR code again.' AS explain_, 0 AS is_admin, '如遇到扫码失败请将屏幕调至最亮重新扫码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '安装更新文件...' AS code, '安装更新文件...' AS remarks, '安装更新文件...' AS explain_, 0 AS is_admin, '安装更新文件...' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '安装更新文件...' AS code, '[待审]安装更新文件...' AS remarks, 'Cài đặt bản cập nhật...' AS explain_, 0 AS is_admin, '安装更新文件...' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '安装更新文件...' AS code, '安装更新文件...' AS remarks, 'Install updates...' AS explain_, 0 AS is_admin, '安装更新文件...' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '安装更新文件失败[' AS code, '安装更新文件失败[' AS remarks, '安装更新文件失败[' AS explain_, 0 AS is_admin, '安装更新文件失败[' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '安装更新文件失败[' AS code, '[待审]安装更新文件失败[' AS remarks, 'Không cài đặt được tệp cập nhật [' AS explain_, 0 AS is_admin, '安装更新文件失败[' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '安装更新文件失败[' AS code, '安装更新文件失败[' AS remarks, 'Failed to install update file [' AS explain_, 0 AS is_admin, '安装更新文件失败[' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '实际到账:' AS code, '实际到账:' AS remarks, '实际到账:' AS explain_, 0 AS is_admin, '实际到账:' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '实际到账:' AS code, '[待审]实际到账:' AS remarks, 'Đến thực tế:' AS explain_, 0 AS is_admin, '实际到账:' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '实际到账:' AS code, '实际到账:' AS remarks, 'Actual arrival:' AS explain_, 0 AS is_admin, '实际到账:' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '展开' AS code, '展开' AS remarks, '展开' AS explain_, 0 AS is_admin, '展开' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '展开' AS code, '[待审]展开' AS remarks, 'Mở rộng' AS explain_, 0 AS is_admin, '展开' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '展开' AS code, '展开' AS remarks, 'Expand' AS explain_, 0 AS is_admin, '展开' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '工作台' AS code, '工作台' AS remarks, '工作台' AS explain_, 0 AS is_admin, '工作台' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '工作台' AS code, '[待审]工作台' AS remarks, 'bàn làm việc' AS explain_, 0 AS is_admin, '工作台' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '工作台' AS code, '工作台' AS remarks, 'workbench' AS explain_, 0 AS is_admin, '工作台' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已失效' AS code, '已失效' AS remarks, '已失效' AS explain_, 0 AS is_admin, '已失效' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已失效' AS code, '[待审]已失效' AS remarks, 'Hết hạn' AS explain_, 0 AS is_admin, '已失效' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已失效' AS code, '已失效' AS remarks, 'Expired' AS explain_, 0 AS is_admin, '已失效' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已核销' AS code, '已核销' AS remarks, '已核销' AS explain_, 0 AS is_admin, '已核销' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已核销' AS code, '[待审]已核销' AS remarks, 'Viết tắt' AS explain_, 0 AS is_admin, '已核销' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已核销' AS code, '已核销' AS remarks, 'Written off' AS explain_, 0 AS is_admin, '已核销' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已读' AS code, '已读' AS remarks, '已读' AS explain_, 0 AS is_admin, '已读' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已读' AS code, '[待审]已读' AS remarks, 'Đọc' AS explain_, 0 AS is_admin, '已读' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已读' AS code, '已读' AS remarks, 'Read' AS explain_, 0 AS is_admin, '已读' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已过期/暂未开通' AS code, '已过期/暂未开通' AS remarks, '已过期/暂未开通' AS explain_, 0 AS is_admin, '已过期/暂未开通' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已过期/暂未开通' AS code, '[待审]已过期/暂未开通' AS remarks, 'Đã hết hạn/chưa có sẵn' AS explain_, 0 AS is_admin, '已过期/暂未开通' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已过期/暂未开通' AS code, '已过期/暂未开通' AS remarks, 'Expired/not yet available' AS explain_, 0 AS is_admin, '已过期/暂未开通' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已连续签到' AS code, '已连续签到' AS remarks, '已连续签到' AS explain_, 0 AS is_admin, '已连续签到' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已连续签到' AS code, '[待审]已连续签到' AS remarks, 'Đăng nhập liên tục' AS explain_, 0 AS is_admin, '已连续签到' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已连续签到' AS code, '已连续签到' AS remarks, 'Signed in continuously' AS explain_, 0 AS is_admin, '已连续签到' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已配送' AS code, '已配送' AS remarks, '已配送' AS explain_, 0 AS is_admin, '已配送' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已配送' AS code, '[待审]已配送' AS remarks, 'Đã giao hàng' AS explain_, 0 AS is_admin, '已配送' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已配送' AS code, '已配送' AS remarks, 'Delivered' AS explain_, 0 AS is_admin, '已配送' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已预订' AS code, '已预订' AS remarks, '已预订' AS explain_, 0 AS is_admin, '已预订' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已预订' AS code, '[待审]已预订' AS remarks, 'Đã đặt' AS explain_, 0 AS is_admin, '已预订' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已预订' AS code, '已预订' AS remarks, 'Booked' AS explain_, 0 AS is_admin, '已预订' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '年' AS code, '年' AS remarks, '年' AS explain_, 0 AS is_admin, '年' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '年' AS code, '[待审]年' AS remarks, 'Năm' AS explain_, 0 AS is_admin, '年' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '年' AS code, '年' AS remarks, 'Year' AS explain_, 0 AS is_admin, '年' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '库存警告' AS code, '库存警告' AS remarks, '库存警告' AS explain_, 0 AS is_admin, '库存警告' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '库存警告' AS code, '[待审]库存警告' AS remarks, 'Cảnh báo chứng khoán' AS explain_, 0 AS is_admin, '库存警告' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '库存警告' AS code, '库存警告' AS remarks, 'Stock warning' AS explain_, 0 AS is_admin, '库存警告' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '应用资源下载完成！' AS code, '应用资源下载完成！' AS remarks, '应用资源下载完成！' AS explain_, 0 AS is_admin, '应用资源下载完成！' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '应用资源下载完成！' AS code, '[待审]应用资源下载完成！' AS remarks, 'Tải xuống tài nguyên ứng dụng đã hoàn tất!' AS explain_, 0 AS is_admin, '应用资源下载完成！' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '应用资源下载完成！' AS code, '应用资源下载完成！' AS remarks, 'Application resource download completed!' AS explain_, 0 AS is_admin, '应用资源下载完成！' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '建议' AS code, '建议' AS remarks, '建议' AS explain_, 0 AS is_admin, '建议' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '建议' AS code, '[待审]建议' AS remarks, 'gợi ý' AS explain_, 0 AS is_admin, '建议' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '建议' AS code, '建议' AS remarks, 'suggestion' AS explain_, 0 AS is_admin, '建议' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '开启' AS code, '开启' AS remarks, '开启' AS explain_, 0 AS is_admin, '开启' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '开启' AS code, '[待审]开启' AS remarks, 'bật lên' AS explain_, 0 AS is_admin, '开启' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '开启' AS code, '开启' AS remarks, 'turn on' AS explain_, 0 AS is_admin, '开启' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '开盘：' AS code, '开盘：' AS remarks, '开盘：' AS explain_, 0 AS is_admin, '开盘：' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '开盘：' AS code, '[待审]开盘：' AS remarks, 'khai mạc:' AS explain_, 0 AS is_admin, '开盘：' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '开盘：' AS code, '开盘：' AS remarks, 'opening:' AS explain_, 0 AS is_admin, '开盘：' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '开通SVIP会员预计省' AS code, '开通SVIP会员预计省' AS remarks, '开通SVIP会员预计省' AS explain_, 0 AS is_admin, '开通SVIP会员预计省' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '开通SVIP会员预计省' AS code, '[待审]开通SVIP会员预计省' AS remarks, 'Mở SVIP dự kiến tiết kiệm' AS explain_, 0 AS is_admin, '开通SVIP会员预计省' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '开通SVIP会员预计省' AS code, '开通SVIP会员预计省' AS remarks, 'Open SVIP to save about' AS explain_, 0 AS is_admin, '开通SVIP会员预计省' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '张' AS code, '张' AS remarks, '张' AS explain_, 0 AS is_admin, '张' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '张' AS code, '[待审]张' AS remarks, 'mở' AS explain_, 0 AS is_admin, '张' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '张' AS code, '张' AS remarks, 'open' AS explain_, 0 AS is_admin, '张' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '当前使用移动网络，是否继续播放视频？' AS code, '当前使用移动网络，是否继续播放视频？' AS remarks, '当前使用移动网络，是否继续播放视频？' AS explain_, 0 AS is_admin, '当前使用移动网络，是否继续播放视频？' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '当前使用移动网络，是否继续播放视频？' AS code, '[待审]当前使用移动网络，是否继续播放视频？' AS remarks, 'Hiện đang sử dụng mạng di động, bạn có muốn tiếp tục phát video không?' AS explain_, 0 AS is_admin, '当前使用移动网络，是否继续播放视频？' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '当前使用移动网络，是否继续播放视频？' AS code, '当前使用移动网络，是否继续播放视频？' AS remarks, 'Currently using mobile network, do you want to continue playing the video?' AS explain_, 0 AS is_admin, '当前使用移动网络，是否继续播放视频？' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '当前订单已完成核销' AS code, '当前订单已完成核销' AS remarks, '当前订单已完成核销' AS explain_, 0 AS is_admin, '当前订单已完成核销' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '当前订单已完成核销' AS code, '[待审]当前订单已完成核销' AS remarks, 'Lệnh hiện tại đã bị xóa' AS explain_, 0 AS is_admin, '当前订单已完成核销' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '当前订单已完成核销' AS code, '当前订单已完成核销' AS remarks, 'The current order has been written off' AS explain_, 0 AS is_admin, '当前订单已完成核销' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' AS code, '当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' AS remarks, '当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' AS explain_, 0 AS is_admin, '当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' AS code, '[待审]当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' AS remarks, 'Khi bạn nhấp chuột đồng ý và bắt đầu sử dụng dịch vụ của sản phẩm có nghĩa là bạn đã hiểu và đồng ý với các điều khoản, đồng thời các điều khoản đó sẽ có giá trị ràng buộc về mặt pháp lý đối với bạn. Nếu bạn từ chối, bạn sẽ không thể tiến hành bước tiếp theo.' AS explain_, 0 AS is_admin, '当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' AS code, '当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' AS remarks, 'When you click to agree and start using the product services, it means that you have understood and agreed with the terms, and the terms will be legally binding on you. If you refuse, you will not be able to proceed to the next step.' AS explain_, 0 AS is_admin, '当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '待发货/核销' AS code, '待发货/核销' AS remarks, '待发货/核销' AS explain_, 0 AS is_admin, '待发货/核销' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '待发货/核销' AS code, '[待审]待发货/核销' AS remarks, 'Đang chờ giao hàng/xóa sổ' AS explain_, 0 AS is_admin, '待发货/核销' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '待发货/核销' AS code, '待发货/核销' AS remarks, 'Pending shipment/write-off' AS explain_, 0 AS is_admin, '待发货/核销' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '待退货' AS code, '待退货' AS remarks, '待退货' AS explain_, 0 AS is_admin, '待退货' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '待退货' AS code, '[待审]待退货' AS remarks, 'Đang chờ trả lại' AS explain_, 0 AS is_admin, '待退货' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '待退货' AS code, '待退货' AS remarks, 'Pending return' AS explain_, 0 AS is_admin, '待退货' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '待配送' AS code, '待配送' AS remarks, '待配送' AS explain_, 0 AS is_admin, '待配送' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '待配送' AS code, '[待审]待配送' AS remarks, 'Đang chờ giao hàng' AS explain_, 0 AS is_admin, '待配送' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '待配送' AS code, '待配送' AS remarks, 'Awaiting delivery' AS explain_, 0 AS is_admin, '待配送' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '待领取' AS code, '待领取' AS remarks, '待领取' AS explain_, 0 AS is_admin, '待领取' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '待领取' AS code, '[待审]待领取' AS remarks, 'Sẽ được thu thập' AS explain_, 0 AS is_admin, '待领取' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '待领取' AS code, '待领取' AS remarks, 'To be collected' AS explain_, 0 AS is_admin, '待领取' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '忘记密码' AS code, '忘记密码' AS remarks, '忘记密码' AS explain_, 0 AS is_admin, '忘记密码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '忘记密码' AS code, '[待审]忘记密码' AS remarks, 'quên mật khẩu' AS explain_, 0 AS is_admin, '忘记密码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '忘记密码' AS code, '忘记密码' AS remarks, 'forget the password' AS explain_, 0 AS is_admin, '忘记密码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '快递退回' AS code, '快递退回' AS remarks, '快递退回' AS explain_, 0 AS is_admin, '快递退回' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '快递退回' AS code, '[待审]快递退回' AS remarks, 'Trả lại nhanh' AS explain_, 0 AS is_admin, '快递退回' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '快递退回' AS code, '快递退回' AS remarks, 'Express return' AS explain_, 0 AS is_admin, '快递退回' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '成功' AS code, '成功' AS remarks, '成功' AS explain_, 0 AS is_admin, '成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '成功' AS code, '[待审]成功' AS remarks, 'thành công' AS explain_, 0 AS is_admin, '成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '成功' AS code, '成功' AS remarks, 'success' AS explain_, 0 AS is_admin, '成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '成功开启试用' AS code, '成功开启试用' AS remarks, '成功开启试用' AS explain_, 0 AS is_admin, '成功开启试用' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '成功开启试用' AS code, '[待审]成功开启试用' AS remarks, 'Thử nghiệm bắt đầu thành công' AS explain_, 0 AS is_admin, '成功开启试用' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '成功开启试用' AS code, '成功开启试用' AS remarks, 'Trial started successfully' AS explain_, 0 AS is_admin, '成功开启试用' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '成本价' AS code, '成本价' AS remarks, '成本价' AS explain_, 0 AS is_admin, '成本价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '成本价' AS code, '[待审]成本价' AS remarks, 'giá thành' AS explain_, 0 AS is_admin, '成本价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '成本价' AS code, '成本价' AS remarks, 'cost price' AS explain_, 0 AS is_admin, '成本价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '我的礼物' AS code, '我的礼物' AS remarks, '我的礼物' AS explain_, 0 AS is_admin, '我的礼物' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '我的礼物' AS code, '[待审]我的礼物' AS remarks, 'món quà của tôi' AS explain_, 0 AS is_admin, '我的礼物' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '我的礼物' AS code, '我的礼物' AS remarks, 'my gift' AS explain_, 0 AS is_admin, '我的礼物' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '打开错误' AS code, '打开错误' AS remarks, '打开错误' AS explain_, 0 AS is_admin, '打开错误' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '打开错误' AS code, '[待审]打开错误' AS remarks, 'lỗi mở' AS explain_, 0 AS is_admin, '打开错误' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '打开错误' AS code, '打开错误' AS remarks, 'open error' AS explain_, 0 AS is_admin, '打开错误' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '批量修改' AS code, '批量修改' AS remarks, '批量修改' AS explain_, 0 AS is_admin, '批量修改' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '批量修改' AS code, '[待审]批量修改' AS remarks, 'Chỉnh sửa hàng loạt' AS explain_, 0 AS is_admin, '批量修改' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '批量修改' AS code, '批量修改' AS remarks, 'Batch edit' AS explain_, 0 AS is_admin, '批量修改' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '批量操作' AS code, '批量操作' AS remarks, '批量操作' AS explain_, 0 AS is_admin, '批量操作' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '批量操作' AS code, '[待审]批量操作' AS remarks, 'Hoạt động hàng loạt' AS explain_, 0 AS is_admin, '批量操作' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '批量操作' AS code, '批量操作' AS remarks, 'Batch operations' AS explain_, 0 AS is_admin, '批量操作' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '抽奖结果' AS code, '抽奖结果' AS remarks, '抽奖结果' AS explain_, 0 AS is_admin, '抽奖结果' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '抽奖结果' AS code, '[待审]抽奖结果' AS remarks, 'Kết quả xổ số' AS explain_, 0 AS is_admin, '抽奖结果' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '抽奖结果' AS code, '抽奖结果' AS remarks, 'Lottery results' AS explain_, 0 AS is_admin, '抽奖结果' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '拼团简介' AS code, '拼团简介' AS remarks, '拼团简介' AS explain_, 0 AS is_admin, '拼团简介' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '拼团简介' AS code, '[待审]拼团简介' AS remarks, 'Giới thiệu về chia sẻ nhóm' AS explain_, 0 AS is_admin, '拼团简介' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '拼团简介' AS code, '拼团简介' AS remarks, 'Introduction to group sharing' AS explain_, 0 AS is_admin, '拼团简介' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '按下单时间' AS code, '按下单时间' AS remarks, '按下单时间' AS explain_, 0 AS is_admin, '按下单时间' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '按下单时间' AS code, '[待审]按下单时间' AS remarks, 'Nhấn thời gian đặt hàng' AS explain_, 0 AS is_admin, '按下单时间' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '按下单时间' AS code, '按下单时间' AS remarks, 'Press order time' AS explain_, 0 AS is_admin, '按下单时间' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '按支付方式' AS code, '按支付方式' AS remarks, '按支付方式' AS explain_, 0 AS is_admin, '按支付方式' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '按支付方式' AS code, '[待审]按支付方式' AS remarks, 'Theo phương thức thanh toán' AS explain_, 0 AS is_admin, '按支付方式' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '按支付方式' AS code, '按支付方式' AS remarks, 'By payment method' AS explain_, 0 AS is_admin, '按支付方式' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '按退货类型' AS code, '按退货类型' AS remarks, '按退货类型' AS explain_, 0 AS is_admin, '按退货类型' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '按退货类型' AS code, '[待审]按退货类型' AS remarks, 'Theo kiểu trả về' AS explain_, 0 AS is_admin, '按退货类型' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '按退货类型' AS code, '按退货类型' AS remarks, 'By return type' AS explain_, 0 AS is_admin, '按退货类型' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '授权提醒' AS code, '授权提醒' AS remarks, '授权提醒' AS explain_, 0 AS is_admin, '授权提醒' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '授权提醒' AS code, '[待审]授权提醒' AS remarks, 'Nhắc nhở ủy quyền' AS explain_, 0 AS is_admin, '授权提醒' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '授权提醒' AS code, '授权提醒' AS remarks, 'Authorization reminder' AS explain_, 0 AS is_admin, '授权提醒' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '推广人' AS code, '推广人' AS remarks, '推广人' AS explain_, 0 AS is_admin, '推广人' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '推广人' AS code, '[待审]推广人' AS remarks, 'người quảng bá' AS explain_, 0 AS is_admin, '推广人' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '推广人' AS code, '推广人' AS remarks, 'promoter' AS explain_, 0 AS is_admin, '推广人' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '推广佣金' AS code, '推广佣金' AS remarks, '推广佣金' AS explain_, 0 AS is_admin, '推广佣金' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '推广佣金' AS code, '[待审]推广佣金' AS remarks, 'Hoa hồng khuyến mại' AS explain_, 0 AS is_admin, '推广佣金' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '推广佣金' AS code, '推广佣金' AS remarks, 'Promotional commission' AS explain_, 0 AS is_admin, '推广佣金' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '提交成功' AS code, '提交成功' AS remarks, '提交成功' AS explain_, 0 AS is_admin, '提交成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '提交成功' AS code, '[待审]提交成功' AS remarks, 'Gửi thành công' AS explain_, 0 AS is_admin, '提交成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '提交成功' AS code, '提交成功' AS remarks, 'Submission successful' AS explain_, 0 AS is_admin, '提交成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '提供具有辨识度的用户中心界面' AS code, '提供具有辨识度的用户中心界面' AS remarks, '提供具有辨识度的用户中心界面' AS explain_, 0 AS is_admin, '提供具有辨识度的用户中心界面' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '提供具有辨识度的用户中心界面' AS code, '[待审]提供具有辨识度的用户中心界面' AS remarks, 'Cung cấp giao diện lấy người dùng làm trung tâm dễ nhận biết' AS explain_, 0 AS is_admin, '提供具有辨识度的用户中心界面' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '提供具有辨识度的用户中心界面' AS code, '提供具有辨识度的用户中心界面' AS remarks, 'Provide a recognizable user-centered interface' AS explain_, 0 AS is_admin, '提供具有辨识度的用户中心界面' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '提现中' AS code, '提现中' AS remarks, '提现中' AS explain_, 0 AS is_admin, '提现中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '提现中' AS code, '[待审]提现中' AS remarks, 'Rút tiền' AS explain_, 0 AS is_admin, '提现中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '提现中' AS code, '提现中' AS remarks, 'Withdrawing' AS explain_, 0 AS is_admin, '提现中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '提现到余额' AS code, '提现到余额' AS remarks, '提现到余额' AS explain_, 0 AS is_admin, '提现到余额' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '提现到余额' AS code, '[待审]提现到余额' AS remarks, 'Rút tiền để cân bằng' AS explain_, 0 AS is_admin, '提现到余额' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '提现到余额' AS code, '提现到余额' AS remarks, 'Withdraw to balance' AS explain_, 0 AS is_admin, '提现到余额' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '提现到余额后无法再次转出，确认是否提现到余额' AS code, '提现到余额后无法再次转出，确认是否提现到余额' AS remarks, '提现到余额后无法再次转出，确认是否提现到余额' AS explain_, 0 AS is_admin, '提现到余额后无法再次转出，确认是否提现到余额' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '提现到余额后无法再次转出，确认是否提现到余额' AS code, '[待审]提现到余额后无法再次转出，确认是否提现到余额' AS remarks, 'Khi số dư đã được rút, số dư sẽ không thể được chuyển ra ngoài nữa. Vui lòng xác nhận xem số tiền rút có vào số dư hay không.' AS explain_, 0 AS is_admin, '提现到余额后无法再次转出，确认是否提现到余额' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '提现到余额后无法再次转出，确认是否提现到余额' AS code, '提现到余额后无法再次转出，确认是否提现到余额' AS remarks, 'Once the balance is withdrawn, it cannot be transferred out again. Please confirm whether the withdrawal is to the balance.' AS explain_, 0 AS is_admin, '提现到余额后无法再次转出，确认是否提现到余额' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '提现到余额成功' AS code, '提现到余额成功' AS remarks, '提现到余额成功' AS explain_, 0 AS is_admin, '提现到余额成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '提现到余额成功' AS code, '[待审]提现到余额成功' AS remarks, 'Rút tiền để cân bằng thành công' AS explain_, 0 AS is_admin, '提现到余额成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '提现到余额成功' AS code, '提现到余额成功' AS remarks, 'Withdraw to balance successfully' AS explain_, 0 AS is_admin, '提现到余额成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '提现手续费' AS code, '提现手续费' AS remarks, '提现手续费' AS explain_, 0 AS is_admin, '提现手续费' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '提现手续费' AS code, '[待审]提现手续费' AS remarks, 'Phí rút tiền' AS explain_, 0 AS is_admin, '提现手续费' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '提现手续费' AS code, '提现手续费' AS remarks, 'Withdrawal fee' AS explain_, 0 AS is_admin, '提现手续费' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '提现手续费:' AS code, '提现手续费:' AS remarks, '提现手续费:' AS explain_, 0 AS is_admin, '提现手续费:' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '提现手续费:' AS code, '[待审]提现手续费:' AS remarks, 'Phí rút tiền:' AS explain_, 0 AS is_admin, '提现手续费:' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '提现手续费:' AS code, '提现手续费:' AS remarks, 'Withdrawal fee:' AS explain_, 0 AS is_admin, '提现手续费:' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '提现最低' AS code, '提现最低' AS remarks, '提现最低' AS explain_, 0 AS is_admin, '提现最低' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '提现最低' AS code, '[待审]提现最低' AS remarks, 'Rút tiền tối thiểu' AS explain_, 0 AS is_admin, '提现最低' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '提现最低' AS code, '提现最低' AS remarks, 'Minimum withdrawal' AS explain_, 0 AS is_admin, '提现最低' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '提现金额不能高于500' AS code, '提现金额不能高于500' AS remarks, '提现金额不能高于500' AS explain_, 0 AS is_admin, '提现金额不能高于500' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '提现金额不能高于500' AS code, '[待审]提现金额不能高于500' AS remarks, 'Số tiền rút không thể cao hơn 500' AS explain_, 0 AS is_admin, '提现金额不能高于500' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '提现金额不能高于500' AS code, '提现金额不能高于500' AS remarks, 'The withdrawal amount cannot be higher than 500' AS explain_, 0 AS is_admin, '提现金额不能高于500' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '操作失败' AS code, '操作失败' AS remarks, '操作失败' AS explain_, 0 AS is_admin, '操作失败' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '操作失败' AS code, '[待审]操作失败' AS remarks, 'Thao tác không thành công' AS explain_, 0 AS is_admin, '操作失败' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '操作失败' AS code, '操作失败' AS remarks, 'Operation failed' AS explain_, 0 AS is_admin, '操作失败' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '操作提示' AS code, '操作提示' AS remarks, '操作提示' AS explain_, 0 AS is_admin, '操作提示' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '操作提示' AS code, '[待审]操作提示' AS remarks, 'Mẹo vận hành' AS explain_, 0 AS is_admin, '操作提示' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '操作提示' AS code, '操作提示' AS remarks, 'Operation tips' AS explain_, 0 AS is_admin, '操作提示' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '支付剩余' AS code, '支付剩余' AS remarks, '支付剩余' AS explain_, 0 AS is_admin, '支付剩余' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '支付剩余' AS code, '[待审]支付剩余' AS remarks, 'Thanh toán còn lại' AS explain_, 0 AS is_admin, '支付剩余' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '支付剩余' AS code, '支付剩余' AS remarks, 'Pay remaining' AS explain_, 0 AS is_admin, '支付剩余' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '支付失败：' AS code, '支付失败：' AS remarks, '支付失败：' AS explain_, 0 AS is_admin, '支付失败：' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '支付失败：' AS code, '[待审]支付失败：' AS remarks, 'Thanh toán không thành công:' AS explain_, 0 AS is_admin, '支付失败：' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '支付失败：' AS code, '支付失败：' AS remarks, 'Payment failed:' AS explain_, 0 AS is_admin, '支付失败：' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '支付已取消' AS code, '支付已取消' AS remarks, '支付已取消' AS explain_, 0 AS is_admin, '支付已取消' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '支付已取消' AS code, '[待审]支付已取消' AS remarks, 'Đã hủy thanh toán' AS explain_, 0 AS is_admin, '支付已取消' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '支付已取消' AS code, '支付已取消' AS remarks, 'Payment canceled' AS explain_, 0 AS is_admin, '支付已取消' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '支付时间' AS code, '支付时间' AS remarks, '支付时间' AS explain_, 0 AS is_admin, '支付时间' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '支付时间' AS code, '[待审]支付时间' AS remarks, 'thời gian thanh toán' AS explain_, 0 AS is_admin, '支付时间' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '支付时间' AS code, '支付时间' AS remarks, 'payment time' AS explain_, 0 AS is_admin, '支付时间' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '收下礼物' AS code, '收下礼物' AS remarks, '收下礼物' AS explain_, 0 AS is_admin, '收下礼物' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '收下礼物' AS code, '[待审]收下礼物' AS remarks, 'chấp nhận món quà' AS explain_, 0 AS is_admin, '收下礼物' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '收下礼物' AS code, '收下礼物' AS remarks, 'accept the gift' AS explain_, 0 AS is_admin, '收下礼物' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '收件人或寄件人手机号后四位' AS code, '收件人或寄件人手机号后四位' AS remarks, '收件人或寄件人手机号后四位' AS explain_, 0 AS is_admin, '收件人或寄件人手机号后四位' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '收件人或寄件人手机号后四位' AS code, '[待审]收件人或寄件人手机号后四位' AS remarks, 'Bốn chữ số cuối của số điện thoại di động của người nhận hoặc người gửi' AS explain_, 0 AS is_admin, '收件人或寄件人手机号后四位' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '收件人或寄件人手机号后四位' AS code, '收件人或寄件人手机号后四位' AS remarks, 'The last four digits of the recipient’s or sender’s mobile phone number' AS explain_, 0 AS is_admin, '收件人或寄件人手机号后四位' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '收到' AS code, '收到' AS remarks, '收到' AS explain_, 0 AS is_admin, '收到' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '收到' AS code, '[待审]收到' AS remarks, 'nhận được' AS explain_, 0 AS is_admin, '收到' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '收到' AS code, '收到' AS remarks, 'receive' AS explain_, 0 AS is_admin, '收到' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '收款' AS code, '收款' AS remarks, '收款' AS explain_, 0 AS is_admin, '收款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '收款' AS code, '[待审]收款' AS remarks, 'Bộ sưu tập' AS explain_, 0 AS is_admin, '收款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '收款' AS code, '收款' AS remarks, 'Collection' AS explain_, 0 AS is_admin, '收款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '收款成功' AS code, '收款成功' AS remarks, '收款成功' AS explain_, 0 AS is_admin, '收款成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '收款成功' AS code, '[待审]收款成功' AS remarks, 'Bộ sưu tập thành công' AS explain_, 0 AS is_admin, '收款成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '收款成功' AS code, '收款成功' AS remarks, 'Collection successful' AS explain_, 0 AS is_admin, '收款成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '收款方式' AS code, '收款方式' AS remarks, '收款方式' AS explain_, 0 AS is_admin, '收款方式' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '收款方式' AS code, '[待审]收款方式' AS remarks, 'Phương thức thanh toán' AS explain_, 0 AS is_admin, '收款方式' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '收款方式' AS code, '收款方式' AS remarks, 'Payment method' AS explain_, 0 AS is_admin, '收款方式' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '收款至微信' AS code, '收款至微信' AS remarks, '收款至微信' AS explain_, 0 AS is_admin, '收款至微信' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '收款至微信' AS code, '[待审]收款至微信' AS remarks, 'Nhận thanh toán tới WeChat' AS explain_, 0 AS is_admin, '收款至微信' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '收款至微信' AS code, '收款至微信' AS remarks, 'Receive payment to WeChat' AS explain_, 0 AS is_admin, '收款至微信' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '收款金额' AS code, '收款金额' AS remarks, '收款金额' AS explain_, 0 AS is_admin, '收款金额' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '收款金额' AS code, '[待审]收款金额' AS remarks, 'Số tiền thanh toán' AS explain_, 0 AS is_admin, '收款金额' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '收款金额' AS code, '收款金额' AS remarks, 'Payment amount' AS explain_, 0 AS is_admin, '收款金额' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '收盘：' AS code, '收盘：' AS remarks, '收盘：' AS explain_, 0 AS is_admin, '收盘：' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '收盘：' AS code, '[待审]收盘：' AS remarks, 'Đóng cửa:' AS explain_, 0 AS is_admin, '收盘：' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '收盘：' AS code, '收盘：' AS remarks, 'Closing:' AS explain_, 0 AS is_admin, '收盘：' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '收藏商品' AS code, '收藏商品' AS remarks, '收藏商品' AS explain_, 0 AS is_admin, '收藏商品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '收藏商品' AS code, '[待审]收藏商品' AS remarks, 'Thu thập vật phẩm' AS explain_, 0 AS is_admin, '收藏商品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '收藏商品' AS code, '收藏商品' AS remarks, 'Collect items' AS explain_, 0 AS is_admin, '收藏商品' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '整单退款' AS code, '整单退款' AS remarks, '整单退款' AS explain_, 0 AS is_admin, '整单退款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '整单退款' AS code, '[待审]整单退款' AS remarks, 'Hoàn tiền toàn bộ đơn hàng' AS explain_, 0 AS is_admin, '整单退款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '整单退款' AS code, '整单退款' AS remarks, 'Whole order refund' AS explain_, 0 AS is_admin, '整单退款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '新人专享优惠券' AS code, '新人专享优惠券' AS remarks, '新人专享优惠券' AS explain_, 0 AS is_admin, '新人专享优惠券' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '新人专享优惠券' AS code, '[待审]新人专享优惠券' AS remarks, 'Phiếu giảm giá độc quyền cho người mới' AS explain_, 0 AS is_admin, '新人专享优惠券' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '新人专享优惠券' AS code, '新人专享优惠券' AS remarks, 'Exclusive coupons for newcomers' AS explain_, 0 AS is_admin, '新人专享优惠券' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '新人专享福利' AS code, '新人专享福利' AS remarks, '新人专享福利' AS explain_, 0 AS is_admin, '新人专享福利' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '新人专享福利' AS code, '[待审]新人专享福利' AS remarks, 'Quyền lợi dành riêng cho người mới' AS explain_, 0 AS is_admin, '新人专享福利' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '新人专享福利' AS code, '新人专享福利' AS remarks, 'Exclusive benefits for newcomers' AS explain_, 0 AS is_admin, '新人专享福利' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '新人商品专区' AS code, '新人商品专区' AS remarks, '新人商品专区' AS explain_, 0 AS is_admin, '新人商品专区' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '新人商品专区' AS code, '[待审]新人商品专区' AS remarks, 'Khu vực sản phẩm dành cho người mới' AS explain_, 0 AS is_admin, '新人商品专区' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '新人商品专区' AS code, '新人商品专区' AS remarks, 'Product area for newcomers' AS explain_, 0 AS is_admin, '新人商品专区' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '新人红包' AS code, '新人红包' AS remarks, '新人红包' AS explain_, 0 AS is_admin, '新人红包' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '新人红包' AS code, '[待审]新人红包' AS remarks, 'Phong bì đỏ dành cho người mới' AS explain_, 0 AS is_admin, '新人红包' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '新人红包' AS code, '新人红包' AS remarks, 'Newbie red envelope' AS explain_, 0 AS is_admin, '新人红包' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '新版本下载失败' AS code, '新版本下载失败' AS remarks, '新版本下载失败' AS explain_, 0 AS is_admin, '新版本下载失败' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '新版本下载失败' AS code, '[待审]新版本下载失败' AS remarks, 'Tải xuống phiên bản mới không thành công' AS explain_, 0 AS is_admin, '新版本下载失败' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '新版本下载失败' AS code, '新版本下载失败' AS remarks, 'New version download failed' AS explain_, 0 AS is_admin, '新版本下载失败' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '新版本已经下载好，是否重启当前应用？' AS code, '新版本已经下载好，是否重启当前应用？' AS remarks, '新版本已经下载好，是否重启当前应用？' AS explain_, 0 AS is_admin, '新版本已经下载好，是否重启当前应用？' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '新版本已经下载好，是否重启当前应用？' AS code, '[待审]新版本已经下载好，是否重启当前应用？' AS remarks, 'Phiên bản mới đã được tải xuống. Bạn có muốn khởi động lại ứng dụng hiện tại không?' AS explain_, 0 AS is_admin, '新版本已经下载好，是否重启当前应用？' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '新版本已经下载好，是否重启当前应用？' AS code, '新版本已经下载好，是否重启当前应用？' AS remarks, 'The new version has been downloaded. Do you want to restart the current application?' AS explain_, 0 AS is_admin, '新版本已经下载好，是否重启当前应用？' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '新用户注册即可' AS code, '新用户注册即可' AS remarks, '新用户注册即可' AS explain_, 0 AS is_admin, '新用户注册即可' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '新用户注册即可' AS code, '[待审]新用户注册即可' AS remarks, 'Người dùng mới có thể đăng ký' AS explain_, 0 AS is_admin, '新用户注册即可' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '新用户注册即可' AS code, '新用户注册即可' AS remarks, 'New users can register' AS explain_, 0 AS is_admin, '新用户注册即可' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '新用户注册后即可获得积分' AS code, '新用户注册后即可获得积分' AS remarks, '新用户注册后即可获得积分' AS explain_, 0 AS is_admin, '新用户注册后即可获得积分' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '新用户注册后即可获得积分' AS code, '[待审]新用户注册后即可获得积分' AS remarks, 'Người dùng mới có thể kiếm điểm sau khi đăng ký' AS explain_, 0 AS is_admin, '新用户注册后即可获得积分' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '新用户注册后即可获得积分' AS code, '新用户注册后即可获得积分' AS remarks, 'New users can earn points after registering' AS explain_, 0 AS is_admin, '新用户注册后即可获得积分' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '新用户注册领积分' AS code, '新用户注册领积分' AS remarks, '新用户注册领积分' AS explain_, 0 AS is_admin, '新用户注册领积分' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '新用户注册领积分' AS code, '[待审]新用户注册领积分' AS remarks, 'Đăng ký người dùng mới để nhận điểm' AS explain_, 0 AS is_admin, '新用户注册领积分' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '新用户注册领积分' AS code, '新用户注册领积分' AS remarks, 'New user registration to receive points' AS explain_, 0 AS is_admin, '新用户注册领积分' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '无' AS code, '无' AS remarks, '无' AS explain_, 0 AS is_admin, '无' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '无' AS code, '[待审]无' AS remarks, 'không có' AS explain_, 0 AS is_admin, '无' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '无' AS code, '无' AS remarks, 'none' AS explain_, 0 AS is_admin, '无' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '昨日' AS code, '昨日' AS remarks, '昨日' AS explain_, 0 AS is_admin, '昨日' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '昨日' AS code, '[待审]昨日' AS remarks, 'Hôm qua' AS explain_, 0 AS is_admin, '昨日' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '昨日' AS code, '昨日' AS remarks, 'yesterday' AS explain_, 0 AS is_admin, '昨日' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '是否确认核销该订单？' AS code, '是否确认核销该订单？' AS remarks, '是否确认核销该订单？' AS explain_, 0 AS is_admin, '是否确认核销该订单？' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '是否确认核销该订单？' AS code, '[待审]是否确认核销该订单？' AS remarks, 'Bạn có muốn xác nhận việc hủy bỏ lệnh này không?' AS explain_, 0 AS is_admin, '是否确认核销该订单？' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '是否确认核销该订单？' AS code, '是否确认核销该订单？' AS remarks, 'Do you want to confirm the write-off of this order?' AS explain_, 0 AS is_admin, '是否确认核销该订单？' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂无优惠券～' AS code, '暂无优惠券～' AS remarks, '暂无优惠券～' AS explain_, 0 AS is_admin, '暂无优惠券～' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂无优惠券～' AS code, '[待审]暂无优惠券～' AS remarks, 'Chưa có phiếu giảm giá ~' AS explain_, 0 AS is_admin, '暂无优惠券～' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂无优惠券～' AS code, '暂无优惠券～' AS remarks, 'No coupons yet ~' AS explain_, 0 AS is_admin, '暂无优惠券～' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂无分类～' AS code, '暂无分类～' AS remarks, '暂无分类～' AS explain_, 0 AS is_admin, '暂无分类～' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂无分类～' AS code, '[待审]暂无分类～' AS remarks, 'Chưa có phân loại nào~' AS explain_, 0 AS is_admin, '暂无分类～' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂无分类～' AS code, '暂无分类～' AS remarks, 'No classification yet~' AS explain_, 0 AS is_admin, '暂无分类～' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂无商品，去看点别的吧～' AS code, '暂无商品，去看点别的吧～' AS remarks, '暂无商品，去看点别的吧～' AS explain_, 0 AS is_admin, '暂无商品，去看点别的吧～' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂无商品，去看点别的吧～' AS code, '[待审]暂无商品，去看点别的吧～' AS remarks, 'Chưa có sản phẩm nào Hãy nhìn vào cái gì khác ~' AS explain_, 0 AS is_admin, '暂无商品，去看点别的吧～' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂无商品，去看点别的吧～' AS code, '暂无商品，去看点别的吧～' AS remarks, 'There are no products yet. Let’s look at something else~' AS explain_, 0 AS is_admin, '暂无商品，去看点别的吧～' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂无商品～' AS code, '暂无商品～' AS remarks, '暂无商品～' AS explain_, 0 AS is_admin, '暂无商品～' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂无商品～' AS code, '[待审]暂无商品～' AS remarks, 'Chưa có sản phẩm nào ~' AS explain_, 0 AS is_admin, '暂无商品～' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂无商品～' AS code, '暂无商品～' AS remarks, 'There are no products yet ~' AS explain_, 0 AS is_admin, '暂无商品～' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂无数据～' AS code, '暂无数据～' AS remarks, '暂无数据～' AS explain_, 0 AS is_admin, '暂无数据～' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂无数据～' AS code, '[待审]暂无数据～' AS remarks, 'Chưa có dữ liệu~' AS explain_, 0 AS is_admin, '暂无数据～' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂无数据～' AS code, '暂无数据～' AS remarks, 'No data yet~' AS explain_, 0 AS is_admin, '暂无数据～' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂无标签～' AS code, '暂无标签～' AS remarks, '暂无标签～' AS explain_, 0 AS is_admin, '暂无标签～' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂无标签～' AS code, '[待审]暂无标签～' AS remarks, 'Chưa có thẻ nào ~' AS explain_, 0 AS is_admin, '暂无标签～' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂无标签～' AS code, '暂无标签～' AS remarks, 'No tags yet ~' AS explain_, 0 AS is_admin, '暂无标签～' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂无物流信息' AS code, '暂无物流信息' AS remarks, '暂无物流信息' AS explain_, 0 AS is_admin, '暂无物流信息' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂无物流信息' AS code, '[待审]暂无物流信息' AS remarks, 'Chưa có thông tin hậu cần' AS explain_, 0 AS is_admin, '暂无物流信息' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂无物流信息' AS code, '暂无物流信息' AS remarks, 'No logistics information yet' AS explain_, 0 AS is_admin, '暂无物流信息' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂无用户信息～' AS code, '暂无用户信息～' AS remarks, '暂无用户信息～' AS explain_, 0 AS is_admin, '暂无用户信息～' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂无用户信息～' AS code, '[待审]暂无用户信息～' AS remarks, 'Chưa có thông tin người dùng ~' AS explain_, 0 AS is_admin, '暂无用户信息～' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂无用户信息～' AS code, '暂无用户信息～' AS remarks, 'No user information yet~' AS explain_, 0 AS is_admin, '暂无用户信息～' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂无订单～' AS code, '暂无订单～' AS remarks, '暂无订单～' AS explain_, 0 AS is_admin, '暂无订单～' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂无订单～' AS code, '[待审]暂无订单～' AS remarks, 'Chưa có đơn đặt hàng nào ~' AS explain_, 0 AS is_admin, '暂无订单～' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂无订单～' AS code, '暂无订单～' AS remarks, 'No orders yet~' AS explain_, 0 AS is_admin, '暂无订单～' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂无评论' AS code, '暂无评论' AS remarks, '暂无评论' AS explain_, 0 AS is_admin, '暂无评论' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂无评论' AS code, '[待审]暂无评论' AS remarks, 'không có bình luận' AS explain_, 0 AS is_admin, '暂无评论' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂无评论' AS code, '暂无评论' AS remarks, 'no comments' AS explain_, 0 AS is_admin, '暂无评论' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂未开启等级' AS code, '暂未开启等级' AS remarks, '暂未开启等级' AS explain_, 0 AS is_admin, '暂未开启等级' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂未开启等级' AS code, '[待审]暂未开启等级' AS remarks, 'Cấp độ chưa được mở' AS explain_, 0 AS is_admin, '暂未开启等级' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂未开启等级' AS code, '暂未开启等级' AS remarks, 'Level not yet opened' AS explain_, 0 AS is_admin, '暂未开启等级' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂未解锁' AS code, '暂未解锁' AS remarks, '暂未解锁' AS explain_, 0 AS is_admin, '暂未解锁' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂未解锁' AS code, '[待审]暂未解锁' AS remarks, 'Chưa mở khóa' AS explain_, 0 AS is_admin, '暂未解锁' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂未解锁' AS code, '暂未解锁' AS remarks, 'Not unlocked yet' AS explain_, 0 AS is_admin, '暂未解锁' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '更多优惠' AS code, '更多优惠' AS remarks, '更多优惠' AS explain_, 0 AS is_admin, '更多优惠' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '更多优惠' AS code, '[待审]更多优惠' AS remarks, 'Ưu đãi khác' AS explain_, 0 AS is_admin, '更多优惠' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '更多优惠' AS code, '更多优惠' AS remarks, 'More offers' AS explain_, 0 AS is_admin, '更多优惠' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '更新提示' AS code, '更新提示' AS remarks, '更新提示' AS explain_, 0 AS is_admin, '更新提示' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '更新提示' AS code, '[待审]更新提示' AS remarks, 'Cập nhật mẹo' AS explain_, 0 AS is_admin, '更新提示' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '更新提示' AS code, '更新提示' AS remarks, 'Update tips' AS explain_, 0 AS is_admin, '更新提示' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '最低：' AS code, '最低：' AS remarks, '最低：' AS explain_, 0 AS is_admin, '最低：' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '最低：' AS code, '[待审]最低：' AS remarks, 'thấp nhất:' AS explain_, 0 AS is_admin, '最低：' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '最低：' AS code, '最低：' AS remarks, 'lowest:' AS explain_, 0 AS is_admin, '最低：' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '最多可兑换' AS code, '最多可兑换' AS remarks, '最多可兑换' AS explain_, 0 AS is_admin, '最多可兑换' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '最多可兑换' AS code, '[待审]最多可兑换' AS remarks, 'Có thể đổi tối đa' AS explain_, 0 AS is_admin, '最多可兑换' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '最多可兑换' AS code, '最多可兑换' AS remarks, 'Maximum redeemable' AS explain_, 0 AS is_admin, '最多可兑换' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '最少添加 1 件商品' AS code, '最少添加 1 件商品' AS remarks, '最少添加 1 件商品' AS explain_, 0 AS is_admin, '最少添加 1 件商品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '最少添加 1 件商品' AS code, '[待审]最少添加 1 件商品' AS remarks, 'Thêm ít nhất 1 mục' AS explain_, 0 AS is_admin, '最少添加 1 件商品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '最少添加 1 件商品' AS code, '最少添加 1 件商品' AS remarks, 'Add at least 1 item' AS explain_, 0 AS is_admin, '最少添加 1 件商品' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '最高：' AS code, '最高：' AS remarks, '最高：' AS explain_, 0 AS is_admin, '最高：' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '最高：' AS code, '[待审]最高：' AS remarks, 'Cao nhất:' AS explain_, 0 AS is_admin, '最高：' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '最高：' AS code, '最高：' AS remarks, 'Highest:' AS explain_, 0 AS is_admin, '最高：' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '月' AS code, '月' AS remarks, '月' AS explain_, 0 AS is_admin, '月' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '月' AS code, '[待审]月' AS remarks, 'mặt trăng' AS explain_, 0 AS is_admin, '月' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '月' AS code, '月' AS remarks, 'moon' AS explain_, 0 AS is_admin, '月' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '服务' AS code, '服务' AS remarks, '服务' AS explain_, 0 AS is_admin, '服务' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '服务' AS code, '[待审]服务' AS remarks, 'Phục vụ' AS explain_, 0 AS is_admin, '服务' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '服务' AS code, '服务' AS remarks, 'Serve' AS explain_, 0 AS is_admin, '服务' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '服务与隐私协议' AS code, '服务与隐私协议' AS remarks, '服务与隐私协议' AS explain_, 0 AS is_admin, '服务与隐私协议' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '服务与隐私协议' AS code, '[待审]服务与隐私协议' AS remarks, 'Thỏa thuận dịch vụ và quyền riêng tư' AS explain_, 0 AS is_admin, '服务与隐私协议' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '服务与隐私协议' AS code, '服务与隐私协议' AS remarks, 'Service and Privacy Agreement' AS explain_, 0 AS is_admin, '服务与隐私协议' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '服务保障' AS code, '服务保障' AS remarks, '服务保障' AS explain_, 0 AS is_admin, '服务保障' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '服务保障' AS code, '[待审]服务保障' AS remarks, 'Bảo đảm dịch vụ' AS explain_, 0 AS is_admin, '服务保障' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '服务保障' AS code, '服务保障' AS remarks, 'Service guarantee' AS explain_, 0 AS is_admin, '服务保障' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '未登录' AS code, '未登录' AS remarks, '未登录' AS explain_, 0 AS is_admin, '未登录' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '未登录' AS code, '[待审]未登录' AS remarks, 'Chưa đăng nhập' AS explain_, 0 AS is_admin, '未登录' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '未登录' AS code, '未登录' AS remarks, 'Not logged in' AS explain_, 0 AS is_admin, '未登录' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '查看地图' AS code, '查看地图' AS remarks, '查看地图' AS explain_, 0 AS is_admin, '查看地图' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '查看地图' AS code, '[待审]查看地图' AS remarks, 'Xem bản đồ' AS explain_, 0 AS is_admin, '查看地图' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '查看地图' AS code, '查看地图' AS remarks, 'View map' AS explain_, 0 AS is_admin, '查看地图' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '查看更多物流详情' AS code, '查看更多物流详情' AS remarks, '查看更多物流详情' AS explain_, 0 AS is_admin, '查看更多物流详情' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '查看更多物流详情' AS code, '[待审]查看更多物流详情' AS remarks, 'Xem thêm chi tiết hậu cần' AS explain_, 0 AS is_admin, '查看更多物流详情' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '查看更多物流详情' AS code, '查看更多物流详情' AS remarks, 'View more logistics details' AS explain_, 0 AS is_admin, '查看更多物流详情' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '查看礼物' AS code, '查看礼物' AS remarks, '查看礼物' AS explain_, 0 AS is_admin, '查看礼物' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '查看礼物' AS code, '[待审]查看礼物' AS remarks, 'xem quà tặng' AS explain_, 0 AS is_admin, '查看礼物' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '查看礼物' AS code, '查看礼物' AS remarks, 'view gifts' AS explain_, 0 AS is_admin, '查看礼物' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '查看礼物详情' AS code, '查看礼物详情' AS remarks, '查看礼物详情' AS explain_, 0 AS is_admin, '查看礼物详情' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '查看礼物详情' AS code, '[待审]查看礼物详情' AS remarks, 'Xem chi tiết quà tặng' AS explain_, 0 AS is_admin, '查看礼物详情' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '查看礼物详情' AS code, '查看礼物详情' AS remarks, 'View gift details' AS explain_, 0 AS is_admin, '查看礼物详情' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '标签' AS code, '标签' AS remarks, '标签' AS explain_, 0 AS is_admin, '标签' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '标签' AS code, '[待审]标签' AS remarks, 'Nhãn' AS explain_, 0 AS is_admin, '标签' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '标签' AS code, '标签' AS remarks, 'Label' AS explain_, 0 AS is_admin, '标签' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '核销' AS code, '核销' AS remarks, '核销' AS explain_, 0 AS is_admin, '核销' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '核销' AS code, '[待审]核销' AS remarks, 'Viết tắt' AS explain_, 0 AS is_admin, '核销' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '核销' AS code, '核销' AS remarks, 'Write off' AS explain_, 0 AS is_admin, '核销' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '核销其他订单' AS code, '核销其他订单' AS remarks, '核销其他订单' AS explain_, 0 AS is_admin, '核销其他订单' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '核销其他订单' AS code, '[待审]核销其他订单' AS remarks, 'Xóa các đơn đặt hàng khác' AS explain_, 0 AS is_admin, '核销其他订单' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '核销其他订单' AS code, '核销其他订单' AS remarks, 'Write off other orders' AS explain_, 0 AS is_admin, '核销其他订单' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '核销成功' AS code, '核销成功' AS remarks, '核销成功' AS explain_, 0 AS is_admin, '核销成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '核销成功' AS code, '[待审]核销成功' AS remarks, 'Xóa sổ thành công' AS explain_, 0 AS is_admin, '核销成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '核销成功' AS code, '核销成功' AS remarks, 'Write-off successful' AS explain_, 0 AS is_admin, '核销成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '核销记录' AS code, '核销记录' AS remarks, '核销记录' AS explain_, 0 AS is_admin, '核销记录' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '核销记录' AS code, '[待审]核销记录' AS remarks, 'Hồ sơ xóa sổ' AS explain_, 0 AS is_admin, '核销记录' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '核销记录' AS code, '核销记录' AS remarks, 'Write-off records' AS explain_, 0 AS is_admin, '核销记录' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '次' AS code, '次' AS remarks, '次' AS explain_, 0 AS is_admin, '次' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '次' AS code, '[待审]次' AS remarks, 'hạng hai' AS explain_, 0 AS is_admin, '次' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '次' AS code, '次' AS remarks, 'Second-rate' AS explain_, 0 AS is_admin, '次' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '款' AS code, '款' AS remarks, '款' AS explain_, 0 AS is_admin, '款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '款' AS code, '[待审]款' AS remarks, 'mẫu' AS explain_, 0 AS is_admin, '款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '款' AS code, '款' AS remarks, 'options' AS explain_, 0 AS is_admin, '款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '正在加载...' AS code, '正在加载...' AS remarks, '正在加载...' AS explain_, 0 AS is_admin, '正在加载...' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '正在加载...' AS code, '[待审]正在加载...' AS remarks, 'Đang tải...' AS explain_, 0 AS is_admin, '正在加载...' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '正在加载...' AS code, '正在加载...' AS remarks, 'Loading...' AS explain_, 0 AS is_admin, '正在加载...' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '每次最多只提交100条数据' AS code, '每次最多只提交100条数据' AS remarks, '每次最多只提交100条数据' AS explain_, 0 AS is_admin, '每次最多只提交100条数据' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '每次最多只提交100条数据' AS code, '[待审]每次最多只提交100条数据' AS remarks, 'Chỉ có thể gửi tối đa 100 mẩu dữ liệu mỗi lần' AS explain_, 0 AS is_admin, '每次最多只提交100条数据' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '每次最多只提交100条数据' AS code, '每次最多只提交100条数据' AS remarks, 'Only a maximum of 100 pieces of data can be submitted each time' AS explain_, 0 AS is_admin, '每次最多只提交100条数据' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '没有更多了～' AS code, '没有更多了～' AS remarks, '没有更多了～' AS explain_, 0 AS is_admin, '没有更多了～' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '没有更多了～' AS code, '[待审]没有更多了～' AS remarks, 'Không còn nữa~' AS explain_, 0 AS is_admin, '没有更多了～' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '没有更多了～' AS code, '没有更多了～' AS remarks, 'No more~' AS explain_, 0 AS is_admin, '没有更多了～' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '注册成功' AS code, '注册成功' AS remarks, '注册成功' AS explain_, 0 AS is_admin, '注册成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '注册成功' AS code, '[待审]注册成功' AS remarks, 'Đăng ký thành công' AS explain_, 0 AS is_admin, '注册成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '注册成功' AS code, '注册成功' AS remarks, 'Registration successful' AS explain_, 0 AS is_admin, '注册成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '注册时间' AS code, '注册时间' AS remarks, '注册时间' AS explain_, 0 AS is_admin, '注册时间' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '注册时间' AS code, '[待审]注册时间' AS remarks, 'Thời gian đăng ký' AS explain_, 0 AS is_admin, '注册时间' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '注册时间' AS code, '注册时间' AS remarks, 'Registration time' AS explain_, 0 AS is_admin, '注册时间' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '活动福利，第一时间了解' AS code, '活动福利，第一时间了解' AS remarks, '活动福利，第一时间了解' AS explain_, 0 AS is_admin, '活动福利，第一时间了解' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '活动福利，第一时间了解' AS code, '[待审]活动福利，第一时间了解' AS remarks, 'Các hoạt động và lợi ích, hãy tìm hiểu về chúng càng sớm càng tốt' AS explain_, 0 AS is_admin, '活动福利，第一时间了解' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '活动福利，第一时间了解' AS code, '活动福利，第一时间了解' AS remarks, 'Activities and benefits, learn about them as soon as possible' AS explain_, 0 AS is_admin, '活动福利，第一时间了解' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '浏览' AS code, '浏览' AS remarks, '浏览' AS explain_, 0 AS is_admin, '浏览' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '浏览' AS code, '[待审]浏览' AS remarks, 'Duyệt qua' AS explain_, 0 AS is_admin, '浏览' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '浏览' AS code, '浏览' AS remarks, 'Browse' AS explain_, 0 AS is_admin, '浏览' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '消费笔数' AS code, '消费笔数' AS remarks, '消费笔数' AS explain_, 0 AS is_admin, '消费笔数' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '消费笔数' AS code, '[待审]消费笔数' AS remarks, 'Số lượng mua hàng' AS explain_, 0 AS is_admin, '消费笔数' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '消费笔数' AS code, '消费笔数' AS remarks, 'Number of purchases' AS explain_, 0 AS is_admin, '消费笔数' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '添加商品' AS code, '添加商品' AS remarks, '添加商品' AS explain_, 0 AS is_admin, '添加商品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '添加商品' AS code, '[待审]添加商品' AS remarks, 'Thêm sản phẩm' AS explain_, 0 AS is_admin, '添加商品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '添加商品' AS code, '添加商品' AS remarks, 'Add product' AS explain_, 0 AS is_admin, '添加商品' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '添加标签' AS code, '添加标签' AS remarks, '添加标签' AS explain_, 0 AS is_admin, '添加标签' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '添加标签' AS code, '[待审]添加标签' AS remarks, 'Thêm thẻ' AS explain_, 0 AS is_admin, '添加标签' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '添加标签' AS code, '添加标签' AS remarks, 'Add tag' AS explain_, 0 AS is_admin, '添加标签' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '激活中' AS code, '激活中' AS remarks, '激活中' AS explain_, 0 AS is_admin, '激活中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '激活中' AS code, '[待审]激活中' AS remarks, 'Kích hoạt' AS explain_, 0 AS is_admin, '激活中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '激活中' AS code, '激活中' AS remarks, 'Activating' AS explain_, 0 AS is_admin, '激活中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '点击搜索名称' AS code, '点击搜索名称' AS remarks, '点击搜索名称' AS explain_, 0 AS is_admin, '点击搜索名称' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '点击搜索名称' AS code, '[待审]点击搜索名称' AS remarks, 'Click để tìm kiếm tên' AS explain_, 0 AS is_admin, '点击搜索名称' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '点击搜索名称' AS code, '点击搜索名称' AS remarks, 'Click to search name' AS explain_, 0 AS is_admin, '点击搜索名称' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '点击查看' AS code, '点击查看' AS remarks, '点击查看' AS explain_, 0 AS is_admin, '点击查看' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '点击查看' AS code, '[待审]点击查看' AS remarks, 'Bấm vào để xem' AS explain_, 0 AS is_admin, '点击查看' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '点击查看' AS code, '点击查看' AS remarks, 'Click to view' AS explain_, 0 AS is_admin, '点击查看' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '点击添加到我的小程序' AS code, '点击添加到我的小程序' AS remarks, '点击添加到我的小程序' AS explain_, 0 AS is_admin, '点击添加到我的小程序' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '点击添加到我的小程序' AS code, '[待审]点击添加到我的小程序' AS remarks, 'Nhấn vào đây để thêm vào chương trình nhỏ của tôi' AS explain_, 0 AS is_admin, '点击添加到我的小程序' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '点击添加到我的小程序' AS code, '点击添加到我的小程序' AS remarks, 'Click to add to my mini program' AS explain_, 0 AS is_admin, '点击添加到我的小程序' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '点击阅读' AS code, '点击阅读' AS remarks, '点击阅读' AS explain_, 0 AS is_admin, '点击阅读' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '点击阅读' AS code, '[待审]点击阅读' AS remarks, 'Bấm vào để đọc' AS explain_, 0 AS is_admin, '点击阅读' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '点击阅读' AS code, '点击阅读' AS remarks, 'Click to read' AS explain_, 0 AS is_admin, '点击阅读' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '物流单号' AS code, '物流单号' AS remarks, '物流单号' AS explain_, 0 AS is_admin, '物流单号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '物流单号' AS code, '[待审]物流单号' AS remarks, 'Số đơn hàng hậu cần' AS explain_, 0 AS is_admin, '物流单号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '物流单号' AS code, '物流单号' AS remarks, 'Logistics order number' AS explain_, 0 AS is_admin, '物流单号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '物流查询' AS code, '物流查询' AS remarks, '物流查询' AS explain_, 0 AS is_admin, '物流查询' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '物流查询' AS code, '[待审]物流查询' AS remarks, 'Điều tra hậu cần' AS explain_, 0 AS is_admin, '物流查询' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '物流查询' AS code, '物流查询' AS remarks, 'Logistics inquiry' AS explain_, 0 AS is_admin, '物流查询' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '物流详情' AS code, '物流详情' AS remarks, '物流详情' AS explain_, 0 AS is_admin, '物流详情' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '物流详情' AS code, '[待审]物流详情' AS remarks, 'Chi tiết hậu cần' AS explain_, 0 AS is_admin, '物流详情' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '物流详情' AS code, '物流详情' AS remarks, 'Logistics details' AS explain_, 0 AS is_admin, '物流详情' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '用于完善会员资料' AS code, '用于完善会员资料' AS remarks, '用于完善会员资料' AS explain_, 0 AS is_admin, '用于完善会员资料' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '用于完善会员资料' AS code, '[待审]用于完善会员资料' AS remarks, 'Dùng để điền thông tin thành viên' AS explain_, 0 AS is_admin, '用于完善会员资料' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '用于完善会员资料' AS code, '用于完善会员资料' AS remarks, 'Used to complete member information' AS explain_, 0 AS is_admin, '用于完善会员资料' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '用户' AS code, '用户' AS remarks, '用户' AS explain_, 0 AS is_admin, '用户' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '用户' AS code, '[待审]用户' AS remarks, 'người dùng' AS explain_, 0 AS is_admin, '用户' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '用户' AS code, '用户' AS remarks, 'user' AS explain_, 0 AS is_admin, '用户' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '用户ID' AS code, '用户ID' AS remarks, '用户ID' AS explain_, 0 AS is_admin, '用户ID' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '用户ID' AS code, '[待审]用户ID' AS remarks, 'ID người dùng' AS explain_, 0 AS is_admin, '用户ID' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '用户ID' AS code, '用户ID' AS remarks, 'User ID' AS explain_, 0 AS is_admin, '用户ID' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '用户信息' AS code, '用户信息' AS remarks, '用户信息' AS explain_, 0 AS is_admin, '用户信息' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '用户信息' AS code, '[待审]用户信息' AS remarks, 'Thông tin người dùng' AS explain_, 0 AS is_admin, '用户信息' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '用户信息' AS code, '用户信息' AS remarks, 'User information' AS explain_, 0 AS is_admin, '用户信息' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '用户协议' AS code, '用户协议' AS remarks, '用户协议' AS explain_, 0 AS is_admin, '用户协议' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '用户协议' AS code, '[待审]用户协议' AS remarks, 'Thỏa thuận người dùng' AS explain_, 0 AS is_admin, '用户协议' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '用户协议' AS code, '用户协议' AS remarks, 'User Agreement' AS explain_, 0 AS is_admin, '用户协议' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '用户备注' AS code, '用户备注' AS remarks, '用户备注' AS explain_, 0 AS is_admin, '用户备注' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '用户备注' AS code, '[待审]用户备注' AS remarks, 'Nhận xét của người dùng' AS explain_, 0 AS is_admin, '用户备注' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '用户备注' AS code, '用户备注' AS remarks, 'User remarks' AS explain_, 0 AS is_admin, '用户备注' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '用户已付款，需要您尽快发货哦～' AS code, '用户已付款，需要您尽快发货哦～' AS remarks, '用户已付款，需要您尽快发货哦～' AS explain_, 0 AS is_admin, '用户已付款，需要您尽快发货哦～' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '用户已付款，需要您尽快发货哦～' AS code, '[待审]用户已付款，需要您尽快发货哦～' AS remarks, 'Người dùng đã thanh toán và cần bạn vận chuyển hàng càng sớm càng tốt ~' AS explain_, 0 AS is_admin, '用户已付款，需要您尽快发货哦～' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '用户已付款，需要您尽快发货哦～' AS code, '用户已付款，需要您尽快发货哦～' AS remarks, 'The user has paid and needs you to ship the goods as soon as possible~' AS explain_, 0 AS is_admin, '用户已付款，需要您尽快发货哦～' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '用户昵称' AS code, '用户昵称' AS remarks, '用户昵称' AS explain_, 0 AS is_admin, '用户昵称' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '用户昵称' AS code, '[待审]用户昵称' AS remarks, 'Biệt hiệu của người dùng' AS explain_, 0 AS is_admin, '用户昵称' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '用户昵称' AS code, '用户昵称' AS remarks, 'User nickname' AS explain_, 0 AS is_admin, '用户昵称' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '用户管理' AS code, '用户管理' AS remarks, '用户管理' AS explain_, 0 AS is_admin, '用户管理' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '用户管理' AS code, '[待审]用户管理' AS remarks, 'Quản lý người dùng' AS explain_, 0 AS is_admin, '用户管理' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '用户管理' AS code, '用户管理' AS remarks, 'User management' AS explain_, 0 AS is_admin, '用户管理' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '用户详情' AS code, '用户详情' AS remarks, '用户详情' AS explain_, 0 AS is_admin, '用户详情' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '用户详情' AS code, '[待审]用户详情' AS remarks, 'Chi tiết người dùng' AS explain_, 0 AS is_admin, '用户详情' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '用户详情' AS code, '用户详情' AS remarks, 'User details' AS explain_, 0 AS is_admin, '用户详情' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '由平台为您提供配送服务' AS code, '由平台为您提供配送服务' AS remarks, '由平台为您提供配送服务' AS explain_, 0 AS is_admin, '由平台为您提供配送服务' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '由平台为您提供配送服务' AS code, '[待审]由平台为您提供配送服务' AS remarks, 'Nền tảng cung cấp cho bạn dịch vụ giao hàng' AS explain_, 0 AS is_admin, '由平台为您提供配送服务' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '由平台为您提供配送服务' AS code, '由平台为您提供配送服务' AS remarks, 'The platform provides you with delivery services' AS explain_, 0 AS is_admin, '由平台为您提供配送服务' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '申请' AS code, '申请' AS remarks, '申请' AS explain_, 0 AS is_admin, '申请' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '申请' AS code, '[待审]申请' AS remarks, 'Áp dụng' AS explain_, 0 AS is_admin, '申请' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '申请' AS code, '申请' AS remarks, 'Apply' AS explain_, 0 AS is_admin, '申请' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '申请件数' AS code, '申请件数' AS remarks, '申请件数' AS explain_, 0 AS is_admin, '申请件数' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '申请件数' AS code, '[待审]申请件数' AS remarks, 'Số lượng ứng dụng' AS explain_, 0 AS is_admin, '申请件数' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '申请件数' AS code, '申请件数' AS remarks, 'Number of applications' AS explain_, 0 AS is_admin, '申请件数' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '申请图片' AS code, '申请图片' AS remarks, '申请图片' AS explain_, 0 AS is_admin, '申请图片' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '申请图片' AS code, '[待审]申请图片' AS remarks, 'Áp dụng cho hình ảnh' AS explain_, 0 AS is_admin, '申请图片' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '申请图片' AS code, '申请图片' AS remarks, 'Apply for pictures' AS explain_, 0 AS is_admin, '申请图片' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '申请理由' AS code, '申请理由' AS remarks, '申请理由' AS explain_, 0 AS is_admin, '申请理由' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '申请理由' AS code, '[待审]申请理由' AS remarks, 'Lý do ứng dụng' AS explain_, 0 AS is_admin, '申请理由' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '申请理由' AS code, '申请理由' AS remarks, 'Reasons for application' AS explain_, 0 AS is_admin, '申请理由' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '申请记录' AS code, '申请记录' AS remarks, '申请记录' AS explain_, 0 AS is_admin, '申请记录' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '申请记录' AS code, '[待审]申请记录' AS remarks, 'Hồ sơ ứng tuyển' AS explain_, 0 AS is_admin, '申请记录' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '申请记录' AS code, '申请记录' AS remarks, 'Application record' AS explain_, 0 AS is_admin, '申请记录' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '留言' AS code, '留言' AS remarks, '留言' AS explain_, 0 AS is_admin, '留言' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '留言' AS code, '[待审]留言' AS remarks, 'tin nhắn' AS explain_, 0 AS is_admin, '留言' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '留言' AS code, '留言' AS remarks, 'message' AS explain_, 0 AS is_admin, '留言' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '登录注册需绑定手机号' AS code, '登录注册需绑定手机号' AS remarks, '登录注册需绑定手机号' AS explain_, 0 AS is_admin, '登录注册需绑定手机号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '登录注册需绑定手机号' AS code, '[待审]登录注册需绑定手机号' AS remarks, 'Đăng nhập và đăng ký yêu cầu ràng buộc số điện thoại di động' AS explain_, 0 AS is_admin, '登录注册需绑定手机号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '登录注册需绑定手机号' AS code, '登录注册需绑定手机号' AS remarks, 'Login and registration require binding mobile phone number' AS explain_, 0 AS is_admin, '登录注册需绑定手机号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '的礼物' AS code, '的礼物' AS remarks, '的礼物' AS explain_, 0 AS is_admin, '的礼物' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '的礼物' AS code, '[待审]的礼物' AS remarks, 'quà' AS explain_, 0 AS is_admin, '的礼物' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '的礼物' AS code, '的礼物' AS remarks, 'gift' AS explain_, 0 AS is_admin, '的礼物' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '直播中' AS code, '直播中' AS remarks, '直播中' AS explain_, 0 AS is_admin, '直播中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '直播中' AS code, '[待审]直播中' AS remarks, 'Phát sóng trực tiếp' AS explain_, 0 AS is_admin, '直播中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '直播中' AS code, '直播中' AS remarks, 'Live broadcast' AS explain_, 0 AS is_admin, '直播中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '知道了' AS code, '知道了' AS remarks, '知道了' AS explain_, 0 AS is_admin, '知道了' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '知道了' AS code, '[待审]知道了' AS remarks, 'biết' AS explain_, 0 AS is_admin, '知道了' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '知道了' AS code, '知道了' AS remarks, 'knew' AS explain_, 0 AS is_admin, '知道了' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '确定删除吗？' AS code, '确定删除吗？' AS remarks, '确定删除吗？' AS explain_, 0 AS is_admin, '确定删除吗？' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '确定删除吗？' AS code, '[待审]确定删除吗？' AS remarks, 'Bạn có chắc chắn muốn xóa nó?' AS explain_, 0 AS is_admin, '确定删除吗？' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '确定删除吗？' AS code, '确定删除吗？' AS remarks, 'Are you sure you want to delete it?' AS explain_, 0 AS is_admin, '确定删除吗？' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '确认该订单用户已付款' AS code, '确认该订单用户已付款' AS remarks, '确认该订单用户已付款' AS explain_, 0 AS is_admin, '确认该订单用户已付款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '确认该订单用户已付款' AS code, '[待审]确认该订单用户已付款' AS remarks, 'Xác nhận đơn hàng đã được người dùng thanh toán' AS explain_, 0 AS is_admin, '确认该订单用户已付款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '确认该订单用户已付款' AS code, '确认该订单用户已付款' AS remarks, 'Confirm that the order has been paid by the user' AS explain_, 0 AS is_admin, '确认该订单用户已付款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '礼品附加费' AS code, '礼品附加费' AS remarks, '礼品附加费' AS explain_, 0 AS is_admin, '礼品附加费' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '礼品附加费' AS code, '[待审]礼品附加费' AS remarks, 'phụ phí quà tặng' AS explain_, 0 AS is_admin, '礼品附加费' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '礼品附加费' AS code, '礼品附加费' AS remarks, 'gift surcharge' AS explain_, 0 AS is_admin, '礼品附加费' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '礼品附加费用' AS code, '礼品附加费用' AS remarks, '礼品附加费用' AS explain_, 0 AS is_admin, '礼品附加费用' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '礼品附加费用' AS code, '[待审]礼品附加费用' AS remarks, 'Phụ phí quà tặng' AS explain_, 0 AS is_admin, '礼品附加费用' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '礼品附加费用' AS code, '礼品附加费用' AS remarks, 'Gift surcharge' AS explain_, 0 AS is_admin, '礼品附加费用' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '礼物已失效' AS code, '礼物已失效' AS remarks, '礼物已失效' AS explain_, 0 AS is_admin, '礼物已失效' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '礼物已失效' AS code, '[待审]礼物已失效' AS remarks, 'Quà tặng đã hết hạn' AS explain_, 0 AS is_admin, '礼物已失效' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '礼物已失效' AS code, '礼物已失效' AS remarks, 'The gift has expired' AS explain_, 0 AS is_admin, '礼物已失效' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '礼物已被领取' AS code, '礼物已被领取' AS remarks, '礼物已被领取' AS explain_, 0 AS is_admin, '礼物已被领取' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '礼物已被领取' AS code, '[待审]礼物已被领取' AS remarks, 'Món quà đã được nhận' AS explain_, 0 AS is_admin, '礼物已被领取' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '礼物已被领取' AS code, '礼物已被领取' AS remarks, 'The gift has been received' AS explain_, 0 AS is_admin, '礼物已被领取' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '礼物未赠送' AS code, '礼物未赠送' AS remarks, '礼物未赠送' AS explain_, 0 AS is_admin, '礼物未赠送' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '礼物未赠送' AS code, '[待审]礼物未赠送' AS remarks, 'Món quà không được tặng' AS explain_, 0 AS is_admin, '礼物未赠送' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '礼物未赠送' AS code, '礼物未赠送' AS remarks, 'Gift not given' AS explain_, 0 AS is_admin, '礼物未赠送' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '礼物详情' AS code, '礼物详情' AS remarks, '礼物详情' AS explain_, 0 AS is_admin, '礼物详情' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '礼物详情' AS code, '[待审]礼物详情' AS remarks, 'Chi tiết quà tặng' AS explain_, 0 AS is_admin, '礼物详情' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '礼物详情' AS code, '礼物详情' AS remarks, 'Gift details' AS explain_, 0 AS is_admin, '礼物详情' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '礼物领取成功' AS code, '礼物领取成功' AS remarks, '礼物领取成功' AS explain_, 0 AS is_admin, '礼物领取成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '礼物领取成功' AS code, '[待审]礼物领取成功' AS remarks, 'Đã nhận quà thành công' AS explain_, 0 AS is_admin, '礼物领取成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '礼物领取成功' AS code, '礼物领取成功' AS remarks, 'Gift received successfully' AS explain_, 0 AS is_admin, '礼物领取成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '秒杀价' AS code, '秒杀价' AS remarks, '秒杀价' AS explain_, 0 AS is_admin, '秒杀价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '秒杀价' AS code, '[待审]秒杀价' AS remarks, 'giá bán chớp nhoáng' AS explain_, 0 AS is_admin, '秒杀价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '秒杀价' AS code, '秒杀价' AS remarks, 'flash sale price' AS explain_, 0 AS is_admin, '秒杀价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '积分抵扣金额' AS code, '积分抵扣金额' AS remarks, '积分抵扣金额' AS explain_, 0 AS is_admin, '积分抵扣金额' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '积分抵扣金额' AS code, '[待审]积分抵扣金额' AS remarks, 'Số tiền trừ điểm' AS explain_, 0 AS is_admin, '积分抵扣金额' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '积分抵扣金额' AS code, '积分抵扣金额' AS remarks, 'Points deduction amount' AS explain_, 0 AS is_admin, '积分抵扣金额' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '立即收款' AS code, '立即收款' AS remarks, '立即收款' AS explain_, 0 AS is_admin, '立即收款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '立即收款' AS code, '[待审]立即收款' AS remarks, 'Được trả tiền ngay lập tức' AS explain_, 0 AS is_admin, '立即收款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '立即收款' AS code, '立即收款' AS remarks, 'Get paid immediately' AS explain_, 0 AS is_admin, '立即收款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '立即试用' AS code, '立即试用' AS remarks, '立即试用' AS explain_, 0 AS is_admin, '立即试用' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '立即试用' AS code, '[待审]立即试用' AS remarks, 'Hãy thử ngay bây giờ' AS explain_, 0 AS is_admin, '立即试用' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '立即试用' AS code, '立即试用' AS remarks, 'Try it now' AS explain_, 0 AS is_admin, '立即试用' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '等待支付中' AS code, '等待支付中' AS remarks, '等待支付中' AS explain_, 0 AS is_admin, '等待支付中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '等待支付中' AS code, '[待审]等待支付中' AS remarks, 'Đang chờ thanh toán' AS explain_, 0 AS is_admin, '等待支付中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '等待支付中' AS code, '等待支付中' AS remarks, 'Waiting for payment' AS explain_, 0 AS is_admin, '等待支付中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '等级' AS code, '等级' AS remarks, '等级' AS explain_, 0 AS is_admin, '等级' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '等级' AS code, '[待审]等级' AS remarks, 'cấp' AS explain_, 0 AS is_admin, '等级' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '等级' AS code, '等级' AS remarks, 'grade' AS explain_, 0 AS is_admin, '等级' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '筛选' AS code, '筛选' AS remarks, '筛选' AS explain_, 0 AS is_admin, '筛选' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '筛选' AS code, '[待审]筛选' AS remarks, 'lọc' AS explain_, 0 AS is_admin, '筛选' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '筛选' AS code, '筛选' AS remarks, 'filter' AS explain_, 0 AS is_admin, '筛选' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '签到功能已关闭' AS code, '签到功能已关闭' AS remarks, '签到功能已关闭' AS explain_, 0 AS is_admin, '签到功能已关闭' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '签到功能已关闭' AS code, '[待审]签到功能已关闭' AS remarks, 'Chức năng đăng nhập đã đóng' AS explain_, 0 AS is_admin, '签到功能已关闭' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '签到功能已关闭' AS code, '签到功能已关闭' AS remarks, 'Sign-in function is closed' AS explain_, 0 AS is_admin, '签到功能已关闭' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '签到提醒' AS code, '签到提醒' AS remarks, '签到提醒' AS explain_, 0 AS is_admin, '签到提醒' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '签到提醒' AS code, '[待审]签到提醒' AS remarks, 'Lời nhắc đăng ký' AS explain_, 0 AS is_admin, '签到提醒' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '签到提醒' AS code, '签到提醒' AS remarks, 'Check-in reminder' AS explain_, 0 AS is_admin, '签到提醒' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '签到立即获取' AS code, '签到立即获取' AS remarks, '签到立即获取' AS explain_, 0 AS is_admin, '签到立即获取' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '签到立即获取' AS code, '[待审]签到立即获取' AS remarks, 'Đăng nhập và nhận ngay' AS explain_, 0 AS is_admin, '签到立即获取' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '签到立即获取' AS code, '签到立即获取' AS remarks, 'Sign in and get it now' AS explain_, 0 AS is_admin, '签到立即获取' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '精选类目' AS code, '精选类目' AS remarks, '精选类目' AS explain_, 0 AS is_admin, '精选类目' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '精选类目' AS code, '[待审]精选类目' AS remarks, 'Danh mục nổi bật' AS explain_, 0 AS is_admin, '精选类目' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '精选类目' AS code, '精选类目' AS remarks, 'Featured categories' AS explain_, 0 AS is_admin, '精选类目' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '累计推广订单' AS code, '累计推广订单' AS remarks, '累计推广订单' AS explain_, 0 AS is_admin, '累计推广订单' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '累计推广订单' AS code, '[待审]累计推广订单' AS remarks, 'Lệnh khuyến mãi tích lũy' AS explain_, 0 AS is_admin, '累计推广订单' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '累计推广订单' AS code, '累计推广订单' AS remarks, 'Cumulative promotion orders' AS explain_, 0 AS is_admin, '累计推广订单' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '线上下单，到店自提' AS code, '线上下单，到店自提' AS remarks, '线上下单，到店自提' AS explain_, 0 AS is_admin, '线上下单，到店自提' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '线上下单，到店自提' AS code, '[待审]线上下单，到店自提' AS remarks, 'Đặt hàng trực tuyến và nhận hàng tại cửa hàng' AS explain_, 0 AS is_admin, '线上下单，到店自提' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '线上下单，到店自提' AS code, '线上下单，到店自提' AS remarks, 'Order online and pick up in store' AS explain_, 0 AS is_admin, '线上下单，到店自提' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '经验值明细' AS code, '经验值明细' AS remarks, '经验值明细' AS explain_, 0 AS is_admin, '经验值明细' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '经验值明细' AS code, '[待审]经验值明细' AS remarks, 'Chi tiết giá trị trải nghiệm' AS explain_, 0 AS is_admin, '经验值明细' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '经验值明细' AS code, '经验值明细' AS remarks, 'Experience value details' AS explain_, 0 AS is_admin, '经验值明细' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '继续核销' AS code, '继续核销' AS remarks, '继续核销' AS explain_, 0 AS is_admin, '继续核销' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '继续核销' AS code, '[待审]继续核销' AS remarks, 'Tiếp tục viết tắt' AS explain_, 0 AS is_admin, '继续核销' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '继续核销' AS code, '继续核销' AS remarks, 'Continue writing off' AS explain_, 0 AS is_admin, '继续核销' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '编辑发票' AS code, '编辑发票' AS remarks, '编辑发票' AS explain_, 0 AS is_admin, '编辑发票' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '编辑发票' AS code, '[待审]编辑发票' AS remarks, 'Chỉnh sửa hóa đơn' AS explain_, 0 AS is_admin, '编辑发票' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '编辑发票' AS code, '编辑发票' AS remarks, 'Edit invoice' AS explain_, 0 AS is_admin, '编辑发票' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '获取您的昵称、头像' AS code, '获取您的昵称、头像' AS remarks, '获取您的昵称、头像' AS explain_, 0 AS is_admin, '获取您的昵称、头像' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '获取您的昵称、头像' AS code, '[待审]获取您的昵称、头像' AS remarks, 'Nhận biệt hiệu và hình đại diện của bạn' AS explain_, 0 AS is_admin, '获取您的昵称、头像' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '获取您的昵称、头像' AS code, '获取您的昵称、头像' AS remarks, 'Get your nickname and avatar' AS explain_, 0 AS is_admin, '获取您的昵称、头像' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '获取手机号' AS code, '获取手机号' AS remarks, '获取手机号' AS explain_, 0 AS is_admin, '获取手机号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '获取手机号' AS code, '[待审]获取手机号' AS remarks, 'Nhận số điện thoại di động' AS explain_, 0 AS is_admin, '获取手机号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '获取手机号' AS code, '获取手机号' AS remarks, 'Get mobile phone number' AS explain_, 0 AS is_admin, '获取手机号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '获取手机号授权' AS code, '获取手机号授权' AS remarks, '获取手机号授权' AS explain_, 0 AS is_admin, '获取手机号授权' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '获取手机号授权' AS code, '[待审]获取手机号授权' AS remarks, 'Nhận ủy quyền số điện thoại di động' AS explain_, 0 AS is_admin, '获取手机号授权' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '获取手机号授权' AS code, '获取手机号授权' AS remarks, 'Obtain mobile phone number authorization' AS explain_, 0 AS is_admin, '获取手机号授权' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '装饰' AS code, '装饰' AS remarks, '装饰' AS explain_, 0 AS is_admin, '装饰' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '装饰' AS code, '[待审]装饰' AS remarks, 'trang trí' AS explain_, 0 AS is_admin, '装饰' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '装饰' AS code, '装饰' AS remarks, 'decorate' AS explain_, 0 AS is_admin, '装饰' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '规格' AS code, '规格' AS remarks, '规格' AS explain_, 0 AS is_admin, '规格' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '规格' AS code, '[待审]规格' AS remarks, 'Quy cách' AS explain_, 0 AS is_admin, '规格' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '规格' AS code, '规格' AS remarks, 'Spec' AS explain_, 0 AS is_admin, '规格' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '规格名称' AS code, '规格名称' AS remarks, '规格名称' AS explain_, 0 AS is_admin, '规格名称' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '规格名称' AS code, '[待审]规格名称' AS remarks, 'Tên đặc điểm kỹ thuật' AS explain_, 0 AS is_admin, '规格名称' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '规格名称' AS code, '规格名称' AS remarks, 'Specification name' AS explain_, 0 AS is_admin, '规格名称' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '规格设置' AS code, '规格设置' AS remarks, '规格设置' AS explain_, 0 AS is_admin, '规格设置' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '规格设置' AS code, '[待审]规格设置' AS remarks, 'Thông số kỹ thuật' AS explain_, 0 AS is_admin, '规格设置' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '规格设置' AS code, '规格设置' AS remarks, 'Specifications' AS explain_, 0 AS is_admin, '规格设置' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '解冻时间' AS code, '解冻时间' AS remarks, '解冻时间' AS explain_, 0 AS is_admin, '解冻时间' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '解冻时间' AS code, '[待审]解冻时间' AS remarks, 'thời gian rã đông' AS explain_, 0 AS is_admin, '解冻时间' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '解冻时间' AS code, '解冻时间' AS remarks, 'Thawing time' AS explain_, 0 AS is_admin, '解冻时间' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '订单列表' AS code, '订单列表' AS remarks, '订单列表' AS explain_, 0 AS is_admin, '订单列表' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '订单列表' AS code, '[待审]订单列表' AS remarks, 'danh sách đặt hàng' AS explain_, 0 AS is_admin, '订单列表' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '订单列表' AS code, '订单列表' AS remarks, 'order list' AS explain_, 0 AS is_admin, '订单列表' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '订单实付' AS code, '订单实付' AS remarks, '订单实付' AS explain_, 0 AS is_admin, '订单实付' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '订单实付' AS code, '[待审]订单实付' AS remarks, 'Đặt hàng thanh toán thực tế' AS explain_, 0 AS is_admin, '订单实付' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '订单实付' AS code, '订单实付' AS remarks, 'Order actual payment' AS explain_, 0 AS is_admin, '订单实付' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '订单详情' AS code, '订单详情' AS remarks, '订单详情' AS explain_, 0 AS is_admin, '订单详情' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '订单详情' AS code, '[待审]订单详情' AS remarks, 'Chi tiết đặt hàng' AS explain_, 0 AS is_admin, '订单详情' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '订单详情' AS code, '订单详情' AS remarks, 'Order details' AS explain_, 0 AS is_admin, '订单详情' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '该商品已下架' AS code, '该商品已下架' AS remarks, '该商品已下架' AS explain_, 0 AS is_admin, '该商品已下架' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '该商品已下架' AS code, '[待审]该商品已下架' AS remarks, 'Sản phẩm này đã được gỡ bỏ khỏi kệ' AS explain_, 0 AS is_admin, '该商品已下架' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '该商品已下架' AS code, '该商品已下架' AS remarks, 'This product has been removed from the shelves' AS explain_, 0 AS is_admin, '该商品已下架' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '该订单仍有其他待核销商品' AS code, '该订单仍有其他待核销商品' AS remarks, '该订单仍有其他待核销商品' AS explain_, 0 AS is_admin, '该订单仍有其他待核销商品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '该订单仍有其他待核销商品' AS code, '[待审]该订单仍有其他待核销商品' AS remarks, 'Đơn hàng vẫn còn những hạng mục khác cần được xóa' AS explain_, 0 AS is_admin, '该订单仍有其他待核销商品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '该订单仍有其他待核销商品' AS code, '该订单仍有其他待核销商品' AS remarks, 'The order still has other items to be written off' AS explain_, 0 AS is_admin, '该订单仍有其他待核销商品' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请上传商品图片' AS code, '请上传商品图片' AS remarks, '请上传商品图片' AS explain_, 0 AS is_admin, '请上传商品图片' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请上传商品图片' AS code, '[待审]请上传商品图片' AS remarks, 'Vui lòng tải lên hình ảnh sản phẩm' AS explain_, 0 AS is_admin, '请上传商品图片' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请上传商品图片' AS code, '请上传商品图片' AS remarks, 'Please upload product pictures' AS explain_, 0 AS is_admin, '请上传商品图片' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请上传头像' AS code, '请上传头像' AS remarks, '请上传头像' AS explain_, 0 AS is_admin, '请上传头像' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请上传头像' AS code, '[待审]请上传头像' AS remarks, 'Vui lòng tải lên hình đại diện' AS explain_, 0 AS is_admin, '请上传头像' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请上传头像' AS code, '请上传头像' AS remarks, 'Please upload avatar' AS explain_, 0 AS is_admin, '请上传头像' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请依次点击 [' AS code, '请依次点击 [' AS remarks, '请依次点击 [' AS explain_, 0 AS is_admin, '请依次点击 [' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请依次点击 [' AS code, '[待审]请依次点击 [' AS remarks, 'Vui lòng nhấp vào [' AS explain_, 0 AS is_admin, '请依次点击 [' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请依次点击 [' AS code, '请依次点击 [' AS remarks, 'Please click [' AS explain_, 0 AS is_admin, '请依次点击 [' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请依次点击【' AS code, '请依次点击【' AS remarks, '请依次点击【' AS explain_, 0 AS is_admin, '请依次点击【' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请依次点击【' AS code, '[待审]请依次点击【' AS remarks, 'Vui lòng nhấp vào [' AS explain_, 0 AS is_admin, '请依次点击【' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请依次点击【' AS code, '请依次点击【' AS remarks, 'Please click [' AS explain_, 0 AS is_admin, '请依次点击【' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请删除当前小程序，重启搜索打开...' AS code, '请删除当前小程序，重启搜索打开...' AS remarks, '请删除当前小程序，重启搜索打开...' AS explain_, 0 AS is_admin, '请删除当前小程序，重启搜索打开...' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请删除当前小程序，重启搜索打开...' AS code, '[待审]请删除当前小程序，重启搜索打开...' AS remarks, 'Vui lòng xóa applet hiện tại và khởi động lại tìm kiếm để mở...' AS explain_, 0 AS is_admin, '请删除当前小程序，重启搜索打开...' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请删除当前小程序，重启搜索打开...' AS code, '请删除当前小程序，重启搜索打开...' AS remarks, 'Please delete the current applet and restart the search to open...' AS explain_, 0 AS is_admin, '请删除当前小程序，重启搜索打开...' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请在平台后台添加送货人' AS code, '请在平台后台添加送货人' AS remarks, '请在平台后台添加送货人' AS explain_, 0 AS is_admin, '请在平台后台添加送货人' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请在平台后台添加送货人' AS code, '[待审]请在平台后台添加送货人' AS remarks, 'Vui lòng thêm người giao hàng vào nền tảng' AS explain_, 0 AS is_admin, '请在平台后台添加送货人' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请在平台后台添加送货人' AS code, '请在平台后台添加送货人' AS remarks, 'Please add the delivery person in the platform background' AS explain_, 0 AS is_admin, '请在平台后台添加送货人' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写你要增加或减少的余额' AS code, '请填写你要增加或减少的余额' AS remarks, '请填写你要增加或减少的余额' AS explain_, 0 AS is_admin, '请填写你要增加或减少的余额' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写你要增加或减少的余额' AS code, '[待审]请填写你要增加或减少的余额' AS remarks, 'Vui lòng điền số dư bạn muốn tăng hoặc giảm' AS explain_, 0 AS is_admin, '请填写你要增加或减少的余额' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写你要增加或减少的余额' AS code, '请填写你要增加或减少的余额' AS remarks, 'Please fill in the balance you want to increase or decrease' AS explain_, 0 AS is_admin, '请填写你要增加或减少的余额' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写你要增加或减少的积分' AS code, '请填写你要增加或减少的积分' AS remarks, '请填写你要增加或减少的积分' AS explain_, 0 AS is_admin, '请填写你要增加或减少的积分' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写你要增加或减少的积分' AS code, '[待审]请填写你要增加或减少的积分' AS remarks, 'Hãy điền vào những điểm bạn muốn tăng hoặc giảm' AS explain_, 0 AS is_admin, '请填写你要增加或减少的积分' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写你要增加或减少的积分' AS code, '请填写你要增加或减少的积分' AS remarks, 'Please fill in the points you want to increase or decrease' AS explain_, 0 AS is_admin, '请填写你要增加或减少的积分' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写单位' AS code, '请填写单位' AS remarks, '请填写单位' AS explain_, 0 AS is_admin, '请填写单位' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写单位' AS code, '[待审]请填写单位' AS remarks, 'Vui lòng điền vào đơn vị' AS explain_, 0 AS is_admin, '请填写单位' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写单位' AS code, '请填写单位' AS remarks, 'Please fill in the unit' AS explain_, 0 AS is_admin, '请填写单位' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写原价' AS code, '请填写原价' AS remarks, '请填写原价' AS explain_, 0 AS is_admin, '请填写原价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写原价' AS code, '[待审]请填写原价' AS remarks, 'Vui lòng điền giá gốc' AS explain_, 0 AS is_admin, '请填写原价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写原价' AS code, '请填写原价' AS remarks, 'Please fill in the original price' AS explain_, 0 AS is_admin, '请填写原价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写售价' AS code, '请填写售价' AS remarks, '请填写售价' AS explain_, 0 AS is_admin, '请填写售价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写售价' AS code, '[待审]请填写售价' AS remarks, 'Vui lòng điền giá bán' AS explain_, 0 AS is_admin, '请填写售价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写售价' AS code, '请填写售价' AS remarks, 'Please fill in the selling price' AS explain_, 0 AS is_admin, '请填写售价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写商品划线价' AS code, '请填写商品划线价' AS remarks, '请填写商品划线价' AS explain_, 0 AS is_admin, '请填写商品划线价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写商品划线价' AS code, '[待审]请填写商品划线价' AS remarks, 'Vui lòng điền giá gạch chân của sản phẩm' AS explain_, 0 AS is_admin, '请填写商品划线价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写商品划线价' AS code, '请填写商品划线价' AS remarks, 'Please fill in the underlined price of the product' AS explain_, 0 AS is_admin, '请填写商品划线价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写商品单位' AS code, '请填写商品单位' AS remarks, '请填写商品单位' AS explain_, 0 AS is_admin, '请填写商品单位' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写商品单位' AS code, '[待审]请填写商品单位' AS remarks, 'Vui lòng điền đơn vị sản phẩm' AS explain_, 0 AS is_admin, '请填写商品单位' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写商品单位' AS code, '请填写商品单位' AS remarks, 'Please fill in the product unit' AS explain_, 0 AS is_admin, '请填写商品单位' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写商品名称' AS code, '请填写商品名称' AS remarks, '请填写商品名称' AS explain_, 0 AS is_admin, '请填写商品名称' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写商品名称' AS code, '[待审]请填写商品名称' AS remarks, 'Vui lòng điền tên sản phẩm' AS explain_, 0 AS is_admin, '请填写商品名称' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写商品名称' AS code, '请填写商品名称' AS remarks, 'Please fill in the product name' AS explain_, 0 AS is_admin, '请填写商品名称' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写商品售价' AS code, '请填写商品售价' AS remarks, '请填写商品售价' AS explain_, 0 AS is_admin, '请填写商品售价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写商品售价' AS code, '[待审]请填写商品售价' AS remarks, 'Vui lòng điền giá bán sản phẩm' AS explain_, 0 AS is_admin, '请填写商品售价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写商品售价' AS code, '请填写商品售价' AS remarks, 'Please fill in the product selling price' AS explain_, 0 AS is_admin, '请填写商品售价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写商品库存' AS code, '请填写商品库存' AS remarks, '请填写商品库存' AS explain_, 0 AS is_admin, '请填写商品库存' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写商品库存' AS code, '[待审]请填写商品库存' AS remarks, 'Vui lòng điền vào kho sản phẩm' AS explain_, 0 AS is_admin, '请填写商品库存' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写商品库存' AS code, '请填写商品库存' AS remarks, 'Please fill in the product inventory' AS explain_, 0 AS is_admin, '请填写商品库存' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写商品成本价' AS code, '请填写商品成本价' AS remarks, '请填写商品成本价' AS explain_, 0 AS is_admin, '请填写商品成本价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写商品成本价' AS code, '[待审]请填写商品成本价' AS remarks, 'Vui lòng điền giá thành sản phẩm' AS explain_, 0 AS is_admin, '请填写商品成本价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写商品成本价' AS code, '请填写商品成本价' AS remarks, 'Please fill in the cost price of the product' AS explain_, 0 AS is_admin, '请填写商品成本价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写图片验证码' AS code, '请填写图片验证码' AS remarks, '请填写图片验证码' AS explain_, 0 AS is_admin, '请填写图片验证码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写图片验证码' AS code, '[待审]请填写图片验证码' AS remarks, 'Vui lòng điền mã xác minh hình ảnh' AS explain_, 0 AS is_admin, '请填写图片验证码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写图片验证码' AS code, '请填写图片验证码' AS remarks, 'Please fill in the image verification code' AS explain_, 0 AS is_admin, '请填写图片验证码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写姓名' AS code, '请填写姓名' AS remarks, '请填写姓名' AS explain_, 0 AS is_admin, '请填写姓名' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写姓名' AS code, '[待审]请填写姓名' AS remarks, 'Vui lòng điền tên của bạn' AS explain_, 0 AS is_admin, '请填写姓名' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写姓名' AS code, '请填写姓名' AS remarks, 'Please fill in your name' AS explain_, 0 AS is_admin, '请填写姓名' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写寄件人地址' AS code, '请填写寄件人地址' AS remarks, '请填写寄件人地址' AS explain_, 0 AS is_admin, '请填写寄件人地址' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写寄件人地址' AS code, '[待审]请填写寄件人地址' AS remarks, 'Vui lòng điền địa chỉ người gửi' AS explain_, 0 AS is_admin, '请填写寄件人地址' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写寄件人地址' AS code, '请填写寄件人地址' AS remarks, 'Please fill in the sender''s address' AS explain_, 0 AS is_admin, '请填写寄件人地址' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写寄件人姓名' AS code, '请填写寄件人姓名' AS remarks, '请填写寄件人姓名' AS explain_, 0 AS is_admin, '请填写寄件人姓名' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写寄件人姓名' AS code, '[待审]请填写寄件人姓名' AS remarks, 'Vui lòng điền tên người gửi' AS explain_, 0 AS is_admin, '请填写寄件人姓名' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写寄件人姓名' AS code, '请填写寄件人姓名' AS remarks, 'Please fill in the sender''s name' AS explain_, 0 AS is_admin, '请填写寄件人姓名' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写寄件人手机号码' AS code, '请填写寄件人手机号码' AS remarks, '请填写寄件人手机号码' AS explain_, 0 AS is_admin, '请填写寄件人手机号码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写寄件人手机号码' AS code, '[待审]请填写寄件人手机号码' AS remarks, 'Vui lòng điền số điện thoại di động của người gửi' AS explain_, 0 AS is_admin, '请填写寄件人手机号码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写寄件人手机号码' AS code, '请填写寄件人手机号码' AS remarks, 'Please fill in the sender’s mobile phone number' AS explain_, 0 AS is_admin, '请填写寄件人手机号码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写库存' AS code, '请填写库存' AS remarks, '请填写库存' AS explain_, 0 AS is_admin, '请填写库存' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写库存' AS code, '[待审]请填写库存' AS remarks, 'Vui lòng điền vào kho' AS explain_, 0 AS is_admin, '请填写库存' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写库存' AS code, '请填写库存' AS remarks, 'Please fill in the inventory' AS explain_, 0 AS is_admin, '请填写库存' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写快递单号' AS code, '请填写快递单号' AS remarks, '请填写快递单号' AS explain_, 0 AS is_admin, '请填写快递单号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写快递单号' AS code, '[待审]请填写快递单号' AS remarks, 'Vui lòng điền số chuyển phát nhanh' AS explain_, 0 AS is_admin, '请填写快递单号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写快递单号' AS code, '请填写快递单号' AS remarks, 'Please fill in the express delivery number' AS explain_, 0 AS is_admin, '请填写快递单号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写您的真实姓名' AS code, '请填写您的真实姓名' AS remarks, '请填写您的真实姓名' AS explain_, 0 AS is_admin, '请填写您的真实姓名' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写您的真实姓名' AS code, '[待审]请填写您的真实姓名' AS remarks, 'Vui lòng điền tên thật của bạn' AS explain_, 0 AS is_admin, '请填写您的真实姓名' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写您的真实姓名' AS code, '请填写您的真实姓名' AS remarks, 'Please fill in your real name' AS explain_, 0 AS is_admin, '请填写您的真实姓名' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写成本价' AS code, '请填写成本价' AS remarks, '请填写成本价' AS explain_, 0 AS is_admin, '请填写成本价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写成本价' AS code, '[待审]请填写成本价' AS remarks, 'Vui lòng điền giá thành' AS explain_, 0 AS is_admin, '请填写成本价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写成本价' AS code, '请填写成本价' AS remarks, 'Please fill in the cost price' AS explain_, 0 AS is_admin, '请填写成本价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写支付宝号' AS code, '请填写支付宝号' AS remarks, '请填写支付宝号' AS explain_, 0 AS is_admin, '请填写支付宝号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写支付宝号' AS code, '[待审]请填写支付宝号' AS remarks, 'Vui lòng điền số Alipay của bạn' AS explain_, 0 AS is_admin, '请填写支付宝号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写支付宝号' AS code, '请填写支付宝号' AS remarks, 'Please fill in your Alipay number' AS explain_, 0 AS is_admin, '请填写支付宝号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写支付宝绑定的真实姓名' AS code, '请填写支付宝绑定的真实姓名' AS remarks, '请填写支付宝绑定的真实姓名' AS explain_, 0 AS is_admin, '请填写支付宝绑定的真实姓名' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写支付宝绑定的真实姓名' AS code, '[待审]请填写支付宝绑定的真实姓名' AS remarks, 'Vui lòng điền tên thật ràng buộc với Alipay' AS explain_, 0 AS is_admin, '请填写支付宝绑定的真实姓名' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写支付宝绑定的真实姓名' AS code, '请填写支付宝绑定的真实姓名' AS remarks, 'Please fill in the real name bound to Alipay' AS explain_, 0 AS is_admin, '请填写支付宝绑定的真实姓名' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写有效时长' AS code, '请填写有效时长' AS remarks, '请填写有效时长' AS explain_, 0 AS is_admin, '请填写有效时长' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写有效时长' AS code, '[待审]请填写有效时长' AS remarks, 'Vui lòng điền thời hạn hiệu lực' AS explain_, 0 AS is_admin, '请填写有效时长' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写有效时长' AS code, '请填写有效时长' AS remarks, 'Please fill in the validity period' AS explain_, 0 AS is_admin, '请填写有效时长' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请完成安全验证' AS code, '请完成安全验证' AS remarks, '请完成安全验证' AS explain_, 0 AS is_admin, '请完成安全验证' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请完成安全验证' AS code, '[待审]请完成安全验证' AS remarks, 'Vui lòng hoàn tất xác minh bảo mật' AS explain_, 0 AS is_admin, '请完成安全验证' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请完成安全验证' AS code, '请完成安全验证' AS remarks, 'Please complete the security verification' AS explain_, 0 AS is_admin, '请完成安全验证' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请开启网络连接' AS code, '请开启网络连接' AS remarks, '请开启网络连接' AS explain_, 0 AS is_admin, '请开启网络连接' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请开启网络连接' AS code, '[待审]请开启网络连接' AS remarks, 'Vui lòng kích hoạt kết nối mạng' AS explain_, 0 AS is_admin, '请开启网络连接' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请开启网络连接' AS code, '请开启网络连接' AS remarks, 'Please enable network connection' AS explain_, 0 AS is_admin, '请开启网络连接' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请授权头像等信息，以便为您提供更好的服务' AS code, '请授权头像等信息，以便为您提供更好的服务' AS remarks, '请授权头像等信息，以便为您提供更好的服务' AS explain_, 0 AS is_admin, '请授权头像等信息，以便为您提供更好的服务' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请授权头像等信息，以便为您提供更好的服务' AS code, '[待审]请授权头像等信息，以便为您提供更好的服务' AS remarks, 'Vui lòng ủy quyền cho avatar và các thông tin khác của bạn để cung cấp cho bạn dịch vụ tốt hơn' AS explain_, 0 AS is_admin, '请授权头像等信息，以便为您提供更好的服务' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请授权头像等信息，以便为您提供更好的服务' AS code, '请授权头像等信息，以便为您提供更好的服务' AS remarks, 'Please authorize your avatar and other information to provide you with better services' AS explain_, 0 AS is_admin, '请授权头像等信息，以便为您提供更好的服务' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请点击登录' AS code, '请点击登录' AS remarks, '请点击登录' AS explain_, 0 AS is_admin, '请点击登录' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请点击登录' AS code, '[待审]请点击登录' AS remarks, 'Vui lòng bấm vào để đăng nhập' AS explain_, 0 AS is_admin, '请点击登录' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请点击登录' AS code, '请点击登录' AS remarks, 'Please click to log in' AS explain_, 0 AS is_admin, '请点击登录' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入优惠券名称' AS code, '请输入优惠券名称' AS remarks, '请输入优惠券名称' AS explain_, 0 AS is_admin, '请输入优惠券名称' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入优惠券名称' AS code, '[待审]请输入优惠券名称' AS remarks, 'Vui lòng nhập tên phiếu giảm giá' AS explain_, 0 AS is_admin, '请输入优惠券名称' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入优惠券名称' AS code, '请输入优惠券名称' AS remarks, 'Please enter the coupon name' AS explain_, 0 AS is_admin, '请输入优惠券名称' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入体积' AS code, '请输入体积' AS remarks, '请输入体积' AS explain_, 0 AS is_admin, '请输入体积' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入体积' AS code, '[待审]请输入体积' AS remarks, 'Vui lòng nhập âm lượng' AS explain_, 0 AS is_admin, '请输入体积' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入体积' AS code, '请输入体积' AS remarks, 'Please enter volume' AS explain_, 0 AS is_admin, '请输入体积' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入分销员姓名' AS code, '请输入分销员姓名' AS remarks, '请输入分销员姓名' AS explain_, 0 AS is_admin, '请输入分销员姓名' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入分销员姓名' AS code, '[待审]请输入分销员姓名' AS remarks, 'Vui lòng nhập tên nhà phân phối' AS explain_, 0 AS is_admin, '请输入分销员姓名' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入分销员姓名' AS code, '请输入分销员姓名' AS remarks, 'Please enter the distributor''s name' AS explain_, 0 AS is_admin, '请输入分销员姓名' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入划线价' AS code, '请输入划线价' AS remarks, '请输入划线价' AS explain_, 0 AS is_admin, '请输入划线价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入划线价' AS code, '[待审]请输入划线价' AS remarks, 'Vui lòng nhập giá bị gạch chéo' AS explain_, 0 AS is_admin, '请输入划线价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入划线价' AS code, '请输入划线价' AS remarks, 'Please enter the crossed-out price' AS explain_, 0 AS is_admin, '请输入划线价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入售价' AS code, '请输入售价' AS remarks, '请输入售价' AS explain_, 0 AS is_admin, '请输入售价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入售价' AS code, '[待审]请输入售价' AS remarks, 'Vui lòng nhập giá bán' AS explain_, 0 AS is_admin, '请输入售价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入售价' AS code, '请输入售价' AS remarks, 'Please enter the selling price' AS explain_, 0 AS is_admin, '请输入售价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入商品名称' AS code, '请输入商品名称' AS remarks, '请输入商品名称' AS explain_, 0 AS is_admin, '请输入商品名称' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入商品名称' AS code, '[待审]请输入商品名称' AS remarks, 'Vui lòng nhập tên sản phẩm' AS explain_, 0 AS is_admin, '请输入商品名称' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入商品名称' AS code, '请输入商品名称' AS remarks, 'Please enter product name' AS explain_, 0 AS is_admin, '请输入商品名称' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入商品名称/ID' AS code, '请输入商品名称/ID' AS remarks, '请输入商品名称/ID' AS explain_, 0 AS is_admin, '请输入商品名称/ID' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入商品名称/ID' AS code, '[待审]请输入商品名称/ID' AS remarks, 'Vui lòng nhập tên/ID sản phẩm' AS explain_, 0 AS is_admin, '请输入商品名称/ID' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入商品名称/ID' AS code, '请输入商品名称/ID' AS remarks, 'Please enter product name/ID' AS explain_, 0 AS is_admin, '请输入商品名称/ID' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入商品编码' AS code, '请输入商品编码' AS remarks, '请输入商品编码' AS explain_, 0 AS is_admin, '请输入商品编码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入商品编码' AS code, '[待审]请输入商品编码' AS remarks, 'Vui lòng nhập mã sản phẩm' AS explain_, 0 AS is_admin, '请输入商品编码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入商品编码' AS code, '请输入商品编码' AS remarks, 'Please enter product code' AS explain_, 0 AS is_admin, '请输入商品编码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入固定邮费' AS code, '请输入固定邮费' AS remarks, '请输入固定邮费' AS explain_, 0 AS is_admin, '请输入固定邮费' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入固定邮费' AS code, '[待审]请输入固定邮费' AS remarks, 'Vui lòng nhập bưu phí cố định' AS explain_, 0 AS is_admin, '请输入固定邮费' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入固定邮费' AS code, '请输入固定邮费' AS remarks, 'Please enter fixed postage' AS explain_, 0 AS is_admin, '请输入固定邮费' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入库存' AS code, '请输入库存' AS remarks, '请输入库存' AS explain_, 0 AS is_admin, '请输入库存' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入库存' AS code, '[待审]请输入库存' AS remarks, 'Vui lòng nhập hàng tồn kho' AS explain_, 0 AS is_admin, '请输入库存' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入库存' AS code, '请输入库存' AS remarks, 'Please enter inventory' AS explain_, 0 AS is_admin, '请输入库存' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入成本价' AS code, '请输入成本价' AS remarks, '请输入成本价' AS explain_, 0 AS is_admin, '请输入成本价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入成本价' AS code, '[待审]请输入成本价' AS remarks, 'Vui lòng nhập giá thành' AS explain_, 0 AS is_admin, '请输入成本价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入成本价' AS code, '请输入成本价' AS remarks, 'Please enter cost price' AS explain_, 0 AS is_admin, '请输入成本价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入提现金额' AS code, '请输入提现金额' AS remarks, '请输入提现金额' AS explain_, 0 AS is_admin, '请输入提现金额' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入提现金额' AS code, '[待审]请输入提现金额' AS remarks, 'Vui lòng nhập số tiền rút' AS explain_, 0 AS is_admin, '请输入提现金额' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入提现金额' AS code, '请输入提现金额' AS remarks, 'Please enter the withdrawal amount' AS explain_, 0 AS is_admin, '请输入提现金额' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入时长' AS code, '请输入时长' AS remarks, '请输入时长' AS explain_, 0 AS is_admin, '请输入时长' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入时长' AS code, '[待审]请输入时长' AS remarks, 'Vui lòng nhập thời lượng' AS explain_, 0 AS is_admin, '请输入时长' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入时长' AS code, '请输入时长' AS remarks, 'Please enter duration' AS explain_, 0 AS is_admin, '请输入时长' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入昵称' AS code, '请输入昵称' AS remarks, '请输入昵称' AS explain_, 0 AS is_admin, '请输入昵称' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入昵称' AS code, '[待审]请输入昵称' AS remarks, 'Vui lòng nhập biệt hiệu' AS explain_, 0 AS is_admin, '请输入昵称' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入昵称' AS code, '请输入昵称' AS remarks, 'Please enter a nickname' AS explain_, 0 AS is_admin, '请输入昵称' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入条形码' AS code, '请输入条形码' AS remarks, '请输入条形码' AS explain_, 0 AS is_admin, '请输入条形码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入条形码' AS code, '[待审]请输入条形码' AS remarks, 'Vui lòng nhập mã vạch' AS explain_, 0 AS is_admin, '请输入条形码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入条形码' AS code, '请输入条形码' AS remarks, 'Please enter barcode' AS explain_, 0 AS is_admin, '请输入条形码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入物流单号' AS code, '请输入物流单号' AS remarks, '请输入物流单号' AS explain_, 0 AS is_admin, '请输入物流单号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入物流单号' AS code, '[待审]请输入物流单号' AS remarks, 'Vui lòng nhập số đơn hàng hậu cần' AS explain_, 0 AS is_admin, '请输入物流单号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入物流单号' AS code, '请输入物流单号' AS remarks, 'Please enter the logistics order number' AS explain_, 0 AS is_admin, '请输入物流单号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入用户手机号/用户昵称/订单号/商品名称' AS code, '请输入用户手机号/用户昵称/订单号/商品名称' AS remarks, '请输入用户手机号/用户昵称/订单号/商品名称' AS explain_, 0 AS is_admin, '请输入用户手机号/用户昵称/订单号/商品名称' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入用户手机号/用户昵称/订单号/商品名称' AS code, '[待审]请输入用户手机号/用户昵称/订单号/商品名称' AS remarks, 'Vui lòng nhập số điện thoại di động của người dùng/biệt danh người dùng/số đơn hàng/tên sản phẩm' AS explain_, 0 AS is_admin, '请输入用户手机号/用户昵称/订单号/商品名称' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入用户手机号/用户昵称/订单号/商品名称' AS code, '请输入用户手机号/用户昵称/订单号/商品名称' AS remarks, 'Please enter user mobile phone number/user nickname/order number/product name' AS explain_, 0 AS is_admin, '请输入用户手机号/用户昵称/订单号/商品名称' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入用户昵称/ID' AS code, '请输入用户昵称/ID' AS remarks, '请输入用户昵称/ID' AS explain_, 0 AS is_admin, '请输入用户昵称/ID' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入用户昵称/ID' AS code, '[待审]请输入用户昵称/ID' AS remarks, 'Vui lòng nhập biệt hiệu/ID người dùng' AS explain_, 0 AS is_admin, '请输入用户昵称/ID' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入用户昵称/ID' AS code, '请输入用户昵称/ID' AS remarks, 'Please enter user nickname/ID' AS explain_, 0 AS is_admin, '请输入用户昵称/ID' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入申请理由' AS code, '请输入申请理由' AS remarks, '请输入申请理由' AS explain_, 0 AS is_admin, '请输入申请理由' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入申请理由' AS code, '[待审]请输入申请理由' AS remarks, 'Vui lòng nhập lý do ứng tuyển' AS explain_, 0 AS is_admin, '请输入申请理由' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入申请理由' AS code, '请输入申请理由' AS remarks, 'Please enter the reason for application' AS explain_, 0 AS is_admin, '请输入申请理由' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入要查询的订单' AS code, '请输入要查询的订单' AS remarks, '请输入要查询的订单' AS explain_, 0 AS is_admin, '请输入要查询的订单' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入要查询的订单' AS code, '[待审]请输入要查询的订单' AS remarks, 'Vui lòng nhập thứ tự bạn muốn truy vấn' AS explain_, 0 AS is_admin, '请输入要查询的订单' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入要查询的订单' AS code, '请输入要查询的订单' AS remarks, 'Please enter the order you want to query' AS explain_, 0 AS is_admin, '请输入要查询的订单' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入规格编码' AS code, '请输入规格编码' AS remarks, '请输入规格编码' AS explain_, 0 AS is_admin, '请输入规格编码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入规格编码' AS code, '[待审]请输入规格编码' AS remarks, 'Vui lòng nhập mã thông số kỹ thuật' AS explain_, 0 AS is_admin, '请输入规格编码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入规格编码' AS code, '请输入规格编码' AS remarks, 'Please enter the specification code' AS explain_, 0 AS is_admin, '请输入规格编码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入订单号/售后单号/用户ID/手机号' AS code, '请输入订单号/售后单号/用户ID/手机号' AS remarks, '请输入订单号/售后单号/用户ID/手机号' AS explain_, 0 AS is_admin, '请输入订单号/售后单号/用户ID/手机号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入订单号/售后单号/用户ID/手机号' AS code, '[待审]请输入订单号/售后单号/用户ID/手机号' AS remarks, 'Vui lòng nhập mã đơn hàng/mã đơn hàng/ID người dùng/số điện thoại di động' AS explain_, 0 AS is_admin, '请输入订单号/售后单号/用户ID/手机号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入订单号/售后单号/用户ID/手机号' AS code, '请输入订单号/售后单号/用户ID/手机号' AS remarks, 'Please enter the order number/sales order number/user ID/mobile phone number' AS explain_, 0 AS is_admin, '请输入订单号/售后单号/用户ID/手机号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入重量' AS code, '请输入重量' AS remarks, '请输入重量' AS explain_, 0 AS is_admin, '请输入重量' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入重量' AS code, '[待审]请输入重量' AS remarks, 'Vui lòng nhập trọng lượng' AS explain_, 0 AS is_admin, '请输入重量' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入重量' AS code, '请输入重量' AS remarks, 'Please enter weight' AS explain_, 0 AS is_admin, '请输入重量' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择分类' AS code, '请选择分类' AS remarks, '请选择分类' AS explain_, 0 AS is_admin, '请选择分类' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择分类' AS code, '[待审]请选择分类' AS remarks, 'Vui lòng chọn một danh mục' AS explain_, 0 AS is_admin, '请选择分类' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择分类' AS code, '请选择分类' AS remarks, 'Please select a category' AS explain_, 0 AS is_admin, '请选择分类' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择删除商品' AS code, '请选择删除商品' AS remarks, '请选择删除商品' AS explain_, 0 AS is_admin, '请选择删除商品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择删除商品' AS code, '[待审]请选择删除商品' AS remarks, 'Vui lòng chọn xóa sản phẩm' AS explain_, 0 AS is_admin, '请选择删除商品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择删除商品' AS code, '请选择删除商品' AS remarks, 'Please choose to delete the product' AS explain_, 0 AS is_admin, '请选择删除商品' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择发货商品' AS code, '请选择发货商品' AS remarks, '请选择发货商品' AS explain_, 0 AS is_admin, '请选择发货商品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择发货商品' AS code, '[待审]请选择发货商品' AS remarks, 'Vui lòng chọn sản phẩm cần vận chuyển' AS explain_, 0 AS is_admin, '请选择发货商品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择发货商品' AS code, '请选择发货商品' AS remarks, 'Please select the product to be shipped' AS explain_, 0 AS is_admin, '请选择发货商品' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择商品分类' AS code, '请选择商品分类' AS remarks, '请选择商品分类' AS explain_, 0 AS is_admin, '请选择商品分类' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择商品分类' AS code, '[待审]请选择商品分类' AS remarks, 'Vui lòng chọn danh mục sản phẩm' AS explain_, 0 AS is_admin, '请选择商品分类' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择商品分类' AS code, '请选择商品分类' AS remarks, 'Please select a product category' AS explain_, 0 AS is_admin, '请选择商品分类' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择商品规格' AS code, '请选择商品规格' AS remarks, '请选择商品规格' AS explain_, 0 AS is_admin, '请选择商品规格' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择商品规格' AS code, '[待审]请选择商品规格' AS remarks, 'Vui lòng chọn thông số kỹ thuật sản phẩm' AS explain_, 0 AS is_admin, '请选择商品规格' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择商品规格' AS code, '请选择商品规格' AS remarks, 'Please select product specifications' AS explain_, 0 AS is_admin, '请选择商品规格' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择当前核销订单' AS code, '请选择当前核销订单' AS remarks, '请选择当前核销订单' AS explain_, 0 AS is_admin, '请选择当前核销订单' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择当前核销订单' AS code, '[待审]请选择当前核销订单' AS remarks, 'Vui lòng chọn thứ tự xóa nợ hiện tại' AS explain_, 0 AS is_admin, '请选择当前核销订单' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择当前核销订单' AS code, '请选择当前核销订单' AS remarks, 'Please select the current write-off order' AS explain_, 0 AS is_admin, '请选择当前核销订单' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择收藏商品' AS code, '请选择收藏商品' AS remarks, '请选择收藏商品' AS explain_, 0 AS is_admin, '请选择收藏商品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择收藏商品' AS code, '[待审]请选择收藏商品' AS remarks, 'Hãy chọn sản phẩm yêu thích' AS explain_, 0 AS is_admin, '请选择收藏商品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择收藏商品' AS code, '请选择收藏商品' AS remarks, 'Please select favorite products' AS explain_, 0 AS is_admin, '请选择收藏商品' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择用户' AS code, '请选择用户' AS remarks, '请选择用户' AS explain_, 0 AS is_admin, '请选择用户' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择用户' AS code, '[待审]请选择用户' AS remarks, 'Vui lòng chọn người dùng' AS explain_, 0 AS is_admin, '请选择用户' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择用户' AS code, '请选择用户' AS remarks, 'Please select user' AS explain_, 0 AS is_admin, '请选择用户' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择要核销的订单' AS code, '请选择要核销的订单' AS remarks, '请选择要核销的订单' AS explain_, 0 AS is_admin, '请选择要核销的订单' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择要核销的订单' AS code, '[待审]请选择要核销的订单' AS remarks, 'Hãy chọn thứ tự cần xóa' AS explain_, 0 AS is_admin, '请选择要核销的订单' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择要核销的订单' AS code, '请选择要核销的订单' AS remarks, 'Please select the order to be written off' AS explain_, 0 AS is_admin, '请选择要核销的订单' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择运费模版' AS code, '请选择运费模版' AS remarks, '请选择运费模版' AS explain_, 0 AS is_admin, '请选择运费模版' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择运费模版' AS code, '[待审]请选择运费模版' AS remarks, 'Vui lòng chọn mẫu vận chuyển hàng hóa' AS explain_, 0 AS is_admin, '请选择运费模版' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择运费模版' AS code, '请选择运费模版' AS remarks, 'Please select a freight template' AS explain_, 0 AS is_admin, '请选择运费模版' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择运费设置' AS code, '请选择运费设置' AS remarks, '请选择运费设置' AS explain_, 0 AS is_admin, '请选择运费设置' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择运费设置' AS code, '[待审]请选择运费设置' AS remarks, 'Vui lòng chọn cài đặt vận chuyển' AS explain_, 0 AS is_admin, '请选择运费设置' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择运费设置' AS code, '请选择运费设置' AS remarks, 'Please select shipping settings' AS explain_, 0 AS is_admin, '请选择运费设置' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择配送方式' AS code, '请选择配送方式' AS remarks, '请选择配送方式' AS explain_, 0 AS is_admin, '请选择配送方式' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择配送方式' AS code, '[待审]请选择配送方式' AS remarks, 'Vui lòng chọn phương thức vận chuyển' AS explain_, 0 AS is_admin, '请选择配送方式' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择配送方式' AS code, '请选择配送方式' AS remarks, 'Please select a shipping method' AS explain_, 0 AS is_admin, '请选择配送方式' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请阅读并同意分销员协议' AS code, '请阅读并同意分销员协议' AS remarks, '请阅读并同意分销员协议' AS explain_, 0 AS is_admin, '请阅读并同意分销员协议' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请阅读并同意分销员协议' AS code, '[待审]请阅读并同意分销员协议' AS remarks, 'Vui lòng đọc và đồng ý với Thỏa thuận Nhà phân phối' AS explain_, 0 AS is_admin, '请阅读并同意分销员协议' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请阅读并同意分销员协议' AS code, '请阅读并同意分销员协议' AS remarks, 'Please read and agree to the Distributor Agreement' AS explain_, 0 AS is_admin, '请阅读并同意分销员协议' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '调整时长' AS code, '调整时长' AS remarks, '调整时长' AS explain_, 0 AS is_admin, '调整时长' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '调整时长' AS code, '[待审]调整时长' AS remarks, 'Điều chỉnh thời lượng' AS explain_, 0 AS is_admin, '调整时长' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '调整时长' AS code, '调整时长' AS remarks, 'Adjust duration' AS explain_, 0 AS is_admin, '调整时长' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '购买' AS code, '购买' AS remarks, '购买' AS explain_, 0 AS is_admin, '购买' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '购买' AS code, '[待审]购买' AS remarks, 'Mua' AS explain_, 0 AS is_admin, '购买' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '购买' AS code, '购买' AS remarks, 'Buy' AS explain_, 0 AS is_admin, '购买' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '资产信息' AS code, '资产信息' AS remarks, '资产信息' AS explain_, 0 AS is_admin, '资产信息' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '资产信息' AS code, '[待审]资产信息' AS remarks, 'Thông tin tài sản' AS explain_, 0 AS is_admin, '资产信息' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '资产信息' AS code, '资产信息' AS remarks, 'Asset information' AS explain_, 0 AS is_admin, '资产信息' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '赠品' AS code, '赠品' AS remarks, '赠品' AS explain_, 0 AS is_admin, '赠品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '赠品' AS code, '[待审]赠品' AS remarks, 'quà tặng' AS explain_, 0 AS is_admin, '赠品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '赠品' AS code, '赠品' AS remarks, 'giveaway' AS explain_, 0 AS is_admin, '赠品' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '赠送会员' AS code, '赠送会员' AS remarks, '赠送会员' AS explain_, 0 AS is_admin, '赠送会员' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '赠送会员' AS code, '[待审]赠送会员' AS remarks, 'Quà tặng thành viên' AS explain_, 0 AS is_admin, '赠送会员' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '赠送会员' AS code, '赠送会员' AS remarks, 'Gift membership' AS explain_, 0 AS is_admin, '赠送会员' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '赠送积分' AS code, '赠送积分' AS remarks, '赠送积分' AS explain_, 0 AS is_admin, '赠送积分' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '赠送积分' AS code, '[待审]赠送积分' AS remarks, 'Tặng điểm' AS explain_, 0 AS is_admin, '赠送积分' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '赠送积分' AS code, '赠送积分' AS remarks, 'Give away points' AS explain_, 0 AS is_admin, '赠送积分' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '赠送给好友一份礼物' AS code, '赠送给好友一份礼物' AS remarks, '赠送给好友一份礼物' AS explain_, 0 AS is_admin, '赠送给好友一份礼物' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '赠送给好友一份礼物' AS code, '[待审]赠送给好友一份礼物' AS remarks, 'Tặng một người bạn một món quà' AS explain_, 0 AS is_admin, '赠送给好友一份礼物' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '赠送给好友一份礼物' AS code, '赠送给好友一份礼物' AS remarks, 'Give a friend a gift' AS explain_, 0 AS is_admin, '赠送给好友一份礼物' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '起购' AS code, '起购' AS remarks, '起购' AS explain_, 0 AS is_admin, '起购' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '起购' AS code, '[待审]起购' AS remarks, 'mua tối thiểu' AS explain_, 0 AS is_admin, '起购' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '起购' AS code, '起购' AS remarks, 'Minimum purchase' AS explain_, 0 AS is_admin, '起购' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '超值优惠 限时专享' AS code, '超值优惠 限时专享' AS remarks, '超值优惠 限时专享' AS explain_, 0 AS is_admin, '超值优惠 限时专享' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '超值优惠 限时专享' AS code, '[待审]超值优惠 限时专享' AS remarks, 'Ưu đãi lớn, thời gian có hạn' AS explain_, 0 AS is_admin, '超值优惠 限时专享' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '超值优惠 限时专享' AS code, '超值优惠 限时专享' AS remarks, 'Great deals, limited time only' AS explain_, 0 AS is_admin, '超值优惠 限时专享' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '距离结束' AS code, '距离结束' AS remarks, '距离结束' AS explain_, 0 AS is_admin, '距离结束' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '距离结束' AS code, '[待审]距离结束' AS remarks, 'khoảng cách kết thúc' AS explain_, 0 AS is_admin, '距离结束' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '距离结束' AS code, '距离结束' AS remarks, 'distance ends' AS explain_, 0 AS is_admin, '距离结束' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '身份证号' AS code, '身份证号' AS remarks, '身份证号' AS explain_, 0 AS is_admin, '身份证号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '身份证号' AS code, '[待审]身份证号' AS remarks, 'số CMND' AS explain_, 0 AS is_admin, '身份证号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '身份证号' AS code, '身份证号' AS remarks, 'ID number' AS explain_, 0 AS is_admin, '身份证号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '转账已失效,请从重新发起' AS code, '转账已失效,请从重新发起' AS remarks, '转账已失效,请从重新发起' AS explain_, 0 AS is_admin, '转账已失效,请从重新发起' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '转账已失效,请从重新发起' AS code, '[待审]转账已失效,请从重新发起' AS remarks, 'Quá trình chuyển đã hết hạn, vui lòng thử lại' AS explain_, 0 AS is_admin, '转账已失效,请从重新发起' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '转账已失效,请从重新发起' AS code, '转账已失效,请从重新发起' AS remarks, 'The transfer has expired, please try again' AS explain_, 0 AS is_admin, '转账已失效,请从重新发起' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '运费模板' AS code, '运费模板' AS remarks, '运费模板' AS explain_, 0 AS is_admin, '运费模板' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '运费模板' AS code, '[待审]运费模板' AS remarks, 'Mẫu vận chuyển hàng hóa' AS explain_, 0 AS is_admin, '运费模板' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '运费模板' AS code, '运费模板' AS remarks, 'Freight Template' AS explain_, 0 AS is_admin, '运费模板' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '返回列表' AS code, '返回列表' AS remarks, '返回列表' AS explain_, 0 AS is_admin, '返回列表' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '返回列表' AS code, '[待审]返回列表' AS remarks, 'Quay lại danh sách' AS explain_, 0 AS is_admin, '返回列表' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '返回列表' AS code, '返回列表' AS remarks, 'Return to list' AS explain_, 0 AS is_admin, '返回列表' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '返回商城首页' AS code, '返回商城首页' AS remarks, '返回商城首页' AS explain_, 0 AS is_admin, '返回商城首页' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '返回商城首页' AS code, '[待审]返回商城首页' AS remarks, 'Quay lại trang chủ trung tâm mua sắm' AS explain_, 0 AS is_admin, '返回商城首页' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '返回商城首页' AS code, '返回商城首页' AS remarks, 'Return to the mall homepage' AS explain_, 0 AS is_admin, '返回商城首页' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '返回工作台' AS code, '返回工作台' AS remarks, '返回工作台' AS explain_, 0 AS is_admin, '返回工作台' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '返回工作台' AS code, '[待审]返回工作台' AS remarks, 'Quay trở lại bàn làm việc' AS explain_, 0 AS is_admin, '返回工作台' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '返回工作台' AS code, '返回工作台' AS remarks, 'Return to workbench' AS explain_, 0 AS is_admin, '返回工作台' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '这是一个模态弹窗!' AS code, '这是一个模态弹窗!' AS remarks, '这是一个模态弹窗!' AS explain_, 0 AS is_admin, '这是一个模态弹窗!' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '这是一个模态弹窗!' AS code, '[待审]这是一个模态弹窗!' AS remarks, 'Đây là một cửa sổ bật lên phương thức!' AS explain_, 0 AS is_admin, '这是一个模态弹窗!' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '这是一个模态弹窗!' AS code, '这是一个模态弹窗!' AS remarks, 'This is a modal popup!' AS explain_, 0 AS is_admin, '这是一个模态弹窗!' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '这是送您的一份礼物~' AS code, '这是送您的一份礼物~' AS remarks, '这是送您的一份礼物~' AS explain_, 0 AS is_admin, '这是送您的一份礼物~' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '这是送您的一份礼物~' AS code, '[待审]这是送您的一份礼物~' AS remarks, 'Đây là một món quà dành cho bạn ~' AS explain_, 0 AS is_admin, '这是送您的一份礼物~' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '这是送您的一份礼物~' AS code, '这是送您的一份礼物~' AS remarks, 'This is a gift for you~' AS explain_, 0 AS is_admin, '这是送您的一份礼物~' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '连续签到' AS code, '连续签到' AS remarks, '连续签到' AS explain_, 0 AS is_admin, '连续签到' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '连续签到' AS code, '[待审]连续签到' AS remarks, 'Đăng nhập liên tục' AS explain_, 0 AS is_admin, '连续签到' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '连续签到' AS code, '连续签到' AS remarks, 'Continuous check-ins' AS explain_, 0 AS is_admin, '连续签到' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '退出预览' AS code, '退出预览' AS remarks, '退出预览' AS explain_, 0 AS is_admin, '退出预览' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '退出预览' AS code, '[待审]退出预览' AS remarks, 'Thoát xem trước' AS explain_, 0 AS is_admin, '退出预览' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '退出预览' AS code, '退出预览' AS remarks, 'Exit preview' AS explain_, 0 AS is_admin, '退出预览' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '退款凭证' AS code, '退款凭证' AS remarks, '退款凭证' AS explain_, 0 AS is_admin, '退款凭证' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '退款凭证' AS code, '[待审]退款凭证' AS remarks, 'Phiếu hoàn tiền' AS explain_, 0 AS is_admin, '退款凭证' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '退款凭证' AS code, '退款凭证' AS remarks, 'Refund voucher' AS explain_, 0 AS is_admin, '退款凭证' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '退款审核' AS code, '退款审核' AS remarks, '退款审核' AS explain_, 0 AS is_admin, '退款审核' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '退款审核' AS code, '[待审]退款审核' AS remarks, 'Xem xét hoàn tiền' AS explain_, 0 AS is_admin, '退款审核' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '退款审核' AS code, '退款审核' AS remarks, 'Refund review' AS explain_, 0 AS is_admin, '退款审核' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '退款留言' AS code, '退款留言' AS remarks, '退款留言' AS explain_, 0 AS is_admin, '退款留言' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '退款留言' AS code, '[待审]退款留言' AS remarks, 'Tin nhắn hoàn tiền' AS explain_, 0 AS is_admin, '退款留言' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '退款留言' AS code, '退款留言' AS remarks, 'Refund message' AS explain_, 0 AS is_admin, '退款留言' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '退货凭证' AS code, '退货凭证' AS remarks, '退货凭证' AS explain_, 0 AS is_admin, '退货凭证' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '退货凭证' AS code, '[待审]退货凭证' AS remarks, 'Phiếu trả lại' AS explain_, 0 AS is_admin, '退货凭证' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '退货凭证' AS code, '退货凭证' AS remarks, 'Return voucher' AS explain_, 0 AS is_admin, '退货凭证' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '退货方式' AS code, '退货方式' AS remarks, '退货方式' AS explain_, 0 AS is_admin, '退货方式' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '退货方式' AS code, '[待审]退货方式' AS remarks, 'Phương thức trả về' AS explain_, 0 AS is_admin, '退货方式' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '退货方式' AS code, '退货方式' AS remarks, 'Return method' AS explain_, 0 AS is_admin, '退货方式' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '退货留言' AS code, '退货留言' AS remarks, '退货留言' AS explain_, 0 AS is_admin, '退货留言' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '退货留言' AS code, '[待审]退货留言' AS remarks, 'Trả lại tin nhắn' AS explain_, 0 AS is_admin, '退货留言' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '退货留言' AS code, '退货留言' AS remarks, 'Return message' AS explain_, 0 AS is_admin, '退货留言' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '退货退款' AS code, '退货退款' AS remarks, '退货退款' AS explain_, 0 AS is_admin, '退货退款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '退货退款' AS code, '[待审]退货退款' AS remarks, 'Trả lại và hoàn tiền' AS explain_, 0 AS is_admin, '退货退款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '退货退款' AS code, '退货退款' AS remarks, 'Returns and refunds' AS explain_, 0 AS is_admin, '退货退款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '送礼物' AS code, '送礼物' AS remarks, '送礼物' AS explain_, 0 AS is_admin, '送礼物' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '送礼物' AS code, '[待审]送礼物' AS remarks, 'tặng quà' AS explain_, 0 AS is_admin, '送礼物' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '送礼物' AS code, '送礼物' AS remarks, 'give gifts' AS explain_, 0 AS is_admin, '送礼物' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '送给' AS code, '送给' AS remarks, '送给' AS explain_, 0 AS is_admin, '送给' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '送给' AS code, '[待审]送给' AS remarks, 'đưa cho' AS explain_, 0 AS is_admin, '送给' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '送给' AS code, '送给' AS remarks, 'give to' AS explain_, 0 AS is_admin, '送给' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '送给好友' AS code, '送给好友' AS remarks, '送给好友' AS explain_, 0 AS is_admin, '送给好友' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '送给好友' AS code, '[待审]送给好友' AS remarks, 'Gửi cho bạn bè' AS explain_, 0 AS is_admin, '送给好友' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '送给好友' AS code, '送给好友' AS remarks, 'Send to a friend' AS explain_, 0 AS is_admin, '送给好友' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '送给您的一份礼物' AS code, '送给您的一份礼物' AS remarks, '送给您的一份礼物' AS explain_, 0 AS is_admin, '送给您的一份礼物' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '送给您的一份礼物' AS code, '[待审]送给您的一份礼物' AS remarks, 'một món quà cho bạn' AS explain_, 0 AS is_admin, '送给您的一份礼物' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '送给您的一份礼物' AS code, '送给您的一份礼物' AS remarks, 'a gift to you' AS explain_, 0 AS is_admin, '送给您的一份礼物' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '通用优惠券' AS code, '通用优惠券' AS remarks, '通用优惠券' AS explain_, 0 AS is_admin, '通用优惠券' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '通用优惠券' AS code, '[待审]通用优惠券' AS remarks, 'Phiếu giảm giá phổ quát' AS explain_, 0 AS is_admin, '通用优惠券' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '通用优惠券' AS code, '通用优惠券' AS remarks, 'Universal Coupon' AS explain_, 0 AS is_admin, '通用优惠券' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '通联支付' AS code, '通联支付' AS remarks, '通联支付' AS explain_, 0 AS is_admin, '通联支付' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '通联支付' AS code, '[待审]通联支付' AS remarks, 'thanh toán Tonglian' AS explain_, 0 AS is_admin, '通联支付' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '通联支付' AS code, '通联支付' AS remarks, 'Tonglian payment' AS explain_, 0 AS is_admin, '通联支付' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '部分核销' AS code, '部分核销' AS remarks, '部分核销' AS explain_, 0 AS is_admin, '部分核销' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '部分核销' AS code, '[待审]部分核销' AS remarks, 'Xóa nợ một phần' AS explain_, 0 AS is_admin, '部分核销' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '部分核销' AS code, '部分核销' AS remarks, 'Partial write-off' AS explain_, 0 AS is_admin, '部分核销' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '配送员' AS code, '配送员' AS remarks, '配送员' AS explain_, 0 AS is_admin, '配送员' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '配送员' AS code, '[待审]配送员' AS remarks, 'người giao hàng' AS explain_, 0 AS is_admin, '配送员' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '配送员' AS code, '配送员' AS remarks, 'delivery person' AS explain_, 0 AS is_admin, '配送员' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '配送地址' AS code, '配送地址' AS remarks, '配送地址' AS explain_, 0 AS is_admin, '配送地址' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '配送地址' AS code, '[待审]配送地址' AS remarks, 'địa chỉ giao hàng' AS explain_, 0 AS is_admin, '配送地址' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '配送地址' AS code, '配送地址' AS remarks, 'shipping address' AS explain_, 0 AS is_admin, '配送地址' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '配送金额' AS code, '配送金额' AS remarks, '配送金额' AS explain_, 0 AS is_admin, '配送金额' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '配送金额' AS code, '[待审]配送金额' AS remarks, 'Số tiền giao hàng' AS explain_, 0 AS is_admin, '配送金额' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '配送金额' AS code, '配送金额' AS remarks, 'Delivery amount' AS explain_, 0 AS is_admin, '配送金额' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '采购优惠' AS code, '采购优惠' AS remarks, '采购优惠' AS explain_, 0 AS is_admin, '采购优惠' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '采购优惠' AS code, '[待审]采购优惠' AS remarks, 'Giảm giá mua hàng' AS explain_, 0 AS is_admin, '采购优惠' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '采购优惠' AS code, '采购优惠' AS remarks, 'Purchase discount' AS explain_, 0 AS is_admin, '采购优惠' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '重开一个' AS code, '重开一个' AS remarks, '重开一个' AS explain_, 0 AS is_admin, '重开一个' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '重开一个' AS code, '[待审]重开一个' AS remarks, 'Mở lại một' AS explain_, 0 AS is_admin, '重开一个' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '重开一个' AS code, '重开一个' AS remarks, 'Reopen one' AS explain_, 0 AS is_admin, '重开一个' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '重置' AS code, '重置' AS remarks, '重置' AS explain_, 0 AS is_admin, '重置' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '重置' AS code, '[待审]重置' AS remarks, 'cài lại' AS explain_, 0 AS is_admin, '重置' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '重置' AS code, '重置' AS remarks, 'reset' AS explain_, 0 AS is_admin, '重置' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '重连中' AS code, '重连中' AS remarks, '重连中' AS explain_, 0 AS is_admin, '重连中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '重连中' AS code, '[待审]重连中' AS remarks, 'Đang kết nối lại' AS explain_, 0 AS is_admin, '重连中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '重连中' AS code, '重连中' AS remarks, 'Reconnecting' AS explain_, 0 AS is_admin, '重连中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '链接已复制' AS code, '链接已复制' AS remarks, '链接已复制' AS explain_, 0 AS is_admin, '链接已复制' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '链接已复制' AS code, '[待审]链接已复制' AS remarks, 'Đã sao chép liên kết' AS explain_, 0 AS is_admin, '链接已复制' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '链接已复制' AS code, '链接已复制' AS remarks, 'Link copied' AS explain_, 0 AS is_admin, '链接已复制' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '门店自提' AS code, '门店自提' AS remarks, '门店自提' AS explain_, 0 AS is_admin, '门店自提' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '门店自提' AS code, '[待审]门店自提' AS remarks, 'Nhận tại cửa hàng' AS explain_, 0 AS is_admin, '门店自提' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '门店自提' AS code, '门店自提' AS remarks, 'Pick up in store' AS explain_, 0 AS is_admin, '门店自提' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '限量剩余' AS code, '限量剩余' AS remarks, '限量剩余' AS explain_, 0 AS is_admin, '限量剩余' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '限量剩余' AS code, '[待审]限量剩余' AS remarks, 'Số lượng còn lại có hạn' AS explain_, 0 AS is_admin, '限量剩余' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '限量剩余' AS code, '限量剩余' AS remarks, 'Limited amount left' AS explain_, 0 AS is_admin, '限量剩余' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '随便逛逛' AS code, '随便逛逛' AS remarks, '随便逛逛' AS explain_, 0 AS is_admin, '随便逛逛' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '随便逛逛' AS code, '[待审]随便逛逛' AS remarks, 'Chỉ cần đi dạo' AS explain_, 0 AS is_admin, '随便逛逛' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '随便逛逛' AS code, '随便逛逛' AS remarks, 'Just take a stroll' AS explain_, 0 AS is_admin, '随便逛逛' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '隐私政策概要' AS code, '隐私政策概要' AS remarks, '隐私政策概要' AS explain_, 0 AS is_admin, '隐私政策概要' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '隐私政策概要' AS code, '[待审]隐私政策概要' AS remarks, 'Tóm tắt chính sách quyền riêng tư' AS explain_, 0 AS is_admin, '隐私政策概要' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '隐私政策概要' AS code, '隐私政策概要' AS remarks, 'Privacy Policy Summary' AS explain_, 0 AS is_admin, '隐私政策概要' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '零' AS code, '零' AS remarks, '零' AS explain_, 0 AS is_admin, '零' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '零' AS code, '[待审]零' AS remarks, 'không' AS explain_, 0 AS is_admin, '零' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '零' AS code, '零' AS remarks, 'zero' AS explain_, 0 AS is_admin, '零' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '需付款' AS code, '需付款' AS remarks, '需付款' AS explain_, 0 AS is_admin, '需付款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '需付款' AS code, '[待审]需付款' AS remarks, 'Yêu cầu thanh toán' AS explain_, 0 AS is_admin, '需付款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '需付款' AS code, '需付款' AS remarks, 'Payment required' AS explain_, 0 AS is_admin, '需付款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '需用户出示二维码或数字即可核销' AS code, '需用户出示二维码或数字即可核销' AS remarks, '需用户出示二维码或数字即可核销' AS explain_, 0 AS is_admin, '需用户出示二维码或数字即可核销' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '需用户出示二维码或数字即可核销' AS code, '[待审]需用户出示二维码或数字即可核销' AS remarks, 'Người dùng được yêu cầu xuất trình mã QR hoặc số để hủy' AS explain_, 0 AS is_admin, '需用户出示二维码或数字即可核销' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '需用户出示二维码或数字即可核销' AS code, '需用户出示二维码或数字即可核销' AS remarks, 'Users are required to present a QR code or number to cancel' AS explain_, 0 AS is_admin, '需用户出示二维码或数字即可核销' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '顺丰请输入单号' AS code, '顺丰请输入单号' AS remarks, '顺丰请输入单号' AS explain_, 0 AS is_admin, '顺丰请输入单号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '顺丰请输入单号' AS code, '[待审]顺丰请输入单号' AS remarks, 'SF Vui lòng nhập số theo dõi' AS explain_, 0 AS is_admin, '顺丰请输入单号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '顺丰请输入单号' AS code, '顺丰请输入单号' AS remarks, 'SF Please enter the tracking number' AS explain_, 0 AS is_admin, '顺丰请输入单号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '预售:' AS code, '预售:' AS remarks, '预售:' AS explain_, 0 AS is_admin, '预售:' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '预售:' AS code, '[待审]预售:' AS remarks, 'Bán trước:' AS explain_, 0 AS is_admin, '预售:' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '预售:' AS code, '预售:' AS remarks, 'Pre-sale:' AS explain_, 0 AS is_admin, '预售:' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '领券下单·享购物优惠' AS code, '领券下单·享购物优惠' AS remarks, '领券下单·享购物优惠' AS explain_, 0 AS is_admin, '领券下单·享购物优惠' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '领券下单·享购物优惠' AS code, '[待审]领券下单·享购物优惠' AS remarks, 'Nhận phiếu giảm giá và đặt hàng để được giảm giá mua sắm' AS explain_, 0 AS is_admin, '领券下单·享购物优惠' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '领券下单·享购物优惠' AS code, '领券下单·享购物优惠' AS remarks, 'Receive coupons and place orders to enjoy shopping discounts' AS explain_, 0 AS is_admin, '领券下单·享购物优惠' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '领取失败，礼物已失效' AS code, '领取失败，礼物已失效' AS remarks, '领取失败，礼物已失效' AS explain_, 0 AS is_admin, '领取失败，礼物已失效' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '领取失败，礼物已失效' AS code, '[待审]领取失败，礼物已失效' AS remarks, 'Không nhận được, quà tặng đã hết hạn' AS explain_, 0 AS is_admin, '领取失败，礼物已失效' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '领取失败，礼物已失效' AS code, '领取失败，礼物已失效' AS remarks, 'Failed to receive, the gift has expired' AS explain_, 0 AS is_admin, '领取失败，礼物已失效' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '首次登录会自动注册' AS code, '首次登录会自动注册' AS remarks, '首次登录会自动注册' AS explain_, 0 AS is_admin, '首次登录会自动注册' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '首次登录会自动注册' AS code, '[待审]首次登录会自动注册' AS remarks, 'Bạn sẽ được đăng ký tự động khi đăng nhập lần đầu tiên.' AS explain_, 0 AS is_admin, '首次登录会自动注册' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '首次登录会自动注册' AS code, '首次登录会自动注册' AS remarks, 'You will be automatically registered when you log in for the first time.' AS explain_, 0 AS is_admin, '首次登录会自动注册' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '验证失败' AS code, '验证失败' AS remarks, '验证失败' AS explain_, 0 AS is_admin, '验证失败' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '验证失败' AS code, '[待审]验证失败' AS remarks, 'Xác thực không thành công' AS explain_, 0 AS is_admin, '验证失败' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '验证失败' AS code, '验证失败' AS remarks, 'Authentication failed' AS explain_, 0 AS is_admin, '验证失败' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '验证成功' AS code, '验证成功' AS remarks, '验证成功' AS explain_, 0 AS is_admin, '验证成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '验证成功' AS code, '[待审]验证成功' AS remarks, 'Xác minh thành công' AS explain_, 0 AS is_admin, '验证成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '验证成功' AS code, '验证成功' AS remarks, 'Verification successful' AS explain_, 0 AS is_admin, '验证成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '，退款中' AS code, '，退款中' AS remarks, '，退款中' AS explain_, 0 AS is_admin, '，退款中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '，退款中' AS code, '[待审]，退款中' AS remarks, ', hoàn lại tiền' AS explain_, 0 AS is_admin, '，退款中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '，退款中' AS code, '，退款中' AS remarks, ', refunding' AS explain_, 0 AS is_admin, '，退款中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '，部分退款中' AS code, '，部分退款中' AS remarks, '，部分退款中' AS explain_, 0 AS is_admin, '，部分退款中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '，部分退款中' AS code, '[待审]，部分退款中' AS remarks, ', đang hoàn lại một phần' AS explain_, 0 AS is_admin, '，部分退款中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '，部分退款中' AS code, '，部分退款中' AS remarks, ', partial refund is in progress' AS explain_, 0 AS is_admin, '，部分退款中' AS zh_
) v
WHERE v.tid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_lang_code e WHERE e.type_id = v.tid AND e.code = v.code);

-- 补翻：已有越语/英语占位（等于中文）时更新 lang_explain
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='(có thể trống)', c.remarks='[待审](可为空)' WHERE c.code='(可为空)' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='(可为空)');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='(can be empty)' WHERE c.code='(可为空)' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='(可为空)');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='7 ngày không có lý do để trả lại hoặc trao đổi hàng · Yên tâm mua hàng', c.remarks='[待审]7天无理由退换货·放心购' WHERE c.code='7天无理由退换货·放心购' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='7天无理由退换货·放心购');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='7 days no reason to return or exchange goods·Buy with confidence' WHERE c.code='7天无理由退换货·放心购' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='7天无理由退换货·放心购');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='h5 và ứng dụng không hỗ trợ chuyển sang các chương trình nhỏ bên ngoài', c.remarks='[待审]h5与app端不支持跳转外部小程序' WHERE c.code='h5与app端不支持跳转外部小程序' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='h5与app端不支持跳转外部小程序');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='h5 and app do not support jumping to external mini programs' WHERE c.code='h5与app端不支持跳转外部小程序' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='h5与app端不支持跳转外部小程序');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='một', c.remarks='[待审]一' WHERE c.code='一' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='一');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='one' WHERE c.code='一' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='一');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='trong vòng một tháng', c.remarks='[待审]一个月内' WHERE c.code='一个月内' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='一个月内');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='within a month' WHERE c.code='一个月内' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='一个月内');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tỷ lệ hoa hồng cấp đầu tiên', c.remarks='[待审]一级分佣比例' WHERE c.code='一级分佣比例' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='一级分佣比例');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='First level commission ratio' WHERE c.code='一级分佣比例' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='一级分佣比例');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phân loại cấp độ đầu tiên', c.remarks='[待审]一级分类' WHERE c.code='一级分类' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='一级分类');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='First level classification' WHERE c.code='一级分类' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='一级分类');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Một cú nhấp chuột', c.remarks='[待审]一键' WHERE c.code='一键' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='一键');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='One click' WHERE c.code='一键' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='一键');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhận nó với một cú nhấp chuột', c.remarks='[待审]一键领取' WHERE c.code='一键领取' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='一键领取');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Get it with one click' WHERE c.code='一键领取' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='一键领取');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='bảy', c.remarks='[待审]七' WHERE c.code='七' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='七');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='seven' WHERE c.code='七' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='七');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='ba', c.remarks='[待审]三' WHERE c.code='三' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='三');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='three' WHERE c.code='三' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='三');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='trong vòng ba tháng', c.remarks='[待审]三个月内' WHERE c.code='三个月内' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='三个月内');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='within three months' WHERE c.code='三个月内' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='三个月内');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='trong vòng ba ngày', c.remarks='[待审]三天内' WHERE c.code='三天内' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='三天内');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='within three days' WHERE c.code='三天内' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='三天内');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Trên kệ', c.remarks='[待审]上架' WHERE c.code='上架' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='上架');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='On the shelves' WHERE c.code='上架' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='上架');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đã xóa khỏi kệ', c.remarks='[待审]下架' WHERE c.code='下架' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='下架');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Removed from shelves' WHERE c.code='下架' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='下架');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Lỗi tải xuống', c.remarks='[待审]下载出错' WHERE c.code='下载出错' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='下载出错');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Download error' WHERE c.code='下载出错' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='下载出错');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tải file cập nhật...', c.remarks='[待审]下载更新文件...' WHERE c.code='下载更新文件...' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='下载更新文件...');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Download update files...' WHERE c.code='下载更新文件...' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='下载更新文件...');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bạn không thể nhập 0', c.remarks='[待审]不能输入0喔' WHERE c.code='不能输入0喔' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='不能输入0喔');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='You cannot enter 0' WHERE c.code='不能输入0喔' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='不能输入0喔');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phiếu giảm giá độc quyền', c.remarks='[待审]专属优惠券' WHERE c.code='专属优惠券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='专属优惠券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Exclusive coupons' WHERE c.code='专属优惠券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='专属优惠券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Cá nhân chỉ hỗ trợ hóa đơn thông thường', c.remarks='[待审]个人仅支持普通发票' WHERE c.code='个人仅支持普通发票' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='个人仅支持普通发票');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Individuals only support ordinary invoices' WHERE c.code='个人仅支持普通发票' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='个人仅支持普通发票');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Neo', c.remarks='[待审]主播' WHERE c.code='主播' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='主播');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Anchor' WHERE c.code='主播' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='主播');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chín', c.remarks='[待审]九' WHERE c.code='九' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='九');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Nine' WHERE c.code='九' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='九');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Ghi chú của người mua', c.remarks='[待审]买家备注' WHERE c.code='买家备注' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='买家备注');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Buyer''s Notes' WHERE c.code='买家备注' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='买家备注');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='hai', c.remarks='[待审]二' WHERE c.code='二' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='二');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='two' WHERE c.code='二' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='二');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tỷ lệ hoa hồng cấp hai', c.remarks='[待审]二级分佣比例' WHERE c.code='二级分佣比例' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='二级分佣比例');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Second level commission ratio' WHERE c.code='二级分佣比例' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='二级分佣比例');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phân loại thứ cấp', c.remarks='[待审]二级分类' WHERE c.code='二级分类' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='二级分类');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Secondary classification' WHERE c.code='二级分类' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='二级分类');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đã lưu mã QR thành công', c.remarks='[待审]二维码保存成功' WHERE c.code='二维码保存成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='二维码保存成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='QR code saved successfully' WHERE c.code='二维码保存成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='二维码保存成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nội dung mã QR không được để trống', c.remarks='[待审]二维码内容不能为空' WHERE c.code='二维码内容不能为空' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='二维码内容不能为空');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The QR code content cannot be empty' WHERE c.code='二维码内容不能为空' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='二维码内容不能为空');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Mã QR đang được tạo', c.remarks='[待审]二维码生成中' WHERE c.code='二维码生成中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='二维码生成中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='QR code is being generated' WHERE c.code='二维码生成中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='二维码生成中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='năm', c.remarks='[待审]五' WHERE c.code='五' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='五');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='five' WHERE c.code='五' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='五');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Mọi người tham gia vào các cuộc chiến nhóm', c.remarks='[待审]人参与拼团' WHERE c.code='人参与拼团' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='人参与拼团');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='People participate in group fights' WHERE c.code='人参与拼团' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='人参与拼团');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chỉ có tại cửa hàng', c.remarks='[待审]仅支持到店' WHERE c.code='仅支持到店' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='仅支持到店');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Only available in store' WHERE c.code='仅支持到店' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='仅支持到店');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chỉ hỗ trợ giao hàng', c.remarks='[待审]仅支持配送' WHERE c.code='仅支持配送' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='仅支持配送');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Only supports delivery' WHERE c.code='仅支持配送' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='仅支持配送');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hôm nay', c.remarks='[待审]今日' WHERE c.code='今日' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='今日');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='today' WHERE c.code='今日' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='今日');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hôm nay tôi đã đăng nhập, ngày mai quay lại', c.remarks='[待审]今日已签到，明日再来吧' WHERE c.code='今日已签到，明日再来吧' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='今日已签到，明日再来吧');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='I''ve signed in today, come back tomorrow' WHERE c.code='今日已签到，明日再来吧' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='今日已签到，明日再来吧');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Trong kho', c.remarks='[待审]仓库中' WHERE c.code='仓库中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='仓库中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='In warehouse' WHERE c.code='仓库中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='仓库中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='mã thanh toán', c.remarks='[待审]付款码' WHERE c.code='付款码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='付款码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='payment code' WHERE c.code='付款码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='付款码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Lợi ích thành viên trả phí', c.remarks='[待审]付费会员优惠' WHERE c.code='付费会员优惠' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='付费会员优惠');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Paid membership benefits' WHERE c.code='付费会员优惠' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='付费会员优惠');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Trả tiền cho hình đại diện', c.remarks='[待审]代付头像' WHERE c.code='代付头像' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='代付头像');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Pay for avatar' WHERE c.code='代付头像' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='代付头像');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='chia sẻ', c.remarks='[待审]份' WHERE c.code='份' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='份');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='share' WHERE c.code='份' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='份');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='thành viên', c.remarks='[待审]会员' WHERE c.code='会员' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='会员');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='member' WHERE c.code='会员' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='会员');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Ngày hết hạn thành viên', c.remarks='[待审]会员到期日' WHERE c.code='会员到期日' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='会员到期日');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Membership expiration date' WHERE c.code='会员到期日' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='会员到期日');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Mã thành viên', c.remarks='[待审]会员码' WHERE c.code='会员码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='会员码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Member code' WHERE c.code='会员码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='会员码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='thấp như', c.remarks='[待审]低至' WHERE c.code='低至' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='低至');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='as low as' WHERE c.code='低至' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='低至');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Khấu trừ số dư', c.remarks='[待审]余额抵扣' WHERE c.code='余额抵扣' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='余额抵扣');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Balance deduction' WHERE c.code='余额抵扣' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='余额抵扣');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phiên bản WeChat của bạn quá thấp, vui lòng cập nhật lên phiên bản mới nhất.', c.remarks='[待审]你的微信版本过低，请更新至最新版本。' WHERE c.code='你的微信版本过低，请更新至最新版本。' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='你的微信版本过低，请更新至最新版本。');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Your WeChat version is too low, please update to the latest version.' WHERE c.code='你的微信版本过低，请更新至最新版本。' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='你的微信版本过低，请更新至最新版本。');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hoa hồng bị đóng băng', c.remarks='[待审]佣金冻结中' WHERE c.code='佣金冻结中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='佣金冻结中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Commission is frozen' WHERE c.code='佣金冻结中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='佣金冻结中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thanh toán bằng Tonglian Pay', c.remarks='[待审]使用通联支付付款' WHERE c.code='使用通联支付付款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='使用通联支付付款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Pay using Tonglian Pay' WHERE c.code='使用通联支付付款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='使用通联支付付款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Ví dụ', c.remarks='[待审]例如' WHERE c.code='例如' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='例如');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='For example' WHERE c.code='例如' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='例如');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='lưu hình ảnh', c.remarks='[待审]保存图片' WHERE c.code='保存图片' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='保存图片');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='save image' WHERE c.code='保存图片' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='保存图片');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Ôn lại', c.remarks='[待审]修改' WHERE c.code='修改' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Revise' WHERE c.code='修改' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Sửa đổi giá/cổ phiếu', c.remarks='[待审]修改价格/库存' WHERE c.code='修改价格/库存' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改价格/库存');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Modify price/stock' WHERE c.code='修改价格/库存' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改价格/库存');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Sửa đổi số dư', c.remarks='[待审]修改余额' WHERE c.code='修改余额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改余额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Modify balance' WHERE c.code='修改余额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改余额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền ít nhất một mục cho nội dung sửa đổi', c.remarks='[待审]修改内容至少填写一项' WHERE c.code='修改内容至少填写一项' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改内容至少填写一项');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in at least one item for modification content' WHERE c.code='修改内容至少填写一项' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改内容至少填写一项');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Sửa đổi phân loại', c.remarks='[待审]修改分类' WHERE c.code='修改分类' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改分类');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Modify classification' WHERE c.code='修改分类' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改分类');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Sửa đổi nhóm', c.remarks='[待审]修改分组' WHERE c.code='修改分组' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改分组');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Modify group' WHERE c.code='修改分组' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改分组');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Sửa đổi điểm', c.remarks='[待审]修改积分' WHERE c.code='修改积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Modify points' WHERE c.code='修改积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Sửa đổi cấp độ', c.remarks='[待审]修改等级' WHERE c.code='修改等级' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改等级');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Modify level' WHERE c.code='修改等级' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='修改等级');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='nhân dân tệ, lên tới 500 nhân dân tệ', c.remarks='[待审]元，最高500元' WHERE c.code='元，最高500元' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='元，最高500元');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='yuan, up to 500 yuan' WHERE c.code='元，最高500元' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='元，最高500元');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhận phiếu giảm giá trước rồi mua sắm', c.remarks='[待审]先领券 再购物' WHERE c.code='先领券 再购物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='先领券 再购物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Get coupons first and then shop' WHERE c.code='先领券 再购物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='先领券 再购物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tất cả sản phẩm', c.remarks='[待审]全部商品' WHERE c.code='全部商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='全部商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='All products' WHERE c.code='全部商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='全部商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='tám', c.remarks='[待审]八' WHERE c.code='八' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='八');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='eight' WHERE c.code='八' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='八');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='sáu', c.remarks='[待审]六' WHERE c.code='六' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='六');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='six' WHERE c.code='六' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='六');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Theo dõi tài khoản công khai', c.remarks='[待审]关注公众号' WHERE c.code='关注公众号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='关注公众号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Follow the public account' WHERE c.code='关注公众号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='关注公众号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Các cài đặt khác', c.remarks='[待审]其他设置' WHERE c.code='其他设置' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='其他设置');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Other settings' WHERE c.code='其他设置' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='其他设置');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tích lũy lại số lần đăng nhập', c.remarks='[待审]再累计签到' WHERE c.code='再累计签到' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='再累计签到');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Accumulate sign-ins again' WHERE c.code='再累计签到' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='再累计签到');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đăng nhập lại', c.remarks='[待审]再连续签到' WHERE c.code='再连续签到' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='再连续签到');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Sign in again' WHERE c.code='再连续签到' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='再连续签到');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đóng băng', c.remarks='[待审]冻结中' WHERE c.code='冻结中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='冻结中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Freezing' WHERE c.code='冻结中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='冻结中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Giảm số dư', c.remarks='[待审]减少余额' WHERE c.code='减少余额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='减少余额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Reduce balance' WHERE c.code='减少余额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='减少余额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Giảm điểm', c.remarks='[待审]减少积分' WHERE c.code='减少积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='减少积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Reduce points' WHERE c.code='减少积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='减少积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Cần bán', c.remarks='[待审]出售中' WHERE c.code='出售中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='出售中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='For sale' WHERE c.code='出售中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='出售中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Ngày sinh', c.remarks='[待审]出生年月' WHERE c.code='出生年月' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='出生年月');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Date of birth' WHERE c.code='出生年月' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='出生年月');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='chia sẻ', c.remarks='[待审]分享' WHERE c.code='分享' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分享');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='share' WHERE c.code='分享' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分享');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vận chuyển theo đơn đặt hàng riêng biệt', c.remarks='[待审]分单发货' WHERE c.code='分单发货' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分单发货');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Ship in separate orders' WHERE c.code='分单发货' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分单发货');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hoàn tiền đơn hàng', c.remarks='[待审]分单退款' WHERE c.code='分单退款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分单退款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Split order refund' WHERE c.code='分单退款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分单退款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhóm', c.remarks='[待审]分组' WHERE c.code='分组' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分组');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Group' WHERE c.code='分组' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分组');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thỏa thuận phân phối', c.remarks='[待审]分销员协议' WHERE c.code='分销员协议' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分销员协议');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Distributor Agreement' WHERE c.code='分销员协议' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分销员协议');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tên nhà phân phối', c.remarks='[待审]分销员姓名' WHERE c.code='分销员姓名' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分销员姓名');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Distributor name' WHERE c.code='分销员姓名' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分销员姓名');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hướng dẫn phân phối', c.remarks='[待审]分销说明' WHERE c.code='分销说明' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分销说明');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Distribution instructions' WHERE c.code='分销说明' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='分销说明');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chuyển đổi địa chỉ', c.remarks='[待审]切换地址' WHERE c.code='切换地址' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='切换地址');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Switch address' WHERE c.code='切换地址' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='切换地址');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chuyển đổi cửa hàng', c.remarks='[待审]切换门店' WHERE c.code='切换门店' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='切换门店');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Switch store' WHERE c.code='切换门店' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='切换门店');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tạo đơn hàng', c.remarks='[待审]创建订单中' WHERE c.code='创建订单中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='创建订单中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Creating order' WHERE c.code='创建订单中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='创建订单中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đến cửa hàng', c.remarks='[待审]到店' WHERE c.code='到店' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='到店');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Arrive at the store' WHERE c.code='到店' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='到店');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Giá thực trả', c.remarks='[待审]到手价' WHERE c.code='到手价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='到手价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Final price' WHERE c.code='到手价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='到手价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Làm mới trạng thái thanh toán', c.remarks='[待审]刷新支付状态' WHERE c.code='刷新支付状态' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='刷新支付状态');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Refresh payment status' WHERE c.code='刷新支付状态' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='刷新支付状态');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Số ngày còn lại', c.remarks='[待审]剩余天数' WHERE c.code='剩余天数' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='剩余天数');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Days remaining' WHERE c.code='剩余天数' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='剩余天数');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Số lần rút còn lại là 0', c.remarks='[待审]剩余抽奖次数为0' WHERE c.code='剩余抽奖次数为0' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='剩余抽奖次数为0');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The remaining number of draws is 0' WHERE c.code='剩余抽奖次数为0' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='剩余抽奖次数为0');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='đang tải...', c.remarks='[待审]加载中...' WHERE c.code='加载中...' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='加载中...');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='loading...' WHERE c.code='加载中...' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='加载中...');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Trong vòng nửa năm', c.remarks='[待审]半年内' WHERE c.code='半年内' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='半年内');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Within half a year' WHERE c.code='半年内' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='半年内');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Giao hàng bí mật thẻ', c.remarks='[待审]卡密发货' WHERE c.code='卡密发货' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='卡密发货');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Card secret delivery' WHERE c.code='卡密发货' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='卡密发货');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Giá gốc', c.remarks='[待审]原价' WHERE c.code='原价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='原价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Original price' WHERE c.code='原价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='原价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đi mua sắm', c.remarks='[待审]去抢购' WHERE c.code='去抢购' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去抢购');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Go shopping' WHERE c.code='去抢购' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去抢购');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='ủy quyền', c.remarks='[待审]去授权' WHERE c.code='去授权' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去授权');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='to authorize' WHERE c.code='去授权' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去授权');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đi và nhìn xem', c.remarks='[待审]去看看' WHERE c.code='去看看' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去看看');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Go and have a look' WHERE c.code='去看看' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去看看');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='để đánh giá', c.remarks='[待审]去评价' WHERE c.code='去评价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去评价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='to evaluate' WHERE c.code='去评价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去评价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đi mua sắm', c.remarks='[待审]去逛逛' WHERE c.code='去逛逛' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去逛逛');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Go shopping' WHERE c.code='去逛逛' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去逛逛');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đi và đặt chỗ', c.remarks='[待审]去预定' WHERE c.code='去预定' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去预定');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Go and book' WHERE c.code='去预定' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去预定');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đi và lấy nó', c.remarks='[待审]去领取' WHERE c.code='去领取' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去领取');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Go and get it' WHERE c.code='去领取' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='去领取');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='tham số', c.remarks='[待审]参数' WHERE c.code='参数' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='参数');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='parameter' WHERE c.code='参数' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='参数');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='gửi', c.remarks='[待审]发送' WHERE c.code='发送' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='发送');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='send' WHERE c.code='发送' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='发送');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Gửi phiếu giảm giá', c.remarks='[待审]发送优惠券' WHERE c.code='发送优惠券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='发送优惠券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Send coupon' WHERE c.code='发送优惠券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='发送优惠券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Gửi hàng', c.remarks='[待审]发送货' WHERE c.code='发送货' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='发送货');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Send the goods' WHERE c.code='发送货' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='发送货');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hủy đăng nhập', c.remarks='[待审]取消登录' WHERE c.code='取消登录' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='取消登录');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Cancel login' WHERE c.code='取消登录' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='取消登录');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thông tin chi tiết có thể được xem trong "WeChat Payment-Service-Wallet-Hóa đơn"', c.remarks='[待审]可在“微信支付-服务-钱包-账单”查看明细' WHERE c.code='可在“微信支付-服务-钱包-账单”查看明细' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='可在“微信支付-服务-钱包-账单”查看明细');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Details can be viewed in "WeChat Payment-Service-Wallet-Bill"' WHERE c.code='可在“微信支付-服务-钱包-账单”查看明细' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='可在“微信支付-服务-钱包-账单”查看明细');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tiền mặt sẵn có (nhân dân tệ)', c.remarks='[待审]可提现(元)' WHERE c.code='可提现(元)' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='可提现(元)');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Cash available (yuan)' WHERE c.code='可提现(元)' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='可提现(元)');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='có thể chọn', c.remarks='[待审]可选' WHERE c.code='可选' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='可选');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='available' WHERE c.code='可选' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='可选');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhận thêm gói quà bất ngờ', c.remarks='[待审]可额外获得惊喜礼包' WHERE c.code='可额外获得惊喜礼包' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='可额外获得惊喜礼包');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Receive additional surprise gift packs' WHERE c.code='可额外获得惊喜礼包' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='可额外获得惊喜礼包');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đồng ý và tiếp tục', c.remarks='[待审]同意并继续' WHERE c.code='同意并继续' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='同意并继续');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Agree and continue' WHERE c.code='同意并继续' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='同意并继续');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='tên', c.remarks='[待审]名称' WHERE c.code='名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='name' WHERE c.code='名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vuốt sang phải để hoàn tất xác minh', c.remarks='[待审]向右滑动完成验证' WHERE c.code='向右滑动完成验证' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='向右滑动完成验证');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Swipe right to complete verification' WHERE c.code='向右滑动完成验证' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='向右滑动完成验证');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='vào thứ Hai', c.remarks='[待审]周一' WHERE c.code='周一' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周一');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='on Monday' WHERE c.code='周一' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周一');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thứ Tư', c.remarks='[待审]周三' WHERE c.code='周三' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周三');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Wednesday' WHERE c.code='周三' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周三');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thứ ba', c.remarks='[待审]周二' WHERE c.code='周二' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周二');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Tuesday' WHERE c.code='周二' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周二');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thứ sáu', c.remarks='[待审]周五' WHERE c.code='周五' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周五');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Friday' WHERE c.code='周五' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周五');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thứ bảy', c.remarks='[待审]周六' WHERE c.code='周六' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周六');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Saturday' WHERE c.code='周六' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周六');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thứ năm', c.remarks='[待审]周四' WHERE c.code='周四' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周四');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Thursday' WHERE c.code='周四' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周四');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chủ nhật', c.remarks='[待审]周日' WHERE c.code='周日' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周日');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Sunday' WHERE c.code='周日' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='周日');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phiếu giảm giá thương hiệu', c.remarks='[待审]品牌券' WHERE c.code='品牌券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='品牌券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Brand coupon' WHERE c.code='品牌券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='品牌券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Danh mục Phiếu giảm giá', c.remarks='[待审]品类优惠券' WHERE c.code='品类优惠券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='品类优惠券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Category Coupons' WHERE c.code='品类优惠券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='品类优惠券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='giá bán', c.remarks='[待审]售价' WHERE c.code='售价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='售价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='selling price' WHERE c.code='售价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='售价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Số đơn hàng sau bán hàng', c.remarks='[待审]售后单号' WHERE c.code='售后单号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='售后单号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='After-sales order number' WHERE c.code='售后单号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='售后单号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Loại hậu mãi', c.remarks='[待审]售后类型' WHERE c.code='售后类型' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='售后类型');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='After-sales type' WHERE c.code='售后类型' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='售后类型');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đơn hàng sau bán hàng', c.remarks='[待审]售后订单' WHERE c.code='售后订单' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='售后订单');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='After-sales orders' WHERE c.code='售后订单' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='售后订单');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phiếu giảm giá sản phẩm', c.remarks='[待审]商品优惠券' WHERE c.code='商品优惠券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品优惠券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Product coupons' WHERE c.code='商品优惠券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品优惠券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tên sản phẩm', c.remarks='[待审]商品名称' WHERE c.code='商品名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Product name' WHERE c.code='商品名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hình ảnh sản phẩm', c.remarks='[待审]商品图' WHERE c.code='商品图' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品图');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Product picture' WHERE c.code='商品图' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品图');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hình ảnh sản phẩm', c.remarks='[待审]商品图片' WHERE c.code='商品图片' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品图片');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Product pictures' WHERE c.code='商品图片' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品图片');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Sản phẩm không có trên kệ', c.remarks='[待审]商品未上架' WHERE c.code='商品未上架' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品未上架');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The product is not on the shelves' WHERE c.code='商品未上架' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品未上架');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thẻ sản phẩm', c.remarks='[待审]商品标签' WHERE c.code='商品标签' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品标签');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Product tag' WHERE c.code='商品标签' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品标签');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Xóa sổ sản phẩm', c.remarks='[待审]商品核销' WHERE c.code='商品核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Product write-off' WHERE c.code='商品核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Quản lý sản phẩm', c.remarks='[待审]商品管理' WHERE c.code='商品管理' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品管理');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Product management' WHERE c.code='商品管理' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商品管理');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='đăng nhập trung tâm mua sắm', c.remarks='[待审]商城登录' WHERE c.code='商城登录' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商城登录');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Mall login' WHERE c.code='商城登录' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商城登录');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Trung tâm giao hàng', c.remarks='[待审]商城配送' WHERE c.code='商城配送' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商城配送');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Mall delivery' WHERE c.code='商城配送' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商城配送');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Người bán đã chuyển hàng và đang chờ người dùng nhận hàng.', c.remarks='[待审]商家已发货，等待用户收货' WHERE c.code='商家已发货，等待用户收货' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商家已发货，等待用户收货');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The merchant has shipped the goods and is waiting for the user to receive the goods.' WHERE c.code='商家已发货，等待用户收货' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='商家已发货，等待用户收货');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='bốn', c.remarks='[待审]四' WHERE c.code='四' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='四');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Four' WHERE c.code='四' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='四');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='trở lại ngày hôm đó', c.remarks='[待审]回到当天' WHERE c.code='回到当天' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='回到当天');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='back to the day' WHERE c.code='回到当天' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='回到当天');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='lãnh đạo', c.remarks='[待审]团长' WHERE c.code='团长' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='团长');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='leader' WHERE c.code='团长' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='团长');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bưu phí cố định', c.remarks='[待审]固定邮费' WHERE c.code='固定邮费' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='固定邮费');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Fixed postage' WHERE c.code='固定邮费' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='固定邮费');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='hình ảnh', c.remarks='[待审]图片' WHERE c.code='图片' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='图片');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='picture' WHERE c.code='图片' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='图片');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đang tải hình ảnh', c.remarks='[待审]图片加载中' WHERE c.code='图片加载中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='图片加载中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Picture loading' WHERE c.code='图片加载中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='图片加载中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Kích thước hình ảnh là 750*750px và có thể tải lên tối đa 10 hình ảnh.', c.remarks='[待审]图片尺寸为750*750px，最多上传10张' WHERE c.code='图片尺寸为750*750px，最多上传10张' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='图片尺寸为750*750px，最多上传10张');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The image size is 750*750px, and a maximum of 10 images can be uploaded.' WHERE c.code='图片尺寸为750*750px，最多上传10张' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='图片尺寸为750*750px，最多上传10张');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Kích thước hình ảnh là 750*750px và có thể tải lên tối đa 9 hình ảnh', c.remarks='[待审]图片尺寸为750*750px，最多上传9张' WHERE c.code='图片尺寸为750*750px，最多上传9张' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='图片尺寸为750*750px，最多上传9张');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The image size is 750*750px, and a maximum of 9 images can be uploaded' WHERE c.code='图片尺寸为750*750px，最多上传9张' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='图片尺寸为750*750px，最多上传9张');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Địa chỉ', c.remarks='[待审]地址' WHERE c.code='地址' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='地址');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='address' WHERE c.code='地址' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='地址');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Điền mã xác minh hình ảnh', c.remarks='[待审]填写图片验证码' WHERE c.code='填写图片验证码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='填写图片验证码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Fill in the image verification code' WHERE c.code='填写图片验证码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='填写图片验证码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Điền tin nhắn của bạn bè, tối đa 40 từ', c.remarks='[待审]填写好友留言，最多40字' WHERE c.code='填写好友留言，最多40字' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='填写好友留言，最多40字');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Fill in the friend’s message, up to 40 words' WHERE c.code='填写好友留言，最多40字' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='填写好友留言，最多40字');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Điền số đơn hàng hậu cần', c.remarks='[待审]填写物流单号' WHERE c.code='填写物流单号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='填写物流单号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Fill in the logistics order number' WHERE c.code='填写物流单号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='填写物流单号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='tăng số dư', c.remarks='[待审]增加余额' WHERE c.code='增加余额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='增加余额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='increase balance' WHERE c.code='增加余额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='增加余额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='tăng điểm', c.remarks='[待审]增加积分' WHERE c.code='增加积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='增加积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='increase points' WHERE c.code='增加积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='增加积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Xử lý không thành công', c.remarks='[待审]处理失败' WHERE c.code='处理失败' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='处理失败');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Processing failed' WHERE c.code='处理失败' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='处理失败');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Sao chép', c.remarks='[待审]复制中' WHERE c.code='复制中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='复制中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Copying' WHERE c.code='复制中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='复制中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Sao chép liên kết quà tặng', c.remarks='[待审]复制礼物链接' WHERE c.code='复制礼物链接' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='复制礼物链接');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Copy gift link' WHERE c.code='复制礼物链接' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='复制礼物链接');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='thất bại', c.remarks='[待审]失败' WHERE c.code='失败' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='失败');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='fail' WHERE c.code='失败' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='失败');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tin nhắn của bạn bè', c.remarks='[待审]好友留言' WHERE c.code='好友留言' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='好友留言');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Friend''s message' WHERE c.code='好友留言' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='好友留言');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nếu quét không thành công, vui lòng điều chỉnh màn hình về cài đặt sáng nhất và quét lại mã QR.', c.remarks='[待审]如遇到扫码失败请将屏幕调至最亮重新扫码' WHERE c.code='如遇到扫码失败请将屏幕调至最亮重新扫码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='如遇到扫码失败请将屏幕调至最亮重新扫码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='If scanning fails, please adjust the screen to the brightest setting and scan the QR code again.' WHERE c.code='如遇到扫码失败请将屏幕调至最亮重新扫码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='如遇到扫码失败请将屏幕调至最亮重新扫码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Cài đặt bản cập nhật...', c.remarks='[待审]安装更新文件...' WHERE c.code='安装更新文件...' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='安装更新文件...');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Install updates...' WHERE c.code='安装更新文件...' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='安装更新文件...');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Không cài đặt được tệp cập nhật [', c.remarks='[待审]安装更新文件失败[' WHERE c.code='安装更新文件失败[' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='安装更新文件失败[');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Failed to install update file [' WHERE c.code='安装更新文件失败[' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='安装更新文件失败[');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đến thực tế:', c.remarks='[待审]实际到账:' WHERE c.code='实际到账:' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='实际到账:');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Actual arrival:' WHERE c.code='实际到账:' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='实际到账:');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Mở rộng', c.remarks='[待审]展开' WHERE c.code='展开' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='展开');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Expand' WHERE c.code='展开' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='展开');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='bàn làm việc', c.remarks='[待审]工作台' WHERE c.code='工作台' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='工作台');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='workbench' WHERE c.code='工作台' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='工作台');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hết hạn', c.remarks='[待审]已失效' WHERE c.code='已失效' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已失效');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Expired' WHERE c.code='已失效' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已失效');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Viết tắt', c.remarks='[待审]已核销' WHERE c.code='已核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Written off' WHERE c.code='已核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đọc', c.remarks='[待审]已读' WHERE c.code='已读' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已读');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Read' WHERE c.code='已读' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已读');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đã hết hạn/chưa có sẵn', c.remarks='[待审]已过期/暂未开通' WHERE c.code='已过期/暂未开通' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已过期/暂未开通');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Expired/not yet available' WHERE c.code='已过期/暂未开通' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已过期/暂未开通');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đăng nhập liên tục', c.remarks='[待审]已连续签到' WHERE c.code='已连续签到' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已连续签到');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Signed in continuously' WHERE c.code='已连续签到' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已连续签到');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đã giao hàng', c.remarks='[待审]已配送' WHERE c.code='已配送' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已配送');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Delivered' WHERE c.code='已配送' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已配送');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đã đặt', c.remarks='[待审]已预订' WHERE c.code='已预订' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已预订');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Booked' WHERE c.code='已预订' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='已预订');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Năm', c.remarks='[待审]年' WHERE c.code='年' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='年');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Year' WHERE c.code='年' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='年');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Cảnh báo chứng khoán', c.remarks='[待审]库存警告' WHERE c.code='库存警告' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='库存警告');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Stock warning' WHERE c.code='库存警告' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='库存警告');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tải xuống tài nguyên ứng dụng đã hoàn tất!', c.remarks='[待审]应用资源下载完成！' WHERE c.code='应用资源下载完成！' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='应用资源下载完成！');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Application resource download completed!' WHERE c.code='应用资源下载完成！' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='应用资源下载完成！');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='gợi ý', c.remarks='[待审]建议' WHERE c.code='建议' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='建议');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='suggestion' WHERE c.code='建议' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='建议');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='bật lên', c.remarks='[待审]开启' WHERE c.code='开启' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='开启');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='turn on' WHERE c.code='开启' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='开启');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='khai mạc:', c.remarks='[待审]开盘：' WHERE c.code='开盘：' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='开盘：');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='opening:' WHERE c.code='开盘：' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='开盘：');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Mở SVIP dự kiến tiết kiệm', c.remarks='[待审]开通SVIP会员预计省' WHERE c.code='开通SVIP会员预计省' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='开通SVIP会员预计省');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Open SVIP to save about' WHERE c.code='开通SVIP会员预计省' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='开通SVIP会员预计省');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='mở', c.remarks='[待审]张' WHERE c.code='张' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='张');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='open' WHERE c.code='张' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='张');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hiện đang sử dụng mạng di động, bạn có muốn tiếp tục phát video không?', c.remarks='[待审]当前使用移动网络，是否继续播放视频？' WHERE c.code='当前使用移动网络，是否继续播放视频？' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='当前使用移动网络，是否继续播放视频？');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Currently using mobile network, do you want to continue playing the video?' WHERE c.code='当前使用移动网络，是否继续播放视频？' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='当前使用移动网络，是否继续播放视频？');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Lệnh hiện tại đã bị xóa', c.remarks='[待审]当前订单已完成核销' WHERE c.code='当前订单已完成核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='当前订单已完成核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The current order has been written off' WHERE c.code='当前订单已完成核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='当前订单已完成核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Khi bạn nhấp chuột đồng ý và bắt đầu sử dụng dịch vụ của sản phẩm có nghĩa là bạn đã hiểu và đồng ý với các điều khoản, đồng thời các điều khoản đó sẽ có giá trị ràng buộc về mặt pháp lý đối với bạn. Nếu bạn từ chối, bạn sẽ không thể tiến hành bước tiếp theo.', c.remarks='[待审]当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' WHERE c.code='当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='When you click to agree and start using the product services, it means that you have understood and agreed with the terms, and the terms will be legally binding on you. If you refuse, you will not be able to proceed to the next step.' WHERE c.code='当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='当您点击同意并开始时用产品服务时，即表示您已理解并同息该条款内容，该条款将对您产生法律约束力。如您拒绝，将无法继续下一步操作。');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đang chờ giao hàng/xóa sổ', c.remarks='[待审]待发货/核销' WHERE c.code='待发货/核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='待发货/核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Pending shipment/write-off' WHERE c.code='待发货/核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='待发货/核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đang chờ trả lại', c.remarks='[待审]待退货' WHERE c.code='待退货' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='待退货');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Pending return' WHERE c.code='待退货' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='待退货');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đang chờ giao hàng', c.remarks='[待审]待配送' WHERE c.code='待配送' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='待配送');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Awaiting delivery' WHERE c.code='待配送' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='待配送');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Sẽ được thu thập', c.remarks='[待审]待领取' WHERE c.code='待领取' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='待领取');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='To be collected' WHERE c.code='待领取' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='待领取');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='quên mật khẩu', c.remarks='[待审]忘记密码' WHERE c.code='忘记密码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='忘记密码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='forget the password' WHERE c.code='忘记密码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='忘记密码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Trả lại nhanh', c.remarks='[待审]快递退回' WHERE c.code='快递退回' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='快递退回');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Express return' WHERE c.code='快递退回' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='快递退回');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='thành công', c.remarks='[待审]成功' WHERE c.code='成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='success' WHERE c.code='成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thử nghiệm bắt đầu thành công', c.remarks='[待审]成功开启试用' WHERE c.code='成功开启试用' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='成功开启试用');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Trial started successfully' WHERE c.code='成功开启试用' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='成功开启试用');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='giá thành', c.remarks='[待审]成本价' WHERE c.code='成本价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='成本价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='cost price' WHERE c.code='成本价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='成本价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='món quà của tôi', c.remarks='[待审]我的礼物' WHERE c.code='我的礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='我的礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='my gift' WHERE c.code='我的礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='我的礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='lỗi mở', c.remarks='[待审]打开错误' WHERE c.code='打开错误' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='打开错误');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='open error' WHERE c.code='打开错误' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='打开错误');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chỉnh sửa hàng loạt', c.remarks='[待审]批量修改' WHERE c.code='批量修改' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='批量修改');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Batch edit' WHERE c.code='批量修改' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='批量修改');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hoạt động hàng loạt', c.remarks='[待审]批量操作' WHERE c.code='批量操作' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='批量操作');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Batch operations' WHERE c.code='批量操作' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='批量操作');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Kết quả xổ số', c.remarks='[待审]抽奖结果' WHERE c.code='抽奖结果' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='抽奖结果');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Lottery results' WHERE c.code='抽奖结果' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='抽奖结果');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Giới thiệu về chia sẻ nhóm', c.remarks='[待审]拼团简介' WHERE c.code='拼团简介' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='拼团简介');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Introduction to group sharing' WHERE c.code='拼团简介' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='拼团简介');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhấn thời gian đặt hàng', c.remarks='[待审]按下单时间' WHERE c.code='按下单时间' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='按下单时间');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Press order time' WHERE c.code='按下单时间' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='按下单时间');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Theo phương thức thanh toán', c.remarks='[待审]按支付方式' WHERE c.code='按支付方式' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='按支付方式');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='By payment method' WHERE c.code='按支付方式' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='按支付方式');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Theo kiểu trả về', c.remarks='[待审]按退货类型' WHERE c.code='按退货类型' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='按退货类型');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='By return type' WHERE c.code='按退货类型' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='按退货类型');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhắc nhở ủy quyền', c.remarks='[待审]授权提醒' WHERE c.code='授权提醒' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='授权提醒');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Authorization reminder' WHERE c.code='授权提醒' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='授权提醒');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='người quảng bá', c.remarks='[待审]推广人' WHERE c.code='推广人' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='推广人');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='promoter' WHERE c.code='推广人' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='推广人');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hoa hồng khuyến mại', c.remarks='[待审]推广佣金' WHERE c.code='推广佣金' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='推广佣金');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Promotional commission' WHERE c.code='推广佣金' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='推广佣金');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Gửi thành công', c.remarks='[待审]提交成功' WHERE c.code='提交成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提交成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Submission successful' WHERE c.code='提交成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提交成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Cung cấp giao diện lấy người dùng làm trung tâm dễ nhận biết', c.remarks='[待审]提供具有辨识度的用户中心界面' WHERE c.code='提供具有辨识度的用户中心界面' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提供具有辨识度的用户中心界面');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Provide a recognizable user-centered interface' WHERE c.code='提供具有辨识度的用户中心界面' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提供具有辨识度的用户中心界面');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Rút tiền', c.remarks='[待审]提现中' WHERE c.code='提现中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Withdrawing' WHERE c.code='提现中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Rút tiền để cân bằng', c.remarks='[待审]提现到余额' WHERE c.code='提现到余额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现到余额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Withdraw to balance' WHERE c.code='提现到余额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现到余额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Khi số dư đã được rút, số dư sẽ không thể được chuyển ra ngoài nữa. Vui lòng xác nhận xem số tiền rút có vào số dư hay không.', c.remarks='[待审]提现到余额后无法再次转出，确认是否提现到余额' WHERE c.code='提现到余额后无法再次转出，确认是否提现到余额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现到余额后无法再次转出，确认是否提现到余额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Once the balance is withdrawn, it cannot be transferred out again. Please confirm whether the withdrawal is to the balance.' WHERE c.code='提现到余额后无法再次转出，确认是否提现到余额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现到余额后无法再次转出，确认是否提现到余额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Rút tiền để cân bằng thành công', c.remarks='[待审]提现到余额成功' WHERE c.code='提现到余额成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现到余额成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Withdraw to balance successfully' WHERE c.code='提现到余额成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现到余额成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phí rút tiền', c.remarks='[待审]提现手续费' WHERE c.code='提现手续费' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现手续费');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Withdrawal fee' WHERE c.code='提现手续费' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现手续费');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phí rút tiền:', c.remarks='[待审]提现手续费:' WHERE c.code='提现手续费:' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现手续费:');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Withdrawal fee:' WHERE c.code='提现手续费:' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现手续费:');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Rút tiền tối thiểu', c.remarks='[待审]提现最低' WHERE c.code='提现最低' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现最低');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Minimum withdrawal' WHERE c.code='提现最低' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现最低');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Số tiền rút không thể cao hơn 500', c.remarks='[待审]提现金额不能高于500' WHERE c.code='提现金额不能高于500' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现金额不能高于500');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The withdrawal amount cannot be higher than 500' WHERE c.code='提现金额不能高于500' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='提现金额不能高于500');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thao tác không thành công', c.remarks='[待审]操作失败' WHERE c.code='操作失败' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='操作失败');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Operation failed' WHERE c.code='操作失败' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='操作失败');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Mẹo vận hành', c.remarks='[待审]操作提示' WHERE c.code='操作提示' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='操作提示');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Operation tips' WHERE c.code='操作提示' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='操作提示');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thanh toán còn lại', c.remarks='[待审]支付剩余' WHERE c.code='支付剩余' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='支付剩余');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Pay remaining' WHERE c.code='支付剩余' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='支付剩余');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thanh toán không thành công:', c.remarks='[待审]支付失败：' WHERE c.code='支付失败：' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='支付失败：');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Payment failed:' WHERE c.code='支付失败：' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='支付失败：');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đã hủy thanh toán', c.remarks='[待审]支付已取消' WHERE c.code='支付已取消' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='支付已取消');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Payment canceled' WHERE c.code='支付已取消' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='支付已取消');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='thời gian thanh toán', c.remarks='[待审]支付时间' WHERE c.code='支付时间' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='支付时间');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='payment time' WHERE c.code='支付时间' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='支付时间');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='chấp nhận món quà', c.remarks='[待审]收下礼物' WHERE c.code='收下礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收下礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='accept the gift' WHERE c.code='收下礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收下礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bốn chữ số cuối của số điện thoại di động của người nhận hoặc người gửi', c.remarks='[待审]收件人或寄件人手机号后四位' WHERE c.code='收件人或寄件人手机号后四位' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收件人或寄件人手机号后四位');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The last four digits of the recipient’s or sender’s mobile phone number' WHERE c.code='收件人或寄件人手机号后四位' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收件人或寄件人手机号后四位');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='nhận được', c.remarks='[待审]收到' WHERE c.code='收到' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收到');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='receive' WHERE c.code='收到' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收到');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bộ sưu tập', c.remarks='[待审]收款' WHERE c.code='收款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Collection' WHERE c.code='收款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bộ sưu tập thành công', c.remarks='[待审]收款成功' WHERE c.code='收款成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收款成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Collection successful' WHERE c.code='收款成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收款成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phương thức thanh toán', c.remarks='[待审]收款方式' WHERE c.code='收款方式' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收款方式');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Payment method' WHERE c.code='收款方式' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收款方式');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhận thanh toán tới WeChat', c.remarks='[待审]收款至微信' WHERE c.code='收款至微信' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收款至微信');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Receive payment to WeChat' WHERE c.code='收款至微信' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收款至微信');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Số tiền thanh toán', c.remarks='[待审]收款金额' WHERE c.code='收款金额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收款金额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Payment amount' WHERE c.code='收款金额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收款金额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đóng cửa:', c.remarks='[待审]收盘：' WHERE c.code='收盘：' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收盘：');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Closing:' WHERE c.code='收盘：' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收盘：');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thu thập vật phẩm', c.remarks='[待审]收藏商品' WHERE c.code='收藏商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收藏商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Collect items' WHERE c.code='收藏商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='收藏商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hoàn tiền toàn bộ đơn hàng', c.remarks='[待审]整单退款' WHERE c.code='整单退款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='整单退款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Whole order refund' WHERE c.code='整单退款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='整单退款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phiếu giảm giá độc quyền cho người mới', c.remarks='[待审]新人专享优惠券' WHERE c.code='新人专享优惠券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新人专享优惠券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Exclusive coupons for newcomers' WHERE c.code='新人专享优惠券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新人专享优惠券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Quyền lợi dành riêng cho người mới', c.remarks='[待审]新人专享福利' WHERE c.code='新人专享福利' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新人专享福利');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Exclusive benefits for newcomers' WHERE c.code='新人专享福利' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新人专享福利');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Khu vực sản phẩm dành cho người mới', c.remarks='[待审]新人商品专区' WHERE c.code='新人商品专区' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新人商品专区');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Product area for newcomers' WHERE c.code='新人商品专区' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新人商品专区');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phong bì đỏ dành cho người mới', c.remarks='[待审]新人红包' WHERE c.code='新人红包' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新人红包');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Newbie red envelope' WHERE c.code='新人红包' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新人红包');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tải xuống phiên bản mới không thành công', c.remarks='[待审]新版本下载失败' WHERE c.code='新版本下载失败' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新版本下载失败');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='New version download failed' WHERE c.code='新版本下载失败' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新版本下载失败');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phiên bản mới đã được tải xuống. Bạn có muốn khởi động lại ứng dụng hiện tại không?', c.remarks='[待审]新版本已经下载好，是否重启当前应用？' WHERE c.code='新版本已经下载好，是否重启当前应用？' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新版本已经下载好，是否重启当前应用？');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The new version has been downloaded. Do you want to restart the current application?' WHERE c.code='新版本已经下载好，是否重启当前应用？' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新版本已经下载好，是否重启当前应用？');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Người dùng mới có thể đăng ký', c.remarks='[待审]新用户注册即可' WHERE c.code='新用户注册即可' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新用户注册即可');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='New users can register' WHERE c.code='新用户注册即可' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新用户注册即可');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Người dùng mới có thể kiếm điểm sau khi đăng ký', c.remarks='[待审]新用户注册后即可获得积分' WHERE c.code='新用户注册后即可获得积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新用户注册后即可获得积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='New users can earn points after registering' WHERE c.code='新用户注册后即可获得积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新用户注册后即可获得积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đăng ký người dùng mới để nhận điểm', c.remarks='[待审]新用户注册领积分' WHERE c.code='新用户注册领积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新用户注册领积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='New user registration to receive points' WHERE c.code='新用户注册领积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='新用户注册领积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='không có', c.remarks='[待审]无' WHERE c.code='无' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='无');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='none' WHERE c.code='无' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='无');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hôm qua', c.remarks='[待审]昨日' WHERE c.code='昨日' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='昨日');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='yesterday' WHERE c.code='昨日' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='昨日');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bạn có muốn xác nhận việc hủy bỏ lệnh này không?', c.remarks='[待审]是否确认核销该订单？' WHERE c.code='是否确认核销该订单？' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='是否确认核销该订单？');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Do you want to confirm the write-off of this order?' WHERE c.code='是否确认核销该订单？' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='是否确认核销该订单？');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chưa có phiếu giảm giá ~', c.remarks='[待审]暂无优惠券～' WHERE c.code='暂无优惠券～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无优惠券～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='No coupons yet ~' WHERE c.code='暂无优惠券～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无优惠券～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chưa có phân loại nào~', c.remarks='[待审]暂无分类～' WHERE c.code='暂无分类～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无分类～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='No classification yet~' WHERE c.code='暂无分类～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无分类～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chưa có sản phẩm nào Hãy nhìn vào cái gì khác ~', c.remarks='[待审]暂无商品，去看点别的吧～' WHERE c.code='暂无商品，去看点别的吧～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无商品，去看点别的吧～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='There are no products yet. Let’s look at something else~' WHERE c.code='暂无商品，去看点别的吧～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无商品，去看点别的吧～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chưa có sản phẩm nào ~', c.remarks='[待审]暂无商品～' WHERE c.code='暂无商品～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无商品～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='There are no products yet ~' WHERE c.code='暂无商品～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无商品～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chưa có dữ liệu~', c.remarks='[待审]暂无数据～' WHERE c.code='暂无数据～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无数据～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='No data yet~' WHERE c.code='暂无数据～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无数据～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chưa có thẻ nào ~', c.remarks='[待审]暂无标签～' WHERE c.code='暂无标签～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无标签～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='No tags yet ~' WHERE c.code='暂无标签～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无标签～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chưa có thông tin hậu cần', c.remarks='[待审]暂无物流信息' WHERE c.code='暂无物流信息' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无物流信息');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='No logistics information yet' WHERE c.code='暂无物流信息' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无物流信息');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chưa có thông tin người dùng ~', c.remarks='[待审]暂无用户信息～' WHERE c.code='暂无用户信息～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无用户信息～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='No user information yet~' WHERE c.code='暂无用户信息～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无用户信息～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chưa có đơn đặt hàng nào ~', c.remarks='[待审]暂无订单～' WHERE c.code='暂无订单～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无订单～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='No orders yet~' WHERE c.code='暂无订单～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无订单～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='không có bình luận', c.remarks='[待审]暂无评论' WHERE c.code='暂无评论' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无评论');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='no comments' WHERE c.code='暂无评论' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂无评论');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Cấp độ chưa được mở', c.remarks='[待审]暂未开启等级' WHERE c.code='暂未开启等级' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂未开启等级');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Level not yet opened' WHERE c.code='暂未开启等级' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂未开启等级');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chưa mở khóa', c.remarks='[待审]暂未解锁' WHERE c.code='暂未解锁' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂未解锁');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Not unlocked yet' WHERE c.code='暂未解锁' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='暂未解锁');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Ưu đãi khác', c.remarks='[待审]更多优惠' WHERE c.code='更多优惠' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='更多优惠');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='More offers' WHERE c.code='更多优惠' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='更多优惠');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Cập nhật mẹo', c.remarks='[待审]更新提示' WHERE c.code='更新提示' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='更新提示');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Update tips' WHERE c.code='更新提示' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='更新提示');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='thấp nhất:', c.remarks='[待审]最低：' WHERE c.code='最低：' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='最低：');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='lowest:' WHERE c.code='最低：' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='最低：');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Có thể đổi tối đa', c.remarks='[待审]最多可兑换' WHERE c.code='最多可兑换' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='最多可兑换');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Maximum redeemable' WHERE c.code='最多可兑换' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='最多可兑换');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thêm ít nhất 1 mục', c.remarks='[待审]最少添加 1 件商品' WHERE c.code='最少添加 1 件商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='最少添加 1 件商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Add at least 1 item' WHERE c.code='最少添加 1 件商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='最少添加 1 件商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Cao nhất:', c.remarks='[待审]最高：' WHERE c.code='最高：' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='最高：');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Highest:' WHERE c.code='最高：' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='最高：');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='mặt trăng', c.remarks='[待审]月' WHERE c.code='月' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='月');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='moon' WHERE c.code='月' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='月');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phục vụ', c.remarks='[待审]服务' WHERE c.code='服务' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='服务');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Serve' WHERE c.code='服务' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='服务');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thỏa thuận dịch vụ và quyền riêng tư', c.remarks='[待审]服务与隐私协议' WHERE c.code='服务与隐私协议' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='服务与隐私协议');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Service and Privacy Agreement' WHERE c.code='服务与隐私协议' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='服务与隐私协议');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bảo đảm dịch vụ', c.remarks='[待审]服务保障' WHERE c.code='服务保障' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='服务保障');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Service guarantee' WHERE c.code='服务保障' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='服务保障');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chưa đăng nhập', c.remarks='[待审]未登录' WHERE c.code='未登录' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='未登录');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Not logged in' WHERE c.code='未登录' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='未登录');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Xem bản đồ', c.remarks='[待审]查看地图' WHERE c.code='查看地图' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='查看地图');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='View map' WHERE c.code='查看地图' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='查看地图');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Xem thêm chi tiết hậu cần', c.remarks='[待审]查看更多物流详情' WHERE c.code='查看更多物流详情' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='查看更多物流详情');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='View more logistics details' WHERE c.code='查看更多物流详情' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='查看更多物流详情');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='xem quà tặng', c.remarks='[待审]查看礼物' WHERE c.code='查看礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='查看礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='view gifts' WHERE c.code='查看礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='查看礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Xem chi tiết quà tặng', c.remarks='[待审]查看礼物详情' WHERE c.code='查看礼物详情' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='查看礼物详情');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='View gift details' WHERE c.code='查看礼物详情' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='查看礼物详情');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhãn', c.remarks='[待审]标签' WHERE c.code='标签' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='标签');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Label' WHERE c.code='标签' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='标签');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Viết tắt', c.remarks='[待审]核销' WHERE c.code='核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Write off' WHERE c.code='核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Xóa các đơn đặt hàng khác', c.remarks='[待审]核销其他订单' WHERE c.code='核销其他订单' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='核销其他订单');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Write off other orders' WHERE c.code='核销其他订单' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='核销其他订单');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Xóa sổ thành công', c.remarks='[待审]核销成功' WHERE c.code='核销成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='核销成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Write-off successful' WHERE c.code='核销成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='核销成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hồ sơ xóa sổ', c.remarks='[待审]核销记录' WHERE c.code='核销记录' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='核销记录');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Write-off records' WHERE c.code='核销记录' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='核销记录');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='hạng hai', c.remarks='[待审]次' WHERE c.code='次' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='次');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Second-rate' WHERE c.code='次' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='次');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='mẫu', c.remarks='[待审]款' WHERE c.code='款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='options' WHERE c.code='款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đang tải...', c.remarks='[待审]正在加载...' WHERE c.code='正在加载...' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='正在加载...');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Loading...' WHERE c.code='正在加载...' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='正在加载...');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chỉ có thể gửi tối đa 100 mẩu dữ liệu mỗi lần', c.remarks='[待审]每次最多只提交100条数据' WHERE c.code='每次最多只提交100条数据' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='每次最多只提交100条数据');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Only a maximum of 100 pieces of data can be submitted each time' WHERE c.code='每次最多只提交100条数据' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='每次最多只提交100条数据');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Không còn nữa~', c.remarks='[待审]没有更多了～' WHERE c.code='没有更多了～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='没有更多了～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='No more~' WHERE c.code='没有更多了～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='没有更多了～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đăng ký thành công', c.remarks='[待审]注册成功' WHERE c.code='注册成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='注册成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Registration successful' WHERE c.code='注册成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='注册成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thời gian đăng ký', c.remarks='[待审]注册时间' WHERE c.code='注册时间' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='注册时间');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Registration time' WHERE c.code='注册时间' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='注册时间');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Các hoạt động và lợi ích, hãy tìm hiểu về chúng càng sớm càng tốt', c.remarks='[待审]活动福利，第一时间了解' WHERE c.code='活动福利，第一时间了解' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='活动福利，第一时间了解');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Activities and benefits, learn about them as soon as possible' WHERE c.code='活动福利，第一时间了解' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='活动福利，第一时间了解');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Duyệt qua', c.remarks='[待审]浏览' WHERE c.code='浏览' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='浏览');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Browse' WHERE c.code='浏览' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='浏览');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Số lượng mua hàng', c.remarks='[待审]消费笔数' WHERE c.code='消费笔数' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='消费笔数');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Number of purchases' WHERE c.code='消费笔数' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='消费笔数');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thêm sản phẩm', c.remarks='[待审]添加商品' WHERE c.code='添加商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='添加商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Add product' WHERE c.code='添加商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='添加商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thêm thẻ', c.remarks='[待审]添加标签' WHERE c.code='添加标签' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='添加标签');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Add tag' WHERE c.code='添加标签' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='添加标签');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Kích hoạt', c.remarks='[待审]激活中' WHERE c.code='激活中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='激活中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Activating' WHERE c.code='激活中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='激活中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Click để tìm kiếm tên', c.remarks='[待审]点击搜索名称' WHERE c.code='点击搜索名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='点击搜索名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Click to search name' WHERE c.code='点击搜索名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='点击搜索名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bấm vào để xem', c.remarks='[待审]点击查看' WHERE c.code='点击查看' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='点击查看');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Click to view' WHERE c.code='点击查看' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='点击查看');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhấn vào đây để thêm vào chương trình nhỏ của tôi', c.remarks='[待审]点击添加到我的小程序' WHERE c.code='点击添加到我的小程序' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='点击添加到我的小程序');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Click to add to my mini program' WHERE c.code='点击添加到我的小程序' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='点击添加到我的小程序');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bấm vào để đọc', c.remarks='[待审]点击阅读' WHERE c.code='点击阅读' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='点击阅读');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Click to read' WHERE c.code='点击阅读' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='点击阅读');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Số đơn hàng hậu cần', c.remarks='[待审]物流单号' WHERE c.code='物流单号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='物流单号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Logistics order number' WHERE c.code='物流单号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='物流单号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Điều tra hậu cần', c.remarks='[待审]物流查询' WHERE c.code='物流查询' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='物流查询');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Logistics inquiry' WHERE c.code='物流查询' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='物流查询');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chi tiết hậu cần', c.remarks='[待审]物流详情' WHERE c.code='物流详情' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='物流详情');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Logistics details' WHERE c.code='物流详情' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='物流详情');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Dùng để điền thông tin thành viên', c.remarks='[待审]用于完善会员资料' WHERE c.code='用于完善会员资料' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用于完善会员资料');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Used to complete member information' WHERE c.code='用于完善会员资料' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用于完善会员资料');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='người dùng', c.remarks='[待审]用户' WHERE c.code='用户' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='user' WHERE c.code='用户' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='ID người dùng', c.remarks='[待审]用户ID' WHERE c.code='用户ID' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户ID');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='User ID' WHERE c.code='用户ID' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户ID');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thông tin người dùng', c.remarks='[待审]用户信息' WHERE c.code='用户信息' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户信息');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='User information' WHERE c.code='用户信息' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户信息');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thỏa thuận người dùng', c.remarks='[待审]用户协议' WHERE c.code='用户协议' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户协议');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='User Agreement' WHERE c.code='用户协议' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户协议');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhận xét của người dùng', c.remarks='[待审]用户备注' WHERE c.code='用户备注' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户备注');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='User remarks' WHERE c.code='用户备注' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户备注');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Người dùng đã thanh toán và cần bạn vận chuyển hàng càng sớm càng tốt ~', c.remarks='[待审]用户已付款，需要您尽快发货哦～' WHERE c.code='用户已付款，需要您尽快发货哦～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户已付款，需要您尽快发货哦～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The user has paid and needs you to ship the goods as soon as possible~' WHERE c.code='用户已付款，需要您尽快发货哦～' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户已付款，需要您尽快发货哦～');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Biệt hiệu của người dùng', c.remarks='[待审]用户昵称' WHERE c.code='用户昵称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户昵称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='User nickname' WHERE c.code='用户昵称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户昵称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Quản lý người dùng', c.remarks='[待审]用户管理' WHERE c.code='用户管理' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户管理');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='User management' WHERE c.code='用户管理' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户管理');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chi tiết người dùng', c.remarks='[待审]用户详情' WHERE c.code='用户详情' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户详情');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='User details' WHERE c.code='用户详情' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='用户详情');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nền tảng cung cấp cho bạn dịch vụ giao hàng', c.remarks='[待审]由平台为您提供配送服务' WHERE c.code='由平台为您提供配送服务' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='由平台为您提供配送服务');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The platform provides you with delivery services' WHERE c.code='由平台为您提供配送服务' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='由平台为您提供配送服务');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Áp dụng', c.remarks='[待审]申请' WHERE c.code='申请' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='申请');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Apply' WHERE c.code='申请' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='申请');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Số lượng ứng dụng', c.remarks='[待审]申请件数' WHERE c.code='申请件数' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='申请件数');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Number of applications' WHERE c.code='申请件数' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='申请件数');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Áp dụng cho hình ảnh', c.remarks='[待审]申请图片' WHERE c.code='申请图片' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='申请图片');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Apply for pictures' WHERE c.code='申请图片' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='申请图片');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Lý do ứng dụng', c.remarks='[待审]申请理由' WHERE c.code='申请理由' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='申请理由');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Reasons for application' WHERE c.code='申请理由' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='申请理由');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hồ sơ ứng tuyển', c.remarks='[待审]申请记录' WHERE c.code='申请记录' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='申请记录');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Application record' WHERE c.code='申请记录' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='申请记录');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='tin nhắn', c.remarks='[待审]留言' WHERE c.code='留言' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='留言');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='message' WHERE c.code='留言' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='留言');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đăng nhập và đăng ký yêu cầu ràng buộc số điện thoại di động', c.remarks='[待审]登录注册需绑定手机号' WHERE c.code='登录注册需绑定手机号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='登录注册需绑定手机号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Login and registration require binding mobile phone number' WHERE c.code='登录注册需绑定手机号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='登录注册需绑定手机号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='quà', c.remarks='[待审]的礼物' WHERE c.code='的礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='的礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='gift' WHERE c.code='的礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='的礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phát sóng trực tiếp', c.remarks='[待审]直播中' WHERE c.code='直播中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='直播中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Live broadcast' WHERE c.code='直播中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='直播中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='biết', c.remarks='[待审]知道了' WHERE c.code='知道了' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='知道了');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='knew' WHERE c.code='知道了' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='知道了');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bạn có chắc chắn muốn xóa nó?', c.remarks='[待审]确定删除吗？' WHERE c.code='确定删除吗？' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='确定删除吗？');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Are you sure you want to delete it?' WHERE c.code='确定删除吗？' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='确定删除吗？');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Xác nhận đơn hàng đã được người dùng thanh toán', c.remarks='[待审]确认该订单用户已付款' WHERE c.code='确认该订单用户已付款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='确认该订单用户已付款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Confirm that the order has been paid by the user' WHERE c.code='确认该订单用户已付款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='确认该订单用户已付款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='phụ phí quà tặng', c.remarks='[待审]礼品附加费' WHERE c.code='礼品附加费' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼品附加费');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='gift surcharge' WHERE c.code='礼品附加费' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼品附加费');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phụ phí quà tặng', c.remarks='[待审]礼品附加费用' WHERE c.code='礼品附加费用' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼品附加费用');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Gift surcharge' WHERE c.code='礼品附加费用' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼品附加费用');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Quà tặng đã hết hạn', c.remarks='[待审]礼物已失效' WHERE c.code='礼物已失效' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼物已失效');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The gift has expired' WHERE c.code='礼物已失效' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼物已失效');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Món quà đã được nhận', c.remarks='[待审]礼物已被领取' WHERE c.code='礼物已被领取' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼物已被领取');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The gift has been received' WHERE c.code='礼物已被领取' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼物已被领取');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Món quà không được tặng', c.remarks='[待审]礼物未赠送' WHERE c.code='礼物未赠送' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼物未赠送');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Gift not given' WHERE c.code='礼物未赠送' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼物未赠送');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chi tiết quà tặng', c.remarks='[待审]礼物详情' WHERE c.code='礼物详情' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼物详情');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Gift details' WHERE c.code='礼物详情' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼物详情');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đã nhận quà thành công', c.remarks='[待审]礼物领取成功' WHERE c.code='礼物领取成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼物领取成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Gift received successfully' WHERE c.code='礼物领取成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='礼物领取成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='giá bán chớp nhoáng', c.remarks='[待审]秒杀价' WHERE c.code='秒杀价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='秒杀价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='flash sale price' WHERE c.code='秒杀价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='秒杀价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Số tiền trừ điểm', c.remarks='[待审]积分抵扣金额' WHERE c.code='积分抵扣金额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='积分抵扣金额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Points deduction amount' WHERE c.code='积分抵扣金额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='积分抵扣金额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Được trả tiền ngay lập tức', c.remarks='[待审]立即收款' WHERE c.code='立即收款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='立即收款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Get paid immediately' WHERE c.code='立即收款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='立即收款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hãy thử ngay bây giờ', c.remarks='[待审]立即试用' WHERE c.code='立即试用' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='立即试用');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Try it now' WHERE c.code='立即试用' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='立即试用');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đang chờ thanh toán', c.remarks='[待审]等待支付中' WHERE c.code='等待支付中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='等待支付中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Waiting for payment' WHERE c.code='等待支付中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='等待支付中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='cấp', c.remarks='[待审]等级' WHERE c.code='等级' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='等级');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='grade' WHERE c.code='等级' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='等级');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='lọc', c.remarks='[待审]筛选' WHERE c.code='筛选' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='筛选');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='filter' WHERE c.code='筛选' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='筛选');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chức năng đăng nhập đã đóng', c.remarks='[待审]签到功能已关闭' WHERE c.code='签到功能已关闭' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='签到功能已关闭');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Sign-in function is closed' WHERE c.code='签到功能已关闭' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='签到功能已关闭');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Lời nhắc đăng ký', c.remarks='[待审]签到提醒' WHERE c.code='签到提醒' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='签到提醒');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Check-in reminder' WHERE c.code='签到提醒' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='签到提醒');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đăng nhập và nhận ngay', c.remarks='[待审]签到立即获取' WHERE c.code='签到立即获取' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='签到立即获取');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Sign in and get it now' WHERE c.code='签到立即获取' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='签到立即获取');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Danh mục nổi bật', c.remarks='[待审]精选类目' WHERE c.code='精选类目' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='精选类目');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Featured categories' WHERE c.code='精选类目' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='精选类目');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Lệnh khuyến mãi tích lũy', c.remarks='[待审]累计推广订单' WHERE c.code='累计推广订单' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='累计推广订单');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Cumulative promotion orders' WHERE c.code='累计推广订单' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='累计推广订单');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đặt hàng trực tuyến và nhận hàng tại cửa hàng', c.remarks='[待审]线上下单，到店自提' WHERE c.code='线上下单，到店自提' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='线上下单，到店自提');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Order online and pick up in store' WHERE c.code='线上下单，到店自提' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='线上下单，到店自提');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chi tiết giá trị trải nghiệm', c.remarks='[待审]经验值明细' WHERE c.code='经验值明细' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='经验值明细');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Experience value details' WHERE c.code='经验值明细' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='经验值明细');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tiếp tục viết tắt', c.remarks='[待审]继续核销' WHERE c.code='继续核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='继续核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Continue writing off' WHERE c.code='继续核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='继续核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chỉnh sửa hóa đơn', c.remarks='[待审]编辑发票' WHERE c.code='编辑发票' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='编辑发票');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Edit invoice' WHERE c.code='编辑发票' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='编辑发票');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhận biệt hiệu và hình đại diện của bạn', c.remarks='[待审]获取您的昵称、头像' WHERE c.code='获取您的昵称、头像' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='获取您的昵称、头像');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Get your nickname and avatar' WHERE c.code='获取您的昵称、头像' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='获取您的昵称、头像');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhận số điện thoại di động', c.remarks='[待审]获取手机号' WHERE c.code='获取手机号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='获取手机号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Get mobile phone number' WHERE c.code='获取手机号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='获取手机号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhận ủy quyền số điện thoại di động', c.remarks='[待审]获取手机号授权' WHERE c.code='获取手机号授权' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='获取手机号授权');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Obtain mobile phone number authorization' WHERE c.code='获取手机号授权' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='获取手机号授权');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='trang trí', c.remarks='[待审]装饰' WHERE c.code='装饰' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='装饰');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='decorate' WHERE c.code='装饰' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='装饰');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Quy cách', c.remarks='[待审]规格' WHERE c.code='规格' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='规格');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Spec' WHERE c.code='规格' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='规格');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tên đặc điểm kỹ thuật', c.remarks='[待审]规格名称' WHERE c.code='规格名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='规格名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Specification name' WHERE c.code='规格名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='规格名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thông số kỹ thuật', c.remarks='[待审]规格设置' WHERE c.code='规格设置' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='规格设置');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Specifications' WHERE c.code='规格设置' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='规格设置');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='thời gian rã đông', c.remarks='[待审]解冻时间' WHERE c.code='解冻时间' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='解冻时间');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Thawing time' WHERE c.code='解冻时间' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='解冻时间');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='danh sách đặt hàng', c.remarks='[待审]订单列表' WHERE c.code='订单列表' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='订单列表');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='order list' WHERE c.code='订单列表' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='订单列表');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đặt hàng thanh toán thực tế', c.remarks='[待审]订单实付' WHERE c.code='订单实付' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='订单实付');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Order actual payment' WHERE c.code='订单实付' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='订单实付');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chi tiết đặt hàng', c.remarks='[待审]订单详情' WHERE c.code='订单详情' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='订单详情');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Order details' WHERE c.code='订单详情' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='订单详情');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Sản phẩm này đã được gỡ bỏ khỏi kệ', c.remarks='[待审]该商品已下架' WHERE c.code='该商品已下架' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='该商品已下架');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='This product has been removed from the shelves' WHERE c.code='该商品已下架' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='该商品已下架');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đơn hàng vẫn còn những hạng mục khác cần được xóa', c.remarks='[待审]该订单仍有其他待核销商品' WHERE c.code='该订单仍有其他待核销商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='该订单仍有其他待核销商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The order still has other items to be written off' WHERE c.code='该订单仍有其他待核销商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='该订单仍有其他待核销商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng tải lên hình ảnh sản phẩm', c.remarks='[待审]请上传商品图片' WHERE c.code='请上传商品图片' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请上传商品图片');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please upload product pictures' WHERE c.code='请上传商品图片' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请上传商品图片');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng tải lên hình đại diện', c.remarks='[待审]请上传头像' WHERE c.code='请上传头像' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请上传头像');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please upload avatar' WHERE c.code='请上传头像' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请上传头像');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhấp vào [', c.remarks='[待审]请依次点击 [' WHERE c.code='请依次点击 [' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请依次点击 [');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please click [' WHERE c.code='请依次点击 [' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请依次点击 [');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhấp vào [', c.remarks='[待审]请依次点击【' WHERE c.code='请依次点击【' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请依次点击【');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please click [' WHERE c.code='请依次点击【' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请依次点击【');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng xóa applet hiện tại và khởi động lại tìm kiếm để mở...', c.remarks='[待审]请删除当前小程序，重启搜索打开...' WHERE c.code='请删除当前小程序，重启搜索打开...' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请删除当前小程序，重启搜索打开...');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please delete the current applet and restart the search to open...' WHERE c.code='请删除当前小程序，重启搜索打开...' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请删除当前小程序，重启搜索打开...');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng thêm người giao hàng vào nền tảng', c.remarks='[待审]请在平台后台添加送货人' WHERE c.code='请在平台后台添加送货人' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请在平台后台添加送货人');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please add the delivery person in the platform background' WHERE c.code='请在平台后台添加送货人' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请在平台后台添加送货人');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền số dư bạn muốn tăng hoặc giảm', c.remarks='[待审]请填写你要增加或减少的余额' WHERE c.code='请填写你要增加或减少的余额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写你要增加或减少的余额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the balance you want to increase or decrease' WHERE c.code='请填写你要增加或减少的余额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写你要增加或减少的余额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hãy điền vào những điểm bạn muốn tăng hoặc giảm', c.remarks='[待审]请填写你要增加或减少的积分' WHERE c.code='请填写你要增加或减少的积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写你要增加或减少的积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the points you want to increase or decrease' WHERE c.code='请填写你要增加或减少的积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写你要增加或减少的积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền vào đơn vị', c.remarks='[待审]请填写单位' WHERE c.code='请填写单位' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写单位');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the unit' WHERE c.code='请填写单位' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写单位');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền giá gốc', c.remarks='[待审]请填写原价' WHERE c.code='请填写原价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写原价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the original price' WHERE c.code='请填写原价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写原价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền giá bán', c.remarks='[待审]请填写售价' WHERE c.code='请填写售价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写售价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the selling price' WHERE c.code='请填写售价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写售价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền giá gạch chân của sản phẩm', c.remarks='[待审]请填写商品划线价' WHERE c.code='请填写商品划线价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写商品划线价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the underlined price of the product' WHERE c.code='请填写商品划线价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写商品划线价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền đơn vị sản phẩm', c.remarks='[待审]请填写商品单位' WHERE c.code='请填写商品单位' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写商品单位');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the product unit' WHERE c.code='请填写商品单位' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写商品单位');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền tên sản phẩm', c.remarks='[待审]请填写商品名称' WHERE c.code='请填写商品名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写商品名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the product name' WHERE c.code='请填写商品名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写商品名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền giá bán sản phẩm', c.remarks='[待审]请填写商品售价' WHERE c.code='请填写商品售价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写商品售价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the product selling price' WHERE c.code='请填写商品售价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写商品售价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền vào kho sản phẩm', c.remarks='[待审]请填写商品库存' WHERE c.code='请填写商品库存' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写商品库存');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the product inventory' WHERE c.code='请填写商品库存' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写商品库存');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền giá thành sản phẩm', c.remarks='[待审]请填写商品成本价' WHERE c.code='请填写商品成本价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写商品成本价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the cost price of the product' WHERE c.code='请填写商品成本价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写商品成本价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền mã xác minh hình ảnh', c.remarks='[待审]请填写图片验证码' WHERE c.code='请填写图片验证码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写图片验证码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the image verification code' WHERE c.code='请填写图片验证码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写图片验证码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền tên của bạn', c.remarks='[待审]请填写姓名' WHERE c.code='请填写姓名' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写姓名');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in your name' WHERE c.code='请填写姓名' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写姓名');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền địa chỉ người gửi', c.remarks='[待审]请填写寄件人地址' WHERE c.code='请填写寄件人地址' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写寄件人地址');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the sender''s address' WHERE c.code='请填写寄件人地址' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写寄件人地址');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền tên người gửi', c.remarks='[待审]请填写寄件人姓名' WHERE c.code='请填写寄件人姓名' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写寄件人姓名');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the sender''s name' WHERE c.code='请填写寄件人姓名' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写寄件人姓名');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền số điện thoại di động của người gửi', c.remarks='[待审]请填写寄件人手机号码' WHERE c.code='请填写寄件人手机号码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写寄件人手机号码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the sender’s mobile phone number' WHERE c.code='请填写寄件人手机号码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写寄件人手机号码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền vào kho', c.remarks='[待审]请填写库存' WHERE c.code='请填写库存' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写库存');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the inventory' WHERE c.code='请填写库存' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写库存');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền số chuyển phát nhanh', c.remarks='[待审]请填写快递单号' WHERE c.code='请填写快递单号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写快递单号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the express delivery number' WHERE c.code='请填写快递单号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写快递单号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền tên thật của bạn', c.remarks='[待审]请填写您的真实姓名' WHERE c.code='请填写您的真实姓名' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写您的真实姓名');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in your real name' WHERE c.code='请填写您的真实姓名' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写您的真实姓名');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền giá thành', c.remarks='[待审]请填写成本价' WHERE c.code='请填写成本价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写成本价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the cost price' WHERE c.code='请填写成本价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写成本价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền số Alipay của bạn', c.remarks='[待审]请填写支付宝号' WHERE c.code='请填写支付宝号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写支付宝号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in your Alipay number' WHERE c.code='请填写支付宝号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写支付宝号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền tên thật ràng buộc với Alipay', c.remarks='[待审]请填写支付宝绑定的真实姓名' WHERE c.code='请填写支付宝绑定的真实姓名' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写支付宝绑定的真实姓名');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the real name bound to Alipay' WHERE c.code='请填写支付宝绑定的真实姓名' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写支付宝绑定的真实姓名');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng điền thời hạn hiệu lực', c.remarks='[待审]请填写有效时长' WHERE c.code='请填写有效时长' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写有效时长');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please fill in the validity period' WHERE c.code='请填写有效时长' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请填写有效时长');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng hoàn tất xác minh bảo mật', c.remarks='[待审]请完成安全验证' WHERE c.code='请完成安全验证' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请完成安全验证');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please complete the security verification' WHERE c.code='请完成安全验证' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请完成安全验证');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng kích hoạt kết nối mạng', c.remarks='[待审]请开启网络连接' WHERE c.code='请开启网络连接' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请开启网络连接');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enable network connection' WHERE c.code='请开启网络连接' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请开启网络连接');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng ủy quyền cho avatar và các thông tin khác của bạn để cung cấp cho bạn dịch vụ tốt hơn', c.remarks='[待审]请授权头像等信息，以便为您提供更好的服务' WHERE c.code='请授权头像等信息，以便为您提供更好的服务' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请授权头像等信息，以便为您提供更好的服务');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please authorize your avatar and other information to provide you with better services' WHERE c.code='请授权头像等信息，以便为您提供更好的服务' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请授权头像等信息，以便为您提供更好的服务');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng bấm vào để đăng nhập', c.remarks='[待审]请点击登录' WHERE c.code='请点击登录' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请点击登录');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please click to log in' WHERE c.code='请点击登录' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请点击登录');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập tên phiếu giảm giá', c.remarks='[待审]请输入优惠券名称' WHERE c.code='请输入优惠券名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入优惠券名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter the coupon name' WHERE c.code='请输入优惠券名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入优惠券名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập âm lượng', c.remarks='[待审]请输入体积' WHERE c.code='请输入体积' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入体积');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter volume' WHERE c.code='请输入体积' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入体积');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập tên nhà phân phối', c.remarks='[待审]请输入分销员姓名' WHERE c.code='请输入分销员姓名' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入分销员姓名');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter the distributor''s name' WHERE c.code='请输入分销员姓名' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入分销员姓名');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập giá bị gạch chéo', c.remarks='[待审]请输入划线价' WHERE c.code='请输入划线价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入划线价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter the crossed-out price' WHERE c.code='请输入划线价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入划线价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập giá bán', c.remarks='[待审]请输入售价' WHERE c.code='请输入售价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入售价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter the selling price' WHERE c.code='请输入售价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入售价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập tên sản phẩm', c.remarks='[待审]请输入商品名称' WHERE c.code='请输入商品名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入商品名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter product name' WHERE c.code='请输入商品名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入商品名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập tên/ID sản phẩm', c.remarks='[待审]请输入商品名称/ID' WHERE c.code='请输入商品名称/ID' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入商品名称/ID');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter product name/ID' WHERE c.code='请输入商品名称/ID' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入商品名称/ID');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập mã sản phẩm', c.remarks='[待审]请输入商品编码' WHERE c.code='请输入商品编码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入商品编码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter product code' WHERE c.code='请输入商品编码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入商品编码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập bưu phí cố định', c.remarks='[待审]请输入固定邮费' WHERE c.code='请输入固定邮费' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入固定邮费');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter fixed postage' WHERE c.code='请输入固定邮费' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入固定邮费');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập hàng tồn kho', c.remarks='[待审]请输入库存' WHERE c.code='请输入库存' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入库存');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter inventory' WHERE c.code='请输入库存' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入库存');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập giá thành', c.remarks='[待审]请输入成本价' WHERE c.code='请输入成本价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入成本价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter cost price' WHERE c.code='请输入成本价' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入成本价');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập số tiền rút', c.remarks='[待审]请输入提现金额' WHERE c.code='请输入提现金额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入提现金额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter the withdrawal amount' WHERE c.code='请输入提现金额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入提现金额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập thời lượng', c.remarks='[待审]请输入时长' WHERE c.code='请输入时长' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入时长');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter duration' WHERE c.code='请输入时长' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入时长');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập biệt hiệu', c.remarks='[待审]请输入昵称' WHERE c.code='请输入昵称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入昵称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter a nickname' WHERE c.code='请输入昵称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入昵称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập mã vạch', c.remarks='[待审]请输入条形码' WHERE c.code='请输入条形码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入条形码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter barcode' WHERE c.code='请输入条形码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入条形码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập số đơn hàng hậu cần', c.remarks='[待审]请输入物流单号' WHERE c.code='请输入物流单号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入物流单号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter the logistics order number' WHERE c.code='请输入物流单号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入物流单号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập số điện thoại di động của người dùng/biệt danh người dùng/số đơn hàng/tên sản phẩm', c.remarks='[待审]请输入用户手机号/用户昵称/订单号/商品名称' WHERE c.code='请输入用户手机号/用户昵称/订单号/商品名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入用户手机号/用户昵称/订单号/商品名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter user mobile phone number/user nickname/order number/product name' WHERE c.code='请输入用户手机号/用户昵称/订单号/商品名称' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入用户手机号/用户昵称/订单号/商品名称');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập biệt hiệu/ID người dùng', c.remarks='[待审]请输入用户昵称/ID' WHERE c.code='请输入用户昵称/ID' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入用户昵称/ID');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter user nickname/ID' WHERE c.code='请输入用户昵称/ID' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入用户昵称/ID');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập lý do ứng tuyển', c.remarks='[待审]请输入申请理由' WHERE c.code='请输入申请理由' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入申请理由');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter the reason for application' WHERE c.code='请输入申请理由' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入申请理由');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập thứ tự bạn muốn truy vấn', c.remarks='[待审]请输入要查询的订单' WHERE c.code='请输入要查询的订单' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入要查询的订单');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter the order you want to query' WHERE c.code='请输入要查询的订单' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入要查询的订单');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập mã thông số kỹ thuật', c.remarks='[待审]请输入规格编码' WHERE c.code='请输入规格编码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入规格编码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter the specification code' WHERE c.code='请输入规格编码' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入规格编码');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập mã đơn hàng/mã đơn hàng/ID người dùng/số điện thoại di động', c.remarks='[待审]请输入订单号/售后单号/用户ID/手机号' WHERE c.code='请输入订单号/售后单号/用户ID/手机号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入订单号/售后单号/用户ID/手机号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter the order number/sales order number/user ID/mobile phone number' WHERE c.code='请输入订单号/售后单号/用户ID/手机号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入订单号/售后单号/用户ID/手机号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng nhập trọng lượng', c.remarks='[待审]请输入重量' WHERE c.code='请输入重量' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入重量');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please enter weight' WHERE c.code='请输入重量' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请输入重量');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng chọn một danh mục', c.remarks='[待审]请选择分类' WHERE c.code='请选择分类' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择分类');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please select a category' WHERE c.code='请选择分类' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择分类');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng chọn xóa sản phẩm', c.remarks='[待审]请选择删除商品' WHERE c.code='请选择删除商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择删除商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please choose to delete the product' WHERE c.code='请选择删除商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择删除商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng chọn sản phẩm cần vận chuyển', c.remarks='[待审]请选择发货商品' WHERE c.code='请选择发货商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择发货商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please select the product to be shipped' WHERE c.code='请选择发货商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择发货商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng chọn danh mục sản phẩm', c.remarks='[待审]请选择商品分类' WHERE c.code='请选择商品分类' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择商品分类');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please select a product category' WHERE c.code='请选择商品分类' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择商品分类');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng chọn thông số kỹ thuật sản phẩm', c.remarks='[待审]请选择商品规格' WHERE c.code='请选择商品规格' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择商品规格');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please select product specifications' WHERE c.code='请选择商品规格' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择商品规格');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng chọn thứ tự xóa nợ hiện tại', c.remarks='[待审]请选择当前核销订单' WHERE c.code='请选择当前核销订单' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择当前核销订单');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please select the current write-off order' WHERE c.code='请选择当前核销订单' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择当前核销订单');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hãy chọn sản phẩm yêu thích', c.remarks='[待审]请选择收藏商品' WHERE c.code='请选择收藏商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择收藏商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please select favorite products' WHERE c.code='请选择收藏商品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择收藏商品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng chọn người dùng', c.remarks='[待审]请选择用户' WHERE c.code='请选择用户' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择用户');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please select user' WHERE c.code='请选择用户' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择用户');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Hãy chọn thứ tự cần xóa', c.remarks='[待审]请选择要核销的订单' WHERE c.code='请选择要核销的订单' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择要核销的订单');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please select the order to be written off' WHERE c.code='请选择要核销的订单' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择要核销的订单');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng chọn mẫu vận chuyển hàng hóa', c.remarks='[待审]请选择运费模版' WHERE c.code='请选择运费模版' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择运费模版');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please select a freight template' WHERE c.code='请选择运费模版' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择运费模版');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng chọn cài đặt vận chuyển', c.remarks='[待审]请选择运费设置' WHERE c.code='请选择运费设置' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择运费设置');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please select shipping settings' WHERE c.code='请选择运费设置' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择运费设置');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng chọn phương thức vận chuyển', c.remarks='[待审]请选择配送方式' WHERE c.code='请选择配送方式' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择配送方式');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please select a shipping method' WHERE c.code='请选择配送方式' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请选择配送方式');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Vui lòng đọc và đồng ý với Thỏa thuận Nhà phân phối', c.remarks='[待审]请阅读并同意分销员协议' WHERE c.code='请阅读并同意分销员协议' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请阅读并同意分销员协议');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Please read and agree to the Distributor Agreement' WHERE c.code='请阅读并同意分销员协议' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='请阅读并同意分销员协议');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Điều chỉnh thời lượng', c.remarks='[待审]调整时长' WHERE c.code='调整时长' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='调整时长');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Adjust duration' WHERE c.code='调整时长' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='调整时长');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Mua', c.remarks='[待审]购买' WHERE c.code='购买' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='购买');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Buy' WHERE c.code='购买' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='购买');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thông tin tài sản', c.remarks='[待审]资产信息' WHERE c.code='资产信息' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='资产信息');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Asset information' WHERE c.code='资产信息' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='资产信息');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='quà tặng', c.remarks='[待审]赠品' WHERE c.code='赠品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='赠品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='giveaway' WHERE c.code='赠品' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='赠品');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Quà tặng thành viên', c.remarks='[待审]赠送会员' WHERE c.code='赠送会员' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='赠送会员');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Gift membership' WHERE c.code='赠送会员' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='赠送会员');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tặng điểm', c.remarks='[待审]赠送积分' WHERE c.code='赠送积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='赠送积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Give away points' WHERE c.code='赠送积分' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='赠送积分');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tặng một người bạn một món quà', c.remarks='[待审]赠送给好友一份礼物' WHERE c.code='赠送给好友一份礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='赠送给好友一份礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Give a friend a gift' WHERE c.code='赠送给好友一份礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='赠送给好友一份礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='mua tối thiểu', c.remarks='[待审]起购' WHERE c.code='起购' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='起购');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Minimum purchase' WHERE c.code='起购' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='起购');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Ưu đãi lớn, thời gian có hạn', c.remarks='[待审]超值优惠 限时专享' WHERE c.code='超值优惠 限时专享' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='超值优惠 限时专享');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Great deals, limited time only' WHERE c.code='超值优惠 限时专享' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='超值优惠 限时专享');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='khoảng cách kết thúc', c.remarks='[待审]距离结束' WHERE c.code='距离结束' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='距离结束');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='distance ends' WHERE c.code='距离结束' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='距离结束');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='số CMND', c.remarks='[待审]身份证号' WHERE c.code='身份证号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='身份证号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='ID number' WHERE c.code='身份证号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='身份证号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Quá trình chuyển đã hết hạn, vui lòng thử lại', c.remarks='[待审]转账已失效,请从重新发起' WHERE c.code='转账已失效,请从重新发起' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='转账已失效,请从重新发起');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='The transfer has expired, please try again' WHERE c.code='转账已失效,请从重新发起' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='转账已失效,请从重新发起');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Mẫu vận chuyển hàng hóa', c.remarks='[待审]运费模板' WHERE c.code='运费模板' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='运费模板');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Freight Template' WHERE c.code='运费模板' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='运费模板');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Quay lại danh sách', c.remarks='[待审]返回列表' WHERE c.code='返回列表' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='返回列表');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Return to list' WHERE c.code='返回列表' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='返回列表');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Quay lại trang chủ trung tâm mua sắm', c.remarks='[待审]返回商城首页' WHERE c.code='返回商城首页' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='返回商城首页');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Return to the mall homepage' WHERE c.code='返回商城首页' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='返回商城首页');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Quay trở lại bàn làm việc', c.remarks='[待审]返回工作台' WHERE c.code='返回工作台' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='返回工作台');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Return to workbench' WHERE c.code='返回工作台' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='返回工作台');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đây là một cửa sổ bật lên phương thức!', c.remarks='[待审]这是一个模态弹窗!' WHERE c.code='这是一个模态弹窗!' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='这是一个模态弹窗!');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='This is a modal popup!' WHERE c.code='这是一个模态弹窗!' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='这是一个模态弹窗!');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đây là một món quà dành cho bạn ~', c.remarks='[待审]这是送您的一份礼物~' WHERE c.code='这是送您的一份礼物~' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='这是送您的一份礼物~');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='This is a gift for you~' WHERE c.code='这是送您的一份礼物~' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='这是送您的一份礼物~');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đăng nhập liên tục', c.remarks='[待审]连续签到' WHERE c.code='连续签到' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='连续签到');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Continuous check-ins' WHERE c.code='连续签到' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='连续签到');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Thoát xem trước', c.remarks='[待审]退出预览' WHERE c.code='退出预览' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退出预览');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Exit preview' WHERE c.code='退出预览' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退出预览');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phiếu hoàn tiền', c.remarks='[待审]退款凭证' WHERE c.code='退款凭证' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退款凭证');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Refund voucher' WHERE c.code='退款凭证' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退款凭证');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Xem xét hoàn tiền', c.remarks='[待审]退款审核' WHERE c.code='退款审核' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退款审核');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Refund review' WHERE c.code='退款审核' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退款审核');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tin nhắn hoàn tiền', c.remarks='[待审]退款留言' WHERE c.code='退款留言' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退款留言');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Refund message' WHERE c.code='退款留言' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退款留言');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phiếu trả lại', c.remarks='[待审]退货凭证' WHERE c.code='退货凭证' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退货凭证');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Return voucher' WHERE c.code='退货凭证' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退货凭证');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phương thức trả về', c.remarks='[待审]退货方式' WHERE c.code='退货方式' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退货方式');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Return method' WHERE c.code='退货方式' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退货方式');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Trả lại tin nhắn', c.remarks='[待审]退货留言' WHERE c.code='退货留言' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退货留言');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Return message' WHERE c.code='退货留言' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退货留言');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Trả lại và hoàn tiền', c.remarks='[待审]退货退款' WHERE c.code='退货退款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退货退款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Returns and refunds' WHERE c.code='退货退款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='退货退款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='tặng quà', c.remarks='[待审]送礼物' WHERE c.code='送礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='送礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='give gifts' WHERE c.code='送礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='送礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='đưa cho', c.remarks='[待审]送给' WHERE c.code='送给' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='送给');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='give to' WHERE c.code='送给' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='送给');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Gửi cho bạn bè', c.remarks='[待审]送给好友' WHERE c.code='送给好友' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='送给好友');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Send to a friend' WHERE c.code='送给好友' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='送给好友');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='một món quà cho bạn', c.remarks='[待审]送给您的一份礼物' WHERE c.code='送给您的一份礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='送给您的一份礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='a gift to you' WHERE c.code='送给您的一份礼物' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='送给您的一份礼物');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Phiếu giảm giá phổ quát', c.remarks='[待审]通用优惠券' WHERE c.code='通用优惠券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='通用优惠券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Universal Coupon' WHERE c.code='通用优惠券' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='通用优惠券');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='thanh toán Tonglian', c.remarks='[待审]通联支付' WHERE c.code='通联支付' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='通联支付');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Tonglian payment' WHERE c.code='通联支付' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='通联支付');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Xóa nợ một phần', c.remarks='[待审]部分核销' WHERE c.code='部分核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='部分核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Partial write-off' WHERE c.code='部分核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='部分核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='người giao hàng', c.remarks='[待审]配送员' WHERE c.code='配送员' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='配送员');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='delivery person' WHERE c.code='配送员' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='配送员');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='địa chỉ giao hàng', c.remarks='[待审]配送地址' WHERE c.code='配送地址' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='配送地址');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='shipping address' WHERE c.code='配送地址' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='配送地址');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Số tiền giao hàng', c.remarks='[待审]配送金额' WHERE c.code='配送金额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='配送金额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Delivery amount' WHERE c.code='配送金额' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='配送金额');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Giảm giá mua hàng', c.remarks='[待审]采购优惠' WHERE c.code='采购优惠' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='采购优惠');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Purchase discount' WHERE c.code='采购优惠' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='采购优惠');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Mở lại một', c.remarks='[待审]重开一个' WHERE c.code='重开一个' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='重开一个');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Reopen one' WHERE c.code='重开一个' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='重开一个');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='cài lại', c.remarks='[待审]重置' WHERE c.code='重置' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='重置');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='reset' WHERE c.code='重置' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='重置');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đang kết nối lại', c.remarks='[待审]重连中' WHERE c.code='重连中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='重连中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Reconnecting' WHERE c.code='重连中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='重连中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Đã sao chép liên kết', c.remarks='[待审]链接已复制' WHERE c.code='链接已复制' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='链接已复制');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Link copied' WHERE c.code='链接已复制' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='链接已复制');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhận tại cửa hàng', c.remarks='[待审]门店自提' WHERE c.code='门店自提' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='门店自提');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Pick up in store' WHERE c.code='门店自提' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='门店自提');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Số lượng còn lại có hạn', c.remarks='[待审]限量剩余' WHERE c.code='限量剩余' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='限量剩余');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Limited amount left' WHERE c.code='限量剩余' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='限量剩余');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Chỉ cần đi dạo', c.remarks='[待审]随便逛逛' WHERE c.code='随便逛逛' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='随便逛逛');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Just take a stroll' WHERE c.code='随便逛逛' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='随便逛逛');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Tóm tắt chính sách quyền riêng tư', c.remarks='[待审]隐私政策概要' WHERE c.code='隐私政策概要' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='隐私政策概要');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Privacy Policy Summary' WHERE c.code='隐私政策概要' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='隐私政策概要');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='không', c.remarks='[待审]零' WHERE c.code='零' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='零');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='zero' WHERE c.code='零' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='零');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Yêu cầu thanh toán', c.remarks='[待审]需付款' WHERE c.code='需付款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='需付款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Payment required' WHERE c.code='需付款' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='需付款');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Người dùng được yêu cầu xuất trình mã QR hoặc số để hủy', c.remarks='[待审]需用户出示二维码或数字即可核销' WHERE c.code='需用户出示二维码或数字即可核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='需用户出示二维码或数字即可核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Users are required to present a QR code or number to cancel' WHERE c.code='需用户出示二维码或数字即可核销' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='需用户出示二维码或数字即可核销');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='SF Vui lòng nhập số theo dõi', c.remarks='[待审]顺丰请输入单号' WHERE c.code='顺丰请输入单号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='顺丰请输入单号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='SF Please enter the tracking number' WHERE c.code='顺丰请输入单号' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='顺丰请输入单号');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bán trước:', c.remarks='[待审]预售:' WHERE c.code='预售:' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='预售:');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Pre-sale:' WHERE c.code='预售:' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='预售:');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Nhận phiếu giảm giá và đặt hàng để được giảm giá mua sắm', c.remarks='[待审]领券下单·享购物优惠' WHERE c.code='领券下单·享购物优惠' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='领券下单·享购物优惠');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Receive coupons and place orders to enjoy shopping discounts' WHERE c.code='领券下单·享购物优惠' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='领券下单·享购物优惠');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Không nhận được, quà tặng đã hết hạn', c.remarks='[待审]领取失败，礼物已失效' WHERE c.code='领取失败，礼物已失效' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='领取失败，礼物已失效');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Failed to receive, the gift has expired' WHERE c.code='领取失败，礼物已失效' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='领取失败，礼物已失效');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Bạn sẽ được đăng ký tự động khi đăng nhập lần đầu tiên.', c.remarks='[待审]首次登录会自动注册' WHERE c.code='首次登录会自动注册' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='首次登录会自动注册');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='You will be automatically registered when you log in for the first time.' WHERE c.code='首次登录会自动注册' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='首次登录会自动注册');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Xác thực không thành công', c.remarks='[待审]验证失败' WHERE c.code='验证失败' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='验证失败');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Authentication failed' WHERE c.code='验证失败' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='验证失败');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain='Xác minh thành công', c.remarks='[待审]验证成功' WHERE c.code='验证成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='验证成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain='Verification successful' WHERE c.code='验证成功' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='验证成功');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain=', hoàn lại tiền', c.remarks='[待审]，退款中' WHERE c.code='，退款中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='，退款中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain=', refunding' WHERE c.code='，退款中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='，退款中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='vi-VN' AND t.is_del=0 SET c.lang_explain=', đang hoàn lại một phần', c.remarks='[待审]，部分退款中' WHERE c.code='，部分退款中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='，部分退款中');
UPDATE eb_lang_code c JOIN eb_lang_type t ON t.id=c.type_id AND t.file_name='en-US' AND t.is_del=0 SET c.lang_explain=', partial refund is in progress' WHERE c.code='，部分退款中' AND c.is_admin=0 AND (c.lang_explain=c.code OR c.lang_explain='，部分退款中');

