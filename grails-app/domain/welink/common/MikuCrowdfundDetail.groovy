package welink.common

class MikuCrowdfundDetail {
    Long id
    //�ڳ�id
    Long crowdfundId
    //��Ʒid
    Long itemId
    //֧����
    Integer soldNum
    //�汾
    Long version
    //����ʱ��
    Date dateCreated
    //����ʱ��
    Date lastUpdated
    //�ر����� return_content
    String returnContent
    //������ʾ risk_tips
    String riskTips
    //�ر�˵�� special_note
    String specialNote

    //״̬[��ʾ  ����  ɾ��]--->[1  0  -1]
    Byte approveStatus


    static constraints = {
    }
    static mapping = {
        id generator: 'identity'
    }
}
