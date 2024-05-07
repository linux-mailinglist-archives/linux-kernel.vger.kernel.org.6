Return-Path: <linux-kernel+bounces-170870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3CA8BDD21
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D0928347E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0F013C9B9;
	Tue,  7 May 2024 08:26:03 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2124.outbound.protection.partner.outlook.cn [139.219.146.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69113C831;
	Tue,  7 May 2024 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715070363; cv=fail; b=EXHTuzVLknGVK3ytIP8qxnyj2ZHxOgC7mXCXaVCqDeDy5OBMeK4JJLVxzo0JVcvB9WnGruQatW0kKyDKJfol2hsemaLLwiDnJeFeVeOTndeC1xbGZ0uM8v/Fx4a2TvQ8iUdIsndK0I//v5x8vMWVmPN8x5nc9q8WA7D3Owdez/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715070363; c=relaxed/simple;
	bh=+d1k85xv5nynBkPyXacwxSPEm1TgMXq7YLDTzM9QmM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eoRGd5BQ7+jo2VaUU6UcrShXRIgpJ8jbk/sWY/8wGWxaFhXqI6foTxLHM3hGH7DPQ8n2nSsRP6jGWI2dIsjaP3eSHZZQsK/992h3MWxOwtSauRH2RzUopR3UNmX6GBlw2dwAgJLmfp38mAAmP7kngBEsvp10c4SocWSJTvaNkuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRIhjox5LY2IEuMSvjCeZWfEHC8bQMFUc/yBDfTXs0TVd5k2wEGQqX9nyJa7lp156InFEnLs4IuIN0bCh4LSGcKNTFSICmzDZO7HUn5aFR7kMs3Wy4QwzRzCPl6R5ygno3Y4NFiyGvxkvHo50NODCqoeAoyYXiCV/bu2K28Yk6y77/R2ZEZ52KdbTZjLPOExlN6HxgQL0mChDh76rZrmnqRsmjqdRo8EqY5XFPjltfjVd+EBkgysa93YD9bmQy5jsPIe3sh0jm+lqKdN0+Iby2E7UNGgOwhnGCdMDXUCOPdQFtF+GPpwP9egbLZAoTlAG3ALFuM92/9KKmnDR0GGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsKXRjNxpLy5oL+nixW6k3X0zh3KH6nERM5pf9BfTh8=;
 b=BPnvGKBRFwxNxJlIk06uU13caWlTc7RMEfaqaBWutSS7CaFS4MePKXWylGCq8ZNW21rv0m1xhoJ1Fh50qrhDMIyw7+1703jFRY81SGEr6aY+En4PonZ5DrYMOzEAAtasuiow7PhN0b/Mmvu7/xNZs0iHtxSrU7CcNTcuR6Fa5W7twQG1/RSgfEPyOraWLkanU8TXxSZM/NHrt07d0OLV02/hB8RzDBvKWeU9AXBYy2e9f32fI32m1/5ecHelYxqExQsVTIDv4VfjDucEerehD119Qt37gIQjoiu/pWLbvBSmYtt97kO4hj+/CeqoYV1EPog8ivkOurm6wtbgTvPagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1100.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 7 May
 2024 06:53:27 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::e903:99a6:10b7:304d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::e903:99a6:10b7:304d%6])
 with mapi id 15.20.7472.044; Tue, 7 May 2024 06:53:27 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 1/2] clk: starfive: jh7110-sys: Add notifier for PLL0 clock
Date: Tue,  7 May 2024 14:53:18 +0800
Message-Id: <20240507065319.274976-2-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::32) To NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB0956:EE_|NTZPR01MB1100:EE_
X-MS-Office365-Filtering-Correlation-Id: 97fd2099-bc7f-4544-9e83-08dc6e62658c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IQVtz3/8V3KM23kuRdpvR2kX5hbWve944w3IcDZGCt7lohn/JmBQHwMt2F5KVdJXu2a3hOLOoQmiq3uV37daexW5f0TLhH69aOblqlP/dPjq1R8Xq2QJH2laQzQZh50Z4T03kjdGbZ8n4pEcbreUQzKpT/05ZQ+OR1blxSVNDarUG7IOGDFTW9rCQWVldemqDLJ1RDpCq5Hjvb2dZQ9obWHCvYKC6xxkYw23+JDjAMH3ojBzsPth2v9ap5ozMqSQCHnKc4TiNy1jViypZG8uPpuUiClyZYdI6BVFwItT00SAhQiayPTowC2vFyM0cTY6RbUyjARxanXttCEtgWZDjaWFHx4MCgGI0K5kX05MRo4Rvb/SzCepP43TSUKZCZjtnD80LHUE6TRJQVorUhb1RAtL5Q+jDF8xn6pf4TPZtHnp+tKiZQwfSLriDKDnNzfKuvlPzo7DqhOBRQXeKWlGrYIBgcD9WwlWXBtkMEICB+Hmsb0kUJnWlnk32ks7aoW3fQ5BgvEv2tMD7GThp+kg4ZJKPqHuLwu9KityvO6wYegJAotmqawJwBeLKbcWSS13osEuuTprdXpA7y4KkwT/rIBYhfbWnsh5oYBn77kkWqB9jHsDgnn5QPcoA2600UdK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(41320700004)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ATo7AylaMm9ZQu1vkp9C6qgbHozrZ7rN5pHYPD/0r84DoEJTE4vve0u1lCw?=
 =?us-ascii?Q?zfcnh0nexpDsRSnjfGjUc2c/hpdQ6JMBiepqA+ChFZ2Jz5+RQE5/8/pg9Rp8?=
 =?us-ascii?Q?dA5x3oQ80GjxohQuT6WnQL++zZjLsjVmkC28DsB8zEN4PbcjShHnWzF4zB5H?=
 =?us-ascii?Q?hPv+Rsmf5bAR9UI5n9DbMdRvGVeAnK4rMQmERgoPkmVY8V8kTVrh/hK9kFTb?=
 =?us-ascii?Q?Se8xPHz9L2sjm6CGGNNkJNo06I0AS/XkZScH3hpT7nIV77SYwrI2iJF1Fb+p?=
 =?us-ascii?Q?BcPh+xkHV9OKQM0Bb0OXx2Ub5NUBcG49LQi+F9WVJqONuNP+K87R9cGESFsR?=
 =?us-ascii?Q?NzjKKmEIJbo4OEaVB1efCMiFzVdku0aCvmASHNL10q8uN1Mri8ZZJtbBHwfT?=
 =?us-ascii?Q?j1KulYb92Lw8/fiFsEINZ7oDWWWnpUdWLwQXf5hapLnPVQVicUJstXXf5KBv?=
 =?us-ascii?Q?t/QU6x+i0L/agnaKDoVT93NC2cQ3womO1HFnQMgQI9ADXu25HJ+il8Q/UYy1?=
 =?us-ascii?Q?8PanKPRAqguQfKyB0XCEPgtev3Arvdc/kuL2q22HyxNj6HPCZfM6lnZBKVY6?=
 =?us-ascii?Q?mXP5CFsPuKbmfr9G8SVf6LVFQ047SzDwbcgr7AcieyGs7E0Wm9lJtVTFNY5B?=
 =?us-ascii?Q?tFfmIyCnoWS1j9EhimACmI1+cRZHrbmwE7bKhQmVBJPOS+7TlEIbxs6sibB4?=
 =?us-ascii?Q?ogLMC99mviIakBB31DEiphROmZUg3AkEsSGNOQAldFRcqZzo/80SjPVM39pE?=
 =?us-ascii?Q?SQIoQFPD/Y4p3r4ks1EMIa8p5MR3gS4VPd0/mO0vELfgBBJsO/lx0LNS+cpw?=
 =?us-ascii?Q?QvuJ8w1j+99xsUWxTsdPbVU0Yu9vsQncOPMF/MMlm8nckGj9AMp3vBUuclbK?=
 =?us-ascii?Q?PHrupZK3h0vmgNTY7wyVJixXHsXj5OT+0rHZ2b6ScWnoTRL8a06+r0Nys+a/?=
 =?us-ascii?Q?YdLgJzetlx4Yfv1faoBZaCLUeGC6UKxX8/BWpuQ6QYZL+FeiOTIfJuLCWSA2?=
 =?us-ascii?Q?Q7uEwAWKaO/l0UFpGPOUfHZbTgpvueq3todx/FweHPsNSWiaHJXEMaq+XYlM?=
 =?us-ascii?Q?7AgJJye1WuEyz2PnyXsdguMk86WUHSnems1TilWAQVNYn44eIXjZlsm63AE6?=
 =?us-ascii?Q?s3dLcin9vN70fS5v5gaMzcHo6/v3Fu5PbQnyjDbpOJ87t/dFW1XoMPEuC5SA?=
 =?us-ascii?Q?E5h6fmkOHLxpcK5HmR/O+8yLiWWnwzrkQW82vnkeYD2LWrI+KXGPb+Kj17w/?=
 =?us-ascii?Q?A9kAEbQp1Fc68q6xwMUS+D4godei20whPY6sULNgCt73iTVGsoJX3X+gLug9?=
 =?us-ascii?Q?Xnoeh92fqI432x81VSFs/Tc7W1bcT3jo4FXKZWJotHdouIRXnQ7ulBuHJoQM?=
 =?us-ascii?Q?WdyEeBiozCxb65Zf02uJlnbJz3cSSHPO4OzXZM2wVDE7zqRckkSrWz5WOWXV?=
 =?us-ascii?Q?79We9XmK69LyhpkybCSPRj9OTSGTzNextQNiCTNV83SLgDH2sask1EXK0WAL?=
 =?us-ascii?Q?XWs/gJPL+hvDlXaYQj83OMxQ4P5EAVdjGU4Zws7dFZtblpHXfKZM4PxtHGBo?=
 =?us-ascii?Q?A7wI6eyoZ8iDknkJy6EMql/fW2pA7gEsZWnH37KVJljUxTIuN0Y0xG1VymzC?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97fd2099-bc7f-4544-9e83-08dc6e62658c
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 06:53:27.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2b/6dNvnwep52ugACydxk34v0QdM1sIQRAKoXSuRZZji8BSl2wn6Lu9sOdnswx8WKJbj121J4ryl6pW2eSjcyIdJg28FhCktOjDzCOpyHPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1100

Add notifier function for PLL0 clock. In the function, the cpu_root clock
should be operated by saving its current parent and setting a new safe
parent (osc clock) before setting the PLL0 clock rate. After setting PLL0
rate, it should be switched back to the original parent clock.

Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
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
2.25.1


