import com.ncncn.domain.UserVO;
import com.ncncn.mapper.UserMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.apache.ibatis.annotations.Mapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/applicationContext.xml"})
public class MemberMapperTests {

    @Setter(onMethod_ = @Autowired)
    private UserMapper mapper;

    @Test
    public void testRead(){
        UserVO vo = mapper.readForLogin("planner26@nate.com");

        log.info(vo);

    }
}
