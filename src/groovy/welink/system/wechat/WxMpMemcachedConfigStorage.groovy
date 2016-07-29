package welink.system.wechat

import com.google.common.base.Preconditions
import me.chanjar.weixin.common.bean.WxAccessToken
import me.chanjar.weixin.common.util.StringUtils
import me.chanjar.weixin.mp.api.WxMpConfigStorage
import net.spy.memcached.MemcachedClient
import org.codehaus.groovy.grails.commons.GrailsApplication
import org.springframework.beans.factory.InitializingBean

/**
 * Created by saarixx on 28/12/14.
 */
class WxMpMemcachedConfigStorage implements WxMpConfigStorage, InitializingBean {

    private static String DEFAULT_WECHAT_ACCESSTOKEN_PREFIX = '$WECHAT_ACCESSTOKEN_$';

    private static String DEFAULT_JSAPI_TICKET_PREFIX = '$JSAPI_TICKET_$';

    private MemcachedClient memcachedClient;

    GrailsApplication grailsApplication


    void setGrailsApplication(GrailsApplication grailsApplication) {
        this.grailsApplication = grailsApplication
    }

    void setMemcachedClient(MemcachedClient memcachedClient) {
        this.memcachedClient = memcachedClient
    }

    // 以下信息直接写在代码里面就好了
    protected String appId;
    protected String secret;
    protected String token;
    protected String aesKey;
    protected volatile long expiresTime;

    protected String oauth2redirectUri;

    // 如果没有proxy就可以不写，默认不用写
    protected String http_proxy_host;
    protected int http_proxy_port;
    protected String http_proxy_username;
    protected String http_proxy_password;

    protected volatile long jsapiTicketExpiresTime;

    @Override
    public void updateAccessToken(WxAccessToken wxAccessToken) {
        Preconditions.checkNotNull(wxAccessToken);
        updateAccessToken(wxAccessToken.getAccessToken(), wxAccessToken.getExpiresIn());
    }

    @Override
    public synchronized void updateAccessToken(String accessToken, int expiresInSeconds) {
        StringUtils.isNotBlank(accessToken);
        Preconditions.checkArgument(expiresInSeconds > 0);
        memcachedClient.set(makeKey(DEFAULT_WECHAT_ACCESSTOKEN_PREFIX, this.appId), expiresInSeconds * 2, accessToken);
        this.expiresTime = System.currentTimeMillis() + (expiresInSeconds - 200) * 1000L;
    }

    @Override
    public String getJsapiTicket() {
        String jsapiTicket = (String) memcachedClient.get(makeKey(DEFAULT_JSAPI_TICKET_PREFIX, this.appId));
        return jsapiTicket;
    }

    @Override
    public boolean isJsapiTicketExpired() {
        return System.currentTimeMillis() > this.jsapiTicketExpiresTime;
    }

    @Override
    public void expireJsapiTicket() {
        this.jsapiTicketExpiresTime = 0;
    }

    @Override
    public synchronized void updateJsapiTicket(String jsapiTicket, int expiresInSeconds) {
        // 预留200秒的时间
        memcachedClient.set(makeKey(DEFAULT_JSAPI_TICKET_PREFIX, this.appId), expiresInSeconds * 2, jsapiTicket);
        this.jsapiTicketExpiresTime = System.currentTimeMillis() + (expiresInSeconds - 200) * 1000L;
    }

    @Override
    public String getAccessToken() {
        String accessToken = (String) memcachedClient.get(makeKey(DEFAULT_WECHAT_ACCESSTOKEN_PREFIX, this.appId));
        return accessToken;
    }

    @Override
    public boolean isAccessTokenExpired() {
        return System.currentTimeMillis() > this.expiresTime;
    }

    @Override
    void expireAccessToken() {

    }

    @Override
    public String getAppId() {
        return this.appId;
    }

    @Override
    public String getSecret() {
        return this.secret;
    }

    @Override
    public String getToken() {
        return this.token;
    }

    @Override
    public String getAesKey() {
        return this.aesKey;
    }

    @Override
    long getExpiresTime() {
        return 0
    }

    @Override
    public String getOauth2redirectUri() {
        return this.oauth2redirectUri;
    }

    @Override
    public String getHttp_proxy_host() {
        return this.http_proxy_host;
    }

    @Override
    public int getHttp_proxy_port() {
        return this.http_proxy_port;
    }

    @Override
    public String getHttp_proxy_username() {
        return this.http_proxy_username;
    }

    @Override
    public String getHttp_proxy_password() {
        return this.http_proxy_password;
    }

    public static String makeKey(String prefix, String appId) {
        return prefix + appId;
    }

    @Override
    void afterPropertiesSet() throws Exception {
        this.appId = grailsApplication.config.weChat.appId
        this.secret = grailsApplication.config.weChat.secret
        this.token = grailsApplication.config.weChat.token
        this.aesKey = grailsApplication.config.weChat.aesKey
    }

}
