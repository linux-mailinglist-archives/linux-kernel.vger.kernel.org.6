Return-Path: <linux-kernel+bounces-229956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E263C917681
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6290E1F23F91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46BA1474CF;
	Wed, 26 Jun 2024 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IcU836RD"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A913D28F;
	Wed, 26 Jun 2024 02:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719370439; cv=none; b=GTVCm+VTIsTdIUMKfL9jpFjE8hCTOHEDGAi0erIqMvg4XsoeuntqrAsqzqRvgd3RXYhHcnAkFtBi49bN6OJrUvrPltfuEI9oP0QNLHxm8cpFBWH8wAcNnE6/hC7V+WCuP2pSI2SBIud2uI9XaBKFPc4PDemKHxZn+8HfdWal7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719370439; c=relaxed/simple;
	bh=275VGf1HLW+v0BsbW1qeyROAhDwXgXWYUPHp+s+Fm9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sc3ZnlrHkYhnhxHzawjUCwY27GWaqfgpiyMeqgGCTmSBQRkpEZFdXVhq0KlG7EiRuFsrnnn5t3B8QAKECdEzyEdsfgFykue3INv2jKvKCwqcOFmQwq0g0QYhiQS7V78y+PiaUKxME5CMFFKsK28mn4pjC/ocAeEUVQ42uWpSsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IcU836RD; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5139a47c336711ef99dc3f8fac2c3230-20240626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fVvpTPyWbb5GUnVLGMDZY/eWxKQFdXxoKfNyFEOyKjs=;
	b=IcU836RD2jyrLaRsC71KL2ofRimhs250YUySkLTUA1fUZ/dZplOqnscw1dFKopnzHEhpL9dhHQXaWS6nhPHHemoi2J8u8egv0ujVMFSvuEhfJlg02ZQw7oi1QW9EuM0R/FAvLkSyRJoAH6kKiKTlhE2Bo4Ta7eAwVbg/p36H3Ks=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:2fa06043-8b44-4c46-adb1-11d7ed8d59b2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:f47c0989-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5139a47c336711ef99dc3f8fac2c3230-20240626
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1034163931; Wed, 26 Jun 2024 10:53:50 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 25 Jun 2024 19:53:49 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 26 Jun 2024 10:53:49 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v5 6/8] Bluetooth: btmtk: move btusb_mtk_[setup, shutdown] to btmtk.c
Date: Wed, 26 Jun 2024 10:53:27 +0800
Message-ID: <20240626025329.26424-7-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240626025329.26424-1-chris.lu@mediatek.com>
References: <20240626025329.26424-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Move btusb_mtk_[setup, shutdown] and related function from
btusb.c to btmtk.c which holds vendor specific stuff and
would make btusb.c clean.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 454 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btmtk.h |  23 +-
 drivers/bluetooth/btusb.c | 452 ++-----------------------------------
 3 files changed, 484 insertions(+), 445 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index d9b4e636f0d1..3b00a13da235 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -4,6 +4,8 @@
  */
 #include <linux/module.h>
 #include <linux/firmware.h>
+#include <linux/iopoll.h>
+#include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -566,8 +568,8 @@ static int btmtk_usb_submit_wmt_recv_urb(struct hci_dev *hdev)
 	return err;
 }
 
-int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
-			   struct btmtk_hci_wmt_params *wmt_params)
+static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
+				  struct btmtk_hci_wmt_params *wmt_params)
 {
 	struct btmtk_data *data = hci_get_priv(hdev);
 	struct btmtk_hci_wmt_evt_funcc *wmt_evt_funcc;
@@ -693,7 +695,453 @@ int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	kfree(wc);
 	return err;
 }
-EXPORT_SYMBOL_GPL(btmtk_usb_hci_wmt_sync);
+
+static int btmtk_usb_func_query(struct hci_dev *hdev)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	int status, err;
+	u8 param = 0;
+
+	/* Query whether the function is enabled */
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 4;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = &status;
+
+	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to query function status (%d)", err);
+		return err;
+	}
+
+	return status;
+}
+
+static int btmtk_usb_uhw_reg_write(struct hci_dev *hdev, u32 reg, u32 val)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	int pipe, err;
+	void *buf;
+
+	buf = kzalloc(4, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	put_unaligned_le32(val, buf);
+
+	pipe = usb_sndctrlpipe(data->udev, 0);
+	err = usb_control_msg(data->udev, pipe, 0x02,
+			      0x5E,
+			      reg >> 16, reg & 0xffff,
+			      buf, 4, USB_CTRL_SET_TIMEOUT);
+	if (err < 0)
+		bt_dev_err(hdev, "Failed to write uhw reg(%d)", err);
+
+	kfree(buf);
+
+	return err;
+}
+
+static int btmtk_usb_uhw_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	int pipe, err;
+	void *buf;
+
+	buf = kzalloc(4, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pipe = usb_rcvctrlpipe(data->udev, 0);
+	err = usb_control_msg(data->udev, pipe, 0x01,
+			      0xDE,
+			      reg >> 16, reg & 0xffff,
+			      buf, 4, USB_CTRL_GET_TIMEOUT);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to read uhw reg(%d)", err);
+		goto err_free_buf;
+	}
+
+	*val = get_unaligned_le32(buf);
+	bt_dev_dbg(hdev, "reg=%x, value=0x%08x", reg, *val);
+
+err_free_buf:
+	kfree(buf);
+
+	return err;
+}
+
+static int btmtk_usb_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	int pipe, err, size = sizeof(u32);
+	void *buf;
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pipe = usb_rcvctrlpipe(data->udev, 0);
+	err = usb_control_msg(data->udev, pipe, 0x63,
+			      USB_TYPE_VENDOR | USB_DIR_IN,
+			      reg >> 16, reg & 0xffff,
+			      buf, size, USB_CTRL_GET_TIMEOUT);
+	if (err < 0)
+		goto err_free_buf;
+
+	*val = get_unaligned_le32(buf);
+
+err_free_buf:
+	kfree(buf);
+
+	return err;
+}
+
+static int btmtk_usb_id_get(struct hci_dev *hdev, u32 reg, u32 *id)
+{
+	return btmtk_usb_reg_read(hdev, reg, id);
+}
+
+static u32 btmtk_usb_reset_done(struct hci_dev *hdev)
+{
+	u32 val = 0;
+
+	btmtk_usb_uhw_reg_read(hdev, MTK_BT_MISC, &val);
+
+	return val & MTK_BT_RST_DONE;
+}
+
+int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
+{
+	u32 val;
+	int err;
+
+	if (dev_id == 0x7922) {
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_SUBSYS_RST, &val);
+		if (err < 0)
+			return err;
+		val |= 0x00002020;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_SUBSYS_RST, val);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT, 0x00010001);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_SUBSYS_RST, &val);
+		if (err < 0)
+			return err;
+		val |= BIT(0);
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_SUBSYS_RST, val);
+		if (err < 0)
+			return err;
+		msleep(100);
+	} else if (dev_id == 0x7925) {
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err < 0)
+			return err;
+		val |= (1 << 5);
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err < 0)
+			return err;
+		val &= 0xFFFF00FF;
+		val |= (1 << 13);
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT, 0x00010001);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_RESET_REG_CONNV3, &val);
+		if (err < 0)
+			return err;
+		val |= (1 << 0);
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_RESET_REG_CONNV3, val);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_UDMA_INT_STA_BT, &val);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT1, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_UDMA_INT_STA_BT1, &val);
+		if (err < 0)
+			return err;
+		msleep(100);
+	} else {
+		/* It's Device EndPoint Reset Option Register */
+		bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_WDT_STATUS, &val);
+		if (err < 0)
+			return err;
+		/* Reset the bluetooth chip via USB interface. */
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_SUBSYS_RST, 1);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_UDMA_INT_STA_BT, &val);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT1, 0x000000FF);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_UDMA_INT_STA_BT1, &val);
+		if (err < 0)
+			return err;
+		/* MT7921 need to delay 20ms between toggle reset bit */
+		msleep(20);
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_BT_SUBSYS_RST, 0);
+		if (err < 0)
+			return err;
+		err = btmtk_usb_uhw_reg_read(hdev, MTK_BT_SUBSYS_RST, &val);
+		if (err < 0)
+			return err;
+	}
+
+	err = readx_poll_timeout(btmtk_usb_reset_done, hdev, val,
+				 val & MTK_BT_RST_DONE, 20000, 1000000);
+	if (err < 0)
+		bt_dev_err(hdev, "Reset timeout");
+
+	if (dev_id == 0x7922) {
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_UDMA_INT_STA_BT, 0x000000FF);
+		if (err < 0)
+			return err;
+	}
+
+	err = btmtk_usb_id_get(hdev, 0x70010200, &val);
+	if (err < 0 || !val)
+		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btmtk_usb_subsys_reset);
+
+int btmtk_usb_setup(struct hci_dev *hdev)
+{
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
+	struct btmtk_hci_wmt_params wmt_params;
+	ktime_t calltime, delta, rettime;
+	struct btmtk_tci_sleep tci_sleep;
+	unsigned long long duration;
+	struct sk_buff *skb;
+	const char *fwname;
+	int err, status;
+	u32 dev_id = 0;
+	char fw_bin_name[64];
+	u32 fw_version = 0, fw_flavor = 0;
+	u8 param;
+
+	calltime = ktime_get();
+
+	err = btmtk_usb_id_get(hdev, 0x80000008, &dev_id);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to get device id (%d)", err);
+		return err;
+	}
+
+	if (!dev_id || dev_id != 0x7663) {
+		err = btmtk_usb_id_get(hdev, 0x70010200, &dev_id);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to get device id (%d)", err);
+			return err;
+		}
+		err = btmtk_usb_id_get(hdev, 0x80021004, &fw_version);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to get fw version (%d)", err);
+			return err;
+		}
+		err = btmtk_usb_id_get(hdev, 0x70010020, &fw_flavor);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to get fw flavor (%d)", err);
+			return err;
+		}
+		fw_flavor = (fw_flavor & 0x00000080) >> 7;
+	}
+
+	btmtk_data->dev_id = dev_id;
+
+	err = btmtk_register_coredump(hdev, btmtk_data->drv_name, fw_version);
+	if (err < 0)
+		bt_dev_err(hdev, "Failed to register coredump (%d)", err);
+
+	switch (dev_id) {
+	case 0x7663:
+		fwname = FIRMWARE_MT7663;
+		break;
+	case 0x7668:
+		fwname = FIRMWARE_MT7668;
+		break;
+	case 0x7922:
+	case 0x7961:
+	case 0x7925:
+		/* Reset the device to ensure it's in the initial state before
+		 * downloading the firmware to ensure.
+		 */
+
+		if (!test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags))
+			btmtk_usb_subsys_reset(hdev, dev_id);
+
+		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
+				      fw_version, fw_flavor);
+
+		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
+						btmtk_usb_hci_wmt_sync);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
+			clear_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
+			return err;
+		}
+
+		set_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
+
+		/* It's Device EndPoint Reset Option Register */
+		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT,
+					      MTK_EP_RST_IN_OUT_OPT);
+		if (err < 0)
+			return err;
+
+		/* Enable Bluetooth protocol */
+		param = 1;
+		wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+		wmt_params.flag = 0;
+		wmt_params.dlen = sizeof(param);
+		wmt_params.data = &param;
+		wmt_params.status = NULL;
+
+		err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+			return err;
+		}
+
+		hci_set_msft_opcode(hdev, 0xFD30);
+		hci_set_aosp_capable(hdev);
+
+		goto done;
+	default:
+		bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
+			   dev_id);
+		return -ENODEV;
+	}
+
+	/* Query whether the firmware is already download */
+	wmt_params.op = BTMTK_WMT_SEMAPHORE;
+	wmt_params.flag = 1;
+	wmt_params.dlen = 0;
+	wmt_params.data = NULL;
+	wmt_params.status = &status;
+
+	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to query firmware status (%d)", err);
+		return err;
+	}
+
+	if (status == BTMTK_WMT_PATCH_DONE) {
+		bt_dev_info(hdev, "firmware already downloaded");
+		goto ignore_setup_fw;
+	}
+
+	/* Setup a firmware which the device definitely requires */
+	err = btmtk_setup_firmware(hdev, fwname,
+				   btmtk_usb_hci_wmt_sync);
+	if (err < 0)
+		return err;
+
+ignore_setup_fw:
+	err = readx_poll_timeout(btmtk_usb_func_query, hdev, status,
+				 status < 0 || status != BTMTK_WMT_ON_PROGRESS,
+				 2000, 5000000);
+	/* -ETIMEDOUT happens */
+	if (err < 0)
+		return err;
+
+	/* The other errors happen in btmtk_usb_func_query */
+	if (status < 0)
+		return status;
+
+	if (status == BTMTK_WMT_ON_DONE) {
+		bt_dev_info(hdev, "function already on");
+		goto ignore_func_on;
+	}
+
+	/* Enable Bluetooth protocol */
+	param = 1;
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 0;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+		return err;
+	}
+
+ignore_func_on:
+	/* Apply the low power environment setup */
+	tci_sleep.mode = 0x5;
+	tci_sleep.duration = cpu_to_le16(0x640);
+	tci_sleep.host_duration = cpu_to_le16(0x640);
+	tci_sleep.host_wakeup_pin = 0;
+	tci_sleep.time_compensation = 0;
+
+	skb = __hci_cmd_sync(hdev, 0xfc7a, sizeof(tci_sleep), &tci_sleep,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Failed to apply low power setting (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+done:
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Device setup in %llu usecs", duration);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btmtk_usb_setup);
+
+int btmtk_usb_shutdown(struct hci_dev *hdev)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	u8 param = 0;
+	int err;
+
+	/* Disable the device */
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 0;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btmtk_usb_shutdown);
 
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index c9717630e55d..9cc4490e8ddb 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -142,6 +142,8 @@ struct btmtk_hci_wmt_params {
 
 enum {
 	BTMTK_TX_WAIT_VND_EVT,
+	BTMTK_FIRMWARE_LOADED,
+	BTMTK_HW_RESET_ACTIVE,
 };
 
 typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
@@ -154,6 +156,7 @@ struct btmtk_coredump_info {
 };
 
 struct btmtk_data {
+	const char *drv_name;
 	unsigned long flags;
 	u32 dev_id;
 	btmtk_reset_sync_func_t reset_sync;
@@ -188,8 +191,11 @@ int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
 void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 			   u32 fw_flavor);
 
-int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
-			   struct btmtk_hci_wmt_params *wmt_params);
+int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id);
+
+int btmtk_usb_setup(struct hci_dev *hdev);
+
+int btmtk_usb_shutdown(struct hci_dev *hdev);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -230,8 +236,17 @@ static void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id,
 {
 }
 
-static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
-				  struct btmtk_hci_wmt_params *wmt_params)
+static int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static int btmtk_usb_setup(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
+static int btmtk_usb_shutdown(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 660e528fdd94..d61a1d02e3e3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2641,241 +2641,6 @@ static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_recv_frame(hdev, skb);
 }
 
-static int btusb_mtk_func_query(struct hci_dev *hdev)
-{
-	struct btmtk_hci_wmt_params wmt_params;
-	int status, err;
-	u8 param = 0;
-
-	/* Query whether the function is enabled */
-	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
-	wmt_params.flag = 4;
-	wmt_params.dlen = sizeof(param);
-	wmt_params.data = &param;
-	wmt_params.status = &status;
-
-	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to query function status (%d)", err);
-		return err;
-	}
-
-	return status;
-}
-
-static int btusb_mtk_uhw_reg_write(struct btusb_data *data, u32 reg, u32 val)
-{
-	struct hci_dev *hdev = data->hdev;
-	int pipe, err;
-	void *buf;
-
-	buf = kzalloc(4, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	put_unaligned_le32(val, buf);
-
-	pipe = usb_sndctrlpipe(data->udev, 0);
-	err = usb_control_msg(data->udev, pipe, 0x02,
-			      0x5E,
-			      reg >> 16, reg & 0xffff,
-			      buf, 4, USB_CTRL_SET_TIMEOUT);
-	if (err < 0)
-		bt_dev_err(hdev, "Failed to write uhw reg(%d)", err);
-
-	kfree(buf);
-
-	return err;
-}
-
-static int btusb_mtk_uhw_reg_read(struct btusb_data *data, u32 reg, u32 *val)
-{
-	struct hci_dev *hdev = data->hdev;
-	int pipe, err;
-	void *buf;
-
-	buf = kzalloc(4, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	pipe = usb_rcvctrlpipe(data->udev, 0);
-	err = usb_control_msg(data->udev, pipe, 0x01,
-			      0xDE,
-			      reg >> 16, reg & 0xffff,
-			      buf, 4, USB_CTRL_GET_TIMEOUT);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to read uhw reg(%d)", err);
-		goto err_free_buf;
-	}
-
-	*val = get_unaligned_le32(buf);
-	bt_dev_dbg(hdev, "reg=%x, value=0x%08x", reg, *val);
-
-err_free_buf:
-	kfree(buf);
-
-	return err;
-}
-
-static int btusb_mtk_reg_read(struct btusb_data *data, u32 reg, u32 *val)
-{
-	int pipe, err, size = sizeof(u32);
-	void *buf;
-
-	buf = kzalloc(size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	pipe = usb_rcvctrlpipe(data->udev, 0);
-	err = usb_control_msg(data->udev, pipe, 0x63,
-			      USB_TYPE_VENDOR | USB_DIR_IN,
-			      reg >> 16, reg & 0xffff,
-			      buf, size, USB_CTRL_GET_TIMEOUT);
-	if (err < 0)
-		goto err_free_buf;
-
-	*val = get_unaligned_le32(buf);
-
-err_free_buf:
-	kfree(buf);
-
-	return err;
-}
-
-static int btusb_mtk_id_get(struct btusb_data *data, u32 reg, u32 *id)
-{
-	return btusb_mtk_reg_read(data, reg, id);
-}
-
-static u32 btusb_mtk_reset_done(struct hci_dev *hdev)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	u32 val = 0;
-
-	btusb_mtk_uhw_reg_read(data, MTK_BT_MISC, &val);
-
-	return val & MTK_BT_RST_DONE;
-}
-
-static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	u32 val;
-	int err;
-
-	if (dev_id == 0x7922) {
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
-		if (err < 0)
-			return err;
-		val |= 0x00002020;
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
-		if (err < 0)
-			return err;
-		val |= BIT(0);
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
-		if (err < 0)
-			return err;
-		msleep(100);
-	} else if (dev_id == 0x7925) {
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
-		if (err < 0)
-			return err;
-		val |= (1 << 5);
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
-		if (err < 0)
-			return err;
-		val &= 0xFFFF00FF;
-		if (err < 0)
-			return err;
-		val |= (1 << 13);
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &val);
-		if (err < 0)
-			return err;
-		val |= (1 << 0);
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, val);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
-		if (err < 0)
-			return err;
-		msleep(100);
-	} else {
-		/* It's Device EndPoint Reset Option Register */
-		bt_dev_dbg(hdev, "Initiating reset mechanism via uhw");
-		err = btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_WDT_STATUS, &val);
-		if (err < 0)
-			return err;
-		/* Reset the bluetooth chip via USB interface. */
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 1);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT1, 0x000000FF);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT1, &val);
-		if (err < 0)
-			return err;
-		/* MT7921 need to delay 20ms between toggle reset bit */
-		msleep(20);
-		err = btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
-		if (err < 0)
-			return err;
-		err = btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
-		if (err < 0)
-			return err;
-	}
-
-	err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
-				 val & MTK_BT_RST_DONE, 20000, 1000000);
-	if (err < 0)
-		bt_dev_err(hdev, "Reset timeout");
-
-	if (dev_id == 0x7922) {
-		err = btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x000000FF);
-		if (err < 0)
-			return err;
-	}
-
-	err = btusb_mtk_id_get(data, 0x70010200, &val);
-	if (err < 0 || !val)
-		bt_dev_err(hdev, "Can't get device id, subsys reset fail.");
-
-	return err;
-}
-
 static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2883,7 +2648,7 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	int err;
 
 	/* It's MediaTek specific bluetooth reset mechanism via USB */
-	if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
+	if (test_and_set_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags)) {
 		bt_dev_err(hdev, "last reset failed? Not resetting again");
 		return -EBUSY;
 	}
@@ -2895,10 +2660,10 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
 
-	err = btusb_mtk_subsys_reset(hdev, btmtk_data->dev_id);
+	err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
 
 	usb_queue_reset_device(data->intf);
-	clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
+	clear_bit(BTMTK_HW_RESET_ACTIVE, &btmtk_data->flags);
 
 	return err;
 }
@@ -2906,212 +2671,23 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 static int btusb_mtk_setup(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
-	struct btmtk_hci_wmt_params wmt_params;
-	ktime_t calltime, delta, rettime;
-	struct btmtk_tci_sleep tci_sleep;
-	unsigned long long duration;
-	struct sk_buff *skb;
-	const char *fwname;
-	int err, status;
-	u32 dev_id = 0;
-	char fw_bin_name[64];
-	u32 fw_version = 0, fw_flavor = 0;
-	u8 param;
-	struct btmtk_data *mediatek;
-
-	calltime = ktime_get();
-
-	err = btusb_mtk_id_get(data, 0x80000008, &dev_id);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to get device id (%d)", err);
-		return err;
-	}
-
-	if (!dev_id || dev_id != 0x7663) {
-		err = btusb_mtk_id_get(data, 0x70010200, &dev_id);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to get device id (%d)", err);
-			return err;
-		}
-		err = btusb_mtk_id_get(data, 0x80021004, &fw_version);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to get fw version (%d)", err);
-			return err;
-		}
-		err = btusb_mtk_id_get(data, 0x70010020, &fw_flavor);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to get fw flavor (%d)", err);
-			return err;
-		}
-		fw_flavor = (fw_flavor & 0x00000080) >> 7;
-	}
-
-	mediatek = hci_get_priv(hdev);
-	mediatek->dev_id = dev_id;
-	mediatek->reset_sync = btusb_mtk_reset;
-
-	err = btmtk_register_coredump(hdev, btusb_driver.name, fw_version);
-	if (err < 0)
-		bt_dev_err(hdev, "Failed to register coredump (%d)", err);
-
-	switch (dev_id) {
-	case 0x7663:
-		fwname = FIRMWARE_MT7663;
-		break;
-	case 0x7668:
-		fwname = FIRMWARE_MT7668;
-		break;
-	case 0x7922:
-	case 0x7961:
-	case 0x7925:
-		/* Reset the device to ensure it's in the initial state before
-		 * downloading the firmware to ensure.
-		 */
-
-		if (!test_bit(BTUSB_FIRMWARE_LOADED, &data->flags))
-			btusb_mtk_subsys_reset(hdev, dev_id);
-
-		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
-				      fw_version, fw_flavor);
-
-		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
-						btmtk_usb_hci_wmt_sync);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
-			clear_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-			return err;
-		}
-
-		set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
-
-		/* It's Device EndPoint Reset Option Register */
-		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
-
-		/* Enable Bluetooth protocol */
-		param = 1;
-		wmt_params.op = BTMTK_WMT_FUNC_CTRL;
-		wmt_params.flag = 0;
-		wmt_params.dlen = sizeof(param);
-		wmt_params.data = &param;
-		wmt_params.status = NULL;
-
-		err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
-			return err;
-		}
-
-		hci_set_msft_opcode(hdev, 0xFD30);
-		hci_set_aosp_capable(hdev);
-		goto done;
-	default:
-		bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
-			   dev_id);
-		return -ENODEV;
-	}
-
-	/* Query whether the firmware is already download */
-	wmt_params.op = BTMTK_WMT_SEMAPHORE;
-	wmt_params.flag = 1;
-	wmt_params.dlen = 0;
-	wmt_params.data = NULL;
-	wmt_params.status = &status;
-
-	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to query firmware status (%d)", err);
-		return err;
-	}
-
-	if (status == BTMTK_WMT_PATCH_DONE) {
-		bt_dev_info(hdev, "firmware already downloaded");
-		goto ignore_setup_fw;
-	}
-
-	/* Setup a firmware which the device definitely requires */
-	err = btmtk_setup_firmware(hdev, fwname,
-				   btmtk_usb_hci_wmt_sync);
-	if (err < 0)
-		return err;
-
-ignore_setup_fw:
-	err = readx_poll_timeout(btusb_mtk_func_query, hdev, status,
-				 status < 0 || status != BTMTK_WMT_ON_PROGRESS,
-				 2000, 5000000);
-	/* -ETIMEDOUT happens */
-	if (err < 0)
-		return err;
-
-	/* The other errors happen in btusb_mtk_func_query */
-	if (status < 0)
-		return status;
-
-	if (status == BTMTK_WMT_ON_DONE) {
-		bt_dev_info(hdev, "function already on");
-		goto ignore_func_on;
-	}
-
-	/* Enable Bluetooth protocol */
-	param = 1;
-	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
-	wmt_params.flag = 0;
-	wmt_params.dlen = sizeof(param);
-	wmt_params.data = &param;
-	wmt_params.status = NULL;
-
-	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
-		return err;
-	}
-
-ignore_func_on:
-	/* Apply the low power environment setup */
-	tci_sleep.mode = 0x5;
-	tci_sleep.duration = cpu_to_le16(0x640);
-	tci_sleep.host_duration = cpu_to_le16(0x640);
-	tci_sleep.host_wakeup_pin = 0;
-	tci_sleep.time_compensation = 0;
-
-	skb = __hci_cmd_sync(hdev, 0xfc7a, sizeof(tci_sleep), &tci_sleep,
-			     HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		err = PTR_ERR(skb);
-		bt_dev_err(hdev, "Failed to apply low power setting (%d)", err);
-		return err;
-	}
-	kfree_skb(skb);
-
-done:
-	rettime = ktime_get();
-	delta = ktime_sub(rettime, calltime);
-	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
 
-	bt_dev_info(hdev, "Device setup in %llu usecs", duration);
+	/* MediaTek WMT vendor cmd requiring below USB resources to
+	 * complete the handshake.
+	 */
+	btmtk_data->drv_name = btusb_driver.name;
+	btmtk_data->intf = data->intf;
+	btmtk_data->udev = data->udev;
+	btmtk_data->ctrl_anchor = &data->ctrl_anchor;
+	btmtk_data->reset_sync = btusb_mtk_reset;
 
-	return 0;
+	return btmtk_usb_setup(hdev);
 }
 
 static int btusb_mtk_shutdown(struct hci_dev *hdev)
 {
-	struct btmtk_hci_wmt_params wmt_params;
-	u8 param = 0;
-	int err;
-
-	/* Disable the device */
-	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
-	wmt_params.flag = 0;
-	wmt_params.dlen = sizeof(param);
-	wmt_params.data = &param;
-	wmt_params.status = NULL;
-
-	err = btmtk_usb_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
-		return err;
-	}
-
-	return 0;
+	return btmtk_usb_shutdown(hdev);
 }
 
 static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
-- 
2.18.0


