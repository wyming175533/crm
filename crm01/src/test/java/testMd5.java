import com.bjpowernode.crm.settings.dao.UserDao;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.utils.MD5Util;
import com.bjpowernode.crm.utils.SqlSessionUtil;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.experimental.theories.suppliers.TestedOn;

import java.util.HashMap;
import java.util.Map;

public class testMd5 {
    @Test
    public void test(){
        String s="123";
        s= MD5Util.getMD5(s);
        System.out.println(s);
    }
    @Test
    public  void testGetsession(){
        SqlSession session = SqlSessionUtil.getSqlSession();
    }
  @Test
    public void testUserpwd(){
        SqlSession session=SqlSessionUtil.getSqlSession();
        UserDao userDao=session.getMapper(UserDao.class);
      Map<String,String> map=new HashMap<>();
      map.put("loginAct","zs");
      map.put("loginPwd","202cb962ac59075b964b07152d234b70");
        User user=userDao.login(map);
      System.out.println(user);
  }
}
