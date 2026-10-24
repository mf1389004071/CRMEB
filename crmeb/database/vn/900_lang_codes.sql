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
  UNION ALL
  SELECT @t_zh AS tid, '展示币种' AS code, '展示币种' AS remarks, '展示币种' AS explain_, 0 AS is_admin, '展示币种' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '展示币种' AS code, '[待审]展示币种' AS remarks, 'Đơn vị tiền tệ hiển thị' AS explain_, 0 AS is_admin, '展示币种' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '展示币种' AS code, '展示币种' AS remarks, 'Display currency' AS explain_, 0 AS is_admin, '展示币种' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商品信息' AS code, '商品信息' AS remarks, '商品信息' AS explain_, 0 AS is_admin, '商品信息' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商品信息' AS code, '[待审]商品信息' AS remarks, 'Thông tin sản phẩm' AS explain_, 0 AS is_admin, '商品信息' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商品信息' AS code, '商品信息' AS remarks, 'Product information' AS explain_, 0 AS is_admin, '商品信息' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '产地' AS code, '产地' AS remarks, '产地' AS explain_, 0 AS is_admin, '产地' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '产地' AS code, '[待审]产地' AS remarks, 'Xuất xứ' AS explain_, 0 AS is_admin, '产地' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '产地' AS code, '产地' AS remarks, 'Origin' AS explain_, 0 AS is_admin, '产地' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '保质期' AS code, '保质期' AS remarks, '保质期' AS explain_, 0 AS is_admin, '保质期' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '保质期' AS code, '[待审]保质期' AS remarks, 'Hạn sử dụng' AS explain_, 0 AS is_admin, '保质期' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '保质期' AS code, '保质期' AS remarks, 'Shelf life' AS explain_, 0 AS is_admin, '保质期' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '天' AS code, '天' AS remarks, '天' AS explain_, 0 AS is_admin, '天' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '天' AS code, '[待审]天' AS remarks, 'ngày' AS explain_, 0 AS is_admin, '天' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '天' AS code, '天' AS remarks, 'days' AS explain_, 0 AS is_admin, '天' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '冷链' AS code, '冷链' AS remarks, '冷链' AS explain_, 0 AS is_admin, '冷链' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '冷链' AS code, '[待审]冷链' AS remarks, 'Chuỗi lạnh' AS explain_, 0 AS is_admin, '冷链' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '冷链' AS code, '冷链' AS remarks, 'Cold chain' AS explain_, 0 AS is_admin, '冷链' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '需冷链运输' AS code, '需冷链运输' AS remarks, '需冷链运输' AS explain_, 0 AS is_admin, '需冷链运输' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '需冷链运输' AS code, '[待审]需冷链运输' AS remarks, 'Cần vận chuyển lạnh' AS explain_, 0 AS is_admin, '需冷链运输' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '需冷链运输' AS code, '需冷链运输' AS remarks, 'Cold-chain delivery required' AS explain_, 0 AS is_admin, '需冷链运输' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '净含量' AS code, '净含量' AS remarks, '净含量' AS explain_, 0 AS is_admin, '净含量' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '净含量' AS code, '[待审]净含量' AS remarks, 'Khối lượng tịnh' AS explain_, 0 AS is_admin, '净含量' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '净含量' AS code, '净含量' AS remarks, 'Net content' AS explain_, 0 AS is_admin, '净含量' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '单位' AS code, '单位' AS remarks, '单位' AS explain_, 0 AS is_admin, '单位' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '单位' AS code, '[待审]单位' AS remarks, 'Đơn vị' AS explain_, 0 AS is_admin, '单位' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '单位' AS code, '单位' AS remarks, 'Unit' AS explain_, 0 AS is_admin, '单位' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '税率' AS code, '税率' AS remarks, '税率' AS explain_, 0 AS is_admin, '税率' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '税率' AS code, '[待审]税率' AS remarks, 'Thuế suất' AS explain_, 0 AS is_admin, '税率' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '税率' AS code, '税率' AS remarks, 'Tax rate' AS explain_, 0 AS is_admin, '税率' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '搜索商品' AS code, '搜索商品' AS remarks, '搜索商品' AS explain_, 0 AS is_admin, '搜索商品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '搜索商品' AS code, '[待审]搜索商品' AS remarks, 'Tìm sản phẩm' AS explain_, 0 AS is_admin, '搜索商品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '搜索商品' AS code, '搜索商品' AS remarks, 'Search products' AS explain_, 0 AS is_admin, '搜索商品' AS zh_
  UNION ALL
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
  UNION ALL
  SELECT @t_zh AS tid, '请输入搜索词' AS code, '请输入搜索词' AS remarks, '请输入搜索词' AS explain_, 0 AS is_admin, '请输入搜索词' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '请输入搜索词' AS code, '[待审]请输入搜索词' AS remarks, 'Nhập từ khóa tìm kiếm' AS explain_, 0 AS is_admin, '请输入搜索词' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '请输入搜索词' AS code, '请输入搜索词' AS remarks, 'Enter search keywords' AS explain_, 0 AS is_admin, '请输入搜索词' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '猜你喜欢' AS code, '猜你喜欢' AS remarks, '猜你喜欢' AS explain_, 0 AS is_admin, '猜你喜欢' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '猜你喜欢' AS code, '[待审]猜你喜欢' AS remarks, 'Có thể bạn thích' AS explain_, 0 AS is_admin, '猜你喜欢' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '猜你喜欢' AS code, '猜你喜欢' AS remarks, 'You may also like' AS explain_, 0 AS is_admin, '猜你喜欢' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '砍价中心' AS code, '砍价中心' AS remarks, '砍价中心' AS explain_, 0 AS is_admin, '砍价中心' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '砍价中心' AS code, '[待审]砍价中心' AS remarks, 'Trung tâm mặc cả' AS explain_, 0 AS is_admin, '砍价中心' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '砍价中心' AS code, '砍价中心' AS remarks, 'Bargain center' AS explain_, 0 AS is_admin, '砍价中心' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '抽奖活动' AS code, '抽奖活动' AS remarks, '抽奖活动' AS explain_, 0 AS is_admin, '抽奖活动' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '抽奖活动' AS code, '[待审]抽奖活动' AS remarks, 'Hoạt động rút thăm' AS explain_, 0 AS is_admin, '抽奖活动' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '抽奖活动' AS code, '抽奖活动' AS remarks, 'Lucky draw' AS explain_, 0 AS is_admin, '抽奖活动' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '最新出炉' AS code, '最新出炉' AS remarks, '最新出炉' AS explain_, 0 AS is_admin, '最新出炉' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '最新出炉' AS code, '[待审]最新出炉' AS remarks, 'Mới nhất' AS explain_, 0 AS is_admin, '最新出炉' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '最新出炉' AS code, '最新出炉' AS remarks, 'Just dropped' AS explain_, 0 AS is_admin, '最新出炉' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '好物好价' AS code, '好物好价' AS remarks, '好物好价' AS explain_, 0 AS is_admin, '好物好价' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '好物好价' AS code, '[待审]好物好价' AS remarks, 'Hàng tốt giá tốt' AS explain_, 0 AS is_admin, '好物好价' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '好物好价' AS code, '好物好价' AS remarks, 'Good deals' AS explain_, 0 AS is_admin, '好物好价' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '爆款热卖' AS code, '爆款热卖' AS remarks, '爆款热卖' AS explain_, 0 AS is_admin, '爆款热卖' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '爆款热卖' AS code, '[待审]爆款热卖' AS remarks, 'Bán chạy' AS explain_, 0 AS is_admin, '爆款热卖' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '爆款热卖' AS code, '爆款热卖' AS remarks, 'Best sellers' AS explain_, 0 AS is_admin, '爆款热卖' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '鞋靴箱包' AS code, '鞋靴箱包' AS remarks, '鞋靴箱包' AS explain_, 0 AS is_admin, '鞋靴箱包' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '鞋靴箱包' AS code, '[待审]鞋靴箱包' AS remarks, 'Giày dép & túi' AS explain_, 0 AS is_admin, '鞋靴箱包' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '鞋靴箱包' AS code, '鞋靴箱包' AS remarks, 'Shoes & bags' AS explain_, 0 AS is_admin, '鞋靴箱包' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '个' AS code, '个' AS remarks, '个' AS explain_, 0 AS is_admin, '个' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '个' AS code, '[待审]个' AS remarks, 'cái' AS explain_, 0 AS is_admin, '个' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '个' AS code, '个' AS remarks, 'pcs' AS explain_, 0 AS is_admin, '个' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '套' AS code, '套' AS remarks, '套' AS explain_, 0 AS is_admin, '套' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '套' AS code, '[待审]套' AS remarks, 'bộ' AS explain_, 0 AS is_admin, '套' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '套' AS code, '套' AS remarks, 'set' AS explain_, 0 AS is_admin, '套' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '商品列表' AS code, '商品列表' AS remarks, '商品列表' AS explain_, 0 AS is_admin, '商品列表' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '商品列表' AS code, '[待审]商品列表' AS remarks, 'Danh sách sản phẩm' AS explain_, 0 AS is_admin, '商品列表' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '商品列表' AS code, '商品列表' AS remarks, 'Product list' AS explain_, 0 AS is_admin, '商品列表' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '生活家居' AS code, '生活家居' AS remarks, '生活家居' AS explain_, 0 AS is_admin, '生活家居' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '生活家居' AS code, '[待审]生活家居' AS remarks, 'Đời sống & nhà cửa' AS explain_, 0 AS is_admin, '生活家居' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '生活家居' AS code, '生活家居' AS remarks, 'Home & living' AS explain_, 0 AS is_admin, '生活家居' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '运动专区' AS code, '运动专区' AS remarks, '运动专区' AS explain_, 0 AS is_admin, '运动专区' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '运动专区' AS code, '[待审]运动专区' AS remarks, 'Khu thể thao' AS explain_, 0 AS is_admin, '运动专区' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '运动专区' AS code, '运动专区' AS remarks, 'Sports zone' AS explain_, 0 AS is_admin, '运动专区' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '电子产品' AS code, '电子产品' AS remarks, '电子产品' AS explain_, 0 AS is_admin, '电子产品' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '电子产品' AS code, '[待审]电子产品' AS remarks, 'Điện tử' AS explain_, 0 AS is_admin, '电子产品' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '电子产品' AS code, '电子产品' AS remarks, 'Electronics' AS explain_, 0 AS is_admin, '电子产品' AS zh_
  UNION ALL
  SELECT @t_zh AS tid, '家用电器' AS code, '家用电器' AS remarks, '家用电器' AS explain_, 0 AS is_admin, '家用电器' AS zh_
  UNION ALL
  SELECT @t_vi AS tid, '家用电器' AS code, '[待审]家用电器' AS remarks, 'Điện gia dụng' AS explain_, 0 AS is_admin, '家用电器' AS zh_
  UNION ALL
  SELECT @t_en AS tid, '家用电器' AS code, '家用电器' AS remarks, 'Home appliances' AS explain_, 0 AS is_admin, '家用电器' AS zh_
) v
WHERE v.tid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM eb_lang_code e WHERE e.type_id = v.tid AND e.code = v.code) AND NOT EXISTS (SELECT 1 FROM eb_lang_code z WHERE z.type_id = @t_zh AND z.remarks = v.zh_ AND z.code <> v.code);

-- 使语言包缓存失效：执行后在后台“清除缓存”
