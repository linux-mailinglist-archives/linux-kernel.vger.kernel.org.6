Return-Path: <linux-kernel+bounces-379583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 197DB9AE0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE021C23CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E95D1D4341;
	Thu, 24 Oct 2024 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DZmgxdaz"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775FD1B3924;
	Thu, 24 Oct 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762020; cv=none; b=kzkmo5b9dGlU5lc7v1CEuP6cta0V4zq8ghNwXKdnEa0p1nzWuUqZCkfZMCMNn7dnFgPAH0RKSPJqWFUqqNgmQ83Sjq8Pw4X5R6Rcp3OWod2DZe1j/JZhC3BY3aFasTPFuKdBB/+X9o5usPB+FW/ne1//qbRVhbyAFFlBPrDQ99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762020; c=relaxed/simple;
	bh=Glev8zOQj4Z4pXPTbkLCvSvCTQpIQpK31YT6/RRlgXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIvpWpThfUhzI21w8ZrZMs9uDlQqdH8yG8whoqC0EY8mDQ3S+aap/y6lGaqPHDez2d6dWPZ35UdvnSftzokdkxlyDQTNwha/jVBocvdCEC9iM6cGPTjGATtWfVt6czv7BCSMKqX/KOxszvCIDZ0IMXBQAYBPeCljEf32+Ukz7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DZmgxdaz; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 19f2504091ea11efbd192953cf12861f-20241024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/023G7mDKUOrTtonKh4QV10AQzKB2Tag8vWepYfhObU=;
	b=DZmgxdazQy+WgpGDs771gDf2n4o4BdftAwJL0hYtDzmKnrBZbqwMUdGYJAFNQLzQ1j6IA7MCsTktZzzRXypisAG+L2MGD1mkc5U0uGexw4k13TY94fQcS6/IkN296GYUrHlLHMkwiPAl/4tqJBaMVAK2VB/rsWZZhBge30ERGBg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:8e74b272-f5cd-457b-b878-bc3afee1fca2,IP:0,U
	RL:0,TC:0,Content:40,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:40
X-CID-META: VersionHash:b0fcdc3,CLOUDID:622dcccc-110e-4f79-849e-58237df93e70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 19f2504091ea11efbd192953cf12861f-20241024
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <karl.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1075449677; Thu, 24 Oct 2024 17:26:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 24 Oct 2024 17:26:50 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 24 Oct 2024 17:26:50 +0800
From: Karl.Li <karl.li@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Karl Li <Karl.Li@mediatek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Chungying Lu <chungying.lu@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Karl Li
	<karl.li@mediatek.com>
Subject: [PATCH 3/3] mailbox: mediatek: Add mtk-apu-mailbox driver
Date: Thu, 24 Oct 2024 17:25:45 +0800
Message-ID: <20241024092608.431581-4-karl.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024092608.431581-1-karl.li@mediatek.com>
References: <20241024092608.431581-1-karl.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--8.620800-8.000000
X-TMASE-MatchedRID: 4kHyKE737jM9S3IiQd+eNWgZSmduwyweUAjrAJWsTe8It7KhKWdvFOJ1
	Z55wDcxT8AyWk2NFMNZM8qdoCvOVvj13WcdbGR6Qzbh2+gTKAQ+AfODDLypXmvFJXtgF4GFL0JL
	YEuZmPHUC470HKuzgB1rcv8nBrrT3BrU1duOq6zS3D7EeeyZCMwrefVId6fzVjnLTb30f4043dV
	Tnu0EmWDqE8reTKDts781jTNgzH3VZT98H9cWYnJMSBMTQNiSAKSiQ6eagz6JX14Hy+eYp7+YI8
	JecFTbdRw3fpQHgw3sGYQd6rNaIOSJFbDWAdpZLHPYwOJi6PLmXYX34rFl3x2d6vNuG6CqySAKU
	IhfaB7A0RbGKWWKZ/3Qe11JD81nVu9okb5cOFzbKl4yJoI+fG9O4VcbrqWuq8EAby1w1DMl576m
	y5IxjulD3U31Zcw/LhxHjE30dAnsfE8yM4pjsDwtuKBGekqUpOlxBO2IcOBaIHGa67w1D28oh7y
	qmhyfdMbuKPPB0sroSZzN3LFJ282uTKbq4kNjO
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.620800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0BF7B7E278F88FE729E9F1441FC5995BADA4A3936A1666D1E2EF3D5FE850B0772000:8

From: Karl Li <karl.li@mediatek.com>

Add mtk-apu-mailbox driver to support the communication with
APU remote microprocessor.

Also, the mailbox hardware contains extra spare (scratch) registers
that other hardware blocks use to communicate through.
Expose these with custom mtk_apu_mbox_(read|write)() functions.

Signed-off-by: Karl Li <karl.li@mediatek.com>
---
 drivers/mailbox/Kconfig                 |   9 +
 drivers/mailbox/Makefile                |   2 +
 drivers/mailbox/mtk-apu-mailbox.c       | 222 ++++++++++++++++++++++++
 include/linux/mailbox/mtk-apu-mailbox.h |  20 +++
 4 files changed, 253 insertions(+)
 create mode 100644 drivers/mailbox/mtk-apu-mailbox.c
 create mode 100644 include/linux/mailbox/mtk-apu-mailbox.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 6fb995778636..2338e08a110a 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -240,6 +240,15 @@ config MTK_ADSP_MBOX
           between processors with ADSP. It will place the message to share
 	  buffer and will access the ipc control.
 
+config MTK_APU_MBOX
+	tristate "MediaTek APU Mailbox Support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  Say yes here to add support for the MediaTek APU Mailbox
+	  driver. The mailbox implementation provides access from the
+	  application processor to the MediaTek AI Processing Unit.
+	  If unsure say N.
+
 config MTK_CMDQ_MBOX
 	tristate "MediaTek CMDQ Mailbox Support"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 3c3c27d54c13..6b6dcc78d644 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -53,6 +53,8 @@ obj-$(CONFIG_STM32_IPCC) 	+= stm32-ipcc.o
 
 obj-$(CONFIG_MTK_ADSP_MBOX)	+= mtk-adsp-mailbox.o
 
+obj-$(CONFIG_MTK_APU_MBOX)	+= mtk-apu-mailbox.o
+
 obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
 
 obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
diff --git a/drivers/mailbox/mtk-apu-mailbox.c b/drivers/mailbox/mtk-apu-mailbox.c
new file mode 100644
index 000000000000..b347ebd34ef7
--- /dev/null
+++ b/drivers/mailbox/mtk-apu-mailbox.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#include <asm/io.h>
+#include <linux/bits.h>
+#include <linux/interrupt.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/mtk-apu-mailbox.h>
+#include <linux/platform_device.h>
+
+#define INBOX		(0x0)
+#define OUTBOX		(0x20)
+#define INBOX_IRQ	(0xc0)
+#define OUTBOX_IRQ	(0xc4)
+#define INBOX_IRQ_MASK	(0xd0)
+
+#define SPARE_OFF_START	(0x40)
+#define SPARE_OFF_END	(0xB0)
+
+struct mtk_apu_mailbox {
+	struct device *dev;
+	void __iomem *regs;
+	struct mbox_controller controller;
+	u32 msgs[MSG_MBOX_SLOTS];
+};
+
+struct mtk_apu_mailbox *g_mbox;
+
+static irqreturn_t mtk_apu_mailbox_irq_top_half(int irq, void *dev_id)
+{
+	struct mtk_apu_mailbox *mbox = dev_id;
+	struct mbox_chan *link = &mbox->controller.chans[0];
+	int i;
+
+	for (i = 0; i < MSG_MBOX_SLOTS; i++)
+		mbox->msgs[i] = readl(mbox->regs + OUTBOX + i * sizeof(u32));
+
+	mbox_chan_received_data(link, &mbox->msgs);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t mtk_apu_mailbox_irq_btm_half(int irq, void *dev_id)
+{
+	struct mtk_apu_mailbox *mbox = dev_id;
+	struct mbox_chan *link = &mbox->controller.chans[0];
+
+	mbox_chan_received_data_bh(link, &mbox->msgs);
+	writel(readl(mbox->regs + OUTBOX_IRQ), mbox->regs + OUTBOX_IRQ);
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_apu_mailbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct mtk_apu_mailbox *mbox = container_of(chan->mbox,
+						    struct mtk_apu_mailbox,
+						    controller);
+	struct mtk_apu_mailbox_msg *msg = data;
+	int i;
+
+	if (msg->send_cnt <= 0 || msg->send_cnt > MSG_MBOX_SLOTS) {
+		dev_err(mbox->dev, "%s: invalid send_cnt %d\n", __func__, msg->send_cnt);
+		return -EINVAL;
+	}
+
+	/*
+	 *	Mask lowest "send_cnt-1" interrupts bits, so the interrupt on the other side
+	 *	triggers only after the last data slot is written (sent).
+	 */
+	writel(GENMASK(msg->send_cnt - 2, 0), mbox->regs + INBOX_IRQ_MASK);
+	for (i = 0; i < msg->send_cnt; i++)
+		writel(msg->data[i], mbox->regs + INBOX + i * sizeof(u32));
+
+	return 0;
+}
+
+static bool mtk_apu_mailbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct mtk_apu_mailbox *mbox = container_of(chan->mbox,
+						    struct mtk_apu_mailbox,
+						    controller);
+
+	return readl(mbox->regs + INBOX_IRQ) == 0;
+}
+
+static const struct mbox_chan_ops mtk_apu_mailbox_ops = {
+	.send_data = mtk_apu_mailbox_send_data,
+	.last_tx_done = mtk_apu_mailbox_last_tx_done,
+};
+
+/**
+ * mtk_apu_mbox_write - Write value to specifice mtk_apu_mbox spare register.
+ * @val: Value to be written.
+ * @offset: Offset of the spare register.
+ *
+ * Return: 0 if successful
+ *	   negative value if error happened
+ */
+int mtk_apu_mbox_write(u32 val, u32 offset)
+{
+	if (!g_mbox) {
+		pr_err("mtk apu mbox was not initialized, stop writing register\n");
+		return -ENODEV;
+	}
+
+	if (offset < SPARE_OFF_START || offset >= SPARE_OFF_END) {
+		dev_err(g_mbox->dev, "Invalid offset %d for mtk apu mbox spare register\n", offset);
+		return -EINVAL;
+	}
+
+	writel(val, g_mbox->regs + offset);
+	return 0;
+}
+EXPORT_SYMBOL_NS(mtk_apu_mbox_write, MTK_APU_MAILBOX);
+
+/**
+ * mtk_apu_mbox_read - Read value to specifice mtk_apu_mbox spare register.
+ * @offset: Offset of the spare register.
+ * @val: Pointer to store read value.
+ *
+ * Return: 0 if successful
+ *	   negative value if error happened
+ */
+int mtk_apu_mbox_read(u32 offset, u32 *val)
+{
+	if (!g_mbox) {
+		pr_err("mtk apu mbox was not initialized, stop reading register\n");
+		return -ENODEV;
+	}
+
+	if (offset < SPARE_OFF_START || offset >= SPARE_OFF_END) {
+		dev_err(g_mbox->dev, "Invalid offset %d for mtk apu mbox spare register\n", offset);
+		return -EINVAL;
+	}
+
+	*val = readl(g_mbox->regs + offset);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS(mtk_apu_mbox_read, MTK_APU_MAILBOX);
+
+static int mtk_apu_mailbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_apu_mailbox *mbox;
+	int irq = -1, ret = 0;
+
+	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
+	if (!mbox)
+		return -ENOMEM;
+
+	mbox->dev = dev;
+	platform_set_drvdata(pdev, mbox);
+
+	mbox->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mbox->regs))
+		return PTR_ERR(mbox->regs);
+
+	mbox->controller.txdone_irq = false;
+	mbox->controller.txdone_poll = true;
+	mbox->controller.txpoll_period = 1;
+	mbox->controller.ops = &mtk_apu_mailbox_ops;
+	mbox->controller.dev = dev;
+	/*
+	 * Here we only register 1 mbox channel.
+	 * The remaining channels are used by other modules.
+	 */
+	mbox->controller.num_chans = 1;
+	mbox->controller.chans = devm_kcalloc(dev, mbox->controller.num_chans,
+					      sizeof(*mbox->controller.chans),
+					      GFP_KERNEL);
+	if (!mbox->controller.chans)
+		return -ENOMEM;
+
+	ret = devm_mbox_controller_register(dev, &mbox->controller);
+	if (ret)
+		return ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, mtk_apu_mailbox_irq_top_half,
+					mtk_apu_mailbox_irq_btm_half, IRQF_ONESHOT,
+					dev_name(dev), mbox);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
+
+	g_mbox = mbox;
+
+	dev_dbg(dev, "registered mtk apu mailbox\n");
+
+	return 0;
+}
+
+static void mtk_apu_mailbox_remove(struct platform_device *pdev)
+{
+	g_mbox = NULL;
+}
+
+static const struct of_device_id mtk_apu_mailbox_of_match[] = {
+	{ .compatible = "mediatek,mt8188-apu-mailbox" },
+	{ .compatible = "mediatek,mt8196-apu-mailbox" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mtk_apu_mailbox_of_match);
+
+static struct platform_driver mtk_apu_mailbox_driver = {
+	.probe = mtk_apu_mailbox_probe,
+	.remove = mtk_apu_mailbox_remove,
+	.driver = {
+		.name = "mtk-apu-mailbox",
+		.of_match_table = mtk_apu_mailbox_of_match,
+	},
+};
+
+module_platform_driver(mtk_apu_mailbox_driver);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MediaTek APU Mailbox Driver");
diff --git a/include/linux/mailbox/mtk-apu-mailbox.h b/include/linux/mailbox/mtk-apu-mailbox.h
new file mode 100644
index 000000000000..d1457d16ce9b
--- /dev/null
+++ b/include/linux/mailbox/mtk-apu-mailbox.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ *
+ */
+
+#ifndef __MTK_APU_MAILBOX_H__
+#define __MTK_APU_MAILBOX_H__
+
+#define MSG_MBOX_SLOTS	(8)
+
+struct mtk_apu_mailbox_msg {
+	int send_cnt;
+	u32 data[MSG_MBOX_SLOTS];
+};
+
+int mtk_apu_mbox_write(u32 val, u32 offset);
+int mtk_apu_mbox_read(u32 offset, u32 *val);
+
+#endif /* __MTK_APU_MAILBOX_H__ */
-- 
2.18.0


