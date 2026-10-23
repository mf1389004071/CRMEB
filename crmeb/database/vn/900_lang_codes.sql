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
) v
WHERE v.tid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_lang_code e WHERE e.type_id = v.tid AND e.code = v.code) AND NOT EXISTS (SELECT 1 FROM eb_lang_code z WHERE z.type_id = @t_zh AND z.remarks = v.zh_ AND z.code <> v.code);

-- 使语言包缓存失效：执行后在后台“清除缓存”
