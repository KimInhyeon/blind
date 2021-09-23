package com.ksinfo.blind.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import java.util.Set;

@Component
@PropertySource(value = "classpath:badWords.properties", encoding = "UTF-8")
public final class BadWordsUtil {
	private final Set<String> badWords;

	public BadWordsUtil(@Value("${badWords}") Set<String> badWords) {
		this.badWords = badWords;
	}

	public boolean isContainsBadWord(String word) {
		return badWords.stream().anyMatch(word::contains);
	}
}