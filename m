Return-Path: <linux-kernel+bounces-381682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDCE9B028C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC2E1C20927
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3751632FA;
	Fri, 25 Oct 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nxjmFoVm"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0F231CA8;
	Fri, 25 Oct 2024 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859791; cv=none; b=FPmY0TKVa/4AXkcdSsxkR16tgUKK0QxP2xSVREFA7sckPMoWgG5jo+RFD6F4nyK8DUQr0uEJELWMKZggCS4e5Yn6dUbtYZAY0RbTxG6Gc1C0UjZNYP4ExnhQEPSrMhMa9IMKOJOk5LRsf43gn41Sc/WHXIa9BRmfvQejNqu3ddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859791; c=relaxed/simple;
	bh=MmOnCkl7+7GVHFdZYTd5jM/eoxn/O2m2WNIh0jj8tJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLVDe+3f17kEyz5R995/x2FRRbsS7RTlwquN4PX7f27dD4WdehrheT0nwweY2kOd+Q/SGKzzDCDghkv+9Jr5sB7MJw6tqCaR/hJOrWND/1hnHSU81vzuQXH1RTUK2jPiGGJVtFAUjbRz7mewoT031HLvapohlimQJtWotRz7FqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nxjmFoVm; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1729859788; x=1761395788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MmOnCkl7+7GVHFdZYTd5jM/eoxn/O2m2WNIh0jj8tJY=;
  b=nxjmFoVmajD4lbW5lBOXlXZgpUfmhY6ZrMUrJo7HfG7VWxQwt5/rw1H0
   i0Q8RE0tzpXpNAYrklPW1+Vc6WUnqAsL7hKdLsYyha2MvlnPr7GUHxtSL
   ssumW+5EamkT5ttu1WxSU0DaZZoBnSTq9Sj4/0AKY4W5KCrauOl6AceQk
   XAgC4btI0W9B+Eai2jM0XNCgrS+2ztaTfoTMQV8BiVw2m6qoinAzm5MnJ
   24hRYM8eeuBdwxFQrwEY0wmHTO/Epw5zLrxAyl38GzOACgKskFLrfWtTc
   uCtTqkd1tVkWodT/S2HGHL6mo5Bjy9fY3Yw96ejcdkMpT5SPt2RqVeF3o
   A==;
X-CSE-ConnectionGUID: /fS3tpDQTK6/KTRMJLYOIQ==
X-CSE-MsgGUID: in2nVUa3SsyokwKL1A1taw==
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="200905582"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2024 05:36:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 25 Oct 2024 05:35:53 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 25 Oct 2024 05:35:51 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<peterlin@andestech.com>, <conor.dooley@microchip.com>,
	<conor+dt@kernel.org>, <ycliang@andestech.com>, <dminus@andestech.com>,
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, <jassisinghbrar@gmail.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 3/3] mailbox: add Microchip IPC support
Date: Fri, 25 Oct 2024 13:51:10 +0100
Message-ID: <20241025125110.1347757-4-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025125110.1347757-1-valentina.fernandezalanis@microchip.com>
References: <20241025125110.1347757-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add a mailbox controller driver for the Microchip Inter-processor
Communication (IPC), which is used to send and receive data between
processors.

The driver uses the RISC-V Supervisor Binary Interface (SBI) to
communicate with software running in machine mode (M-mode) to access
the IPC hardware block.

Additional details on the Microchip vendor extension and the IPC
function IDs described in the driver can be found in the following
documentation:

https://github.com/linux4microchip/microchip-sbi-ecall-extension

This SBI interface in this driver is compatible with the Mi-V Inter-hart
Communication (IHC) IP.

Transmitting and receiving data through the mailbox framework is done
through struct mchp_ipc_msg.

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 drivers/mailbox/Kconfig                |  13 +
 drivers/mailbox/Makefile               |   2 +
 drivers/mailbox/mailbox-mchp-ipc-sbi.c | 537 +++++++++++++++++++++++++
 include/linux/mailbox/mchp-ipc.h       |  23 ++
 4 files changed, 575 insertions(+)
 create mode 100644 drivers/mailbox/mailbox-mchp-ipc-sbi.c
 create mode 100644 include/linux/mailbox/mchp-ipc.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 6fb995778636..a61b3b0c5da3 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -177,6 +177,19 @@ config POLARFIRE_SOC_MAILBOX
 
 	  If unsure, say N.
 
+config MCHP_SBI_IPC_MBOX
+	tristate "Microchip Inter-processor Communication (IPC) SBI driver"
+	depends on RISCV_SBI || COMPILE_TEST
+	depends on ARCH_MICROCHIP
+	help
+	  Mailbox implementation for Microchip devices with an
+	  Inter-process communication (IPC) controller.
+
+	  To compile this driver as a module, choose M here. the
+	  module will be called mailbox-mchp-ipc-sbi.
+
+	  If unsure, say N.
+
 config QCOM_APCS_IPC
 	tristate "Qualcomm APCS IPC driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 3c3c27d54c13..a78d1948e331 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -45,6 +45,8 @@ obj-$(CONFIG_BCM_FLEXRM_MBOX)	+= bcm-flexrm-mailbox.o
 
 obj-$(CONFIG_POLARFIRE_SOC_MAILBOX)	+= mailbox-mpfs.o
 
+obj-$(CONFIG_MCHP_SBI_IPC_MBOX)		+= mailbox-mchp-ipc-sbi.o
+
 obj-$(CONFIG_QCOM_APCS_IPC)	+= qcom-apcs-ipc-mailbox.o
 
 obj-$(CONFIG_TEGRA_HSP_MBOX)	+= tegra-hsp.o
diff --git a/drivers/mailbox/mailbox-mchp-ipc-sbi.c b/drivers/mailbox/mailbox-mchp-ipc-sbi.c
new file mode 100644
index 000000000000..2416e0d740e7
--- /dev/null
+++ b/drivers/mailbox/mailbox-mchp-ipc-sbi.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Microchip Inter-Processor communication (IPC) driver
+ *
+ * Copyright (c) 2021 - 2024 Microchip Technology Inc. All rights reserved.
+ *
+ * Author: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/of_device.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/mailbox/mchp-ipc.h>
+#include <asm/sbi.h>
+#include <asm/vendorid_list.h>
+
+#define IRQ_STATUS_BITS			12
+#define NUM_CHANS_PER_CLUSTER		5
+#define IPC_DMA_BIT_MASK		32
+#define SBI_EXT_MICROCHIP_TECHNOLOGY	(SBI_EXT_VENDOR_START | \
+					 MICROCHIP_VENDOR_ID)
+
+enum {
+	SBI_EXT_IPC_PROBE = 0x100,
+	SBI_EXT_IPC_CH_INIT,
+	SBI_EXT_IPC_SEND,
+	SBI_EXT_IPC_RECEIVE,
+	SBI_EXT_IPC_STATUS,
+};
+
+enum ipc_hw {
+	MIV_IHC,
+};
+
+enum ipc_irq_type {
+	IPC_OPS_NOT_SUPPORTED	= 1,
+	IPC_MP_IRQ		= 2,
+	IPC_MC_IRQ		= 4,
+};
+
+/**
+ * struct mchp_ipc_probe - IPC probe message format
+ *
+ * @hw_type:		IPC implementation available in the hardware
+ * @num_channels:	number of IPC channels available in the hardware
+ *
+ * Used to retrieve information on the IPC implementation
+ * using the SBI_EXT_IPC_PROBE SBI function id.
+ */
+struct mchp_ipc_probe {
+	enum ipc_hw hw_type;
+	u8 num_channels;
+};
+
+/**
+ * struct mchp_ipc_init - IPC channel init message format
+ *
+ * @max_msg_size:	maxmimum message size in bytes of a given channel
+ *
+ * struct used by the SBI_EXT_IPC_CH_INIT SBI function id to get
+ * the max message size in bytes of the initialized channel.
+ */
+struct mchp_ipc_init {
+	u16 max_msg_size;
+};
+
+/**
+ * struct mchp_ipc_status - IPC status message format
+ *
+ * @status:	interrupt status for all channels associated to a cluster
+ * @cluster:	specifies the cluster instance that originated an irq
+ *
+ * struct used by the SBI_EXT_IPC_STATUS SBI function id to get
+ * the message present and message clear interrupt status for all the
+ * channels associated to a cluster.
+ */
+struct mchp_ipc_status {
+	u32 status;
+	u8 cluster;
+};
+
+/**
+ * struct mchp_ipc_sbi_msg - IPC SBI payload message
+ *
+ * @buf_addr:	physical address where the received data should be copied to
+ * @size:	maximum size(in bytes) that can be stored in the buffer pointed to by `buf`
+ * @irq_type:	mask representing the irq types that triggered an irq
+ *
+ * struct used by the SBI_EXT_IPC_SEND/SBI_EXT_IPC_RECEIVE SBI function
+ * ids to send/receive a message from an associated processor using
+ * the IPC.
+ */
+struct mchp_ipc_sbi_msg {
+	u64 buf_addr;
+	u16 size;
+	u8 irq_type;
+};
+
+struct mchp_ipc_cluster_cfg {
+	void *buf_base;
+	unsigned long buf_base_addr;
+	int irq;
+};
+
+struct ipc_chan_info {
+	void *buf_base_tx;
+	void *buf_base_rx;
+	void *msg_buf_tx;
+	void *msg_buf_rx;
+	unsigned long buf_base_tx_addr;
+	unsigned long buf_base_rx_addr;
+	unsigned long msg_buf_tx_addr;
+	unsigned long msg_buf_rx_addr;
+	int chan_aggregated_irq;
+	int mp_irq;
+	int mc_irq;
+	u32 id;
+	u32 max_msg_size;
+};
+
+struct microchip_ipc {
+	struct device *dev;
+	struct mbox_chan *chans;
+	struct mchp_ipc_cluster_cfg *cluster_cfg;
+	struct ipc_chan_info *priv;
+	void *buf_base;
+	unsigned long buf_base_addr;
+	struct mbox_controller controller;
+	u8 num_channels;
+	enum ipc_hw hw_type;
+};
+
+static int mchp_ipc_sbi_chan_send(u32 command, u32 channel, unsigned long address)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_MICROCHIP_TECHNOLOGY, command, channel,
+			address, 0, 0, 0, 0);
+
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+	else
+		return ret.value;
+}
+
+static int mchp_ipc_sbi_send(u32 command, unsigned long address)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_MICROCHIP_TECHNOLOGY, command, address,
+			0, 0, 0, 0, 0);
+
+	if (ret.error)
+		return sbi_err_map_linux_errno(ret.error);
+	else
+		return ret.value;
+}
+
+static struct microchip_ipc *to_mchp_ipc_mbox(struct mbox_controller *mbox)
+{
+	return container_of(mbox, struct microchip_ipc, controller);
+}
+
+/**
+ * mchp_ipc_get_chan_id - Retrieve the channel ID from a mailbox channel
+ * @chan: Pointer to the mailbox channel
+ *
+ * This function extracts the channel ID from the given mailbox channel.
+ *
+ * Return: The channel ID as a 32-bit unsigned integer.
+ */
+u32 mchp_ipc_get_chan_id(struct mbox_chan *chan)
+{
+	struct ipc_chan_info *chan_info = (struct ipc_chan_info *)chan->con_priv;
+
+	return chan_info->id;
+}
+EXPORT_SYMBOL_GPL(mchp_ipc_get_chan_id);
+
+static inline void mchp_ipc_prepare_receive_req(struct mbox_chan *chan)
+{
+	struct ipc_chan_info *chan_info = (struct ipc_chan_info *)chan->con_priv;
+	struct mchp_ipc_sbi_msg request;
+
+	request.buf_addr = chan_info->msg_buf_rx_addr;
+	request.size = chan_info->max_msg_size;
+	memcpy(chan_info->buf_base_rx, &request, sizeof(struct mchp_ipc_sbi_msg));
+}
+
+static inline void mchp_ipc_process_received_data(struct mbox_chan *chan,
+						  struct mchp_ipc_msg *ipc_msg)
+{
+	struct ipc_chan_info *chan_info = (struct ipc_chan_info *)chan->con_priv;
+	struct mchp_ipc_sbi_msg sbi_msg;
+
+	memcpy(&sbi_msg, chan_info->buf_base_rx, sizeof(struct mchp_ipc_sbi_msg));
+	ipc_msg->buf = (u32 *)chan_info->msg_buf_rx;
+	ipc_msg->size = sbi_msg.size;
+}
+
+static irqreturn_t mchp_ipc_cluster_aggr_isr(int irq, void *data)
+{
+	struct mbox_chan *chan;
+	struct ipc_chan_info *chan_info;
+	struct microchip_ipc *ipc = (struct microchip_ipc *)data;
+	struct mchp_ipc_msg ipc_msg;
+	struct mchp_ipc_status status_msg;
+	int ret;
+	unsigned long hartid;
+	u32 i, chan_index, chan_id;
+
+	/* Find out the hart that originated the irq */
+	for_each_online_cpu(i) {
+		hartid = cpuid_to_hartid_map(i);
+		if (irq == ipc->cluster_cfg[hartid].irq)
+			break;
+	}
+
+	status_msg.cluster = hartid;
+	memcpy(ipc->cluster_cfg[hartid].buf_base, &status_msg, sizeof(struct mchp_ipc_status));
+
+	ret = mchp_ipc_sbi_send(SBI_EXT_IPC_STATUS, ipc->cluster_cfg[hartid].buf_base_addr);
+	if (ret < 0) {
+		dev_err_ratelimited(ipc->dev, "could not get IHC irq status ret=%d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	memcpy(&status_msg, ipc->cluster_cfg[hartid].buf_base, sizeof(struct mchp_ipc_status));
+
+	/*
+	 * Iterate over each bit set in the IHC interrupt status register (IRQ_STATUS) to identify
+	 * the channel(s) that have a message to be processed/acknowledged.
+	 * The bits are organized in alternating format, where each pair of bits represents
+	 * the status of the message present and message clear interrupts for each cluster/hart
+	 * (from hart 0 to hart 5). Each cluster can have up to 5 fixed channels associated.
+	 */
+
+	for_each_set_bit(i, (unsigned long *)&status_msg.status, IRQ_STATUS_BITS) {
+		/* Find out the destination hart that triggered the interrupt */
+		chan_index = i / 2;
+
+		/*
+		 * The IP has no loopback channels, so we need to decrement the index when
+		 * the target hart has a greater index than our own
+		 */
+		if (chan_index >= status_msg.cluster)
+			chan_index--;
+
+		/*
+		 * Calculate the channel id given the hart and channel index. Channel IDs
+		 * are unique across all clusters of an IPC, and iterate contiguously
+		 * across all clusters.
+		 */
+		chan_id = status_msg.cluster * (NUM_CHANS_PER_CLUSTER + chan_index);
+
+		chan = &ipc->chans[chan_id];
+		chan_info = (struct ipc_chan_info *)chan->con_priv;
+
+		if (i % 2 == 0) {
+			mchp_ipc_prepare_receive_req(chan);
+			ret = mchp_ipc_sbi_chan_send(SBI_EXT_IPC_RECEIVE, chan_id,
+						     chan_info->buf_base_rx_addr);
+			if (ret < 0)
+				continue;
+
+			mchp_ipc_process_received_data(chan, &ipc_msg);
+			mbox_chan_received_data(&ipc->chans[chan_id], (void *)&ipc_msg);
+
+		} else {
+			ret = mchp_ipc_sbi_chan_send(SBI_EXT_IPC_RECEIVE, chan_id,
+						     chan_info->buf_base_rx_addr);
+			mbox_chan_txdone(&ipc->chans[chan_id], ret);
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static int mchp_ipc_send_data(struct mbox_chan *chan, void *data)
+{
+	struct ipc_chan_info *chan_info = (struct ipc_chan_info *)chan->con_priv;
+	const struct mchp_ipc_msg *msg = data;
+	struct mchp_ipc_sbi_msg sbi_payload;
+
+	memcpy(chan_info->msg_buf_tx, msg->buf, msg->size);
+	sbi_payload.buf_addr = chan_info->msg_buf_tx_addr;
+	sbi_payload.size = msg->size;
+	memcpy(chan_info->buf_base_tx, &sbi_payload, sizeof(sbi_payload));
+
+	return mchp_ipc_sbi_chan_send(SBI_EXT_IPC_SEND, chan_info->id, chan_info->buf_base_tx_addr);
+}
+
+static int mchp_ipc_startup(struct mbox_chan *chan)
+{
+	struct ipc_chan_info *chan_info = (struct ipc_chan_info *)chan->con_priv;
+	struct microchip_ipc *ipc = to_mchp_ipc_mbox(chan->mbox);
+	struct mchp_ipc_init ch_init_msg;
+	int ret;
+
+	chan_info->buf_base_tx = kmalloc(sizeof(*chan_info->buf_base_tx), GFP_KERNEL);
+	if (!chan_info->buf_base_tx) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	chan_info->buf_base_tx_addr = __pa(chan_info->buf_base_tx);
+
+	chan_info->buf_base_rx = kmalloc(sizeof(*chan_info->buf_base_rx), GFP_KERNEL);
+	if (!chan_info->buf_base_rx) {
+		ret = -ENOMEM;
+		goto fail_free_buf_base_tx;
+	}
+
+	chan_info->buf_base_rx_addr = __pa(chan_info->buf_base_rx);
+
+	ret = mchp_ipc_sbi_chan_send(SBI_EXT_IPC_CH_INIT, chan_info->id,
+				     chan_info->buf_base_tx_addr);
+	if (ret < 0) {
+		dev_err(ipc->dev, "channel %u init failed\n", chan_info->id);
+		goto fail_free_buf_base_rx;
+	}
+
+	memcpy(&ch_init_msg, chan_info->buf_base_tx, sizeof(struct mchp_ipc_init));
+	chan_info->max_msg_size = ch_init_msg.max_msg_size;
+
+	chan_info->msg_buf_tx = kmalloc(chan_info->max_msg_size, GFP_KERNEL);
+	if (!chan_info->msg_buf_tx) {
+		ret = -ENOMEM;
+		goto fail_free_buf_base_rx;
+	}
+
+	chan_info->msg_buf_tx_addr = __pa(chan_info->msg_buf_tx);
+
+	chan_info->msg_buf_rx = kmalloc(chan_info->max_msg_size, GFP_KERNEL);
+	if (!chan_info->msg_buf_rx) {
+		ret = -ENOMEM;
+		goto fail_free_buf_msg_tx;
+	}
+
+	chan_info->msg_buf_rx_addr = __pa(chan_info->msg_buf_rx);
+
+	switch (ipc->hw_type) {
+	case MIV_IHC:
+		return 0;
+	default:
+		goto fail_free_buf_msg_rx;
+	}
+
+	if (ret) {
+		dev_err(ipc->dev, "failed to register interrupt(s)\n");
+		goto fail_free_buf_msg_rx;
+	}
+
+	return ret;
+
+fail_free_buf_msg_rx:
+	kfree(chan_info->msg_buf_rx);
+fail_free_buf_msg_tx:
+	kfree(chan_info->msg_buf_tx);
+fail_free_buf_base_rx:
+	kfree(chan_info->buf_base_rx);
+fail_free_buf_base_tx:
+	kfree(chan_info->buf_base_tx);
+fail:
+	return ret;
+}
+
+static void mchp_ipc_shutdown(struct mbox_chan *chan)
+{
+	struct ipc_chan_info *chan_info = (struct ipc_chan_info *)chan->con_priv;
+
+	kfree(chan_info->buf_base_tx);
+	kfree(chan_info->buf_base_rx);
+	kfree(chan_info->msg_buf_tx);
+	kfree(chan_info->msg_buf_rx);
+}
+
+static const struct mbox_chan_ops mchp_ipc_ops = {
+	.startup = mchp_ipc_startup,
+	.send_data = mchp_ipc_send_data,
+	.shutdown = mchp_ipc_shutdown,
+};
+
+static struct mbox_chan *mchp_ipc_mbox_xlate(struct mbox_controller *controller,
+					     const struct of_phandle_args *spec)
+{
+	struct microchip_ipc *ipc = to_mchp_ipc_mbox(controller);
+	unsigned int chan_id = spec->args[0];
+
+	if (chan_id >= ipc->num_channels) {
+		dev_err(ipc->dev, "invalid channel id %d\n", chan_id);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &ipc->chans[chan_id];
+}
+
+static int mchp_ipc_get_cluster_aggr_irq(struct microchip_ipc *ipc)
+{
+	struct platform_device *pdev = to_platform_device(ipc->dev);
+	char *irq_name;
+	int cpuid, ret;
+	unsigned long hartid;
+	bool irq_found = false;
+
+	for_each_online_cpu(cpuid) {
+		hartid = cpuid_to_hartid_map(cpuid);
+		irq_name = devm_kasprintf(ipc->dev, GFP_KERNEL, "hart-%lu", hartid);
+		ret = platform_get_irq_byname_optional(pdev, irq_name);
+		if (ret <= 0)
+			continue;
+
+		ipc->cluster_cfg[hartid].irq = ret;
+		ret = devm_request_irq(ipc->dev, ipc->cluster_cfg[hartid].irq,
+				       mchp_ipc_cluster_aggr_isr, IRQF_SHARED,
+				       "miv-ihc-irq", ipc);
+		if (ret)
+			return ret;
+
+		ipc->cluster_cfg[hartid].buf_base = devm_kmalloc(ipc->dev,
+								 sizeof(struct mchp_ipc_status),
+								 GFP_KERNEL);
+
+		if (!ipc->cluster_cfg[hartid].buf_base)
+			return -ENOMEM;
+
+		ipc->cluster_cfg[hartid].buf_base_addr = __pa(ipc->cluster_cfg[hartid].buf_base);
+
+		irq_found = true;
+	}
+
+	return irq_found;
+}
+
+static int mchp_ipc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mchp_ipc_probe ipc_info;
+	struct microchip_ipc *ipc;
+	struct ipc_chan_info *priv;
+	bool irq_avail = false;
+	int ret;
+	u32 chan_id;
+
+	ret = sbi_probe_extension(SBI_EXT_MICROCHIP_TECHNOLOGY);
+	if (ret <= 0)
+		return dev_err_probe(dev, ret, "Microchip SBI extension not detected\n");
+
+	ipc = devm_kzalloc(dev, sizeof(*ipc), GFP_KERNEL);
+	if (!ipc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ipc);
+
+	ipc->buf_base = devm_kmalloc(dev, sizeof(struct mchp_ipc_probe), GFP_KERNEL);
+	if (!ipc->buf_base)
+		return -ENOMEM;
+
+	ipc->buf_base_addr = __pa(ipc->buf_base);
+
+	ret = mchp_ipc_sbi_send(SBI_EXT_IPC_PROBE, ipc->buf_base_addr);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "could not probe IPC SBI service\n");
+
+	memcpy(&ipc_info, ipc->buf_base, sizeof(struct mchp_ipc_probe));
+	ipc->num_channels = ipc_info.num_channels;
+	ipc->hw_type = ipc_info.hw_type;
+
+	ipc->chans = devm_kcalloc(dev, ipc->num_channels, sizeof(*ipc->chans), GFP_KERNEL);
+	if (!ipc->chans)
+		return -ENOMEM;
+
+	ipc->dev = dev;
+	ipc->controller.txdone_irq = true;
+	ipc->controller.dev = ipc->dev;
+	ipc->controller.ops = &mchp_ipc_ops;
+	ipc->controller.chans = ipc->chans;
+	ipc->controller.num_chans = ipc->num_channels;
+	ipc->controller.of_xlate = mchp_ipc_mbox_xlate;
+
+	for (chan_id = 0; chan_id < ipc->num_channels; chan_id++) {
+		priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
+		if (!priv)
+			return -ENOMEM;
+
+		ipc->chans[chan_id].con_priv = priv;
+		priv->id = chan_id;
+	}
+
+	if (ipc->hw_type == MIV_IHC) {
+		ipc->cluster_cfg = devm_kcalloc(dev, num_online_cpus(),
+						sizeof(struct mchp_ipc_cluster_cfg),
+						GFP_KERNEL);
+		if (!ipc->cluster_cfg)
+			return -ENOMEM;
+
+		if (mchp_ipc_get_cluster_aggr_irq(ipc))
+			irq_avail = true;
+	}
+
+	if (!irq_avail)
+		return dev_err_probe(dev, -ENODEV, "missing interrupt property\n");
+
+	ret = devm_mbox_controller_register(dev, &ipc->controller);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				    "Inter-Processor communication (IPC) registration failed\n");
+
+	return 0;
+}
+
+static const struct of_device_id mchp_ipc_of_match[] = {
+	{.compatible = "microchip,sbi-ipc", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mchp_ipc_of_match);
+
+static struct platform_driver mchp_ipc_driver = {
+	.driver = {
+		.name = "microchip_ipc",
+		.of_match_table = mchp_ipc_of_match,
+	},
+	.probe = mchp_ipc_probe,
+};
+
+module_platform_driver(mchp_ipc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Valentina Fernandez <valentina.fernandezalanis@microchip.com>");
+MODULE_DESCRIPTION("Microchip Inter-Processor Communication (IPC) driver");
diff --git a/include/linux/mailbox/mchp-ipc.h b/include/linux/mailbox/mchp-ipc.h
new file mode 100644
index 000000000000..69352bcb1402
--- /dev/null
+++ b/include/linux/mailbox/mchp-ipc.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *Copyright (c) 2024 Microchip Technology Inc. All rights reserved.
+ */
+
+#ifndef _LINUX_MCHP_IPC_H_
+#define _LINUX_MCHP_IPC_H_
+
+#include <linux/mailbox_controller.h>
+#include <linux/types.h>
+
+struct mchp_ipc_msg {
+	u32 *buf;
+	u16 size;
+};
+
+#if IS_ENABLED(CONFIG_MCHP_SBI_IPC_MBOX)
+u32 mchp_ipc_get_chan_id(struct mbox_chan *chan);
+#else
+u32 mchp_ipc_get_chan_id(struct mbox_chan *chan) { return 0; }
+#endif
+
+#endif /* _LINUX_MCHP_IPC_H_ */
-- 
2.34.1


