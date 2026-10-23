-- 由 scripts/vn_lang_codes_to_sql.py 自动生成，请勿手改；幂等。
-- 回滚：DELETE FROM eb_lang_code WHERE code LIKE vn_%（api 词条）；front 词条按中文 code 删除。
SET NAMES utf8mb4;
SET @t_zh := (SELECT id FROM eb_lang_type WHERE file_name='zh-CN' AND is_del=0 LIMIT 1);
SET @t_vi := (SELECT id FROM eb_lang_type WHERE file_name='vi-VN' AND is_del=0 LIMIT 1);
SET @t_en := (SELECT id FROM eb_lang_type WHERE file_name='en-US' AND is_del=0 LIMIT 1);

INSERT INTO eb_lang_code (type_id, code, remarks, lang_explain, is_admin)
SELECT v.tid, v.code, v.remarks, v.explain_, v.is_admin FROM (
  SELECT @t_zh AS tid, '如需帮助，请通过以下方式联系我们' AS code, '如需帮助，请通过以下方式联系我们' AS remarks, '如需帮助，请通过以下方式联系我们' AS explain_, 0 AS is_admin, '如需帮助，请通过以下方式联系我们' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '如需帮助，请通过以下方式联系我们' AS code, '[待审]如需帮助，请通过以下方式联系我们' AS remarks, 'Nếu cần trợ giúp, vui lòng liên hệ chúng tôi qua các cách sau' AS explain_, 0 AS is_admin, '如需帮助，请通过以下方式联系我们' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '如需帮助，请通过以下方式联系我们' AS code, '如需帮助，请通过以下方式联系我们' AS remarks, 'For help, please contact us via the following channels' AS explain_, 0 AS is_admin, '如需帮助，请通过以下方式联系我们' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '复制' AS code, '复制' AS remarks, '复制' AS explain_, 0 AS is_admin, '复制' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '复制' AS code, '[待审]复制' AS remarks, 'Sao chép' AS explain_, 0 AS is_admin, '复制' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '复制' AS code, '复制' AS remarks, 'Copy' AS explain_, 0 AS is_admin, '复制' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '拨打电话' AS code, '拨打电话' AS remarks, '拨打电话' AS explain_, 0 AS is_admin, '拨打电话' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '拨打电话' AS code, '[待审]拨打电话' AS remarks, 'Gọi điện thoại' AS explain_, 0 AS is_admin, '拨打电话' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '拨打电话' AS code, '拨打电话' AS remarks, 'Call' AS explain_, 0 AS is_admin, '拨打电话' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂未配置联系方式' AS code, '暂未配置联系方式' AS remarks, '暂未配置联系方式' AS explain_, 0 AS is_admin, '暂未配置联系方式' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂未配置联系方式' AS code, '[待审]暂未配置联系方式' AS remarks, 'Chưa cấu hình thông tin liên hệ' AS explain_, 0 AS is_admin, '暂未配置联系方式' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂未配置联系方式' AS code, '暂未配置联系方式' AS remarks, 'No contact information configured yet' AS explain_, 0 AS is_admin, '暂未配置联系方式' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '微信' AS code, '微信' AS remarks, '微信' AS explain_, 0 AS is_admin, '微信' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '微信' AS code, '[待审]微信' AS remarks, 'WeChat' AS explain_, 0 AS is_admin, '微信' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '微信' AS code, '微信' AS remarks, 'WeChat' AS explain_, 0 AS is_admin, '微信' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '电话' AS code, '电话' AS remarks, '电话' AS explain_, 0 AS is_admin, '电话' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '电话' AS code, '[待审]电话' AS remarks, 'Điện thoại' AS explain_, 0 AS is_admin, '电话' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '电话' AS code, '电话' AS remarks, 'Phone' AS explain_, 0 AS is_admin, '电话' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '邮箱' AS code, '邮箱' AS remarks, '邮箱' AS explain_, 0 AS is_admin, '邮箱' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '邮箱' AS code, '[待审]邮箱' AS remarks, 'Email' AS explain_, 0 AS is_admin, '邮箱' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '邮箱' AS code, '邮箱' AS remarks, 'Email' AS explain_, 0 AS is_admin, '邮箱' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '复制成功' AS code, '复制成功' AS remarks, '复制成功' AS explain_, 0 AS is_admin, '复制成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '复制成功' AS code, '[待审]复制成功' AS remarks, 'Sao chép thành công' AS explain_, 0 AS is_admin, '复制成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '复制成功' AS code, '复制成功' AS remarks, 'Copied' AS explain_, 0 AS is_admin, '复制成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '联系我们' AS code, '联系我们' AS remarks, '联系我们' AS explain_, 0 AS is_admin, '联系我们' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '联系我们' AS code, '[待审]联系我们' AS remarks, 'Liên hệ chúng tôi' AS explain_, 0 AS is_admin, '联系我们' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '联系我们' AS code, '联系我们' AS remarks, 'Contact us' AS explain_, 0 AS is_admin, '联系我们' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_d4538c0d1b' AS code, '订单不是待确认状态' AS remarks, '订单不是待确认状态' AS explain_, 1 AS is_admin, '订单不是待确认状态' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_d4538c0d1b' AS code, '[待审]订单不是待确认状态' AS remarks, 'Đơn hàng không ở trạng thái chờ xác nhận' AS explain_, 1 AS is_admin, '订单不是待确认状态' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_d4538c0d1b' AS code, '订单不是待确认状态' AS remarks, 'The order is not pending confirmation' AS explain_, 1 AS is_admin, '订单不是待确认状态' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_e08f9dced9' AS code, '订单状态已变化，请刷新后重试' AS remarks, '订单状态已变化，请刷新后重试' AS explain_, 1 AS is_admin, '订单状态已变化，请刷新后重试' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_e08f9dced9' AS code, '[待审]订单状态已变化，请刷新后重试' AS remarks, 'Trạng thái đơn hàng đã thay đổi, vui lòng tải lại và thử lại' AS explain_, 1 AS is_admin, '订单状态已变化，请刷新后重试' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_e08f9dced9' AS code, '订单状态已变化，请刷新后重试' AS remarks, 'The order status has changed, please refresh and try again' AS explain_, 1 AS is_admin, '订单状态已变化，请刷新后重试' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_991c7482b1' AS code, '当前状态不能开始配送' AS remarks, '当前状态不能开始配送' AS explain_, 1 AS is_admin, '当前状态不能开始配送' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_991c7482b1' AS code, '[待审]当前状态不能开始配送' AS remarks, 'Trạng thái hiện tại không thể bắt đầu giao hàng' AS explain_, 1 AS is_admin, '当前状态不能开始配送' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_991c7482b1' AS code, '当前状态不能开始配送' AS remarks, 'Delivery cannot be started in the current status' AS explain_, 1 AS is_admin, '当前状态不能开始配送' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_87bdc9cace' AS code, '核销码格式不正确' AS remarks, '核销码格式不正确' AS explain_, 1 AS is_admin, '核销码格式不正确' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_87bdc9cace' AS code, '[待审]核销码格式不正确' AS remarks, 'Định dạng mã xác nhận không đúng' AS explain_, 1 AS is_admin, '核销码格式不正确' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_87bdc9cace' AS code, '核销码格式不正确' AS remarks, 'Invalid verification code format' AS explain_, 1 AS is_admin, '核销码格式不正确' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_bbcab92ea3' AS code, '核销码错误或订单不可核销' AS remarks, '核销码错误或订单不可核销' AS explain_, 1 AS is_admin, '核销码错误或订单不可核销' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_bbcab92ea3' AS code, '[待审]核销码错误或订单不可核销' AS remarks, 'Mã xác nhận sai hoặc đơn hàng không thể xác nhận' AS explain_, 1 AS is_admin, '核销码错误或订单不可核销' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_bbcab92ea3' AS code, '核销码错误或订单不可核销' AS remarks, 'Wrong verification code or the order cannot be verified' AS explain_, 1 AS is_admin, '核销码错误或订单不可核销' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_ed74a4f947' AS code, '订单已收款' AS remarks, '订单已收款' AS explain_, 1 AS is_admin, '订单已收款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_ed74a4f947' AS code, '[待审]订单已收款' AS remarks, 'Đơn hàng đã được thu tiền' AS explain_, 1 AS is_admin, '订单已收款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_ed74a4f947' AS code, '订单已收款' AS remarks, 'The order has already been collected' AS explain_, 1 AS is_admin, '订单已收款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_4b2515f6c9' AS code, '请先确认接单' AS remarks, '请先确认接单' AS explain_, 1 AS is_admin, '请先确认接单' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_4b2515f6c9' AS code, '[待审]请先确认接单' AS remarks, 'Vui lòng xác nhận nhận đơn trước' AS explain_, 1 AS is_admin, '请先确认接单' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_4b2515f6c9' AS code, '请先确认接单' AS remarks, 'Please confirm the order first' AS explain_, 1 AS is_admin, '请先确认接单' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_d633687f26' AS code, '实收金额不正确' AS remarks, '实收金额不正确' AS explain_, 1 AS is_admin, '实收金额不正确' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_d633687f26' AS code, '[待审]实收金额不正确' AS remarks, 'Số tiền thực thu không đúng' AS explain_, 1 AS is_admin, '实收金额不正确' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_d633687f26' AS code, '实收金额不正确' AS remarks, 'Invalid received amount' AS explain_, 1 AS is_admin, '实收金额不正确' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_fbca471541' AS code, '实收与应收不一致，请填写原因' AS remarks, '实收与应收不一致，请填写原因' AS explain_, 1 AS is_admin, '实收与应收不一致，请填写原因' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_fbca471541' AS code, '[待审]实收与应收不一致，请填写原因' AS remarks, 'Số tiền thực thu khác số phải thu, vui lòng nhập lý do' AS explain_, 1 AS is_admin, '实收与应收不一致，请填写原因' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_fbca471541' AS code, '实收与应收不一致，请填写原因' AS remarks, 'Received amount differs from receivable, please enter a reason' AS explain_, 1 AS is_admin, '实收与应收不一致，请填写原因' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_b69960e166' AS code, '已收款/已送达订单请走售后' AS remarks, '已收款/已送达订单请走售后' AS explain_, 1 AS is_admin, '已收款/已送达订单请走售后' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_b69960e166' AS code, '[待审]已收款/已送达订单请走售后' AS remarks, 'Đơn hàng đã thu tiền/đã giao vui lòng xử lý qua hậu mãi' AS explain_, 1 AS is_admin, '已收款/已送达订单请走售后' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_b69960e166' AS code, '已收款/已送达订单请走售后' AS remarks, 'Collected/delivered orders must go through after-sales' AS explain_, 1 AS is_admin, '已收款/已送达订单请走售后' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_6f2f645139' AS code, '请填写取消原因' AS remarks, '请填写取消原因' AS explain_, 1 AS is_admin, '请填写取消原因' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_6f2f645139' AS code, '[待审]请填写取消原因' AS remarks, 'Vui lòng nhập lý do hủy' AS explain_, 1 AS is_admin, '请填写取消原因' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_6f2f645139' AS code, '请填写取消原因' AS remarks, 'Please enter the cancellation reason' AS explain_, 1 AS is_admin, '请填写取消原因' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_60e3212774' AS code, '当前状态不能标记送达' AS remarks, '当前状态不能标记送达' AS explain_, 1 AS is_admin, '当前状态不能标记送达' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_60e3212774' AS code, '[待审]当前状态不能标记送达' AS remarks, 'Trạng thái hiện tại không thể đánh dấu đã giao' AS explain_, 1 AS is_admin, '当前状态不能标记送达' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_60e3212774' AS code, '当前状态不能标记送达' AS remarks, 'Cannot mark as delivered in the current status' AS explain_, 1 AS is_admin, '当前状态不能标记送达' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_62c287efea' AS code, '不是到付订单' AS remarks, '不是到付订单' AS explain_, 1 AS is_admin, '不是到付订单' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_62c287efea' AS code, '[待审]不是到付订单' AS remarks, 'Không phải đơn thanh toán khi nhận hàng' AS explain_, 1 AS is_admin, '不是到付订单' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_62c287efea' AS code, '不是到付订单' AS remarks, 'Not a cash-on-delivery order' AS explain_, 1 AS is_admin, '不是到付订单' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_5af500c641' AS code, '订单已取消' AS remarks, '订单已取消' AS explain_, 1 AS is_admin, '订单已取消' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_5af500c641' AS code, '[待审]订单已取消' AS remarks, 'Đơn hàng đã bị hủy' AS explain_, 1 AS is_admin, '订单已取消' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_5af500c641' AS code, '订单已取消' AS remarks, 'The order has been cancelled' AS explain_, 1 AS is_admin, '订单已取消' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_830ff7af34' AS code, '订单已确认备货，如需取消请联系客服' AS remarks, '订单已确认备货，如需取消请联系客服' AS explain_, 1 AS is_admin, '订单已确认备货，如需取消请联系客服' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_830ff7af34' AS code, '[待审]订单已确认备货，如需取消请联系客服' AS remarks, 'Đơn hàng đã được xác nhận chuẩn bị hàng, nếu cần hủy vui lòng liên hệ CSKH' AS explain_, 1 AS is_admin, '订单已确认备货，如需取消请联系客服' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_830ff7af34' AS code, '订单已确认备货，如需取消请联系客服' AS remarks, 'The order is being prepared. Please contact customer service to cancel' AS explain_, 1 AS is_admin, '订单已确认备货，如需取消请联系客服' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_bc1d047e91' AS code, '订单不存在' AS remarks, '订单不存在' AS explain_, 1 AS is_admin, '订单不存在' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_bc1d047e91' AS code, '[待审]订单不存在' AS remarks, 'Đơn hàng không tồn tại' AS explain_, 1 AS is_admin, '订单不存在' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_bc1d047e91' AS code, '订单不存在' AS remarks, 'Order does not exist' AS explain_, 1 AS is_admin, '订单不存在' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_482e8539da' AS code, '取消失败' AS remarks, '取消失败' AS explain_, 1 AS is_admin, '取消失败' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_482e8539da' AS code, '[待审]取消失败' AS remarks, 'Hủy thất bại' AS explain_, 1 AS is_admin, '取消失败' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_482e8539da' AS code, '取消失败' AS remarks, 'Cancellation failed' AS explain_, 1 AS is_admin, '取消失败' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_34073d594d' AS code, '系统繁忙，请稍后重试' AS remarks, '系统繁忙，请稍后重试' AS explain_, 1 AS is_admin, '系统繁忙，请稍后重试' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_34073d594d' AS code, '[待审]系统繁忙，请稍后重试' AS remarks, 'Hệ thống đang bận, vui lòng thử lại sau' AS explain_, 1 AS is_admin, '系统繁忙，请稍后重试' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_34073d594d' AS code, '系统繁忙，请稍后重试' AS remarks, 'System busy, please try again later' AS explain_, 1 AS is_admin, '系统繁忙，请稍后重试' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '待确认' AS code, '待确认' AS remarks, '待确认' AS explain_, 0 AS is_admin, '待确认' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '待确认' AS code, '[待审]待确认' AS remarks, 'Chờ xác nhận' AS explain_, 0 AS is_admin, '待确认' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '待确认' AS code, '待确认' AS remarks, 'Pending confirmation' AS explain_, 0 AS is_admin, '待确认' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '备货中' AS code, '备货中' AS remarks, '备货中' AS explain_, 0 AS is_admin, '备货中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '备货中' AS code, '[待审]备货中' AS remarks, 'Đang chuẩn bị hàng' AS explain_, 0 AS is_admin, '备货中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '备货中' AS code, '备货中' AS remarks, 'Preparing' AS explain_, 0 AS is_admin, '备货中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '发货中' AS code, '发货中' AS remarks, '发货中' AS explain_, 0 AS is_admin, '发货中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '发货中' AS code, '[待审]发货中' AS remarks, 'Đang giao hàng' AS explain_, 0 AS is_admin, '发货中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '发货中' AS code, '发货中' AS remarks, 'Out for delivery' AS explain_, 0 AS is_admin, '发货中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已送达' AS code, '已送达' AS remarks, '已送达' AS explain_, 0 AS is_admin, '已送达' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已送达' AS code, '[待审]已送达' AS remarks, 'Đã giao' AS explain_, 0 AS is_admin, '已送达' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已送达' AS code, '已送达' AS remarks, 'Delivered' AS explain_, 0 AS is_admin, '已送达' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已送达待收款' AS code, '已送达待收款' AS remarks, '已送达待收款' AS explain_, 0 AS is_admin, '已送达待收款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已送达待收款' AS code, '[待审]已送达待收款' AS remarks, 'Đã giao, chờ thu tiền' AS explain_, 0 AS is_admin, '已送达待收款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已送达待收款' AS code, '已送达待收款' AS remarks, 'Delivered, awaiting payment' AS explain_, 0 AS is_admin, '已送达待收款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商家正在确认订单,请耐心等待' AS code, '商家正在确认订单,请耐心等待' AS remarks, '商家正在确认订单,请耐心等待' AS explain_, 0 AS is_admin, '商家正在确认订单,请耐心等待' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商家正在确认订单,请耐心等待' AS code, '[待审]商家正在确认订单,请耐心等待' AS remarks, 'Cửa hàng đang xác nhận đơn hàng, vui lòng chờ' AS explain_, 0 AS is_admin, '商家正在确认订单,请耐心等待' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商家正在确认订单,请耐心等待' AS code, '商家正在确认订单,请耐心等待' AS remarks, 'The merchant is confirming your order, please wait' AS explain_, 0 AS is_admin, '商家正在确认订单,请耐心等待' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商家正在备货,请耐心等待' AS code, '商家正在备货,请耐心等待' AS remarks, '商家正在备货,请耐心等待' AS explain_, 0 AS is_admin, '商家正在备货,请耐心等待' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商家正在备货,请耐心等待' AS code, '[待审]商家正在备货,请耐心等待' AS remarks, 'Cửa hàng đang chuẩn bị hàng, vui lòng chờ' AS explain_, 0 AS is_admin, '商家正在备货,请耐心等待' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商家正在备货,请耐心等待' AS code, '商家正在备货,请耐心等待' AS remarks, 'The merchant is preparing your goods, please wait' AS explain_, 0 AS is_admin, '商家正在备货,请耐心等待' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商品正在配送中,请保持电话畅通' AS code, '商品正在配送中,请保持电话畅通' AS remarks, '商品正在配送中,请保持电话畅通' AS explain_, 0 AS is_admin, '商品正在配送中,请保持电话畅通' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商品正在配送中,请保持电话畅通' AS code, '[待审]商品正在配送中,请保持电话畅通' AS remarks, 'Hàng đang được giao, vui lòng giữ điện thoại thông suốt' AS explain_, 0 AS is_admin, '商品正在配送中,请保持电话畅通' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商品正在配送中,请保持电话畅通' AS code, '商品正在配送中,请保持电话畅通' AS remarks, 'Your goods are on the way, please keep your phone available' AS explain_, 0 AS is_admin, '商品正在配送中,请保持电话畅通' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已送达,请按应付金额支付货款' AS code, '已送达,请按应付金额支付货款' AS remarks, '已送达,请按应付金额支付货款' AS explain_, 0 AS is_admin, '已送达,请按应付金额支付货款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已送达,请按应付金额支付货款' AS code, '[待审]已送达,请按应付金额支付货款' AS remarks, 'Đã giao hàng, vui lòng thanh toán đúng số tiền phải trả' AS explain_, 0 AS is_admin, '已送达,请按应付金额支付货款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已送达,请按应付金额支付货款' AS code, '已送达,请按应付金额支付货款' AS remarks, 'Delivered, please pay the amount due' AS explain_, 0 AS is_admin, '已送达,请按应付金额支付货款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已送达,感谢您的支持' AS code, '已送达,感谢您的支持' AS remarks, '已送达,感谢您的支持' AS explain_, 0 AS is_admin, '已送达,感谢您的支持' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已送达,感谢您的支持' AS code, '[待审]已送达,感谢您的支持' AS remarks, 'Đã giao hàng, cảm ơn bạn đã ủng hộ' AS explain_, 0 AS is_admin, '已送达,感谢您的支持' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已送达,感谢您的支持' AS code, '已送达,感谢您的支持' AS remarks, 'Delivered, thank you for your support' AS explain_, 0 AS is_admin, '已送达,感谢您的支持' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '送货员送达时请出示此码' AS code, '送货员送达时请出示此码' AS remarks, '送货员送达时请出示此码' AS explain_, 0 AS is_admin, '送货员送达时请出示此码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '送货员送达时请出示此码' AS code, '[待审]送货员送达时请出示此码' AS remarks, 'Vui lòng đưa mã này cho nhân viên giao hàng khi nhận hàng' AS explain_, 0 AS is_admin, '送货员送达时请出示此码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '送货员送达时请出示此码' AS code, '送货员送达时请出示此码' AS remarks, 'Please show this code to the courier upon delivery' AS explain_, 0 AS is_admin, '送货员送达时请出示此码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '应收金额(货到付款)' AS code, '应收金额(货到付款)' AS remarks, '应收金额(货到付款)' AS explain_, 0 AS is_admin, '应收金额(货到付款)' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '应收金额(货到付款)' AS code, '[待审]应收金额(货到付款)' AS remarks, 'Số tiền phải thu (thanh toán khi nhận hàng)' AS explain_, 0 AS is_admin, '应收金额(货到付款)' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '应收金额(货到付款)' AS code, '应收金额(货到付款)' AS remarks, 'Amount due (cash on delivery)' AS explain_, 0 AS is_admin, '应收金额(货到付款)' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '联系客服' AS code, '联系客服' AS remarks, '联系客服' AS explain_, 0 AS is_admin, '联系客服' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '联系客服' AS code, '[待审]联系客服' AS remarks, 'Liên hệ CSKH' AS explain_, 0 AS is_admin, '联系客服' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '联系客服' AS code, '联系客服' AS remarks, 'Contact support' AS explain_, 0 AS is_admin, '联系客服' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已完成' AS code, '已完成' AS remarks, '已完成' AS explain_, 0 AS is_admin, '已完成' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已完成' AS code, '[待审]已完成' AS remarks, 'Hoàn thành' AS explain_, 0 AS is_admin, '已完成' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已完成' AS code, '已完成' AS remarks, 'Completed' AS explain_, 0 AS is_admin, '已完成' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '送达核销码或订单号' AS code, '送达核销码或订单号' AS remarks, '送达核销码或订单号' AS explain_, 0 AS is_admin, '送达核销码或订单号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '送达核销码或订单号' AS code, '[待审]送达核销码或订单号' AS remarks, 'Mã xác nhận giao hàng hoặc mã đơn hàng' AS explain_, 0 AS is_admin, '送达核销码或订单号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '送达核销码或订单号' AS code, '送达核销码或订单号' AS remarks, 'Delivery code or order number' AS explain_, 0 AS is_admin, '送达核销码或订单号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入6位核销码或订单号' AS code, '请输入6位核销码或订单号' AS remarks, '请输入6位核销码或订单号' AS explain_, 0 AS is_admin, '请输入6位核销码或订单号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入6位核销码或订单号' AS code, '[待审]请输入6位核销码或订单号' AS remarks, 'Nhập mã xác nhận 6 số hoặc mã đơn hàng' AS explain_, 0 AS is_admin, '请输入6位核销码或订单号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入6位核销码或订单号' AS code, '请输入6位核销码或订单号' AS remarks, 'Enter the 6-digit code or order number' AS explain_, 0 AS is_admin, '请输入6位核销码或订单号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '查询订单' AS code, '查询订单' AS remarks, '查询订单' AS explain_, 0 AS is_admin, '查询订单' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '查询订单' AS code, '[待审]查询订单' AS remarks, 'Tra cứu đơn hàng' AS explain_, 0 AS is_admin, '查询订单' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '查询订单' AS code, '查询订单' AS remarks, 'Look up order' AS explain_, 0 AS is_admin, '查询订单' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '确认送达核销' AS code, '确认送达核销' AS remarks, '确认送达核销' AS explain_, 0 AS is_admin, '确认送达核销' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '确认送达核销' AS code, '[待审]确认送达核销' AS remarks, 'Xác nhận đã giao hàng' AS explain_, 0 AS is_admin, '确认送达核销' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '确认送达核销' AS code, '确认送达核销' AS remarks, 'Confirm delivery' AS explain_, 0 AS is_admin, '确认送达核销' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '订单号' AS code, '订单号' AS remarks, '订单号' AS explain_, 0 AS is_admin, '订单号' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '订单号' AS code, '[待审]订单号' AS remarks, 'Mã đơn hàng' AS explain_, 0 AS is_admin, '订单号' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '订单号' AS code, '订单号' AS remarks, 'Order No.' AS explain_, 0 AS is_admin, '订单号' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '收款状态' AS code, '收款状态' AS remarks, '收款状态' AS explain_, 0 AS is_admin, '收款状态' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '收款状态' AS code, '[待审]收款状态' AS remarks, 'Trạng thái thu tiền' AS explain_, 0 AS is_admin, '收款状态' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '收款状态' AS code, '收款状态' AS remarks, 'Collection status' AS explain_, 0 AS is_admin, '收款状态' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '已收款' AS code, '已收款' AS remarks, '已收款' AS explain_, 0 AS is_admin, '已收款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '已收款' AS code, '[待审]已收款' AS remarks, 'Đã thu tiền' AS explain_, 0 AS is_admin, '已收款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '已收款' AS code, '已收款' AS remarks, 'Collected' AS explain_, 0 AS is_admin, '已收款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '未收款' AS code, '未收款' AS remarks, '未收款' AS explain_, 0 AS is_admin, '未收款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '未收款' AS code, '[待审]未收款' AS remarks, 'Chưa thu tiền' AS explain_, 0 AS is_admin, '未收款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '未收款' AS code, '未收款' AS remarks, 'Not collected' AS explain_, 0 AS is_admin, '未收款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '核销成功' AS code, '核销成功' AS remarks, '核销成功' AS explain_, 0 AS is_admin, '核销成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '核销成功' AS code, '[待审]核销成功' AS remarks, 'Xác nhận thành công' AS explain_, 0 AS is_admin, '核销成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '核销成功' AS code, '核销成功' AS remarks, 'Verified successfully' AS explain_, 0 AS is_admin, '核销成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请向客户收取货款，并在后台确认收款' AS code, '请向客户收取货款，并在后台确认收款' AS remarks, '请向客户收取货款，并在后台确认收款' AS explain_, 0 AS is_admin, '请向客户收取货款，并在后台确认收款' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请向客户收取货款，并在后台确认收款' AS code, '[待审]请向客户收取货款，并在后台确认收款' AS remarks, 'Vui lòng thu tiền hàng từ khách và xác nhận thu tiền trên hệ thống' AS explain_, 0 AS is_admin, '请向客户收取货款，并在后台确认收款' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请向客户收取货款，并在后台确认收款' AS code, '请向客户收取货款，并在后台确认收款' AS remarks, 'Please collect payment from the customer and confirm it in the backend' AS explain_, 0 AS is_admin, '请向客户收取货款，并在后台确认收款' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入客户出示的6位核销码' AS code, '请输入客户出示的6位核销码' AS remarks, '请输入客户出示的6位核销码' AS explain_, 0 AS is_admin, '请输入客户出示的6位核销码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入客户出示的6位核销码' AS code, '[待审]请输入客户出示的6位核销码' AS remarks, 'Vui lòng nhập mã 6 số khách hàng cung cấp' AS explain_, 0 AS is_admin, '请输入客户出示的6位核销码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入客户出示的6位核销码' AS code, '请输入客户出示的6位核销码' AS remarks, 'Please enter the 6-digit code shown by the customer' AS explain_, 0 AS is_admin, '请输入客户出示的6位核销码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '注册' AS code, '注册' AS remarks, '注册' AS explain_, 0 AS is_admin, '注册' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '注册' AS code, '[待审]注册' AS remarks, 'Đăng ký' AS explain_, 0 AS is_admin, '注册' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '注册' AS code, '注册' AS remarks, 'Register' AS explain_, 0 AS is_admin, '注册' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '昵称(选填)' AS code, '昵称(选填)' AS remarks, '昵称(选填)' AS explain_, 0 AS is_admin, '昵称(选填)' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '昵称(选填)' AS code, '[待审]昵称(选填)' AS remarks, 'Biệt danh (không bắt buộc)' AS explain_, 0 AS is_admin, '昵称(选填)' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '昵称(选填)' AS code, '昵称(选填)' AS remarks, 'Nickname (optional)' AS explain_, 0 AS is_admin, '昵称(选填)' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '密码至少6位' AS code, '密码至少6位' AS remarks, '密码至少6位' AS explain_, 0 AS is_admin, '密码至少6位' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '密码至少6位' AS code, '[待审]密码至少6位' AS remarks, 'Mật khẩu tối thiểu 6 ký tự' AS explain_, 0 AS is_admin, '密码至少6位' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '密码至少6位' AS code, '密码至少6位' AS remarks, 'Password must be at least 6 characters' AS explain_, 0 AS is_admin, '密码至少6位' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '注册成功' AS code, '注册成功' AS remarks, '注册成功' AS explain_, 0 AS is_admin, '注册成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '注册成功' AS code, '[待审]注册成功' AS remarks, 'Đăng ký thành công' AS explain_, 0 AS is_admin, '注册成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '注册成功' AS code, '注册成功' AS remarks, 'Registered successfully' AS explain_, 0 AS is_admin, '注册成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请输入手机号码' AS code, '请输入手机号码' AS remarks, '请输入手机号码' AS explain_, 0 AS is_admin, '请输入手机号码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入手机号码' AS code, '[待审]请输入手机号码' AS remarks, 'Vui lòng nhập số điện thoại' AS explain_, 0 AS is_admin, '请输入手机号码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入手机号码' AS code, '请输入手机号码' AS remarks, 'Please enter your phone number' AS explain_, 0 AS is_admin, '请输入手机号码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请联系客服重置密码' AS code, '请联系客服重置密码' AS remarks, '请联系客服重置密码' AS explain_, 0 AS is_admin, '请联系客服重置密码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请联系客服重置密码' AS code, '[待审]请联系客服重置密码' AS remarks, 'Vui lòng liên hệ CSKH để đặt lại mật khẩu' AS explain_, 0 AS is_admin, '请联系客服重置密码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请联系客服重置密码' AS code, '请联系客服重置密码' AS remarks, 'Please contact customer service to reset your password' AS explain_, 0 AS is_admin, '请联系客服重置密码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_03c7e40b2a' AS code, '手机号已注册' AS remarks, '手机号已注册' AS explain_, 1 AS is_admin, '手机号已注册' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_03c7e40b2a' AS code, '[待审]手机号已注册' AS remarks, 'Số điện thoại đã được đăng ký' AS explain_, 1 AS is_admin, '手机号已注册' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_03c7e40b2a' AS code, '手机号已注册' AS remarks, 'Phone number already registered' AS explain_, 1 AS is_admin, '手机号已注册' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_19c896fe76' AS code, '手机号格式不正确' AS remarks, '手机号格式不正确' AS explain_, 1 AS is_admin, '手机号格式不正确' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_19c896fe76' AS code, '[待审]手机号格式不正确' AS remarks, 'Định dạng số điện thoại không đúng' AS explain_, 1 AS is_admin, '手机号格式不正确' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_19c896fe76' AS code, '手机号格式不正确' AS remarks, 'Invalid phone number format' AS explain_, 1 AS is_admin, '手机号格式不正确' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_94c5f74d48' AS code, '账号密码必须是在6到32位之间' AS remarks, '账号密码必须是在6到32位之间' AS explain_, 1 AS is_admin, '账号密码必须是在6到32位之间' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_94c5f74d48' AS code, '[待审]账号密码必须是在6到32位之间' AS remarks, 'Mật khẩu phải từ 6 đến 32 ký tự' AS explain_, 1 AS is_admin, '账号密码必须是在6到32位之间' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_94c5f74d48' AS code, '账号密码必须是在6到32位之间' AS remarks, 'Password must be between 6 and 32 characters' AS explain_, 1 AS is_admin, '账号密码必须是在6到32位之间' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_c6a94080fa' AS code, '密码太过简单，请输入较为复杂的密码' AS remarks, '密码太过简单，请输入较为复杂的密码' AS explain_, 1 AS is_admin, '密码太过简单，请输入较为复杂的密码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_c6a94080fa' AS code, '[待审]密码太过简单，请输入较为复杂的密码' AS remarks, 'Mật khẩu quá đơn giản, vui lòng nhập mật khẩu phức tạp hơn' AS explain_, 1 AS is_admin, '密码太过简单，请输入较为复杂的密码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_c6a94080fa' AS code, '密码太过简单，请输入较为复杂的密码' AS remarks, 'Password is too simple, please use a stronger one' AS explain_, 1 AS is_admin, '密码太过简单，请输入较为复杂的密码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_14470411aa' AS code, '账号或密码错误' AS remarks, '账号或密码错误' AS explain_, 1 AS is_admin, '账号或密码错误' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_14470411aa' AS code, '[待审]账号或密码错误' AS remarks, 'Tài khoản hoặc mật khẩu không đúng' AS explain_, 1 AS is_admin, '账号或密码错误' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_14470411aa' AS code, '账号或密码错误' AS remarks, 'Wrong account or password' AS explain_, 1 AS is_admin, '账号或密码错误' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_e6c9714979' AS code, '请输入账号和密码' AS remarks, '请输入账号和密码' AS explain_, 1 AS is_admin, '请输入账号和密码' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_e6c9714979' AS code, '[待审]请输入账号和密码' AS remarks, 'Vui lòng nhập tài khoản và mật khẩu' AS explain_, 1 AS is_admin, '请输入账号和密码' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_e6c9714979' AS code, '请输入账号和密码' AS remarks, 'Please enter account and password' AS explain_, 1 AS is_admin, '请输入账号和密码' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_1c56d8c5aa' AS code, '注册失败' AS remarks, '注册失败' AS explain_, 1 AS is_admin, '注册失败' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_1c56d8c5aa' AS code, '[待审]注册失败' AS remarks, 'Đăng ký thất bại' AS explain_, 1 AS is_admin, '注册失败' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_1c56d8c5aa' AS code, '注册失败' AS remarks, 'Registration failed' AS explain_, 1 AS is_admin, '注册失败' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_6506a9ecaa' AS code, '注册成功' AS remarks, '注册成功' AS explain_, 1 AS is_admin, '注册成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_6506a9ecaa' AS code, '[待审]注册成功' AS remarks, 'Đăng ký thành công' AS explain_, 1 AS is_admin, '注册成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_6506a9ecaa' AS code, '注册成功' AS remarks, 'Registered successfully' AS explain_, 1 AS is_admin, '注册成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_88680ea43b' AS code, '暂时无法下单，请联系客服' AS remarks, '暂时无法下单，请联系客服' AS explain_, 1 AS is_admin, '暂时无法下单，请联系客服' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_88680ea43b' AS code, '[待审]暂时无法下单，请联系客服' AS remarks, 'Hiện chưa thể đặt hàng, vui lòng liên hệ CSKH' AS explain_, 1 AS is_admin, '暂时无法下单，请联系客服' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_88680ea43b' AS code, '暂时无法下单，请联系客服' AS remarks, 'Unable to place order at the moment, please contact customer service' AS explain_, 1 AS is_admin, '暂时无法下单，请联系客服' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_b517d17aeb' AS code, '下单过于频繁，请稍后再试或联系客服' AS remarks, '下单过于频繁，请稍后再试或联系客服' AS explain_, 1 AS is_admin, '下单过于频繁，请稍后再试或联系客服' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_b517d17aeb' AS code, '[待审]下单过于频繁，请稍后再试或联系客服' AS remarks, 'Bạn đặt hàng quá thường xuyên, vui lòng thử lại sau hoặc liên hệ CSKH' AS explain_, 1 AS is_admin, '下单过于频繁，请稍后再试或联系客服' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_b517d17aeb' AS code, '下单过于频繁，请稍后再试或联系客服' AS remarks, 'Too many orders placed, please try again later or contact customer service' AS explain_, 1 AS is_admin, '下单过于频繁，请稍后再试或联系客服' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_489251bfc8' AS code, '用户不存在' AS remarks, '用户不存在' AS explain_, 1 AS is_admin, '用户不存在' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_489251bfc8' AS code, '[待审]用户不存在' AS remarks, 'Người dùng không tồn tại' AS explain_, 1 AS is_admin, '用户不存在' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_489251bfc8' AS code, '用户不存在' AS remarks, 'User does not exist' AS explain_, 1 AS is_admin, '用户不存在' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_bff0e83714' AS code, '参数错误' AS remarks, '参数错误' AS explain_, 1 AS is_admin, '参数错误' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_bff0e83714' AS code, '[待审]参数错误' AS remarks, 'Tham số không hợp lệ' AS explain_, 1 AS is_admin, '参数错误' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_bff0e83714' AS code, '参数错误' AS remarks, 'Invalid parameters' AS explain_, 1 AS is_admin, '参数错误' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '正在定位…' AS code, '正在定位…' AS remarks, '正在定位…' AS explain_, 0 AS is_admin, '正在定位…' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '正在定位…' AS code, '[待审]正在定位…' AS remarks, 'Đang định vị…' AS explain_, 0 AS is_admin, '正在定位…' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '正在定位…' AS code, '正在定位…' AS remarks, 'Locating…' AS explain_, 0 AS is_admin, '正在定位…' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '定位当前位置' AS code, '定位当前位置' AS remarks, '定位当前位置' AS explain_, 0 AS is_admin, '定位当前位置' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '定位当前位置' AS code, '[待审]定位当前位置' AS remarks, 'Định vị vị trí hiện tại' AS explain_, 0 AS is_admin, '定位当前位置' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '定位当前位置' AS code, '定位当前位置' AS remarks, 'Use my current location' AS explain_, 0 AS is_admin, '定位当前位置' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '定位到' AS code, '定位到' AS remarks, '定位到' AS explain_, 0 AS is_admin, '定位到' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '定位到' AS code, '[待审]定位到' AS remarks, 'Đã định vị' AS explain_, 0 AS is_admin, '定位到' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '定位到' AS code, '定位到' AS remarks, 'Located' AS explain_, 0 AS is_admin, '定位到' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '点击选择' AS code, '点击选择' AS remarks, '点击选择' AS explain_, 0 AS is_admin, '点击选择' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '点击选择' AS code, '[待审]点击选择' AS remarks, 'Nhấn để chọn' AS explain_, 0 AS is_admin, '点击选择' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '点击选择' AS code, '点击选择' AS remarks, 'tap to select' AS explain_, 0 AS is_admin, '点击选择' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '热门城市' AS code, '热门城市' AS remarks, '热门城市' AS explain_, 0 AS is_admin, '热门城市' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '热门城市' AS code, '[待审]热门城市' AS remarks, 'Thành phố nổi bật' AS explain_, 0 AS is_admin, '热门城市' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '热门城市' AS code, '热门城市' AS remarks, 'Popular cities' AS explain_, 0 AS is_admin, '热门城市' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '全部地区' AS code, '全部地区' AS remarks, '全部地区' AS explain_, 0 AS is_admin, '全部地区' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '全部地区' AS code, '[待审]全部地区' AS remarks, 'Tất cả khu vực' AS explain_, 0 AS is_admin, '全部地区' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '全部地区' AS code, '全部地区' AS remarks, 'All regions' AS explain_, 0 AS is_admin, '全部地区' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '全部' AS code, '全部' AS remarks, '全部' AS explain_, 0 AS is_admin, '全部' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '全部' AS code, '[待审]全部' AS remarks, 'Tất cả' AS explain_, 0 AS is_admin, '全部' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '全部' AS code, '全部' AS remarks, 'All' AS explain_, 0 AS is_admin, '全部' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '选择' AS code, '选择' AS remarks, '选择' AS explain_, 0 AS is_admin, '选择' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '选择' AS code, '[待审]选择' AS remarks, 'Chọn' AS explain_, 0 AS is_admin, '选择' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '选择' AS code, '选择' AS remarks, 'Select' AS explain_, 0 AS is_admin, '选择' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '暂无可选区域' AS code, '暂无可选区域' AS remarks, '暂无可选区域' AS explain_, 0 AS is_admin, '暂无可选区域' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '暂无可选区域' AS code, '[待审]暂无可选区域' AS remarks, 'Chưa có khu vực khả dụng' AS explain_, 0 AS is_admin, '暂无可选区域' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '暂无可选区域' AS code, '暂无可选区域' AS remarks, 'No regions available' AS explain_, 0 AS is_admin, '暂无可选区域' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '当前位置暂不在配送范围，请从下方选择' AS code, '当前位置暂不在配送范围，请从下方选择' AS remarks, '当前位置暂不在配送范围，请从下方选择' AS explain_, 0 AS is_admin, '当前位置暂不在配送范围，请从下方选择' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '当前位置暂不在配送范围，请从下方选择' AS code, '[待审]当前位置暂不在配送范围，请从下方选择' AS remarks, 'Vị trí hiện tại chưa nằm trong phạm vi giao hàng, vui lòng chọn bên dưới' AS explain_, 0 AS is_admin, '当前位置暂不在配送范围，请从下方选择' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '当前位置暂不在配送范围，请从下方选择' AS code, '当前位置暂不在配送范围，请从下方选择' AS remarks, 'Your location is outside our delivery area, please choose below' AS explain_, 0 AS is_admin, '当前位置暂不在配送范围，请从下方选择' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '定位失败，请从下方选择' AS code, '定位失败，请从下方选择' AS remarks, '定位失败，请从下方选择' AS explain_, 0 AS is_admin, '定位失败，请从下方选择' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '定位失败，请从下方选择' AS code, '[待审]定位失败，请从下方选择' AS remarks, 'Định vị thất bại, vui lòng chọn bên dưới' AS explain_, 0 AS is_admin, '定位失败，请从下方选择' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '定位失败，请从下方选择' AS code, '定位失败，请从下方选择' AS remarks, 'Location failed, please choose below' AS explain_, 0 AS is_admin, '定位失败，请从下方选择' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '无法获取位置，请从下方选择' AS code, '无法获取位置，请从下方选择' AS remarks, '无法获取位置，请从下方选择' AS explain_, 0 AS is_admin, '无法获取位置，请从下方选择' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '无法获取位置，请从下方选择' AS code, '[待审]无法获取位置，请从下方选择' AS remarks, 'Không thể lấy vị trí, vui lòng chọn bên dưới' AS explain_, 0 AS is_admin, '无法获取位置，请从下方选择' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '无法获取位置，请从下方选择' AS code, '无法获取位置，请从下方选择' AS remarks, 'Unable to get your location, please choose below' AS explain_, 0 AS is_admin, '无法获取位置，请从下方选择' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '该区域暂未开放' AS code, '该区域暂未开放' AS remarks, '该区域暂未开放' AS explain_, 0 AS is_admin, '该区域暂未开放' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '该区域暂未开放' AS code, '[待审]该区域暂未开放' AS remarks, 'Khu vực này chưa mở' AS explain_, 0 AS is_admin, '该区域暂未开放' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '该区域暂未开放' AS code, '该区域暂未开放' AS remarks, 'This region is not open yet' AS explain_, 0 AS is_admin, '该区域暂未开放' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '切换配送区域将清空购物车，是否继续？' AS code, '切换配送区域将清空购物车，是否继续？' AS remarks, '切换配送区域将清空购物车，是否继续？' AS explain_, 0 AS is_admin, '切换配送区域将清空购物车，是否继续？' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '切换配送区域将清空购物车，是否继续？' AS code, '[待审]切换配送区域将清空购物车，是否继续？' AS remarks, 'Đổi khu vực giao hàng sẽ làm trống giỏ hàng, bạn có muốn tiếp tục?' AS explain_, 0 AS is_admin, '切换配送区域将清空购物车，是否继续？' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '切换配送区域将清空购物车，是否继续？' AS code, '切换配送区域将清空购物车，是否继续？' AS remarks, 'Changing the delivery region will clear your cart. Continue?' AS explain_, 0 AS is_admin, '切换配送区域将清空购物车，是否继续？' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '配送区域' AS code, '配送区域' AS remarks, '配送区域' AS explain_, 0 AS is_admin, '配送区域' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '配送区域' AS code, '[待审]配送区域' AS remarks, 'Khu vực giao hàng' AS explain_, 0 AS is_admin, '配送区域' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '配送区域' AS code, '配送区域' AS remarks, 'Delivery region' AS explain_, 0 AS is_admin, '配送区域' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择配送区域' AS code, '请选择配送区域' AS remarks, '请选择配送区域' AS explain_, 0 AS is_admin, '请选择配送区域' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择配送区域' AS code, '[待审]请选择配送区域' AS remarks, 'Vui lòng chọn khu vực giao hàng' AS explain_, 0 AS is_admin, '请选择配送区域' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择配送区域' AS code, '请选择配送区域' AS remarks, 'Please select a delivery region' AS explain_, 0 AS is_admin, '请选择配送区域' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '选择配送区域' AS code, '选择配送区域' AS remarks, '选择配送区域' AS explain_, 0 AS is_admin, '选择配送区域' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '选择配送区域' AS code, '[待审]选择配送区域' AS remarks, 'Chọn khu vực giao hàng' AS explain_, 0 AS is_admin, '选择配送区域' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '选择配送区域' AS code, '选择配送区域' AS remarks, 'Select delivery region' AS explain_, 0 AS is_admin, '选择配送区域' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_c7f87c03d1' AS code, '请先选择配送区域' AS remarks, '请先选择配送区域' AS explain_, 1 AS is_admin, '请先选择配送区域' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_c7f87c03d1' AS code, '[待审]请先选择配送区域' AS remarks, 'Vui lòng chọn khu vực giao hàng trước' AS explain_, 1 AS is_admin, '请先选择配送区域' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_c7f87c03d1' AS code, '请先选择配送区域' AS remarks, 'Please select a delivery region first' AS explain_, 1 AS is_admin, '请先选择配送区域' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_c72904a3a2' AS code, '当前区域暂不销售该商品' AS remarks, '当前区域暂不销售该商品' AS explain_, 1 AS is_admin, '当前区域暂不销售该商品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_c72904a3a2' AS code, '[待审]当前区域暂不销售该商品' AS remarks, 'Khu vực hiện tại tạm thời không bán sản phẩm này' AS explain_, 1 AS is_admin, '当前区域暂不销售该商品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_c72904a3a2' AS code, '当前区域暂不销售该商品' AS remarks, 'This product is not sold in the current region' AS explain_, 1 AS is_admin, '当前区域暂不销售该商品' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_e8b76bc171' AS code, '商品 {:name} 当前区域不可售' AS remarks, '商品 {:name} 当前区域不可售' AS explain_, 1 AS is_admin, '商品 {:name} 当前区域不可售' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_e8b76bc171' AS code, '[待审]商品 {:name} 当前区域不可售' AS remarks, 'Sản phẩm {:name} không được bán tại khu vực hiện tại' AS explain_, 1 AS is_admin, '商品 {:name} 当前区域不可售' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_e8b76bc171' AS code, '商品 {:name} 当前区域不可售' AS remarks, 'Product {:name} is not available in the current region' AS explain_, 1 AS is_admin, '商品 {:name} 当前区域不可售' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_4894880037' AS code, '商品价格已变化，请重新确认订单' AS remarks, '商品价格已变化，请重新确认订单' AS explain_, 1 AS is_admin, '商品价格已变化，请重新确认订单' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_4894880037' AS code, '[待审]商品价格已变化，请重新确认订单' AS remarks, 'Giá sản phẩm đã thay đổi, vui lòng xác nhận lại đơn hàng' AS explain_, 1 AS is_admin, '商品价格已变化，请重新确认订单' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_4894880037' AS code, '商品价格已变化，请重新确认订单' AS remarks, 'Product price has changed, please re-confirm the order' AS explain_, 1 AS is_admin, '商品价格已变化，请重新确认订单' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_a2292c8d4f' AS code, '该商品库存不足{:num}' AS remarks, '该商品库存不足{:num}' AS explain_, 1 AS is_admin, '该商品库存不足{:num}' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_a2292c8d4f' AS code, '[待审]该商品库存不足{:num}' AS remarks, 'Sản phẩm không đủ tồn kho {:num}' AS explain_, 1 AS is_admin, '该商品库存不足{:num}' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_a2292c8d4f' AS code, '该商品库存不足{:num}' AS remarks, 'Insufficient stock for this product {:num}' AS explain_, 1 AS is_admin, '该商品库存不足{:num}' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_a05d5a7803' AS code, '收货地址不在当前配送区域' AS remarks, '收货地址不在当前配送区域' AS explain_, 1 AS is_admin, '收货地址不在当前配送区域' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_a05d5a7803' AS code, '[待审]收货地址不在当前配送区域' AS remarks, 'Địa chỉ nhận hàng không nằm trong khu vực giao hàng hiện tại' AS explain_, 1 AS is_admin, '收货地址不在当前配送区域' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_a05d5a7803' AS code, '收货地址不在当前配送区域' AS remarks, 'The delivery address is outside the current delivery region' AS explain_, 1 AS is_admin, '收货地址不在当前配送区域' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_1b59618f7b' AS code, '请填写收货人姓名(25字以内)' AS remarks, '请填写收货人姓名(25字以内)' AS explain_, 1 AS is_admin, '请填写收货人姓名(25字以内)' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_1b59618f7b' AS code, '[待审]请填写收货人姓名(25字以内)' AS remarks, 'Vui lòng nhập tên người nhận (tối đa 25 ký tự)' AS explain_, 1 AS is_admin, '请填写收货人姓名(25字以内)' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_1b59618f7b' AS code, '请填写收货人姓名(25字以内)' AS remarks, 'Please enter the recipient name (max 25 characters)' AS explain_, 1 AS is_admin, '请填写收货人姓名(25字以内)' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_aa202f3682' AS code, '请填写详细地址' AS remarks, '请填写详细地址' AS explain_, 1 AS is_admin, '请填写详细地址' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_aa202f3682' AS code, '[待审]请填写详细地址' AS remarks, 'Vui lòng nhập địa chỉ chi tiết' AS explain_, 1 AS is_admin, '请填写详细地址' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_aa202f3682' AS code, '请填写详细地址' AS remarks, 'Please enter the detailed address' AS explain_, 1 AS is_admin, '请填写详细地址' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_66a3d38465' AS code, '收货地址格式错误，请重新选择' AS remarks, '收货地址格式错误，请重新选择' AS explain_, 1 AS is_admin, '收货地址格式错误，请重新选择' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_66a3d38465' AS code, '[待审]收货地址格式错误，请重新选择' AS remarks, 'Địa chỉ nhận hàng không hợp lệ, vui lòng chọn lại' AS explain_, 1 AS is_admin, '收货地址格式错误，请重新选择' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_66a3d38465' AS code, '收货地址格式错误，请重新选择' AS remarks, 'Invalid delivery address, please select again' AS explain_, 1 AS is_admin, '收货地址格式错误，请重新选择' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_7728ac8476' AS code, '地址已存在' AS remarks, '地址已存在' AS explain_, 1 AS is_admin, '地址已存在' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_7728ac8476' AS code, '[待审]地址已存在' AS remarks, 'Địa chỉ đã tồn tại' AS explain_, 1 AS is_admin, '地址已存在' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_7728ac8476' AS code, '地址已存在' AS remarks, 'The address already exists' AS explain_, 1 AS is_admin, '地址已存在' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_5badb3ba85' AS code, '修改失败' AS remarks, '修改失败' AS explain_, 1 AS is_admin, '修改失败' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_5badb3ba85' AS code, '[待审]修改失败' AS remarks, 'Sửa đổi thất bại' AS explain_, 1 AS is_admin, '修改失败' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_5badb3ba85' AS code, '修改失败' AS remarks, 'Update failed' AS explain_, 1 AS is_admin, '修改失败' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_6452a05591' AS code, '添加失败' AS remarks, '添加失败' AS explain_, 1 AS is_admin, '添加失败' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_6452a05591' AS code, '[待审]添加失败' AS remarks, 'Thêm thất bại' AS explain_, 1 AS is_admin, '添加失败' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_6452a05591' AS code, '添加失败' AS remarks, 'Failed to add' AS explain_, 1 AS is_admin, '添加失败' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_b20188f639' AS code, '数据不存在' AS remarks, '数据不存在' AS explain_, 1 AS is_admin, '数据不存在' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_b20188f639' AS code, '[待审]数据不存在' AS remarks, 'Dữ liệu không tồn tại' AS explain_, 1 AS is_admin, '数据不存在' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_b20188f639' AS code, '数据不存在' AS remarks, 'Data does not exist' AS explain_, 1 AS is_admin, '数据不存在' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_bbf09eae46' AS code, '地址选择有误' AS remarks, '地址选择有误' AS explain_, 1 AS is_admin, '地址选择有误' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_bbf09eae46' AS code, '[待审]地址选择有误' AS remarks, 'Địa chỉ được chọn không đúng' AS explain_, 1 AS is_admin, '地址选择有误' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_bbf09eae46' AS code, '地址选择有误' AS remarks, 'Wrong address selected' AS explain_, 1 AS is_admin, '地址选择有误' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_4a04600924' AS code, '请选择收货地址' AS remarks, '请选择收货地址' AS explain_, 1 AS is_admin, '请选择收货地址' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_4a04600924' AS code, '[待审]请选择收货地址' AS remarks, 'Vui lòng chọn địa chỉ nhận hàng' AS explain_, 1 AS is_admin, '请选择收货地址' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_4a04600924' AS code, '请选择收货地址' AS remarks, 'Please select a delivery address' AS explain_, 1 AS is_admin, '请选择收货地址' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写收货人姓名' AS code, '请填写收货人姓名' AS remarks, '请填写收货人姓名' AS explain_, 0 AS is_admin, '请填写收货人姓名' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写收货人姓名' AS code, '[待审]请填写收货人姓名' AS remarks, 'Vui lòng nhập tên người nhận' AS explain_, 0 AS is_admin, '请填写收货人姓名' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写收货人姓名' AS code, '请填写收货人姓名' AS remarks, 'Please enter the recipient name' AS explain_, 0 AS is_admin, '请填写收货人姓名' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写联系电话' AS code, '请填写联系电话' AS remarks, '请填写联系电话' AS explain_, 0 AS is_admin, '请填写联系电话' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写联系电话' AS code, '[待审]请填写联系电话' AS remarks, 'Vui lòng nhập số điện thoại liên hệ' AS explain_, 0 AS is_admin, '请填写联系电话' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写联系电话' AS code, '请填写联系电话' AS remarks, 'Please enter the contact phone number' AS explain_, 0 AS is_admin, '请填写联系电话' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请选择所在地区' AS code, '请选择所在地区' AS remarks, '请选择所在地区' AS explain_, 0 AS is_admin, '请选择所在地区' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请选择所在地区' AS code, '[待审]请选择所在地区' AS remarks, 'Vui lòng chọn khu vực' AS explain_, 0 AS is_admin, '请选择所在地区' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请选择所在地区' AS code, '请选择所在地区' AS remarks, 'Please select the region' AS explain_, 0 AS is_admin, '请选择所在地区' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '请填写详细地址' AS code, '请填写详细地址' AS remarks, '请填写详细地址' AS explain_, 0 AS is_admin, '请填写详细地址' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请填写详细地址' AS code, '[待审]请填写详细地址' AS remarks, 'Vui lòng nhập địa chỉ chi tiết' AS explain_, 0 AS is_admin, '请填写详细地址' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请填写详细地址' AS code, '请填写详细地址' AS remarks, 'Please enter the detailed address' AS explain_, 0 AS is_admin, '请填写详细地址' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '姓名' AS code, '姓名' AS remarks, '姓名' AS explain_, 0 AS is_admin, '姓名' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '姓名' AS code, '[待审]姓名' AS remarks, 'Họ tên' AS explain_, 0 AS is_admin, '姓名' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '姓名' AS code, '姓名' AS remarks, 'Name' AS explain_, 0 AS is_admin, '姓名' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '联系电话' AS code, '联系电话' AS remarks, '联系电话' AS explain_, 0 AS is_admin, '联系电话' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '联系电话' AS code, '[待审]联系电话' AS remarks, 'Số điện thoại' AS explain_, 0 AS is_admin, '联系电话' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '联系电话' AS code, '联系电话' AS remarks, 'Phone number' AS explain_, 0 AS is_admin, '联系电话' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '所在地区' AS code, '所在地区' AS remarks, '所在地区' AS explain_, 0 AS is_admin, '所在地区' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '所在地区' AS code, '[待审]所在地区' AS remarks, 'Khu vực' AS explain_, 0 AS is_admin, '所在地区' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '所在地区' AS code, '所在地区' AS remarks, 'Region' AS explain_, 0 AS is_admin, '所在地区' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '详细地址' AS code, '详细地址' AS remarks, '详细地址' AS explain_, 0 AS is_admin, '详细地址' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '详细地址' AS code, '[待审]详细地址' AS remarks, 'Địa chỉ chi tiết' AS explain_, 0 AS is_admin, '详细地址' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '详细地址' AS code, '详细地址' AS remarks, 'Detailed address' AS explain_, 0 AS is_admin, '详细地址' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '立即保存' AS code, '立即保存' AS remarks, '立即保存' AS explain_, 0 AS is_admin, '立即保存' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '立即保存' AS code, '[待审]立即保存' AS remarks, 'Lưu ngay' AS explain_, 0 AS is_admin, '立即保存' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '立即保存' AS code, '立即保存' AS remarks, 'Save' AS explain_, 0 AS is_admin, '立即保存' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '设置为默认地址' AS code, '设置为默认地址' AS remarks, '设置为默认地址' AS explain_, 0 AS is_admin, '设置为默认地址' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '设置为默认地址' AS code, '[待审]设置为默认地址' AS remarks, 'Đặt làm địa chỉ mặc định' AS explain_, 0 AS is_admin, '设置为默认地址' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '设置为默认地址' AS code, '设置为默认地址' AS remarks, 'Set as default address' AS explain_, 0 AS is_admin, '设置为默认地址' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '修改地址' AS code, '修改地址' AS remarks, '修改地址' AS explain_, 0 AS is_admin, '修改地址' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '修改地址' AS code, '[待审]修改地址' AS remarks, 'Sửa địa chỉ' AS explain_, 0 AS is_admin, '修改地址' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '修改地址' AS code, '修改地址' AS remarks, 'Edit address' AS explain_, 0 AS is_admin, '修改地址' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '添加地址' AS code, '添加地址' AS remarks, '添加地址' AS explain_, 0 AS is_admin, '添加地址' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '添加地址' AS code, '[待审]添加地址' AS remarks, 'Thêm địa chỉ' AS explain_, 0 AS is_admin, '添加地址' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '添加地址' AS code, '添加地址' AS remarks, 'Add address' AS explain_, 0 AS is_admin, '添加地址' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '保存中' AS code, '保存中' AS remarks, '保存中' AS explain_, 0 AS is_admin, '保存中' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '保存中' AS code, '[待审]保存中' AS remarks, 'Đang lưu' AS explain_, 0 AS is_admin, '保存中' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '保存中' AS code, '保存中' AS remarks, 'Saving' AS explain_, 0 AS is_admin, '保存中' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '修改成功' AS code, '修改成功' AS remarks, '修改成功' AS explain_, 0 AS is_admin, '修改成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '修改成功' AS code, '[待审]修改成功' AS remarks, 'Sửa thành công' AS explain_, 0 AS is_admin, '修改成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '修改成功' AS code, '修改成功' AS remarks, 'Updated successfully' AS explain_, 0 AS is_admin, '修改成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '添加成功' AS code, '添加成功' AS remarks, '添加成功' AS explain_, 0 AS is_admin, '添加成功' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '添加成功' AS code, '[待审]添加成功' AS remarks, 'Thêm thành công' AS explain_, 0 AS is_admin, '添加成功' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '添加成功' AS code, '添加成功' AS remarks, 'Added successfully' AS explain_, 0 AS is_admin, '添加成功' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, 'vn_7f4e906d34' AS code, '当前语言不可用' AS remarks, '当前语言不可用' AS explain_, 1 AS is_admin, '当前语言不可用' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, 'vn_7f4e906d34' AS code, '[待审]当前语言不可用' AS remarks, 'Ngôn ngữ hiện tại không khả dụng' AS explain_, 1 AS is_admin, '当前语言不可用' AS zh_
  UNION ALL
  SELECT @t_en AS tid, 'vn_7f4e906d34' AS code, '当前语言不可用' AS remarks, 'Current language is not available' AS explain_, 1 AS is_admin, '当前语言不可用' AS zh_
) v
WHERE v.tid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_lang_code e WHERE e.type_id = v.tid AND e.code = v.code) AND NOT EXISTS (SELECT 1 FROM eb_lang_code z WHERE z.type_id = @t_zh AND z.remarks = v.zh_ AND z.code <> v.code);

-- 使语言包缓存失效：执行后在后台“清除缓存”
