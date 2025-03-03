Return-Path: <linux-aspeed+bounces-949-lists+linux-aspeed=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-aspeed@lfdr.de
Delivered-To: lists+linux-aspeed@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D9499A4F19B
	for <lists+linux-aspeed@lfdr.de>; Wed,  5 Mar 2025 00:36:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWl2mKJz3bx0;
	Wed,  5 Mar 2025 10:36:19 +1100 (AEDT)
X-Original-To: linux-aspeed@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip=160.75.25.115
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741098299;
	cv=fail; b=EWla/2JDgNkmYBQ+DEZ+X56JCFG9zBUmc4/+xbKUb2x0B7Bc5czxS+ejkk9ootXSdfqTx72/UqQ8jEovyE1Lt4mWhxLeEBUOi5vGl+L4obTRfb2sLS5wY9pdI91V321TBogA8YsDWVQ5KFDcL6DjPwuwxI7iWXUOF2wuhz/wc9oQr/Gpb62jsUdeT7XZ4wN0KUtQxBCb/kPNutJA6NutZHnX5c0Z/M42k1g5dtbCfPpPI5id2zS5HKtKpkm32ZJ418DPZrOZfOaSSqJS/WkcjVgxsezjGGt9E4asvuqUPsuZit8Cig+mj/LGUaFuUb+QHQXcgwrre8vgjuOOjwb6bA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741098299; c=relaxed/relaxed;
	bh=ChzWCAC/nneidv5nY92AltDK1p3xOBlts66BZXwSMHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgnxFozoZ8dCuDZiyf3xJcUmWsT0FiaKXsRr7vv3SS80dYxg9kuciEUUyZN0sY68abPYmaupTh/WlXAmhEhCvih3FxfMt7BwtKvyf6CAGP+H1K2rr6/PZagIeTy/0TrE2btWXT/W/6wDT3W6vhuZ3iUjIKjXMlRTBCIbX5gOEIvCoslnqpE6cMQ6zJ7dZHyhMhYdPMPYOZafXyDnU9Hip1VvATUMpiQ7deQR2VeDmduesWLjvWPe5PYeNdLLQPs4QzqUKPpLfP3G2YEQGfan9KRHdC4M3OL3jcpCK27F9I8dQEXs19KwftkDVMNGx+zZxsGeGi8YQ4LI/UzmQjoQPw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=fail (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HMuZyZAt reason="signature verification failed"; dkim-atps=neutral; spf=none (client-ip=160.75.25.115; helo=beeline1.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org) smtp.mailfrom=cc.itu.edu.tr
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=HMuZyZAt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=cc.itu.edu.tr (client-ip=160.75.25.115; helo=beeline1.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org)
X-Greylist: delayed 245 seconds by postgrey-1.37 at boromir; Wed, 05 Mar 2025 01:24:58 AEDT
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6dHZ6wTrz3089
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 01:24:58 +1100 (AEDT)
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id D5F6E40D5707
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 17:24:25 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dDx4DqszFwYD
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 17:22:41 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5FDE04272F; Tue,  4 Mar 2025 17:22:34 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMuZyZAt
X-Envelope-From: <linux-kernel+bounces-541874-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMuZyZAt
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 0BB234220E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:04:47 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 95BB4305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:04:47 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AFE3AA327
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784362135D8;
	Mon,  3 Mar 2025 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMuZyZAt"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553320FAB5;
	Mon,  3 Mar 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010656; cv=none; b=GmV0AsmW2GTu4hGxeL7c6lCLPQ+0aMelbzB7M7JhHpOi4bZl62lwAS5t6dvmQdJYtRuqzku6oKU09NLB9+L9d7y7wBnuQYJX71eVccCqwICsthdJ4tg2SIwCoaWliyVcCtlsx1xZoqWpQ6c8KM1zBAgTFRluviklXyLCI1G8NZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010656; c=relaxed/simple;
	bh=8k28ohh0BPSZHJHOBtNIM4qll2UGyVczMLoUtKSqo1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tj3AsVJiQnxZJpqmydaM9fIRa87U37Eu5BgQkgd3Vo5SQXoKbS7ltowDf0uK5GrNaXL4FKWT/KEb1cImx88i1CLDMWW0eGO6ZIyjPCWLLgDPRxOoY/bTmHZ7rgHczL8jGEuYr8F4ljHKmvg1vEvB3xR7pCqOjThsXoBSBLdJU+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMuZyZAt; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a823036so42853775e9.0;
        Mon, 03 Mar 2025 06:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741010652; x=1741615452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8k28ohh0BPSZHJHOBtNIM4qll2UGyVczMLoUtKSqo1k=;
        b=HMuZyZAt3+HrcqUH2wDsCmDpbKiFItBtr8/0V/WDq2g16LasV9IOnq+dO/GEWPSKtX
         kMi/Hb1xLCLX+4r3Z0nFzor101reg5Vd2Fn/1KoXe09FMx1g99ojWfM5hJ7kEGlUB2G4
         WOT3HRaQxMILVhsdYeD+t8a+o+JkQiTi4+VWVfo4KF1zUPnRnNbsDT5ZhvXf3lfAzDV8
         rRF5tPkrrumjlqxbyunrMHUoh5At7RMr228RzIUton2Mk5p7H4lvvqPiqvc823991v+h
         kPIUA48tjnZ8luNk8eNDW75+D7uqZamPoCvVUgTLeA/L1J0IB8EG0NXNePXUb99Vhw72
         tZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010652; x=1741615452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8k28ohh0BPSZHJHOBtNIM4qll2UGyVczMLoUtKSqo1k=;
        b=rAE9Fy76ozFyqo4amQLQObaKNJfrmaz9CEDMBLLl6LXlFp8FWq6+c4B2PNEMqNcIBx
         rylt3ohqvwadsc5S5DO2qu5mNzzVyNWjRgSlOv1L1E/iODVBcoqeyGMpXBjWQreWT6+y
         aMh+ZjfutmfOwO0hdzUWTpnJk5QuL4brYgJifO2s2uT0dxVSYUqvbkXTnNlqiFiY36tn
         daOAa5YiOUnpvZ+vQlSSahwNMtSrAMuihZ5iy5YyKG1SCZryQKVOrY+z/mfAFjRXkL79
         DeRmWizEmzXVnGvvI5q4luGd6BZaphDBoNT2194LtRfgFsRJMdSvseLvv82G7nIPQFvs
         aeVw==
X-Forwarded-Encrypted: i=1; AJvYcCUx+Ltl09t+5Okss6+7fhvMxHcP4/TKjLG8yV8m5iwyk7wA8MkILGsedHWlhMD+klp4veR8sd+zIDNZ0VkKvNSS9Zs=@vger.kernel.org, AJvYcCWXEfO8zwWZBXxXRvZC3JKmwvCGcIeS/lsXVLiDdqGHBB0EpLRn+j9koeVe2lXQ6PdcyLvBI6HBlHp9QEs=@vger.kernel.org, AJvYcCXa+ESqYlmieoKrmPM3Mv994053zyJSjMQdO4E72RrR8GFW8+i6U+r33OXCCPEh0Xxf45PLqKRaLXDF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl855ZvE7prsJAOtYRk0h6G57Za/l751DTqF2bnkVztmjaLM0h
	LAxE08UDXoNXUEA11BMtLH/Lq2CigUewbyJ+DO1XHAY3ue5tc6/B
X-Gm-Gg: ASbGncu/OS6VUzHuiuqjRaVH2h0Kp/kTAFvmKS0WwDvYoAJaFXayFkwilZSMn+gGa39
	qk6feCfTlkywqB4MG6APMmxla5M++u21ayfwKfbarUFghFvcrfeBkinHkVsreI0Ip78BgxOV8kB
	OJQWTsmNECGDKPYE1GQ+n2VW4Dg+8Km+m15/PNUJAVxCZf1oIrtZyyQbHMPCkighaH9rRrgque3
	nka7QrTooO5ERTIrbN8pPsgZmqhnRFS9PjnALK+nViUz2+wU2W4cZfb0r5sP5LEzxglc/dVd/lS
	H1RhGfv/RkutV8TqbQl99BX0ADAlPLFDzEh4TFOmWF/ZaOID8Ptlv0S2OMCmyEH5NuuImGMI+VO
	QnLI=
X-Google-Smtp-Source: AGHT+IHvcHXOSeKhHWMUt2xXWhTV53mo6yshUFDelmHEDhBHpCQfhR1rFavwoCbMnPzni4lL0cMigA==
X-Received: by 2002:a05:6000:1f8c:b0:38d:e48b:1783 with SMTP id ffacd0b85a97d-390eca27761mr8649282f8f.42.1741010652096;
        Mon, 03 Mar 2025 06:04:12 -0800 (PST)
Received: from ubuntu2204 (207-pool1.nat.godollo.uni-mate.hu. [192.188.242.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47960b6sm14936073f8f.17.2025.03.03.06.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 06:04:11 -0800 (PST)
Date: Mon, 3 Mar 2025 15:04:09 +0100
From: =?utf-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>
To: =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Hans Ulli Kroll <ulli.kroll@googlemail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Dianlong Li <long17.cool@163.com>, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 13/18] rtc: sd2405al: drop needless struct sd2405al::rtc
 member
Message-ID: <2gfjdazu2ohv4evd7iuk2dzexlydnd6yu3xmjk2lgsx3iws5sa@xdwf4df4ojck>
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
 <20250228-rtc-cleanups-v1-13-b44cec078481@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250228-rtc-cleanups-v1-13-b44cec078481@linaro.org>
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dDx4DqszFwYD
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741702968.82795@UYzycq/sjtRBl6OJQ4WogA
X-ITU-MailScanner-SpamCheck: not spam
X-Spam-Status: No, score=-0.8 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

Hi!

> We can drop it from the structure and just use a local temporary
> variable, reducing runtime memory consumption by a few bytes.

It works on real hardware.

Tested-by: T=F3th J=E1nos <gomba007@gmail.com>

Regards,
TJ



