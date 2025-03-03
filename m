Return-Path: <linux-aspeed+bounces-933-lists+linux-aspeed=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-aspeed@lfdr.de
Delivered-To: lists+linux-aspeed@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43992A4E572
	for <lists+linux-aspeed@lfdr.de>; Tue,  4 Mar 2025 17:19:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6gqB4Ss0z2xDD;
	Wed,  5 Mar 2025 03:19:02 +1100 (AEDT)
X-Original-To: linux-aspeed@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=160.75.25.116 arc.chain=subspace.kernel.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741105142;
	cv=pass; b=ZBOilo8RjfNobTY9+9cH4dFauSJdtWg61IGADoTfeek2TewwQCMnU7NQUx1KTDa+fVyLwExrw2uSccJVtzMfOytUVR1/Cx8lPqN7CfR29kgJLjrGRJ7piOMKGciJ8eDuW6RLnNMDz1bMe+klNjfG6naQ1LbVTDPQhTrjMFL/dUvtxMt15gsTHEY50qGzKgRuD2J7ScuPkcou3PECP1SW/j+I7VvPA+b+K//SrS2+XZaRG0zXn2m1Sfci7zCjeMUHumKcrHDFlkJuZM8kqW2mmsZtXb9kiwggm1Llp67rwpfroUm+E0U643KCYTQgiSRZCW2tMiclHqvL/cXVrIu9pQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741105142; c=relaxed/relaxed;
	bh=lfos9Syg08SqOn+//RWYzG2n1+EfVqjsyXohmBPCw+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBdlcomAHv68EAJGaUpUdyLgxXFIAT0CqX4bQLvbAJByveJFTucZkg+IPjIn8PXg85A4CdlkSgo6UmRE0ahrZ8VCk0NPxK4zA6/+oltyPXBXd0iIu7nnMefCcpO5HlVASFW1VFBP72/PdyhKALZpRXmZ04M1p7dywlRLIGBFrN4UW7Hct+VxDIJj4yAliNxYo3MfbWSYMJX7gS3SOPTcwzvqMrjyebPLGUh1tKya+K9j7DukDlUq+kgVQAI2S2wBWKbaztvyaFDwNwcQU0rNEyP4KS1zpZfcfwc+R+aHSrziplQIy1fK0p5l7jOCBfAZRmpv5rfpEC01HeeptBWoqQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=NbLTLPSf; dkim-atps=neutral; spf=none (client-ip=160.75.25.116; helo=beeline2.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org) smtp.mailfrom=cc.itu.edu.tr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=NbLTLPSf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=cc.itu.edu.tr (client-ip=160.75.25.116; helo=beeline2.cc.itu.edu.tr; envelope-from=root@cc.itu.edu.tr; receiver=lists.ozlabs.org)
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6gq93t43z2xCW
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 03:19:01 +1100 (AEDT)
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 5AEC4408B660
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 19:18:29 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gk645z4zG2KS
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 19:14:38 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id D4E6042720; Tue,  4 Mar 2025 19:14:32 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NbLTLPSf
X-Envelope-From: <linux-kernel+bounces-541795-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NbLTLPSf
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id BF22441FB4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:23:10 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 8CE3A305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:23:10 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D18318979A6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2464C21638A;
	Mon,  3 Mar 2025 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NbLTLPSf"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1016214A70
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007934; cv=none; b=fj5CeuD1CAgGmefzefE1V6xBsmIgawe/caqCaO9fAJ9OVkp22SsjECHyFPF2g+DsNpTtG0BucqyPGeowp6UU/VnUuK9+K2p9C1LEeAYccVjrhJlP6cVU8x8U5GUvXJyzL8D9Bl2b07mBl41xVQuLPLG6vaFqQDpddMcsgzRMz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007934; c=relaxed/simple;
	bh=vlo1sOpINhYxlANjGKB2TZCc7AQtX8YGKke1Q97h0SI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HbmF3oKq6P+C/ApUoWBLPyd3/6uJO9aNQe7GSTzkMHTF35ENILSm3D54Poseio7PCMwQEWxGkBUbN/ZBXbjxFrDVuHBjXm5TpcavoQp1WK1JCPxX3VNxPoAk87DHmWnYOXrQHe6f9FABUm+cy9sJo/wbPsdNqR/8clVWAAB7050=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NbLTLPSf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bbb440520so11702655e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 05:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741007931; x=1741612731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfos9Syg08SqOn+//RWYzG2n1+EfVqjsyXohmBPCw+w=;
        b=NbLTLPSfsZw69VITbK91w98F7jLMKxNfPwJ4DPzT4Old3sMPOSPCztmr5KZ5R4+9No
         9MOkrBbyOkLWQQLBT938GX6x70o9XouCO25ew7nbLA1iY3Z/ISLvNYcSRw/55xXalAaN
         8IDM4pPS3pQb4NaWPRP0SW6mmbzGU+JcyX6Xy1EkFAZqaZATm1LpgIMZV/e9Qm9M5ODS
         PvxjUBviaUjFO3yYA39z2QzlAPz6Eo0/v6ViNVZQ2FQVt7RslQiNK+lM766KvjqlN3gG
         UYeqpvsLzaFITEZUXXjnNMcsPGxTS3fwaOu+43dnQJpf6o9vlrvlWUfvqBirrVLl5vGs
         Lg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741007931; x=1741612731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfos9Syg08SqOn+//RWYzG2n1+EfVqjsyXohmBPCw+w=;
        b=BNcCOYyL4o7Uz4+8BnGNFqinv8SIcuaUkHe3RP9kD4+qFr8Dt6Gfe1DmMq7T1nZCpy
         yooCA2R/igQ+g59xVGsLtdvDNbBYmEyRtV2bDxOHHBbdxnEiKAomdRE8XWC6R+leouY1
         bcqb8P9tCiAvTyqgfG76Z7nCvg+z9vRdD4U5zJA1BVCXeTAmmj6RkqX1Uv85o+fxOpEr
         enAr7hlvEDXa7h1C1MR5rd7w2Q9MI+KHURT1SRyWSEM/BZfV1/9XdOjq0OHMfjFHDuFi
         UqUjTkfIZhJol30VHsuZCCT9w52HtV2cS8kkz8tJ/a9cDQlcHS3KBnZ3q88eqEOZljUZ
         NklQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+z1UfC9hOtRK1nsJXGsT1W/fGz+jIF6pGo4yjah825UF1M0JKojn/wXpa99HMwIZi3Ewtpnv2f223f/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMZ4uyM+c1375FCrrOgUSrq8IjXLERwYaZ3UVr37Cae1v3AxS
	zPyV6oi/HbU6mbpa3F/CIUJFgUDL6U+kCGVwnZtpgx+Gbr38yieEQlYwAh7OLv8=
X-Gm-Gg: ASbGncvejNFj42CILpiNzBgGDRYXx6p65TsPWSLZLgNYmEl534WyfDEtbLQqVu/Lfct
	Hu8fRM1fBkC9p/Ff9jO2uKxyLThRMYQLy6oTlZnoeTDh7ljQWOrCxCfx4pJxcSbRuUVtp6+KtoA
	6lTW3oD3aS3dg/5dVtFAv5Wlr9yn4A41WU4gTbzSbYTyazNBdh1qy87PLuI+ZvhjITQDegoHklP
	XHL4FjY6GIkJOfE6JN891u/AnLa8A945LpMF66o+72IEtXf2ZU50MUuk99xOolw/Yq5LLZbbk/j
	M93Kg1GVQKZ2XDlsKiCKTB4juGx1W1IRbd+1Bw==
X-Google-Smtp-Source: AGHT+IHXK2frQu5mm5st7OG50mDUgW+ZqOAgaKWtdnfNsGdx2IIR5+MeX+T68WRmGU9N2Zhz+vD07w==
X-Received: by 2002:a05:600c:45cc:b0:439:9ee1:86bf with SMTP id 5b1f17b1804b1-43ba7c9b8e2mr134577995e9.7.1741007931114;
        Mon, 03 Mar 2025 05:18:51 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:664a:9e92:6aa8:6007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba538b9fsm194821915e9.17.2025.03.03.05.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:18:50 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Mar 2025 14:18:37 +0100
Subject: [PATCH 12/15] gpio: aspeed: use lock guards
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-gpiochip-set-conversion-v1-12-1d5cceeebf8b@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
In-Reply-To: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mun Yew Tham <mun.yew.tham@intel.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=10512;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=6Biyqx/oPiy1u29C0+kNxd6YeuL0GXYE5IHU8R6GPkQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnxawre/nLb8HZ9vCTWG9HgoFrpXBkyMmO3uPg+
 DkbCvt+1bmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ8WsKwAKCRARpy6gFHHX
 ct7sD/9yKqknbydRuHgo09mRDQLljVd2RW0HD61Q3y+e/L/B6cyQnjzZKT5uGJ+v6h4lgQv+iXU
 ka+2zeotaUUZDupvz+c5QV5Z7LA8/PWAP3O7uVp9pdDlIJ9GsdOQg9KbFeQZsTOfhMKXfQTt6PY
 z0o7Fa+2lJh1TS+J24HnpMcUWXqI1Nu1N3tBj9XiBcJspKwP0iDeP3a2KjMUw3cNX+EPK7a47J3
 Snyjbs5wm8baI0fqmEyKL4pt1rZZ5mWecGL4VVpLMLZiCBTrIa+LgvxNGHkL+gKevzXYUnoYKR3
 tZKeMyE69KAyE/ZOB1tvR5UmGrw7vjpuPJMpcG4eAIIJswazrvDydIqT4M43TPIevqtqhgQg/YE
 6vp6cHKqSigeHfJcLF+msUCUvTtjmSKGBGp0LupdS+uPASKA/O/cfZx4v5tIeG2nPSnQZZl6tqR
 SIJHEXkhxoclh99WGXVu0GM2vsR9nl22pgPSYkKIwUzKV2epGnm+RVZZYhddELQ3fVhplnYWUnK
 s6bz7bNOSah0XlLT3p4hQp5s/jkOPlPszWSIJcnxeh5Q05zwmcgbdo4MF2vZBX0iaeCd4y+NI9X
 c6vgDAzA8oJ1o3lkJ5HWlhwdW/fj54pLrh+XXHSZ+a05AcdBd1vi1UyJ5kHAKf8jITmDJdjkq45
 NxSkq37b/jMxB8Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gk645z4zG2KS
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741709789.15031@eP90SjsqrNpcHvZ7A0eG1w
X-ITU-MailScanner-SpamCheck: not spam
X-Spam-Status: No, score=-1.0 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reduce the code complexity by using automatic lock guards with the raw
spinlock.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-aspeed.c | 101 +++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 63 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 40c1bd80f8b0..e2535aad1026 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -5,6 +5,7 @@
  * Joel Stanley <joel@jms.id.au>
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/gpio/aspeed.h>
 #include <linux/gpio/driver.h>
@@ -427,37 +428,33 @@ static void aspeed_gpio_set(struct gpio_chip *gc, unsigned int offset,
 			    int val)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
-	unsigned long flags;
 	bool copro = false;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
+
 	copro = aspeed_gpio_copro_request(gpio, offset);
 
 	__aspeed_gpio_set(gc, offset, val);
 
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 }
 
 static int aspeed_gpio_dir_in(struct gpio_chip *gc, unsigned int offset)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
-	unsigned long flags;
 	bool copro = false;
 
 	if (!have_input(gpio, offset))
 		return -ENOTSUPP;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	copro = aspeed_gpio_copro_request(gpio, offset);
 	gpio->config->llops->reg_bit_set(gpio, offset, reg_dir, 0);
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
 
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
-
 	return 0;
 }
 
@@ -465,13 +462,12 @@ static int aspeed_gpio_dir_out(struct gpio_chip *gc,
 			       unsigned int offset, int val)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
-	unsigned long flags;
 	bool copro = false;
 
 	if (!have_output(gpio, offset))
 		return -ENOTSUPP;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	copro = aspeed_gpio_copro_request(gpio, offset);
 	__aspeed_gpio_set(gc, offset, val);
@@ -479,7 +475,6 @@ static int aspeed_gpio_dir_out(struct gpio_chip *gc,
 
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 
 	return 0;
 }
@@ -487,7 +482,6 @@ static int aspeed_gpio_dir_out(struct gpio_chip *gc,
 static int aspeed_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(gc);
-	unsigned long flags;
 	u32 val;
 
 	if (!have_input(gpio, offset))
@@ -496,12 +490,10 @@ static int aspeed_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 	if (!have_output(gpio, offset))
 		return GPIO_LINE_DIRECTION_IN;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	val = gpio->config->llops->reg_bit_get(gpio, offset, reg_dir);
 
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
-
 	return val ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
 }
 
@@ -527,7 +519,6 @@ static inline int irqd_to_aspeed_gpio_data(struct irq_data *d,
 static void aspeed_gpio_irq_ack(struct irq_data *d)
 {
 	struct aspeed_gpio *gpio;
-	unsigned long flags;
 	int rc, offset;
 	bool copro = false;
 
@@ -535,20 +526,19 @@ static void aspeed_gpio_irq_ack(struct irq_data *d)
 	if (rc)
 		return;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
+
 	copro = aspeed_gpio_copro_request(gpio, offset);
 
 	gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_status, 1);
 
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 }
 
 static void aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)
 {
 	struct aspeed_gpio *gpio;
-	unsigned long flags;
 	int rc, offset;
 	bool copro = false;
 
@@ -560,14 +550,14 @@ static void aspeed_gpio_irq_set_mask(struct irq_data *d, bool set)
 	if (set)
 		gpiochip_enable_irq(&gpio->chip, irqd_to_hwirq(d));
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
+
 	copro = aspeed_gpio_copro_request(gpio, offset);
 
 	gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_enable, set);
 
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 
 	/* Masking the IRQ */
 	if (!set)
@@ -591,7 +581,6 @@ static int aspeed_gpio_set_type(struct irq_data *d, unsigned int type)
 	u32 type2 = 0;
 	irq_flow_handler_t handler;
 	struct aspeed_gpio *gpio;
-	unsigned long flags;
 	int rc, offset;
 	bool copro = false;
 
@@ -620,16 +609,19 @@ static int aspeed_gpio_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
-	copro = aspeed_gpio_copro_request(gpio, offset);
+	scoped_guard(raw_spinlock_irqsave, &gpio->lock) {
+		copro = aspeed_gpio_copro_request(gpio, offset);
 
-	gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_type0, type0);
-	gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_type1, type1);
-	gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_type2, type2);
+		gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_type0,
+						 type0);
+		gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_type1,
+						 type1);
+		gpio->config->llops->reg_bit_set(gpio, offset, reg_irq_type2,
+						 type2);
 
-	if (copro)
-		aspeed_gpio_copro_release(gpio, offset);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
+		if (copro)
+			aspeed_gpio_copro_release(gpio, offset);
+	}
 
 	irq_set_handler_locked(d, handler);
 
@@ -686,17 +678,16 @@ static int aspeed_gpio_reset_tolerance(struct gpio_chip *chip,
 					unsigned int offset, bool enable)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
-	unsigned long flags;
 	bool copro = false;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
+
 	copro = aspeed_gpio_copro_request(gpio, offset);
 
 	gpio->config->llops->reg_bit_set(gpio, offset, reg_tolerance, enable);
 
 	if (copro)
 		aspeed_gpio_copro_release(gpio, offset);
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 
 	return 0;
 }
@@ -798,7 +789,6 @@ static int enable_debounce(struct gpio_chip *chip, unsigned int offset,
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
 	u32 requested_cycles;
-	unsigned long flags;
 	int rc;
 	int i;
 
@@ -812,12 +802,12 @@ static int enable_debounce(struct gpio_chip *chip, unsigned int offset,
 		return rc;
 	}
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	if (timer_allocation_registered(gpio, offset)) {
 		rc = unregister_allocated_timer(gpio, offset);
 		if (rc < 0)
-			goto out;
+			return rc;
 	}
 
 	/* Try to find a timer already configured for the debounce period */
@@ -855,7 +845,7 @@ static int enable_debounce(struct gpio_chip *chip, unsigned int offset,
 			 * consistency.
 			 */
 			configure_timer(gpio, offset, 0);
-			goto out;
+			return rc;
 		}
 
 		i = j;
@@ -863,34 +853,26 @@ static int enable_debounce(struct gpio_chip *chip, unsigned int offset,
 		iowrite32(requested_cycles, gpio->base + gpio->config->debounce_timers_array[i]);
 	}
 
-	if (WARN(i == 0, "Cannot register index of disabled timer\n")) {
-		rc = -EINVAL;
-		goto out;
-	}
+	if (WARN(i == 0, "Cannot register index of disabled timer\n"))
+		return -EINVAL;
 
 	register_allocated_timer(gpio, offset, i);
 	configure_timer(gpio, offset, i);
 
-out:
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
-
 	return rc;
 }
 
 static int disable_debounce(struct gpio_chip *chip, unsigned int offset)
 {
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
-	unsigned long flags;
 	int rc;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	rc = unregister_allocated_timer(gpio, offset);
 	if (!rc)
 		configure_timer(gpio, offset, 0);
 
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
-
 	return rc;
 }
 
@@ -961,7 +943,6 @@ int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc,
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
 	int rc = 0, bindex, offset = gpio_chip_hwgpio(desc);
 	const struct aspeed_gpio_bank *bank = to_bank(offset);
-	unsigned long flags;
 
 	if (!aspeed_gpio_support_copro(gpio))
 		return -EOPNOTSUPP;
@@ -974,13 +955,12 @@ int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc,
 		return -EINVAL;
 	bindex = offset >> 3;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	/* Sanity check, this shouldn't happen */
-	if (gpio->cf_copro_bankmap[bindex] == 0xff) {
-		rc = -EIO;
-		goto bail;
-	}
+	if (gpio->cf_copro_bankmap[bindex] == 0xff)
+		return -EIO;
+
 	gpio->cf_copro_bankmap[bindex]++;
 
 	/* Switch command source */
@@ -994,8 +974,6 @@ int aspeed_gpio_copro_grab_gpio(struct gpio_desc *desc,
 		*dreg_offset = bank->rdata_reg;
 	if (bit)
 		*bit = GPIO_OFFSET(offset);
- bail:
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(aspeed_gpio_copro_grab_gpio);
@@ -1009,7 +987,6 @@ int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc)
 	struct gpio_chip *chip = gpiod_to_chip(desc);
 	struct aspeed_gpio *gpio = gpiochip_get_data(chip);
 	int rc = 0, bindex, offset = gpio_chip_hwgpio(desc);
-	unsigned long flags;
 
 	if (!aspeed_gpio_support_copro(gpio))
 		return -EOPNOTSUPP;
@@ -1021,21 +998,19 @@ int aspeed_gpio_copro_release_gpio(struct gpio_desc *desc)
 		return -EINVAL;
 	bindex = offset >> 3;
 
-	raw_spin_lock_irqsave(&gpio->lock, flags);
+	guard(raw_spinlock_irqsave)(&gpio->lock);
 
 	/* Sanity check, this shouldn't happen */
-	if (gpio->cf_copro_bankmap[bindex] == 0) {
-		rc = -EIO;
-		goto bail;
-	}
+	if (gpio->cf_copro_bankmap[bindex] == 0)
+		return -EIO;
+
 	gpio->cf_copro_bankmap[bindex]--;
 
 	/* Switch command source */
 	if (gpio->cf_copro_bankmap[bindex] == 0)
 		aspeed_gpio_change_cmd_source(gpio, offset,
 					      GPIO_CMDSRC_ARM);
- bail:
-	raw_spin_unlock_irqrestore(&gpio->lock, flags);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(aspeed_gpio_copro_release_gpio);

-- 
2.45.2



