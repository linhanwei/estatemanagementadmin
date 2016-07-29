package welink.sdk.partner

import com.google.common.base.Charsets
import com.google.common.io.CharStreams
import org.apache.http.HttpEntity
import org.apache.http.client.HttpRequestRetryHandler
import org.apache.http.client.config.RequestConfig
import org.apache.http.client.methods.CloseableHttpResponse
import org.apache.http.client.methods.HttpPost
import org.apache.http.entity.ContentType
import org.apache.http.entity.mime.MultipartEntityBuilder
import org.apache.http.entity.mime.content.StringBody
import org.apache.http.impl.client.CloseableHttpClient
import org.apache.http.impl.client.HttpClients
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager
import org.apache.http.protocol.HttpContext
import org.codehaus.groovy.grails.web.json.JSONObject

/**
 * Created by saarixx on 29/4/15.
 */
class PartnerSyncInvoker {

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

    static def syncPartnerData(String url, String token, String json) {

        HttpPost httpPost = new HttpPost(url)

        System.out.println(json)

        HttpEntity reqEntity = MultipartEntityBuilder.create()
                .setCharset(Charsets.UTF_8)
                .addPart("token", new StringBody(token, ContentType.TEXT_PLAIN))
                .addPart("jsonData", new StringBody(json, ContentType.TEXT_PLAIN))
                .build()

        httpPost.setEntity(reqEntity)

        CloseableHttpResponse httpResponse = httpClient.execute(httpPost);
        String content = CharStreams.toString(new InputStreamReader(httpResponse.getEntity().getContent(), Charsets.UTF_8));

        try {
            return new JSONObject(content)
        } finally {
            httpResponse.close()
        }
    }
}
