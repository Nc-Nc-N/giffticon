package com.ncncn.domain.response;

import com.ncncn.domain.StatisticsVO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AdminMainDTO {

	private StatisticsVO statisticsVO;

	private int countRecentlyRegister;

	private int countNotYetApproved;

	private int countHaveNoAns;

}
