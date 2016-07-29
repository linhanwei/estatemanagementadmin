package welink.sdk.amap;

import com.google.common.collect.ImmutableMap;
import com.google.common.collect.Lists;
import org.apache.commons.lang.StringUtils;
import org.hamcrest.MatcherAssert;
import org.joda.time.DateTime;
import org.junit.Test;
import welink.sdk.amap.result.DataCreateResult;
import welink.sdk.amap.result.DataDeleteResult;
import welink.sdk.amap.result.TableCreateResult;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.is;

public class AMapTest {


    private static final String DEV_KEY = "45037846683337ee5ba40b262fc548f0";


    @Test
    public void testAccuracy() throws Exception {
        TableCreateResult cloudTable = AMap.createCloudTable(DEV_KEY, "unit_test_001");

        MatcherAssert.assertThat(cloudTable.getStatus(), is(1));
        MatcherAssert.assertThat(cloudTable.getInfo(), equalTo("OK"));

        String tableId = cloudTable.getTableId();


        DataCreateResult createResult = AMap.createDataInTable(DEV_KEY, "5510d0eae4b050797968ce48",
                ImmutableMap.builder() //
                        .put("_name", 4334/032.43f) //
                        .put("_location", "120.343441,30.318445") //
                        .put("trade_id", 231323452345234L)
                        .put("date_created", "2013-12-23 00:23:32")
                        .put("has_buyer_message", false)
                        .put("has_company_message", true)
                        .put("pay_type", 1)
                        .put("type", 2)
                        .put("shipping_type", 3)
                        .build()

        );

        DataCreateResult dataInTable = AMap.createDataInTable(DEV_KEY, tableId,
                ImmutableMap.of("_name", "测试", "_location", "120.543441,30.218445"));

        MatcherAssert.assertThat(createResult.getStatus(), is(1));
        MatcherAssert.assertThat(createResult.getInfo(), equalTo("OK"));

//        DataDeleteResult dataDeleteResult
//                = AMap.deleteDataInTable(DEV_KEY, tableId, StringUtils.join(Lists.newArrayList(createResult.getId(), dataInTable.getId()), ","));
//
//        MatcherAssert.assertThat(dataDeleteResult.getStatus(), is(1));
//        MatcherAssert.assertThat(dataDeleteResult.getInfo(), equalTo("OK"));
//        MatcherAssert.assertThat(dataDeleteResult.getFail(), is(0));
//        MatcherAssert.assertThat(dataDeleteResult.getSuccess(), is(2));


    }

    @Test
    public void testCreateDataInTable() throws Exception {

    }

    @Test
    public void testCreateDataInTable1() throws Exception {

    }

    @Test
    public void testDeleteDataInTable() throws Exception {

    }
}