package welink.utils

import org.apache.shiro.SecurityUtils
import org.apache.shiro.session.Session
import org.apache.shiro.subject.Subject

import static com.google.common.base.Preconditions.checkNotNull

/**
 * Created by saarixx on 28/10/14.
 */
class SessionUtils {

    /**
     * 获取当前用户所在的小区，只有superadmin/root才会拿不到communityId
     *
     * @return
     */
    public static Long getCurrentUserCommunityId() {
        // 获取 commnityId
        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        Long communityId = checkNotNull(session.getAttribute('communityId'))

        return communityId
    }
}
