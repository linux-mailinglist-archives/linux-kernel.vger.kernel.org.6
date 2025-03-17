Return-Path: <linux-kernel+bounces-563998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAD5A64BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B193A889B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FFD23A56B;
	Mon, 17 Mar 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QPF8oICe"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48DC23816F;
	Mon, 17 Mar 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209428; cv=none; b=OhSPu6Q/+sxI4bpidp0chtPyTGP1daf2tUNFDM84p1kI+W49ZwMg7EWcx1EHzYSaIBqArfW4eQjR3KkySp+IBPTHojqYshtODS4XpkbNv4ytoPhm2pRg7YF9tvpFyXJcfyHrIzM+lZVPq0d0Isf/vohd6tBGtCBL56+mBErPbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209428; c=relaxed/simple;
	bh=HEpc7JIvk72vctzHAfJT3CPmFQXnw7VrjOURa7esXFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyvDzvllnrdEhDqcBabxP6l4mrOuXasD3PRzfcmSTNch6lMW9gHt4VL4VQ3R+EkS5o22P+aCJGu3TllRKyr9Z8WoCH1kg15QhB87cfEzKpTBZc8HxyG109hze7EDr7GaZV9/irFbpruSyp5MWY7XeIZIos7rGSU4Y+xqkB8/qIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QPF8oICe; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7a4673a8031f11f0aae1fd9735fae912-20250317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eVHnTPYD1NqFriz6eCLRMpMNlPKKVwGPxqrltINJC1o=;
	b=QPF8oICeDWcM+vCIN4NcXl9Wx6VKf2tOhlPR4xEWxG8YssZJsh5V4pYtm5IzonowY5RVloC2cVSbihJG/7YbRVqq60IjVx+8lQOG5d1zV9oLYXXV+6oAXC6Sq8rLJjpXT9R+C7vG6RWJChAvY6JVr5b7vIoNxX5AVxX29sWMqcY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:8c551dc5-ce1a-4786-9388-7bd197856c36,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:5c8c798c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7a4673a8031f11f0aae1fd9735fae912-20250317
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1981424841; Mon, 17 Mar 2025 19:03:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 17 Mar 2025 19:03:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 17 Mar 2025 19:03:36 +0800
From: Jjian Zhou <jjian.zhou@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>, Jjian Zhou <jjian.zhou@mediatek.com>
Subject: [PATCH RFC v3 2/3] firmware: mediatek: Add vcp ipc protocol interface
Date: Mon, 17 Mar 2025 19:03:24 +0800
Message-ID: <20250317110331.2776-3-jjian.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250317110331.2776-1-jjian.zhou@mediatek.com>
References: <20250317110331.2776-1-jjian.zhou@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Some of mediatek processors contain the Risc-V coprocessor.

The communication between Host CPU and vcp firmware is
taking place using a shared memory area for message passing.

VCP IPC protocol offers (send/recv) interfaces using
mediatek-mailbox APIs.

Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
---
 drivers/firmware/Kconfig                      |   9 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/mtk-vcp-ipc.c                | 481 ++++++++++++++++++
 include/linux/firmware/mediatek/mtk-vcp-ipc.h | 151 ++++++
 4 files changed, 642 insertions(+)
 create mode 100644 drivers/firmware/mtk-vcp-ipc.c
 create mode 100644 include/linux/firmware/mediatek/mtk-vcp-ipc.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 37e43f287e78..98c4ff667836 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -179,6 +179,15 @@ config MTK_ADSP_IPC
 	  ADSP exists on some mtk processors.
 	  Client might use shared memory to exchange information with ADSP.
 
+config MTK_VCP_IPC
+	tristate "MTK VCP IPC Protocol driver"
+	depends on MTK_VCP_MBOX
+	help
+	  Say yes here to add support for the MediaTek VCP IPC
+	  between host AP (Linux) and the firmware running on VCP.
+	  VCP exists on some mtk processors.
+	  Client might use shared memory to exchange information with VCP.
+
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 91efcc868a05..2b9894e5169a 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ISCSI_IBFT_FIND)	+= iscsi_ibft_find.o
 obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
 obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
 obj-$(CONFIG_MTK_ADSP_IPC)	+= mtk-adsp-ipc.o
+obj-$(CONFIG_MTK_VCP_IPC)	+= mtk-vcp-ipc.o
 obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
diff --git a/drivers/firmware/mtk-vcp-ipc.c b/drivers/firmware/mtk-vcp-ipc.c
new file mode 100644
index 000000000000..744937c56b67
--- /dev/null
+++ b/drivers/firmware/mtk-vcp-ipc.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/firmware/mediatek/mtk-vcp-ipc.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/sched/clock.h>
+#include <linux/time64.h>
+#include <linux/vmalloc.h>
+
+/**
+ * struct mtk_ipi_chan_table - channel table that belong to mtk_ipi_device
+ * @mbox: the mbox channel number
+ * @mbox_pin_cb: callback function
+ * @holder: keep 1 if there are ipi waiters (to wait the reply)
+ * @ipi_record: timestamp of each ipi transmission stage
+ * @pin_buf: buffer point
+ * @prdata: private data
+ * @recv_opt: recv option,  0:receive ,1: response
+ * @notify: completion notify process
+ * @send_ofs: message offset in the slots of a mbox
+ * @send_index: bit offset in the mbox
+ * @msg_zie: slot size of the ipi message
+ *
+ * All of these data should be initialized by mtk_ipi_device_register()
+ */
+struct mtk_ipi_chan_table {
+	u32 mbox;
+	mbox_pin_cb_t mbox_pin_cb;
+	atomic_t holder;
+	void *pin_buf;
+	void *prdata;
+	u32 recv_opt;
+	struct completion notify;
+	/* define a mutex for remote response */
+	struct mutex mutex_send;
+	u32 send_ofs;
+	u32 send_index;
+	u32 msg_size;
+};
+
+/**
+ * mbox information
+ *
+ * @mbdev: mbox device
+ * @mbox_id: mbox id
+ * @slot: how many slots that mbox used
+ * @opt: option for tx mode, 0:mbox, 1:share memory 2:queue
+ * @base: mbox base address
+ * @mbox_client: mbox client
+ * @mbox_chan: mbox channel
+ */
+struct mtk_mbox_info {
+	struct mtk_vcp_ipc *vcp_ipc;
+	u32 mbox_id;
+	u32 slot;
+	u32 opt;
+	/* lock of mbox */
+	spinlock_t mbox_lock;
+	struct mbox_client cl;
+	struct mbox_chan *ch;
+	struct mtk_ipi_info ipi_info;
+};
+
+static const char * const mbox_names[VCP_MBOX_NUM] = {
+	"mbox0", "mbox1", "mbox2", "mbox3", "mbox4"
+};
+
+/**
+ * mtk_vcp_ipc_recv - recv callback used by MTK VCP mailbox
+ *
+ * @c: mbox client
+ * @msg: message received
+ *
+ * Users of VCP IPC will need to provide handle_reply and handle_request
+ * callbacks.
+ */
+static void mtk_vcp_ipc_recv(struct mbox_client *c, void *msg)
+{
+	struct mtk_mbox_info *minfo = container_of(c, struct mtk_mbox_info, cl);
+	struct mtk_vcp_ipc *vcp_ipc = minfo->vcp_ipc;
+	struct mtk_ipi_info *ipi_info = msg;
+	struct mtk_ipi_device *ipidev = vcp_ipc->ipi_priv;
+	struct mtk_ipi_chan_table *table;
+	struct mtk_mbox_recv_table *mbox_recv;
+	u32 id;
+
+	/* execute all receive pin handler */
+	for (id = 0; id < vcp_ipc->mbdev->recv_count; id++) {
+		mbox_recv = &vcp_ipc->mbdev->recv_table[id];
+		if (mbox_recv->mbox_id != minfo->mbox_id)
+			continue;
+
+		if (!(BIT(mbox_recv->pin_index) & ipi_info->irq_status))
+			continue;
+
+		table = &ipidev->table[mbox_recv->ipi_id];
+		if (!table->pin_buf) {
+			dev_err(vcp_ipc->dev, "IPI%d buf is null.\n",
+				mbox_recv->ipi_id);
+			continue;
+		}
+
+		memcpy(table->pin_buf,
+		       ipi_info->msg + mbox_recv->offset * MBOX_SLOT_SIZE,
+		       mbox_recv->msg_size * MBOX_SLOT_SIZE);
+
+		if (!mbox_recv->recv_opt && table->mbox_pin_cb)
+			table->mbox_pin_cb(mbox_recv->ipi_id,
+					   table->prdata,
+					   table->pin_buf,
+					   mbox_recv->msg_size * MBOX_SLOT_SIZE);
+
+		/* notify task */
+		if (table->recv_opt == MBOX_RECV_MESSAGE ||
+		    atomic_read(&table->holder))
+			complete(&table->notify);
+	}
+}
+
+/*
+ * mtk_vcp_ipc_send - send ipc command to MTK VCP
+ *
+ * @ipidev: VCP struct mtk_ipi_device handle
+ * @id: id of the feature IPI
+ * @data: message address
+ * @len: message length
+ *
+ * Return: Zero for success from mbox_send_message
+ *         negative value for error
+ */
+int mtk_vcp_ipc_send(struct mtk_ipi_device *ipidev, u32 id, void *data, u32 len)
+{
+	struct device *dev;
+	struct mtk_mbox_info *minfo;
+	struct mtk_ipi_chan_table *table;
+	struct mtk_vcp_ipc *vcp_ipc;
+	int ret;
+
+	if (!ipidev || !ipidev->ipi_inited || !data)
+		return IPI_UNAVAILABLE;
+	vcp_ipc = ipidev->vcp_ipc;
+	if (!vcp_ipc)
+		return IPI_UNAVAILABLE;
+
+	table = ipidev->table;
+	dev = ipidev->vcp_ipc->dev;
+	minfo = &ipidev->vcp_ipc->info_table[table[id].mbox];
+	if (!minfo) {
+		dev_err(dev, "%s IPI%d minfo is invalid.\n", ipidev->name, id);
+		return IPI_UNAVAILABLE;
+	}
+
+	if (len > table[id].msg_size)
+		return IPI_MSG_TOO_BIG;
+	else if (!len)
+		len = table[id].msg_size;
+
+	mutex_lock(&table[id].mutex_send);
+
+	minfo->ipi_info.msg = data;
+	minfo->ipi_info.len = len;
+	minfo->ipi_info.id = id;
+	minfo->ipi_info.index = table[id].send_index;
+	minfo->ipi_info.slot_ofs = table[id].send_ofs * MBOX_SLOT_SIZE;
+
+	ret = mbox_send_message(minfo->ch, &minfo->ipi_info);
+	mutex_unlock(&table[id].mutex_send);
+	if (ret < 0) {
+		dev_err(dev, "%s IPI%d send failed.\n", ipidev->name, id);
+		return IPI_MBOX_ERR;
+	}
+
+	return IPI_ACTION_DONE;
+}
+EXPORT_SYMBOL(mtk_vcp_ipc_send);
+
+/*
+ * mtk_vcp_ipc_send_compl - send ipc command to MTK VCP
+ *
+ * @ipidev: VCP struct mtk_ipi_device handle
+ * @id: id of the feature IPI
+ * @data: message address
+ * @len: message length
+ * @timeout_ms:
+ *
+ * Return: Zero for success from mbox_send_message
+ *         negative value for error
+ */
+int mtk_vcp_ipc_send_compl(struct mtk_ipi_device *ipidev, u32 id,
+			   void *data, u32 len, u32 timeout_ms)
+{
+	struct device *dev;
+	struct mtk_mbox_info *minfo;
+	struct mtk_ipi_chan_table *table;
+	struct mtk_vcp_ipc *vcp_ipc;
+	int ret;
+
+	if (!ipidev || !ipidev->ipi_inited || !data)
+		return IPI_UNAVAILABLE;
+	vcp_ipc = ipidev->vcp_ipc;
+	if (!vcp_ipc)
+		return IPI_UNAVAILABLE;
+
+	table = ipidev->table;
+	dev = ipidev->vcp_ipc->dev;
+	minfo = &ipidev->vcp_ipc->info_table[table[id].mbox];
+	if (!minfo) {
+		dev_err(dev, "%s IPI%d minfo is invalid.\n", ipidev->name, id);
+		return IPI_UNAVAILABLE;
+	}
+
+	if (len > table[id].msg_size)
+		return IPI_MSG_TOO_BIG;
+	else if (!len)
+		len = table[id].msg_size;
+
+	mutex_lock(&table[id].mutex_send);
+
+	minfo->ipi_info.msg = data;
+	minfo->ipi_info.len = len;
+	minfo->ipi_info.id = id;
+	minfo->ipi_info.index = table[id].send_index;
+	minfo->ipi_info.slot_ofs = table[id].send_ofs * MBOX_SLOT_SIZE;
+
+	atomic_inc(&table[id].holder);
+
+	ret = mbox_send_message(minfo->ch, &minfo->ipi_info);
+	if (ret < 0) {
+		atomic_set(&table[id].holder, 0);
+		mutex_unlock(&table[id].mutex_send);
+		dev_err(dev, "%s IPI%d send failed.\n", ipidev->name, id);
+		return IPI_MBOX_ERR;
+	}
+
+	/* wait for completion */
+	ret = wait_for_completion_timeout(&table[id].notify,
+					  msecs_to_jiffies(timeout_ms));
+	atomic_set(&table[id].holder, 0);
+	if (ret > 0)
+		ret = IPI_ACTION_DONE;
+
+	mutex_unlock(&table[id].mutex_send);
+
+	return ret;
+}
+EXPORT_SYMBOL(mtk_vcp_ipc_send_compl);
+
+int mtk_vcp_mbox_ipc_register(struct mtk_ipi_device *ipidev, int id,
+			      mbox_pin_cb_t cb, void *prdata, void *msg)
+{
+	if (!ipidev || !ipidev->ipi_inited)
+		return IPI_DEV_ILLEGAL;
+	if (!msg)
+		return IPI_NO_MSGBUF;
+
+	if (ipidev->table[id].pin_buf)
+		return IPI_ALREADY_USED;
+	ipidev->table[id].mbox_pin_cb = cb;
+	ipidev->table[id].pin_buf = msg;
+	ipidev->table[id].prdata = prdata;
+
+	return IPI_ACTION_DONE;
+}
+EXPORT_SYMBOL(mtk_vcp_mbox_ipc_register);
+
+int mtk_vcp_mbox_ipc_unregister(struct mtk_ipi_device *ipidev, int id)
+{
+	if (!ipidev || !ipidev->ipi_inited)
+		return IPI_DEV_ILLEGAL;
+
+	/* Drop the ipi and reset the record */
+	complete(&ipidev->table[id].notify);
+
+	ipidev->table[id].mbox_pin_cb = NULL;
+	ipidev->table[id].pin_buf = NULL;
+	ipidev->table[id].prdata = NULL;
+
+	return IPI_ACTION_DONE;
+}
+EXPORT_SYMBOL(mtk_vcp_mbox_ipc_unregister);
+
+static void mtk_fill_in_entry(struct mtk_ipi_chan_table *entry, const u32 ipi_id,
+			      const struct mtk_mbox_table *mbdev)
+{
+	const struct mtk_mbox_send_table *mbox_send = mbdev->send_table;
+	u32 index;
+
+	for (index = 0; index < mbdev->send_count; index++) {
+		if (ipi_id != mbox_send[index].ipi_id)
+			continue;
+
+		entry->send_ofs = mbox_send[index].offset;
+		entry->send_index = mbox_send[index].pin_index;
+		entry->msg_size = mbox_send[index].msg_size;
+		entry->mbox = mbox_send[index].mbox_id;
+		return;
+	}
+
+	entry->mbox = -ENOENT;
+}
+
+int mtk_vcp_ipc_device_register(struct mtk_ipi_device *ipidev,
+				u32 ipi_chan_count, struct mtk_vcp_ipc *vcp_ipc)
+{
+	struct mtk_ipi_chan_table *ipi_chan_table;
+	struct mtk_mbox_table *mbdev;
+	u32 index;
+
+	if (!vcp_ipc || !ipidev)
+		return -EINVAL;
+
+	ipi_chan_table = kcalloc(ipi_chan_count,
+				 sizeof(struct mtk_ipi_chan_table), GFP_KERNEL);
+	if (!ipi_chan_table)
+		return -ENOMEM;
+
+	mbdev = vcp_ipc->mbdev;
+	vcp_ipc->ipi_priv = (void *)ipidev;
+	ipidev->table = ipi_chan_table;
+	ipidev->vcp_ipc = vcp_ipc;
+
+	for (index = 0; index < ipi_chan_count; index++) {
+		atomic_set(&ipi_chan_table[index].holder, 0);
+		mutex_init(&ipi_chan_table[index].mutex_send);
+		init_completion(&ipi_chan_table[index].notify);
+		mtk_fill_in_entry(&ipi_chan_table[index], index, mbdev);
+	}
+
+	ipidev->ipi_inited = 1;
+
+	dev_dbg(vcp_ipc->dev, "%s (with %d IPI) has registered.\n",
+		ipidev->name, ipi_chan_count);
+
+	return IPI_ACTION_DONE;
+}
+EXPORT_SYMBOL(mtk_vcp_ipc_device_register);
+
+static int setup_mbox_table(struct mtk_mbox_table *mbdev, u32 mbox)
+{
+	struct mtk_mbox_send_table *mbox_send = &mbdev->send_table[0];
+	struct mtk_mbox_recv_table *mbox_recv = &mbdev->recv_table[0];
+	u32 i, last_ofs = 0, last_idx = 0, last_slot = 0, last_sz = 0;
+
+	for (i = 0; i < mbdev->send_count; i++) {
+		if (mbox == mbox_send[i].mbox_id) {
+			mbox_send[i].offset = last_ofs + last_slot;
+			mbox_send[i].pin_index = last_idx + last_sz;
+			last_idx = mbox_send[i].pin_index;
+			last_sz = DIV_ROUND_UP(mbox_send[i].msg_size, MBOX_SLOT_ALIGN);
+			last_ofs = last_sz * MBOX_SLOT_ALIGN;
+			last_slot = last_idx * MBOX_SLOT_ALIGN;
+		} else if (mbox < mbox_send[i].mbox_id) {
+			/* no need to search the rest id */
+			break;
+		}
+	}
+
+	for (i = 0; i < mbdev->recv_count; i++) {
+		if (mbox == mbox_recv[i].mbox_id) {
+			mbox_recv[i].offset = last_ofs + last_slot;
+			mbox_recv[i].pin_index = last_idx + last_sz;
+			last_idx = mbox_recv[i].pin_index;
+			last_sz = DIV_ROUND_UP(mbox_recv[i].msg_size, MBOX_SLOT_ALIGN);
+			last_ofs = last_sz * MBOX_SLOT_ALIGN;
+			last_slot = last_idx * MBOX_SLOT_ALIGN;
+		} else if (mbox < mbox_recv[i].mbox_id) {
+			/* no need to search the rest id */
+			break;
+		}
+	}
+
+	if (last_idx > MBOX_MAX_PIN || (last_ofs + last_slot) > MAX_SLOT_NUM)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int mtk_vcp_ipc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_vcp_ipc *vcp_ipc;
+	struct mbox_client *cl;
+	struct mtk_mbox_info *minfo;
+	int ret;
+	u32 mbox, i;
+	struct mtk_mbox_table *mbox_data = dev_get_platdata(dev);
+
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
+
+	vcp_ipc = devm_kzalloc(dev, sizeof(*vcp_ipc), GFP_KERNEL);
+	if (!vcp_ipc)
+		return -ENOMEM;
+
+	if (!mbox_data) {
+		dev_err(dev, "No platform data available\n");
+		return -EINVAL;
+	}
+	vcp_ipc->mbdev = mbox_data;
+
+	/* alloc and init mmup_mbox_info */
+	vcp_ipc->info_table = vzalloc(sizeof(*vcp_ipc->info_table) * VCP_MBOX_NUM);
+	if (!vcp_ipc->info_table)
+		return -ENOMEM;
+
+	/* create mbox dev */
+	for (mbox = 0; mbox < VCP_MBOX_NUM; mbox++) {
+		minfo = &vcp_ipc->info_table[mbox];
+		minfo->mbox_id = mbox;
+		minfo->vcp_ipc = vcp_ipc;
+		spin_lock_init(&minfo->mbox_lock);
+
+		ret = setup_mbox_table(vcp_ipc->mbdev, mbox);
+		if (ret)
+			return ret;
+
+		cl = &minfo->cl;
+		cl->dev = &pdev->dev;
+		cl->tx_block = false;
+		cl->knows_txdone = false;
+		cl->tx_prepare = NULL;
+		cl->rx_callback = mtk_vcp_ipc_recv;
+		minfo->ch = mbox_request_channel_byname(cl, mbox_names[mbox]);
+		if (IS_ERR(minfo->ch)) {
+			ret = PTR_ERR(minfo->ch);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to request mbox channel %s ret %d\n",
+					mbox_names[mbox], ret);
+
+			for (i = 0; i < mbox; i++) {
+				minfo = &vcp_ipc->info_table[i];
+				mbox_free_channel(minfo->ch);
+			}
+
+			vfree(vcp_ipc->info_table);
+			return ret;
+		}
+	}
+
+	vcp_ipc->dev = dev;
+	dev_set_drvdata(dev, vcp_ipc);
+	dev_dbg(dev, "MTK VCP IPC initialized\n");
+
+	return 0;
+}
+
+static void mtk_vcp_ipc_remove(struct platform_device *pdev)
+{
+	struct mtk_vcp_ipc *vcp_ipc = dev_get_drvdata(&pdev->dev);
+	struct mtk_mbox_info *minfo;
+	int i;
+
+	for (i = 0; i < VCP_MBOX_NUM; i++) {
+		minfo = &vcp_ipc->info_table[i];
+		mbox_free_channel(minfo->ch);
+	}
+
+	vfree(vcp_ipc->info_table);
+}
+
+static struct platform_driver mtk_vcp_ipc_driver = {
+	.probe = mtk_vcp_ipc_probe,
+	.remove = mtk_vcp_ipc_remove,
+	.driver = {
+		.name = "mtk-vcp-ipc",
+	},
+};
+builtin_platform_driver(mtk_vcp_ipc_driver);
+
+MODULE_AUTHOR("Jjian Zhou <jjian.zhou@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek VCP IPC Controller");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/firmware/mediatek/mtk-vcp-ipc.h b/include/linux/firmware/mediatek/mtk-vcp-ipc.h
new file mode 100644
index 000000000000..dc34b0ba9dd8
--- /dev/null
+++ b/include/linux/firmware/mediatek/mtk-vcp-ipc.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#ifndef __MTK_VCP_IPC_H__
+#define __MTK_VCP_IPC_H__
+
+#include <linux/completion.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox/mtk-vcp-mailbox.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+/* IPI result definition */
+#define IPI_ACTION_DONE	  0
+#define IPI_DEV_ILLEGAL	 -1 /* ipi device is not initialized */
+#define IPI_ALREADY_USED	 -2 /* the ipi has be registered */
+#define IPI_UNAVAILABLE	 -3 /* the ipi can't be found */
+#define IPI_NO_MSGBUF		 -4 /* receiver doesn't have message buffer */
+#define IPI_MSG_TOO_BIG		 -5 /* message length is larger than defined */
+#define IPI_MBOX_ERR		-99 /* some error from rpmsg layer */
+
+/* mbox recv action definition */
+enum mtk_ipi_recv_opt {
+	MBOX_RECV_MESSAGE  = 0,
+	MBOX_RECV_ACK      = 1,
+};
+
+/* mbox table item number definition */
+#define send_item_num	3
+#define recv_item_num	4
+#define VCP_MBOX_NUM	5
+
+/* mbox slot size definition: 1 slot for 4 bytes */
+#define MBOX_SLOT_SIZE	0x4
+#define MBOX_MAX_PIN	32
+#define VCP_MBOX_NUM	5
+#define MBOX_SLOT_ALIGN	2
+
+struct mtk_vcp_ipc;
+struct mtk_ipi_chan_table;
+
+typedef int (*mbox_pin_cb_t)(u32 ipi_id, void *prdata, void *data, u32 len);
+
+/**
+ * mbox pin structure, this is for send definition,
+ * @offset: message offset in the slots of a mbox
+ * @msg_size: message used slots in the mbox, 4 bytes alignment
+ * @pin_index: bit offset in the mbox
+ * @ipi_id: ipi enum number
+ * @mbox_id: mbox number id
+ */
+struct mtk_mbox_send_table {
+	u32 offset;
+	u32 msg_size;
+	u32 pin_index;
+	u32 ipi_id;
+	u32 mbox_id;
+};
+
+/**
+ * mbox pin structure, this is for receive definition,
+ * @offset: message offset in the slots of a mbox
+ * @recv_opt: recv option,  0:receive ,1: response
+ * @msg_size: message used slots in the mbox, 4 bytes alignment
+ * @pin_index: bit offset in the mbox
+ * @ipi_id: ipi enum number
+ * @mbox_id: mbox number id
+ */
+struct mtk_mbox_recv_table {
+	u32 offset;
+	u32 recv_opt;
+	u32 msg_size;
+	u32 pin_index;
+	u32 ipi_id;
+	u32 mbox_id;
+};
+
+/**
+ * struct mtk_ipi_device - device for represent the tinysys using mtk ipi
+ * @name: name of tinysys device
+ * @id: device id (used to match between rpmsg drivers and devices)
+ * @vcp_ipc: vcp ipc structure for tinysys device
+ * @table: channel table with endpoint & channel_info & mbox_pin info
+ * @prdata: private data for the callback use
+ * @ipi_inited: set when vcp_ipi_device_register() done
+ */
+struct mtk_ipi_device  {
+	const char *name;
+	struct mtk_vcp_ipc *vcp_ipc;
+	struct mtk_ipi_chan_table *table;
+	void *prdata;
+	int ipi_inited;
+};
+
+/**
+ * The mtk_mbox_table is a structure used to record the send
+ * table and recv table. The send table is used to record
+ * the feature ID and size of the sent data. The recv table
+ * is used to record the feature ID and size of the received
+ * data, and whether a callback needs to be invoked.
+ *
+ * Following are platform specific interfacer
+ * @recv_table: structure mtk_mbox_recv_table
+ * @send_table: structure mtk_mbox_send_table
+ * @recv_count: receive feature number in this channel
+ * @send_count: send feature number in this channel
+ */
+struct mtk_mbox_table {
+	struct mtk_mbox_recv_table recv_table[32];
+	struct mtk_mbox_send_table send_table[32];
+	u32 recv_count;
+	u32 send_count;
+};
+
+/**
+ * Mbox is a dedicate hardware of a tinysys consists of:
+ * 1) a share memory tightly coupled to the tinysys
+ * 2) several IRQs
+ *
+ * Following are platform specific interface
+ * @dev: vcp device
+ * @name: identity of the device
+ * @info_table: mbox info structure
+ * @ipi_priv: private data for synchronization layer
+ * @mbox_id: mbox number
+ * @mbdev: mtk_mbox_table structure
+ */
+struct mtk_vcp_ipc {
+	struct device *dev;
+	const char *name;
+	struct mtk_mbox_info *info_table;
+	void *ipi_priv;
+	void *mbox_id;
+	struct mtk_mbox_table *mbdev;
+};
+
+int mtk_vcp_ipc_device_register(struct mtk_ipi_device *ipidev,
+				u32 ipi_chan_count,
+				struct mtk_vcp_ipc *vcp_ipc);
+int mtk_vcp_ipc_send(struct mtk_ipi_device *ipidev, u32 ipi_id,
+		     void *data, u32 len);
+int mtk_vcp_ipc_send_compl(struct mtk_ipi_device *ipidev, u32 ipi_id,
+			   void *data, u32 len, u32 timeout_ms);
+int mtk_vcp_mbox_ipc_register(struct mtk_ipi_device *ipidev, int ipi_id,
+			      mbox_pin_cb_t cb, void *prdata, void *msg);
+int mtk_vcp_mbox_ipc_unregister(struct mtk_ipi_device *ipidev, int ipi_id);
+
+#endif
-- 
2.45.2


