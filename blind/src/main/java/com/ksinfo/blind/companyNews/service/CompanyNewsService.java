package com.ksinfo.blind.companyNews.service;

import com.ksinfo.blind.companyNews.vo.CompanyNewsVO;
import com.ksinfo.blind.util.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@Service
public class CompanyNewsService {
	private static final int recordLimit = 10;
	private static final int pagination = 5;
	private final String baseUrl;

	@Autowired
	public CompanyNewsService(@Value("${NewsAPIKey}") String key) {
		StringBuilder sb = new StringBuilder(104);
		baseUrl = sb.append("https://newsapi.org/v2/everything")
					.append("?apiKey=").append(key)
					.append("&pageSize=").append(recordLimit)
					.append("&from=")
					.toString();
	}

	public Map<String, Object> getCompanyNews(String companyName, int page) {
		StringBuilder sb = new StringBuilder(baseUrl);
//		sb.append(LocalDate.now().minusYears(1)); // ビジネスプラン
		sb.append(LocalDate.now().minusMonths(1)); // デベロッパープラン
		sb.append("&q=").append(companyName);
		if (page > 1) {
			sb.append("&page=").append(page);
		}

		WebClient webClient = WebClient.create(sb.toString());
		CompanyNewsVO companyNewsVO = webClient.get().retrieve().bodyToMono(CompanyNewsVO.class).block();
		PageNavigator navi = new PageNavigator(page, companyNewsVO.getTotalResults(), recordLimit, pagination);

		Map<String, Object> companyNews = new HashMap<>(2);
		companyNews.put("articles", companyNewsVO.getArticles());
		companyNews.put("navi", navi);

		return companyNews;
	}
}