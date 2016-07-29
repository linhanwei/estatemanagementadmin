package welink.common

import grails.converters.JSON
import org.codehaus.groovy.grails.io.support.ClassPathResource
import org.codehaus.groovy.grails.io.support.GrailsIOUtils
import org.codehaus.groovy.grails.web.json.JSONObject

import javax.annotation.PostConstruct
import java.nio.charset.StandardCharsets

import static com.google.common.base.Preconditions.checkArgument
import static org.apache.commons.lang3.StringUtils.isNotBlank

class UEditorService {

    static lazyInit = false

    private JSONObject config

    def standard() {
        config
    }

    def withImageUrlPrefix(String imageUrlPrefix) {
        checkArgument(isNotBlank(imageUrlPrefix))
        config.imageUrlPrefix = imageUrlPrefix
        config
    }

    def withImagePathFormat(String imagePathFormat) {
        checkArgument(isNotBlank(imagePathFormat))
        config.imagePathFormat = imagePathFormat
        config
    }

    @PostConstruct
    void init() {
        config = (JSONObject) JSON.parse(GrailsIOUtils.toString(new ClassPathResource('ueditor-config.json').inputStream, StandardCharsets.UTF_8.name()).replaceAll("/\\*[\\s\\S]*?\\*/", ""))
    }
}


