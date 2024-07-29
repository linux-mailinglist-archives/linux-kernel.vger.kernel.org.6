Return-Path: <linux-kernel+bounces-265209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058F093EE01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8064A280CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8102112D75C;
	Mon, 29 Jul 2024 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Y2pCf0Mt"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECC86AE3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236830; cv=none; b=qSFMlV3mZKInQFJjdG/UfhKi94PaYYac/gwrqT0M6sxqX1smVpoWi/XLShIzm3xBnhiy2/+M9IZGq6R4AaiYstKub1o0DWqasdSkRlnwITTP33dOW3+QKi/hRi0X7D+miZxhMoTQy1dmIFjtGbvr6EmbFK7P4KcaOYAH7QIN0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236830; c=relaxed/simple;
	bh=QH6iVLDsFa2jo+SBqkx8ftjMcYybPbIGSfZAEccKHgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktHTN4tm03SaRWXTRAj5DjnNNTmB/uTv0mOiD9YeXR7jg1P+shQSYAbq5J9HRrT1kVm5YRUbPTdbzRM97IiQ8Zq0puFZZ6ITM3cFMqdWP/hQ1dEadcpyCsZ7UKlRQCXdigrKgxmRZWcqatGDxVVmcERqsx5Coh9RT56/2afruJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Y2pCf0Mt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236829; x=1753772829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QH6iVLDsFa2jo+SBqkx8ftjMcYybPbIGSfZAEccKHgc=;
  b=Y2pCf0MtGbvioUd3OQ7ObKo7dDgiGgJsDXbFDqhjTqis2+J5g64REaGK
   YBWDCA2+/LFyJZZRey3ONTiaIJNsIuhQl/gIDV8cvpzP8NHzjNFGEALot
   JujCaYiAKFJKjoDLnkVKL7oFsU2g9GcYWO3zqkr/FXXi04VfkuSuPbZ41
   +/yd/9ahU7t3V9CaKTWg9ym2P8hRJdniO3AQPGTeYWlFermvIc1HrgURY
   kncggZTdsFsEHcWAR5fO6MabWYCuDFeZJ7NEp339mjnuHmUE4j3rxXDy4
   jKJZ9D0KUpSGXLbEEeBbO6PfwRPSagoFFPGwMh6oTSLPmoflmp2g3lUwm
   w==;
X-CSE-ConnectionGUID: pQjOSLNzTjuj0oMDb/547w==
X-CSE-MsgGUID: bpiantCIRn6jzEOqMW+n7g==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="197213812"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:07:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:07:05 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:07:01 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Claudiu Beznea
	<claudiu.beznea@microchip.com>
Subject: [PATCH v6 06/27] ARM: at91: pm: add support for sam9x7 SoC family
Date: Mon, 29 Jul 2024 12:36:59 +0530
Message-ID: <20240729070659.1990506-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support and pm init config for sam9x7 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
Changes in v6:

- Sorted the compatibles alphanumerically.
---
 arch/arm/mach-at91/generic.h |  2 ++
 arch/arm/mach-at91/pm.c      | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 0c3960a8b3eb..acf0b3c82a30 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -12,6 +12,7 @@
 extern void __init at91rm9200_pm_init(void);
 extern void __init at91sam9_pm_init(void);
 extern void __init sam9x60_pm_init(void);
+extern void __init sam9x7_pm_init(void);
 extern void __init sama5_pm_init(void);
 extern void __init sama5d2_pm_init(void);
 extern void __init sama7_pm_init(void);
@@ -19,6 +20,7 @@ extern void __init sama7_pm_init(void);
 static inline void __init at91rm9200_pm_init(void) { }
 static inline void __init at91sam9_pm_init(void) { }
 static inline void __init sam9x60_pm_init(void) { }
+static inline void __init sam9x7_pm_init(void) { }
 static inline void __init sama5_pm_init(void) { }
 static inline void __init sama5d2_pm_init(void) { }
 static inline void __init sama7_pm_init(void) { }
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 345b91dc6627..b9b995f8a36e 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -233,6 +233,13 @@ static const struct of_device_id sama7g5_ws_ids[] = {
 	{ /* sentinel */ }
 };
 
+static const struct of_device_id sam9x7_ws_ids[] = {
+	{ .compatible = "microchip,sam9x7-rtc",		.data = &ws_info[1] },
+	{ .compatible = "microchip,sam9x7-rtt",		.data = &ws_info[4] },
+	{ .compatible = "microchip,sam9x7-gem",		.data = &ws_info[5] },
+	{ /* sentinel */ }
+};
+
 static int at91_pm_config_ws(unsigned int pm_mode, bool set)
 {
 	const struct wakeup_source_info *wsi;
@@ -1361,6 +1368,7 @@ static const struct of_device_id atmel_pmc_ids[] __initconst = {
 	{ .compatible = "atmel,sama5d4-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "atmel,sama5d2-pmc", .data = &pmc_infos[1] },
 	{ .compatible = "microchip,sam9x60-pmc", .data = &pmc_infos[4] },
+	{ .compatible = "microchip,sam9x7-pmc", .data = &pmc_infos[4] },
 	{ .compatible = "microchip,sama7g5-pmc", .data = &pmc_infos[5] },
 	{ /* sentinel */ },
 };
@@ -1499,6 +1507,27 @@ void __init sam9x60_pm_init(void)
 	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
 }
 
+void __init sam9x7_pm_init(void)
+{
+	static const int modes[] __initconst = {
+		AT91_PM_STANDBY, AT91_PM_ULP0,
+	};
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_SOC_SAM9X7))
+		return;
+
+	at91_pm_modes_validate(modes, ARRAY_SIZE(modes));
+	ret = at91_dt_ramc(false);
+	if (ret)
+		return;
+
+	at91_pm_init(NULL);
+
+	soc_pm.ws_ids = sam9x7_ws_ids;
+	soc_pm.config_pmc_ws = at91_sam9x60_config_pmc_ws;
+}
+
 void __init at91sam9_pm_init(void)
 {
 	int ret;
-- 
2.25.1


