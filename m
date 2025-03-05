Return-Path: <linux-kernel+bounces-546273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B4EA4F89F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754063A16E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B71FC119;
	Wed,  5 Mar 2025 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uqbtiRlh"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6E1F419A;
	Wed,  5 Mar 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162862; cv=none; b=TCaaZA7ub4VWGbFkn6/cTo+2Q580S//JT4ejF/G7zx6vhb6t8JSR5TutULN8HyS0Zj/od0Msm07IZv4wwN6Ua9YNXFMZZo4DS/KaqMNcceW3XG+FyMqaIn04w9vI7rdMJVI8z9Y3iacZ5mlKIvklj7MW5mFJkYyZuDcynHECGHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162862; c=relaxed/simple;
	bh=stnMJykr8CsGdm4rH9EfY5R8rxlj95A3FNICHynjab8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTgCf3mLIkgM0zq7YW5ZevSNVtf2wEVo8/NLy9rmEkt32iQfcIX2YLtDUWUPAhPQkXmA1Ne3S3cyJOVWv+YUjmWumGPw/M9QotmPaBP5YeRwPMqJQ07Nomqt0TKnQP1jxrxqrNm2DXdPUAzDJBkxh9F/fepOr8cXTNYwFVBIdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uqbtiRlh; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c13f4cbef99a11ef8eb9c36241bbb6fb-20250305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=InaeS8/UkU8eLyrlVZZUnJa6Ghra5rWqfYuQwgP38JU=;
	b=uqbtiRlha3/mspW7E3V4bmvKL7LxQ8mQlrESBKYu9kwxiKWZ/PKyEbDtbwYSwASCr8RFXvK7KdApGC/eW4vO3Z4nSYWAuAr0dP1v+/mOwjJJB3Y5PGbz9s+GkAeHXHSsSTGmAnvXyzylthRb0I1+qBPoyMsyHID4Q4NgNRNgQVs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:e07c6623-3531-4324-ba85-709338ae9a74,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:43610bce-23b9-4c94-add0-e827a7999e28,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c13f4cbef99a11ef8eb9c36241bbb6fb-20250305
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2039444796; Wed, 05 Mar 2025 16:20:53 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 5 Mar 2025 16:20:51 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 5 Mar 2025 16:20:51 +0800
From: Jjian Zhou <jjian.zhou@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-ch Chen
	<jason-ch.chen@mediatek.com>, Jjian Zhou <jjian.zhou@mediatek.com>
Subject: [PATCH RFC 1/3] mailbox: mediatek: Add mtk-vcp-mailbox driver
Date: Wed, 5 Mar 2025 16:20:38 +0800
Message-ID: <20250305082047.15746-2-jjian.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250305082047.15746-1-jjian.zhou@mediatek.com>
References: <20250305082047.15746-1-jjian.zhou@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add mtk-vcp-mailbox driver to support the communication with
VCP remote microprocessor.

Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
---
 drivers/mailbox/Kconfig                 |   9 ++
 drivers/mailbox/Makefile                |   2 +
 drivers/mailbox/mtk-vcp-mailbox.c       | 179 ++++++++++++++++++++++++
 include/linux/mailbox/mtk-vcp-mailbox.h |  34 +++++
 4 files changed, 224 insertions(+)
 create mode 100644 drivers/mailbox/mtk-vcp-mailbox.c
 create mode 100644 include/linux/mailbox/mtk-vcp-mailbox.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index ed52db272f4d..ffc4a5491462 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -275,6 +275,15 @@ config MTK_CMDQ_MBOX
 	  critical time limitation, such as updating display configuration
 	  during the vblank.

+config MTK_VCP_MBOX
+	tristate "MediaTek VCP Mailbox Support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  Say yes here to add support for the MediaTek VCP mailbox driver.
+	  The mailbox implementation provides access from the application
+	  processor to the MediaTek Video Processing Unit.
+	  If unsure say N.
+
 config ZYNQMP_IPI_MBOX
 	tristate "Xilinx ZynqMP IPI Mailbox"
 	depends on ARCH_ZYNQMP && OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 9a1542b55539..75a200a9d2d2 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -59,6 +59,8 @@ obj-$(CONFIG_MTK_ADSP_MBOX)	+= mtk-adsp-mailbox.o

 obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o

+obj-$(CONFIG_MTK_VCP_MBOX)	+= mtk-vcp-mailbox.o
+
 obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o

 obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
diff --git a/drivers/mailbox/mtk-vcp-mailbox.c b/drivers/mailbox/mtk-vcp-mailbox.c
new file mode 100644
index 000000000000..fd7a123c71c8
--- /dev/null
+++ b/drivers/mailbox/mtk-vcp-mailbox.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Corporation. All rights reserved.
+ * Author: Jjian Zhou <jjian.zhou.@mediatek.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/mtk-vcp-mailbox.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct mtk_vcp_mbox_priv {
+	void __iomem *base;
+	struct device *dev;
+	struct mbox_controller mbox;
+	const struct mtk_vcp_mbox_cfg *cfg;
+	struct mtk_ipi_info ipi_recv;
+};
+
+struct mtk_vcp_mbox_cfg {
+	u32 set_in;
+	u32 clr_out;
+};
+
+static inline struct mtk_vcp_mbox_priv *get_mtk_vcp_mbox_priv(struct mbox_controller *mbox)
+{
+	return container_of(mbox, struct mtk_vcp_mbox_priv, mbox);
+}
+
+static irqreturn_t mtk_vcp_mbox_irq_thread(int irq, void *data)
+{
+	struct mbox_chan *chan = data;
+	struct mtk_vcp_mbox_priv *priv = get_mtk_vcp_mbox_priv(chan->mbox);
+
+	/* get irq status */
+	priv->ipi_recv.irq_status = readl(priv->base + priv->cfg->clr_out);
+
+	__ioread32_copy(priv->ipi_recv.msg, priv->base, MAX_SLOT_NUM);
+
+	mbox_chan_received_data(chan, &priv->ipi_recv);
+
+	/* clear irq status */
+	writel(priv->ipi_recv.irq_status, priv->base + priv->cfg->clr_out);
+
+	return IRQ_HANDLED;
+}
+
+static struct mbox_chan *mtk_vcp_mbox_xlate(struct mbox_controller *mbox,
+					    const struct of_phandle_args *sp)
+{
+	if (sp->args_count)
+		return NULL;
+
+	return mbox->chans;
+}
+
+static int mtk_vcp_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct mtk_vcp_mbox_priv *priv = get_mtk_vcp_mbox_priv(chan->mbox);
+	struct mtk_ipi_info *ipi_info = data;
+	u32 status;
+
+	if (!ipi_info->msg) {
+		dev_err(priv->dev, "msg buffer is NULL.\n");
+		return -ENOMEM;
+	}
+
+	status = readl(priv->base + priv->cfg->set_in) & BIT(ipi_info->index);
+	if (status) {
+		dev_err(priv->dev, "mailbox IPI %d is busy.\n", ipi_info->id);
+		return -EBUSY;
+	}
+
+	if (ipi_info->slot_ofs + ipi_info->len > MBOX_SLOT_MAX_SIZE)
+		return -EINVAL;
+	__iowrite32_copy(priv->base + ipi_info->slot_ofs, ipi_info->msg,
+			 ipi_info->len);
+
+	writel(BIT(ipi_info->index), priv->base + priv->cfg->set_in);
+
+	return 0;
+}
+
+static bool mtk_vcp_mbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct mtk_ipi_info *ipi_info = chan->active_req;
+	struct mtk_vcp_mbox_priv *priv = get_mtk_vcp_mbox_priv(chan->mbox);
+	u32 op;
+
+	op = readl(priv->base + priv->cfg->set_in) & BIT(ipi_info->index);
+	return !op;
+}
+
+static const struct mbox_chan_ops mtk_vcp_mbox_chan_ops = {
+	.send_data	= mtk_vcp_mbox_send_data,
+	.last_tx_done	= mtk_vcp_mbox_last_tx_done,
+};
+
+static int mtk_vcp_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_vcp_mbox_priv *priv;
+	struct mbox_controller *mbox;
+	int ret, irq;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	mbox = &priv->mbox;
+	mbox->dev = dev;
+	mbox->ops = &mtk_vcp_mbox_chan_ops;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = true;
+	mbox->of_xlate = mtk_vcp_mbox_xlate;
+	mbox->num_chans = 1;
+	mbox->chans = devm_kzalloc(dev, sizeof(*mbox->chans), GFP_KERNEL);
+	if (!mbox->chans)
+		return -ENOMEM;
+
+	priv->ipi_recv.msg = devm_kzalloc(dev, sizeof(u8) * MBOX_SLOT_MAX_SIZE,
+					  GFP_KERNEL);
+	if (!priv->ipi_recv.msg)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->cfg = of_device_get_match_data(dev);
+	if (!priv->cfg)
+		return -EINVAL;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+					mtk_vcp_mbox_irq_thread, IRQF_ONESHOT,
+					dev_name(dev), mbox->chans);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, priv);
+
+	dev_dbg(dev, "MTK VCP mailbox initialized\n");
+
+	return devm_mbox_controller_register(dev, &priv->mbox);
+}
+
+static const struct mtk_vcp_mbox_cfg mt8196_cfg = {
+	.set_in		= 0x100,
+	.clr_out	= 0x10C,
+};
+
+static const struct of_device_id mtk_vcp_mbox_of_match[] = {
+	{ .compatible = "mediatek,mt8196-vcp-mbox", .data = &mt8196_cfg },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_vcp_mbox_of_match);
+
+static struct platform_driver mtk_vcp_mbox_driver = {
+	.probe		= mtk_vcp_mbox_probe,
+	.driver = {
+		.name	= "mtk_vcp_mbox",
+		.of_match_table = mtk_vcp_mbox_of_match,
+	},
+};
+module_platform_driver(mtk_vcp_mbox_driver);
+
+MODULE_AUTHOR("Jjian Zhou <jjian.zhou@mediatek.com>");
+MODULE_DESCRIPTION("MTK VCP Mailbox Controller");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mailbox/mtk-vcp-mailbox.h b/include/linux/mailbox/mtk-vcp-mailbox.h
new file mode 100644
index 000000000000..953499b7cfeb
--- /dev/null
+++ b/include/linux/mailbox/mtk-vcp-mailbox.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#ifndef __MTK_VCP_MAILBOX_H__
+#define __MTK_VCP_MAILBOX_H__
+
+#define MBOX_SLOT_MAX_SIZE	0x100 /* mbox max slot size */
+#define MAX_SLOT_NUM	64
+
+/**
+ * struct mtk_ipi_info - channel table that belong to mtk_ipi_device
+ * @msg: The share buffer between IPC and mailbox driver
+ * @len: Message length
+ * @id: IPI number
+ * @recv_opt: Recv option,  0:receive ,1: response
+ * @index: The pin groups number of the mailbox channel
+ * @slot_ofs: Slot offset of the mailbox channel
+ * @irq_status: Indicate which pin groups triggered the interrupt
+ *
+ * It is used between IPC with mailbox driver.
+ */
+struct mtk_ipi_info {
+	void *msg;
+	u32 len;
+	u32 id;
+	u32 recv_opt;
+	u32 index;
+	u32 slot_ofs;
+	u32 irq_status;
+};
+
+#endif
--
2.45.2


