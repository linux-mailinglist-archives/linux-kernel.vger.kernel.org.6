Return-Path: <linux-kernel+bounces-204195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17058FE5AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555E91F27196
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E494619597C;
	Thu,  6 Jun 2024 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RgbthJy/"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8281E52A;
	Thu,  6 Jun 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674216; cv=none; b=DbekwN90UNXAQN9xg6HGamlLTEjcaqlrDpMXmfYlJWF34D9Qye5pQYyfp271/nTYuR4F812YFRNL2kslN7YEMrPG3YJnmthZG3IQ4JzgDn/6EAQI1ORDqGdzZIRc4pTHX2ewQOpTC4Ti7d6+5xJoqePuVwQ/M/PrqYxWbFFHIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674216; c=relaxed/simple;
	bh=mEozOdyq3JhE4NZ9GAdH3wSUhRyds+L/Hs1E9DZ0gv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbR5sOSF3703bkaN0wrS+e4Zr7vcBLnsRb+CAvondZZgTh+0n2MFqXuO2wBI5gm8hxkCEYoQZ4fzYNP4zIhC+12N20I/52tQB1pLxpW1dkeWwZkHWvHWoaLN5e5tjrRMZpdj1df0baVznXNVQWuAJGvgRAnawcWNNeyPmInddRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RgbthJy/; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fd09aa4023f911efa54bbfbb386b949c-20240606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LKjKCz6MWko6tQGKhAEekON+68KMgjRQz4EtM95IYls=;
	b=RgbthJy/nW5FOn4xqiMRzLTBUw+EERs6rpYKRRroiHGvd9TH/Y/2wDp0RCOyzmpGKtnNbIpAl5pTBJ7zQz9vxnJUhoWPNes+Tg98sNme1pddDWY7QhfNp4kYq0oictJGZQKSITlMzaSzAv1e1Jkouswkd2d74V5jezlXuoYgTP8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:4f714a76-c35c-4e6e-934d-cb04a03f92b2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:0efd4a88-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: fd09aa4023f911efa54bbfbb386b949c-20240606
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 511123124; Thu, 06 Jun 2024 19:43:27 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jun 2024 19:43:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jun 2024 19:43:25 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v4 3/4] Bluetooth: btmtk: add macro to get/set/clear MediaTek defined flags
Date: Thu, 6 Jun 2024 19:43:20 +0800
Message-ID: <20240606114321.30515-4-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240606114321.30515-1-chris.lu@mediatek.com>
References: <20240606114321.30515-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Define a enumeration to store MediaTek specific flags and
macro function to set/test/clear the flags in data structure.

Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtk.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index e76b8a358be8..6a0697a22b16 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -128,6 +128,10 @@ struct btmtk_hci_wmt_params {
 
 typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
 
+enum {
+	__BTMTK_NUM_FLAGS,
+};
+
 struct btmtk_coredump_info {
 	const char *driver_name;
 	u32 fw_version;
@@ -136,11 +140,30 @@ struct btmtk_coredump_info {
 };
 
 struct btmediatek_data {
+	DECLARE_BITMAP(flags, __BTMTK_NUM_FLAGS);
+
 	u32 dev_id;
 	btmtk_reset_sync_func_t reset_sync;
 	struct btmtk_coredump_info cd_info;
 };
 
+#define btmtk_set_flag(hdev, nr)						\
+	do {									\
+		struct btmediatek_data *mediatek = hci_get_priv((hdev));	\
+		set_bit((nr), mediatek->flags);					\
+	} while (0)
+
+#define btmtk_clear_flag(hdev, nr)						\
+	do {									\
+		struct btmediatek_data *mediatek = hci_get_priv((hdev));	\
+		clear_bit((nr), mediatek->flags);				\
+	} while (0)
+
+#define btmtk_get_flag(hdev)							\
+	(((struct btmediatek_data *)hci_get_priv(hdev))->flags)
+
+#define btmtk_test_flag(hdev, nr)	test_bit((nr), btmtk_get_flag(hdev))
+
 typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
 				   struct btmtk_hci_wmt_params *);
 
-- 
2.18.0


