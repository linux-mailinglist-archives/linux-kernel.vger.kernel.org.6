Return-Path: <linux-kernel+bounces-272176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CF394583D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093151F24314
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E9B4AED7;
	Fri,  2 Aug 2024 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="IBXgPigL"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazrln10220002.outbound.protection.outlook.com [52.103.192.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735A78F47;
	Fri,  2 Aug 2024 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.192.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722581568; cv=fail; b=T/xHPKoi04Mp4GgIW5198V+x6uHEvDuZfgH0pRrCYfpKGaJEq9IS72Au7cwEOCeIx/mg6G8UTurXURa6+KRN8NL0vdA0OUx8MROgey1EqBHlk1d6s92/N6/kFEaNCriNjYMSa/6jA3n7Uik3Xgf6zJKN8pHTRdXV9YiVh2LqG+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722581568; c=relaxed/simple;
	bh=SZfdRYxLgqV1D45D0IiQhUdNkwZz+FPvdUUYLfS9B2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgZkudUuX5X09OLCR2xsoB8tOEBkHuo90XhFJ6KdzEc6VHK3FlT/fV6obO7F9dgNncoHc0lfphPn2/GoS4ownYDP56GxtFkmd4fhM6zsZHkKI8JBzvK5+X/FZM/+d50yNTSOw2BFTRnJubsDSIVNu17J98uovTpRvP9nENVJWs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=IBXgPigL; arc=fail smtp.client-ip=52.103.192.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
Received: from SEZPR03MB7124.apcprd03.prod.outlook.com (2603:1096:101:e1::9)
 by SEYPR03MB6507.apcprd03.prod.outlook.com (2603:1096:101:54::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Fri, 2 Aug
 2024 06:52:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jI0F97uQ174y5O4n81aQiJSLubtCsVEOOssdycGvus7D70NDTtuVLf0as0+yLUfhOGgcDK2j4X3r1wdl7SUpeuTRo9UT6vDWtWwFmDnuyzqiWQJtjFtEKVZn3sxHKH+uIF42eYf81DCE1gNB4ZRKjtV3B2xZ/+dC+Z8dd070OBjFv4Am3AraPi4j8yjaSmf711xETqD6uegYXICdoU5hzj3bLDir8eJDvs+NY7gSC4QjdErjuMgGNEg1Q4bJ/xmguzA52/riD7pOsGgU8Xo6V/oHLqmoGJOZcVea7tJUxcNPs9GGCio9aYC0qGxapUOYc1n5ZLTmhQvgh0JqYDIqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAuEzqHIOSfq8jhfg97/P6te6r/B/zcq/uq1CyQxERk=;
 b=AnFcVAhjY7bpeDj5u7x8eVwidXl2KKFMZeEBLUnKcOUE7Pi/uy9fAsgqyFnObrTzeLgSCNMcirbWboRLtCwqrIAnNcoomlkL6ZWGRpRhzSFqcefXnTnRilPJLsk5gjyd9syZ9tf9V/8WkRk1/piufyKhfGv6jt7zUS5bxutw2CqRLXpQHXSmTGGCYkl9wPV0P5DS2iTYq2o0VemK6q3VgstIdLO0y7Wp6kIFhJ9qFcKvPAP8+1zyBNmLeirZ/Y71dCib/lG+v7zmJ1f8Brujg7V2H/i2XnMGqaO2QRZW3UIrzUOoDvvDnsKwCOB/rDNrxtcOpJfbcf+9U2E9uBQwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAuEzqHIOSfq8jhfg97/P6te6r/B/zcq/uq1CyQxERk=;
 b=IBXgPigLq0ezb2k7pzwTzMKtHfs5kLPYS2HcJ1/jqsH09RUCNyaS764O9I7vRxH8QBTO7j5VLeNe5iYXuKKwahMi/A/xtsB3WVM9ys1ALlpK5BtLW2rhSuzKzFadUZ5kFtVUgcr8WJKnSiBDRTSLhkti4n8zfmd8K0vRlcYR9G8=
Received: from SI2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::23) by
 SEZPR03MB7124.apcprd03.prod.outlook.com (2603:1096:101:e1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Thu, 1 Aug 2024 19:46:40 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:4:140:cafe::f5) by SI2P153CA0004.outlook.office365.com
 (2603:1096:4:140::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.5 via Frontend
 Transport; Thu, 1 Aug 2024 19:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 175.98.123.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 19:46:38 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 Aug
 2024 03:46:36 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 Aug
 2024 03:46:35 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 2 Aug 2024 03:46:35 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id F1B3E5F64E;
	Thu,  1 Aug 2024 22:46:34 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id EAED7DC1D37; Thu,  1 Aug 2024 22:46:34 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v27 2/3] reset: npcm: register npcm8xx clock auxiliary bus device
Date: Thu, 1 Aug 2024 22:46:31 +0300
Message-ID: <20240801194632.742006-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801194632.742006-1-tmaimon77@gmail.com>
References: <20240801194632.742006-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	HK3PEPF00000221:EE_|SEZPR03MB7124:EE_|SEYPR03MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: d71dad43-a8e0-4415-7cb8-08dcb262a8be
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7093399012|61400799027|48200799018|376014|7416014|35950700016|82310400026|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?i0o1qDzv+AWlYZvw5yvpBDCVDoliHU0vCTvlzewcjiaO+bzMBy+4w15FhXoB?=
 =?us-ascii?Q?byVQZbsFrKh2es4am7tmV7qABTtD/wzaB2UcooQj6cIOjJT2xazM0M1GexbH?=
 =?us-ascii?Q?6jq/XRb1rMYLXfupCG+XShIKE+r/0A2QZW7H3lj+K0FSuEdAWc+4ONNTYEah?=
 =?us-ascii?Q?kKmAfs6c/yKEW/ED5jCqLQ1eRNkYLy1QbtW1TFXrIKa5ebKbLpn5FHP/RQST?=
 =?us-ascii?Q?diNKpsV/hgvNpzRrR11ZyQtIZe/SEvyW5EC5Ze1RdLtSKZ8S+/vBLY4Kzti3?=
 =?us-ascii?Q?lJhyms9HHfX6ZuoBjchUTEu65SqoXfu4pIip/XBEAX3EPVpp881lZrKiSHX6?=
 =?us-ascii?Q?siAKQslgHYuH6P2HcwIvFTNPTbA1ttYotyX+y30ORFAeYKv8k3CoBdqx9b0X?=
 =?us-ascii?Q?erTcP+L+x/sptHHPpvzMiWX8ld5K1EOe2qyZarch/6FTGdmWAXYdr5rCZk8k?=
 =?us-ascii?Q?FCN7ACGYj2aAF1JEKhRWcVncaTDLZxw+bbef7KnCxUrmDyUzzQTxWUsg+7X2?=
 =?us-ascii?Q?fKwi2wFVKJ/5DSF82Qpjh11GOWCDpxR19l7CnBQaWdviwXPrIcGxxooUTLMg?=
 =?us-ascii?Q?bIAnZ12jG/M52EUYtbHraZFyDtiB5no5ACuc+3Mpb79nY96Hmj+8wQC3c7z9?=
 =?us-ascii?Q?MZr/YDKkiAznXfNhpQBLFdB76TJLZGvxJ3fBnRIfX7w2Lm3AjyBPGi2XEDAI?=
 =?us-ascii?Q?85fAVCpY+u9cDNiIBXddpiL5ywxWeNDT2H7YZvt5dctP+CHpNba24h2b2GU5?=
 =?us-ascii?Q?NQA9gX6MlfUJ2+1kvs41w47Xi9V4vv1tMq3YFa8SOCWRb2GVvKHPWmWozAc8?=
 =?us-ascii?Q?d4QEjCgU1Z2s7r+VLza8jSKUiQ9fsWdnEzQecXQjwXSahcaghJVyMzKCETOG?=
 =?us-ascii?Q?rm3sINEoIe1jg5FGkfJgm5ROpz4nK0tDTwPS3A2u3uQiwNdWc2beX0yAENi9?=
 =?us-ascii?Q?MsrYVtLwMwdn9kNhoFwD8jYXbylZX1pwBqdZrU52kSOz+drBOePafknLECWi?=
 =?us-ascii?Q?L7Aj7uH0f+uc7t8hPKcZwrVAosRAjBU9XVZdeRp8n3IwxXY89XoP3ppXQynA?=
 =?us-ascii?Q?OHjz/cGjXhcmpWMHL3SPq6/b3a9Z/b6mWTS/jmw8vnzDw7VX5gOeZni9KTr+?=
 =?us-ascii?Q?TjZM/LImqGz7qdfnEuQpgWax8oJLc/GMfTdSu/WgCUn3jYDkrBbVtGBjvjJZ?=
 =?us-ascii?Q?T8eGcDInCPY70SJRcF8zft5KCBNFL1LUg+wFwkOhAexMQCJL7GXh8RBRlL3A?=
 =?us-ascii?Q?hD6rPBuagbGGQ2tJIKhjMU6s90jwpPu0mdgvYNsSC+7tY9MOa7s2aurXmPP8?=
 =?us-ascii?Q?kx8CG0K6ek/iq5bIIn87s6t8+VlLnDvPwgMBf3yxcKYzcghNKtYbwze+dpyN?=
 =?us-ascii?Q?24U7CdsHursGlRm7jsR+nrcnYQGaamzO0zi/DTWoaJnMVgv87evL45VlQZA/?=
 =?us-ascii?Q?86SdYdyyrc3HX1MicDrIZ5zkOw10gTKb+HmmUHuZgWvmlIKSSctNbjWmokci?=
 =?us-ascii?Q?HH9IZV81TyiUr7U=3D?=
X-Forefront-Antispam-Report:
 CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(7093399012)(61400799027)(48200799018)(376014)(7416014)(35950700016)(82310400026)(921020)(35450700002);DIR:OUT;SFP:1022;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 19:46:38.6894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71dad43-a8e0-4415-7cb8-08dcb262a8be
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
 HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7124
X-OriginatorOrg: nuvoton.com

Add NPCM8xx clock controller auxiliary bus device registration.

The NPCM8xx clock controller is registered as an aux device because the
reset and the clock controller share the same register region.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Tested-by: Benjamin Fair <benjaminfair@google.com>
---
 drivers/reset/Kconfig               |  1 +
 drivers/reset/reset-npcm.c          | 74 ++++++++++++++++++++++++++++-
 include/soc/nuvoton/clock-npcm8xx.h | 16 +++++++
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100755 include/soc/nuvoton/clock-npcm8xx.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 67bce340a87e..c6bf5275cca2 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -157,6 +157,7 @@ config RESET_MESON_AUDIO_ARB
 config RESET_NPCM
 	bool "NPCM BMC Reset Driver" if COMPILE_TEST
 	default ARCH_NPCM
+	select AUXILIARY_BUS
 	help
 	  This enables the reset controller driver for Nuvoton NPCM
 	  BMC SoCs.
diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index 8935ef95a2d1..aa68b947226a 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Nuvoton Technology corporation.
 
+#include <linux/auxiliary_bus.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -10,11 +11,14 @@
 #include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/reset-controller.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/of_address.h>
 
+#include <soc/nuvoton/clock-npcm8xx.h>
+
 /* NPCM7xx GCR registers */
 #define NPCM_MDLR_OFFSET	0x7C
 #define NPCM7XX_MDLR_USBD0	BIT(9)
@@ -89,6 +93,7 @@ struct npcm_rc_data {
 	const struct npcm_reset_info *info;
 	struct regmap *gcr_regmap;
 	u32 sw_reset_number;
+	struct device *dev;
 	void __iomem *base;
 	spinlock_t lock;
 };
@@ -372,6 +377,67 @@ static const struct reset_control_ops npcm_rc_ops = {
 	.status		= npcm_rc_status,
 };
 
+static void npcm_clock_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void npcm_clock_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct npcm_clock_adev *rdev = to_npcm_clock_adev(adev);
+
+	kfree(rdev);
+}
+
+static struct auxiliary_device *npcm_clock_adev_alloc(struct npcm_rc_data *rst_data, char *clk_name)
+{
+	struct npcm_clock_adev *rdev;
+	struct auxiliary_device *adev;
+	int ret;
+
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return ERR_PTR(-ENOMEM);
+
+	rdev->base = rst_data->base;
+
+	adev = &rdev->adev;
+	adev->name = clk_name;
+	adev->dev.parent = rst_data->dev;
+	adev->dev.release = npcm_clock_adev_release;
+	adev->id = 555u;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(rdev);
+		return ERR_PTR(ret);
+	}
+
+	return adev;
+}
+
+static int npcm8xx_clock_controller_register(struct npcm_rc_data *rst_data, char *clk_name)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = npcm_clock_adev_alloc(rst_data, clk_name);
+	if (IS_ERR(adev))
+		return PTR_ERR(adev);
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(rst_data->dev, npcm_clock_unregister_adev, adev);
+}
+
 static int npcm_rc_probe(struct platform_device *pdev)
 {
 	struct npcm_rc_data *rc;
@@ -392,6 +458,7 @@ static int npcm_rc_probe(struct platform_device *pdev)
 	rc->rcdev.of_node = pdev->dev.of_node;
 	rc->rcdev.of_reset_n_cells = 2;
 	rc->rcdev.of_xlate = npcm_reset_xlate;
+	rc->dev = &pdev->dev;
 
 	ret = devm_reset_controller_register(&pdev->dev, &rc->rcdev);
 	if (ret) {
@@ -413,7 +480,12 @@ static int npcm_rc_probe(struct platform_device *pdev)
 		}
 	}
 
-	return ret;
+	switch (rc->info->bmc_id) {
+	case BMC_NPCM8XX:
+		return npcm8xx_clock_controller_register(rc, "clk-npcm8xx");
+	default:
+		return ret;
+	}
 }
 
 static struct platform_driver npcm_rc_driver = {
diff --git a/include/soc/nuvoton/clock-npcm8xx.h b/include/soc/nuvoton/clock-npcm8xx.h
new file mode 100755
index 000000000000..139130e98c51
--- /dev/null
+++ b/include/soc/nuvoton/clock-npcm8xx.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SOC_NPCM8XX_CLOCK_H
+#define __SOC_NPCM8XX_CLOCK_H
+
+#include <linux/auxiliary_bus.h>
+#include <linux/container_of.h>
+
+struct npcm_clock_adev {
+	void __iomem *base;
+	struct auxiliary_device adev;
+};
+
+#define to_npcm_clock_adev(_adev) \
+	container_of((_adev), struct npcm_clock_adev, adev)
+
+#endif
-- 
2.34.1


