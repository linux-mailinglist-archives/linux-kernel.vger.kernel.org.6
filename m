Return-Path: <linux-kernel+bounces-409660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8558C9C908C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BFBB3979C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F2188A15;
	Thu, 14 Nov 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="rzvOSwCY"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7D18755F;
	Thu, 14 Nov 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601777; cv=none; b=unoM7Wynfqp1HzTcca09tbDWpwBDseI0rkNN2zva4ewrCEswuj3FxPqPt1ZTTIeMlIXqZOeRlcGvQcX68A2z9sukU7OCl+VQ/97/wEPWBCkywTg01xUMCcmMGmBx0s2fmqNZYEjNMLJoVHswI4otzZ60XNRK+sxHv/2OSeoPh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601777; c=relaxed/simple;
	bh=3dBJGEOHp634LoWY4JbZqaFzLOIKh4oKWOY58Uo4Zms=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UyklJ3pOgdk+z/OgxU3uygLtFpXG6YMhCVICFyINR+zCfpLMlHY3yl9SCHQM+pq2BI2twlticJE0cSr4GkLmS815dq+OVw4m2BBzcWz60YtA99eMoAyqgZTnKq7xTo3P9eRhqrNccjPfKUIZhKEVbpnJaOyXe49K8XLQzhzGJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=rzvOSwCY; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id EC46D12000B;
	Thu, 14 Nov 2024 19:29:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EC46D12000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731601772;
	bh=DOSHt+MVfqoI6yUFl7+wi3kWGpaEllOtAf6f4LEbPEc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=rzvOSwCYK/zMLnQrueRDbBS95+kMns5Op0wLS1mA4qqbvlQVtFI5qo/3CrR2FCWSZ
	 JX6a7Jz0n1kHn2Qyt4OoLb+i28bacSjb+wfvgdkYpTy7CGwnSItJ9fqhuRcUPoyQ5a
	 vcht/sWqWCIFm3lpq4XMNFiR0MHpHzyE5a1dAUEhYMG/k5Ok99TqVXCiADkFZnfCwL
	 Jm7MSvlJZPldihhF6N/Fnid1uno3wjQRv2zp+txJSHKNtx2zZntb4gjpAJ6qapH4i2
	 PF/YmgcLGzrKG1ysrsTpin9s9U9aZNBnbO5V8k1+mY4PY07QnRx+lHjOj+wQiGCHIz
	 UYP5zySafFU/w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 14 Nov 2024 19:29:32 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH 1/3] clk: amlogic: axg-audio: use dev_err_probe()
Date: Thu, 14 Nov 2024 19:29:24 +0300
Message-ID: <20241114162926.3356551-2-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114162926.3356551-1-jan.dakinevich@salutedevices.com>
References: <20241114162926.3356551-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189183 [Nov 14 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_smtp_not_equal_from}, salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:7.1.1,5.0.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/14 14:31:00 #26861614
X-KSMG-AntiVirus-Status: Clean, skipped

Replace dev_err() with dev_err_probe() to simplify the code.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/clk/meson/axg-audio.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 7714bde5ffc0..05a72a199ebd 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -1714,10 +1714,8 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 
 	axg_audio_regmap_cfg.max_register = data->max_register;
 	map = devm_regmap_init_mmio(dev, regs, &axg_audio_regmap_cfg);
-	if (IS_ERR(map)) {
-		dev_err(dev, "failed to init regmap: %ld\n", PTR_ERR(map));
-		return PTR_ERR(map);
-	}
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map), "failed to init regmap\n");
 
 	/* Get the mandatory peripheral clock */
 	clk = devm_clk_get_enabled(dev, "pclk");
@@ -1725,10 +1723,8 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 
 	ret = device_reset(dev);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to reset device\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to reset device\n");
 
 	/* Populate regmap for the regmap backed clocks */
 	for (i = 0; i < data->regmap_clk_num; i++)
@@ -1746,10 +1742,9 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 		name = hw->init->name;
 
 		ret = devm_clk_hw_register(dev, hw);
-		if (ret) {
-			dev_err(dev, "failed to register clock %s\n", name);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to register clock %s\n",
+					     name);
 	}
 
 	ret = devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, (void *)&data->hw_clks);
-- 
2.34.1


