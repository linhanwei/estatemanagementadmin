package welink.sdk.amap.result

import groovy.transform.ToString

/**
 * Created by saarixx on 21/3/15.
 */
@ToString
class AMapCommonResult {

    /**
     * 1：成功；
     * 0：失败，
     */
    int status;

    String info;

}