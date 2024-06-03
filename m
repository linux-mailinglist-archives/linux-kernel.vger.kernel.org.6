Return-Path: <linux-kernel+bounces-198542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FC58D7A0A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 04:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A6228116F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 02:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A822F63BF;
	Mon,  3 Jun 2024 02:06:30 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DD4C90;
	Mon,  3 Jun 2024 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717380390; cv=fail; b=giU5BwN9DqQDP+9rQBfPp6GDstakdfnPecRCj1XJI1uwb6keLcbxD8zZRPcunur37frFf5HVEFQwrcvEiYaVjj+kpXTFfYXDbPB76QfYRQGzIVrVqihPbyloDYx5ZRGbd49zJSqdAZ2jiTu06RQFRiVOjNebwfpL/79utk5Tn8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717380390; c=relaxed/simple;
	bh=0AZZ8rVLcZ2r2k2iP0b4gS06Wa0o1ZIaqdKbkWYweLE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YZc764RWK32iuohMjnZI2y4t7RmhcCdgkI0s0p75RahHg6ObVy58V+WKHdNz5XH6Brmqf1xnN6c2AKI58GClvtf1Nvo0lCx2tv/r3l0hpR709WuChxMmVgv3Ln7Gkw4rlz/DOd/8u8h1SfmpOxVxGo1+1DVICxeaSTR1dvzW04k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSKGqZmKN27ZvTypxYHecEKUw0et8DI+vAizUfQpsF8DrFudT6dc88KlK3BUV8uFniU0bTODoU5db69zHTpg7qpo5AusO9MxPbbEwPAsqx1HE2Bksc91GvBCebW2Zl8UgIsCJ28I1suNjzesvIsd+0HCPATFjo4jRCjRazvXGMaOJalKAehCbqy2TogBx9xKqLPYZfHvRzEodixB8IRWFFzyOf6gzwPSkJsoch6U/hPKF6VgqLo45sHcs01oAuIgg9JxzAAyYt6T1d/5sbkTlTaX/z1IGdtgSLRzDj7cyl+p6ez2qbRB4Di2BbpS/8p9TQAiaMchuGkXKfiNiy8zUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+QT5ZNbj7RSgWtWTRzsSU15uSbJESbA3BtOK0Rx/WU=;
 b=XvnLWHGNMzX1VPp+scgpO3038JtYrX3sICkSWVtMcH88KKV+AR4y9PQMm11VevLkSamsHwgDltQrnq+3pNVntlBztfcjuT8cKtZdbvmBpulUipoUxLzSWDI45cgQWKFXGSQfOJ4ufnACJauv3GGgwGTCiEGpPI3tNy3EBOpI3D1CksAfxx/7PXXcnWP3Zs3sKjm3idg4HyDOgDRNByTNCEisQNd5U4XJR0YLiuYAH9mR55p0xXO7Nu3DC/KSdFpwxdYMtlagXBor1X2vnWCzBMiWfgt2yRMsZWUL2c+fO3QWf7yc2aE2Lszmq4jT22OOpEptbYHSpCr2isuFukHlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 3 Jun
 2024 02:06:13 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::add5:1215:5112:d13d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::add5:1215:5112:d13d%7])
 with mapi id 15.20.7587.037; Mon, 3 Jun 2024 02:06:13 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v6] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq by setting PLL0 rate to 1.5GHz
Date: Mon,  3 Jun 2024 10:06:07 +0800
Message-Id: <20240603020607.25122-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::24) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1050:EE_
X-MS-Office365-Filtering-Correlation-Id: db01c83e-8313-4564-776c-08dc8371bebf
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|41320700004|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	hqwy8gl2Dr1IkpR8FJ8L4Os4rNVSUzi6cvbSvmu15US/DN0yDg0rTN2z62vSFNg2jZApbAbNMkjXO+nxHC6+0y+idYZVMtlcmpJ3fUEiXAkAmPr3YIe3aThbtqO2Mnu1dYQm3/o1gZmtxFS7iHIIU8QeZzV6r70QU7pfIj4b3cnI4TTucO/5DJljTIqd0NpEk8KA5mIvPlr2vCg+CJi/YAJTLXFDF3Ph4FLLQJsTjNJo1h/FLbwPOGalbaRIzZNMH36BrcKHp/2/XGNRaIcy0e4/n58hg/QhOHRQgJdez7dqxMpxBFN7tEbAyZ5BW1MgVS7SyMOFIr0ggLgLpjvgeJ7HEdw4a4xgh3qt98zYb2ee96gO53OLvpkRc6O81xe7eciW4rXjE+YGPDY/iWACHL6HhBdBtPjWBcG+nesQAZqBAom8MM8K5a2Hys6YvVNJMEv8Jjf+foqBv2UH5yUGBAF9zoQbRH1qmAdXHYLTVvqXvvm1tKO2x+Otr8O92Vcq5TMEem5pP49pfTYKfTAKHa7KnPYRFlvNZ98wy/CRaNl36ve1gy9ByM0YSSrsWZULCOhxasum7MPqKdqpvdzgEu49II6KVP1odx5EJxP9KsDMckRz7NCvxEUFkdgggNsN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PGGphSdTPV4UJWhSouXdvaDmuK829aL6VLvk0gY6280AS//ChmVd7vCNZex?=
 =?us-ascii?Q?SeNPesc8okJxqvyacTPV2DxjX1zYfvh7fup/Y9F47pgoC54Nyf7b3GJGNF5/?=
 =?us-ascii?Q?s5VeVMjEz5LTI66dC0/TQBa5BeN0f7Gssh4PnMCA41NBv0bLKzL8KyGAaS5J?=
 =?us-ascii?Q?IDwl570Vh1La2zwB6KyjJ0fQPcm5eN755vKjcZiY5yGBxQZFq2mQyVNEjGO9?=
 =?us-ascii?Q?KbyOjOmfzB/IDWkD9167ZGLBAkUHKMlZZ3AB24hQAZGQ0q98N0EpWv5bLxxj?=
 =?us-ascii?Q?J/xt9FLs5bnhgMo1zF0+Si550TdiGlH8i7NsL0aTeKdHvhgtKvm1/830YayW?=
 =?us-ascii?Q?30eLr5V+dFJh6kuWELeOKPZ456sw+Sy+Ahl4DH0OFwVAmyw1QyJN7dCw7U/H?=
 =?us-ascii?Q?LAkkAUQUN30xcMXCT042kQGmIDh2Gf44FSvaWTx3FChmJ0/wxr+tDm0llo51?=
 =?us-ascii?Q?kdC+3P+NTLqTcScNyIi7+ZFKlmIlu/kun0Z+0b4M5HmIWt/1EZtRPhyTraCD?=
 =?us-ascii?Q?4SDYygiC7DiPEwuURuD333UEiyeG0AIPTWhE4hUOOalPb7XYvHqeePttc90H?=
 =?us-ascii?Q?o2DS1w2Vu98YaEw3avsbAz+/fm2CxtdVMZFHkmbp2IvYRx81b5bnc2GwzZQv?=
 =?us-ascii?Q?rO/nAqY0hhrgc+nZPDc4E6l1p7r+hfFC08x072b26qvKN5vwbb6bFNwhXZwZ?=
 =?us-ascii?Q?TLEZbMXsRvrvXq+4eKcpci1ZNXuRrBQ8QyX+r3TiUyOs0T6FMUgccE96ucn2?=
 =?us-ascii?Q?dhRvVhgGVjJ1x/dmJ0ZiEjNjWna+ji6ELlcyYcpVHNjWmIYq9llD7jZRItk+?=
 =?us-ascii?Q?EeLAy8fvF5hQyOK+64fObm6qF+xq6+6wR5sw/AQRfeY4JRWZF6B2zXHymjrO?=
 =?us-ascii?Q?lZcT9tgoMCkAcDSIG57AxWCJMzggInRv8yX1VmAV8CB/+Bipv+R0gB+GCMgU?=
 =?us-ascii?Q?qqqhM4/XE7yWAXT0e5+Gvql0kDw82C1EaLVwjU1UjgB6Nfv3lSqTJf+j1AkG?=
 =?us-ascii?Q?I8wfTev1uX3Y/wormxomC2EMXk69R3CZQsO/WO/ki2CHsrK4vPhF/VxfHFRw?=
 =?us-ascii?Q?SvbJABI7CET0cZS8Oh3diCVgdNYM1jYHqW0V6iQZrE0qZhY2AN+bw1gzjNci?=
 =?us-ascii?Q?e5PrHbmADofHMEdW1MA+LLO4DHAfFqlkJ0uPmzhIHT3HjfyiAmxV+OR5LraH?=
 =?us-ascii?Q?/YIQNh6qjHLuRDMTRkup6pa0SFFoLvPTqz/19ID5Bf8pB1DYYeN2XP3nxj47?=
 =?us-ascii?Q?e3HlFwKyzOsx9M3bokWcUvw4j+/mymkVBEzLv1yh1pBRFQPla1TPHcgT7vR+?=
 =?us-ascii?Q?XVWxGfbQqUWdVIBxUDqbyMJdJ7BcDb+xx5jmdxj5a9UTYSdnfX0WGk+gAfD7?=
 =?us-ascii?Q?htqXI5U1Fj9rdb5sZn3T1LTzBRB992Iih3dVEHLU3fQEf1ZWonUhRr7tMpfK?=
 =?us-ascii?Q?weoSsBcRdWhVov0piXV+CykVa4Nf1pXC20BKDj6N+S2AWqzqovR7eTovLhHI?=
 =?us-ascii?Q?5ueHWfgtWvBHoHWnQoD0qU3EnGbc/CaUuh/irHqFx3Yk1dKcMgbqWMBxCA5c?=
 =?us-ascii?Q?ox7VeWVuMcDuHjSlCiCcrgxm02a6YEY0JZPXSMUg4/lZdbUf6hQxQxxe23nx?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db01c83e-8313-4564-776c-08dc8371bebf
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 02:06:13.5444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krEGoCuwOr67w+t0fvwfIO7HqW8HTbTgHOm/SdDkDjezhHLAEseN84BKnOx7NPh3SaBr53z8NmHcXWrf7xUPHzdkqk/b/AndOWg7t2iE4TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1050

CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz. But now
PLL0 rate is 1GHz and the cpu frequency loads become 250/333/500/1000MHz
in fact. The PLL0 rate should be default set to 1.5GHz and set the
divider of cpu_core clock to 2 in safe.

To keeo the cpu frequency stable when setting PLL0, the parent clock of
the cpu_root clock needs to be switched from PLL0 to another parent
clock and add notifier function to do this for PLL0 clock. In the
function, the cpu_root clock should be operated by saving its current
parent and setting a new safe parent (osc clock) before setting the PLL0
clock rate. After setting PLL0 rate, it should be switched back to the
original parent clock.

To keep the DTS same in Linux and U-Boot and the PLL0 rate is 1GHz in
U-Boot, the PLL0 rate should be set to 1.5GHz in the driver instead of
DTS.

Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---

Hi Stephen and Emil,

This patch is to fix the lower rate of CPUfreq by adding the notifier
for PLL0 clock and changing the PLL0 rate to 1.5GHz.

To keep the DTS same in Linux and U-Boot as Conor wants[1] and the PLL0
rate is 1GHz in U-Boot, the PLL0 rate should be set to 1.5GHz in the 
driver instead of DTS.

[1]: https://lore.kernel.org/all/20240515-reorder-even-8b9eebd91b45@spud/

Thanks,
Xingyu Wu

---
 .../clk/starfive/clk-starfive-jh7110-sys.c    | 54 ++++++++++++++++++-
 drivers/clk/starfive/clk-starfive-jh71x0.h    |  2 +
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 8f5e5abfa178..7469981fb405 100644
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
@@ -413,7 +439,11 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 		if (IS_ERR(priv->pll[0]))
 			return PTR_ERR(priv->pll[0]);
 	} else {
-		clk_put(pllclk);
+		priv->pll_clk_nb.notifier_call = jh7110_pll0_clk_notifier_cb;
+		ret = clk_notifier_register(pllclk, &priv->pll_clk_nb);
+		if (ret)
+			return ret;
+
 		priv->pll[0] = NULL;
 	}
 
@@ -501,7 +531,27 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return jh7110_reset_controller_register(priv, "rst-sys", 0);
+	ret = jh7110_reset_controller_register(priv, "rst-sys", 0);
+	if (ret)
+		return ret;
+
+	/* Set the divider cpu_core to 2 and set the PLL0 rate to 1.5G. */
+	pllclk = clk_get(priv->dev, "pll0_out");
+	if (!IS_ERR(pllclk)) {
+		struct clk *cpu_core = priv->reg[JH7110_SYSCLK_CPU_CORE].hw.clk;
+
+		ret = clk_set_rate(cpu_core, clk_get_rate(cpu_core) / 2);
+		if (ret)
+			return ret;
+
+		ret = clk_set_rate(pllclk, 1500000000);
+		if (ret)
+			return ret;
+
+		clk_put(pllclk);
+	}
+
+	return 0;
 }
 
 static const struct of_device_id jh7110_syscrg_match[] = {
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


