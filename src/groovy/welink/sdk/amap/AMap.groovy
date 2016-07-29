package welink.sdk.amap

import com.alibaba.fastjson.JSON
import com.google.common.base.Charsets
import com.google.common.collect.Lists
import com.google.common.io.CharStreams
import groovy.json.JsonBuilder
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
import welink.sdk.amap.result.DataCreateResult
import welink.sdk.amap.result.DataDeleteResult
import welink.sdk.amap.result.TableCreateResult

import static com.google.common.base.Preconditions.checkArgument
import static org.apache.commons.lang3.StringUtils.countMatches
import static org.apache.commons.lang3.StringUtils.isNotBlank

/**
 * 搞得地图 REST API 的访问请求，主要用来做
 *
 * Created by saarixx on 20/3/15.
 */
class AMap {

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
    static TableCreateResult createCloudTable(String key, String name) {

        key = key?.trim()
        name = name?.trim()

        checkArgument(key.length() <= 32)
        checkArgument(name.length() <= 50)

        HttpPost httpPost = new HttpPost("http://yuntuapi.amap.com/datamanage/table/create")

        List<NameValuePair> params = Lists.newArrayList()
        params.add(new BasicNameValuePair("key", key));
        params.add(new BasicNameValuePair("name", name));

        httpPost.setEntity(new UrlEncodedFormEntity(params, "UTF-8"))
        CloseableHttpResponse httpResponse = httpClient.execute(httpPost);
        String content = CharStreams.toString(new InputStreamReader(httpResponse.getEntity().getContent(), Charsets.UTF_8));

        try {
            def json = new JSONObject(content)
            return new TableCreateResult(status: json.status, info: json.info, tableId: json.tableid)
        } finally {
            httpResponse.close()
        }
    }

    /**
     * 在云图里面插入一条数据
     *
     * @param key
     * @param tableId
     * @param loctype
     * @param data
     * @return
     */
    static DataCreateResult createDataInTable(String key, String tableId, String loctype = '1', Map data) {

        checkArgument(data.containsKey("_name"))
        checkArgument(data.containsKey("_location"))

        HttpPost httpPost = new HttpPost("http://yuntuapi.amap.com/datamanage/data/create")

        List<NameValuePair> params = Lists.newArrayList()
        params.add(new BasicNameValuePair("key", key));
        params.add(new BasicNameValuePair("tableid", tableId));
        params.add(new BasicNameValuePair("loctype", loctype));
        String s = new JsonBuilder(data).toString()
        params.add(new BasicNameValuePair("data", s));

        httpPost.setEntity(new UrlEncodedFormEntity(params, "UTF-8"))
        CloseableHttpResponse httpResponse = httpClient.execute(httpPost);
        String content = CharStreams.toString(new InputStreamReader(httpResponse.getEntity().getContent(), Charsets.UTF_8));

        try {
            def json = new JSONObject(content)
            return new DataCreateResult(status: json.status, info: json.info, id: json._id)
        } finally {
            httpResponse.close()
        }
    }

    /**
     *
     *
     * @param key
     * @param tableId
     * @param ids 一次请求限制1-50条数据，多个_id用逗号隔开
     */
    static DataDeleteResult deleteDataInTable(String key, String tableId, String ids) {

        checkArgument(isNotBlank(ids))
        checkArgument(countMatches(ids, ",") <= 50)

        HttpPost httpPost = new HttpPost("http://yuntuapi.amap.com/datamanage/data/delete")

        List<NameValuePair> params = Lists.newArrayList()
        params.add(new BasicNameValuePair("key", key));
        params.add(new BasicNameValuePair("tableid", tableId));
        params.add(new BasicNameValuePair("ids", ids));

        httpPost.setEntity(new UrlEncodedFormEntity(params, "UTF-8"))
        CloseableHttpResponse httpResponse = httpClient.execute(httpPost);
        String content = CharStreams.toString(new InputStreamReader(httpResponse.getEntity().getContent(), Charsets.UTF_8));

        try {
            def json = new JSONObject(content)
            return new DataDeleteResult(status: json.status, info: json.info, fail: json.fail, success: json.success)
        } finally {
            httpResponse.close()
        }
    }

    /**
     * 把百度的lbs转换成为高德的
     *
     * @param key
     * @param lbs
     * @return
     */
    static String transformBaiduToAMap(String key, String lbs) {

        def build = new URIBuilder("http://restapi.amap.com/v3/assistant/coordinate/convert") //
                .addParameter("locations", lbs) //
                .addParameter("coordsys", "baidu") //
                .addParameter("output", "json") //
                .addParameter("key", key) //
                .build()

        HttpGet httpGet = new HttpGet(build)

        CloseableHttpResponse httpResponse = httpClient.execute(httpGet);
        String content = CharStreams.toString(new InputStreamReader(httpResponse.getEntity().getContent(), Charsets.UTF_8));

        try {
            def json = new JSONObject(content)
            return json.locations
        } finally {
            httpResponse.close()
        }
    }


}
