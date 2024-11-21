Return-Path: <linux-kernel+bounces-416566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D17EC9D46F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EFD282418
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5552713BACC;
	Thu, 21 Nov 2024 04:48:21 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2133.outbound.protection.partner.outlook.cn [139.219.17.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF4230986;
	Thu, 21 Nov 2024 04:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732164500; cv=fail; b=fbc8sBWPtNzJ+bqKWSZ2/aJKkLGAD6uIoaB6ChbU2UNixFVc6x2nkBJjS4KWMx6XnimtyqIO7y1TEbaM6FY9C9iRHGltUt2g/VGi1yMcjyYSr8pZg4Z4hI9Glf7qnxGw3Ct37nGR09guAFeVzUZJOdY9LTKMmOSm/cQ1uhVTr2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732164500; c=relaxed/simple;
	bh=ypyZePgswkaywOqNH7VkLDs+tCfYZSvHKduRG6VQKHc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EzAao3LJFPMU90QEkoOLoPXl7j8OWSqF+V3bB+QzLYn9nbFu3JvXxD4HrleqFEBNXA0VEu9iKbjfA/+VrwJ8h85Ien/rc/2SadTskXih0Y2cuQZ/vutAbz+xkAi8R9KQLNdyNL4kp0R8Z8kdXQixmhny1i2AJRLsK4tVpPGMaVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7mcmdr23ifct5ZxRM2vJWsR9xrqUnrKVaBBIOF5cE980bpl78vpb/rHb0KicOkBPyXPkvyWshdj3K7jhWBkOPButeJSI3gxUadN7OrrpWAR2yinsPVf9Xa+nu7zNa5apa9TdiHoe15CVk4+O1FZOuguhhM2TgZIGTUS2VVIf/rEHjkHJIStbONMswY3DjRQgH7sM0U5vEBzQvc6khn+wR/+8o4Uo9aXDas/adpNqGEYDcMFCigpYEo92tTv+othK0RJLhx5sb2vNyxuk7p5qedVObi6Wtkst9cnjw6VaKv6IsqU7ZKiG7E//sZ4h5YECg9bq2IlNELLsPutuZXwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TcuRXNc7CqsSLj+7qbK43KgLEKW2ltnrwkbSDaje0M=;
 b=QQITA+QyLbM82gZ1Ec2hPrNvZisngBjZsAfmrfubjInHgiWNtGGrKL5nrK5Fywu87ZZiZX82dH+125ddii8yDA7wH/7gvzAEBPbPCFgiihzxejOhl6YbCSYpiTSo7MQnwwGueBBhxz8dQdDi9wjqRIOOWbnaP+xBpbTOnIVEcoXDy01DkL0iZZgtCs2lRbEzN0pDqhtBonUxnR1UFhJg7pa8P0GN4nLQk2CvShtQRZ3t/DUqx8Y4JQWF8NpFjjJWCDOz7B/TwUT9aVEG9bIVlcZm5z45NO4QHCcnWtCsn53u7+Hly1akvUPWna54ET2k3HgvRgTlIXCruLvTrDbf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1173.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25; Thu, 21 Nov
 2024 03:14:43 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%4])
 with mapi id 15.20.8158.024; Thu, 21 Nov 2024 03:14:43 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH] clk: starfive: Make _clk_get become a common helper function
Date: Wed, 20 Nov 2024 19:14:26 -0800
Message-Id: <20241121031426.36588-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::36) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1173:EE_
X-MS-Office365-Filtering-Correlation-Id: ec3f5cd2-3575-41e6-6804-08dd09daa4c7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|41320700013|38350700014;
X-Microsoft-Antispam-Message-Info:
	G9zPLgOqs68IrU96Yo4MDMbsQLMpTnzpF0ysakNylByC3wCXb7687gbfs8vzj6AurEAf5Gy1jFTd48qqmEYVzUNf1s/UmPqJ38YjKImR3XCntNZB7c1QY2Yz/I6p+w3s8FPIAk9wIBMv/iQ3stjmDEof4+TESbg+QNagKV7wlxv2zW0gxCP1FuLUVR+MP6HrkcFOxPxU5oVr9PywD4XTZppt1qLpoTWmRhCj93j9ZnvfpCQPbosErruHmCbKjLEvIKAqqx9GxuES6d0GO1Zq1pVGBH2lT308pZuVoEzpkyA3+7ilO5diLO65+AX0Y35sTDaOhUHwGkj72eLokzdas6qPF6FhO3uRxEUYnBSHlvGfyUWCTKMIRXdHKJSh5+5yGkhC1Jwero90o0Lx7iAhrMj64V9Tlb6SmXuNDbhyJft8VRa55Hd+4QENZ1RE9dnJo+JcisK8qxeGEcuWgdraxtBmuRghenaf/gaHU0yb1u8IH+Oy1Ah5X/1JNAsV06qjUpcoADicUD9i5MX/6HcTKiX8QuMX8h0zgZxb9sgJJ6x0J+ONKx35Nf3oRU1mACx5BSpN/lvYQm8JQljEBjJnR2oNxy2hA7sz5N/TLYWBO6QDxHK1fCIE23iopwyFsdYG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(41320700013)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ephB8D7+qpn73AQzl3c1F+Kp16aGOzrwQdrjPHY+NmDDgtcIBKF0frVMBTIQ?=
 =?us-ascii?Q?32aEBzwWimUsixFksE0/hT3dALA4Z2zK92I4RpxwCwPBku0v27v5IbXASr/A?=
 =?us-ascii?Q?cag86UETavWBFk+K9ceyx4sy9j+cPPkOw/1MEqh0r7kwmbpjaJ7mfKrphY9J?=
 =?us-ascii?Q?3Di59ffAyijKHrJ5vT0G2lmC8cBoy5zsKvtQzWcBijogRhh69cUv7dXzqMww?=
 =?us-ascii?Q?32PMZJcbO9NhHt6mBPHMoxhfLbCIpQsd5z0qnH75WC5aPoQXCYVHw9B4BYug?=
 =?us-ascii?Q?vR3M42iDQH+gZ0Pxua2tT/IjdftiN67X8DD4YLtCn38M8CoFMQuhrYwKuUKX?=
 =?us-ascii?Q?MQ8qq5pMW+xVYTUpk1GkU2KUHl2H2avNEoMJH6lMODUOfTbEjZ+jNMY7/6MQ?=
 =?us-ascii?Q?RzvPHwDuI9Fg2FMrQqshtN2AMLh1tknXNXvuru+nMLqSfJul1cJFs+2DpAyj?=
 =?us-ascii?Q?80bh6oyFwmFgXyHAcU6/2d5L1uY4S1ft0AECcep5D/zAnmPcCToxAUmmpv0U?=
 =?us-ascii?Q?NS0o1TIMM2hzhBPk2daJpxoasV3qU70/KbslOrIvBq+CLLX7MfkV+mSiasTo?=
 =?us-ascii?Q?BtYqV1iY+SFFXGOGY9aZhLgiatGDVTNCucESRgzPNf2EqLCblec8eeDC5tSX?=
 =?us-ascii?Q?oQZeiUSG4ekIvMTFeh10j1jqZjKvqY0FWu4z5xfOCdbUJdRtvX6sXJPZD7GD?=
 =?us-ascii?Q?BgfSO3jI30ZdmJtcxpjbe0dvGIhsbGcztWmVjj7Ddjirz5aPj5FRK9tQnpkx?=
 =?us-ascii?Q?GLFIQcDCUFcaSm841/6J7p4BRiFtLsbz/AyN68hwBWrWEXNngU8wNHZhGaFo?=
 =?us-ascii?Q?8JRuhSsF9qZ/aF+T5MX2quQ8PrfDeRY1QR8wSGG8bxMR4q6lPc7n0+Vhpgar?=
 =?us-ascii?Q?RQi0Yh7BUB44dut+YbrqrvXFtiqx9EwpP0j50ZGlrEy975YXGPBWzDJTfevC?=
 =?us-ascii?Q?FYB2uVjHjNvtDgjVbpd0ls7BXMxiqE68rlLOjZxEFD7PS43yfdMfy3l4NG8q?=
 =?us-ascii?Q?hSpyIgyBF2nqVMsVcDi+kFK3PT8ccuVOolD/DIGvAVLHWUyXbMDq7KGoZG3P?=
 =?us-ascii?Q?ZmzwOg99GIdHmb3H/BuPV1ROlE06iP9+CmOXs36Mge9DIGtyH/PQm0pW8MNi?=
 =?us-ascii?Q?8t4vIPgcmjWHQ0a9kDWq99Gu4Tcp7OPTdjvoAhuQYQf3cjTOXlii9LWtNGOi?=
 =?us-ascii?Q?p0/wQsKxIbGiRyiAzVvlh555xF9DIaSWDrwEfheM8NFq3eM1mDLPRossYgeA?=
 =?us-ascii?Q?3oN7PGWqDO4xndOUAtZnhWkoAwv5C46H3Fn2Cl3+XaLlipH36dnodgnGEr/p?=
 =?us-ascii?Q?osTh5gSXYP66mtFWls1RCJQPhmqN+gkTpLLWF+/Zxt1zjT3nK42o+o3HOJXO?=
 =?us-ascii?Q?QfuVkRutV4gpNtR2ZRherQ+9Z3/Ca5ohqf7cVpsBk1Pr7REF0EAXrU5uoU7u?=
 =?us-ascii?Q?8Zc8XRLyaXT2iogtD3+Rr0r6VWsD/qxp1mCjyz3WDZEAEgl9DAyZLHh0OxHd?=
 =?us-ascii?Q?uP0ocVGVsYa8zp7aeEoqV+MskFX9pWiR7raUIjpHYXe4gwtA4Tle69MD0Enq?=
 =?us-ascii?Q?5Kl98VCgI2g5NELkXwxGGhBOck/xFEG6A7TPrmxfp/DZJa7vC63sJcl4OY4V?=
 =?us-ascii?Q?ImxG1CvlGachCuut7PgAve8=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3f5cd2-3575-41e6-6804-08dd09daa4c7
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 03:14:43.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkVYY5LQd/0Vt8zaz84gMVDsw+tPiq1ie+g+QlCVEHoncU0tTNm8aTjRAJ/lX8UnsSM+TVCYHkEXGnXumhxV0HYUTxD6HOnEqiuTujsvFs9xNOv1YX8VDXuJsCuJCdPq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1173

Introduce num_reg to store the number of clocks, this helps to make
_clk_get become a common helper function which called jh71x0_clk_get().
With this, it helps to simplify the code and extend the code in the
future.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/clk/starfive/clk-starfive-jh7100-audio.c | 14 ++------------
 drivers/clk/starfive/clk-starfive-jh7110-aon.c   | 14 ++------------
 drivers/clk/starfive/clk-starfive-jh7110-isp.c   | 14 ++------------
 drivers/clk/starfive/clk-starfive-jh7110-stg.c   | 14 ++------------
 drivers/clk/starfive/clk-starfive-jh7110-sys.c   | 14 ++------------
 drivers/clk/starfive/clk-starfive-jh7110-vout.c  | 14 ++------------
 drivers/clk/starfive/clk-starfive-jh71x0.c       | 12 ++++++++++++
 drivers/clk/starfive/clk-starfive-jh71x0.h       |  2 ++
 8 files changed, 26 insertions(+), 72 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
index 1fcf4e62f347..7de23f6749aa 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
@@ -84,17 +84,6 @@ static const struct jh71x0_clk_data jh7100_audclk_data[] = {
 		    JH7100_AUDCLK_AUDIO_12288),
 };
 
-static struct clk_hw *jh7100_audclk_get(struct of_phandle_args *clkspec, void *data)
-{
-	struct jh71x0_clk_priv *priv = data;
-	unsigned int idx = clkspec->args[0];
-
-	if (idx < JH7100_AUDCLK_END)
-		return &priv->reg[idx].hw;
-
-	return ERR_PTR(-EINVAL);
-}
-
 static int jh7100_audclk_probe(struct platform_device *pdev)
 {
 	struct jh71x0_clk_priv *priv;
@@ -106,6 +95,7 @@ static int jh7100_audclk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = JH7100_AUDCLK_END;
 	priv->dev = &pdev->dev;
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -146,7 +136,7 @@ static int jh7100_audclk_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	return devm_of_clk_add_hw_provider(priv->dev, jh7100_audclk_get, priv);
+	return devm_of_clk_add_hw_provider(priv->dev, jh71x0_clk_get, priv);
 }
 
 static const struct of_device_id jh7100_audclk_match[] = {
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-aon.c b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
index 418efdad719b..6f67587f4335 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-aon.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
@@ -54,17 +54,6 @@ static const struct jh71x0_clk_data jh7110_aonclk_data[] = {
 	JH71X0_GATE(JH7110_AONCLK_RTC_CAL, "rtc_cal", 0, JH7110_AONCLK_OSC),
 };
 
-static struct clk_hw *jh7110_aonclk_get(struct of_phandle_args *clkspec, void *data)
-{
-	struct jh71x0_clk_priv *priv = data;
-	unsigned int idx = clkspec->args[0];
-
-	if (idx < JH7110_AONCLK_END)
-		return &priv->reg[idx].hw;
-
-	return ERR_PTR(-EINVAL);
-}
-
 static int jh7110_aoncrg_probe(struct platform_device *pdev)
 {
 	struct jh71x0_clk_priv *priv;
@@ -78,6 +67,7 @@ static int jh7110_aoncrg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = JH7110_AONCLK_END;
 	priv->dev = &pdev->dev;
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -127,7 +117,7 @@ static int jh7110_aoncrg_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_aonclk_get, priv);
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh71x0_clk_get, priv);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-isp.c b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
index 8c4c3a958a9f..f3fa069db193 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-isp.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
@@ -75,17 +75,6 @@ static inline int jh7110_isp_top_rst_init(struct jh71x0_clk_priv *priv)
 	return reset_control_deassert(top_rsts);
 }
 
-static struct clk_hw *jh7110_ispclk_get(struct of_phandle_args *clkspec, void *data)
-{
-	struct jh71x0_clk_priv *priv = data;
-	unsigned int idx = clkspec->args[0];
-
-	if (idx < JH7110_ISPCLK_END)
-		return &priv->reg[idx].hw;
-
-	return ERR_PTR(-EINVAL);
-}
-
 #ifdef CONFIG_PM
 static int jh7110_ispcrg_suspend(struct device *dev)
 {
@@ -126,6 +115,7 @@ static int jh7110_ispcrg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = JH7110_ISPCLK_END;
 	priv->dev = &pdev->dev;
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -186,7 +176,7 @@ static int jh7110_ispcrg_probe(struct platform_device *pdev)
 			goto err_exit;
 	}
 
-	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_ispclk_get, priv);
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh71x0_clk_get, priv);
 	if (ret)
 		goto err_exit;
 
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-stg.c b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
index dafcb7190592..2a5ad0e07d1d 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-stg.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-stg.c
@@ -75,17 +75,6 @@ static const struct jh71x0_clk_data jh7110_stgclk_data[] = {
 	JH71X0_GATE(JH7110_STGCLK_DMA1P_AHB, "dma1p_ahb", 0, JH7110_STGCLK_STG_AXIAHB),
 };
 
-static struct clk_hw *jh7110_stgclk_get(struct of_phandle_args *clkspec, void *data)
-{
-	struct jh71x0_clk_priv *priv = data;
-	unsigned int idx = clkspec->args[0];
-
-	if (idx < JH7110_STGCLK_END)
-		return &priv->reg[idx].hw;
-
-	return ERR_PTR(-EINVAL);
-}
-
 static int jh7110_stgcrg_probe(struct platform_device *pdev)
 {
 	struct jh71x0_clk_priv *priv;
@@ -98,6 +87,7 @@ static int jh7110_stgcrg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = JH7110_STGCLK_END;
 	priv->dev = &pdev->dev;
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -145,7 +135,7 @@ static int jh7110_stgcrg_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_stgclk_get, priv);
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh71x0_clk_get, priv);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 17325f17696f..e9d8168d02b8 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -323,17 +323,6 @@ static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
 		    JH7110_SYSCLK_OSC),
 };
 
-static struct clk_hw *jh7110_sysclk_get(struct of_phandle_args *clkspec, void *data)
-{
-	struct jh71x0_clk_priv *priv = data;
-	unsigned int idx = clkspec->args[0];
-
-	if (idx < JH7110_SYSCLK_END)
-		return &priv->reg[idx].hw;
-
-	return ERR_PTR(-EINVAL);
-}
-
 static void jh7110_reset_unregister_adev(void *_adev)
 {
 	struct auxiliary_device *adev = _adev;
@@ -425,6 +414,7 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = JH7110_SYSCLK_END;
 	priv->dev = &pdev->dev;
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -526,7 +516,7 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_sysclk_get, priv);
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh71x0_clk_get, priv);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
index 04eeed199087..bad20d5d794a 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-vout.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
@@ -80,17 +80,6 @@ static int jh7110_vout_top_rst_init(struct jh71x0_clk_priv *priv)
 	return reset_control_deassert(top_rst);
 }
 
-static struct clk_hw *jh7110_voutclk_get(struct of_phandle_args *clkspec, void *data)
-{
-	struct jh71x0_clk_priv *priv = data;
-	unsigned int idx = clkspec->args[0];
-
-	if (idx < JH7110_VOUTCLK_END)
-		return &priv->reg[idx].hw;
-
-	return ERR_PTR(-EINVAL);
-}
-
 #ifdef CONFIG_PM
 static int jh7110_voutcrg_suspend(struct device *dev)
 {
@@ -131,6 +120,7 @@ static int jh7110_voutcrg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spin_lock_init(&priv->rmw_lock);
+	priv->num_reg = JH7110_VOUTCLK_END;
 	priv->dev = &pdev->dev;
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -193,7 +183,7 @@ static int jh7110_voutcrg_probe(struct platform_device *pdev)
 			goto err_exit;
 	}
 
-	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_voutclk_get, priv);
+	ret = devm_of_clk_add_hw_provider(&pdev->dev, jh71x0_clk_get, priv);
 	if (ret)
 		goto err_exit;
 
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-jh71x0.c
index aebc99264a0b..80e9157347eb 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.c
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
@@ -325,3 +325,15 @@ const struct clk_ops *starfive_jh71x0_clk_ops(u32 max)
 	return &jh71x0_clk_inv_ops;
 }
 EXPORT_SYMBOL_GPL(starfive_jh71x0_clk_ops);
+
+struct clk_hw *jh71x0_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct jh71x0_clk_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < priv->num_reg)
+		return &priv->reg[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+EXPORT_SYMBOL_GPL(jh71x0_clk_get);
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
index e3f441393e48..634d8cb91592 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
@@ -117,9 +117,11 @@ struct jh71x0_clk_priv {
 	struct clk *original_clk;
 	struct notifier_block pll_clk_nb;
 	struct clk_hw *pll[3];
+	unsigned int num_reg;
 	struct jh71x0_clk reg[];
 };
 
 const struct clk_ops *starfive_jh71x0_clk_ops(u32 max);
+struct clk_hw *jh71x0_clk_get(struct of_phandle_args *clkspec, void *data);
 
 #endif
-- 
2.25.1


