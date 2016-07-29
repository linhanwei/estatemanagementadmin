package welink.common

import com.google.common.io.BaseEncoding
import com.upyun.UpYun
import com.upyun.UpYun.PARAMS
import com.upyun.api.utils.UpYunUtils
import com.welink.buy.utils.PhenixBase64
import groovy.text.GStringTemplateEngine
import org.apache.commons.io.FilenameUtils
import org.joda.time.DateTime
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter

import javax.annotation.Nonnull
import javax.annotation.Nullable
import javax.annotation.PostConstruct

import static com.google.common.base.Preconditions.checkNotNull

/**
 * 使用又拍云来做文件上传
 *
 */
class FileUploadService {

    final String fileFolderTemplate = '1/${communityId}/${action}/${actionId}/${date}/'
    final String fileTemplate = '${userId}-${shopId}-${timestamp}.${filename}'
    final DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern("yyyyMMdd");

    def grailsApplication
    String bucket
    String returnUrl
    String formApiSecret
    String username
    String password
    UpYun yun


    def upload(
            @Nonnull Long communityId,
            String action = "UNKNOWN",
            Long actionId = 0L,
            Long userId = 0L,
            Long shopId = 0L,
            @Nonnull String filename,
            @Nonnull InputStream inputStream,
            @Nullable Map<String, String> params) {

        checkNotNull(communityId)
        checkNotNull(filename)

        DateTime now = new DateTime()

        DateTime dateTime = new DateTime()
        dateTime.plusMinutes(5)

        def map = [:]
        map.put('communityId', BaseEncoding.base64().encode(String.valueOf(communityId).getBytes()))
        map.put('action', BaseEncoding.base64().encode(action.getBytes()))
        map.put('actionId', BaseEncoding.base64().encode(String.valueOf(actionId).getBytes()))
        map.put('date', dateTimeFormatter.print(now))
        map.put('userId', PhenixBase64.encode(String.valueOf(userId).getBytes()))
        map.put('shopId', shopId)
        map.put('timestamp', now.millis)
        map.put('filename', FilenameUtils.getExtension(filename))

        String saveKey = new GStringTemplateEngine().createTemplate(fileFolderTemplate).make(map).toString() + new GStringTemplateEngine().createTemplate(fileTemplate).make(map).toString()

        if (yun.writerFile(saveKey, inputStream, true, params)) {
            return "http://${bucket}.b0.upaiyun.com/${saveKey}"
        } else {
            null
        }
    }

    def urlMaker(@Nonnull Long communityId,
                 String action = "UNKNOWN",
                 Long actionId = 0L,
                 Long userId = 0L,
                 Long shopId = 0L,
                 @Nonnull String filename) {
        checkNotNull(communityId)
        checkNotNull(filename)

        DateTime now = new DateTime()

        DateTime dateTime = new DateTime()
        dateTime.plusMinutes(5)

        def params = [:]
        params.put('communityId', BaseEncoding.base64().encode(String.valueOf(communityId).getBytes()))
        params.put('action', BaseEncoding.base64().encode(action.getBytes()))
        params.put('actionId', BaseEncoding.base64().encode(String.valueOf(actionId).getBytes()))
        params.put('date', dateTimeFormatter.print(now))
        params.put('userId', PhenixBase64.encode(String.valueOf(userId).getBytes()))
        params.put('shopId', shopId)
        params.put('timestamp', now.millis)
        params.put('filename', filename)

        String saveKey = new GStringTemplateEngine().createTemplate(fileFolderTemplate).make(params).toString()
        +new GStringTemplateEngine().createTemplate(fileTemplate).make(params).toString()

        saveKey

        def map = [:]
        map.put('return-url', returnUrl)

        def policy = UpYunUtils.makePolicy(saveKey, (dateTime.millis).toLong(), bucket, map)

        def signature = UpYunUtils.signature("${policy}&${formApiSecret}")


        return [policy: policy, signature: signature, bucket: bucket]
    }

    @PostConstruct
    void init() {
        bucket = grailsApplication.config.upyun.bucket
        returnUrl = grailsApplication.config.upyun.return_url
        formApiSecret = grailsApplication.config.upyun.form_api_secret
        username = grailsApplication.config.upyun.username
        password = grailsApplication.config.upyun.password
        yun = new UpYun(bucket, username, password);

        if (log.isDebugEnabled()) {
            yun.debug = true
        }
    }


}
