Return-Path: <linux-kernel+bounces-576533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA1A7108F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE6516E6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BF7190696;
	Wed, 26 Mar 2025 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nWWFm+1b"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E61BC41;
	Wed, 26 Mar 2025 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742970659; cv=none; b=hUa+7jqv/E8tWye/h0qMJTcHaFGIOYOPbsAQbB96SOxhSt89Ow7DEg5UfwyswgfpzHql6u2XttHLQZy85dC+nCwjCaK9a+UvU17lPgsbolnLjk0ZfM0NIKwAdmGXxqSx0lLigmZM9g9edyWm9yDcg1BJET9iPoTShkXO52i2ErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742970659; c=relaxed/simple;
	bh=kafvIR4yCHmlSXlASeHB9y14csd763NgLzmQs/+InCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vw0uGiYbR2StbcvVd6PghiW/UMl7okfzhBBPJKsI2456012Tr9B8NC5sSxSU/DT/+jtOLVjKDrDhCGGneibWr2yRk2H9cr7ckcpLCgLHvdHx3Bh1uHSm1U7z6qgFUUQWfQinWGPtRmY2XUKQ8emC3SgcXRX4qS8/TwDwh9psCGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nWWFm+1b; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dc7d58960a0b11f08eb9c36241bbb6fb-20250326
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3M60JeCSn2pGOvEmA1Fg/RS61NlVnIgN2BJbNhjZiVQ=;
	b=nWWFm+1bPcQGElpT3/llMBzTbYXXCnsH75bInltCxyQ58T3szPxuEtHBQxXgM6BV40HuDzK6oPTFUBhR+WKj40BgiZe2sQNK8qpNwkI/uj/olzAU3C/kex/+BFN65I3F/FpkdPz/SjHPYiDjMpFf19/yUXLKnYi4oN+HaTcFMTU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:8927d2ef-b614-4577-85a2-46125fd669f8,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:0355cfc6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dc7d58960a0b11f08eb9c36241bbb6fb-20250326
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <crystal.guo@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 29433327; Wed, 26 Mar 2025 14:30:50 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 26 Mar 2025 14:30:49 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 26 Mar 2025 14:30:48 +0800
From: Crystal Guo <crystal.guo@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Crystal Guo
	<crystal.guo@mediatek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [v3,2/2] memory/mediatek: Add an interface to get current DDR data rate
Date: Wed, 26 Mar 2025 14:30:32 +0800
Message-ID: <20250326063041.7126-3-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250326063041.7126-1-crystal.guo@mediatek.com>
References: <20250326063041.7126-1-crystal.guo@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add MediaTek DRAMC driver to provide an interface that can
obtain current DDR data rate.

Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
---
 drivers/memory/Kconfig              |   1 +
 drivers/memory/Makefile             |   1 +
 drivers/memory/mediatek/Kconfig     |  21 +++
 drivers/memory/mediatek/Makefile    |   2 +
 drivers/memory/mediatek/mtk-dramc.c | 232 ++++++++++++++++++++++++++++
 5 files changed, 257 insertions(+)
 create mode 100644 drivers/memory/mediatek/Kconfig
 create mode 100644 drivers/memory/mediatek/Makefile
 create mode 100644 drivers/memory/mediatek/mtk-dramc.c

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index c82d8d8a16ea..b1698549ff81 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -227,5 +227,6 @@ config STM32_FMC2_EBI
 
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
+source "drivers/memory/mediatek/Kconfig"
 
 endif
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index d2e6ca9abbe0..c0facf529803 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_STM32_FMC2_EBI)	+= stm32-fmc2-ebi.o
 
 obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
+obj-$(CONFIG_MEDIATEK_MC)	+= mediatek/
 obj-$(CONFIG_TI_EMIF_SRAM)	+= ti-emif-sram.o
 obj-$(CONFIG_FPGA_DFL_EMIF)	+= dfl-emif.o
 
diff --git a/drivers/memory/mediatek/Kconfig b/drivers/memory/mediatek/Kconfig
new file mode 100644
index 000000000000..3f238e0d9647
--- /dev/null
+++ b/drivers/memory/mediatek/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config MEDIATEK_MC
+	bool "MediaTek Memory Controller support"
+	help
+	  This option allows to enable MediaTek memory controller drivers,
+	  which may include controllers for DRAM or others.
+	  Select Y here if you need support for MediaTek memory controller.
+	  If you don't need, select N.
+
+if MEDIATEK_MC
+
+config MTK_DRAMC
+	tristate "MediaTek DRAMC driver"
+	default y
+	help
+	  This option selects the MediaTek DRAMC driver, which provides
+	  an interface for reporting the current data rate of DRAM.
+	  Select Y here if you need support for the MediaTek DRAMC driver.
+	  If you don't need, select N.
+
+endif
diff --git a/drivers/memory/mediatek/Makefile b/drivers/memory/mediatek/Makefile
new file mode 100644
index 000000000000..a1395fc55b41
--- /dev/null
+++ b/drivers/memory/mediatek/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MTK_DRAMC)		+= mtk-dramc.o
diff --git a/drivers/memory/mediatek/mtk-dramc.c b/drivers/memory/mediatek/mtk-dramc.c
new file mode 100644
index 000000000000..22042c9d8e42
--- /dev/null
+++ b/drivers/memory/mediatek/mtk-dramc.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ */
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+
+static unsigned int read_reg_field(void __iomem *base, unsigned int offset, unsigned int mask)
+{
+	unsigned int val = readl(base + offset);
+	unsigned int shift = __ffs(mask);
+
+	return (val & mask) >> shift;
+}
+
+struct mtk_dramc_pdata {
+	u8 fmeter_version;
+	u8 ref_freq_mhz;
+	const u16 *regs;
+	const u32 *masks;
+	u32 posdiv_purify;
+	u8 prediv;
+	u16 shuffle_offset;
+};
+
+struct mtk_dramc_dev_t {
+	void __iomem *anaphy_base;
+	void __iomem *ddrphy_base;
+	const struct mtk_dramc_pdata *pdata;
+};
+
+enum mtk_dramc_reg_index {
+	DRAMC_DPHY_DVFS_STA,
+	DRAMC_APHY_SHU_PHYPLL2,
+	DRAMC_APHY_SHU_CLRPLL2,
+	DRAMC_APHY_SHU_PHYPLL3,
+	DRAMC_APHY_SHU_CLRPLL3,
+	DRAMC_APHY_SHU_PHYPLL4,
+	DRAMC_APHY_ARPI0,
+	DRAMC_APHY_CA_ARDLL1,
+	DRAMC_APHY_B0_TX0,
+};
+
+enum mtk_dramc_mask_index {
+	DRAMC_DPHY_DVFS_SHU_LV,
+	DRAMC_DPHY_DVFS_PLL_SEL,
+	DRAMC_APHY_PLL2_SDMPCW,
+	DRAMC_APHY_PLL3_POSDIV,
+	DRAMC_APHY_PLL4_FBKSEL,
+	DRAMC_APHY_ARPI0_SOPEN,
+	DRAMC_APHY_ARDLL1_CK_EN,
+	DRAMC_APHY_B0_TX0_SER_MODE,
+};
+
+static const u16 mtk_dramc_regs_mt8196[] = {
+	[DRAMC_DPHY_DVFS_STA] = 0xe98,
+	[DRAMC_APHY_SHU_PHYPLL2] = 0x908,
+	[DRAMC_APHY_SHU_CLRPLL2] = 0x928,
+	[DRAMC_APHY_SHU_PHYPLL3] = 0x90c,
+	[DRAMC_APHY_SHU_CLRPLL3] = 0x92c,
+	[DRAMC_APHY_SHU_PHYPLL4] = 0x910,
+	[DRAMC_APHY_ARPI0] = 0x0d94,
+	[DRAMC_APHY_CA_ARDLL1] = 0x0d08,
+	[DRAMC_APHY_B0_TX0] = 0x0dc4,
+};
+
+static const u32 mtk_dramc_masks_mt8196[] = {
+	[DRAMC_DPHY_DVFS_SHU_LV] = GENMASK(15, 14),
+	[DRAMC_DPHY_DVFS_PLL_SEL] = GENMASK(25, 25),
+	[DRAMC_APHY_PLL2_SDMPCW] = GENMASK(18, 3),
+	[DRAMC_APHY_PLL3_POSDIV] = GENMASK(13, 11),
+	[DRAMC_APHY_PLL4_FBKSEL] = GENMASK(6, 6),
+	[DRAMC_APHY_ARPI0_SOPEN] = GENMASK(26, 26),
+	[DRAMC_APHY_ARDLL1_CK_EN] = GENMASK(0, 0),
+	[DRAMC_APHY_B0_TX0_SER_MODE] = GENMASK(4, 3),
+};
+
+static int mtk_dramc_probe(struct platform_device *pdev)
+{
+	struct mtk_dramc_dev_t *dramc;
+	const struct mtk_dramc_pdata *pdata;
+
+	dramc = devm_kzalloc(&pdev->dev, sizeof(struct mtk_dramc_dev_t), GFP_KERNEL);
+	if (!dramc)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed to allocate memory\n");
+
+	pdata = of_device_get_match_data(&pdev->dev);
+	if (!pdata)
+		return dev_err_probe(&pdev->dev, -EINVAL, "No platform data available\n");
+
+	dramc->pdata = pdata;
+
+	dramc->anaphy_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dramc->anaphy_base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dramc->anaphy_base),
+				     "Unable to map ANAPHY base\n");
+
+	dramc->ddrphy_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(dramc->ddrphy_base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dramc->ddrphy_base),
+				     "Unable to map DDRPHY base\n");
+
+	platform_set_drvdata(pdev, dramc);
+	return 0;
+}
+
+static unsigned int mtk_fmeter_v1(struct mtk_dramc_dev_t *dramc)
+{
+	const struct mtk_dramc_pdata *pdata = dramc->pdata;
+	unsigned int shu_level, pll_sel, offset;
+	unsigned int sdmpcw, posdiv, clkdiv, fbksel, sopen, async_ca, ser_mode;
+	unsigned int prediv_freq, posdiv_freq, vco_freq;
+	unsigned int final_rate;
+
+	shu_level = read_reg_field(dramc->ddrphy_base, pdata->regs[DRAMC_DPHY_DVFS_STA],
+				   pdata->masks[DRAMC_DPHY_DVFS_SHU_LV]);
+	pll_sel = read_reg_field(dramc->ddrphy_base, pdata->regs[DRAMC_DPHY_DVFS_STA],
+				 pdata->masks[DRAMC_DPHY_DVFS_PLL_SEL]);
+	offset = pdata->shuffle_offset * shu_level;
+
+	sdmpcw = read_reg_field(dramc->anaphy_base,
+				((pll_sel == 0) ?
+				pdata->regs[DRAMC_APHY_SHU_PHYPLL2] :
+				pdata->regs[DRAMC_APHY_SHU_CLRPLL2]) + offset,
+				pdata->masks[DRAMC_APHY_PLL2_SDMPCW]);
+	posdiv = read_reg_field(dramc->anaphy_base,
+				((pll_sel == 0) ?
+				pdata->regs[DRAMC_APHY_SHU_PHYPLL3] :
+				pdata->regs[DRAMC_APHY_SHU_CLRPLL3]) + offset,
+				pdata->masks[DRAMC_APHY_PLL3_POSDIV]);
+	fbksel = read_reg_field(dramc->anaphy_base, pdata->regs[DRAMC_APHY_SHU_PHYPLL4] + offset,
+				pdata->masks[DRAMC_APHY_PLL4_FBKSEL]);
+	sopen = read_reg_field(dramc->anaphy_base, pdata->regs[DRAMC_APHY_ARPI0] + offset,
+			       pdata->masks[DRAMC_APHY_ARPI0_SOPEN]);
+	async_ca = read_reg_field(dramc->anaphy_base, pdata->regs[DRAMC_APHY_CA_ARDLL1] + offset,
+				  pdata->masks[DRAMC_APHY_ARDLL1_CK_EN]);
+	ser_mode = read_reg_field(dramc->anaphy_base, pdata->regs[DRAMC_APHY_B0_TX0] + offset,
+				  pdata->masks[DRAMC_APHY_B0_TX0_SER_MODE]);
+
+	clkdiv = (ser_mode == 1) ? 1 : 0;
+	posdiv &= ~(pdata->posdiv_purify);
+
+	prediv_freq = pdata->ref_freq_mhz * (sdmpcw >> pdata->prediv);
+	posdiv_freq = (prediv_freq >> posdiv) >> 1;
+	vco_freq = posdiv_freq << fbksel;
+	final_rate = vco_freq >> clkdiv;
+
+	if (sopen == 1 && async_ca == 1)
+		final_rate >>= 1;
+
+	return final_rate;
+}
+
+/*
+ * mtk_dramc_get_data_rate - calculate DRAM data rate
+ *
+ * Returns DRAM data rate (MB/s)
+ */
+static unsigned int mtk_dramc_get_data_rate(struct device *dev)
+{
+	struct mtk_dramc_dev_t *dramc_dev = dev_get_drvdata(dev);
+
+	if (!dramc_dev) {
+		dev_err(dev, "DRAMC device data not found\n");
+		return -EINVAL;
+	}
+
+	if (dramc_dev->pdata) {
+		if (dramc_dev->pdata->fmeter_version == 1)
+			return mtk_fmeter_v1(dramc_dev);
+
+		dev_err(dev, "Unsupported fmeter version\n");
+		return -EINVAL;
+	}
+	dev_err(dev, "DRAMC platform data not found\n");
+	return -EINVAL;
+}
+
+static ssize_t dram_data_rate_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "DRAM data rate = %u\n",
+			mtk_dramc_get_data_rate(dev));
+}
+
+static DEVICE_ATTR_RO(dram_data_rate);
+
+static struct attribute *mtk_dramc_attrs[] = {
+	&dev_attr_dram_data_rate.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(mtk_dramc);
+
+static const struct mtk_dramc_pdata dramc_pdata_mt8196 = {
+	.fmeter_version = 1,
+	.ref_freq_mhz = 26,
+	.regs = mtk_dramc_regs_mt8196,
+	.masks = mtk_dramc_masks_mt8196,
+	.posdiv_purify = BIT(2),
+	.prediv = 7,
+	.shuffle_offset = 0x700,
+};
+
+static const struct of_device_id mtk_dramc_of_ids[] = {
+	{ .compatible = "mediatek,mt8196-dramc", .data = &dramc_pdata_mt8196 },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mtk_dramc_of_ids);
+
+static struct platform_driver mtk_dramc_driver = {
+	.probe = mtk_dramc_probe,
+	.driver = {
+		.name = "mtk_dramc_drv",
+		.of_match_table = mtk_dramc_of_ids,
+		.dev_groups = mtk_dramc_groups,
+	},
+};
+
+module_platform_driver(mtk_dramc_driver);
+
+MODULE_AUTHOR("Crystal Guo <crystal.guo@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek DRAM Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.18.0


