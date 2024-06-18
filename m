Return-Path: <linux-kernel+bounces-220525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF3390E30E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5437B1C21DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551B961FDD;
	Wed, 19 Jun 2024 06:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="EfdS6P2G"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01rlnn2044.outbound.protection.outlook.com [40.95.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75714A1D;
	Wed, 19 Jun 2024 06:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.110.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718777235; cv=fail; b=Li96d/0QPXKxOLlQzDRAIk9aaaafcex6hbT1F8O80k+5QjFGk8FtCNXIDGLwD7hocAp/6YESou592vayydTapTTrHvqdrVytbYAMEd7jnG3mhUSFMvI0zZFV1//eri1gr7S+50IYdYtipehJ+bOgbkM+r/MLGU9ChqbVm0swZCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718777235; c=relaxed/simple;
	bh=mcXP9SNJbzJPmiKmmcsDqUiVDM9EBOk6J1DqTFRBkGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0Y3Z/LMr1zVWuVwG0sVOPLfy+IIjy8JVkDWF8jZfn0sIKaUvm+E619X/2UCCbbwLw+uTdLGnEgTc+JaleXcOB1+Bh8Cy5upwAYNyFfxJ6JA1DQ/B3JvjAkgrS4bR49cbLw/c3YoHvFwC19QiSwXwG82irXJhxKqa/WNBQuTueM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=EfdS6P2G; arc=fail smtp.client-ip=40.95.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
Received: from JH0PR03MB7655.apcprd03.prod.outlook.com (2603:1096:990:d::5) by
 SEZPR03MB7354.apcprd03.prod.outlook.com (2603:1096:101:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 06:07:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bE5c/sYTqZ2fV+PLQ6M7vT4qVkrcrk767ZbwCs2/Q2ktL+cd7YmGNh0WNt1zmphs/n3a/U2Y5/Hxcq59ctxGt7ulvjWeFalbrVJ9IIk52i6k1iS3gVQ5cBDzIh57fAHk9azvkp3Qw1QEjZCqTJPOZ5Xoq+vMJ12Uib1HKJi2DCdPxCMgXZZ7kn9Bv2qvIBD2CbE8GiFE/XF/IN2jX+swBXMQTrp58EjnqgqqQ81jBQJLUynqF3XN/tmacLKrk+pEgcfm/SOd+mVvXECj9MdruaNTcr5S5E4nLBuVwjuytQWjttA7HkrYtJKd9n7QOYbisscsBudKP1ZAxQaUcXDD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGy850DIw7eQ5j5A7JzFAm34SAxuePjha0VfpURvVew=;
 b=KSOt1hnjxpKoRcCPUNBXJu1gVmbB1yIqHuEVb5o/OwJPj59BCQcbhaU2EtDEhENyTtUgkAjHEZLhkPw1qTfhJaMZISOc6qjCmJZ6/WQY/mSg03oRNOcEzcTbw2to67HukBluJ/NVusMEh9EGySKmN7qqx0WEAWp4jqrLabcnup8Z+Dfg3+rL3SohL51NZC3lUzvwhdmsPl6504WFGPMkeM5YTpuxBMnlpOQAMVohr+/aHrZySzikOEbYUkEAy143w9C1HgTLB9rhMshMxNVIjS3RlUPz4L10Ky46D6HZbA37pNRXlk2uKy5/RwdzFHVq9yh5EKYz8FdZotrZaowUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGy850DIw7eQ5j5A7JzFAm34SAxuePjha0VfpURvVew=;
 b=EfdS6P2GIH3qZKW2nPiMMRCIjtwfKcwtiAITLen2I1r0D0q5l91Na3QEooL/hccabCEtVvd4l+FiKWq9sHjXkd92/pC/A8znhtSpIf1x07bRqRJuI23L2IxGM3Iyhe1HeERWXYekVIfEEz9nNXUvxv+5NNhU/i93HKhRvZLILjM=
Received: from PS1PR03CA0003.apcprd03.prod.outlook.com (2603:1096:803:3d::15)
 by JH0PR03MB7655.apcprd03.prod.outlook.com (2603:1096:990:d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 18:58:27 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:803:3d:cafe::1d) by PS1PR03CA0003.outlook.office365.com
 (2603:1096:803:3d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 18:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 175.98.123.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 18:58:25 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 02:58:24 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 19 Jun 2024 02:58:24 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 4C88D5F627;
	Tue, 18 Jun 2024 21:58:23 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 47DA2DC0726; Tue, 18 Jun 2024 21:58:23 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v25 2/3] reset: npcm: register npcm8xx clock auxiliary bus device
Date: Tue, 18 Jun 2024 21:58:18 +0300
Message-ID: <20240618185819.2155595-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618185819.2155595-1-tmaimon77@gmail.com>
References: <20240618185819.2155595-1-tmaimon77@gmail.com>
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
	HK3PEPF00000221:EE_|JH0PR03MB7655:EE_|SEZPR03MB7354:EE_
X-MS-Office365-Filtering-Correlation-Id: e7685ee6-c00a-4797-dfca-08dc8fc8a21d
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230037|48200799015|61400799024|82310400023|376011|7416011|7093399009|35950700013|921017|35450700002;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?s6fvipqa0fj4SimVyVIh1dL+ydTbiASEyMPSuR0KpTnokZfxBs5Db/BNEdgN?=
 =?us-ascii?Q?wbeHb2llEBdMAIrsmSnurmVdIDP8R/KEG7CdyI0tXsphYwnSVmrHYKCEbQ6D?=
 =?us-ascii?Q?7n5J/hs+9qbtbCSdmYTQWArUfMcGPuantw7SxbUeA22Ute8yKMDsNsTSho+J?=
 =?us-ascii?Q?819GRVhBdn9EryholN3DmE7uvmV2hc9D9d5cELG4nfN3jOXAlNnosN1PVwac?=
 =?us-ascii?Q?f4vv/PabH8NAp5rnSOlDpA6Zhnlqc6IrKtIcYfzVJuX9w4pw78WbFDWssBeD?=
 =?us-ascii?Q?3ycz1nPZoHR8Ij6kYba/x7n7jNiu+pfouGJ5ut/onMVoopCL+1XJwQHLQQUI?=
 =?us-ascii?Q?rZv/yX9DqQujmK41LCesAwNYcng4fiL890egdiMSWxzaA7ToYxESVFEqIn9w?=
 =?us-ascii?Q?2sivrqzsqXIRDH86WDXwS4ycnyiu9AJd0JH0AzgzkRlCQtNkVCM2tWYx2vyr?=
 =?us-ascii?Q?xOhJV1h37VnsKTEwNWBwGnE/zdSzlsSujVgHRu7sNmdFsELcPUo3VVAmAwbZ?=
 =?us-ascii?Q?VxunSsL6mLnEGyElOE+9XvgcyLagugceNN8IgL6kLoETXmCPQd2oXCiTDxy7?=
 =?us-ascii?Q?piKB4khSL6msWc0UclN8jF87NeKy/d6PvZSfXSYkGX99FaZOFi9O2F22oLxG?=
 =?us-ascii?Q?6NGPagKxrFgeGAYfCfBZ2g0QlLZ8/olsIp7TQoRNoyIFYhl5KNJafxS1stJL?=
 =?us-ascii?Q?KXM2BhlJyktPdF/KfuU4zkP56CAwEklGQI9G2S3QIA7xWvH1F4qS1Wwp1d2f?=
 =?us-ascii?Q?WDXKU3TXNzOXKE9g/9hIgNw1U+8I1cGklAxXV3DP2OOC3zjuEer2EqESipO5?=
 =?us-ascii?Q?YSf0LJ207L0EdK3Wj5WRly+I1+4/sK0BCPntkl/43cbl1z07/OMpIwSYxsOL?=
 =?us-ascii?Q?CadWmcZq1hVsmEmLO2Qg95peR9aZp3x1Qp77V4J+UJYtiyM9trAWEYcDvXR0?=
 =?us-ascii?Q?M38ELesxFdgTwU/8Lvnz+7zkgyFEWWE1IEvYELK+hBK9xDYs3wNDH99Fx7yu?=
 =?us-ascii?Q?pLnwt0BMhGfy6Exepn6ciqy213HUd5zF+AN6MkPl4psYcRqokvk4p49O0Q6w?=
 =?us-ascii?Q?h6mhKUtPtp3/tjh4Otc0F74AC17nienlgKAfO7AXwn68k12whA/lGBdDGpoI?=
 =?us-ascii?Q?Tzy5D7VlXt7nlbo5AZZbMuHBal8Aze09yR7BMeH6fMgmiFtE8NfR7c+z/WgR?=
 =?us-ascii?Q?6H1NhOEKeC+XGeNMxg2yI7uFJpRN+e7Jnun/mFZjWm5qF6qCNlGuGpC+VvQB?=
 =?us-ascii?Q?FAH0uXioBmaU76BvQQFa+HjyZjZRG/oIkD8tb3eJmEr1uKb+WxeaKCipwAzn?=
 =?us-ascii?Q?mJtVR1vCR0mkcCVvcUcQKkQvmmb2mcJ0YGc1NSXUnqX1d+Ol8gM30/oI/Mn2?=
 =?us-ascii?Q?foNZPgn3ph38ZLo1hWs2cWKBuxyiblHw6UBkVogkpijiRYEdICDt49icJ2hW?=
 =?us-ascii?Q?XiHDONam3x7IOgoONBDbeFM+FsSd9ech?=
X-Forefront-Antispam-Report:
 CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230037)(48200799015)(61400799024)(82310400023)(376011)(7416011)(7093399009)(35950700013)(921017)(35450700002);DIR:OUT;SFP:1022;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 18:58:25.5553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7685ee6-c00a-4797-dfca-08dc8fc8a21d
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
 HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7655
X-OriginatorOrg: nuvoton.com

Add NPCM8xx clock controller auxiliary bus device registration.

The NPCM8xx clock controller is registered as an aux device because the
reset and the clock controller share the same register region.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/reset/reset-npcm.c          | 72 ++++++++++++++++++++++++++++-
 include/soc/nuvoton/clock-npcm8xx.h | 16 +++++++
 2 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 include/soc/nuvoton/clock-npcm8xx.h

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index 8935ef95a2d1..a27f0666c990 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -15,6 +15,8 @@
 #include <linux/regmap.h>
 #include <linux/of_address.h>
 
+#include <soc/nuvoton/clock-npcm8xx.h>
+
 /* NPCM7xx GCR registers */
 #define NPCM_MDLR_OFFSET	0x7C
 #define NPCM7XX_MDLR_USBD0	BIT(9)
@@ -89,6 +91,7 @@ struct npcm_rc_data {
 	const struct npcm_reset_info *info;
 	struct regmap *gcr_regmap;
 	u32 sw_reset_number;
+	struct device *dev;
 	void __iomem *base;
 	spinlock_t lock;
 };
@@ -372,6 +375,67 @@ static const struct reset_control_ops npcm_rc_ops = {
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
@@ -392,6 +456,7 @@ static int npcm_rc_probe(struct platform_device *pdev)
 	rc->rcdev.of_node = pdev->dev.of_node;
 	rc->rcdev.of_reset_n_cells = 2;
 	rc->rcdev.of_xlate = npcm_reset_xlate;
+	rc->dev = &pdev->dev;
 
 	ret = devm_reset_controller_register(&pdev->dev, &rc->rcdev);
 	if (ret) {
@@ -413,7 +478,12 @@ static int npcm_rc_probe(struct platform_device *pdev)
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
new file mode 100644
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


