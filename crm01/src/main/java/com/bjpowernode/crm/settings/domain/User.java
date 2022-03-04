package com.bjpowernode.crm.settings.domain;

public class User {
    /**
     * loginAct 登录账号
     * expireTime  账号过期时间
     * lockState 锁定状态
     * deptno 部门编号
     * allowIps 允许访问的IP地址
     * crateTime 创建时间
     * createBy 创建者
     * editTime 修改时间
     * editBy 修改者
     */
   private String  id;
   private String loginAct;
   private String  name;
   private String  loginPwd;
   private String  email;
   private String  expireTime;
   private String  lockState;
   private String   deptno;
   private String  allowIps;
   private String  createTime;
   private String  createBy;
   private String  editTime;
   private String  editBy;

    public void setId(String id) {
        this.id = id;
    }

    public void setLoginAct(String loginAct) {
        this.loginAct = loginAct;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setLoginPwd(String loginPwd) {
        this.loginPwd = loginPwd;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setExpireTime(String expireTime) {
        this.expireTime = expireTime;
    }

    public void setLockState(String lockState) {
        this.lockState = lockState;
    }

    public void setDeptno(String deptno) {
        this.deptno = deptno;
    }

    public void setAllowIps(String allowIps) {
        this.allowIps = allowIps;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime;
    }

    public void setEditBy(String editBy) {
        this.editBy = editBy;
    }

    public String getId() {
        return id;
    }

    public String getLoginAct() {
        return loginAct;
    }

    public String getName() {
        return name;
    }

    public String getLoginPwd() {
        return loginPwd;
    }

    public String getEmail() {
        return email;
    }

    public String getExpireTime() {
        return expireTime;
    }

    public String getLockState() {
        return lockState;
    }

    public String getDeptno() {
        return deptno;
    }

    public String getAllowIps() {
        return allowIps;
    }

    public String getCreateTime() {
        return createTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public String getEditTime() {
        return editTime;
    }

    public String getEditBy() {
        return editBy;
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", loginAct='" + loginAct + '\'' +
                ", name='" + name + '\'' +
                ", loginPwd='" + loginPwd + '\'' +
                ", email='" + email + '\'' +
                ", expireTime='" + expireTime + '\'' +
                ", lockState='" + lockState + '\'' +
                ", deptno='" + deptno + '\'' +
                ", allowIps='" + allowIps + '\'' +
                ", createTime='" + createTime + '\'' +
                ", createBy='" + createBy + '\'' +
                ", editTime='" + editTime + '\'' +
                ", editBy='" + editBy + '\'' +
                '}';
    }
}
