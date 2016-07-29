package welink.sdk.baidu.result

import groovy.transform.ToString

/**
 * Created by saarixx on 21/3/15.
 */
@ToString
class BaiduMapCommonResult {

    /**
     * 1：成功；
     * 0：失败，
     */
    int status;

    String message;
}