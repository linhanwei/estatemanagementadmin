package welink.common

import com.google.common.base.Charsets
import com.google.common.collect.Maps
import com.google.common.io.CharStreams
import com.welink.commons.tacker.FastJsonHandler
import grails.converters.JSON
import grails.transaction.Transactional
import grails.util.Environment
import org.apache.commons.lang3.StringUtils
import org.apache.http.HttpHost
import org.apache.http.client.HttpRequestRetryHandler
import org.apache.http.client.config.RequestConfig
import org.apache.http.client.methods.CloseableHttpResponse
import org.apache.http.client.methods.HttpDelete
import org.apache.http.client.methods.HttpGet
import org.apache.http.impl.client.CloseableHttpClient
import org.apache.http.impl.client.HttpClients
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager
import org.apache.http.protocol.HttpContext

import javax.annotation.Resource

import static com.google.common.base.Preconditions.checkArgument
import static com.google.common.base.Preconditions.checkNotNull
import static org.apache.commons.lang3.StringUtils.isNotBlank

@Transactional
class KeenIOService {

    @Resource
    def keenClient;

    private CloseableHttpClient httpClient = HttpClients.custom() //
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
            .setProxy(new HttpHost("106.185.37.153", 21768)) //
            .setConnectTimeout(10000) //
            .setConnectionRequestTimeout(30000) //
            .setSocketTimeout(10000) //
            .build()
    )
            .build();


    public void track(String mobile, String category, Object object, Map<String, Object> features) {

        checkNotNull(object);
        checkArgument(isNotBlank(mobile));
        checkArgument(isNotBlank(category));


        Map<String, Object> eventMap = transform(mobile, object);

        if (features != null) {
            eventMap.put("features", features);
        }

        if (Environment.PRODUCTION != Environment.current) {
            category = "sandbox";
        }

        keenClient.addEvent(category, eventMap);
    }

    Map<String, Object> transform(String mobile, Object object) {
        Map<String, Object> map = Maps.newHashMap();
        map.put(FastJsonHandler.DEFAULT_MAP_KEY_MOBILE, mobile);
        map.put(FastJsonHandler.DEFAULT_MAP_KEY_OBJECT, object);
        return map;
    }


    def runQuery(String query) {

        checkArgument(isNotBlank(query))

        HttpGet httpGet = new HttpGet(query)
        CloseableHttpResponse httpResponse = httpClient.execute(httpGet);

        try {
            String content = CharStreams.toString(new InputStreamReader(httpResponse.getEntity().getContent(), Charsets.UTF_8));
            JSON.parse(content)
        } finally {
            httpResponse.close()
        }
    }

    def runDelete(String delete) {

        checkArgument(isNotBlank(delete))

        HttpDelete httpDelete = new HttpDelete(delete)
        CloseableHttpResponse httpResponse = httpClient.execute(httpDelete);

        try {
            int code = httpResponse.getStatusLine().getStatusCode()
            return code == 204
        }finally {
            httpResponse.close()
        }
    }
}
