import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/applicationContext.xml",
                        "file:src/main/webapp/WEB-INF/security-context.xml"})
public class MemberTests {
    
    @Setter(onMethod_ = @Autowired)
    private PasswordEncoder pwencoder;
    
    @Setter(onMethod_ = @Autowired)
    private DataSource ds;
    
    @Test
    public void testInsertMember(){
        String sql = "insert into userC(email, pwd, name, tel_no, enabled, role_code,in_user,up_user) values (?,?,?,?,?,?,current_user,current_user )";
        
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
            con = ds.getConnection();
            pstmt = con.prepareStatement(sql);
            
            pstmt.setString(1,"javahater3@gmail.com");
            pstmt.setString(2, pwencoder.encode("1234"));
            pstmt.setString(3,"밤맛빵");
            pstmt.setString(4,"010-3342-5676");
            pstmt.setString(5,"1");
            pstmt.setString(6,"002");
            pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            if(pstmt!=null){try{pstmt.close();}catch (Exception e){}}
            if(con!=null){try{con.close();}catch (Exception e){}}
        }
    }
}
