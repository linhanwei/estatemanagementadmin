package welink.common

class MikuViewInfo {

    Long id
    //�汾
    Long version=0L
    //ҳ��˵��
    String info
    //״̬(0δɾ��״̬ 1Ϊ��Ч״̬)
    Byte status
    //������˵��
    String otherinfo
    //ҳ������
    String name

    static mapping = {
        table('miku_view_info')
        id generator: 'identity'
    }
}
