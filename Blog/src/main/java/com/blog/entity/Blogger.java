/*博主 bean */

package com.blog.entity;

public class Blogger
{
    /*对应数据库中的属性*/

    /** 主键*/
    private  Integer id;
    /** 用户名*/
    private String userName;
    /** 密码*/
    private String password;
    /** 个人性息*/
    private String profile;
    /** 昵称*/
    private String nickName;
    /** 个性签名*/
    private String sign;
    /** 头像地址*/
    private String imageName;

    public void setId(Integer id) {
        this.id = id;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public void setImageName(String imageName) {
        this.imageName = imageName;
    }

    public Integer getId() {
        return id;
    }

    public String getUserName() {
        return userName;
    }

    public String getPassword() {
        return password;
    }

    public String getProfile() {
        return profile;
    }

    public String getNickName() {
        return nickName;
    }

    public String getSign() {
        return sign;
    }

    public String getImageName() {
        return imageName;
    }
}
