Return-Path: <linux-kernel+bounces-301037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E28595EBC6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536571C22275
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FCB13CABC;
	Mon, 26 Aug 2024 08:20:32 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0113CA95;
	Mon, 26 Aug 2024 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660431; cv=fail; b=NcVVe6U8ZK1aNjvDxm+oNGmJI0kawv8yUG259UZneZH2LEdZ5IdUR7PLq3Jw4Qdl/TRQ+kX4JhbdV6LT9cnQrbwr6E3BcJbo6UY52jVuK7gXIVlSGWW1I6DIgPPHNxQMfUqVyPKFmprk+Ss0PvetSVsQbSSg/z2ua0kMumrnIm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660431; c=relaxed/simple;
	bh=zg/lCcFyz8e6bWm5pK4XAmaDbjFLL91hhg0BV6CxD4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ycn8UflfjlfoXED3LqFvMglCPbNHUpz/0BBVnqR9vdt/t4eZ+KcfnXh4T6RhWdFoo7dhoFwA07riDJOPD/lvy01x1VYrmeY1jNO/nSIS1GvRPOcYMsRuSPwIGeRlKrJOrbptaVH20hG1bqkhJagx2/Y3cZBZ/Qh6axlXy7GOQqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqIJPWeqFideK8x1Hq//17ko+nbVi5SGciy5BvDvVgcWW41idaLVHdGLXYHUkZjCtP1oov/v9emlnVk1xgOMrx9j3ZeW2OA9BCVb9g4qGkO/uQIMX8ZRQDr2ZjE7jvgALMQY9WokiV4jGJJxEKZOLV1xpo0/kLNcsyFcuKreh/L4FaLIE2VDiGCTt9UUltot9FZp6FfPQH8UzqZWjxD2gjPmFLlbzk592D3xFVtbYvmsbUKoZTnmZTFhAjz3+VzLO2hrzhuXx72oHn5RvWrPdvE7usl8yjJ5I9Zcvgy9iddKSlSZCDXbMs1DOaLXTagHCRSXG6yK/NI7RWIAhR+WOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJdGe+gEVZ4oLVDeZWuOBQPf1GKzQ+wXaTJGaeoRm4Y=;
 b=jtwBciSVrlMb/GYsiz4hIovnhICn915ToFWwMyGZWiL6+kD12zfmi0UC/d7qDB01Wzvm3oP70qT/flX3ZDIqPrIMZIPAIFkFR+SSEvlsU3b7VdmynZ+7djyWPSR/XXw1+01awfOpPlwYmcQIyQrNHVlhR1YHmSZtL7aKJjOF8i4Klud0s77sPt2pFTRO5j7ZrB6wU195PpIpClSoRTKesvVvVm2FesN8RRDQyjUwuO32Z0ZrJIjiUc8+SIyD0NiWtUQ6CE9GyX78mTmNGTzKb8cZUJCJoLNls5aQQ+PaA+EsMeb5JyMRRqleItVmQG+icLGSqnlLvxRgvysMr14Alg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Mon, 26 Aug
 2024 08:04:39 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::40dc:d70a:7a0b:3f92]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::40dc:d70a:7a0b:3f92%5])
 with mapi id 15.20.7897.021; Mon, 26 Aug 2024 08:04:39 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v7 1/2] clk: starfive: jh7110-sys: Add notifier for PLL0 clock
Date: Mon, 26 Aug 2024 16:04:29 +0800
Message-Id: <20240826080430.179788-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826080430.179788-1-xingyu.wu@starfivetech.com>
References: <20240826080430.179788-1-xingyu.wu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0013.CHNPR01.prod.partner.outlook.cn (10.2.0.72)
 To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn (10.2.8.138)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1034:EE_
X-MS-Office365-Filtering-Correlation-Id: 5896b1a2-58f3-42ab-de3f-08dcc5a5bbc7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|41320700013|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	a+23ts4DkCTFJ0ZdZCJg1tkzVr06FOIccYCi+ntcwN8tjhQ8aQTum2UrRR+ikeAq4aCCIkhSoLf3mGqNI0/oMGwU/R7MuLZRp539FLxSaViPGtu6AzjgHOjUDWNsK3jdEMY1EaJXReaO3aAq+AWgpiFBnJKtUNhaJs5oTTocXhmlMJvLTEQbjW7W9P5YKj+m2rnxhCgudmE9VjwrFacKpCntq+zs7Iq6A7gkvqrEcTBvHaVU7FSrwHZaz28OWia8hIWRQjo0vyp8PEiganKcYm+zoVOyxL7Zf4XGeIOlX+ONi9vZZ9s8OzToid16jgdDrrqjmzcp9rN9CPrua+ZB2QTm3yBxwYEnAi+6i6MeaHb94zMmPT6nZJU3LlWEtRfuRt/8MJF90DFjkorCOlGXjHk6gFuuPzk4QkSt6ft20X8C8YquZ8vQBNswAkCFDbfw+b+C727ib3clTbm0TGsmEYnpC/EVqQVwFccg1ExCDCmnzHrKPLvDNNASYoyDqrtfEMEWTiXZblag4dzhO36vmPcB2kqOrAd961hHtEKCM0pkam/foeYPoTh1eOXZ1evRwEPeYoRhFU3NEFXdvduyjuXuIVgtjB5Q4ltGxQo+z5nzlQ7lSsMo9o0OekOBpLec
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v5/3b4w1ABKna3ht3OvsrToDwx1jtZExWjyOgrCScALKFOzlhJCULVSo6OCE?=
 =?us-ascii?Q?8dLBTRNFMVCuCOEwWq6XnrzCdLjrytIjVwz2YizzM5ZBUZt/hPC1+1m4QcCh?=
 =?us-ascii?Q?YcHsIH4IJPsxDNgdQeSO5CSS59btnvsTgZAZ5mHEAZ+ONOyWGl+HN7UHipGg?=
 =?us-ascii?Q?GlNWvZ5/x1gA0b7o32oaTfSp3sn9ZfK6il8qslCsFwuJbr0cUdlk0qeK/ErI?=
 =?us-ascii?Q?gb/Wpy3ck5SYvmNU814OPnzPDA1eCL9R/JfoyXrbOhUI7oRP6OeW449Qtp5F?=
 =?us-ascii?Q?OSXhQqn36TryeVaaeQaqVjmKSsjj7u38f2YUL24efAAjM3hdH9v6A9ZCC2Vf?=
 =?us-ascii?Q?EFdtx8Y74opVOpUYfE6DCEiOf01nSd+gPcPEnS4o8hX+bOYz9QRAE1bugu+w?=
 =?us-ascii?Q?j5CDkb3+AzapsoyF4tw2XjvTec92NboxqVXlykCTnLqcmDubFuPLrY/WCTOs?=
 =?us-ascii?Q?C920+btInN10Pbi6U7HUb21dyEHxQ3RO13AYD2n2+K2IA4XPBq00s+bPgBYf?=
 =?us-ascii?Q?1WdAN2ZgY81p+PHXGvqpr0Q3abkmQVhWyOkK/qMR+H4T1/vUuPOnTqTwCSpj?=
 =?us-ascii?Q?HwRZS+yeqj1sQ7Gm2U8YFSXgM9jOjQDB23CMxyp2NSjGUStZH2neHaZ0wtMQ?=
 =?us-ascii?Q?3wi4mNxHlUkxlMWSP3TpHOI0MfG4YqMopLB4bMY9wJGIdO5m45/4C4nm9dn5?=
 =?us-ascii?Q?AuypLPU0XRwxyS2eza1ARHXEX+w0Ic6cOYAsSWkEgrcFhjCjL6LsxC0OuqZU?=
 =?us-ascii?Q?GGrP6IYR8s5p8LBr4HQD9NH0HMG5eAPZm3lIJ4ZjHW9NHAP2Jmkokdo7y8Kg?=
 =?us-ascii?Q?PqCh3M5B23Yd9dLsFqpgrD6QFe2NouJNwHHS9rW8lrOq4VrVXBvbakjUy5py?=
 =?us-ascii?Q?ZOwKT9RRIOol1F955SQsvD4CtVeyShRVVV8Cn9Xq/YYYUBkSusvRO5wcf8tk?=
 =?us-ascii?Q?keDnQwzALxLVJdH0GCBuhXDvdvGqLS/U+ekfDuKDKEB9gcPA1PicUi6LVcOh?=
 =?us-ascii?Q?eHRWn5zBqIXLD30/6SK1Ruie+gHvjkFKONS5p3p/jPDrUsgYulBcuMRI4mXz?=
 =?us-ascii?Q?YJZEL+HXAy9vawSKTO5UmZsbXnvTHZ1u45X2JVBX5e9YPKIMXnvnNEYQTkvX?=
 =?us-ascii?Q?JVRcFc4tjYGuBHzcnSVo9E27oTWVX9NEj+S1FMbD9FSrZ7AqJFq4PlysSDo1?=
 =?us-ascii?Q?CXH/z878VUX00XlktOutGoIz9VG85F/DULBas4PW/Y/+r1/ZEjik+Rxs38Ty?=
 =?us-ascii?Q?ApPY0ka4tDeqS4+C7uKozCT73AUrTl84dFHng2gBncSGc5aq5Hnes5VCyT97?=
 =?us-ascii?Q?TcMUP4QhR5QLyDQ954jJaV3RxsaqZRzdT66JCEt8j2S41WwAR9MG2Zll7QoJ?=
 =?us-ascii?Q?iGxr+yeBCOTCRnnU6wHLltCJA0Y3zp/DvXbo63BF+rqRnOwnrA+7qgQbeXdz?=
 =?us-ascii?Q?2d5KFpwq1XFbTGh99utfgUkkl1h60NWC84aG1tSVNUJYCdpiHbzx33NpV1/X?=
 =?us-ascii?Q?Svkuvlt3AUg8Ed72nwaBjTtlAh1iajG/NPF9z6oF3AIk2iWidsaE5E9Pr3UE?=
 =?us-ascii?Q?hI/zczxtqItW3IJ14b5TAolnrX2C7elz6GfPC/gBVOG4JZo4gThtR+ajdeqb?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5896b1a2-58f3-42ab-de3f-08dcc5a5bbc7
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:04:39.2064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSHcluj4/qN/FanWWbP02ZiRW/CUotM/2FGY+RRpNejJTucVIB0oKH2ytPcnH5c9W4ZRZo8unPXzGuQbQ/XsKrxni8qOgnhysmitJYlEyv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1034

Add notifier function for PLL0 clock. In the function, the cpu_root clock
should be operated by saving its current parent and setting a new safe
parent (osc clock) before setting the PLL0 clock rate. After setting PLL0
rate, it should be switched back to the original parent clock.

Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 31 ++++++++++++++++++-
 drivers/clk/starfive/clk-starfive-jh71x0.h    |  2 ++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 8f5e5abfa178..dafa3ae71751 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -385,6 +385,32 @@ int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
 }
 EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
 
+/*
+ * This clock notifier is called when the rate of PLL0 clock is to be changed.
+ * The cpu_root clock should save the curent parent clock and swicth its parent
+ * clock to osc before PLL0 rate will be changed. Then swicth its parent clock
+ * back after the PLL0 rate is completed.
+ */
+static int jh7110_pll0_clk_notifier_cb(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct jh71x0_clk_priv *priv = container_of(nb, struct jh71x0_clk_priv, pll_clk_nb);
+	struct clk *cpu_root = priv->reg[JH7110_SYSCLK_CPU_ROOT].hw.clk;
+	int ret = 0;
+
+	if (action == PRE_RATE_CHANGE) {
+		struct clk *osc = clk_get(priv->dev, "osc");
+
+		priv->original_clk = clk_get_parent(cpu_root);
+		ret = clk_set_parent(cpu_root, osc);
+		clk_put(osc);
+	} else if (action == POST_RATE_CHANGE) {
+		ret = clk_set_parent(cpu_root, priv->original_clk);
+	}
+
+	return notifier_from_errno(ret);
+}
+
 static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 {
 	struct jh71x0_clk_priv *priv;
@@ -413,7 +439,10 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 		if (IS_ERR(priv->pll[0]))
 			return PTR_ERR(priv->pll[0]);
 	} else {
-		clk_put(pllclk);
+		priv->pll_clk_nb.notifier_call = jh7110_pll0_clk_notifier_cb;
+		ret = clk_notifier_register(pllclk, &priv->pll_clk_nb);
+		if (ret)
+			return ret;
 		priv->pll[0] = NULL;
 	}
 
diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
index 23e052fc1549..e3f441393e48 100644
--- a/drivers/clk/starfive/clk-starfive-jh71x0.h
+++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
@@ -114,6 +114,8 @@ struct jh71x0_clk_priv {
 	spinlock_t rmw_lock;
 	struct device *dev;
 	void __iomem *base;
+	struct clk *original_clk;
+	struct notifier_block pll_clk_nb;
 	struct clk_hw *pll[3];
 	struct jh71x0_clk reg[];
 };
-- 
2.34.1


