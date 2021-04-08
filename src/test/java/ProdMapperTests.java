import com.ncncn.domain.BrandVO;
import com.ncncn.domain.CategoryVO;
import com.ncncn.domain.ProductVO;
import com.ncncn.mapper.ProdMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/applicationContext.xml")
@Log4j
public class ProdMapperTests {

	@Setter(onMethod_ = @Autowired)
	private ProdMapper mapper;

	@Test
	public void testGetCate(){

		CategoryVO category = mapper.getCate("010101");
		log.info(category);

	}


	@Test
	public void testGetBrandList(){

		mapper.getBrandList("01").forEach(brand -> log.info(brand));

	}

/*	@Test
	public void testGetGifti(){

		mapper.getGifti("01","1").forEach(gifti -> log.info(gifti));

	}*/




}
