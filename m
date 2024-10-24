Return-Path: <linux-kernel+bounces-379582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92E9AE0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D772852AE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9687C1BD012;
	Thu, 24 Oct 2024 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="S1kKsfzP"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E98C1AA7B6;
	Thu, 24 Oct 2024 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762018; cv=none; b=WF0A1wDavc3ImUgeeeBcoHhUjdnv1HCcYXaZltJdMWpifV2IPmCTFbMsxF2KRlFGVb/nDtpqEOj63lACcTv42erAEA105jbs4XOoczr1Svm8zasSEalyszVqWd5l6ax8gmDy60INOGnh2SuvXREBsqO9SdnMznXSdiTGY4RvXj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762018; c=relaxed/simple;
	bh=HncH2HOFlO5DQapGUnH4UPjCAjmb2uP6z2r3J+n+nls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sBhdhFijuM95Q3a3sgfA3mEIDTSYuIlem979v/k63pNxfngRnZOJ6gcW5SD5m/zNCRd0STUN3C2DegUZaYXOOQAwaTlZyZxQ+joE7yXgE7/u9kGurtXgvxmL1C/tsYRoWMvblqoIiljJ5hzvpM1oS2V7ZkwuED3MILfPOY2vcoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=S1kKsfzP; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1948a94691ea11efbd192953cf12861f-20241024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jYLMF+xuWoTGHcH9ioamHRWs7pVJoNmieRacljrkDBI=;
	b=S1kKsfzPV4SMDDCjHtAKPvaGnPatn91PyW101KSkPMqg7/1cYS6zYsXYcFw/6tThIfygzCEW16FpZVwsuL37gCgSirZvU6qGs0oDR5Pkqis30rlxfc2yB5zpbMJZMl5KvG9P8N1rOgom6wg/TwjL7xrY+6ehwsLMNVwRUGqCjPY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:c40c0bc9-62c7-4b47-9170-6ace436ac41f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:1f6a0b2e-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1948a94691ea11efbd192953cf12861f-20241024
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <karl.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1948286850; Thu, 24 Oct 2024 17:26:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 24 Oct 2024 17:26:49 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 24 Oct 2024 17:26:49 +0800
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
Subject: [PATCH 2/3] mailbox: add support for bottom half received data
Date: Thu, 24 Oct 2024 17:25:44 +0800
Message-ID: <20241024092608.431581-3-karl.li@mediatek.com>
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

From: Karl Li <karl.li@mediatek.com>

Within the MediaTek APU subsystem, a message passing mechanism
is constructed on top of the mailbox system.

The mailbox only has limited space for each message. The MTK APU firmware
expects the message header from the mailbox, while the message body
is passed through some fixed shared memory.

The mailbox interrupt also serves as a mutex for the shared memory.
Thus the interrupt may only be cleared after the message is handled.
Add a new sleepable rx callback for mailbox clients for cases
where handling the incoming data needs to sleep.

Signed-off-by: Karl Li <karl.li@mediatek.com>
---
 drivers/mailbox/mailbox.c          | 16 ++++++++++++++++
 include/linux/mailbox_client.h     |  2 ++
 include/linux/mailbox_controller.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index d3d26a2c9895..d58a77fcf804 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -164,6 +164,22 @@ void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
 }
 EXPORT_SYMBOL_GPL(mbox_chan_received_data);
 
+/**
+ * mbox_chan_received_data_bh - A way for controller driver to push data
+ *				received from remote to the upper layer.
+ * @chan: Pointer to the mailbox channel on which RX happened.
+ * @mssg: Client specific message typecasted as void *
+ *
+ * For the operations which is not atomic can be called from
+ * mbox_chan_received_data_bh().
+ */
+void mbox_chan_received_data_bh(struct mbox_chan *chan, void *mssg)
+{
+	if (chan->cl->rx_callback_bh)
+		chan->cl->rx_callback_bh(chan->cl, mssg);
+}
+EXPORT_SYMBOL_GPL(mbox_chan_received_data_bh);
+
 /**
  * mbox_chan_txdone - A way for controller driver to notify the
  *			framework that the last TX has completed.
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 734694912ef7..2cc6fa4e1bf9 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -22,6 +22,7 @@ struct mbox_chan;
  *			if the client receives some ACK packet for transmission.
  *			Unused if the controller already has TX_Done/RTR IRQ.
  * @rx_callback:	Atomic callback to provide client the data received
+ * @rx_callback_bh:	Non-atomic callback to provide client the data received
  * @tx_prepare: 	Atomic callback to ask client to prepare the payload
  *			before initiating the transmission if required.
  * @tx_done:		Atomic callback to tell client of data transmission
@@ -33,6 +34,7 @@ struct mbox_client {
 	bool knows_txdone;
 
 	void (*rx_callback)(struct mbox_client *cl, void *mssg);
+	void (*rx_callback_bh)(struct mbox_client *cl, void *mssg);
 	void (*tx_prepare)(struct mbox_client *cl, void *mssg);
 	void (*tx_done)(struct mbox_client *cl, void *mssg, int r);
 };
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 6fee33cb52f5..74c6a31cd313 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -130,6 +130,7 @@ struct mbox_chan {
 int mbox_controller_register(struct mbox_controller *mbox); /* can sleep */
 void mbox_controller_unregister(struct mbox_controller *mbox); /* can sleep */
 void mbox_chan_received_data(struct mbox_chan *chan, void *data); /* atomic */
+void mbox_chan_received_data_bh(struct mbox_chan *chan, void *data); /* can sleep */
 void mbox_chan_txdone(struct mbox_chan *chan, int r); /* atomic */
 
 int devm_mbox_controller_register(struct device *dev,
-- 
2.18.0


