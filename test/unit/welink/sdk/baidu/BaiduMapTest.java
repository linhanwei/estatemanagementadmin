package welink.sdk.baidu;

import com.google.common.collect.ImmutableMap;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.junit.Test;
import welink.sdk.baidu.result.BaiduMapCommonResult;
import welink.sdk.baidu.result.DataCreateResult;
import welink.sdk.baidu.result.DataDeleteResult;
import welink.sdk.baidu.result.TableCreateResult;

import java.util.Date;
import java.util.Map;

/**
 * Created by saarixx on 19/4/15.
 */
public class BaiduMapTest {

    static String ak = "EvhWsp4Px5UYYrHz6UvjUph1";

    @Test
    public void test_accuracy() throws Exception {

        String tableId;

        TableCreateResult tableCreateResult = BaiduMap.createBaiduMapTable(ak, "test4");

        System.out.println(ToStringBuilder.reflectionToString(tableCreateResult));

        tableId = tableCreateResult.getId();

        BaiduMap.createBaiduMapColumn(ak, "订单号", "trade_id", "1", true, false, true, true, tableId);

        BaiduMap.createBaiduMapColumn(ak, "预约时间", "appointment_delivery_time", "1", true, false, true, false, tableId);

        String lbs = "120.021455,30.242223";

        lbs = BaiduMap.transform(ak, lbs);

        double x = Double.valueOf(StringUtils.split(lbs, ",")[0]);
        double y = Double.valueOf(StringUtils.split(lbs, ",")[1]);

        Map<String, String> data = ImmutableMap.<String, String>builder() //
                .put("trade_id", "123") //
                .put("appointment_delivery_time", String.valueOf(new Date().getTime())) //
                .build();

        DataCreateResult dataInTable = BaiduMap.createDataInTable(ak, tableId, "测试", "浙江省杭州市余杭区五常大道翡翠城凌霄苑4幢401", "", x, y, data);

        DataCreateResult dataInTable2 = BaiduMap.createDataInTable(ak, tableId, "测试", "浙江省杭州市余杭区五常大道翡翠城凌霄苑4幢401", "", x, y, data);

        DataDeleteResult dataDeleteResult = BaiduMap.deleteDataInTable(ak, tableId, "123");

        BaiduMapCommonResult baiduMapCommonResult = BaiduMap.deleteBaiduMapTable(ak, tableId);

        System.out.println(ToStringBuilder.reflectionToString(baiduMapCommonResult));

    }


}