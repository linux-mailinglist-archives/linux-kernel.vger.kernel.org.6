Return-Path: <linux-kernel+bounces-295133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5269395976B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CF41F2211C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2801B2EE4;
	Wed, 21 Aug 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EfvKedzN"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E611CEAD7;
	Wed, 21 Aug 2024 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228955; cv=none; b=mkDVBsN2XdVBzDFn5gVvXU6ipJkaIaBzLwvq9mAEW6AVlo3Kvu++qy4Q0eeUjOoycuMGEQtXg7h/CvO0v9Franig+VBnqjDxlAltAaFx8+4LgFGYwmzc1LWZKBQaH7ZpBg9nhFJ2fW+SRJ48G1sL0hTy2CS013qYm6c9eWguKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228955; c=relaxed/simple;
	bh=zAMifUeBqI9PCImhkGcRl3306xsV6cQiDeFVn7OfAFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxErC1M9jnPDhHhg/XvRStHYSuFGIbyVcnQk1n3HIbK3maJMJjn9xTreSu++2Hk4rpYynd1b+VQSz/pXV4vMEUdd6VfEGvPkVlUkE1k06F2fUTUFpDBT9KlCJSops5lsBvKDHQ+QpQf7sBjdpJ/OnIm6bi1GOOLfIhb3clvp7AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EfvKedzN; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6c5c6fa85f9711ef8593d301e5c8a9c0-20240821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Pc+Rz7xF47G2RXFpWaQh/P3XdvswivOO3LEEm6zKyxU=;
	b=EfvKedzN14xOkmSpecoqfrvoCJ6vCND9+U+cczeLf0ts47k2MnKz4s+GX+qg/GTO7lQKz3Y/c0oKSmaJ5rGb6bwW+5j26uZd4xAlgl6BK/mxT4k98ffY+aZ7jP0ROBdHuJEzayANPh75oYTDhbv7H2CkX8ljlkGUneqqXNKTzp4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:d883342e-e34b-4f32-8aa1-de143a1cd67b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:fedeb2be-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6c5c6fa85f9711ef8593d301e5c8a9c0-20240821
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1761939311; Wed, 21 Aug 2024 16:29:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Aug 2024 16:29:03 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 21 Aug 2024 16:29:03 +0800
From: friday.yang <friday.yang@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Yong Wu <yong.wu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Friday Yang <friday.yang@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 3/4] memory: mtk-smi: mt8188: Add SMI clamp function
Date: Wed, 21 Aug 2024 16:26:51 +0800
Message-ID: <20240821082845.11792-4-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821082845.11792-1-friday.yang@mediatek.com>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.482200-8.000000
X-TMASE-MatchedRID: qyOEDd16wS2E9zgVMk3pXnTnOygHVQpO87QrIQgH3y1F/5XzBv3ecmb6
	PphVtfZggq4Vy91HEnbNnEpSSaVatI+TOcasruGo4pdq9sdj8LVPZ8WbDkfxU1fgf8AdlMAqlwW
	f7/4SyDuPtZzz7myNFIHWmfha3tGBOFS6mDjLiboXrP0cYcrA27BH/AqZyGLZatnKjjjc99k5tO
	klY41M4eLzNWBegCW2wgn7iDBesS3CttcwYNipX/m+9AxIOjOGV/HftdBdiQBmannclipmDvTQG
	tuG7oobdoCwYb5UuHGw2l5oOHJT1I0Udt0diqcc5rOA98Lef1exB7i0mR6aGEKo4D0joJpIoydM
	lEjRcid9fBQSbWi4PMsNjEULX/uuMIFAPLUElJzAvpLE+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.482200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	449FE31E0D714008FC2534D99ACA70D873FDFA9471BBBD59F946CA86430E3BD92000:8

In order to avoid handling glitch signal when MTCMOS on/off, SMI need
clamp and reset operation. Parse power reset settings for LARBs which
need to reset. Register genpd callback for SMI LARBs and apply reset
operations in the callback.

Signed-off-by: friday.yang <friday.yang@mediatek.com>
---
 drivers/memory/mtk-smi.c | 148 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index fbe52ecc0eca..1ccd62a17b1d 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -10,11 +10,16 @@
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
@@ -36,6 +41,13 @@
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
@@ -150,6 +162,7 @@ struct mtk_smi {
 };
 
 struct mtk_smi_larb { /* larb: local arbiter */
+	struct device			*dev;
 	struct mtk_smi			smi;
 	void __iomem			*base;
 	struct device			*smi_common_dev; /* common or sub-common dev */
@@ -157,6 +170,10 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	int				larbid;
 	u32				*mmu;
 	unsigned char			*bank;
+	struct regmap			*sub_comm_syscon;
+	int				sub_comm_inport;
+	struct notifier_block		nb;
+	struct reset_control		*rst_con;
 };
 
 static int
@@ -472,6 +489,60 @@ static void mtk_smi_larb_sleep_ctrl_disable(struct mtk_smi_larb *larb)
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
@@ -528,6 +599,59 @@ static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
 	return ret;
 }
 
+static int mtk_smi_larb_parse_clamp_info(struct mtk_smi_larb *larb)
+{
+	struct device *dev = larb->dev;
+	struct device_node *smi_node;
+	int ret;
+
+	/* smi_node could be NULL if larb directly linked to SMI common */
+	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi-sub-comm", 0);
+	if (!smi_node)
+		return 0;
+
+	larb->sub_comm_syscon = device_node_to_regmap(smi_node);
+	of_node_put(smi_node);
+	ret = of_property_read_u32(dev->of_node,
+				   "mediatek,smi-sub-comm-in-portid",
+				   &larb->sub_comm_inport);
+
+	if (IS_ERR(larb->sub_comm_syscon) || ret ||
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
+	struct device_node *reset_node;
+	struct device *dev = larb->dev;
+	int ret;
+
+	/* only larb with "resets" need to get reset setting */
+	reset_node = of_parse_phandle(dev->of_node, "resets", 0);
+	if (!reset_node)
+		return 0;
+	of_node_put(reset_node);
+
+	larb->rst_con = devm_reset_control_get(dev, "larb_rst");
+	if (IS_ERR(larb->rst_con))
+		return dev_err_probe(dev, PTR_ERR(larb->rst_con),
+				     "cannot get larb reset controller\n");
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
@@ -538,6 +662,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	if (!larb)
 		return -ENOMEM;
 
+	larb->dev = dev;
 	larb->larb_gen = of_device_get_match_data(dev);
 	larb->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(larb->base))
@@ -554,15 +679,29 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	pm_runtime_enable(dev);
+	/* find sub common to clamp larb for ISP software reset */
+	ret = mtk_smi_larb_parse_clamp_info(larb);
+	if (ret) {
+		dev_err(dev, "Failed to get clamp setting for larb\n");
+		goto err_pm_disable;
+	}
+
+	ret = mtk_smi_larb_parse_reset_info(larb);
+	if (ret) {
+		dev_err(dev, "Failed to get power setting for larb\n");
+		goto err_pm_disable;
+	}
+
 	platform_set_drvdata(pdev, larb);
 	ret = component_add(dev, &mtk_smi_larb_component_ops);
 	if (ret)
 		goto err_pm_disable;
+
+	pm_runtime_enable(dev);
+
 	return 0;
 
 err_pm_disable:
-	pm_runtime_disable(dev);
 	device_link_remove(dev, larb->smi_common_dev);
 	return ret;
 }
@@ -686,6 +825,10 @@ static const struct mtk_smi_common_plat mtk_smi_common_mt8188_vpp = {
 	.init     = mtk_smi_common_mt8195_init,
 };
 
+static const struct mtk_smi_common_plat mtk_smi_sub_common_mt8188 = {
+	.type     = MTK_SMI_GEN2_SUB_COMM,
+};
+
 static const struct mtk_smi_common_plat mtk_smi_common_mt8192 = {
 	.type     = MTK_SMI_GEN2,
 	.has_gals = true,
@@ -729,6 +872,7 @@ static const struct of_device_id mtk_smi_common_of_ids[] = {
 	{.compatible = "mediatek,mt8186-smi-common", .data = &mtk_smi_common_mt8186},
 	{.compatible = "mediatek,mt8188-smi-common-vdo", .data = &mtk_smi_common_mt8188_vdo},
 	{.compatible = "mediatek,mt8188-smi-common-vpp", .data = &mtk_smi_common_mt8188_vpp},
+	{.compatible = "mediatek,mt8188-smi-sub-common", .data = &mtk_smi_sub_common_mt8188},
 	{.compatible = "mediatek,mt8192-smi-common", .data = &mtk_smi_common_mt8192},
 	{.compatible = "mediatek,mt8195-smi-common-vdo", .data = &mtk_smi_common_mt8195_vdo},
 	{.compatible = "mediatek,mt8195-smi-common-vpp", .data = &mtk_smi_common_mt8195_vpp},
-- 
2.46.0


