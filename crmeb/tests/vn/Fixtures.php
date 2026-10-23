<?php
// 测试夹具：创建/清理 用户、地址、商品(单/多规格)，供 e2e / 区域价等测试复用（直接操作测试库）
use think\facade\Db;

class VnFx
{
    public static $uid = 7007;
    public static $created = ['products' => [], 'orders' => []];

    /** 创建测试用户 */
    public static function user(int $uid = 0): int
    {
        $uid = $uid ?: self::$uid;
        // 清缓存：重置下单限频计数等请求级状态（注意：登录 token 也在缓存中，须在签发 token 之前调用）
        \think\facade\Cache::clear();
        if (!Db::name('user')->where('uid', $uid)->find()) {
            Db::name('user')->insert([
                'uid' => $uid, 'account' => 'vnfx' . $uid, 'nickname' => 'VnFx' . $uid, 'phone' => '0912000' . $uid,
                'add_time' => time(), 'status' => 1, 'user_type' => 'h5', 'now_money' => 0, 'pwd' => md5('123456'),
            ]);
        }
        return $uid;
    }

    /** 创建收货地址，返回地址 id */
    public static function address(int $uid, int $cityId = 911001): int
    {
        Db::name('user_address')->where('uid', $uid)->delete();
        return (int)Db::name('user_address')->insertGetId([
            'uid' => $uid, 'real_name' => 'Nguyen Van A', 'phone' => '0912345678', 'province' => 'Hà Nội', 'city' => 'Hà Nội',
            'city_id' => $cityId, 'district' => 'Ba Đình', 'detail' => '1 Điện Biên Phủ', 'is_default' => 1, 'is_del' => 0, 'add_time' => time(),
        ]);
    }

    /**
     * 创建商品。$skus: [['suk'=>'a','price'=>100,'stock'=>10], ...]，单规格传一个元素。
     * @return array ['id'=>pid,'uniques'=>[suk=>unique]]
     */
    public static function product(int $pid, string $name, array $skus, array $extra = []): array
    {
        self::dropProduct($pid);
        $multi = count($skus) > 1;
        $minPrice = min(array_column($skus, 'price'));
        $stock = array_sum(array_column($skus, 'stock'));
        Db::name('store_product')->insert(array_merge([
            'id' => $pid, 'store_name' => $name, 'image' => '/uploads/t.png', 'slider_image' => '["/uploads/t.png"]', 'price' => $minPrice, 'ot_price' => $minPrice,
            'stock' => $stock, 'sales' => 0, 'is_show' => 1, 'is_del' => 0, 'unit_name' => 'kg', 'temp_id' => 1, 'spec_type' => $multi ? 1 : 0,
            'cate_id' => '1', 'add_time' => time(), 'logistics' => '1', 'freight' => 2, 'postage' => 0, 'is_postage' => 1, 'min_qty' => 1,
        ], $extra));
        $uniques = [];
        $i = 0;
        foreach ($skus as $sku) {
            $i++;
            $unique = substr(md5($pid . '_' . $sku['suk']), 0, 8);
            $uniques[$sku['suk']] = $unique;
            Db::name('store_product_attr_value')->insert([
                'product_id' => $pid, 'suk' => $sku['suk'], 'stock' => $sku['stock'], 'sales' => 0, 'price' => $sku['price'],
                'ot_price' => $sku['ot_price'] ?? $sku['price'], 'cost' => 0, 'unique' => $unique, 'image' => '/uploads/t.png', 'type' => 0, 'weight' => 0, 'volume' => 0,
            ]);
        }
        Db::name('store_product_attr')->insert([
            'product_id' => $pid, 'attr_name' => '规格', 'attr_values' => implode(',', array_column($skus, 'suk')), 'type' => 0,
        ]);
        Db::name('store_product_attr_result')->insert([
            'product_id' => $pid, 'type' => 0, 'change_time' => time(),
            'result' => json_encode(['attr' => [['value' => '规格', 'detailValue' => '', 'attrHidden' => '', 'detail' => array_column($skus, 'suk')]], 'value' => []], JSON_UNESCAPED_UNICODE),
        ]);
        return ['id' => $pid, 'uniques' => $uniques];
    }

    public static function dropProduct(int $pid): void
    {
        Db::name('store_product')->where('id', $pid)->delete();
        Db::name('store_product_attr')->where('product_id', $pid)->delete();
        Db::name('store_product_attr_value')->where('product_id', $pid)->delete();
        Db::name('store_product_attr_result')->where('product_id', $pid)->delete();
        Db::name('store_cart')->where('product_id', $pid)->delete();
        Db::name('store_product_region_price')->where('product_id', $pid)->delete();
    }

    public static function dropOrder(int $oid): void
    {
        Db::name('store_order_status')->where('oid', $oid)->delete();
        Db::name('store_order_cart_info')->where('oid', $oid)->delete();
        Db::name('store_order')->where('id', $oid)->delete();
    }

    /** HTTP 请求封装 */
    public static function http(string $method, string $url, string $token = '', array $data = [], array $headers = []): array
    {
        $ch = curl_init($url);
        $h = array_merge(['Content-Type: application/json'], $headers);
        if ($token) {
            $h[] = 'Authori-zation: Bearer ' . $token;
        }
        curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_TIMEOUT => 90, CURLOPT_CUSTOMREQUEST => $method, CURLOPT_HTTPHEADER => $h]);
        if ($data) {
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        }
        $res = curl_exec($ch);
        $j = json_decode($res, true);
        return $j ?: ['status' => -1, 'raw' => substr((string)$res, 0, 500)];
    }

    public static function base(): string
    {
        return getenv('VN_API_BASE') ?: 'http://host.docker.internal:8089';
    }

    public static function adminToken(): string
    {
        $svc = app()->make(\app\services\system\admin\SystemAdminServices::class);
        return $svc->createToken(1, 'admin', Db::name('system_admin')->where('id', 1)->value('pwd'))['token'];
    }

    public static function userToken(int $uid): string
    {
        $svc = app()->make(\app\services\system\admin\SystemAdminServices::class);
        return $svc->createToken($uid, 'api')['token'];
    }
}
