Return-Path: <linux-kernel+bounces-415263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEBD9D33AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A0B28319A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2015EFA0;
	Wed, 20 Nov 2024 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GntvGOok"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04472158DC6;
	Wed, 20 Nov 2024 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732084636; cv=none; b=W0ntcKxhVb+Tb+ex9V+GwBjsMmvgCUIANezma85oryZhGXjOeJnXi862is09N3hR3HydNGP5Rx4Kic0c1OqF3nTjXvkxy8bsBqXCfttNzGKxchv+6zeaFnCD0vopHaltD5aFrp8PZtaT92CWZySBg7ZWkAhXGkYHI75rl53gfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732084636; c=relaxed/simple;
	bh=wP56fNa9xRCXbwIAKRB7fdWh5HLaTCvlNfUMeYc2DO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jw2UzUbU050rdVv5+JuQUl2K+ktND1nRVgTyYmHy3vf5OxNd5Tq+AZ0c1s5Q+/Ub31ejLAw0LIlDjFTJZ5AfLX7r1CDoC0XXZBQP4AvJY/x7tx18YR909t3QY+UUeUfeo0PbpQo6qDOPyiTyiC1r2DnbTCr3NJlXw1f43wGy2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GntvGOok; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dd1e90aea70911efbd192953cf12861f-20241120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=plcGEKI++Y4M5i0ObDAzfA/yxlnBHw3L4k1yFF26Ipc=;
	b=GntvGOok19TGGPnsdEEMSPNCOlU0LfbteaLwxsz1CAqHL+eOXM6QvBz5qJGEAH6zwQhQ2WSljcQz7Ht6u3yCWSeSPg+5FcjowUcIuhs3IMh7bMsuMt7LRNVn5KYy9+l8ykV7F1lvhQSXIAedP+6YZ2cObbS1zMTmFlJ5hfxMYDw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:d3167e1b-bbc1-4336-90c1-40cc1f311be4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:01f580a0-f395-4dfc-8188-ce2682df7fd8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dd1e90aea70911efbd192953cf12861f-20241120
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 797413326; Wed, 20 Nov 2024 14:37:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Nov 2024 14:37:06 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Nov 2024 14:37:05 +0800
From: Friday Yang <friday.yang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Friday Yang
	<friday.yang@mediatek.com>
Subject: [PATCH v2 2/2] memory: mtk-smi: mt8188: Add SMI clamp function
Date: Wed, 20 Nov 2024 14:36:39 +0800
Message-ID: <20241120063701.8194-3-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241120063701.8194-1-friday.yang@mediatek.com>
References: <20241120063701.8194-1-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In order to avoid handling glitch signal when MTCMOS on/off, SMI need
clamp and reset operation. Parse power reset settings for LARBs which
need to reset. Register genpd callback for SMI LARBs and apply reset
operations in the callback.

Signed-off-by: Friday Yang <friday.yang@mediatek.com>
---
 drivers/memory/mtk-smi.c | 175 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 171 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 2bc034dff691..c7119f655350 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -10,15 +10,21 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/reset-controller.h>
 #include <linux/soc/mediatek/mtk_sip_svc.h>
 #include <soc/mediatek/smi.h>
 #include <dt-bindings/memory/mt2701-larb-port.h>
 #include <dt-bindings/memory/mtk-memory-port.h>
+#include <dt-bindings/reset/mt8188-resets.h>
 
 /* SMI COMMON */
 #define SMI_L1LEN			0x100
@@ -36,6 +42,13 @@
 #define SMI_DCM				0x300
 #define SMI_DUMMY			0x444
 
+#define SMI_COMMON_CLAMP_EN		0x3c0
+#define SMI_COMMON_CLAMP_EN_SET		0x3c4
+#define SMI_COMMON_CLAMP_EN_CLR		0x3c8
+#define SMI_COMMON_CLAMP_MASK(inport)	BIT(inport)
+
+#define SMI_SUB_COMM_INPORT_NR		(8)
+
 /* SMI LARB */
 #define SMI_LARB_SLP_CON                0xc
 #define SLP_PROT_EN                     BIT(0)
@@ -134,6 +147,7 @@ struct mtk_smi_larb_gen {
 	unsigned int			larb_direct_to_common_mask;
 	unsigned int			flags_general;
 	const u8			(*ostd)[SMI_LARB_PORT_NR_MAX];
+	const u8			*clamp_port;
 };
 
 struct mtk_smi {
@@ -150,6 +164,7 @@ struct mtk_smi {
 };
 
 struct mtk_smi_larb { /* larb: local arbiter */
+	struct device			*dev;
 	struct mtk_smi			smi;
 	void __iomem			*base;
 	struct device			*smi_common_dev; /* common or sub-common dev */
@@ -157,6 +172,10 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	int				larbid;
 	u32				*mmu;
 	unsigned char			*bank;
+	struct regmap			*sub_comm_syscon;
+	u8				sub_comm_inport;
+	struct notifier_block		nb;
+	struct reset_control		*rst_con;
 };
 
 static int
@@ -377,6 +396,19 @@ static const u8 mtk_smi_larb_mt8195_ostd[][SMI_LARB_PORT_NR_MAX] = {
 	[28] = {0x1a, 0x0e, 0x0a, 0x0a, 0x0c, 0x0e, 0x10,},
 };
 
+static const u8 mtk_smi_larb_clamp_port_mt8188[] = {
+	[MT8188_SMI_RST_LARB10]		= 1,
+	[MT8188_SMI_RST_LARB11A]	= 2,
+	[MT8188_SMI_RST_LARB11C]	= 3,
+	[MT8188_SMI_RST_LARB12]		= 0,
+	[MT8188_SMI_RST_LARB11B]	= 2,
+	[MT8188_SMI_RST_LARB15]		= 1,
+	[MT8188_SMI_RST_LARB16B]	= 2,
+	[MT8188_SMI_RST_LARB17B]	= 3,
+	[MT8188_SMI_RST_LARB16A]	= 2,
+	[MT8188_SMI_RST_LARB17A]	= 3,
+};
+
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
 	.port_in_larb = {
 		LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
@@ -423,6 +455,7 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8188 = {
 	.flags_general	            = MTK_SMI_FLAG_THRT_UPDATE | MTK_SMI_FLAG_SW_FLAG |
 				      MTK_SMI_FLAG_SLEEP_CTL | MTK_SMI_FLAG_CFG_PORT_SEC_CTL,
 	.ostd		            = mtk_smi_larb_mt8188_ostd,
+	.clamp_port                 = mtk_smi_larb_clamp_port_mt8188,
 };
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
@@ -472,6 +505,60 @@ static void mtk_smi_larb_sleep_ctrl_disable(struct mtk_smi_larb *larb)
 	writel_relaxed(0, larb->base + SMI_LARB_SLP_CON);
 }
 
+static int mtk_smi_larb_clamp_protect_enable(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	int ret;
+
+	/* sub_comm_syscon could be NULL if larb directly linked to SMI common */
+	if (!larb->sub_comm_syscon)
+		return -EINVAL;
+
+	ret = regmap_write(larb->sub_comm_syscon, SMI_COMMON_CLAMP_EN_SET,
+			   SMI_COMMON_CLAMP_MASK(larb->sub_comm_inport));
+	if (ret)
+		dev_err(dev, "Unable to enable clamp, inport %d, ret %d\n",
+			larb->sub_comm_inport, ret);
+
+	return ret;
+}
+
+static int mtk_smi_larb_clamp_protect_disble(struct device *dev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	int ret;
+
+	/* sub_comm_syscon could be NULL if larb directly linked to SMI common */
+	if (!larb->sub_comm_syscon)
+		return -EINVAL;
+
+	ret = regmap_write(larb->sub_comm_syscon, SMI_COMMON_CLAMP_EN_CLR,
+			   SMI_COMMON_CLAMP_MASK(larb->sub_comm_inport));
+	if (ret)
+		dev_err(dev, "Unable to disable clamp, inport %d, ret %d\n",
+			larb->sub_comm_inport, ret);
+
+	return ret;
+}
+
+static int mtk_smi_genpd_callback(struct notifier_block *nb,
+				  unsigned long flags, void *data)
+{
+	struct mtk_smi_larb *larb = container_of(nb, struct mtk_smi_larb, nb);
+	struct device *dev = larb->dev;
+
+	if (flags == GENPD_NOTIFY_PRE_ON || flags == GENPD_NOTIFY_PRE_OFF) {
+		/* disable related SMI sub-common port */
+		mtk_smi_larb_clamp_protect_enable(dev);
+	} else if (flags == GENPD_NOTIFY_ON) {
+		/* enable related SMI sub-common port */
+		reset_control_reset(larb->rst_con);
+		mtk_smi_larb_clamp_protect_disble(dev);
+	}
+
+	return NOTIFY_OK;
+}
+
 static int mtk_smi_device_link_common(struct device *dev, struct device **com_dev)
 {
 	struct platform_device *smi_com_pdev;
@@ -528,6 +615,66 @@ static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
 	return ret;
 }
 
+static int mtk_smi_larb_parse_clamp_info(struct mtk_smi_larb *larb)
+{
+	struct device *dev = larb->dev;
+	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
+	struct device_node *smi_node;
+	struct of_phandle_args args;
+	int ret, index;
+
+	/* Only SMI LARBs located in camera and image subsys need to
+	 * apply clamp and reset operation, others can be skipped.
+	 */
+	ret = of_parse_phandle_with_fixed_args(dev->of_node,
+					       "resets", 1, 0, &args);
+	if (ret)
+		return 0;
+
+	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
+	if (!smi_node)
+		return -EINVAL;
+
+	index = args.args[0];
+	larb->sub_comm_inport = larb_gen->clamp_port[index];
+	larb->sub_comm_syscon = device_node_to_regmap(smi_node);
+	of_node_put(smi_node);
+
+	if (IS_ERR(larb->sub_comm_syscon) ||
+	    larb->sub_comm_inport >= SMI_SUB_COMM_INPORT_NR) {
+		larb->sub_comm_syscon = NULL;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mtk_smi_larb_parse_reset_info(struct mtk_smi_larb *larb)
+{
+	struct device *dev = larb->dev;
+	int ret;
+
+	/* Only SMI LARBs located in camera and image subsys need to
+	 * apply clamp and reset operation, others can be skipped.
+	 */
+	if (!of_find_property(dev->of_node, "resets", NULL))
+		return 0;
+
+	larb->rst_con = devm_reset_control_get(dev, "larb");
+	if (IS_ERR(larb->rst_con))
+		return dev_err_probe(dev, PTR_ERR(larb->rst_con),
+				     "Can not get larb reset controller\n");
+
+	larb->nb.notifier_call = mtk_smi_genpd_callback;
+	ret = dev_pm_genpd_add_notifier(dev, &larb->nb);
+	if (ret) {
+		dev_err(dev, "Failed to add genpd callback %d\n", ret);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int mtk_smi_larb_probe(struct platform_device *pdev)
 {
 	struct mtk_smi_larb *larb;
@@ -538,6 +685,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	if (!larb)
 		return -ENOMEM;
 
+	larb->dev = dev;
 	larb->larb_gen = of_device_get_match_data(dev);
 	larb->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(larb->base))
@@ -554,15 +702,29 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	pm_runtime_enable(dev);
+	/* find sub common to clamp larb for ISP software reset */
+	ret = mtk_smi_larb_parse_clamp_info(larb);
+	if (ret) {
+		dev_err(dev, "Failed to get clamp setting for larb\n");
+		goto err_link_remove;
+	}
+
+	ret = mtk_smi_larb_parse_reset_info(larb);
+	if (ret) {
+		dev_err(dev, "Failed to get power setting for larb\n");
+		goto err_link_remove;
+	}
+
 	platform_set_drvdata(pdev, larb);
 	ret = component_add(dev, &mtk_smi_larb_component_ops);
 	if (ret)
-		goto err_pm_disable;
+		goto err_link_remove;
+
+	pm_runtime_enable(dev);
+
 	return 0;
 
-err_pm_disable:
-	pm_runtime_disable(dev);
+err_link_remove:
 	device_link_remove(dev, larb->smi_common_dev);
 	return ret;
 }
@@ -686,6 +848,10 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8188_vpp = {
 	.init     = mtk_smi_common_mt8195_init,
 };
 
+static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8188 = {
+	.type     = MTK_SMI_GEN2_SUB_COMM,
+};
+
 static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
 	.type     = MTK_SMI_GEN2,
 	.has_gals = true,
@@ -729,6 +895,7 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt8186-smi-common", .data = &mtk_smi_common_mt8186},
 	{.compatible = "mediatek,mt8188-smi-common-vdo", .data = &mtk_smi_common_mt8188_vdo},
 	{.compatible = "mediatek,mt8188-smi-common-vpp", .data = &mtk_smi_common_mt8188_vpp},
+	{.compatible = "mediatek,mt8188-smi-sub-common", .data = &mtk_smi_sub_common_mt8188},
 	{.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
 	{.compatible = "mediatek,mt8195-smi-common-vdo", .data = &mtk_smi_common_mt8195_vdo},
 	{.compatible = "mediatek,mt8195-smi-common-vpp", .data = &mtk_smi_common_mt8195_vpp},
-- 
2.46.0


