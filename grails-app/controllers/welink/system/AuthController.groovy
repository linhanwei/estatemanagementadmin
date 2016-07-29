package welink.system

import com.google.common.base.Preconditions
import grails.transaction.Transactional
import org.apache.shiro.SecurityUtils
import org.apache.shiro.authc.AuthenticationException
import org.apache.shiro.authc.UsernamePasswordToken
import org.apache.shiro.crypto.hash.Sha512Hash
import org.apache.shiro.session.Session
import org.apache.shiro.subject.Subject
import org.apache.shiro.web.util.SavedRequest
import org.apache.shiro.web.util.WebUtils
import welink.common.Shop
import welink.estate.Community
import welink.user.Employee

import javax.servlet.http.Cookie

import static com.google.common.base.Preconditions.checkNotNull
import static org.apache.commons.lang3.StringUtils.isBlank

class AuthController {
    def shiroSecurityManager

    def grailsApplication

    def index = { redirect(action: "login", params: params) }

    def login = {

        return [username: params.username, rememberMe: (params.rememberMe != null), targetUri: params.targetUri]
    }

    def register = {

        def communities = Community.findAllByStatus(1 as byte)

        return [
                communities: communities
        ]

    }

    @Transactional
    def doRegister() {

        withForm {

            String salted = checkNotNull(grailsApplication.config.security.salted)

            Integer times = checkNotNull(Integer.valueOf(grailsApplication.config.security.iterate_times))

            String name = params.name
            String phone = params.phone
            String password = params.password
            String password2 = params.password2
            Long communityId = params.long('communityId')

            if (isBlank(name) || isBlank(phone) || isBlank(password) || isBlank(password2)|| (communityId==null)) {
                flash.message = "信息不完整"
                redirect(action: 'register')
                return;
            }
            if (password != password2) {
                flash.message = "两次输入的密码不一致"
                redirect(action: 'register')
                return;
            }
            if (Employee.countByMobile(phone)) {
                flash.message = "输入的手机号码已经存在"
                redirect(action: 'register')
                return;
            }

            Employee employee = new Employee(
                    communityId: communityId,
                    username: phone,
                    name: name,
                    mobile: phone,
                    status: 1 as byte,
                    password: new Sha512Hash(password, salted, times).toHex()
            )

            employee.addToRole(Preconditions.checkNotNull(Role.findByName("游客")))
            employee.save(failOnError: true)

            redirect(uri: '/auth/login')

        }.invalidToken {
            // bad request
            response.status = 405
        }
    }

    def signIn = {

        if (!params.username || !params.password) {
            redirect(action: "login")
            return;
        }

        // Now check the user's password against the hashed value stored
        // in the database.
        //String salted = Preconditions.checkNotNull(grailsApplication.config.security.salted)
        //Integer times = Preconditions.checkNotNull(Integer.valueOf(grailsApplication.config.security.iterate_times))

        def authToken = new UsernamePasswordToken(params.username, params.password)

        // Support for "remember me"
        if (params.rememberMe) {
            authToken.rememberMe = true
        }

        // If a controller redirected to this page, redirect back
        // to it. Otherwise redirect to the root URI.
        def targetUri = params.targetUri ?: (createLink(controller: 'dashboard', action: 'index') - request.contextPath)

        // Handle requests saved by Shiro filters.
        SavedRequest savedRequest = WebUtils.getSavedRequest(request)
        if (savedRequest) {
            targetUri = savedRequest.requestURI - request.contextPath
            if (savedRequest.queryString) targetUri = targetUri + '?' + savedRequest.queryString
        }

        try {
            // Perform the actual login. An AuthenticationException
            // will be thrown if the username is unrecognised or the
            // password is incorrect.
            SecurityUtils.subject.login(authToken)


            log.info "Redirecting to '${targetUri}'."

            // session
            def user = Employee.findByUsername(params.username)

            Subject currentUser = SecurityUtils.getSubject();
            Session session = currentUser.getSession();
            session.setAttribute("Manyroles","超级管理员")
            if (params.rememberMe)
            {
                Cookie cc=new Cookie("mksc_User",params.username+"=="+params.password)
                cc.setMaxAge(60*60*24*30)
                cc.setPath("/")
                response.addCookie(cc)
            }
//            if (params.rememberMe)
//            {
//                session.setAttribute("rememberMe","true")
//                session.setAttribute("rememberUser",params.username)
//                session.setAttribute("rememberPassword",params.password)
//            }
//            else
//            {
//                session.setAttribute("rememberMe","false")
//            }
//            log.info "================"
//            log.info params
//            log.info "================"
            redirect(uri: targetUri)
            return

        } catch (AuthenticationException ex) {
            // Authentication failed, so display the appropriate message
            // on the login page.
            log.info "Authentication failure for user '${params.username}'."
//            flash.message = message(code: "login.failed")
            flash.message="用户名或者密码不正确."
            // Keep the username and "remember me" setting so that the
            // user doesn't have to enter them again.
            def m = [username: params.username]
            if (params.rememberMe) {
                m["rememberMe"] = true
            }

            // Remember the target URI too.
            if (params.targetUri) {
                m["targetUri"] = params.targetUri
            }

            // Now redirect back to the login page.
            redirect(action: "login", params: m)
            return
        }
    }

    def logout = {
        signOut()
        return []
    }

    def signOut = {
        // Log the user out of the application.
        SecurityUtils.subject?.logout()
        webRequest.getCurrentRequest().session = null

        // For now, redirect back to the home page.
        redirect(uri: "/")
    }

    def unauthorized = {
        render "对不起，您目前没有权限访问该页面！请联系系统管理员"
    }


    def tesTDemo={

        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
        }
        return ;
    }
}
