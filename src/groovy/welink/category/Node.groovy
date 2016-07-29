package welink.category

/**
 * Created by saarixx on 13/11/14.
 */
class Node {
    // 类目id
    Long id
    // 类目名字
    String text
    // 类目属性
    String features
    // 状态
    def state = ["opened": true]
    // 节点的图标
    String icon
    // 是否有子节点
    List<Node> children = []
}
