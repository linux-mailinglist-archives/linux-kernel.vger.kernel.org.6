Return-Path: <linux-kernel+bounces-295132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B5695976A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1996283946
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD901B2EC7;
	Wed, 21 Aug 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CnoweuZj"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1A1B2501;
	Wed, 21 Aug 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228954; cv=none; b=kMhnytkNieYlFf59pOSnbCFPGRcbBWWmKOFoJ8EheRyZSXkpxLIJi0QawoQARAEhPsFptKAB4ySpuzRL4a8byWhoxnK3/9v93c6Q/4Eg/qjxWCgkTM82mdq4FcP/Qm/phF2sJZVRX6Lygt9DCGqdE5F5AlvWEi2Bh7lVEIBQ3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228954; c=relaxed/simple;
	bh=JHfMocmDve6tw5dQ7N/PFgi3uB+gMUZCNc3nTGyplqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYnzi6RlMiHYRmGlJaom4TuJoS7v1kf+Lr/hYyQiGD8AkkY3v6Fgn4gsF6T7Zv+zSHlSlMS+fsLVpNmMv98zf3op+6q+dnbByItIsytPdFXDKE0/4PFQP+qNY737mYi42BRoG+TRFM2jkjydOT50+H9DKQrMvtYFiAHAp7ZGXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CnoweuZj; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6cf824485f9711ef8593d301e5c8a9c0-20240821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cB2ll77VbnemP6OA1wUDzb5/0CHKi39SLfVFe6VhAqg=;
	b=CnoweuZjxdIH7rY1Am4ifHBJfL4uAbC3Dg3iw/ZXT4VGNhQOnXqQiAuLyB60TbizB07JJJ93PPFHs920s8DN3jOcIr2dKO/EariT276PUZfF6Zw4IEMyw/vpYbG5Db51poT6oUKJfLtuqUh8j7F64+ivR4XbV0/g+ae4XQxm8Hc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:de8cf4f1-9f2b-453b-8fc1-2a7a0ecfbc26,IP:0,U
	RL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:6dc6a47,CLOUDID:148ff1ce-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 6cf824485f9711ef8593d301e5c8a9c0-20240821
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 798105000; Wed, 21 Aug 2024 16:29:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Aug 2024 16:29:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 21 Aug 2024 16:29:05 +0800
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
Subject: [PATCH 4/4] reset: mediatek: Add reset control driver for SMI
Date: Wed, 21 Aug 2024 16:26:52 +0800
Message-ID: <20240821082845.11792-5-friday.yang@mediatek.com>
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

Add a reset-controller driver for performing reset management of
SMI LARBs on MediaTek platform. This driver uses the regmap
frameworks to actually implement the various reset functions
needed when SMI LARBs apply clamp operations.

Signed-off-by: friday.yang <friday.yang@mediatek.com>
---
 drivers/reset/Kconfig              |   9 ++
 drivers/reset/Makefile             |   1 +
 drivers/reset/reset-mediatek-smi.c | 152 +++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 drivers/reset/reset-mediatek-smi.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 67bce340a87e..e984a5a332f1 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -154,6 +154,15 @@ config RESET_MESON_AUDIO_ARB
 	  This enables the reset driver for Audio Memory Arbiter of
 	  Amlogic's A113 based SoCs
 
+config RESET_MTK_SMI
+	bool "MediaTek SMI Reset Driver"
+	depends on MTK_SMI
+	help
+	  This option enables the reset controller driver for MediaTek SMI.
+	  This reset driver is responsible for managing the reset signals
+	  for SMI larbs. Say Y if you want to control reset signals for
+	  MediaTek SMI larbs. Otherwise, say N.
+
 config RESET_NPCM
 	bool "NPCM BMC Reset Driver" if COMPILE_TEST
 	default ARCH_NPCM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 27b0bbdfcc04..241777485b40 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
+obj-$(CONFIG_RESET_MTK_SMI) += reset-mediatek-smi.o
 obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
 obj-$(CONFIG_RESET_NUVOTON_MA35D1) += reset-ma35d1.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
diff --git a/drivers/reset/reset-mediatek-smi.c b/drivers/reset/reset-mediatek-smi.c
new file mode 100644
index 000000000000..ead747e80ad5
--- /dev/null
+++ b/drivers/reset/reset-mediatek-smi.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Reset driver for MediaTek SMI module
+ *
+ * Copyright (C) 2024 MediaTek Inc.
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/reset/mt8188-resets.h>
+
+#define to_mtk_smi_reset_data(_rcdev)	\
+	container_of(_rcdev, struct mtk_smi_reset_data, rcdev)
+
+struct mtk_smi_larb_reset {
+	unsigned int offset;
+	unsigned int value;
+};
+
+static const struct mtk_smi_larb_reset rst_signal_mt8188[] = {
+	[MT8188_SMI_RST_LARB10]		= { 0xC, BIT(0) }, /* larb10 */
+	[MT8188_SMI_RST_LARB11A]	= { 0xC, BIT(0) }, /* larb11a */
+	[MT8188_SMI_RST_LARB11C]	= { 0xC, BIT(0) }, /* larb11c */
+	[MT8188_SMI_RST_LARB12]		= { 0xC, BIT(8) }, /* larb12 */
+	[MT8188_SMI_RST_LARB11B]	= { 0xC, BIT(0) }, /* larb11b */
+	[MT8188_SMI_RST_LARB15]		= { 0xC, BIT(0) }, /* larb15 */
+	[MT8188_SMI_RST_LARB16B]	= { 0xA0, BIT(4) }, /* larb16b */
+	[MT8188_SMI_RST_LARB17B]	= { 0xA0, BIT(4) }, /* larb17b */
+	[MT8188_SMI_RST_LARB16A]	= { 0xA0, BIT(4) }, /* larb16a */
+	[MT8188_SMI_RST_LARB17A]	= { 0xA0, BIT(4) }, /* larb17a */
+};
+
+struct mtk_smi_larb_plat {
+	const struct mtk_smi_larb_reset		*reset_signal;
+	const unsigned int			larb_reset_nr;
+};
+
+struct mtk_smi_reset_data {
+	const struct mtk_smi_larb_plat *larb_plat;
+	struct reset_controller_dev rcdev;
+	struct regmap *regmap;
+};
+
+static const struct mtk_smi_larb_plat mtk_smi_larb_mt8188 = {
+	.reset_signal = rst_signal_mt8188,
+	.larb_reset_nr = ARRAY_SIZE(rst_signal_mt8188),
+};
+
+static int mtk_smi_larb_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct mtk_smi_reset_data *data = to_mtk_smi_reset_data(rcdev);
+	const struct mtk_smi_larb_plat *larb_plat = data->larb_plat;
+	const struct mtk_smi_larb_reset *larb_rst = larb_plat->reset_signal + id;
+	int ret;
+
+	ret = regmap_set_bits(data->regmap, larb_rst->offset, larb_rst->value);
+	if (ret)
+		return ret;
+	ret = regmap_clear_bits(data->regmap, larb_rst->offset, larb_rst->value);
+
+	return ret;
+}
+
+static int mtk_smi_larb_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct mtk_smi_reset_data *data = to_mtk_smi_reset_data(rcdev);
+	const struct mtk_smi_larb_plat *larb_plat = data->larb_plat;
+	const struct mtk_smi_larb_reset *larb_rst = larb_plat->reset_signal + id;
+	int ret;
+
+	ret = regmap_set_bits(data->regmap, larb_rst->offset, larb_rst->value);
+	if (ret)
+		dev_err(rcdev->dev, "[%s] Failed to shutdown larb %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int mtk_smi_larb_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct mtk_smi_reset_data *data = to_mtk_smi_reset_data(rcdev);
+	const struct mtk_smi_larb_plat *larb_plat = data->larb_plat;
+	const struct mtk_smi_larb_reset *larb_rst = larb_plat->reset_signal + id;
+	int ret;
+
+	ret = regmap_clear_bits(data->regmap, larb_rst->offset, larb_rst->value);
+	if (ret)
+		dev_err(rcdev->dev, "[%s] Failed to reopen larb %d\n", __func__, ret);
+
+	return ret;
+}
+
+static const struct reset_control_ops mtk_smi_reset_ops = {
+	.reset		= mtk_smi_larb_reset,
+	.assert		= mtk_smi_larb_reset_assert,
+	.deassert	= mtk_smi_larb_reset_deassert,
+};
+
+static int mtk_smi_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct mtk_smi_larb_plat *larb_plat = of_device_get_match_data(dev);
+	struct device_node *np = dev->of_node, *reset_node;
+	struct mtk_smi_reset_data *data;
+	struct regmap *regmap;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	reset_node = of_parse_phandle(np, "mediatek,larb-rst-syscon", 0);
+	if (!reset_node)
+		return -EINVAL;
+
+	regmap = device_node_to_regmap(reset_node);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	data->larb_plat = larb_plat;
+	data->regmap = regmap;
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.ops = &mtk_smi_reset_ops;
+	data->rcdev.of_node = np;
+	data->rcdev.nr_resets = larb_plat->larb_reset_nr;
+	data->rcdev.dev = dev;
+	platform_set_drvdata(pdev, data);
+
+	return devm_reset_controller_register(dev, &data->rcdev);
+}
+
+static const struct of_device_id mtk_smi_larb_reset_of_match[] = {
+	{ .compatible = "mediatek,smi-reset-mt8188", .data = &mtk_smi_larb_mt8188 },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, mtk_smi_larb_reset_of_match);
+
+static struct platform_driver mtk_smi_reset_driver = {
+	.probe = mtk_smi_reset_probe,
+	.driver = {
+		.name = "mediatek-smi-reset",
+		.of_match_table = mtk_smi_larb_reset_of_match,
+	},
+};
+module_platform_driver(mtk_smi_reset_driver);
+
+MODULE_AUTHOR("Friday.Yang@mediatek.com");
+MODULE_DESCRIPTION("MediaTek SMI Reset Driver");
+MODULE_LICENSE("GPL");
-- 
2.46.0


