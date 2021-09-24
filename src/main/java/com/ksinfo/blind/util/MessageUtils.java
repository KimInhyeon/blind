package com.ksinfo.blind.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.Locale;

@Component
public final class MessageUtils {
    private final MessageSource messageSource;
    private MessageSourceAccessor accessor;

    @Autowired
    public MessageUtils(MessageSource messageSource) {
        this.messageSource = messageSource;
    }

    @PostConstruct
    private void init() {
        accessor = new MessageSourceAccessor(messageSource, Locale.JAPAN);
    }

    public String getMessage(String code) {
        return accessor.getMessage(code);
    }
}