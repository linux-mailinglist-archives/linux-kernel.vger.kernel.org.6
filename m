Return-Path: <linux-kernel+bounces-175486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA678C205D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8697728305D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275AE16D330;
	Fri, 10 May 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="QpzNiE2k"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CDA15FA9D;
	Fri, 10 May 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332195; cv=none; b=d6mPBdrbN0h7sRsAUp+91jcJFwguizabrguIgBv5pIiEocRiVNdF+1TxJMAew3KdHtNQiyGExtKCBlqLaPDDZHbc0Jy+IR/6qvHCoK1rPUghGqcDdwZYphlS60/RX/LX9IpiX8dG0IjW/fE+5JwSNZqJ5+q8wZrPOF1HI5b//tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332195; c=relaxed/simple;
	bh=TJg16k9up5iAADLfXxJqpl2ySGKF8ytj+xyo5UoGrSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvUJ6SJkCr/JA8nRZXqrB1DYQOqT7hzZtM8jBEzdB3B/yh3+IMVFhJ2kI9Z+o9xWgeHdq7vDmdwf1tF6vnGIIRqEZBED24GCyDV8HK4iHmBY8mtWXOVwjJ9lGDZyGLEqOVxx0v/5CswCw9DhX5kNxINsmq5Pbp27ZsGwRiSfmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=QpzNiE2k; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 58979120006;
	Fri, 10 May 2024 12:09:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 58979120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715332185;
	bh=xuKBJ+Bt7jmJARjlnxEbw3uFcDYRdaA63r8bHT466l4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=QpzNiE2kIFpaNZGEJDgHBb7Kz5SBqgllVAQ/wikquAbYbdOnvQFhSapdpQyNHmwOK
	 i+6WMaSTXcgWeQL0NamulATPa528LU/9wQoxgq1gd+2XJrRUJyI7qafpq+pQj7Fhb+
	 N3Obeyt978aP0GFVkQqOdlV4eYwFLNMd14kWp98MBLz457EF43MlWrugeUfxYDo+vi
	 Nw5rSVHHEHx4fAQwGYrU+Z4SbH/0py1jVrWW8fI6+3r6a9pHoYwwc4jhEIx+gAJPPh
	 /tB96/V0yuYzOFaQbtxAILsKcNqsLV+FmhF7I0XLcx58WiN8mXiLt4TbK960UtdEYS
	 a77d1WXCVnq4A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 May 2024 12:09:45 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 10 May 2024 12:09:44 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <jian.hu@amlogic.com>, <kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v2 5/7] clk: meson: a1: peripherals: support 'sys_pll_div16' clock as GEN input
Date: Fri, 10 May 2024 12:08:57 +0300
Message-ID: <20240510090933.19464-6-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510090933.19464-1-ddrokosov@salutedevices.com>
References: <20240510090933.19464-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185158 [May 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/10 07:36:00 #25144647
X-KSMG-AntiVirus-Status: Clean, skipped

The clock 'sys_pll_div16' is one of the parents of the GEN clock. It is
generated in the A1 PLL clock controller with a fixed factor.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 drivers/clk/meson/a1-peripherals.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
index 621af1e6e4b2..3c4452f2b146 100644
--- a/drivers/clk/meson/a1-peripherals.c
+++ b/drivers/clk/meson/a1-peripherals.c
@@ -747,13 +747,13 @@ static struct clk_regmap fclk_div2_divn = {
 };
 
 /*
- * the index 2 is sys_pll_div16, it will be implemented in the CPU clock driver,
  * the index 4 is the clock measurement source, it's not supported yet
  */
-static u32 gen_table[] = { 0, 1, 3, 5, 6, 7, 8 };
+static u32 gen_table[] = { 0, 1, 2, 3, 5, 6, 7, 8 };
 static const struct clk_parent_data gen_parent_data[] = {
 	{ .fw_name = "xtal", },
 	{ .hw = &rtc.hw },
+	{ .fw_name = "sys_pll_div16", },
 	{ .fw_name = "hifi_pll", },
 	{ .fw_name = "fclk_div2", },
 	{ .fw_name = "fclk_div3", },
-- 
2.43.0


