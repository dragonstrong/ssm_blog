package com.blog.realm;

import com.blog.entity.Blogger;
import com.blog.service.BloggerService;
import com.blog.util.Const;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;

import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import javax.annotation.Resource;


//自定义类MyRealm 登陆权限验证
public class MyRealm extends AuthorizingRealm //继承权限验证类AuthorizingRealm
{
    /**从Resource引入bloggerService(BloggerServiceImpl类)*/
    @Resource
    private BloggerService bloggerService;


    /**获取授权信息：此项目只要登录就有所有权限，不用修改*/

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        return null;
    }

    /**登录验证
     * 参数authenticationToken:基于用户名和密码的令牌*/
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationtoken) throws AuthenticationException
    {
        //从令牌中取出用户名
        String userName=(String) authenticationtoken.getPrincipal();
        //让shiro验证账号密码，需要得到Blogger对象，从数据库里查到该条记录，shiro判断是否正确
        //写一个查询方法service从数据库中查询blogger，而service又要去DAO里找
        Blogger blogger=bloggerService.getByUserName(userName);
        if(blogger!=null)  //查到了该条记录
        {
            SecurityUtils.getSubject().getSession().setAttribute(Const.CURRENT_USER,blogger);//把blogger放到Session里，这样所有地方都可以直接获取
            AuthenticationInfo authenInfo=new SimpleAuthenticationInfo(blogger.getUserName(),blogger.getPassword(),getName());
            return authenInfo;
        }
        return null;
    }
}
