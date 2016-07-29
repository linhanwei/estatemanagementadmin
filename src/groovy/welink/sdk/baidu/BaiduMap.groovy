package welink.sdk.baidu

import com.google.common.base.Charsets
import com.google.common.collect.Lists
import com.google.common.io.CharStreams
import org.apache.http.NameValuePair
import org.apache.http.client.HttpRequestRetryHandler
import org.apache.http.client.config.RequestConfig
import org.apache.http.client.entity.UrlEncodedFormEntity
import org.apache.http.client.methods.CloseableHttpResponse
import org.apache.http.client.methods.HttpGet
import org.apache.http.client.methods.HttpPost
import org.apache.http.client.utils.URIBuilder
import org.apache.http.impl.client.CloseableHttpClient
import org.apache.http.impl.client.HttpClients
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager
import org.apache.http.message.BasicNameValuePair
import org.apache.http.protocol.HttpContext
import org.codehaus.groovy.grails.web.json.JSONObject
import welink.sdk.baidu.result.BaiduMapCommonResult
import welink.sdk.baidu.result.DataCreateResult
import welink.sdk.baidu.result.DataDeleteResult
import welink.sdk.baidu.result.TableCreateResult

import static com.google.common.base.Preconditions.checkArgument
import static org.apache.commons.lang3.StringUtils.isNotBlank

/**
 * Created by saarixx on 19/4/15.
 */
class BaiduMap {

    static final CloseableHttpClient httpClient = HttpClients.custom() //
            .setMaxConnTotal(20) //
            .setConnectionManager(new PoolingHttpClientConnectionManager()) //
            .setRetryHandler(new HttpRequestRetryHandler() {
        @Override
        public boolean retryRequest(IOException exception, int executionCount, HttpContext context) {
            if (executionCount >= 3) {
                // Do not retry if over max retry count
                return false;
            }
            return true;
        }
    }) //
            .setDefaultRequestConfig(RequestConfig.custom()//
            .setConnectTimeout(2000) //
            .setConnectionRequestTimeout(2000) //
            .setSocketTimeout(2000) //
            .build()
    )
            .build();

    /**
     * 为一个配送点建立一张云图
     *
     * @param community_id
     */
    static TableCreateResult createBaiduMapTable(String ak, String name) {

        ak = ak?.trim()
        name = name?.trim()

        checkArgument(name.length() < 45)
        checkArgument(ak.length() < 50)

        HttpPost httpPost = new HttpPost("http://api.map.baidu.com/geodata/v3/geotable/create")

        List<NameValuePair> params = Lists.newArrayList()
        params.add(new BasicNameValuePair("name", name));
        params.add(new BasicNameValuePair("geotype", "1"));
        params.add(new BasicNameValuePair("is_published", "1"));
        params.add(new BasicNameValuePair("ak", ak));

        httpPost.setEntity(new UrlEncodedFormEntity(params, "UTF-8"))

        CloseableHttpResponse httpResponse = httpClient.execute(httpPost);
        String content = CharStreams.toString(new InputStreamReader(httpResponse.getEntity().getContent(), Charsets.UTF_8));

        try {
            def json = new JSONObject(content)
            return new TableCreateResult(status: json.status, message: json.message, id: json.id)
        } finally {
            httpResponse.close()
        }
    }

    static BaiduMapCommonResult deleteBaiduMapTable(String ak, String id) {
        ak = ak?.trim()
        id = id?.trim()

        checkArgument(id.length() < 32)
        checkArgument(ak.length() < 50)

        HttpPost httpPost = new HttpPost("http://api.map.baidu.com/geodata/v3/geotable/delete")

        List<NameValuePair> params = Lists.newArrayList()
        params.add(new BasicNameValuePair("id", id));
        params.add(new BasicNameValuePair("ak", ak));

        httpPost.setEntity(new UrlEncodedFormEntity(params, "UTF-8"))

        CloseableHttpResponse httpResponse = httpClient.execute(httpPost);
        String content = CharStreams.toString(new InputStreamReader(httpResponse.getEntity().getContent(), Charsets.UTF_8));

        try {
            def json = new JSONObject(content)
            return new BaiduMapCommonResult(status: json.status, message: json.message)
        } finally {
            httpResponse.close()
        }
    }


    static DataCreateResult createBaiduMapColumn(String ak, String name, String key, String type,
                                                 boolean isSortFilterField, boolean isSearchField, boolean isIndexField,
                                                 boolean isUniqueField, String geoTableId) {
        ak = ak?.trim()
        name = name?.trim()
        key = key?.trim()
        type = type?.trim()
        geoTableId = geoTableId?.trim()

        checkArgument(ak.length() < 45)
        checkArgument(name.length() < 45)
        checkArgument(geoTableId.length() < 50)

        HttpPost httpPost = new HttpPost("http://api.map.baidu.com/geodata/v3/column/create")

        List<NameValuePair> params = Lists.newArrayList()
        params.add(new BasicNameValuePair("name", name));
        params.add(new BasicNameValuePair("key", key));
        params.add(new BasicNameValuePair("type", type));
        params.add(new BasicNameValuePair("is_sortfilter_field", isSortFilterField ? "1" : "0"));
        params.add(new BasicNameValuePair("is_search_field", isSearchField ? "1" : "0"));
        params.add(new BasicNameValuePair("is_index_field", isIndexField ? "1" : "0"));
        params.add(new BasicNameValuePair("is_unique_field", isUniqueField ? "1" : "0"));
        params.add(new BasicNameValuePair("geotable_id", geoTableId));
        params.add(new BasicNameValuePair("ak", ak));

        httpPost.setEntity(new UrlEncodedFormEntity(params, "UTF-8"))

        CloseableHttpResponse httpResponse = httpClient.execute(httpPost);
        String content = CharStreams.toString(new InputStreamReader(httpResponse.getEntity().getContent(), Charsets.UTF_8));

        try {
            def json = new JSONObject(content)
            return new DataCreateResult(status: json.status, message: json.message, id: json.id)
        } finally {
            httpResponse.close()
        }
    }

    /**
     * 在百度云图里面插入一条数据
     *
     * @param key
     * @param tableId
     * @param loctype
     * @param data
     * @return
     */
    static DataCreateResult createDataInTable(String key, String tableId, String title, String address, String tags,
                                              Double longitude, Double latitude, String coord_type = "3", Map<String, String> data) {

        checkArgument(data.containsKey("trade_id"))
        checkArgument(data.containsKey("appointment_delivery_time"))

        HttpPost httpPost = new HttpPost("http://api.map.baidu.com/geodata/v3/poi/create")

        List<NameValuePair> params = Lists.newArrayList()
        params.add(new BasicNameValuePair("title", title));
        params.add(new BasicNameValuePair("address", address));
        params.add(new BasicNameValuePair("tags", tags));
        params.add(new BasicNameValuePair("longitude", String.valueOf(longitude)));
        params.add(new BasicNameValuePair("latitude", String.valueOf(latitude)));
        params.add(new BasicNameValuePair("coord_type", coord_type));
        params.add(new BasicNameValuePair("geotable_id", tableId));
        params.add(new BasicNameValuePair("ak", key));
        params.add(new BasicNameValuePair("tags", tags));
        params.add(new BasicNameValuePair("trade_id", data.get("trade_id")));
        params.add(new BasicNameValuePair("appointment_delivery_time", data.get("appointment_delivery_time")));

        httpPost.setEntity(new UrlEncodedFormEntity(params, "UTF-8"))

        CloseableHttpResponse httpResponse = httpClient.execute(httpPost);
        String content = CharStreams.toString(new InputStreamReader(httpResponse.getEntity().getContent(), Charsets.UTF_8));

        try {
            def json = new JSONObject(content)
            return new DataCreateResult(status: json.status, message: json.message, id: json.id)
        } finally {
            httpResponse.close()
        }
    }

    /**
     *
     *
     * @param key
     * @param tableId
     * @param tradeId
     *
     */
    static DataDeleteResult deleteDataInTable(String key, String tableId, String tradeId) {

        checkArgument(isNotBlank(tradeId))
        checkArgument(isNotBlank(key))
        checkArgument(isNotBlank(tableId))

        HttpPost httpPost = new HttpPost("http://api.map.baidu.com/geodata/v3/poi/delete")

        List<NameValuePair> params = Lists.newArrayList()
        params.add(new BasicNameValuePair("key", "trade_id"));
        params.add(new BasicNameValuePair("trade_id", tradeId));
        params.add(new BasicNameValuePair("ak", key));
        params.add(new BasicNameValuePair("geotable_id", tableId));

        httpPost.setEntity(new UrlEncodedFormEntity(params, "UTF-8"))
        CloseableHttpResponse httpResponse = httpClient.execute(httpPost);
        String content = CharStreams.toString(new InputStreamReader(httpResponse.getEntity().getContent(), Charsets.UTF_8));

        try {
            def json = new JSONObject(content)
            return new DataDeleteResult(status: json.status, message: json.info, id: json.id)
        } finally {
            httpResponse.close()
        }
    }

    static String transform(String key, String lbs) {

        def build = new URIBuilder("http://api.map.baidu.com/geoconv/v1/") //
                .addParameter("coords", lbs) //
                .addParameter("ak", key) //
                .addParameter("from", "3") //
                .addParameter("output", "json") //
                .build()

        HttpGet httpGet = new HttpGet(build)

        CloseableHttpResponse httpResponse = httpClient.execute(httpGet);
        String content = CharStreams.toString(new InputStreamReader(httpResponse.getEntity().getContent(), Charsets.UTF_8));

        try {
            def json = new JSONObject(content)
            def x = json.result[0].x
            def y = json.result[0].y
            return "${String.valueOf(x)}, ${String.valueOf(y)}"
        } finally {
            httpResponse.close()
        }
    }
}
