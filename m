Return-Path: <linux-kernel+bounces-341901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5B598880F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37121F2254B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CF01C173C;
	Fri, 27 Sep 2024 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="D4DzA3u1"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36E482481
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450244; cv=none; b=OryoBDTxre5Ku9vP1uzP2uirBBNhi4dZL1tBKLzNNc7c+/0yznJJOfB1dORGcsFcCR74Im704odbvEBalgP2gN6sfzyBnbW5r632gaxQZvxw+wzFjzQN8AQuvjFesEkr4SwpsU89BJnrGF7i2qdvt0lQLsR5bUwJAJrO5l5blco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450244; c=relaxed/simple;
	bh=nbH1KxfA0S+8xSM6p/LKU00KSUg7Z1qt0LKdpeIVZHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=psUC5tnY+wlzOoEFWvSGqUVlZypJzsrc/B1uaoFcjFmfPx3lU/kxTc8NOy0JP08ZJcisMOxpoRWZ6ZfXOKHhdWGoEFLNghOZELr46vUHWO5dDL+nZxiP+m4GE8HCHPMOptuReZXB76SN2WHXpX7PzKOWVuCATg7hPF1FZMu3Jmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=D4DzA3u1; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1727450215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xxaoraOSF1k+bhy4o5Kx3dtozQaoKJekxSPIACzR58o=;
	b=D4DzA3u1J15zox4JPaRHJV93RE60duAtz/Bl2SPGu7L7lVL1b6UmkS/3qO8h1awSvjuhHP
	Pyjf3++DZECYI3wgNUDtTTDBjbtBYETDkR+TEQ8pK+2oIwzyWtySYuLc5zrLk2UPGfTL10
	4kjXsa3G0xGtgIj8WlgZCkasUcz3z9BlYjzwgv+RWslrCnF3ZZjNE5V+b1pgw1PZw2jF0m
	+bd/8YxmSQYFmO88jrJB6HpB8cgeTYh3jgzBWZSCMZQv58i1I0cBxstdCaVGJmu8tMSy9i
	+H8/SlOYIStKmPTEbRdprPI+iaIVm4uzrk7TMTsL9Ett7VhHr0n6D/JMnOs9/w==
From: Xingquan Liu <b1n@b1n.io>
To: Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Xingquan Liu <b1n@b1n.io>
Subject: [PATCH] staging: rtl8712: Fix unnecessary parentheses warnings
Date: Fri, 27 Sep 2024 23:16:36 +0800
Message-Id: <20240927151637.82772-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fix all unnecessary parentheses warnings in checkpath.

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
I ran clang-format additionally because I noticed the Linux community
recommends submitting code formatting patches along with other patches.

I'm not sure if there are any issues with this.

 drivers/staging/rtl8712/basic_types.h         |    1 -
 drivers/staging/rtl8712/drv_types.h           |   97 +-
 drivers/staging/rtl8712/ethernet.h            |    5 +-
 drivers/staging/rtl8712/hal_init.c            |   60 +-
 drivers/staging/rtl8712/ieee80211.c           |   71 +-
 drivers/staging/rtl8712/ieee80211.h           |  139 +-
 drivers/staging/rtl8712/mlme_linux.c          |   31 +-
 drivers/staging/rtl8712/mlme_osdep.h          |    5 +-
 drivers/staging/rtl8712/mp_custom_oid.h       |  470 +++--
 drivers/staging/rtl8712/os_intfs.c            |   42 +-
 drivers/staging/rtl8712/osdep_intf.h          |    4 +-
 drivers/staging/rtl8712/osdep_service.h       |   19 +-
 drivers/staging/rtl8712/recv_linux.c          |   12 +-
 drivers/staging/rtl8712/rtl8712_bitdef.h      |    1 -
 drivers/staging/rtl8712/rtl8712_cmd.c         |   59 +-
 drivers/staging/rtl8712/rtl8712_cmd.h         |  208 +-
 .../staging/rtl8712/rtl8712_cmdctrl_bitdef.h  |  129 +-
 .../staging/rtl8712/rtl8712_cmdctrl_regdef.h  |   15 +-
 .../rtl8712/rtl8712_debugctrl_bitdef.h        |   34 +-
 .../rtl8712/rtl8712_debugctrl_regdef.h        |   41 +-
 .../rtl8712/rtl8712_edcasetting_bitdef.h      |   60 +-
 .../rtl8712/rtl8712_edcasetting_regdef.h      |   25 +-
 drivers/staging/rtl8712/rtl8712_efuse.c       |   84 +-
 drivers/staging/rtl8712/rtl8712_efuse.h       |   40 +-
 drivers/staging/rtl8712/rtl8712_event.h       |   76 +-
 .../staging/rtl8712/rtl8712_fifoctrl_bitdef.h |  179 +-
 .../staging/rtl8712/rtl8712_fifoctrl_regdef.h |  102 +-
 drivers/staging/rtl8712/rtl8712_gp_bitdef.h   |   66 +-
 drivers/staging/rtl8712/rtl8712_gp_regdef.h   |   23 +-
 drivers/staging/rtl8712/rtl8712_hal.h         |   82 +-
 .../rtl8712/rtl8712_interrupt_bitdef.h        |   63 +-
 drivers/staging/rtl8712/rtl8712_led.c         |  549 ++++--
 .../rtl8712/rtl8712_macsetting_bitdef.h       |   13 +-
 .../rtl8712/rtl8712_macsetting_regdef.h       |   17 +-
 .../rtl8712/rtl8712_powersave_bitdef.h        |   36 +-
 .../rtl8712/rtl8712_powersave_regdef.h        |   29 +-
 .../staging/rtl8712/rtl8712_ratectrl_bitdef.h |   31 +-
 .../staging/rtl8712/rtl8712_ratectrl_regdef.h |   51 +-
 drivers/staging/rtl8712/rtl8712_recv.c        |  209 +-
 drivers/staging/rtl8712/rtl8712_recv.h        |   31 +-
 drivers/staging/rtl8712/rtl8712_regdef.h      |    3 +-
 .../staging/rtl8712/rtl8712_security_bitdef.h |   37 +-
 drivers/staging/rtl8712/rtl8712_spec.h        |  158 +-
 .../staging/rtl8712/rtl8712_syscfg_bitdef.h   |  194 +-
 .../staging/rtl8712/rtl8712_syscfg_regdef.h   |   47 +-
 .../staging/rtl8712/rtl8712_timectrl_bitdef.h |   31 +-
 .../staging/rtl8712/rtl8712_timectrl_regdef.h |   30 +-
 drivers/staging/rtl8712/rtl8712_wmac_bitdef.h |   41 +-
 drivers/staging/rtl8712/rtl8712_wmac_regdef.h |   35 +-
 drivers/staging/rtl8712/rtl8712_xmit.c        |  234 +--
 drivers/staging/rtl8712/rtl8712_xmit.h        |   26 +-
 drivers/staging/rtl8712/rtl871x_cmd.c         |  242 ++-
 drivers/staging/rtl8712/rtl871x_cmd.h         |  320 +--
 drivers/staging/rtl8712/rtl871x_debug.h       |  146 +-
 drivers/staging/rtl8712/rtl871x_eeprom.c      |   10 +-
 drivers/staging/rtl8712/rtl871x_eeprom.h      |   47 +-
 drivers/staging/rtl8712/rtl871x_event.h       |   32 +-
 drivers/staging/rtl8712/rtl871x_ht.h          |   15 +-
 drivers/staging/rtl8712/rtl871x_io.c          |   19 +-
 drivers/staging/rtl8712/rtl871x_io.h          |  196 +-
 drivers/staging/rtl8712/rtl871x_ioctl.h       |   83 +-
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c |  791 ++++----
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.c   |  123 +-
 drivers/staging/rtl8712/rtl871x_ioctl_rtl.h   |  123 +-
 drivers/staging/rtl8712/rtl871x_ioctl_set.c   |   67 +-
 drivers/staging/rtl8712/rtl871x_ioctl_set.h   |   11 +-
 drivers/staging/rtl8712/rtl871x_led.h         |   59 +-
 drivers/staging/rtl8712/rtl871x_mlme.c        |  595 +++---
 drivers/staging/rtl8712/rtl871x_mlme.h        |   96 +-
 drivers/staging/rtl8712/rtl871x_mp.c          |  156 +-
 drivers/staging/rtl8712/rtl871x_mp.h          |  166 +-
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c    |  247 ++-
 drivers/staging/rtl8712/rtl871x_mp_ioctl.h    |  287 ++-
 .../staging/rtl8712/rtl871x_mp_phy_regdef.h   | 1714 +++++++++--------
 drivers/staging/rtl8712/rtl871x_pwrctrl.c     |   47 +-
 drivers/staging/rtl8712/rtl871x_pwrctrl.h     |   63 +-
 drivers/staging/rtl8712/rtl871x_recv.c        |  154 +-
 drivers/staging/rtl8712/rtl871x_recv.h        |  141 +-
 drivers/staging/rtl8712/rtl871x_rf.h          |   36 +-
 drivers/staging/rtl8712/rtl871x_security.c    |  634 +++---
 drivers/staging/rtl8712/rtl871x_security.h    |  198 +-
 drivers/staging/rtl8712/rtl871x_sta_mgt.c     |   78 +-
 drivers/staging/rtl8712/rtl871x_wlan_sme.h    |   33 +-
 drivers/staging/rtl8712/rtl871x_xmit.c        |  289 +--
 drivers/staging/rtl8712/rtl871x_xmit.h        |  261 ++-
 drivers/staging/rtl8712/sta_info.h            |   60 +-
 drivers/staging/rtl8712/usb_halinit.c         |   22 +-
 drivers/staging/rtl8712/usb_intf.c            |  273 +--
 drivers/staging/rtl8712/usb_ops.h             |   12 +-
 drivers/staging/rtl8712/usb_ops_linux.c       |   86 +-
 drivers/staging/rtl8712/wifi.h                |  186 +-
 drivers/staging/rtl8712/wlan_bssdef.h         |  114 +-
 drivers/staging/rtl8712/xmit_linux.c          |   21 +-
 drivers/staging/rtl8712/xmit_osdep.h          |   22 +-
 94 files changed, 6192 insertions(+), 6128 deletions(-)

diff --git a/drivers/staging/rtl8712/basic_types.h b/drivers/staging/rtl8712/basic_types.h
index aecded87dd4c..3df7a200ba29 100644
--- a/drivers/staging/rtl8712/basic_types.h
+++ b/drivers/staging/rtl8712/basic_types.h
@@ -25,4 +25,3 @@
 #define addr_t unsigned long
 
 #endif /*__BASIC_TYPES_H__*/
-
diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
index 76ac798642bd..1e9c2ff68eaf 100644
--- a/drivers/staging/rtl8712/drv_types.h
+++ b/drivers/staging/rtl8712/drv_types.h
@@ -29,14 +29,9 @@ struct _adapter;
 #include <linux/mutex.h>
 #include <linux/completion.h>
 
-enum _NIC_VERSION {
-	RTL8711_NIC,
-	RTL8712_NIC,
-	RTL8713_NIC,
-	RTL8716_NIC
-};
+enum _NIC_VERSION { RTL8711_NIC, RTL8712_NIC, RTL8713_NIC, RTL8716_NIC };
 
-struct	qos_priv	{
+struct qos_priv {
 	/* bit mask option: u-apsd, s-apsd, ts, block ack... */
 	unsigned int qos_option;
 };
@@ -60,30 +55,29 @@ struct	qos_priv	{
 #define SPEC_DEV_ID_DISABLE_HT BIT(1)
 
 struct specific_device_id {
-	u32		flags;
-	u16		idVendor;
-	u16		idProduct;
-
+	u32 flags;
+	u16 idVendor;
+	u16 idProduct;
 };
 
 struct registry_priv {
-	u8	chip_version;
-	u8	rfintfs;
-	u8	lbkmode;
-	u8	hci;
-	u8	network_mode;	/*infra, ad-hoc, auto*/
-	struct ndis_802_11_ssid	ssid;
-	u8	channel;/* ad-hoc support requirement */
-	u8	wireless_mode;/* A, B, G, auto */
-	u8	vrtl_carrier_sense; /*Enable, Disable, Auto*/
-	u8	vcs_type;/*RTS/CTS, CTS-to-self*/
-	u16	rts_thresh;
-	u16  frag_thresh;
-	u8	preamble;/*long, short, auto*/
-	u8  scan_mode;/*active, passive*/
-	u8  adhoc_tx_pwr;
-	u8  soft_ap;
-	u8  smart_ps;
+	u8 chip_version;
+	u8 rfintfs;
+	u8 lbkmode;
+	u8 hci;
+	u8 network_mode; /*infra, ad-hoc, auto*/
+	struct ndis_802_11_ssid ssid;
+	u8 channel; /* ad-hoc support requirement */
+	u8 wireless_mode; /* A, B, G, auto */
+	u8 vrtl_carrier_sense; /*Enable, Disable, Auto*/
+	u8 vcs_type; /*RTS/CTS, CTS-to-self*/
+	u16 rts_thresh;
+	u16 frag_thresh;
+	u8 preamble; /*long, short, auto*/
+	u8 scan_mode; /*active, passive*/
+	u8 adhoc_tx_pwr;
+	u8 soft_ap;
+	u8 smart_ps;
 	u8 power_mgnt;
 	u8 radio_enable;
 	u8 long_retry_lmt;
@@ -106,7 +100,7 @@ struct registry_priv {
 
 	u8 ht_enable;
 	u8 cbw40_enable;
-	u8 ampdu_enable;/*for tx*/
+	u8 ampdu_enable; /*for tx*/
 	u8 rf_config;
 	u8 low_power;
 	u8 wifi_test;
@@ -115,7 +109,7 @@ struct registry_priv {
 struct dvobj_priv {
 	struct _adapter *padapter;
 	u32 nr_endpoint;
-	u8   ishighspeed;
+	u8 ishighspeed;
 	uint (*inirp_init)(struct _adapter *adapter);
 	uint (*inirp_deinit)(struct _adapter *adapter);
 	struct usb_device *pusbdev;
@@ -127,27 +121,27 @@ struct dvobj_priv {
  * bup: True indicates that the interface is up.
  */
 struct _adapter {
-	struct	dvobj_priv dvobjpriv;
-	struct	mlme_priv mlmepriv;
-	struct	cmd_priv	cmdpriv;
-	struct	evt_priv	evtpriv;
-	struct	io_queue	*pio_queue;
-	struct	xmit_priv	xmitpriv;
-	struct	recv_priv	recvpriv;
-	struct	sta_priv	stapriv;
-	struct	security_priv	securitypriv;
-	struct	registry_priv	registrypriv;
-	struct	wlan_acl_pool	acl_list;
-	struct	pwrctrl_priv	pwrctrlpriv;
-	struct	eeprom_priv eeprompriv;
-	struct	hal_priv	halpriv;
-	struct	led_priv	ledpriv;
-	struct mp_priv  mppriv;
-	bool	driver_stopped;
-	bool	surprise_removed;
-	bool	suspended;
-	u8	eeprom_address_size;
-	u8	hw_init_completed;
+	struct dvobj_priv dvobjpriv;
+	struct mlme_priv mlmepriv;
+	struct cmd_priv cmdpriv;
+	struct evt_priv evtpriv;
+	struct io_queue *pio_queue;
+	struct xmit_priv xmitpriv;
+	struct recv_priv recvpriv;
+	struct sta_priv stapriv;
+	struct security_priv securitypriv;
+	struct registry_priv registrypriv;
+	struct wlan_acl_pool acl_list;
+	struct pwrctrl_priv pwrctrlpriv;
+	struct eeprom_priv eeprompriv;
+	struct hal_priv halpriv;
+	struct led_priv ledpriv;
+	struct mp_priv mppriv;
+	bool driver_stopped;
+	bool surprise_removed;
+	bool suspended;
+	u8 eeprom_address_size;
+	u8 hw_init_completed;
 	struct task_struct *cmd_thread;
 	uint (*dvobj_init)(struct _adapter *adapter);
 	void (*dvobj_deinit)(struct _adapter *adapter);
@@ -172,4 +166,3 @@ static inline u8 *myid(struct eeprom_priv *peepriv)
 u8 r8712_usb_hal_bus_init(struct _adapter *adapter);
 
 #endif /*__DRV_TYPES_H__*/
-
diff --git a/drivers/staging/rtl8712/ethernet.h b/drivers/staging/rtl8712/ethernet.h
index 4b9b8a97a0bc..e12391264527 100644
--- a/drivers/staging/rtl8712/ethernet.h
+++ b/drivers/staging/rtl8712/ethernet.h
@@ -14,8 +14,7 @@
 #ifndef __INC_ETHERNET_H
 #define __INC_ETHERNET_H
 
-#define ETHERNET_HEADER_SIZE		14	/*!< Ethernet Header Length*/
-#define LLC_HEADER_SIZE			6	/*!< LLC Header Length*/
+#define ETHERNET_HEADER_SIZE 14 /*!< Ethernet Header Length*/
+#define LLC_HEADER_SIZE 6 /*!< LLC Header Length*/
 
 #endif /* #ifndef __INC_ETHERNET_H */
-
diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 1148075f0cd6..aeffb4688fa4 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -96,7 +96,7 @@ static void fill_fwpriv(struct _adapter *adapter, struct fw_priv *fwpriv)
 
 	memset(fwpriv, 0, sizeof(struct fw_priv));
 	/* todo: check if needs endian conversion */
-	fwpriv->hci_sel =  RTL8712_HCI_TYPE_72USB;
+	fwpriv->hci_sel = RTL8712_HCI_TYPE_72USB;
 	fwpriv->usb_ep_num = (u8)dvobj->nr_endpoint;
 	fwpriv->bw_40MHz_en = regpriv->cbw40_enable;
 	switch (regpriv->rf_config) {
@@ -119,7 +119,7 @@ static void fill_fwpriv(struct _adapter *adapter, struct fw_priv *fwpriv)
 	fwpriv->low_power_mode = regpriv->low_power;
 }
 
-static void update_fwhdr(struct fw_hdr	*pfwhdr, const u8 *pmappedfw)
+static void update_fwhdr(struct fw_hdr *pfwhdr, const u8 *pmappedfw)
 {
 	pfwhdr->signature = le16_to_cpu(*(__le16 *)pmappedfw);
 	pfwhdr->version = le16_to_cpu(*(__le16 *)(pmappedfw + 2));
@@ -135,18 +135,18 @@ static void update_fwhdr(struct fw_hdr	*pfwhdr, const u8 *pmappedfw)
 
 static u8 chk_fwhdr(struct fw_hdr *pfwhdr, u32 ulfilelength)
 {
-	u32	fwhdrsz, fw_sz;
+	u32 fwhdrsz, fw_sz;
 
 	/* check signature */
-	if ((pfwhdr->signature != 0x8712) && (pfwhdr->signature != 0x8192))
+	if (pfwhdr->signature != 0x8712 && pfwhdr->signature != 0x8192)
 		return _FAIL;
 	/* check fw_priv_sze & sizeof(struct fw_priv) */
 	if (pfwhdr->fw_priv_sz != sizeof(struct fw_priv))
 		return _FAIL;
 	/* check fw_sz & image_fw_sz */
 	fwhdrsz = offsetof(struct fw_hdr, fwpriv) + pfwhdr->fw_priv_sz;
-	fw_sz =  fwhdrsz + pfwhdr->img_IMEM_size + pfwhdr->img_SRAM_size +
-		 pfwhdr->dmem_size;
+	fw_sz = fwhdrsz + pfwhdr->img_IMEM_size + pfwhdr->img_SRAM_size +
+		pfwhdr->dmem_size;
 	if (fw_sz != ulfilelength)
 		return _FAIL;
 	return _SUCCESS;
@@ -160,7 +160,7 @@ static u8 rtl8712_dl_fw(struct _adapter *adapter)
 	u32 maxlen = 0; /* for compare usage */
 	uint dump_imem_sz, imem_sz, dump_emem_sz, emem_sz; /* max = 49152; */
 	struct fw_hdr fwhdr;
-	u32 ulfilelength;	/* FW file size */
+	u32 ulfilelength; /* FW file size */
 	const u8 *mappedfw = NULL;
 	u8 *tmpchar = NULL, *payload, *ptr;
 	struct tx_desc *txdesc;
@@ -168,21 +168,23 @@ static u8 rtl8712_dl_fw(struct _adapter *adapter)
 	u8 ret = _FAIL;
 
 	ulfilelength = rtl871x_open_fw(adapter, &mappedfw);
-	if (mappedfw && (ulfilelength > 0)) {
+	if (mappedfw && ulfilelength > 0) {
 		update_fwhdr(&fwhdr, mappedfw);
 		if (chk_fwhdr(&fwhdr, ulfilelength) == _FAIL)
 			return ret;
 		fill_fwpriv(adapter, &fwhdr.fwpriv);
 		/* firmware check ok */
 		maxlen = (fwhdr.img_IMEM_size > fwhdr.img_SRAM_size) ?
-			  fwhdr.img_IMEM_size : fwhdr.img_SRAM_size;
+				 fwhdr.img_IMEM_size :
+				 fwhdr.img_SRAM_size;
 		maxlen += txdscp_sz;
 		tmpchar = kmalloc(maxlen + FWBUFF_ALIGN_SZ, GFP_KERNEL);
 		if (!tmpchar)
 			return ret;
 
 		txdesc = (struct tx_desc *)(tmpchar + FWBUFF_ALIGN_SZ -
-			    ((addr_t)(tmpchar) & (FWBUFF_ALIGN_SZ - 1)));
+					    ((addr_t)(tmpchar) &
+					     (FWBUFF_ALIGN_SZ - 1)));
 		payload = (u8 *)(txdesc) + txdscp_sz;
 		ptr = (u8 *)mappedfw + offsetof(struct fw_hdr, fwpriv) +
 		      fwhdr.fw_priv_sz;
@@ -191,14 +193,13 @@ static u8 rtl8712_dl_fw(struct _adapter *adapter)
 		imem_sz = fwhdr.img_IMEM_size;
 		do {
 			memset(txdesc, 0, TXDESC_SIZE);
-			if (imem_sz >  MAX_DUMP_FWSZ/*49152*/) {
+			if (imem_sz > MAX_DUMP_FWSZ /*49152*/) {
 				dump_imem_sz = MAX_DUMP_FWSZ;
 			} else {
 				dump_imem_sz = imem_sz;
 				txdesc->txdw0 |= cpu_to_le32(BIT(28));
 			}
-			txdesc->txdw0 |= cpu_to_le32(dump_imem_sz &
-						       0x0000ffff);
+			txdesc->txdw0 |= cpu_to_le32(dump_imem_sz & 0x0000ffff);
 			memcpy(payload, ptr, dump_imem_sz);
 			r8712_write_mem(adapter, RTL8712_DMA_VOQ,
 					dump_imem_sz + TXDESC_SIZE,
@@ -220,14 +221,13 @@ static u8 rtl8712_dl_fw(struct _adapter *adapter)
 		emem_sz = fwhdr.img_SRAM_size;
 		do {
 			memset(txdesc, 0, TXDESC_SIZE);
-			if (emem_sz >  MAX_DUMP_FWSZ) { /* max=48k */
+			if (emem_sz > MAX_DUMP_FWSZ) { /* max=48k */
 				dump_emem_sz = MAX_DUMP_FWSZ;
 			} else {
 				dump_emem_sz = emem_sz;
 				txdesc->txdw0 |= cpu_to_le32(BIT(28));
 			}
-			txdesc->txdw0 |= cpu_to_le32(dump_emem_sz &
-						       0x0000ffff);
+			txdesc->txdw0 |= cpu_to_le32(dump_emem_sz & 0x0000ffff);
 			memcpy(payload, ptr, dump_emem_sz);
 			r8712_write_mem(adapter, RTL8712_DMA_VOQ,
 					dump_emem_sz + TXDESC_SIZE,
@@ -301,7 +301,7 @@ static u8 rtl8712_dl_fw(struct _adapter *adapter)
 				    * & FW need more time to read EEPROM
 				    */
 			i = 60;
-		else			/* boot from EFUSE */
+		else /* boot from EFUSE */
 			i = 30;
 		tmp16 = r8712_read16(adapter, TCR);
 		while (((tmp16 & _FWRDY) == 0) && (i > 0)) {
@@ -341,22 +341,24 @@ uint rtl8712_hal_init(struct _adapter *padapter)
 	val32 = r8712_read32(padapter, RCR);
 	r8712_write32(padapter, RCR, (val32 | BIT(25))); /* Append PHY status */
 	val32 = r8712_read32(padapter, 0x10250040);
-	r8712_write32(padapter,  0x10250040, (val32 & 0x00FFFFFF));
+	r8712_write32(padapter, 0x10250040, (val32 & 0x00FFFFFF));
 	/* for usb rx aggregation */
-	r8712_write8(padapter, 0x102500B5, r8712_read8(padapter, 0x102500B5) |
-	       BIT(0)); /* page = 128bytes */
-	r8712_write8(padapter, 0x102500BD, r8712_read8(padapter, 0x102500BD) |
-	       BIT(7)); /* enable usb rx aggregation */
+	r8712_write8(padapter, 0x102500B5,
+		     r8712_read8(padapter, 0x102500B5) |
+			     BIT(0)); /* page = 128bytes */
+	r8712_write8(padapter, 0x102500BD,
+		     r8712_read8(padapter, 0x102500BD) |
+			     BIT(7)); /* enable usb rx aggregation */
 	r8712_write8(padapter, 0x102500D9, 1); /* TH=1 => means that invalidate
 						*  usb rx aggregation
 						*/
 	r8712_write8(padapter, 0x1025FE5B, 0x04); /* 1.7ms/4 */
 	/* Fix the RX FIFO issue(USB error) */
-	r8712_write8(padapter, 0x1025fe5C, r8712_read8(padapter, 0x1025fe5C)
-		     | BIT(7));
+	r8712_write8(padapter, 0x1025fe5C,
+		     r8712_read8(padapter, 0x1025fe5C) | BIT(7));
 	for (i = 0; i < ETH_ALEN; i++)
-		padapter->eeprompriv.mac_addr[i] = r8712_read8(padapter,
-							       MACID + i);
+		padapter->eeprompriv.mac_addr[i] =
+			r8712_read8(padapter, MACID + i);
 	return _SUCCESS;
 }
 
@@ -368,19 +370,19 @@ uint rtl8712_hal_deinit(struct _adapter *padapter)
 	/* Turn off MAC	*/
 	r8712_write8(padapter, SYS_CLKR + 1, 0x38); /* Switch Control Path */
 	r8712_write8(padapter, SYS_FUNC_EN + 1, 0x70);
-	r8712_write8(padapter, PMC_FSM, 0x06);  /* Enable Loader Data Keep */
+	r8712_write8(padapter, PMC_FSM, 0x06); /* Enable Loader Data Keep */
 	r8712_write8(padapter, SYS_ISO_CTRL, 0xF9); /* Isolation signals from
 						     * CORE, PLL
 						     */
 	r8712_write8(padapter, SYS_ISO_CTRL + 1, 0xe8); /* Enable EFUSE 1.2V */
 	r8712_write8(padapter, AFE_PLL_CTRL, 0x00); /* Disable AFE PLL. */
-	r8712_write8(padapter, LDOA15_CTRL, 0x54);  /* Disable A15V */
+	r8712_write8(padapter, LDOA15_CTRL, 0x54); /* Disable A15V */
 	r8712_write8(padapter, SYS_FUNC_EN + 1, 0x50); /* Disable E-Fuse 1.2V */
 	r8712_write8(padapter, LDOV12D_CTRL, 0x24); /* Disable LDO12(for CE) */
 	r8712_write8(padapter, AFE_MISC, 0x30); /* Disable AFE BG&MB */
 	/* Option for Disable 1.6V LDO.	*/
 	r8712_write8(padapter, SPS0_CTRL, 0x56); /* Disable 1.6V LDO */
-	r8712_write8(padapter, SPS0_CTRL + 1, 0x43);  /* Set SW PFM */
+	r8712_write8(padapter, SPS0_CTRL + 1, 0x43); /* Set SW PFM */
 	return _SUCCESS;
 }
 
diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index 7d8f1a29d18a..696db5213d8e 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -22,25 +22,25 @@
 #include "osdep_service.h"
 #include "wlan_bssdef.h"
 
-static const u8 WPA_OUI_TYPE[] = {0x00, 0x50, 0xf2, 1};
-static const u8 WPA_CIPHER_SUITE_NONE[] = {0x00, 0x50, 0xf2, 0};
-static const u8 WPA_CIPHER_SUITE_WEP40[] = {0x00, 0x50, 0xf2, 1};
-static const u8 WPA_CIPHER_SUITE_TKIP[] = {0x00, 0x50, 0xf2, 2};
-static const u8 WPA_CIPHER_SUITE_CCMP[] = {0x00, 0x50, 0xf2, 4};
-static const u8 WPA_CIPHER_SUITE_WEP104[] = {0x00, 0x50, 0xf2, 5};
-
-static const u8 RSN_CIPHER_SUITE_NONE[] = {0x00, 0x0f, 0xac, 0};
-static const u8 RSN_CIPHER_SUITE_WEP40[] = {0x00, 0x0f, 0xac, 1};
-static const u8 RSN_CIPHER_SUITE_TKIP[] = {0x00, 0x0f, 0xac, 2};
-static const u8 RSN_CIPHER_SUITE_CCMP[] = {0x00, 0x0f, 0xac, 4};
-static const u8 RSN_CIPHER_SUITE_WEP104[] = {0x00, 0x0f, 0xac, 5};
+static const u8 WPA_OUI_TYPE[] = { 0x00, 0x50, 0xf2, 1 };
+static const u8 WPA_CIPHER_SUITE_NONE[] = { 0x00, 0x50, 0xf2, 0 };
+static const u8 WPA_CIPHER_SUITE_WEP40[] = { 0x00, 0x50, 0xf2, 1 };
+static const u8 WPA_CIPHER_SUITE_TKIP[] = { 0x00, 0x50, 0xf2, 2 };
+static const u8 WPA_CIPHER_SUITE_CCMP[] = { 0x00, 0x50, 0xf2, 4 };
+static const u8 WPA_CIPHER_SUITE_WEP104[] = { 0x00, 0x50, 0xf2, 5 };
+
+static const u8 RSN_CIPHER_SUITE_NONE[] = { 0x00, 0x0f, 0xac, 0 };
+static const u8 RSN_CIPHER_SUITE_WEP40[] = { 0x00, 0x0f, 0xac, 1 };
+static const u8 RSN_CIPHER_SUITE_TKIP[] = { 0x00, 0x0f, 0xac, 2 };
+static const u8 RSN_CIPHER_SUITE_CCMP[] = { 0x00, 0x0f, 0xac, 4 };
+static const u8 RSN_CIPHER_SUITE_WEP104[] = { 0x00, 0x0f, 0xac, 5 };
 
 /*-----------------------------------------------------------
  * for adhoc-master to generate ie and provide supported-rate to fw
  *-----------------------------------------------------------
  */
 
-static u8 WIFI_CCKRATES[] =  {
+static u8 WIFI_CCKRATES[] = {
 	(IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK),
 	(IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK),
 	(IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK),
@@ -48,14 +48,10 @@ static u8 WIFI_CCKRATES[] =  {
 };
 
 static u8 WIFI_OFDMRATES[] = {
-	(IEEE80211_OFDM_RATE_6MB),
-	(IEEE80211_OFDM_RATE_9MB),
-	(IEEE80211_OFDM_RATE_12MB),
-	(IEEE80211_OFDM_RATE_18MB),
-	(IEEE80211_OFDM_RATE_24MB),
-	(IEEE80211_OFDM_RATE_36MB),
-	(IEEE80211_OFDM_RATE_48MB),
-	(IEEE80211_OFDM_RATE_54MB)
+	(IEEE80211_OFDM_RATE_6MB),  (IEEE80211_OFDM_RATE_9MB),
+	(IEEE80211_OFDM_RATE_12MB), (IEEE80211_OFDM_RATE_18MB),
+	(IEEE80211_OFDM_RATE_24MB), (IEEE80211_OFDM_RATE_36MB),
+	(IEEE80211_OFDM_RATE_48MB), (IEEE80211_OFDM_RATE_54MB)
 };
 
 uint r8712_is_cckrates_included(u8 *rate)
@@ -63,8 +59,8 @@ uint r8712_is_cckrates_included(u8 *rate)
 	u32 i = 0;
 
 	while (rate[i] != 0) {
-		if ((((rate[i]) & 0x7f) == 2) || (((rate[i]) & 0x7f) == 4) ||
-		    (((rate[i]) & 0x7f) == 11) || (((rate[i]) & 0x7f) == 22))
+		if (((rate[i] & 0x7f) == 2) || ((rate[i] & 0x7f) == 4) ||
+		    ((rate[i] & 0x7f) == 11) || ((rate[i] & 0x7f) == 22))
 			return true;
 		i++;
 	}
@@ -76,8 +72,8 @@ uint r8712_is_cckratesonly_included(u8 *rate)
 	u32 i = 0;
 
 	while (rate[i] != 0) {
-		if ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-		    (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+		if (((rate[i] & 0x7f) != 2) && ((rate[i] & 0x7f) != 4) &&
+		    ((rate[i] & 0x7f) != 11) && ((rate[i] & 0x7f) != 22))
 			return false;
 		i++;
 	}
@@ -147,7 +143,7 @@ static uint r8712_get_rateset_len(u8 *rateset)
 	uint i = 0;
 
 	while (1) {
-		if ((rateset[i]) == 0)
+		if (rateset[i] == 0)
 			break;
 		if (i > 12)
 			break;
@@ -192,8 +188,8 @@ int r8712_generate_ie(struct registry_priv *registrypriv)
 		ie = r8712_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8),
 				  (dev_network->rates + 8), &sz);
 	} else {
-		ie = r8712_set_ie(ie, WLAN_EID_SUPP_RATES,
-				  rate_len, dev_network->rates, &sz);
+		ie = r8712_set_ie(ie, WLAN_EID_SUPP_RATES, rate_len,
+				  dev_network->rates, &sz);
 	}
 	/*DS parameter set*/
 	ie = r8712_set_ie(ie, WLAN_EID_DS_PARAMS, 1,
@@ -208,7 +204,7 @@ unsigned char *r8712_get_wpa_ie(unsigned char *ie, uint *wpa_ie_len, int limit)
 {
 	u32 len;
 	u16 val16;
-	unsigned char wpa_oui_type[] = {0x00, 0x50, 0xf2, 0x01};
+	unsigned char wpa_oui_type[] = { 0x00, 0x50, 0xf2, 0x01 };
 	u8 *buf = ie;
 
 	while (1) {
@@ -365,26 +361,25 @@ int r8712_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len,
 		     u8 *wpa_ie, u16 *wpa_len)
 {
 	u8 authmode;
-	u8 wpa_oui[4] = {0x0, 0x50, 0xf2, 0x01};
+	u8 wpa_oui[4] = { 0x0, 0x50, 0xf2, 0x01 };
 	uint cnt;
 
 	/*Search required WPA or WPA2 IE and copy to sec_ie[ ]*/
 	cnt = _TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_;
 	while (cnt < in_len) {
 		authmode = in_ie[cnt];
-		if ((authmode == _WPA_IE_ID_) &&
+		if (authmode == _WPA_IE_ID_ &&
 		    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
 			memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 			*wpa_len = in_ie[cnt + 1] + 2;
-			cnt += in_ie[cnt + 1] + 2;  /*get next */
+			cnt += in_ie[cnt + 1] + 2; /*get next */
 		} else {
 			if (authmode == _WPA2_IE_ID_) {
-				memcpy(rsn_ie, &in_ie[cnt],
-				       in_ie[cnt + 1] + 2);
+				memcpy(rsn_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 				*rsn_len = in_ie[cnt + 1] + 2;
-				cnt += in_ie[cnt + 1] + 2;  /*get next*/
+				cnt += in_ie[cnt + 1] + 2; /*get next*/
 			} else {
-				cnt += in_ie[cnt + 1] + 2;   /*get next*/
+				cnt += in_ie[cnt + 1] + 2; /*get next*/
 			}
 		}
 	}
@@ -395,13 +390,13 @@ int r8712_get_wps_ie(u8 *in_ie, uint in_len, u8 *wps_ie, uint *wps_ielen)
 {
 	int match;
 	uint cnt;
-	u8 eid, wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
+	u8 eid, wps_oui[4] = { 0x0, 0x50, 0xf2, 0x04 };
 
 	cnt = 12;
 	match = false;
 	while (cnt < in_len) {
 		eid = in_ie[cnt];
-		if ((eid == _WPA_IE_ID_) &&
+		if (eid == _WPA_IE_ID_ &&
 		    (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
 			memcpy(wps_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
 			*wps_ielen = in_ie[cnt + 1] + 2;
diff --git a/drivers/staging/rtl8712/ieee80211.h b/drivers/staging/rtl8712/ieee80211.h
index 65ceaca9b51e..e815330eb6c9 100644
--- a/drivers/staging/rtl8712/ieee80211.h
+++ b/drivers/staging/rtl8712/ieee80211.h
@@ -16,55 +16,55 @@
 
 #include <linux/ieee80211.h>
 
-#define IEEE_CMD_SET_WPA_PARAM			1
-#define IEEE_CMD_SET_WPA_IE			2
-#define IEEE_CMD_SET_ENCRYPTION			3
-#define IEEE_CMD_MLME				4
-
-#define IEEE_PARAM_WPA_ENABLED			1
-#define IEEE_PARAM_TKIP_COUNTERMEASURES		2
-#define IEEE_PARAM_DROP_UNENCRYPTED		3
-#define IEEE_PARAM_PRIVACY_INVOKED		4
-#define IEEE_PARAM_AUTH_ALGS			5
-#define IEEE_PARAM_IEEE_802_1X			6
-#define IEEE_PARAM_WPAX_SELECT			7
-
-#define AUTH_ALG_OPEN_SYSTEM			0x1
-#define AUTH_ALG_SHARED_KEY			0x2
-#define AUTH_ALG_LEAP				0x00000004
-
-#define IEEE_MLME_STA_DEAUTH			1
-#define IEEE_MLME_STA_DISASSOC			2
-
-#define IEEE_CRYPT_ERR_UNKNOWN_ALG		2
-#define IEEE_CRYPT_ERR_UNKNOWN_ADDR		3
-#define IEEE_CRYPT_ERR_CRYPT_INIT_FAILED	4
-#define IEEE_CRYPT_ERR_KEY_SET_FAILED		5
-#define IEEE_CRYPT_ERR_TX_KEY_SET_FAILED	6
-#define IEEE_CRYPT_ERR_CARD_CONF_FAILED		7
-
-#define	IEEE_CRYPT_ALG_NAME_LEN			16
-
-#define WPA_CIPHER_NONE				BIT(0)
-#define WPA_CIPHER_WEP40			BIT(1)
-#define WPA_CIPHER_WEP104			BIT(2)
-#define WPA_CIPHER_TKIP				BIT(3)
-#define WPA_CIPHER_CCMP				BIT(4)
-
-#define WPA_SELECTOR_LEN			4
-#define RSN_HEADER_LEN				4
+#define IEEE_CMD_SET_WPA_PARAM 1
+#define IEEE_CMD_SET_WPA_IE 2
+#define IEEE_CMD_SET_ENCRYPTION 3
+#define IEEE_CMD_MLME 4
+
+#define IEEE_PARAM_WPA_ENABLED 1
+#define IEEE_PARAM_TKIP_COUNTERMEASURES 2
+#define IEEE_PARAM_DROP_UNENCRYPTED 3
+#define IEEE_PARAM_PRIVACY_INVOKED 4
+#define IEEE_PARAM_AUTH_ALGS 5
+#define IEEE_PARAM_IEEE_802_1X 6
+#define IEEE_PARAM_WPAX_SELECT 7
+
+#define AUTH_ALG_OPEN_SYSTEM 0x1
+#define AUTH_ALG_SHARED_KEY 0x2
+#define AUTH_ALG_LEAP 0x00000004
+
+#define IEEE_MLME_STA_DEAUTH 1
+#define IEEE_MLME_STA_DISASSOC 2
+
+#define IEEE_CRYPT_ERR_UNKNOWN_ALG 2
+#define IEEE_CRYPT_ERR_UNKNOWN_ADDR 3
+#define IEEE_CRYPT_ERR_CRYPT_INIT_FAILED 4
+#define IEEE_CRYPT_ERR_KEY_SET_FAILED 5
+#define IEEE_CRYPT_ERR_TX_KEY_SET_FAILED 6
+#define IEEE_CRYPT_ERR_CARD_CONF_FAILED 7
+
+#define IEEE_CRYPT_ALG_NAME_LEN 16
+
+#define WPA_CIPHER_NONE BIT(0)
+#define WPA_CIPHER_WEP40 BIT(1)
+#define WPA_CIPHER_WEP104 BIT(2)
+#define WPA_CIPHER_TKIP BIT(3)
+#define WPA_CIPHER_CCMP BIT(4)
+
+#define WPA_SELECTOR_LEN 4
+#define RSN_HEADER_LEN 4
 
 #define RSN_SELECTOR_LEN 4
 
 enum NETWORK_TYPE {
-	WIRELESS_INVALID	= 0,
-	WIRELESS_11B		= 1,
-	WIRELESS_11G		= 2,
-	WIRELESS_11BG		= (WIRELESS_11B | WIRELESS_11G),
-	WIRELESS_11A		= 4,
-	WIRELESS_11N		= 8,
-	WIRELESS_11GN		= (WIRELESS_11G | WIRELESS_11N),
-	WIRELESS_11BGN		= (WIRELESS_11B | WIRELESS_11G | WIRELESS_11N),
+	WIRELESS_INVALID = 0,
+	WIRELESS_11B = 1,
+	WIRELESS_11G = 2,
+	WIRELESS_11BG = (WIRELESS_11B | WIRELESS_11G),
+	WIRELESS_11A = 4,
+	WIRELESS_11N = 8,
+	WIRELESS_11GN = (WIRELESS_11G | WIRELESS_11N),
+	WIRELESS_11BGN = (WIRELESS_11B | WIRELESS_11G | WIRELESS_11N),
 };
 
 struct ieee_param {
@@ -96,41 +96,41 @@ struct ieee_param {
 	} u;
 };
 
-#define MIN_FRAG_THRESHOLD     256U
-#define	MAX_FRAG_THRESHOLD     2346U
+#define MIN_FRAG_THRESHOLD 256U
+#define MAX_FRAG_THRESHOLD 2346U
 
 /* QoS,QOS */
-#define NORMAL_ACK			0
+#define NORMAL_ACK 0
 
 /* IEEE 802.11 defines */
 
 #define P80211_OUI_LEN 3
 
 struct ieee80211_snap_hdr {
-	u8    dsap;   /* always 0xAA */
-	u8    ssap;   /* always 0xAA */
-	u8    ctrl;   /* always 0x03 */
-	u8    oui[P80211_OUI_LEN];    /* organizational universal id */
+	u8 dsap; /* always 0xAA */
+	u8 ssap; /* always 0xAA */
+	u8 ctrl; /* always 0x03 */
+	u8 oui[P80211_OUI_LEN]; /* organizational universal id */
 } __packed;
 
 #define SNAP_SIZE sizeof(struct ieee80211_snap_hdr)
 
-#define IEEE80211_CCK_RATE_LEN			4
-#define IEEE80211_NUM_OFDM_RATESLEN	8
-
-#define IEEE80211_CCK_RATE_1MB		        0x02
-#define IEEE80211_CCK_RATE_2MB		        0x04
-#define IEEE80211_CCK_RATE_5MB		        0x0B
-#define IEEE80211_CCK_RATE_11MB		        0x16
-#define IEEE80211_OFDM_RATE_6MB		        0x0C
-#define IEEE80211_OFDM_RATE_9MB		        0x12
-#define IEEE80211_OFDM_RATE_12MB		0x18
-#define IEEE80211_OFDM_RATE_18MB		0x24
-#define IEEE80211_OFDM_RATE_24MB		0x30
-#define IEEE80211_OFDM_RATE_36MB		0x48
-#define IEEE80211_OFDM_RATE_48MB		0x60
-#define IEEE80211_OFDM_RATE_54MB		0x6C
-#define IEEE80211_BASIC_RATE_MASK		0x80
+#define IEEE80211_CCK_RATE_LEN 4
+#define IEEE80211_NUM_OFDM_RATESLEN 8
+
+#define IEEE80211_CCK_RATE_1MB 0x02
+#define IEEE80211_CCK_RATE_2MB 0x04
+#define IEEE80211_CCK_RATE_5MB 0x0B
+#define IEEE80211_CCK_RATE_11MB 0x16
+#define IEEE80211_OFDM_RATE_6MB 0x0C
+#define IEEE80211_OFDM_RATE_9MB 0x12
+#define IEEE80211_OFDM_RATE_12MB 0x18
+#define IEEE80211_OFDM_RATE_18MB 0x24
+#define IEEE80211_OFDM_RATE_24MB 0x30
+#define IEEE80211_OFDM_RATE_36MB 0x48
+#define IEEE80211_OFDM_RATE_48MB 0x60
+#define IEEE80211_OFDM_RATE_54MB 0x6C
+#define IEEE80211_BASIC_RATE_MASK 0x80
 
 #define WEP_KEYS 4
 
@@ -139,7 +139,7 @@ struct ieee80211_snap_hdr {
  * rates.  Other APs, however, stick all of their supported rates on the
  * main rates information element...
  */
-#define MAX_RATES_LENGTH                  ((u8)12)
+#define MAX_RATES_LENGTH ((u8)12)
 #define MAX_WPA_IE_LEN 128
 
 struct registry_priv;
@@ -162,4 +162,3 @@ uint r8712_is_cckrates_included(u8 *rate);
 uint r8712_is_cckratesonly_included(u8 *rate);
 
 #endif /* IEEE80211_H */
-
diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712/mlme_linux.c
index 436816d14cdf..308a113a8692 100644
--- a/drivers/staging/rtl8712/mlme_linux.c
+++ b/drivers/staging/rtl8712/mlme_linux.c
@@ -22,24 +22,22 @@
 
 static void sitesurvey_ctrl_handler(struct timer_list *t)
 {
-	struct _adapter *adapter =
-		from_timer(adapter, t,
-			   mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer);
+	struct _adapter *adapter = from_timer(
+		adapter, t, mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer);
 
 	_r8712_sitesurvey_ctrl_handler(adapter);
 	mod_timer(&adapter->mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer,
 		  jiffies + msecs_to_jiffies(3000));
 }
 
-static void join_timeout_handler (struct timer_list *t)
+static void join_timeout_handler(struct timer_list *t)
 {
-	struct _adapter *adapter =
-		from_timer(adapter, t, mlmepriv.assoc_timer);
+	struct _adapter *adapter = from_timer(adapter, t, mlmepriv.assoc_timer);
 
 	_r8712_join_timeout_handler(adapter);
 }
 
-static void _scan_timeout_handler (struct timer_list *t)
+static void _scan_timeout_handler(struct timer_list *t)
 {
 	struct _adapter *adapter =
 		from_timer(adapter, t, mlmepriv.scan_to_timer);
@@ -47,18 +45,16 @@ static void _scan_timeout_handler (struct timer_list *t)
 	r8712_scan_timeout_handler(adapter);
 }
 
-static void dhcp_timeout_handler (struct timer_list *t)
+static void dhcp_timeout_handler(struct timer_list *t)
 {
-	struct _adapter *adapter =
-		from_timer(adapter, t, mlmepriv.dhcp_timer);
+	struct _adapter *adapter = from_timer(adapter, t, mlmepriv.dhcp_timer);
 
 	_r8712_dhcp_timeout_handler(adapter);
 }
 
-static void wdg_timeout_handler (struct timer_list *t)
+static void wdg_timeout_handler(struct timer_list *t)
 {
-	struct _adapter *adapter =
-		from_timer(adapter, t, mlmepriv.wdg_timer);
+	struct _adapter *adapter = from_timer(adapter, t, mlmepriv.wdg_timer);
 
 	r8712_wdg_wk_cmd(adapter);
 
@@ -68,7 +64,7 @@ static void wdg_timeout_handler (struct timer_list *t)
 
 void r8712_init_mlme_timer(struct _adapter *adapter)
 {
-	struct	mlme_priv *mlmepriv = &adapter->mlmepriv;
+	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
 
 	timer_setup(&mlmepriv->assoc_timer, join_timeout_handler, 0);
 	timer_setup(&mlmepriv->sitesurveyctrl.sitesurvey_ctrl_timer,
@@ -117,7 +113,7 @@ void r8712_os_indicate_disconnect(struct _adapter *adapter)
 		       sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
 		adapter->securitypriv.PMKIDIndex = backup_PMKID_index;
 		adapter->securitypriv.btkip_countermeasure =
-					 backup_TKIP_countermeasure;
+			backup_TKIP_countermeasure;
 	} else { /*reset values in securitypriv*/
 		struct security_priv *sec_priv = &adapter->securitypriv;
 
@@ -146,14 +142,15 @@ void r8712_report_sec_ie(struct _adapter *adapter, u8 authmode, u8 *sec_ie)
 		p = buff;
 		p += sprintf(p, "ASSOCINFO(ReqIEs=");
 		len = sec_ie[1] + 2;
-		len =  (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX;
+		len = (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX;
 		for (i = 0; i < len; i++)
 			p += sprintf(p, "%02x", sec_ie[i]);
 		p += sprintf(p, ")");
 		memset(&wrqu, 0, sizeof(wrqu));
 		wrqu.data.length = p - buff;
 		wrqu.data.length = (wrqu.data.length < IW_CUSTOM_MAX) ?
-				   wrqu.data.length : IW_CUSTOM_MAX;
+					   wrqu.data.length :
+					   IW_CUSTOM_MAX;
 		wireless_send_event(adapter->pnetdev, IWEVCUSTOM, &wrqu, buff);
 		kfree(buff);
 	}
diff --git a/drivers/staging/rtl8712/mlme_osdep.h b/drivers/staging/rtl8712/mlme_osdep.h
index a02c782588dd..b2094d068520 100644
--- a/drivers/staging/rtl8712/mlme_osdep.h
+++ b/drivers/staging/rtl8712/mlme_osdep.h
@@ -11,7 +11,7 @@
  * Larry Finger <Larry.Finger@lwfinger.net>
  *
  ******************************************************************************/
-#ifndef	__MLME_OSDEP_H_
+#ifndef __MLME_OSDEP_H_
 #define __MLME_OSDEP_H_
 
 #include "osdep_service.h"
@@ -27,5 +27,4 @@ int r8712_recv_indicatepkts_in_order(struct _adapter *adapter,
 void r8712_indicate_wx_assoc_event(struct _adapter *padapter);
 void r8712_indicate_wx_disassoc_event(struct _adapter *padapter);
 
-#endif	/*_MLME_OSDEP_H_*/
-
+#endif /*_MLME_OSDEP_H_*/
diff --git a/drivers/staging/rtl8712/mp_custom_oid.h b/drivers/staging/rtl8712/mp_custom_oid.h
index a9fac87fcabc..ba7884fd8a64 100644
--- a/drivers/staging/rtl8712/mp_custom_oid.h
+++ b/drivers/staging/rtl8712/mp_custom_oid.h
@@ -11,7 +11,7 @@
  * Larry Finger <Larry.Finger@lwfinger.net>
  *
  ******************************************************************************/
-#ifndef	__CUSTOM_OID_H
+#ifndef __CUSTOM_OID_H
 #define __CUSTOM_OID_H
 
 /* 0xFF818000 - 0xFF81802F		RTL8180 Mass Production Kit
@@ -26,262 +26,260 @@
  *	 80 (second byte of non zero Realtek unique identifier)
  *	 XX (the custom OID number - providing 255 possible custom oids)
  */
-#define OID_RT_PRO_RESET_DUT				0xFF818000
-#define OID_RT_PRO_SET_DATA_RATE			0xFF818001
-#define OID_RT_PRO_START_TEST				0xFF818002
-#define OID_RT_PRO_STOP_TEST				0xFF818003
-#define OID_RT_PRO_SET_PREAMBLE				0xFF818004
-#define OID_RT_PRO_SET_SCRAMBLER			0xFF818005
-#define OID_RT_PRO_SET_FILTER_BB			0xFF818006
-#define OID_RT_PRO_SET_MANUAL_DIVERSITY_BB		0xFF818007
-#define OID_RT_PRO_SET_CHANNEL_DIRECT_CALL		0xFF818008
-#define OID_RT_PRO_SET_SLEEP_MODE_DIRECT_CALL		0xFF818009
-#define OID_RT_PRO_SET_WAKE_MODE_DIRECT_CALL		0xFF81800A
+#define OID_RT_PRO_RESET_DUT 0xFF818000
+#define OID_RT_PRO_SET_DATA_RATE 0xFF818001
+#define OID_RT_PRO_START_TEST 0xFF818002
+#define OID_RT_PRO_STOP_TEST 0xFF818003
+#define OID_RT_PRO_SET_PREAMBLE 0xFF818004
+#define OID_RT_PRO_SET_SCRAMBLER 0xFF818005
+#define OID_RT_PRO_SET_FILTER_BB 0xFF818006
+#define OID_RT_PRO_SET_MANUAL_DIVERSITY_BB 0xFF818007
+#define OID_RT_PRO_SET_CHANNEL_DIRECT_CALL 0xFF818008
+#define OID_RT_PRO_SET_SLEEP_MODE_DIRECT_CALL 0xFF818009
+#define OID_RT_PRO_SET_WAKE_MODE_DIRECT_CALL 0xFF81800A
 
-#define OID_RT_PRO_SET_TX_ANTENNA_BB			0xFF81800D
-#define OID_RT_PRO_SET_ANTENNA_BB			0xFF81800E
-#define OID_RT_PRO_SET_CR_SCRAMBLER			0xFF81800F
-#define OID_RT_PRO_SET_CR_NEW_FILTER			0xFF818010
-#define OID_RT_PRO_SET_TX_POWER_CONTROL			0xFF818011
-#define OID_RT_PRO_SET_CR_TX_CONFIG			0xFF818012
-#define OID_RT_PRO_GET_TX_POWER_CONTROL			0xFF818013
-#define OID_RT_PRO_GET_CR_SIGNAL_QUALITY		0xFF818014
-#define OID_RT_PRO_SET_CR_SETPOINT			0xFF818015
-#define OID_RT_PRO_SET_INTEGRATOR			0xFF818016
-#define OID_RT_PRO_SET_SIGNAL_QUALITY			0xFF818017
-#define OID_RT_PRO_GET_INTEGRATOR			0xFF818018
-#define OID_RT_PRO_GET_SIGNAL_QUALITY			0xFF818019
-#define OID_RT_PRO_QUERY_EEPROM_TYPE			0xFF81801A
-#define OID_RT_PRO_WRITE_MAC_ADDRESS			0xFF81801B
-#define OID_RT_PRO_READ_MAC_ADDRESS			0xFF81801C
-#define OID_RT_PRO_WRITE_CIS_DATA			0xFF81801D
-#define OID_RT_PRO_READ_CIS_DATA			0xFF81801E
-#define OID_RT_PRO_WRITE_POWER_CONTROL			0xFF81801F
-#define OID_RT_PRO_READ_POWER_CONTROL			0xFF818020
-#define OID_RT_PRO_WRITE_EEPROM				0xFF818021
-#define OID_RT_PRO_READ_EEPROM				0xFF818022
-#define OID_RT_PRO_RESET_TX_PACKET_SENT			0xFF818023
-#define OID_RT_PRO_QUERY_TX_PACKET_SENT			0xFF818024
-#define OID_RT_PRO_RESET_RX_PACKET_RECEIVED		0xFF818025
-#define OID_RT_PRO_QUERY_RX_PACKET_RECEIVED		0xFF818026
-#define OID_RT_PRO_QUERY_RX_PACKET_CRC32_ERROR		0xFF818027
-#define OID_RT_PRO_QUERY_CURRENT_ADDRESS		0xFF818028
-#define OID_RT_PRO_QUERY_PERMANENT_ADDRESS		0xFF818029
-#define OID_RT_PRO_SET_PHILIPS_RF_PARAMETERS		0xFF81802A
-#define OID_RT_PRO_RECEIVE_PACKET			0xFF81802C
-#define OID_RT_PRO_WRITE_EEPROM_BYTE			0xFF81802D
-#define OID_RT_PRO_READ_EEPROM_BYTE			0xFF81802E
-#define OID_RT_PRO_SET_MODULATION			0xFF81802F
-#define OID_RT_DRIVER_OPTION				0xFF818080
-#define OID_RT_RF_OFF					0xFF818081
-#define OID_RT_AUTH_STATUS				0xFF818082
-#define OID_RT_PRO_SET_CONTINUOUS_TX			0xFF81800B
-#define OID_RT_PRO_SET_SINGLE_CARRIER_TX		0xFF81800C
-#define OID_RT_PRO_SET_CARRIER_SUPPRESSION_TX		0xFF81802B
-#define OID_RT_PRO_SET_SINGLE_TONE_TX			0xFF818043
-#define OID_RT_UTILITY_FALSE_ALARM_COUNTERS		0xFF818580
-#define OID_RT_UTILITY_SELECT_DEBUG_MODE		0xFF818581
-#define OID_RT_UTILITY_SELECT_SUBCARRIER_NUMBER		0xFF818582
-#define OID_RT_UTILITY_GET_RSSI_STATUS			0xFF818583
-#define OID_RT_UTILITY_GET_FRAME_DETECTION_STATUS	0xFF818584
-#define OID_RT_UTILITY_GET_AGC_AND_FREQUENCY_OFFSET_ESTIMATION_STATUS \
-							0xFF818585
-#define OID_RT_UTILITY_GET_CHANNEL_ESTIMATION_STATUS	0xFF818586
-#define OID_RT_WIRELESS_MODE				0xFF818500
-#define OID_RT_SUPPORTED_RATES				0xFF818501
-#define OID_RT_DESIRED_RATES				0xFF818502
-#define OID_RT_WIRELESS_MODE_STARTING_ADHOC		0xFF818503
-#define OID_RT_GET_CONNECT_STATE			0xFF030001
-#define OID_RT_RESCAN					0xFF030002
-#define OID_RT_SET_KEY_LENGTH				0xFF030003
-#define OID_RT_SET_DEFAULT_KEY_ID			0xFF030004
-#define OID_RT_SET_CHANNEL				0xFF010182
-#define OID_RT_SET_SNIFFER_MODE				0xFF010183
-#define OID_RT_GET_SIGNAL_QUALITY			0xFF010184
-#define OID_RT_GET_SMALL_PACKET_CRC			0xFF010185
-#define OID_RT_GET_MIDDLE_PACKET_CRC			0xFF010186
-#define OID_RT_GET_LARGE_PACKET_CRC			0xFF010187
-#define OID_RT_GET_TX_RETRY				0xFF010188
-#define OID_RT_GET_RX_RETRY				0xFF010189
-#define OID_RT_PRO_SET_FW_DIG_STATE			0xFF01018A
-#define OID_RT_PRO_SET_FW_RA_STATE			0xFF01018B
-#define OID_RT_GET_RX_TOTAL_PACKET			0xFF010190
-#define OID_RT_GET_TX_BEACON_OK				0xFF010191
-#define OID_RT_GET_TX_BEACON_ERR			0xFF010192
-#define OID_RT_GET_RX_ICV_ERR				0xFF010193
-#define OID_RT_SET_ENCRYPTION_ALGORITHM			0xFF010194
-#define OID_RT_SET_NO_AUTO_RESCAN			0xFF010195
-#define OID_RT_GET_PREAMBLE_MODE			0xFF010196
-#define OID_RT_GET_DRIVER_UP_DELTA_TIME			0xFF010197
-#define OID_RT_GET_AP_IP				0xFF010198
-#define OID_RT_GET_CHANNELPLAN				0xFF010199
-#define OID_RT_SET_PREAMBLE_MODE			0xFF01019A
-#define OID_RT_SET_BCN_INTVL				0xFF01019B
-#define OID_RT_GET_RF_VENDER				0xFF01019C
-#define OID_RT_DEDICATE_PROBE				0xFF01019D
-#define OID_RT_PRO_RX_FILTER_PATTERN			0xFF01019E
-#define OID_RT_GET_DCST_CURRENT_THRESHOLD		0xFF01019F
-#define OID_RT_GET_CCA_ERR				0xFF0101A0
-#define OID_RT_GET_CCA_UPGRADE_THRESHOLD		0xFF0101A1
-#define OID_RT_GET_CCA_FALLBACK_THRESHOLD		0xFF0101A2
-#define OID_RT_GET_CCA_UPGRADE_EVALUATE_TIMES		0xFF0101A3
-#define OID_RT_GET_CCA_FALLBACK_EVALUATE_TIMES		0xFF0101A4
-#define OID_RT_SET_RATE_ADAPTIVE			0xFF0101A5
-#define OID_RT_GET_DCST_EVALUATE_PERIOD			0xFF0101A5
-#define OID_RT_GET_DCST_TIME_UNIT_INDEX			0xFF0101A6
-#define OID_RT_GET_TOTAL_TX_BYTES			0xFF0101A7
-#define OID_RT_GET_TOTAL_RX_BYTES			0xFF0101A8
-#define OID_RT_CURRENT_TX_POWER_LEVEL			0xFF0101A9
-#define OID_RT_GET_ENC_KEY_MISMATCH_COUNT		0xFF0101AA
-#define OID_RT_GET_ENC_KEY_MATCH_COUNT			0xFF0101AB
-#define OID_RT_GET_CHANNEL				0xFF0101AC
-#define OID_RT_SET_CHANNELPLAN				0xFF0101AD
-#define OID_RT_GET_HARDWARE_RADIO_OFF			0xFF0101AE
-#define OID_RT_CHANNELPLAN_BY_COUNTRY			0xFF0101AF
-#define OID_RT_SCAN_AVAILABLE_BSSID			0xFF0101B0
-#define OID_RT_GET_HARDWARE_VERSION			0xFF0101B1
-#define OID_RT_GET_IS_ROAMING				0xFF0101B2
-#define OID_RT_GET_IS_PRIVACY				0xFF0101B3
-#define OID_RT_GET_KEY_MISMATCH				0xFF0101B4
-#define OID_RT_SET_RSSI_ROAM_TRAFFIC_TH			0xFF0101B5
-#define OID_RT_SET_RSSI_ROAM_SIGNAL_TH			0xFF0101B6
-#define OID_RT_RESET_LOG				0xFF0101B7
-#define OID_RT_GET_LOG					0xFF0101B8
-#define OID_RT_SET_INDICATE_HIDDEN_AP			0xFF0101B9
-#define OID_RT_GET_HEADER_FAIL				0xFF0101BA
-#define OID_RT_SUPPORTED_WIRELESS_MODE			0xFF0101BB
-#define OID_RT_GET_CHANNEL_LIST				0xFF0101BC
-#define OID_RT_GET_SCAN_IN_PROGRESS			0xFF0101BD
-#define OID_RT_GET_TX_INFO				0xFF0101BE
-#define OID_RT_RF_READ_WRITE_OFFSET			0xFF0101BF
-#define OID_RT_RF_READ_WRITE				0xFF0101C0
-#define OID_RT_FORCED_DATA_RATE				0xFF0101C1
-#define OID_RT_WIRELESS_MODE_FOR_SCAN_LIST		0xFF0101C2
-#define OID_RT_GET_BSS_WIRELESS_MODE			0xFF0101C3
-#define OID_RT_SCAN_WITH_MAGIC_PACKET			0xFF0101C4
-#define OID_RT_PRO_RX_FILTER				0xFF0111C0
-#define OID_CE_USB_WRITE_REGISTRY			0xFF0111C1
-#define OID_CE_USB_READ_REGISTRY			0xFF0111C2
-#define OID_RT_PRO_SET_INITIAL_GAIN			0xFF0111C3
-#define OID_RT_PRO_SET_BB_RF_STANDBY_MODE		0xFF0111C4
-#define OID_RT_PRO_SET_BB_RF_SHUTDOWN_MODE		0xFF0111C5
-#define OID_RT_PRO_SET_TX_CHARGE_PUMP			0xFF0111C6
-#define OID_RT_PRO_SET_RX_CHARGE_PUMP			0xFF0111C7
-#define OID_RT_PRO_RF_WRITE_REGISTRY			0xFF0111C8
-#define OID_RT_PRO_RF_READ_REGISTRY			0xFF0111C9
-#define OID_RT_PRO_QUERY_RF_TYPE			0xFF0111CA
-#define OID_RT_AP_GET_ASSOCIATED_STATION_LIST		0xFF010300
-#define OID_RT_AP_GET_CURRENT_TIME_STAMP		0xFF010301
-#define OID_RT_AP_SWITCH_INTO_AP_MODE			0xFF010302
-#define OID_RT_AP_SET_DTIM_PERIOD			0xFF010303
-#define OID_RT_AP_SUPPORTED				0xFF010304
-#define OID_RT_AP_SET_PASSPHRASE			0xFF010305
-#define OID_RT_PRO8187_WI_POLL				0xFF818780
-#define OID_RT_PRO_WRITE_BB_REG				0xFF818781
-#define OID_RT_PRO_READ_BB_REG				0xFF818782
-#define OID_RT_PRO_WRITE_RF_REG				0xFF818783
-#define OID_RT_PRO_READ_RF_REG				0xFF818784
-#define OID_RT_MH_VENDER_ID				0xFFEDC100
-#define OID_RT_PRO8711_JOIN_BSS				0xFF871100
-#define OID_RT_PRO_READ_REGISTER			0xFF871101
-#define OID_RT_PRO_WRITE_REGISTER			0xFF871102
-#define OID_RT_PRO_BURST_READ_REGISTER			0xFF871103
-#define OID_RT_PRO_BURST_WRITE_REGISTER			0xFF871104
-#define OID_RT_PRO_WRITE_TXCMD				0xFF871105
-#define OID_RT_PRO_READ16_EEPROM			0xFF871106
-#define OID_RT_PRO_WRITE16_EEPROM			0xFF871107
-#define OID_RT_PRO_H2C_SET_COMMAND			0xFF871108
-#define OID_RT_PRO_H2C_QUERY_RESULT			0xFF871109
-#define OID_RT_PRO8711_WI_POLL				0xFF87110A
-#define OID_RT_PRO8711_PKT_LOSS				0xFF87110B
-#define OID_RT_RD_ATTRIB_MEM				0xFF87110C
-#define OID_RT_WR_ATTRIB_MEM				0xFF87110D
+#define OID_RT_PRO_SET_TX_ANTENNA_BB 0xFF81800D
+#define OID_RT_PRO_SET_ANTENNA_BB 0xFF81800E
+#define OID_RT_PRO_SET_CR_SCRAMBLER 0xFF81800F
+#define OID_RT_PRO_SET_CR_NEW_FILTER 0xFF818010
+#define OID_RT_PRO_SET_TX_POWER_CONTROL 0xFF818011
+#define OID_RT_PRO_SET_CR_TX_CONFIG 0xFF818012
+#define OID_RT_PRO_GET_TX_POWER_CONTROL 0xFF818013
+#define OID_RT_PRO_GET_CR_SIGNAL_QUALITY 0xFF818014
+#define OID_RT_PRO_SET_CR_SETPOINT 0xFF818015
+#define OID_RT_PRO_SET_INTEGRATOR 0xFF818016
+#define OID_RT_PRO_SET_SIGNAL_QUALITY 0xFF818017
+#define OID_RT_PRO_GET_INTEGRATOR 0xFF818018
+#define OID_RT_PRO_GET_SIGNAL_QUALITY 0xFF818019
+#define OID_RT_PRO_QUERY_EEPROM_TYPE 0xFF81801A
+#define OID_RT_PRO_WRITE_MAC_ADDRESS 0xFF81801B
+#define OID_RT_PRO_READ_MAC_ADDRESS 0xFF81801C
+#define OID_RT_PRO_WRITE_CIS_DATA 0xFF81801D
+#define OID_RT_PRO_READ_CIS_DATA 0xFF81801E
+#define OID_RT_PRO_WRITE_POWER_CONTROL 0xFF81801F
+#define OID_RT_PRO_READ_POWER_CONTROL 0xFF818020
+#define OID_RT_PRO_WRITE_EEPROM 0xFF818021
+#define OID_RT_PRO_READ_EEPROM 0xFF818022
+#define OID_RT_PRO_RESET_TX_PACKET_SENT 0xFF818023
+#define OID_RT_PRO_QUERY_TX_PACKET_SENT 0xFF818024
+#define OID_RT_PRO_RESET_RX_PACKET_RECEIVED 0xFF818025
+#define OID_RT_PRO_QUERY_RX_PACKET_RECEIVED 0xFF818026
+#define OID_RT_PRO_QUERY_RX_PACKET_CRC32_ERROR 0xFF818027
+#define OID_RT_PRO_QUERY_CURRENT_ADDRESS 0xFF818028
+#define OID_RT_PRO_QUERY_PERMANENT_ADDRESS 0xFF818029
+#define OID_RT_PRO_SET_PHILIPS_RF_PARAMETERS 0xFF81802A
+#define OID_RT_PRO_RECEIVE_PACKET 0xFF81802C
+#define OID_RT_PRO_WRITE_EEPROM_BYTE 0xFF81802D
+#define OID_RT_PRO_READ_EEPROM_BYTE 0xFF81802E
+#define OID_RT_PRO_SET_MODULATION 0xFF81802F
+#define OID_RT_DRIVER_OPTION 0xFF818080
+#define OID_RT_RF_OFF 0xFF818081
+#define OID_RT_AUTH_STATUS 0xFF818082
+#define OID_RT_PRO_SET_CONTINUOUS_TX 0xFF81800B
+#define OID_RT_PRO_SET_SINGLE_CARRIER_TX 0xFF81800C
+#define OID_RT_PRO_SET_CARRIER_SUPPRESSION_TX 0xFF81802B
+#define OID_RT_PRO_SET_SINGLE_TONE_TX 0xFF818043
+#define OID_RT_UTILITY_FALSE_ALARM_COUNTERS 0xFF818580
+#define OID_RT_UTILITY_SELECT_DEBUG_MODE 0xFF818581
+#define OID_RT_UTILITY_SELECT_SUBCARRIER_NUMBER 0xFF818582
+#define OID_RT_UTILITY_GET_RSSI_STATUS 0xFF818583
+#define OID_RT_UTILITY_GET_FRAME_DETECTION_STATUS 0xFF818584
+#define OID_RT_UTILITY_GET_AGC_AND_FREQUENCY_OFFSET_ESTIMATION_STATUS 0xFF818585
+#define OID_RT_UTILITY_GET_CHANNEL_ESTIMATION_STATUS 0xFF818586
+#define OID_RT_WIRELESS_MODE 0xFF818500
+#define OID_RT_SUPPORTED_RATES 0xFF818501
+#define OID_RT_DESIRED_RATES 0xFF818502
+#define OID_RT_WIRELESS_MODE_STARTING_ADHOC 0xFF818503
+#define OID_RT_GET_CONNECT_STATE 0xFF030001
+#define OID_RT_RESCAN 0xFF030002
+#define OID_RT_SET_KEY_LENGTH 0xFF030003
+#define OID_RT_SET_DEFAULT_KEY_ID 0xFF030004
+#define OID_RT_SET_CHANNEL 0xFF010182
+#define OID_RT_SET_SNIFFER_MODE 0xFF010183
+#define OID_RT_GET_SIGNAL_QUALITY 0xFF010184
+#define OID_RT_GET_SMALL_PACKET_CRC 0xFF010185
+#define OID_RT_GET_MIDDLE_PACKET_CRC 0xFF010186
+#define OID_RT_GET_LARGE_PACKET_CRC 0xFF010187
+#define OID_RT_GET_TX_RETRY 0xFF010188
+#define OID_RT_GET_RX_RETRY 0xFF010189
+#define OID_RT_PRO_SET_FW_DIG_STATE 0xFF01018A
+#define OID_RT_PRO_SET_FW_RA_STATE 0xFF01018B
+#define OID_RT_GET_RX_TOTAL_PACKET 0xFF010190
+#define OID_RT_GET_TX_BEACON_OK 0xFF010191
+#define OID_RT_GET_TX_BEACON_ERR 0xFF010192
+#define OID_RT_GET_RX_ICV_ERR 0xFF010193
+#define OID_RT_SET_ENCRYPTION_ALGORITHM 0xFF010194
+#define OID_RT_SET_NO_AUTO_RESCAN 0xFF010195
+#define OID_RT_GET_PREAMBLE_MODE 0xFF010196
+#define OID_RT_GET_DRIVER_UP_DELTA_TIME 0xFF010197
+#define OID_RT_GET_AP_IP 0xFF010198
+#define OID_RT_GET_CHANNELPLAN 0xFF010199
+#define OID_RT_SET_PREAMBLE_MODE 0xFF01019A
+#define OID_RT_SET_BCN_INTVL 0xFF01019B
+#define OID_RT_GET_RF_VENDER 0xFF01019C
+#define OID_RT_DEDICATE_PROBE 0xFF01019D
+#define OID_RT_PRO_RX_FILTER_PATTERN 0xFF01019E
+#define OID_RT_GET_DCST_CURRENT_THRESHOLD 0xFF01019F
+#define OID_RT_GET_CCA_ERR 0xFF0101A0
+#define OID_RT_GET_CCA_UPGRADE_THRESHOLD 0xFF0101A1
+#define OID_RT_GET_CCA_FALLBACK_THRESHOLD 0xFF0101A2
+#define OID_RT_GET_CCA_UPGRADE_EVALUATE_TIMES 0xFF0101A3
+#define OID_RT_GET_CCA_FALLBACK_EVALUATE_TIMES 0xFF0101A4
+#define OID_RT_SET_RATE_ADAPTIVE 0xFF0101A5
+#define OID_RT_GET_DCST_EVALUATE_PERIOD 0xFF0101A5
+#define OID_RT_GET_DCST_TIME_UNIT_INDEX 0xFF0101A6
+#define OID_RT_GET_TOTAL_TX_BYTES 0xFF0101A7
+#define OID_RT_GET_TOTAL_RX_BYTES 0xFF0101A8
+#define OID_RT_CURRENT_TX_POWER_LEVEL 0xFF0101A9
+#define OID_RT_GET_ENC_KEY_MISMATCH_COUNT 0xFF0101AA
+#define OID_RT_GET_ENC_KEY_MATCH_COUNT 0xFF0101AB
+#define OID_RT_GET_CHANNEL 0xFF0101AC
+#define OID_RT_SET_CHANNELPLAN 0xFF0101AD
+#define OID_RT_GET_HARDWARE_RADIO_OFF 0xFF0101AE
+#define OID_RT_CHANNELPLAN_BY_COUNTRY 0xFF0101AF
+#define OID_RT_SCAN_AVAILABLE_BSSID 0xFF0101B0
+#define OID_RT_GET_HARDWARE_VERSION 0xFF0101B1
+#define OID_RT_GET_IS_ROAMING 0xFF0101B2
+#define OID_RT_GET_IS_PRIVACY 0xFF0101B3
+#define OID_RT_GET_KEY_MISMATCH 0xFF0101B4
+#define OID_RT_SET_RSSI_ROAM_TRAFFIC_TH 0xFF0101B5
+#define OID_RT_SET_RSSI_ROAM_SIGNAL_TH 0xFF0101B6
+#define OID_RT_RESET_LOG 0xFF0101B7
+#define OID_RT_GET_LOG 0xFF0101B8
+#define OID_RT_SET_INDICATE_HIDDEN_AP 0xFF0101B9
+#define OID_RT_GET_HEADER_FAIL 0xFF0101BA
+#define OID_RT_SUPPORTED_WIRELESS_MODE 0xFF0101BB
+#define OID_RT_GET_CHANNEL_LIST 0xFF0101BC
+#define OID_RT_GET_SCAN_IN_PROGRESS 0xFF0101BD
+#define OID_RT_GET_TX_INFO 0xFF0101BE
+#define OID_RT_RF_READ_WRITE_OFFSET 0xFF0101BF
+#define OID_RT_RF_READ_WRITE 0xFF0101C0
+#define OID_RT_FORCED_DATA_RATE 0xFF0101C1
+#define OID_RT_WIRELESS_MODE_FOR_SCAN_LIST 0xFF0101C2
+#define OID_RT_GET_BSS_WIRELESS_MODE 0xFF0101C3
+#define OID_RT_SCAN_WITH_MAGIC_PACKET 0xFF0101C4
+#define OID_RT_PRO_RX_FILTER 0xFF0111C0
+#define OID_CE_USB_WRITE_REGISTRY 0xFF0111C1
+#define OID_CE_USB_READ_REGISTRY 0xFF0111C2
+#define OID_RT_PRO_SET_INITIAL_GAIN 0xFF0111C3
+#define OID_RT_PRO_SET_BB_RF_STANDBY_MODE 0xFF0111C4
+#define OID_RT_PRO_SET_BB_RF_SHUTDOWN_MODE 0xFF0111C5
+#define OID_RT_PRO_SET_TX_CHARGE_PUMP 0xFF0111C6
+#define OID_RT_PRO_SET_RX_CHARGE_PUMP 0xFF0111C7
+#define OID_RT_PRO_RF_WRITE_REGISTRY 0xFF0111C8
+#define OID_RT_PRO_RF_READ_REGISTRY 0xFF0111C9
+#define OID_RT_PRO_QUERY_RF_TYPE 0xFF0111CA
+#define OID_RT_AP_GET_ASSOCIATED_STATION_LIST 0xFF010300
+#define OID_RT_AP_GET_CURRENT_TIME_STAMP 0xFF010301
+#define OID_RT_AP_SWITCH_INTO_AP_MODE 0xFF010302
+#define OID_RT_AP_SET_DTIM_PERIOD 0xFF010303
+#define OID_RT_AP_SUPPORTED 0xFF010304
+#define OID_RT_AP_SET_PASSPHRASE 0xFF010305
+#define OID_RT_PRO8187_WI_POLL 0xFF818780
+#define OID_RT_PRO_WRITE_BB_REG 0xFF818781
+#define OID_RT_PRO_READ_BB_REG 0xFF818782
+#define OID_RT_PRO_WRITE_RF_REG 0xFF818783
+#define OID_RT_PRO_READ_RF_REG 0xFF818784
+#define OID_RT_MH_VENDER_ID 0xFFEDC100
+#define OID_RT_PRO8711_JOIN_BSS 0xFF871100
+#define OID_RT_PRO_READ_REGISTER 0xFF871101
+#define OID_RT_PRO_WRITE_REGISTER 0xFF871102
+#define OID_RT_PRO_BURST_READ_REGISTER 0xFF871103
+#define OID_RT_PRO_BURST_WRITE_REGISTER 0xFF871104
+#define OID_RT_PRO_WRITE_TXCMD 0xFF871105
+#define OID_RT_PRO_READ16_EEPROM 0xFF871106
+#define OID_RT_PRO_WRITE16_EEPROM 0xFF871107
+#define OID_RT_PRO_H2C_SET_COMMAND 0xFF871108
+#define OID_RT_PRO_H2C_QUERY_RESULT 0xFF871109
+#define OID_RT_PRO8711_WI_POLL 0xFF87110A
+#define OID_RT_PRO8711_PKT_LOSS 0xFF87110B
+#define OID_RT_RD_ATTRIB_MEM 0xFF87110C
+#define OID_RT_WR_ATTRIB_MEM 0xFF87110D
 /*Method 2 for H2C/C2H*/
-#define OID_RT_PRO_H2C_CMD_MODE				0xFF871110
-#define OID_RT_PRO_H2C_CMD_RSP_MODE			0xFF871111
-#define OID_RT_PRO_H2C_CMD_EVENT_MODE			0xFF871112
-#define OID_RT_PRO_WAIT_C2H_EVENT			0xFF871113
-#define OID_RT_PRO_RW_ACCESS_PROTOCOL_TEST		0xFF871114
-#define OID_RT_PRO_SCSI_ACCESS_TEST			0xFF871115
-#define OID_RT_PRO_SCSI_TCPIPOFFLOAD_OUT		0xFF871116
-#define OID_RT_PRO_SCSI_TCPIPOFFLOAD_IN			0xFF871117
-#define OID_RT_RRO_RX_PKT_VIA_IOCTRL			0xFF871118
-#define OID_RT_RRO_RX_PKTARRAY_VIA_IOCTRL		0xFF871119
-#define OID_RT_RPO_SET_PWRMGT_TEST			0xFF87111A
-#define OID_RT_PRO_QRY_PWRMGT_TEST			0XFF87111B
-#define OID_RT_RPO_ASYNC_RWIO_TEST			0xFF87111C
-#define OID_RT_RPO_ASYNC_RWIO_POLL			0xFF87111D
-#define OID_RT_PRO_SET_RF_INTFS				0xFF87111E
-#define OID_RT_POLL_RX_STATUS				0xFF87111F
-#define OID_RT_PRO_CFG_DEBUG_MESSAGE			0xFF871120
-#define OID_RT_PRO_SET_DATA_RATE_EX			0xFF871121
-#define OID_RT_PRO_SET_BASIC_RATE			0xFF871122
-#define OID_RT_PRO_READ_TSSI				0xFF871123
-#define OID_RT_PRO_SET_POWER_TRACKING			0xFF871124
-#define OID_RT_PRO_QRY_PWRSTATE				0xFF871150
-#define OID_RT_PRO_SET_PWRSTATE				0xFF871151
+#define OID_RT_PRO_H2C_CMD_MODE 0xFF871110
+#define OID_RT_PRO_H2C_CMD_RSP_MODE 0xFF871111
+#define OID_RT_PRO_H2C_CMD_EVENT_MODE 0xFF871112
+#define OID_RT_PRO_WAIT_C2H_EVENT 0xFF871113
+#define OID_RT_PRO_RW_ACCESS_PROTOCOL_TEST 0xFF871114
+#define OID_RT_PRO_SCSI_ACCESS_TEST 0xFF871115
+#define OID_RT_PRO_SCSI_TCPIPOFFLOAD_OUT 0xFF871116
+#define OID_RT_PRO_SCSI_TCPIPOFFLOAD_IN 0xFF871117
+#define OID_RT_RRO_RX_PKT_VIA_IOCTRL 0xFF871118
+#define OID_RT_RRO_RX_PKTARRAY_VIA_IOCTRL 0xFF871119
+#define OID_RT_RPO_SET_PWRMGT_TEST 0xFF87111A
+#define OID_RT_PRO_QRY_PWRMGT_TEST 0XFF87111B
+#define OID_RT_RPO_ASYNC_RWIO_TEST 0xFF87111C
+#define OID_RT_RPO_ASYNC_RWIO_POLL 0xFF87111D
+#define OID_RT_PRO_SET_RF_INTFS 0xFF87111E
+#define OID_RT_POLL_RX_STATUS 0xFF87111F
+#define OID_RT_PRO_CFG_DEBUG_MESSAGE 0xFF871120
+#define OID_RT_PRO_SET_DATA_RATE_EX 0xFF871121
+#define OID_RT_PRO_SET_BASIC_RATE 0xFF871122
+#define OID_RT_PRO_READ_TSSI 0xFF871123
+#define OID_RT_PRO_SET_POWER_TRACKING 0xFF871124
+#define OID_RT_PRO_QRY_PWRSTATE 0xFF871150
+#define OID_RT_PRO_SET_PWRSTATE 0xFF871151
 /*Method 2 , using workitem */
-#define OID_RT_SET_READ_REG				0xFF871181
-#define OID_RT_SET_WRITE_REG				0xFF871182
-#define OID_RT_SET_BURST_READ_REG			0xFF871183
-#define OID_RT_SET_BURST_WRITE_REG			0xFF871184
-#define OID_RT_SET_WRITE_TXCMD				0xFF871185
-#define OID_RT_SET_READ16_EEPROM			0xFF871186
-#define OID_RT_SET_WRITE16_EEPROM			0xFF871187
-#define OID_RT_QRY_POLL_WKITEM				0xFF871188
+#define OID_RT_SET_READ_REG 0xFF871181
+#define OID_RT_SET_WRITE_REG 0xFF871182
+#define OID_RT_SET_BURST_READ_REG 0xFF871183
+#define OID_RT_SET_BURST_WRITE_REG 0xFF871184
+#define OID_RT_SET_WRITE_TXCMD 0xFF871185
+#define OID_RT_SET_READ16_EEPROM 0xFF871186
+#define OID_RT_SET_WRITE16_EEPROM 0xFF871187
+#define OID_RT_QRY_POLL_WKITEM 0xFF871188
 
 /*For SDIO INTERFACE only*/
-#define OID_RT_PRO_SYNCPAGERW_SRAM			0xFF8711A0
-#define OID_RT_PRO_871X_DRV_EXT				0xFF8711A1
+#define OID_RT_PRO_SYNCPAGERW_SRAM 0xFF8711A0
+#define OID_RT_PRO_871X_DRV_EXT 0xFF8711A1
 
 /*For USB INTERFACE only*/
-#define OID_RT_PRO_USB_VENDOR_REQ			0xFF8711B0
-#define OID_RT_PRO_SCSI_AUTO_TEST			0xFF8711B1
-#define OID_RT_PRO_USB_MAC_AC_FIFO_WRITE		0xFF8711B2
-#define OID_RT_PRO_USB_MAC_RX_FIFO_READ			0xFF8711B3
-#define OID_RT_PRO_USB_MAC_RX_FIFO_POLLING		0xFF8711B4
+#define OID_RT_PRO_USB_VENDOR_REQ 0xFF8711B0
+#define OID_RT_PRO_SCSI_AUTO_TEST 0xFF8711B1
+#define OID_RT_PRO_USB_MAC_AC_FIFO_WRITE 0xFF8711B2
+#define OID_RT_PRO_USB_MAC_RX_FIFO_READ 0xFF8711B3
+#define OID_RT_PRO_USB_MAC_RX_FIFO_POLLING 0xFF8711B4
 
-#define OID_RT_PRO_H2C_SET_RATE_TABLE			0xFF8711FB
-#define OID_RT_PRO_H2C_GET_RATE_TABLE			0xFF8711FC
-#define OID_RT_PRO_H2C_C2H_LBK_TEST			0xFF8711FE
+#define OID_RT_PRO_H2C_SET_RATE_TABLE 0xFF8711FB
+#define OID_RT_PRO_H2C_GET_RATE_TABLE 0xFF8711FC
+#define OID_RT_PRO_H2C_C2H_LBK_TEST 0xFF8711FE
 
-#define OID_RT_PRO_ENCRYPTION_CTRL			0xFF871200
-#define OID_RT_PRO_ADD_STA_INFO				0xFF871201
-#define OID_RT_PRO_DELE_STA_INFO			0xFF871202
-#define OID_RT_PRO_QUERY_DR_VARIABLE			0xFF871203
+#define OID_RT_PRO_ENCRYPTION_CTRL 0xFF871200
+#define OID_RT_PRO_ADD_STA_INFO 0xFF871201
+#define OID_RT_PRO_DELE_STA_INFO 0xFF871202
+#define OID_RT_PRO_QUERY_DR_VARIABLE 0xFF871203
 
-#define OID_RT_PRO_RX_PACKET_TYPE			0xFF871204
+#define OID_RT_PRO_RX_PACKET_TYPE 0xFF871204
 
-#define OID_RT_PRO_READ_EFUSE				0xFF871205
-#define OID_RT_PRO_WRITE_EFUSE				0xFF871206
-#define OID_RT_PRO_RW_EFUSE_PGPKT			0xFF871207
-#define OID_RT_GET_EFUSE_CURRENT_SIZE			0xFF871208
+#define OID_RT_PRO_READ_EFUSE 0xFF871205
+#define OID_RT_PRO_WRITE_EFUSE 0xFF871206
+#define OID_RT_PRO_RW_EFUSE_PGPKT 0xFF871207
+#define OID_RT_GET_EFUSE_CURRENT_SIZE 0xFF871208
 
-#define OID_RT_SET_BANDWIDTH				0xFF871209
-#define OID_RT_SET_CRYSTAL_CAP				0xFF87120A
+#define OID_RT_SET_BANDWIDTH 0xFF871209
+#define OID_RT_SET_CRYSTAL_CAP 0xFF87120A
 
-#define OID_RT_SET_RX_PACKET_TYPE			0xFF87120B
+#define OID_RT_SET_RX_PACKET_TYPE 0xFF87120B
 
-#define OID_RT_GET_EFUSE_MAX_SIZE			0xFF87120C
+#define OID_RT_GET_EFUSE_MAX_SIZE 0xFF87120C
 
-#define OID_RT_PRO_SET_TX_AGC_OFFSET			0xFF87120D
+#define OID_RT_PRO_SET_TX_AGC_OFFSET 0xFF87120D
 
-#define OID_RT_PRO_SET_PKT_TEST_MODE			0xFF87120E
+#define OID_RT_PRO_SET_PKT_TEST_MODE 0xFF87120E
 
-#define OID_RT_PRO_FOR_EVM_TEST_SETTING			0xFF87120F
+#define OID_RT_PRO_FOR_EVM_TEST_SETTING 0xFF87120F
 
-#define OID_RT_PRO_GET_THERMAL_METER			0xFF871210
+#define OID_RT_PRO_GET_THERMAL_METER 0xFF871210
 
-#define OID_RT_RESET_PHY_RX_PACKET_COUNT		0xFF871211
-#define OID_RT_GET_PHY_RX_PACKET_RECEIVED		0xFF871212
-#define OID_RT_GET_PHY_RX_PACKET_CRC32_ERROR		0xFF871213
+#define OID_RT_RESET_PHY_RX_PACKET_COUNT 0xFF871211
+#define OID_RT_GET_PHY_RX_PACKET_RECEIVED 0xFF871212
+#define OID_RT_GET_PHY_RX_PACKET_CRC32_ERROR 0xFF871213
 
-#define OID_RT_SET_POWER_DOWN				0xFF871214
+#define OID_RT_SET_POWER_DOWN 0xFF871214
 
-#define OID_RT_GET_POWER_MODE				0xFF871215
+#define OID_RT_GET_POWER_MODE 0xFF871215
 
-#define OID_RT_PRO_EFUSE				0xFF871216
-#define OID_RT_PRO_EFUSE_MAP				0xFF871217
+#define OID_RT_PRO_EFUSE 0xFF871216
+#define OID_RT_PRO_EFUSE_MAP 0xFF871217
 
 #endif /*#ifndef __CUSTOM_OID_H */
-
diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 1b11f8b04e13..eac53b3e490d 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -37,21 +37,21 @@ static int chip_version = RTL8712_2ndCUT;
 static int rfintfs = HWPI;
 static int lbkmode = RTL8712_AIR_TRX;
 static int hci = RTL8712_USB;
-static int ampdu_enable = 1;/*for enable tx_ampdu*/
+static int ampdu_enable = 1; /*for enable tx_ampdu*/
 
 /* The video_mode variable is for video mode.*/
 /* It may be specify when inserting module with video_mode=1 parameter.*/
-static int video_mode = 1;   /* enable video mode*/
+static int video_mode = 1; /* enable video mode*/
 
 /*Ndis802_11Infrastructure; infra, ad-hoc, auto*/
 static int network_mode = Ndis802_11IBSS;
-static int channel = 1;/*ad-hoc support requirement*/
+static int channel = 1; /*ad-hoc support requirement*/
 static int wireless_mode = WIRELESS_11BG;
 static int vrtl_carrier_sense = AUTO_VCS;
 static int vcs_type = RTS_CTS;
 static int frag_thresh = 2346;
-static int preamble = PREAMBLE_LONG;/*long, short, auto*/
-static int scan_mode = 1;/*active, passive*/
+static int preamble = PREAMBLE_LONG; /*long, short, auto*/
+static int scan_mode = 1; /*active, passive*/
 static int adhoc_tx_pwr = 1;
 static int soft_ap;
 static int smart_ps = 1;
@@ -65,7 +65,7 @@ static int mp_mode;
 static int software_encrypt;
 static int software_decrypt;
 
-static int wmm_enable;/* default is set to disable the wmm.*/
+static int wmm_enable; /* default is set to disable the wmm.*/
 static int uapsd_enable;
 static int uapsd_max_sp = NO_LIMIT;
 static int uapsd_acbk_en;
@@ -75,7 +75,7 @@ static int uapsd_acvo_en;
 
 static int ht_enable = 1;
 static int cbw40_enable = 1;
-static int rf_config = RTL8712_RF_1T2R;  /* 1T2R*/
+static int rf_config = RTL8712_RF_1T2R; /* 1T2R*/
 static int low_power;
 /* mac address to use instead of the one stored in Efuse */
 char *r8712_initmac;
@@ -113,15 +113,15 @@ MODULE_PARM_DESC(initmac, "MAC-Address, default: use FUSE");
 static int netdev_open(struct net_device *pnetdev);
 static int netdev_close(struct net_device *pnetdev);
 
-static void loadparam(struct _adapter *padapter, struct  net_device *pnetdev)
+static void loadparam(struct _adapter *padapter, struct net_device *pnetdev)
 {
-	struct registry_priv  *registry_par = &padapter->registrypriv;
+	struct registry_priv *registry_par = &padapter->registrypriv;
 
 	registry_par->chip_version = (u8)chip_version;
 	registry_par->rfintfs = (u8)rfintfs;
 	registry_par->lbkmode = (u8)lbkmode;
 	registry_par->hci = (u8)hci;
-	registry_par->network_mode  = (u8)network_mode;
+	registry_par->network_mode = (u8)network_mode;
 	memcpy(registry_par->ssid.Ssid, "ANY", 3);
 	registry_par->ssid.SsidLength = 3;
 	registry_par->channel = (u8)channel;
@@ -211,11 +211,11 @@ struct net_device *r8712_init_netdev(void)
 	pr_info("r8712u: register rtl8712_netdev_ops to netdev_ops\n");
 	pnetdev->netdev_ops = &rtl8712_netdev_ops;
 	pnetdev->watchdog_timeo = HZ; /* 1 second timeout */
-	pnetdev->wireless_handlers = (struct iw_handler_def *)
-				     &r871x_handlers_def;
+	pnetdev->wireless_handlers =
+		(struct iw_handler_def *)&r871x_handlers_def;
 	loadparam(padapter, pnetdev);
 	netif_carrier_off(pnetdev);
-	padapter->pid = 0;  /* Initial the PID value used for HW PBC.*/
+	padapter->pid = 0; /* Initial the PID value used for HW PBC.*/
 	return pnetdev;
 }
 
@@ -255,7 +255,8 @@ void r8712_stop_drv_timers(struct _adapter *padapter)
 	del_timer_sync(&padapter->mlmepriv.scan_to_timer);
 	del_timer_sync(&padapter->mlmepriv.dhcp_timer);
 	del_timer_sync(&padapter->mlmepriv.wdg_timer);
-	del_timer_sync(&padapter->mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer);
+	del_timer_sync(
+		&padapter->mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer);
 }
 
 static void init_default_value(struct _adapter *padapter)
@@ -277,9 +278,9 @@ static void init_default_value(struct _adapter *padapter)
 	/*ht_priv*/
 	{
 		int i;
-		struct ht_priv	 *phtpriv = &pmlmepriv->htpriv;
+		struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
-		phtpriv->ampdu_enable = false;/*set to disabled*/
+		phtpriv->ampdu_enable = false; /*set to disabled*/
 		for (i = 0; i < 16; i++)
 			phtpriv->baddbareq_issued[i] = false;
 	}
@@ -368,7 +369,7 @@ static void enable_video_mode(struct _adapter *padapter, int cbw40_value)
 	 *   1 -> enable STBC
 	 *   0 -> disable STBC
 	 */
-	u32  intcmd = 0xf4000500;   /* enable bit8, bit10*/
+	u32 intcmd = 0xf4000500; /* enable bit8, bit10*/
 
 	if (cbw40_value) {
 		/* if the driver supports the 40M bandwidth,
@@ -398,8 +399,7 @@ static int netdev_open(struct net_device *pnetdev)
 			goto netdev_open_error;
 		if (!r8712_initmac) {
 			/* Use the mac address stored in the Efuse */
-			eth_hw_addr_set(pnetdev,
-					padapter->eeprompriv.mac_addr);
+			eth_hw_addr_set(pnetdev, padapter->eeprompriv.mac_addr);
 		} else {
 			/* We have to inform f/w to use user-supplied MAC
 			 * address.
@@ -416,8 +416,8 @@ static int netdev_open(struct net_device *pnetdev)
 			 * the eeprompriv.mac_addr should store the mac which
 			 * users specify.
 			 */
-			memcpy(padapter->eeprompriv.mac_addr,
-			       pnetdev->dev_addr, ETH_ALEN);
+			memcpy(padapter->eeprompriv.mac_addr, pnetdev->dev_addr,
+			       ETH_ALEN);
 		}
 		if (start_drv_threads(padapter) != _SUCCESS)
 			goto netdev_open_error;
diff --git a/drivers/staging/rtl8712/osdep_intf.h b/drivers/staging/rtl8712/osdep_intf.h
index 9e75116c987e..fcd927dbcf27 100644
--- a/drivers/staging/rtl8712/osdep_intf.h
+++ b/drivers/staging/rtl8712/osdep_intf.h
@@ -17,7 +17,7 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#define RND4(x)	(((x >> 2) + ((x & 3) != 0)) << 2)
+#define RND4(x) (((x >> 2) + ((x & 3) != 0)) << 2)
 
 struct intf_priv {
 	u8 *intf_dev;
@@ -29,4 +29,4 @@ struct intf_priv {
 
 int r871x_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 
-#endif	/*_OSDEP_INTF_H_*/
+#endif /*_OSDEP_INTF_H_*/
diff --git a/drivers/staging/rtl8712/osdep_service.h b/drivers/staging/rtl8712/osdep_service.h
index 0d9bb42cbc58..90bae15b417e 100644
--- a/drivers/staging/rtl8712/osdep_service.h
+++ b/drivers/staging/rtl8712/osdep_service.h
@@ -14,8 +14,8 @@
 #ifndef __OSDEP_SERVICE_H_
 #define __OSDEP_SERVICE_H_
 
-#define _SUCCESS	1
-#define _FAIL		0
+#define _SUCCESS 1
+#define _FAIL 0
 
 #include <linux/spinlock.h>
 
@@ -26,22 +26,22 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <net/iw_handler.h>
-#include <linux/proc_fs.h>      /* Necessary because we use the proc fs */
+#include <linux/proc_fs.h> /* Necessary because we use the proc fs */
 
 #include "basic_types.h"
 
-struct	__queue	{
-	struct	list_head	queue;
+struct __queue {
+	struct list_head queue;
 	spinlock_t lock;
 };
 
 #define _pkt struct sk_buff
 #define _buffer unsigned char
 
-#define _init_queue(pqueue)				\
-	do {						\
-		INIT_LIST_HEAD(&((pqueue)->queue));	\
-		spin_lock_init(&((pqueue)->lock));	\
+#define _init_queue(pqueue)                         \
+	do {                                        \
+		INIT_LIST_HEAD(&((pqueue)->queue)); \
+		spin_lock_init(&((pqueue)->lock));  \
 	} while (0)
 
 static inline u32 end_of_queue_search(struct list_head *head,
@@ -57,4 +57,3 @@ static inline void flush_signals_thread(void)
 }
 
 #endif
-
diff --git a/drivers/staging/rtl8712/recv_linux.c b/drivers/staging/rtl8712/recv_linux.c
index 215fca4abb3a..53062ca0bda7 100644
--- a/drivers/staging/rtl8712/recv_linux.c
+++ b/drivers/staging/rtl8712/recv_linux.c
@@ -74,7 +74,7 @@ void r8712_handle_tkip_mic_err(struct _adapter *adapter, u8 bgroup)
 {
 	union iwreq_data wrqu;
 	struct iw_michaelmicfailure ev;
-	struct mlme_priv *mlmepriv  = &adapter->mlmepriv;
+	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
 
 	memset(&ev, 0x00, sizeof(ev));
 	if (bgroup)
@@ -93,7 +93,7 @@ void r8712_recv_indicatepkt(struct _adapter *adapter,
 			    union recv_frame *recvframe)
 {
 	struct recv_priv *recvpriv;
-	struct  __queue	*free_recv_queue;
+	struct __queue *free_recv_queue;
 	_pkt *skb;
 	struct rx_pkt_attrib *attrib = &recvframe->u.hdr.attrib;
 
@@ -105,7 +105,7 @@ void r8712_recv_indicatepkt(struct _adapter *adapter,
 	skb->data = recvframe->u.hdr.rx_data;
 	skb->len = recvframe->u.hdr.len;
 	skb_set_tail_pointer(skb, skb->len);
-	if ((attrib->tcpchk_valid == 1) && (attrib->tcp_chkrpt == 1))
+	if (attrib->tcpchk_valid == 1 && attrib->tcp_chkrpt == 1)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	else
 		skb->ip_summed = CHECKSUM_NONE;
@@ -118,16 +118,16 @@ void r8712_recv_indicatepkt(struct _adapter *adapter,
 	r8712_free_recvframe(recvframe, free_recv_queue);
 	return;
 _recv_indicatepkt_drop:
-	 /*enqueue back to free_recv_queue*/
+	/*enqueue back to free_recv_queue*/
 	if (recvframe)
 		r8712_free_recvframe(recvframe, free_recv_queue);
 	recvpriv->rx_drop++;
 }
 
-static void _r8712_reordering_ctrl_timeout_handler (struct timer_list *t)
+static void _r8712_reordering_ctrl_timeout_handler(struct timer_list *t)
 {
 	struct recv_reorder_ctrl *reorder_ctrl =
-			 from_timer(reorder_ctrl, t, reordering_ctrl_timer);
+		from_timer(reorder_ctrl, t, reordering_ctrl_timer);
 
 	r8712_reordering_ctrl_timeout_handler(reorder_ctrl);
 }
diff --git a/drivers/staging/rtl8712/rtl8712_bitdef.h b/drivers/staging/rtl8712/rtl8712_bitdef.h
index a4a687dcc2e7..383de7be7a47 100644
--- a/drivers/staging/rtl8712/rtl8712_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_bitdef.h
@@ -23,4 +23,3 @@
 #include "rtl8712_debugctrl_bitdef.h"
 
 #endif /* __RTL8712_BITDEF_H__ */
-
diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index bb7db96ed821..59adcd840228 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -42,7 +42,7 @@
 
 static void check_hw_pbc(struct _adapter *padapter)
 {
-	u8	tmp1byte;
+	u8 tmp1byte;
 
 	r8712_write8(padapter, MAC_PINMUX_CTRL, (GPIOMUX_EN | GPIOSEL_GPIO));
 	tmp1byte = r8712_read8(padapter, GPIO_IO_SEL);
@@ -55,7 +55,8 @@ static void check_hw_pbc(struct _adapter *padapter)
 		/* Here we only set bPbcPressed to true
 		 * After trigger PBC, the variable will be set to false
 		 */
-		netdev_dbg(padapter->pnetdev, "CheckPbcGPIO - PBC is pressed !!!!\n");
+		netdev_dbg(padapter->pnetdev,
+			   "CheckPbcGPIO - PBC is pressed !!!!\n");
 		/* 0 is the default value and it means the application monitors
 		 * the HW PBC doesn't provide its pid to driver.
 		 */
@@ -89,7 +90,7 @@ static void query_fw_rx_phy_status(struct _adapter *padapter)
 			val32 = 0;
 		val32 >>= 4;
 		padapter->recvpriv.fw_rssi =
-			 (u8)r8712_signal_scale_mapping(val32);
+			(u8)r8712_signal_scale_mapping(val32);
 	}
 }
 
@@ -119,7 +120,7 @@ static void r871x_internal_cmd_hdl(struct _adapter *padapter, u8 *pbuf)
 
 static u8 read_bbreg_hdl(struct _adapter *padapter, u8 *pbuf)
 {
-	struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
+	struct cmd_obj *pcmd = (struct cmd_obj *)pbuf;
 
 	r8712_free_cmd_obj(pcmd);
 	return H2C_SUCCESS;
@@ -128,7 +129,7 @@ static u8 read_bbreg_hdl(struct _adapter *padapter, u8 *pbuf)
 static u8 write_bbreg_hdl(struct _adapter *padapter, u8 *pbuf)
 {
 	void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
-	struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
+	struct cmd_obj *pcmd = (struct cmd_obj *)pbuf;
 
 	pcmd_callback = cmd_callback[pcmd->cmdcode].callback;
 	if (!pcmd_callback)
@@ -142,7 +143,7 @@ static u8 read_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
 {
 	u32 val;
 	void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
-	struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
+	struct cmd_obj *pcmd = (struct cmd_obj *)pbuf;
 
 	if (pcmd->rsp && pcmd->rspsz > 0)
 		memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
@@ -157,7 +158,7 @@ static u8 read_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
 static u8 write_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
 {
 	void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
-	struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
+	struct cmd_obj *pcmd = (struct cmd_obj *)pbuf;
 
 	pcmd_callback = cmd_callback[pcmd->cmdcode].callback;
 	if (!pcmd_callback)
@@ -169,7 +170,7 @@ static u8 write_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
 
 static u8 sys_suspend_hdl(struct _adapter *padapter, u8 *pbuf)
 {
-	struct cmd_obj *pcmd  = (struct cmd_obj *)pbuf;
+	struct cmd_obj *pcmd = (struct cmd_obj *)pbuf;
 
 	r8712_free_cmd_obj(pcmd);
 	return H2C_SUCCESS;
@@ -245,9 +246,9 @@ u8 r8712_fw_cmd(struct _adapter *pAdapter, u32 cmd)
 
 void r8712_fw_cmd_data(struct _adapter *pAdapter, u32 *value, u8 flag)
 {
-	if (flag == 0)	/* set */
+	if (flag == 0) /* set */
 		r8712_write32(pAdapter, IOCMD_DATA_REG, *value);
-	else		/* query */
+	else /* query */
 		*value = r8712_read32(pAdapter, IOCMD_DATA_REG);
 }
 
@@ -259,9 +260,8 @@ int r8712_cmd_thread(void *context)
 	struct tx_desc *pdesc;
 	void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
 	struct _adapter *padapter = context;
-	struct	cmd_priv *pcmdpriv = &padapter->cmdpriv;
-	struct completion *cmd_queue_comp =
-		&pcmdpriv->cmd_queue_comp;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+	struct completion *cmd_queue_comp = &pcmdpriv->cmd_queue_comp;
 	struct mutex *pwctrl_lock = &padapter->pwrctrlpriv.mutex_lock;
 
 	allow_signal(SIGTERM);
@@ -290,8 +290,8 @@ int r8712_cmd_thread(void *context)
 			pcmdpriv->cmd_issued_cnt++;
 			cmdsz = round_up(pcmd->cmdsz, 8);
 			wr_sz = TXDESC_SIZE + 8 + cmdsz;
-			pdesc->txdw0 |= cpu_to_le32((wr_sz - TXDESC_SIZE) &
-						     0x0000ffff);
+			pdesc->txdw0 |=
+				cpu_to_le32((wr_sz - TXDESC_SIZE) & 0x0000ffff);
 			if (pdvobj->ishighspeed) {
 				if ((wr_sz % 512) == 0)
 					blnPending = 1;
@@ -300,18 +300,19 @@ int r8712_cmd_thread(void *context)
 					blnPending = 1;
 			}
 			if (blnPending) { /* 32 bytes for TX Desc - 8 offset */
-				pdesc->txdw0 |= cpu_to_le32(((TXDESC_SIZE +
-						OFFSET_SZ + 8) << OFFSET_SHT) &
-						0x00ff0000);
+				pdesc->txdw0 |= cpu_to_le32(
+					((TXDESC_SIZE + OFFSET_SZ + 8)
+					 << OFFSET_SHT) &
+					0x00ff0000);
 			} else {
-				pdesc->txdw0 |= cpu_to_le32(((TXDESC_SIZE +
-							      OFFSET_SZ) <<
-							      OFFSET_SHT) &
-							      0x00ff0000);
+				pdesc->txdw0 |=
+					cpu_to_le32(((TXDESC_SIZE + OFFSET_SZ)
+						     << OFFSET_SHT) &
+						    0x00ff0000);
 			}
 			pdesc->txdw0 |= cpu_to_le32(OWN | FSG | LSG);
-			pdesc->txdw1 |= cpu_to_le32((0x13 << QSEL_SHT) &
-						    0x00001f00);
+			pdesc->txdw1 |=
+				cpu_to_le32((0x13 << QSEL_SHT) & 0x00001f00);
 			pcmdbuf += (TXDESC_SIZE >> 2);
 			*pcmdbuf = cpu_to_le32((cmdsz & 0x0000ffff) |
 					       (pcmd->cmdcode << 16) |
@@ -319,7 +320,7 @@ int r8712_cmd_thread(void *context)
 			pcmdbuf += 2; /* 8 bytes alignment */
 			memcpy((u8 *)pcmdbuf, pcmd->parmbuf, pcmd->cmdsz);
 			if (blnPending)
-				wr_sz += 8;   /* Append 8 bytes */
+				wr_sz += 8; /* Append 8 bytes */
 			r8712_write_mem(padapter, RTL8712_DMA_H2CCMD, wr_sz,
 					(u8 *)pdesc);
 			pcmdpriv->cmd_seq++;
@@ -365,7 +366,7 @@ void r8712_event_handle(struct _adapter *padapter, __le32 *peventbuf)
 	u8 evt_code, evt_seq;
 	u16 evt_sz;
 	void (*event_callback)(struct _adapter *dev, u8 *pbuf);
-	struct	evt_priv *pevt_priv = &padapter->evtpriv;
+	struct evt_priv *pevt_priv = &padapter->evtpriv;
 
 	if (!peventbuf)
 		goto _abort_event_;
@@ -387,15 +388,15 @@ void r8712_event_handle(struct _adapter *padapter, __le32 *peventbuf)
 		goto _abort_event_;
 	}
 	/* checking if event size match the event parm size */
-	if ((wlanevents[evt_code].parmsize) &&
-	    (wlanevents[evt_code].parmsize != evt_sz)) {
+	if (wlanevents[evt_code].parmsize &&
+	    wlanevents[evt_code].parmsize != evt_sz) {
 		pevt_priv->event_seq = ((evt_seq + 1) & 0x7f);
 		goto _abort_event_;
 	} else if ((evt_sz == 0) && (evt_code != GEN_EVT_CODE(_WPS_PBC))) {
 		pevt_priv->event_seq = ((evt_seq + 1) & 0x7f);
 		goto _abort_event_;
 	}
-	pevt_priv->event_seq++;	/* update evt_seq */
+	pevt_priv->event_seq++; /* update evt_seq */
 	if (pevt_priv->event_seq > 127)
 		pevt_priv->event_seq = 0;
 	/* move to event content, 8 bytes alignment */
diff --git a/drivers/staging/rtl8712/rtl8712_cmd.h b/drivers/staging/rtl8712/rtl8712_cmd.h
index a34d0dd023f3..8533f942e50b 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.h
+++ b/drivers/staging/rtl8712/rtl8712_cmd.h
@@ -14,7 +14,7 @@
 #ifndef __RTL8712_CMD_H_
 #define __RTL8712_CMD_H_
 
-#define CMD_HDR_SZ      8
+#define CMD_HDR_SZ 8
 
 u8 r8712_fw_cmd(struct _adapter *pAdapter, u32 cmd);
 void r8712_fw_cmd_data(struct _adapter *pAdapter, u32 *value, u8 flag);
@@ -25,7 +25,7 @@ struct cmd_hdr {
 };
 
 enum rtl8712_h2c_cmd {
-	GEN_CMD_CODE(_Read_MACREG),	/*0*/
+	GEN_CMD_CODE(_Read_MACREG), /*0*/
 	GEN_CMD_CODE(_Write_MACREG),
 	GEN_CMD_CODE(_Read_BBREG),
 	GEN_CMD_CODE(_Write_BBREG),
@@ -36,18 +36,18 @@ enum rtl8712_h2c_cmd {
 	GEN_CMD_CODE(_Read_EFUSE),
 	GEN_CMD_CODE(_Write_EFUSE),
 
-	GEN_CMD_CODE(_Read_CAM),	/*10*/
+	GEN_CMD_CODE(_Read_CAM), /*10*/
 	GEN_CMD_CODE(_Write_CAM),
 	GEN_CMD_CODE(_setBCNITV),
 	GEN_CMD_CODE(_setMBIDCFG),
-	GEN_CMD_CODE(_JoinBss),   /*14*/
+	GEN_CMD_CODE(_JoinBss), /*14*/
 	GEN_CMD_CODE(_DisConnect), /*15*/
 	GEN_CMD_CODE(_CreateBss),
 	GEN_CMD_CODE(_SetOpMode),
-	GEN_CMD_CODE(_SiteSurvey),  /*18*/
+	GEN_CMD_CODE(_SiteSurvey), /*18*/
 	GEN_CMD_CODE(_SetAuth),
 
-	GEN_CMD_CODE(_SetKey),	/*20*/
+	GEN_CMD_CODE(_SetKey), /*20*/
 	GEN_CMD_CODE(_SetStaKey),
 	GEN_CMD_CODE(_SetAssocSta),
 	GEN_CMD_CODE(_DelAssocSta),
@@ -58,7 +58,7 @@ enum rtl8712_h2c_cmd {
 	GEN_CMD_CODE(_GetDataRate),
 	GEN_CMD_CODE(_SetPhyInfo),
 
-	GEN_CMD_CODE(_GetPhyInfo),	/*30*/
+	GEN_CMD_CODE(_GetPhyInfo), /*30*/
 	GEN_CMD_CODE(_SetPhy),
 	GEN_CMD_CODE(_GetPhy),
 	GEN_CMD_CODE(_readRssi),
@@ -77,7 +77,7 @@ enum rtl8712_h2c_cmd {
 	GEN_CMD_CODE(_AddBAReq), /*45*/
 
 	GEN_CMD_CODE(_SetChannel), /*46*/
-/* MP_OFFLOAD Start (47~54)*/
+	/* MP_OFFLOAD Start (47~54)*/
 	GEN_CMD_CODE(_SetTxPower),
 	GEN_CMD_CODE(_SwitchAntenna),
 	GEN_CMD_CODE(_SetCrystalCap),
@@ -86,7 +86,7 @@ enum rtl8712_h2c_cmd {
 	GEN_CMD_CODE(_SetCarrierSuppressionTx),
 	GEN_CMD_CODE(_SetContinuousTx),
 	GEN_CMD_CODE(_SwitchBandwidth), /*54*/
-/* MP_OFFLOAD End*/
+	/* MP_OFFLOAD End*/
 	GEN_CMD_CODE(_TX_Beacon), /*55*/
 	GEN_CMD_CODE(_SetPowerTracking),
 	GEN_CMD_CODE(_AMSDU_TO_AMPDU), /*57*/
@@ -108,10 +108,10 @@ enum rtl8712_h2c_cmd {
 	/* the following is driver will do */
 	GEN_CMD_CODE(_GetCurDataRate),
 
-	GEN_CMD_CODE(_GetTxRetrycnt),  /* to record times that Tx retry to
+	GEN_CMD_CODE(_GetTxRetrycnt), /* to record times that Tx retry to
 					* transmit packet after association
 					*/
-	GEN_CMD_CODE(_GetRxRetrycnt),  /* to record total number of the
+	GEN_CMD_CODE(_GetRxRetrycnt), /* to record total number of the
 					* received frame with ReTry bit set in
 					* the WLAN header
 					*/
@@ -128,103 +128,103 @@ enum rtl8712_h2c_cmd {
 	MAX_H2CCMD
 };
 
-#define _GetBBReg_CMD_		_Read_BBREG_CMD_
-#define _SetBBReg_CMD_		_Write_BBREG_CMD_
-#define _GetRFReg_CMD_		_Read_RFREG_CMD_
-#define _SetRFReg_CMD_		_Write_RFREG_CMD_
-#define _DRV_INT_CMD_		(MAX_H2CCMD + 1)
-#define _SetRFIntFs_CMD_	(MAX_H2CCMD + 2)
+#define _GetBBReg_CMD_ _Read_BBREG_CMD_
+#define _SetBBReg_CMD_ _Write_BBREG_CMD_
+#define _GetRFReg_CMD_ _Read_RFREG_CMD_
+#define _SetRFReg_CMD_ _Write_RFREG_CMD_
+#define _DRV_INT_CMD_ (MAX_H2CCMD + 1)
+#define _SetRFIntFs_CMD_ (MAX_H2CCMD + 2)
 
 #ifdef _RTL8712_CMD_C_
-static struct _cmd_callback	cmd_callback[] = {
-	{GEN_CMD_CODE(_Read_MACREG), NULL}, /*0*/
-	{GEN_CMD_CODE(_Write_MACREG), NULL},
-	{GEN_CMD_CODE(_Read_BBREG), NULL},
-	{GEN_CMD_CODE(_Write_BBREG), NULL},
-	{GEN_CMD_CODE(_Read_RFREG), &r8712_getbbrfreg_cmdrsp_callback},
-	{GEN_CMD_CODE(_Write_RFREG), NULL}, /*5*/
-	{GEN_CMD_CODE(_Read_EEPROM), NULL},
-	{GEN_CMD_CODE(_Write_EEPROM), NULL},
-	{GEN_CMD_CODE(_Read_EFUSE), NULL},
-	{GEN_CMD_CODE(_Write_EFUSE), NULL},
-
-	{GEN_CMD_CODE(_Read_CAM),	NULL},	/*10*/
-	{GEN_CMD_CODE(_Write_CAM),	 NULL},
-	{GEN_CMD_CODE(_setBCNITV), NULL},
-	{GEN_CMD_CODE(_setMBIDCFG), NULL},
-	{GEN_CMD_CODE(_JoinBss), &r8712_joinbss_cmd_callback},  /*14*/
-	{GEN_CMD_CODE(_DisConnect), &r8712_disassoc_cmd_callback}, /*15*/
-	{GEN_CMD_CODE(_CreateBss), &r8712_createbss_cmd_callback},
-	{GEN_CMD_CODE(_SetOpMode), NULL},
-	{GEN_CMD_CODE(_SiteSurvey), &r8712_survey_cmd_callback}, /*18*/
-	{GEN_CMD_CODE(_SetAuth), NULL},
-
-	{GEN_CMD_CODE(_SetKey), NULL},	/*20*/
-	{GEN_CMD_CODE(_SetStaKey), &r8712_setstaKey_cmdrsp_callback},
-	{GEN_CMD_CODE(_SetAssocSta), &r8712_setassocsta_cmdrsp_callback},
-	{GEN_CMD_CODE(_DelAssocSta), NULL},
-	{GEN_CMD_CODE(_SetStaPwrState), NULL},
-	{GEN_CMD_CODE(_SetBasicRate), NULL}, /*25*/
-	{GEN_CMD_CODE(_GetBasicRate), NULL},
-	{GEN_CMD_CODE(_SetDataRate), NULL},
-	{GEN_CMD_CODE(_GetDataRate), NULL},
-	{GEN_CMD_CODE(_SetPhyInfo), NULL},
-
-	{GEN_CMD_CODE(_GetPhyInfo), NULL}, /*30*/
-	{GEN_CMD_CODE(_SetPhy), NULL},
-	{GEN_CMD_CODE(_GetPhy), NULL},
-	{GEN_CMD_CODE(_readRssi), NULL},
-	{GEN_CMD_CODE(_readGain), NULL},
-	{GEN_CMD_CODE(_SetAtim), NULL}, /*35*/
-	{GEN_CMD_CODE(_SetPwrMode), NULL},
-	{GEN_CMD_CODE(_JoinbssRpt), NULL},
-	{GEN_CMD_CODE(_SetRaTable), NULL},
-	{GEN_CMD_CODE(_GetRaTable), NULL},
-
-	{GEN_CMD_CODE(_GetCCXReport), NULL}, /*40*/
-	{GEN_CMD_CODE(_GetDTMReport),	NULL},
-	{GEN_CMD_CODE(_GetTXRateStatistics), NULL},
-	{GEN_CMD_CODE(_SetUsbSuspend), NULL},
-	{GEN_CMD_CODE(_SetH2cLbk), NULL},
-	{GEN_CMD_CODE(_AddBAReq), NULL}, /*45*/
-
-	{GEN_CMD_CODE(_SetChannel), NULL},		/*46*/
-/* MP_OFFLOAD Start (47~54)*/
-	{GEN_CMD_CODE(_SetTxPower), NULL},
-	{GEN_CMD_CODE(_SwitchAntenna), NULL},
-	{GEN_CMD_CODE(_SetCrystalCap), NULL},
-	{GEN_CMD_CODE(_SetSingleCarrierTx), NULL},	/*50*/
-	{GEN_CMD_CODE(_SetSingleToneTx), NULL},
-	{GEN_CMD_CODE(_SetCarrierSuppressionTx), NULL},
-	{GEN_CMD_CODE(_SetContinuousTx), NULL},
-	{GEN_CMD_CODE(_SwitchBandwidth), NULL},		/*54*/
-/* MP_OFFLOAD End*/
-	{GEN_CMD_CODE(_TX_Beacon), NULL}, /*55*/
-	{GEN_CMD_CODE(_SetPowerTracking), NULL},
-	{GEN_CMD_CODE(_AMSDU_TO_AMPDU), NULL}, /*57*/
-	{GEN_CMD_CODE(_SetMacAddress), NULL}, /*58*/
-
-	{GEN_CMD_CODE(_DisconnectCtrl), NULL}, /*59*/
-	{GEN_CMD_CODE(_SetChannelPlan), NULL}, /*60*/
-	{GEN_CMD_CODE(_DisconnectCtrlEx), NULL}, /*61*/
+static struct _cmd_callback cmd_callback[] = {
+	{ GEN_CMD_CODE(_Read_MACREG), NULL }, /*0*/
+	{ GEN_CMD_CODE(_Write_MACREG), NULL },
+	{ GEN_CMD_CODE(_Read_BBREG), NULL },
+	{ GEN_CMD_CODE(_Write_BBREG), NULL },
+	{ GEN_CMD_CODE(_Read_RFREG), &r8712_getbbrfreg_cmdrsp_callback },
+	{ GEN_CMD_CODE(_Write_RFREG), NULL }, /*5*/
+	{ GEN_CMD_CODE(_Read_EEPROM), NULL },
+	{ GEN_CMD_CODE(_Write_EEPROM), NULL },
+	{ GEN_CMD_CODE(_Read_EFUSE), NULL },
+	{ GEN_CMD_CODE(_Write_EFUSE), NULL },
+
+	{ GEN_CMD_CODE(_Read_CAM), NULL }, /*10*/
+	{ GEN_CMD_CODE(_Write_CAM), NULL },
+	{ GEN_CMD_CODE(_setBCNITV), NULL },
+	{ GEN_CMD_CODE(_setMBIDCFG), NULL },
+	{ GEN_CMD_CODE(_JoinBss), &r8712_joinbss_cmd_callback }, /*14*/
+	{ GEN_CMD_CODE(_DisConnect), &r8712_disassoc_cmd_callback }, /*15*/
+	{ GEN_CMD_CODE(_CreateBss), &r8712_createbss_cmd_callback },
+	{ GEN_CMD_CODE(_SetOpMode), NULL },
+	{ GEN_CMD_CODE(_SiteSurvey), &r8712_survey_cmd_callback }, /*18*/
+	{ GEN_CMD_CODE(_SetAuth), NULL },
+
+	{ GEN_CMD_CODE(_SetKey), NULL }, /*20*/
+	{ GEN_CMD_CODE(_SetStaKey), &r8712_setstaKey_cmdrsp_callback },
+	{ GEN_CMD_CODE(_SetAssocSta), &r8712_setassocsta_cmdrsp_callback },
+	{ GEN_CMD_CODE(_DelAssocSta), NULL },
+	{ GEN_CMD_CODE(_SetStaPwrState), NULL },
+	{ GEN_CMD_CODE(_SetBasicRate), NULL }, /*25*/
+	{ GEN_CMD_CODE(_GetBasicRate), NULL },
+	{ GEN_CMD_CODE(_SetDataRate), NULL },
+	{ GEN_CMD_CODE(_GetDataRate), NULL },
+	{ GEN_CMD_CODE(_SetPhyInfo), NULL },
+
+	{ GEN_CMD_CODE(_GetPhyInfo), NULL }, /*30*/
+	{ GEN_CMD_CODE(_SetPhy), NULL },
+	{ GEN_CMD_CODE(_GetPhy), NULL },
+	{ GEN_CMD_CODE(_readRssi), NULL },
+	{ GEN_CMD_CODE(_readGain), NULL },
+	{ GEN_CMD_CODE(_SetAtim), NULL }, /*35*/
+	{ GEN_CMD_CODE(_SetPwrMode), NULL },
+	{ GEN_CMD_CODE(_JoinbssRpt), NULL },
+	{ GEN_CMD_CODE(_SetRaTable), NULL },
+	{ GEN_CMD_CODE(_GetRaTable), NULL },
+
+	{ GEN_CMD_CODE(_GetCCXReport), NULL }, /*40*/
+	{ GEN_CMD_CODE(_GetDTMReport), NULL },
+	{ GEN_CMD_CODE(_GetTXRateStatistics), NULL },
+	{ GEN_CMD_CODE(_SetUsbSuspend), NULL },
+	{ GEN_CMD_CODE(_SetH2cLbk), NULL },
+	{ GEN_CMD_CODE(_AddBAReq), NULL }, /*45*/
+
+	{ GEN_CMD_CODE(_SetChannel), NULL }, /*46*/
+	/* MP_OFFLOAD Start (47~54)*/
+	{ GEN_CMD_CODE(_SetTxPower), NULL },
+	{ GEN_CMD_CODE(_SwitchAntenna), NULL },
+	{ GEN_CMD_CODE(_SetCrystalCap), NULL },
+	{ GEN_CMD_CODE(_SetSingleCarrierTx), NULL }, /*50*/
+	{ GEN_CMD_CODE(_SetSingleToneTx), NULL },
+	{ GEN_CMD_CODE(_SetCarrierSuppressionTx), NULL },
+	{ GEN_CMD_CODE(_SetContinuousTx), NULL },
+	{ GEN_CMD_CODE(_SwitchBandwidth), NULL }, /*54*/
+	/* MP_OFFLOAD End*/
+	{ GEN_CMD_CODE(_TX_Beacon), NULL }, /*55*/
+	{ GEN_CMD_CODE(_SetPowerTracking), NULL },
+	{ GEN_CMD_CODE(_AMSDU_TO_AMPDU), NULL }, /*57*/
+	{ GEN_CMD_CODE(_SetMacAddress), NULL }, /*58*/
+
+	{ GEN_CMD_CODE(_DisconnectCtrl), NULL }, /*59*/
+	{ GEN_CMD_CODE(_SetChannelPlan), NULL }, /*60*/
+	{ GEN_CMD_CODE(_DisconnectCtrlEx), NULL }, /*61*/
 
 	/* To do, modify these h2c cmd, add or delete */
-	{GEN_CMD_CODE(_GetH2cLbk), NULL},
-
-	{_SetProbeReqExtraIE_CMD_, NULL},
-	{_SetAssocReqExtraIE_CMD_, NULL},
-	{_SetProbeRspExtraIE_CMD_, NULL},
-	{_SetAssocRspExtraIE_CMD_, NULL},
-	{_GetCurDataRate_CMD_, NULL},
-	{_GetTxRetrycnt_CMD_, NULL},
-	{_GetRxRetrycnt_CMD_, NULL},
-	{_GetBCNOKcnt_CMD_, NULL},
-	{_GetBCNERRcnt_CMD_, NULL},
-	{_GetCurTxPwrLevel_CMD_, NULL},
-	{_SetDIG_CMD_, NULL},
-	{_SetRA_CMD_, NULL},
-	{_SetPT_CMD_, NULL},
-	{GEN_CMD_CODE(_ReadTSSI), &r8712_readtssi_cmdrsp_callback}
+	{ GEN_CMD_CODE(_GetH2cLbk), NULL },
+
+	{ _SetProbeReqExtraIE_CMD_, NULL },
+	{ _SetAssocReqExtraIE_CMD_, NULL },
+	{ _SetProbeRspExtraIE_CMD_, NULL },
+	{ _SetAssocRspExtraIE_CMD_, NULL },
+	{ _GetCurDataRate_CMD_, NULL },
+	{ _GetTxRetrycnt_CMD_, NULL },
+	{ _GetRxRetrycnt_CMD_, NULL },
+	{ _GetBCNOKcnt_CMD_, NULL },
+	{ _GetBCNERRcnt_CMD_, NULL },
+	{ _GetCurTxPwrLevel_CMD_, NULL },
+	{ _SetDIG_CMD_, NULL },
+	{ _SetRA_CMD_, NULL },
+	{ _SetPT_CMD_, NULL },
+	{ GEN_CMD_CODE(_ReadTSSI), &r8712_readtssi_cmdrsp_callback }
 };
 #endif
 
diff --git a/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
index 68bdec07f51e..da651201c25c 100644
--- a/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
@@ -13,83 +13,82 @@
 /*--------------------------------------------------------------------------*/
 /*       8192S (CMD) command register bits	(Offset 0x40, 16 bits)*/
 /*--------------------------------------------------------------------------*/
-#define		_APSDOFF_STATUS		BIT(15)
-#define		_APSDOFF		BIT(14)
-#define		_BBRSTn			BIT(13)  /*Enable OFDM/CCK*/
-#define		_BB_GLB_RSTn		BIT(12)   /*Enable BB*/
-#define		_SCHEDULE_EN		BIT(10)  /*Enable MAC scheduler*/
-#define		_MACRXEN		BIT(9)
-#define		_MACTXEN		BIT(8)
-#define		_DDMA_EN		BIT(7)  /*FW off load function enable*/
-#define		_FW2HW_EN		BIT(6)  /*MAC every module reset */
-#define		_RXDMA_EN		BIT(5)
-#define		_TXDMA_EN		BIT(4)
-#define		_HCI_RXDMA_EN		BIT(3)
-#define		_HCI_TXDMA_EN		BIT(2)
+#define _APSDOFF_STATUS BIT(15)
+#define _APSDOFF BIT(14)
+#define _BBRSTn BIT(13) /*Enable OFDM/CCK*/
+#define _BB_GLB_RSTn BIT(12) /*Enable BB*/
+#define _SCHEDULE_EN BIT(10) /*Enable MAC scheduler*/
+#define _MACRXEN BIT(9)
+#define _MACTXEN BIT(8)
+#define _DDMA_EN BIT(7) /*FW off load function enable*/
+#define _FW2HW_EN BIT(6) /*MAC every module reset */
+#define _RXDMA_EN BIT(5)
+#define _TXDMA_EN BIT(4)
+#define _HCI_RXDMA_EN BIT(3)
+#define _HCI_TXDMA_EN BIT(2)
 
 /*TXPAUSE*/
-#define	_STOPHCCA			BIT(6)
-#define	_STOPHIGH			BIT(5)
-#define	_STOPMGT			BIT(4)
-#define	_STOPVO				BIT(3)
-#define	_STOPVI				BIT(2)
-#define	_STOPBE				BIT(1)
-#define	_STOPBK				BIT(0)
+#define _STOPHCCA BIT(6)
+#define _STOPHIGH BIT(5)
+#define _STOPMGT BIT(4)
+#define _STOPVO BIT(3)
+#define _STOPVI BIT(2)
+#define _STOPBE BIT(1)
+#define _STOPBK BIT(0)
 
 /*TCR*/
-#define	_DISCW				BIT(20)
-#define	_ICV				BIT(19)
-#define	_CFEND_FMT			BIT(17)
-#define	_CRC				BIT(16)
-#define	_FWRDY				BIT(7)
-#define _BASECHG			BIT(6)
-#define	_IMEM_RDY			BIT(5)
-#define _DMEM_CODE_DONE			BIT(4)
-#define _EMEM_CHK_RPT			BIT(3)
-#define _EMEM_CODE_DONE			BIT(2)
-#define _IMEM_CHK_RPT			BIT(1)
-#define _IMEM_CODE_DONE			BIT(0)
+#define _DISCW BIT(20)
+#define _ICV BIT(19)
+#define _CFEND_FMT BIT(17)
+#define _CRC BIT(16)
+#define _FWRDY BIT(7)
+#define _BASECHG BIT(6)
+#define _IMEM_RDY BIT(5)
+#define _DMEM_CODE_DONE BIT(4)
+#define _EMEM_CHK_RPT BIT(3)
+#define _EMEM_CODE_DONE BIT(2)
+#define _IMEM_CHK_RPT BIT(1)
+#define _IMEM_CODE_DONE BIT(0)
 
-#define	_TXDMA_INIT_VALUE	(_IMEM_CHK_RPT | _EMEM_CHK_RPT)
+#define _TXDMA_INIT_VALUE (_IMEM_CHK_RPT | _EMEM_CHK_RPT)
 
 /*RCR*/
-#define	_ENMBID				BIT(27)
-#define	_APP_PHYST_RXFF			BIT(25)
-#define	_APP_PHYST_STAFF		BIT(24)
-#define	_CBSSID				BIT(23)
-#define	_APWRMGT			BIT(22)
-#define	_ADD3				BIT(21)
-#define	_AMF				BIT(20)
-#define	_ACF				BIT(19)
-#define	_ADF				BIT(18)
-#define	_APP_MIC			BIT(17)
-#define	_APP_ICV			BIT(16)
-#define	_RXFTH_MSK			0x0000E000
-#define	_RXFTH_SHT			13
-#define	_AICV				BIT(12)
-#define	_RXPKTLMT_MSK			0x00000FC0
-#define	_RXPKTLMT_SHT			6
-#define	_ACRC32				BIT(5)
-#define	_AB				BIT(3)
-#define	_AM				BIT(2)
-#define	_APM				BIT(1)
-#define	_AAP				BIT(0)
+#define _ENMBID BIT(27)
+#define _APP_PHYST_RXFF BIT(25)
+#define _APP_PHYST_STAFF BIT(24)
+#define _CBSSID BIT(23)
+#define _APWRMGT BIT(22)
+#define _ADD3 BIT(21)
+#define _AMF BIT(20)
+#define _ACF BIT(19)
+#define _ADF BIT(18)
+#define _APP_MIC BIT(17)
+#define _APP_ICV BIT(16)
+#define _RXFTH_MSK 0x0000E000
+#define _RXFTH_SHT 13
+#define _AICV BIT(12)
+#define _RXPKTLMT_MSK 0x00000FC0
+#define _RXPKTLMT_SHT 6
+#define _ACRC32 BIT(5)
+#define _AB BIT(3)
+#define _AM BIT(2)
+#define _APM BIT(1)
+#define _AAP BIT(0)
 
 /*MSR*/
-#define	_NETTYPE_MSK			0x03
-#define	_NETTYPE_SHT			0
+#define _NETTYPE_MSK 0x03
+#define _NETTYPE_SHT 0
 
 /*BT*/
-#define _BTMODE_MSK			0x06
-#define _BTMODE_SHT			1
-#define _ENBT				BIT(0)
+#define _BTMODE_MSK 0x06
+#define _BTMODE_SHT 1
+#define _ENBT BIT(0)
 
 /*MBIDCTRL*/
-#define	_ENMBID_MODE			BIT(15)
-#define	_BCNNO_MSK			0x7000
-#define	_BCNNO_SHT			12
-#define	_BCNSPACE_MSK			0x0FFF
-#define	_BCNSPACE_SHT			0
+#define _ENMBID_MODE BIT(15)
+#define _BCNNO_MSK 0x7000
+#define _BCNNO_SHT 12
+#define _BCNSPACE_MSK 0x0FFF
+#define _BCNSPACE_SHT 0
 
 #endif /* __RTL8712_CMDCTRL_BITDEF_H__*/
-
diff --git a/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h b/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h
index fc67771c89b7..c13ad90d2920 100644
--- a/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h
@@ -7,13 +7,12 @@
 #ifndef __RTL8712_CMDCTRL_REGDEF_H__
 #define __RTL8712_CMDCTRL_REGDEF_H__
 
-#define CR			(RTL8712_CMDCTRL_ + 0x0000)
-#define TXPAUSE			(RTL8712_CMDCTRL_ + 0x0002)
-#define TCR			(RTL8712_CMDCTRL_ + 0x0004)
-#define RCR			(RTL8712_CMDCTRL_ + 0x0008)
-#define MSR			(RTL8712_CMDCTRL_ + 0x000C)
-#define SYSF_CFG		(RTL8712_CMDCTRL_ + 0x000D)
-#define MBIDCTRL		(RTL8712_CMDCTRL_ + 0x000E)
+#define CR (RTL8712_CMDCTRL_ + 0x0000)
+#define TXPAUSE (RTL8712_CMDCTRL_ + 0x0002)
+#define TCR (RTL8712_CMDCTRL_ + 0x0004)
+#define RCR (RTL8712_CMDCTRL_ + 0x0008)
+#define MSR (RTL8712_CMDCTRL_ + 0x000C)
+#define SYSF_CFG (RTL8712_CMDCTRL_ + 0x000D)
+#define MBIDCTRL (RTL8712_CMDCTRL_ + 0x000E)
 
 #endif /* __RTL8712_CMDCTRL_REGDEF_H__ */
-
diff --git a/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h
index bb3863467f0d..0624113d557e 100644
--- a/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h
@@ -8,34 +8,34 @@
 #define __RTL8712_DEBUGCTRL_BITDEF_H__
 
 /*BIST*/
-#define	_BIST_RST			BIT(0)
+#define _BIST_RST BIT(0)
 
 /*LMS*/
-#define	_LMS_MSK			0x03
+#define _LMS_MSK 0x03
 
 /*WDG_CTRL*/
-#define	_OVSEL_MSK			0x0600
-#define	_OVSEL_SHT			9
-#define	_WDGCLR				BIT(8)
-#define	_WDGEN_MSK			0x00FF
-#define	_WDGEN_SHT			0
+#define _OVSEL_MSK 0x0600
+#define _OVSEL_SHT 9
+#define _WDGCLR BIT(8)
+#define _WDGEN_MSK 0x00FF
+#define _WDGEN_SHT 0
 
 /*INTM*/
-#define	_TXTIMER_MSK		0xF000
-#define	_TXTIMER_SHT		12
-#define	_TXNUM_MSK			0x0F00
-#define	_TXNUM_SHT			8
-#define	_RXTIMER_MSK		0x00F0
-#define	_RXTIMER_SHT		4
-#define	_RXNUM_MSK			0x000F
-#define	_RXNUM_SHT			0
+#define _TXTIMER_MSK 0xF000
+#define _TXTIMER_SHT 12
+#define _TXNUM_MSK 0x0F00
+#define _TXNUM_SHT 8
+#define _RXTIMER_MSK 0x00F0
+#define _RXTIMER_SHT 4
+#define _RXNUM_MSK 0x000F
+#define _RXNUM_SHT 0
 
 /*FDLOCKTURN0*/
 /*FDLOCKTURN1*/
-#define	_TURN1				BIT(0)
+#define _TURN1 BIT(0)
 
 /*FDLOCKFLAG0*/
 /*FDLOCKFLAG1*/
-#define	_LOCKFLAG1_MSK		0x03
+#define _LOCKFLAG1_MSK 0x03
 
 #endif /* __RTL8712_DEBUGCTRL_BITDEF_H__ */
diff --git a/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h b/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h
index 319220e9d53d..c19a2a2730ff 100644
--- a/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h
@@ -7,26 +7,25 @@
 #ifndef __RTL8712_DEBUGCTRL_REGDEF_H__
 #define __RTL8712_DEBUGCTRL_REGDEF_H__
 
-#define BIST			(RTL8712_DEBUGCTRL_ + 0x00)
-#define DBS			(RTL8712_DEBUGCTRL_ + 0x04)
-#define LMS			(RTL8712_DEBUGCTRL_ + 0x05)
-#define CPUINST			(RTL8712_DEBUGCTRL_ + 0x08)
-#define CPUCAUSE		(RTL8712_DEBUGCTRL_ + 0x0C)
-#define LBUS_ERR_ADDR		(RTL8712_DEBUGCTRL_ + 0x10)
-#define LBUS_ERR_CMD		(RTL8712_DEBUGCTRL_ + 0x14)
-#define LBUS_ERR_DATA_L		(RTL8712_DEBUGCTRL_ + 0x18)
-#define LBUS_ERR_DATA_H		(RTL8712_DEBUGCTRL_ + 0x1C)
-#define LBUS_EXCEPTION_ADDR	(RTL8712_DEBUGCTRL_ + 0x20)
-#define WDG_CTRL		(RTL8712_DEBUGCTRL_ + 0x24)
-#define INTMTU			(RTL8712_DEBUGCTRL_ + 0x28)
-#define INTM			(RTL8712_DEBUGCTRL_ + 0x2A)
-#define FDLOCKTURN0		(RTL8712_DEBUGCTRL_ + 0x2C)
-#define FDLOCKTURN1		(RTL8712_DEBUGCTRL_ + 0x2D)
-#define FDLOCKFLAG0		(RTL8712_DEBUGCTRL_ + 0x2E)
-#define FDLOCKFLAG1		(RTL8712_DEBUGCTRL_ + 0x2F)
-#define TRXPKTBUF_DBG_DATA	(RTL8712_DEBUGCTRL_ + 0x30)
-#define TRXPKTBUF_DBG_CTRL	(RTL8712_DEBUGCTRL_ + 0x38)
-#define DPLL_MON		(RTL8712_DEBUGCTRL_ + 0x3A)
+#define BIST (RTL8712_DEBUGCTRL_ + 0x00)
+#define DBS (RTL8712_DEBUGCTRL_ + 0x04)
+#define LMS (RTL8712_DEBUGCTRL_ + 0x05)
+#define CPUINST (RTL8712_DEBUGCTRL_ + 0x08)
+#define CPUCAUSE (RTL8712_DEBUGCTRL_ + 0x0C)
+#define LBUS_ERR_ADDR (RTL8712_DEBUGCTRL_ + 0x10)
+#define LBUS_ERR_CMD (RTL8712_DEBUGCTRL_ + 0x14)
+#define LBUS_ERR_DATA_L (RTL8712_DEBUGCTRL_ + 0x18)
+#define LBUS_ERR_DATA_H (RTL8712_DEBUGCTRL_ + 0x1C)
+#define LBUS_EXCEPTION_ADDR (RTL8712_DEBUGCTRL_ + 0x20)
+#define WDG_CTRL (RTL8712_DEBUGCTRL_ + 0x24)
+#define INTMTU (RTL8712_DEBUGCTRL_ + 0x28)
+#define INTM (RTL8712_DEBUGCTRL_ + 0x2A)
+#define FDLOCKTURN0 (RTL8712_DEBUGCTRL_ + 0x2C)
+#define FDLOCKTURN1 (RTL8712_DEBUGCTRL_ + 0x2D)
+#define FDLOCKFLAG0 (RTL8712_DEBUGCTRL_ + 0x2E)
+#define FDLOCKFLAG1 (RTL8712_DEBUGCTRL_ + 0x2F)
+#define TRXPKTBUF_DBG_DATA (RTL8712_DEBUGCTRL_ + 0x30)
+#define TRXPKTBUF_DBG_CTRL (RTL8712_DEBUGCTRL_ + 0x38)
+#define DPLL_MON (RTL8712_DEBUGCTRL_ + 0x3A)
 
 #endif /* __RTL8712_DEBUGCTRL_REGDEF_H__ */
-
diff --git a/drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h b/drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h
index 9048d6a65296..133d451f6e5f 100644
--- a/drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h
@@ -15,51 +15,51 @@
 #define __RTL8712_EDCASETTING_BITDEF_H__
 
 /*EDCAPARAM*/
-#define	_TXOPLIMIT_MSK		0xFFFF0000
-#define	_TXOPLIMIT_SHT		16
-#define	_ECWIN_MSK		0x0000FF00
-#define	_ECWIN_SHT		8
-#define	_AIFS_MSK		0x000000FF
-#define	_AIFS_SHT		0
+#define _TXOPLIMIT_MSK 0xFFFF0000
+#define _TXOPLIMIT_SHT 16
+#define _ECWIN_MSK 0x0000FF00
+#define _ECWIN_SHT 8
+#define _AIFS_MSK 0x000000FF
+#define _AIFS_SHT 0
 
 /*BCNTCFG*/
-#define	_BCNECW_MSK		0xFF00
-#define	_BCNECW_SHT		8
-#define	_BCNIFS_MSK		0x00FF
-#define	_BCNIFS_SHT		0
+#define _BCNECW_MSK 0xFF00
+#define _BCNECW_SHT 8
+#define _BCNIFS_MSK 0x00FF
+#define _BCNIFS_SHT 0
 
 /*CWRR*/
-#define	_CWRR_MSK		0x03FF
+#define _CWRR_MSK 0x03FF
 
 /*ACMAVG*/
-#define	_AVG_TIME_UP		BIT(3)
-#define	_AVGPERIOD_MSK		0x03
+#define _AVG_TIME_UP BIT(3)
+#define _AVGPERIOD_MSK 0x03
 
 /*ACMHWCTRL*/
-#define	_VOQ_ACM_STATUS		BIT(6)
-#define	_VIQ_ACM_STATUS		BIT(5)
-#define	_BEQ_ACM_STATUS		BIT(4)
-#define	_VOQ_ACM_EN		BIT(3)
-#define	_VIQ_ACM_EN		BIT(2)
-#define	_BEQ_ACM_EN		BIT(1)
-#define	_ACMHWEN		BIT(0)
+#define _VOQ_ACM_STATUS BIT(6)
+#define _VIQ_ACM_STATUS BIT(5)
+#define _BEQ_ACM_STATUS BIT(4)
+#define _VOQ_ACM_EN BIT(3)
+#define _VIQ_ACM_EN BIT(2)
+#define _BEQ_ACM_EN BIT(1)
+#define _ACMHWEN BIT(0)
 
 /*VO_ADMTIME*/
-#define	_VO_ACM_RUT		BIT(18)
-#define	_VO_ADMTIME_MSK		0x0003FFF
+#define _VO_ACM_RUT BIT(18)
+#define _VO_ADMTIME_MSK 0x0003FFF
 
 /*VI_ADMTIME*/
-#define	_VI_ACM_RUT		BIT(18)
-#define	_VI_ADMTIME_MSK		0x0003FFF
+#define _VI_ACM_RUT BIT(18)
+#define _VI_ADMTIME_MSK 0x0003FFF
 
 /*BE_ADMTIME*/
-#define	_BE_ACM_RUT		BIT(18)
-#define	_BE_ADMTIME_MSK		0x0003FFF
+#define _BE_ACM_RUT BIT(18)
+#define _BE_ADMTIME_MSK 0x0003FFF
 
 /*Retry limit reg*/
-#define	_SRL_MSK		0xFF00
-#define	_SRL_SHT		8
-#define	_LRL_MSK		0x00FF
-#define	_LRL_SHT		0
+#define _SRL_MSK 0xFF00
+#define _SRL_SHT 8
+#define _LRL_MSK 0x00FF
+#define _LRL_SHT 0
 
 #endif /* __RTL8712_EDCASETTING_BITDEF_H__*/
diff --git a/drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h b/drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h
index 02ec9f3bba66..ef68d4be7cda 100644
--- a/drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h
@@ -7,18 +7,17 @@
 #ifndef __RTL8712_EDCASETTING_REGDEF_H__
 #define __RTL8712_EDCASETTING_REGDEF_H__
 
-#define EDCA_VO_PARAM		(RTL8712_EDCASETTING_ + 0x00)
-#define EDCA_VI_PARAM		(RTL8712_EDCASETTING_ + 0x04)
-#define EDCA_BE_PARAM		(RTL8712_EDCASETTING_ + 0x08)
-#define EDCA_BK_PARAM		(RTL8712_EDCASETTING_ + 0x0C)
-#define BCNTCFG			(RTL8712_EDCASETTING_ + 0x10)
-#define CWRR			(RTL8712_EDCASETTING_ + 0x12)
-#define ACMAVG			(RTL8712_EDCASETTING_ + 0x16)
-#define ACMHWCTRL		(RTL8712_EDCASETTING_ + 0x17)
-#define VO_ADMTIME		(RTL8712_EDCASETTING_ + 0x18)
-#define VI_ADMTIME		(RTL8712_EDCASETTING_ + 0x1C)
-#define BE_ADMTIME		(RTL8712_EDCASETTING_ + 0x20)
-#define RL			(RTL8712_EDCASETTING_ + 0x24)
+#define EDCA_VO_PARAM (RTL8712_EDCASETTING_ + 0x00)
+#define EDCA_VI_PARAM (RTL8712_EDCASETTING_ + 0x04)
+#define EDCA_BE_PARAM (RTL8712_EDCASETTING_ + 0x08)
+#define EDCA_BK_PARAM (RTL8712_EDCASETTING_ + 0x0C)
+#define BCNTCFG (RTL8712_EDCASETTING_ + 0x10)
+#define CWRR (RTL8712_EDCASETTING_ + 0x12)
+#define ACMAVG (RTL8712_EDCASETTING_ + 0x16)
+#define ACMHWCTRL (RTL8712_EDCASETTING_ + 0x17)
+#define VO_ADMTIME (RTL8712_EDCASETTING_ + 0x18)
+#define VI_ADMTIME (RTL8712_EDCASETTING_ + 0x1C)
+#define BE_ADMTIME (RTL8712_EDCASETTING_ + 0x20)
+#define RL (RTL8712_EDCASETTING_ + 0x24)
 
 #endif /* __RTL8712_EDCASETTING_REGDEF_H__ */
-
diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
index a39d6c06648f..e7ba8faa2299 100644
--- a/drivers/staging/rtl8712/rtl8712_efuse.c
+++ b/drivers/staging/rtl8712/rtl8712_efuse.c
@@ -69,12 +69,12 @@ static u8 efuse_one_byte_read(struct _adapter *adapter, u16 addr, u8 *data)
 
 	/* -----------------e-fuse reg ctrl --------------------------------- */
 	r8712_write8(adapter, EFUSE_CTRL + 1, (u8)(addr & 0xFF)); /* address */
-	r8712_write8(adapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) |
-	       (r8712_read8(adapter, EFUSE_CTRL + 2) & 0xFC));
+	r8712_write8(adapter, EFUSE_CTRL + 2,
+		     ((u8)((addr >> 8) & 0x03)) |
+			     (r8712_read8(adapter, EFUSE_CTRL + 2) & 0xFC));
 	r8712_write8(adapter, EFUSE_CTRL + 3, 0x72); /* read cmd */
 	/* wait for complete */
-	while (!(0x80 & r8712_read8(adapter, EFUSE_CTRL + 3)) &&
-	       (tmpidx < 100))
+	while (!(0x80 & r8712_read8(adapter, EFUSE_CTRL + 3)) && (tmpidx < 100))
 		tmpidx++;
 	if (tmpidx < 100) {
 		*data = r8712_read8(adapter, EFUSE_CTRL);
@@ -92,13 +92,13 @@ static u8 efuse_one_byte_write(struct _adapter *adapter, u16 addr, u8 data)
 
 	/* -----------------e-fuse reg ctrl -------------------------------- */
 	r8712_write8(adapter, EFUSE_CTRL + 1, (u8)(addr & 0xFF)); /* address */
-	r8712_write8(adapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) |
-	       (r8712_read8(adapter, EFUSE_CTRL + 2) & 0xFC));
+	r8712_write8(adapter, EFUSE_CTRL + 2,
+		     ((u8)((addr >> 8) & 0x03)) |
+			     (r8712_read8(adapter, EFUSE_CTRL + 2) & 0xFC));
 	r8712_write8(adapter, EFUSE_CTRL, data); /* data */
 	r8712_write8(adapter, EFUSE_CTRL + 3, 0xF2); /* write cmd */
 	/* wait for complete */
-	while ((0x80 &  r8712_read8(adapter, EFUSE_CTRL + 3)) &&
-	       (tmpidx < 100))
+	while ((0x80 & r8712_read8(adapter, EFUSE_CTRL + 3)) && (tmpidx < 100))
 		tmpidx++;
 	if (tmpidx < 100)
 		bResult = true;
@@ -115,10 +115,10 @@ static u8 efuse_one_byte_rw(struct _adapter *adapter, u8 bRead, u16 addr,
 	/* -----------------e-fuse reg ctrl --------------------------------- */
 	r8712_write8(adapter, EFUSE_CTRL + 1, (u8)(addr & 0xFF)); /* address */
 	tmpv8 = ((u8)((addr >> 8) & 0x03)) |
-		 (r8712_read8(adapter, EFUSE_CTRL + 2) & 0xFC);
+		(r8712_read8(adapter, EFUSE_CTRL + 2) & 0xFC);
 	r8712_write8(adapter, EFUSE_CTRL + 2, tmpv8);
 	if (bRead) {
-		r8712_write8(adapter, EFUSE_CTRL + 3,  0x72); /* read cmd */
+		r8712_write8(adapter, EFUSE_CTRL + 3, 0x72); /* read cmd */
 		while (!(0x80 & r8712_read8(adapter, EFUSE_CTRL + 3)) &&
 		       (tmpidx < 100))
 			tmpidx++;
@@ -169,15 +169,15 @@ void r8712_efuse_change_max_size(struct _adapter *adapter)
 	for (i = 0; i < pre_pg_data_size; i++)
 		efuse_one_byte_read(adapter, pre_pg_data_saddr + i,
 				    &pre_pg_data[i]);
-	if ((pre_pg_data[0] == 0x03) && (pre_pg_data[1] == 0x00) &&
-	    (pre_pg_data[2] == 0x00) && (pre_pg_data[3] == 0x00) &&
-	    (pre_pg_data[4] == 0x0C))
+	if (pre_pg_data[0] == 0x03 && pre_pg_data[1] == 0x00 &&
+	    pre_pg_data[2] == 0x00 && pre_pg_data[3] == 0x00 &&
+	    pre_pg_data[4] == 0x0C)
 		efuse_available_max_size -= pre_pg_data_size;
 }
 
 int r8712_efuse_get_max_size(struct _adapter *adapter)
 {
-	return	efuse_available_max_size;
+	return efuse_available_max_size;
 }
 
 static u8 calculate_word_cnts(const u8 word_en)
@@ -213,10 +213,11 @@ u16 r8712_efuse_get_current_size(struct _adapter *adapter)
 	u8 hworden = 0;
 	u8 efuse_data, word_cnts = 0;
 
-	while (bContinual && efuse_one_byte_read(adapter, efuse_addr, &efuse_data) &&
+	while (bContinual &&
+	       efuse_one_byte_read(adapter, efuse_addr, &efuse_data) &&
 	       (efuse_addr < efuse_available_max_size)) {
 		if (efuse_data != 0xFF) {
-			hworden =  efuse_data & 0x0F;
+			hworden = efuse_data & 0x0F;
 			word_cnts = calculate_word_cnts(hworden);
 			/* read next header */
 			efuse_addr = efuse_addr + (word_cnts * 2) + 1;
@@ -246,13 +247,15 @@ u8 r8712_efuse_pg_packet_read(struct _adapter *adapter, u8 offset, u8 *data)
 			if (efuse_data == 0xFF)
 				break;
 			hoffset = (efuse_data >> 4) & 0x0F;
-			hworden =  efuse_data & 0x0F;
+			hworden = efuse_data & 0x0F;
 			word_cnts = calculate_word_cnts(hworden);
 			if (hoffset == offset) {
 				memset(tmpdata, 0xFF, PGPKT_DATA_SIZE);
 				for (tmpidx = 0; tmpidx < word_cnts * 2;
 				     tmpidx++) {
-					if (efuse_one_byte_read(adapter, efuse_addr + 1 + tmpidx,
+					if (efuse_one_byte_read(adapter,
+								efuse_addr + 1 +
+									tmpidx,
 								&efuse_data)) {
 						tmpdata[tmpidx] = efuse_data;
 					} else {
@@ -300,14 +303,11 @@ static u8 fix_header(struct _adapter *adapter, u8 header, u16 header_addr)
 			if (!(BIT(i) & word_en))
 				continue;
 			if (BIT(i) & pkt.word_en) {
-				if (efuse_one_byte_read(adapter,
-							addr,
-							&value))
+				if (efuse_one_byte_read(adapter, addr, &value))
 					pkt.data[i * 2] = value;
 				else
 					return false;
-				if (efuse_one_byte_read(adapter,
-							addr + 1,
+				if (efuse_one_byte_read(adapter, addr + 1,
 							&value))
 					pkt.data[i * 2 + 1] = value;
 				else
@@ -339,9 +339,9 @@ static u8 fix_header(struct _adapter *adapter, u8 header, u16 header_addr)
 			} else if (pkt.data[i * 2 + 1] != value) {
 				ret = false;
 				if (value == 0xFF) /* write again */
-					efuse_one_byte_write(adapter, addr + 1,
-							     pkt.data[i * 2 +
-								      1]);
+					efuse_one_byte_write(
+						adapter, addr + 1,
+						pkt.data[i * 2 + 1]);
 			}
 		}
 		addr += 2;
@@ -370,29 +370,27 @@ u8 r8712_efuse_pg_packet_write(struct _adapter *adapter, const u8 offset,
 	while (efuse_addr < efuse_available_max_size) {
 		curr_size = r8712_efuse_get_current_size(adapter);
 		if ((curr_size + 1 + target_word_cnts * 2) >
-		     efuse_available_max_size)
+		    efuse_available_max_size)
 			return false; /*target_word_cnts + pg header(1 byte)*/
 		efuse_addr = curr_size; /* current size is also the last addr*/
 		efuse_one_byte_write(adapter, efuse_addr, pg_header); /*hdr*/
 		sub_repeat = 0;
 		/* check if what we read is what we write */
-		while (!efuse_one_byte_read(adapter, efuse_addr,
-					    &efuse_data)) {
+		while (!efuse_one_byte_read(adapter, efuse_addr, &efuse_data)) {
 			if (++sub_repeat > _REPEAT_THRESHOLD_) {
 				bResult = false; /* continue to blind write */
 				break; /* continue to blind write */
 			}
 		}
-		if ((sub_repeat > _REPEAT_THRESHOLD_) ||
-		    (pg_header == efuse_data)) {
+		if (sub_repeat > _REPEAT_THRESHOLD_ ||
+		    pg_header == efuse_data) {
 			/* write header ok OR can't check header(creep) */
 			u8 i;
 
 			/* go to next address */
 			efuse_addr++;
 			for (i = 0; i < target_word_cnts * 2; i++) {
-				efuse_one_byte_write(adapter,
-						     efuse_addr + i,
+				efuse_one_byte_write(adapter, efuse_addr + i,
 						     *(data + i));
 				if (!efuse_one_byte_read(adapter,
 							 efuse_addr + i,
@@ -426,8 +424,7 @@ u8 r8712_efuse_access(struct _adapter *adapter, u8 bRead, u16 start_addr,
 
 	if (start_addr > EFUSE_MAX_SIZE)
 		return false;
-	if (!bRead && ((start_addr + cnts) >
-	   efuse_available_max_size))
+	if (!bRead && ((start_addr + cnts) > efuse_available_max_size))
 		return false;
 	if (!bRead && !r8712_efuse_reg_init(adapter))
 		return false;
@@ -462,8 +459,8 @@ u8 r8712_efuse_map_read(struct _adapter *adapter, u16 addr, u16 cnts, u8 *data)
 	}
 	offset = (addr >> 3) & 0xF;
 	ret = r8712_efuse_pg_packet_read(adapter, offset, pktdata);
-	i = addr & 0x7;	/* pktdata index */
-	idx = 0;	/* data index */
+	i = addr & 0x7; /* pktdata index */
+	idx = 0; /* data index */
 
 	do {
 		for (; i < PGPKT_DATA_SIZE; i++) {
@@ -479,8 +476,7 @@ u8 r8712_efuse_map_read(struct _adapter *adapter, u16 addr, u16 cnts, u8 *data)
 	return ret;
 }
 
-u8 r8712_efuse_map_write(struct _adapter *adapter, u16 addr, u16 cnts,
-			 u8 *data)
+u8 r8712_efuse_map_write(struct _adapter *adapter, u16 addr, u16 cnts, u8 *data)
 {
 	u8 offset, word_en, empty;
 	u8 pktdata[PGPKT_DATA_SIZE], newdata[PGPKT_DATA_SIZE];
@@ -504,9 +500,9 @@ u8 r8712_efuse_map_write(struct _adapter *adapter, u16 addr, u16 cnts,
 			return false;
 	word_en = 0xF;
 	memset(newdata, 0xFF, PGPKT_DATA_SIZE);
-	i = addr & 0x7;	/* pktdata index */
-	j = 0;		/* newdata index */
-	idx = 0;	/* data index */
+	i = addr & 0x7; /* pktdata index */
+	j = 0; /* newdata index */
+	idx = 0; /* data index */
 
 	if (i & 0x1) {
 		/*  odd start */
@@ -530,8 +526,8 @@ u8 r8712_efuse_map_write(struct _adapter *adapter, u16 addr, u16 cnts,
 				break;
 			}
 
-			if ((data[idx] != pktdata[i]) || (data[idx + 1] !=
-			     pktdata[i + 1])) {
+			if (data[idx] != pktdata[i] ||
+			    data[idx + 1] != pktdata[i + 1]) {
 				word_en &= ~BIT(i >> 1);
 				newdata[j++] = data[idx];
 				newdata[j++] = data[idx + 1];
diff --git a/drivers/staging/rtl8712/rtl8712_efuse.h b/drivers/staging/rtl8712/rtl8712_efuse.h
index 7a49740212eb..380b268a59fb 100644
--- a/drivers/staging/rtl8712/rtl8712_efuse.h
+++ b/drivers/staging/rtl8712/rtl8712_efuse.h
@@ -4,19 +4,19 @@
 
 #include "osdep_service.h"
 
-#define _REPEAT_THRESHOLD_	3
+#define _REPEAT_THRESHOLD_ 3
 
-#define EFUSE_MAX_SIZE		512
-#define EFUSE_MAP_MAX_SIZE	128
+#define EFUSE_MAX_SIZE 512
+#define EFUSE_MAP_MAX_SIZE 128
 
-#define PGPKG_MAX_WORDS	4
-#define PGPKT_DATA_SIZE	8 /* PGPKG_MAX_WORDS*2; BYTES sizeof(u8)*8*/
-#define MAX_PGPKT_SIZE	9 /* 1 + PGPKT_DATA_SIZE; header + 2 * 4 words (BYTES)*/
+#define PGPKG_MAX_WORDS 4
+#define PGPKT_DATA_SIZE 8 /* PGPKG_MAX_WORDS*2; BYTES sizeof(u8)*8*/
+#define MAX_PGPKT_SIZE 9 /* 1 + PGPKT_DATA_SIZE; header + 2 * 4 words (BYTES)*/
 
-#define GET_EFUSE_OFFSET(header)	((header & 0xF0) >> 4)
-#define GET_EFUSE_WORD_EN(header)	(header & 0x0F)
-#define MAKE_EFUSE_HEADER(offset, word_en)	((((offset) & 0x0F) << 4) | \
-						((word_en) & 0x0F))
+#define GET_EFUSE_OFFSET(header) ((header & 0xF0) >> 4)
+#define GET_EFUSE_WORD_EN(header) (header & 0x0F)
+#define MAKE_EFUSE_HEADER(offset, word_en) \
+	((((offset) & 0x0F) << 4) | ((word_en) & 0x0F))
 /*--------------------------------------------------------------------------*/
 struct PGPKT_STRUCT {
 	u8 offset;
@@ -30,15 +30,13 @@ void r8712_efuse_reg_uninit(struct _adapter *padapter);
 u16 r8712_efuse_get_current_size(struct _adapter *padapter);
 int r8712_efuse_get_max_size(struct _adapter *padapter);
 void r8712_efuse_change_max_size(struct _adapter *padapter);
-u8 r8712_efuse_pg_packet_read(struct _adapter *padapter,
-			      u8 offset, u8 *data);
-u8 r8712_efuse_pg_packet_write(struct _adapter *padapter,
-			       const u8 offset, const u8 word_en,
-			       const u8 *data);
-u8 r8712_efuse_access(struct _adapter *padapter, u8 bRead,
-		      u16 start_addr, u16 cnts, u8 *data);
-u8 r8712_efuse_map_read(struct _adapter *padapter, u16 addr,
-			u16 cnts, u8 *data);
-u8 r8712_efuse_map_write(struct _adapter *padapter, u16 addr,
-			 u16 cnts, u8 *data);
+u8 r8712_efuse_pg_packet_read(struct _adapter *padapter, u8 offset, u8 *data);
+u8 r8712_efuse_pg_packet_write(struct _adapter *padapter, const u8 offset,
+			       const u8 word_en, const u8 *data);
+u8 r8712_efuse_access(struct _adapter *padapter, u8 bRead, u16 start_addr,
+		      u16 cnts, u8 *data);
+u8 r8712_efuse_map_read(struct _adapter *padapter, u16 addr, u16 cnts,
+			u8 *data);
+u8 r8712_efuse_map_write(struct _adapter *padapter, u16 addr, u16 cnts,
+			 u8 *data);
 #endif
diff --git a/drivers/staging/rtl8712/rtl8712_event.h b/drivers/staging/rtl8712/rtl8712_event.h
index 0d3e5feadcc0..297879771e09 100644
--- a/drivers/staging/rtl8712/rtl8712_event.h
+++ b/drivers/staging/rtl8712/rtl8712_event.h
@@ -18,69 +18,69 @@ void r8712_event_handle(struct _adapter *padapter, __le32 *peventbuf);
 void r8712_got_addbareq_event_callback(struct _adapter *adapter, u8 *pbuf);
 
 enum rtl8712_c2h_event {
-	GEN_EVT_CODE(_Read_MACREG) = 0,		/*0*/
+	GEN_EVT_CODE(_Read_MACREG) = 0, /*0*/
 	GEN_EVT_CODE(_Read_BBREG),
 	GEN_EVT_CODE(_Read_RFREG),
 	GEN_EVT_CODE(_Read_EEPROM),
 	GEN_EVT_CODE(_Read_EFUSE),
-	GEN_EVT_CODE(_Read_CAM),		/*5*/
+	GEN_EVT_CODE(_Read_CAM), /*5*/
 	GEN_EVT_CODE(_Get_BasicRate),
 	GEN_EVT_CODE(_Get_DataRate),
-	GEN_EVT_CODE(_Survey),			/*8*/
-	GEN_EVT_CODE(_SurveyDone),		/*9*/
+	GEN_EVT_CODE(_Survey), /*8*/
+	GEN_EVT_CODE(_SurveyDone), /*9*/
 
-	GEN_EVT_CODE(_JoinBss),			/*10*/
+	GEN_EVT_CODE(_JoinBss), /*10*/
 	GEN_EVT_CODE(_AddSTA),
 	GEN_EVT_CODE(_DelSTA),
 	GEN_EVT_CODE(_AtimDone),
 	GEN_EVT_CODE(_TX_Report),
-	GEN_EVT_CODE(_CCX_Report),		/*15*/
+	GEN_EVT_CODE(_CCX_Report), /*15*/
 	GEN_EVT_CODE(_DTM_Report),
 	GEN_EVT_CODE(_TX_Rate_Statistics),
 	GEN_EVT_CODE(_C2HLBK),
 	GEN_EVT_CODE(_FWDBG),
-	GEN_EVT_CODE(_C2HFEEDBACK),		/*20*/
+	GEN_EVT_CODE(_C2HFEEDBACK), /*20*/
 	GEN_EVT_CODE(_ADDBA),
 	GEN_EVT_CODE(_C2HBCN),
-	GEN_EVT_CODE(_ReportPwrState),		/*filen: only for PCIE, USB*/
-	GEN_EVT_CODE(_WPS_PBC),			/*24*/
-	GEN_EVT_CODE(_ADDBAReq_Report),		/*25*/
+	GEN_EVT_CODE(_ReportPwrState), /*filen: only for PCIE, USB*/
+	GEN_EVT_CODE(_WPS_PBC), /*24*/
+	GEN_EVT_CODE(_ADDBAReq_Report), /*25*/
 	MAX_C2HEVT
 };
 
 #ifdef _RTL8712_CMD_C_
 
 static struct fwevent wlanevents[] = {
-	{0, NULL},	/*0*/
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},
-	{0, &r8712_survey_event_callback},		/*8*/
-	{sizeof(struct surveydone_event),
-		&r8712_surveydone_event_callback},	/*9*/
+	{ 0, NULL }, /*0*/
+	{ 0, NULL },
+	{ 0, NULL },
+	{ 0, NULL },
+	{ 0, NULL },
+	{ 0, NULL },
+	{ 0, NULL },
+	{ 0, NULL },
+	{ 0, &r8712_survey_event_callback }, /*8*/
+	{ sizeof(struct surveydone_event),
+	  &r8712_surveydone_event_callback }, /*9*/
 
-	{0, &r8712_joinbss_event_callback},		/*10*/
-	{sizeof(struct stassoc_event), &r8712_stassoc_event_callback},
-	{sizeof(struct stadel_event), &r8712_stadel_event_callback},
-	{0, &r8712_atimdone_event_callback},
-	{0, NULL},
-	{0, NULL},	/*15*/
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},
-	{0, NULL},	/*fwdbg_event_callback},*/
-	{0, NULL},	/*20*/
-	{0, NULL},
-	{0, NULL},
-	{0, &r8712_cpwm_event_callback},
-	{0, &r8712_wpspbc_event_callback},
-	{0, &r8712_got_addbareq_event_callback},
+	{ 0, &r8712_joinbss_event_callback }, /*10*/
+	{ sizeof(struct stassoc_event), &r8712_stassoc_event_callback },
+	{ sizeof(struct stadel_event), &r8712_stadel_event_callback },
+	{ 0, &r8712_atimdone_event_callback },
+	{ 0, NULL },
+	{ 0, NULL }, /*15*/
+	{ 0, NULL },
+	{ 0, NULL },
+	{ 0, NULL },
+	{ 0, NULL }, /*fwdbg_event_callback},*/
+	{ 0, NULL }, /*20*/
+	{ 0, NULL },
+	{ 0, NULL },
+	{ 0, &r8712_cpwm_event_callback },
+	{ 0, &r8712_wpspbc_event_callback },
+	{ 0, &r8712_got_addbareq_event_callback },
 };
 
-#endif/*_RTL8712_CMD_C_*/
+#endif /*_RTL8712_CMD_C_*/
 
 #endif
diff --git a/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h
index f09645fa1886..b4e027d9d1ca 100644
--- a/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h
@@ -8,124 +8,123 @@
 #define __RTL8712_FIFOCTRL_BITDEF_H__
 
 /*PBP*/
-#define	_PSTX_MSK			0xF0
-#define	_PSTX_SHT			4
-#define	_PSRX_MSK			0x0F
-#define	_PSRX_SHT			0
+#define _PSTX_MSK 0xF0
+#define _PSTX_SHT 4
+#define _PSRX_MSK 0x0F
+#define _PSRX_SHT 0
 
 /*TXFF_STATUS*/
-#define	_TXSTATUS_OVF		BIT(15)
+#define _TXSTATUS_OVF BIT(15)
 
 /*RXFF_STATUS*/
-#define	_STATUSFF1_OVF		BIT(7)
-#define	_STATUSFF1_EMPTY	BIT(6)
-#define	_STATUSFF0_OVF		BIT(5)
-#define	_STATUSFF0_EMPTY	BIT(4)
-#define	_RXFF1_OVF			BIT(3)
-#define	_RXFF1_EMPTY		BIT(2)
-#define	_RXFF0_OVF			BIT(1)
-#define	_RXFF0_EMPTY		BIT(0)
+#define _STATUSFF1_OVF BIT(7)
+#define _STATUSFF1_EMPTY BIT(6)
+#define _STATUSFF0_OVF BIT(5)
+#define _STATUSFF0_EMPTY BIT(4)
+#define _RXFF1_OVF BIT(3)
+#define _RXFF1_EMPTY BIT(2)
+#define _RXFF0_OVF BIT(1)
+#define _RXFF0_EMPTY BIT(0)
 
 /*TXFF_EMPTY_TH*/
-#define	_BKQ_EMPTY_TH_MSK	0x0F0000
-#define	_BKQ_EMPTY_TH_SHT	16
-#define	_BEQ_EMPTY_TH_MSK	0x00F000
-#define	_BEQ_EMPTY_TH_SHT	12
-#define	_VIQ_EMPTY_TH_MSK	0x000F00
-#define	_VIQ_EMPTY_TH_SHT	8
-#define	_VOQ_EMPTY_TH_MSK	0x0000F0
-#define	_VOQ_EMPTY_TH_SHT	4
-#define	_BMCQ_EMPTY_TH_MSK	0x00000F
-#define	_BMCQ_EMPTY_TH_SHT	0
+#define _BKQ_EMPTY_TH_MSK 0x0F0000
+#define _BKQ_EMPTY_TH_SHT 16
+#define _BEQ_EMPTY_TH_MSK 0x00F000
+#define _BEQ_EMPTY_TH_SHT 12
+#define _VIQ_EMPTY_TH_MSK 0x000F00
+#define _VIQ_EMPTY_TH_SHT 8
+#define _VOQ_EMPTY_TH_MSK 0x0000F0
+#define _VOQ_EMPTY_TH_SHT 4
+#define _BMCQ_EMPTY_TH_MSK 0x00000F
+#define _BMCQ_EMPTY_TH_SHT 0
 
 /*SDIO_RX_BLKSZ*/
-#define	_SDIO_RX_BLKSZ_MSK	0x07
+#define _SDIO_RX_BLKSZ_MSK 0x07
 
 /*RXDMA_CTRL*/
-#define	_C2HFF_POLL		BIT(4)
-#define	_RXPKT_POLL		BIT(0)
+#define _C2HFF_POLL BIT(4)
+#define _RXPKT_POLL BIT(0)
 
 /*RXPKT_NUM*/
-#define	_RXCMD_NUM_MSK		0xFF00
-#define	_RXCMD_NUM_SHT		8
-#define	_RXFF0_NUM_MSK		0x00FF
-#define	_RXFF0_NUM_SHT		0
+#define _RXCMD_NUM_MSK 0xFF00
+#define _RXCMD_NUM_SHT 8
+#define _RXFF0_NUM_MSK 0x00FF
+#define _RXFF0_NUM_SHT 0
 
 /*FIFOPAGE2*/
-#define	_PUB_AVAL_PG_MSK	0xFFFF0000
-#define	_PUB_AVAL_PG_SHT	16
-#define	_BCN_AVAL_PG_MSK	0x0000FFFF
-#define	_BCN_AVAL_PG_SHT	0
+#define _PUB_AVAL_PG_MSK 0xFFFF0000
+#define _PUB_AVAL_PG_SHT 16
+#define _BCN_AVAL_PG_MSK 0x0000FFFF
+#define _BCN_AVAL_PG_SHT 0
 
 /*RX0PKTNUM*/
-#define	_RXFF0_DEC_POLL				BIT(15)
-#define	_RXFF0_PKT_DEC_NUM_MSK		0x3F00
-#define	_RXFF0_PKT_DEC_NUM_SHT		8
-#define	_RXFF0_PKTNUM_RPT_MSK		0x00FF
-#define	_RXFF0_PKTNUM_RPT_SHT		0
+#define _RXFF0_DEC_POLL BIT(15)
+#define _RXFF0_PKT_DEC_NUM_MSK 0x3F00
+#define _RXFF0_PKT_DEC_NUM_SHT 8
+#define _RXFF0_PKTNUM_RPT_MSK 0x00FF
+#define _RXFF0_PKTNUM_RPT_SHT 0
 
 /*RX1PKTNUM*/
-#define	_RXFF1_DEC_POLL				BIT(15)
-#define	_RXFF1_PKT_DEC_NUM_MSK		0x3F00
-#define	_RXFF1_PKT_DEC_NUM_SHT		8
-#define	_RXFF1_PKTNUM_RPT_MSK		0x00FF
-#define	_RXFF1_PKTNUM_RPT_SHT		0
+#define _RXFF1_DEC_POLL BIT(15)
+#define _RXFF1_PKT_DEC_NUM_MSK 0x3F00
+#define _RXFF1_PKT_DEC_NUM_SHT 8
+#define _RXFF1_PKTNUM_RPT_MSK 0x00FF
+#define _RXFF1_PKTNUM_RPT_SHT 0
 
 /*RXFLTMAP0*/
-#define	_MGTFLT13EN		BIT(13)
-#define	_MGTFLT12EN		BIT(12)
-#define	_MGTFLT11EN		BIT(11)
-#define	_MGTFLT10EN		BIT(10)
-#define	_MGTFLT9EN		BIT(9)
-#define	_MGTFLT8EN		BIT(8)
-#define	_MGTFLT5EN		BIT(5)
-#define	_MGTFLT4EN		BIT(4)
-#define	_MGTFLT3EN		BIT(3)
-#define	_MGTFLT2EN		BIT(2)
-#define	_MGTFLT1EN		BIT(1)
-#define	_MGTFLT0EN		BIT(0)
+#define _MGTFLT13EN BIT(13)
+#define _MGTFLT12EN BIT(12)
+#define _MGTFLT11EN BIT(11)
+#define _MGTFLT10EN BIT(10)
+#define _MGTFLT9EN BIT(9)
+#define _MGTFLT8EN BIT(8)
+#define _MGTFLT5EN BIT(5)
+#define _MGTFLT4EN BIT(4)
+#define _MGTFLT3EN BIT(3)
+#define _MGTFLT2EN BIT(2)
+#define _MGTFLT1EN BIT(1)
+#define _MGTFLT0EN BIT(0)
 
 /*RXFLTMAP1*/
-#define	_CTRLFLT15EN	BIT(15)
-#define	_CTRLFLT14EN	BIT(14)
-#define	_CTRLFLT13EN	BIT(13)
-#define	_CTRLFLT12EN	BIT(12)
-#define	_CTRLFLT11EN	BIT(11)
-#define	_CTRLFLT10EN	BIT(10)
-#define	_CTRLFLT9EN		BIT(9)
-#define	_CTRLFLT8EN		BIT(8)
-#define	_CTRLFLT7EN		BIT(7)
-#define	_CTRLFLT6EN		BIT(6)
+#define _CTRLFLT15EN BIT(15)
+#define _CTRLFLT14EN BIT(14)
+#define _CTRLFLT13EN BIT(13)
+#define _CTRLFLT12EN BIT(12)
+#define _CTRLFLT11EN BIT(11)
+#define _CTRLFLT10EN BIT(10)
+#define _CTRLFLT9EN BIT(9)
+#define _CTRLFLT8EN BIT(8)
+#define _CTRLFLT7EN BIT(7)
+#define _CTRLFLT6EN BIT(6)
 
 /*RXFLTMAP2*/
-#define	_DATAFLT15EN	BIT(15)
-#define	_DATAFLT14EN	BIT(14)
-#define	_DATAFLT13EN	BIT(13)
-#define	_DATAFLT12EN	BIT(12)
-#define	_DATAFLT11EN	BIT(11)
-#define	_DATAFLT10EN	BIT(10)
-#define	_DATAFLT9EN		BIT(9)
-#define	_DATAFLT8EN		BIT(8)
-#define	_DATAFLT7EN		BIT(7)
-#define	_DATAFLT6EN		BIT(6)
-#define	_DATAFLT5EN		BIT(5)
-#define	_DATAFLT4EN		BIT(4)
-#define	_DATAFLT3EN		BIT(3)
-#define	_DATAFLT2EN		BIT(2)
-#define	_DATAFLT1EN		BIT(1)
-#define	_DATAFLT0EN		BIT(0)
+#define _DATAFLT15EN BIT(15)
+#define _DATAFLT14EN BIT(14)
+#define _DATAFLT13EN BIT(13)
+#define _DATAFLT12EN BIT(12)
+#define _DATAFLT11EN BIT(11)
+#define _DATAFLT10EN BIT(10)
+#define _DATAFLT9EN BIT(9)
+#define _DATAFLT8EN BIT(8)
+#define _DATAFLT7EN BIT(7)
+#define _DATAFLT6EN BIT(6)
+#define _DATAFLT5EN BIT(5)
+#define _DATAFLT4EN BIT(4)
+#define _DATAFLT3EN BIT(3)
+#define _DATAFLT2EN BIT(2)
+#define _DATAFLT1EN BIT(1)
+#define _DATAFLT0EN BIT(0)
 
 /*RXFLTMAP3*/
-#define	_MESHAFLT1EN		BIT(1)
-#define	_MESHAFLT0EN		BIT(0)
+#define _MESHAFLT1EN BIT(1)
+#define _MESHAFLT0EN BIT(0)
 
 /*TXPKT_NUM_CTRL*/
-#define	_TXPKTNUM_DEC		BIT(8)
-#define	_TXPKTNUM_MSK		0x00FF
-#define	_TXPKTNUM_SHT		0
+#define _TXPKTNUM_DEC BIT(8)
+#define _TXPKTNUM_MSK 0x00FF
+#define _TXPKTNUM_SHT 0
 
 /*TXFF_PG_NUM*/
-#define	_TXFF_PG_NUM_MSK	0x0FFF
-
-#endif	/*	__RTL8712_FIFOCTRL_BITDEF_H__ */
+#define _TXFF_PG_NUM_MSK 0x0FFF
 
+#endif /*	__RTL8712_FIFOCTRL_BITDEF_H__ */
diff --git a/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h b/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h
index 189fdeb16d7d..ebe76e525be8 100644
--- a/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h
@@ -7,55 +7,55 @@
 #ifndef __RTL8712_FIFOCTRL_REGDEF_H__
 #define __RTL8712_FIFOCTRL_REGDEF_H__
 
-#define RQPN			(RTL8712_FIFOCTRL_ + 0x00)
-#define RXFF_BNDY		(RTL8712_FIFOCTRL_ + 0x0C)
-#define RXRPT_BNDY		(RTL8712_FIFOCTRL_ + 0x10)
-#define TXPKTBUF_PGBNDY		(RTL8712_FIFOCTRL_ + 0x14)
-#define PBP			(RTL8712_FIFOCTRL_ + 0x15)
-#define RX_DRVINFO_SZ		(RTL8712_FIFOCTRL_ + 0x16)
-#define TXFF_STATUS		(RTL8712_FIFOCTRL_ + 0x17)
-#define RXFF_STATUS		(RTL8712_FIFOCTRL_ + 0x18)
-#define TXFF_EMPTY_TH		(RTL8712_FIFOCTRL_ + 0x19)
-#define SDIO_RX_BLKSZ		(RTL8712_FIFOCTRL_ + 0x1C)
-#define RXDMA_RXCTRL		(RTL8712_FIFOCTRL_ + 0x1D)
-#define RXPKT_NUM		(RTL8712_FIFOCTRL_ + 0x1E)
-#define RXPKT_NUM_C2H		(RTL8712_FIFOCTRL_ + 0x1F)
-#define C2HCMD_UDT_SIZE		(RTL8712_FIFOCTRL_ + 0x20)
-#define C2HCMD_UDT_ADDR		(RTL8712_FIFOCTRL_ + 0x22)
-#define FIFOPAGE2		(RTL8712_FIFOCTRL_ + 0x24)
-#define FIFOPAGE1		(RTL8712_FIFOCTRL_ + 0x28)
-#define FW_RSVD_PG_CTRL		(RTL8712_FIFOCTRL_ + 0x30)
-#define TXRPTFF_RDPTR		(RTL8712_FIFOCTRL_ + 0x40)
-#define TXRPTFF_WTPTR		(RTL8712_FIFOCTRL_ + 0x44)
-#define C2HFF_RDPTR		(RTL8712_FIFOCTRL_ + 0x48)
-#define C2HFF_WTPTR		(RTL8712_FIFOCTRL_ + 0x4C)
-#define RXFF0_RDPTR		(RTL8712_FIFOCTRL_ + 0x50)
-#define RXFF0_WTPTR		(RTL8712_FIFOCTRL_ + 0x54)
-#define RXFF1_RDPTR		(RTL8712_FIFOCTRL_ + 0x58)
-#define RXFF1_WTPTR		(RTL8712_FIFOCTRL_ + 0x5C)
-#define RXRPT0FF_RDPTR		(RTL8712_FIFOCTRL_ + 0x60)
-#define RXRPT0FF_WTPTR		(RTL8712_FIFOCTRL_ + 0x64)
-#define RXRPT1FF_RDPTR		(RTL8712_FIFOCTRL_ + 0x68)
-#define RXRPT1FF_WTPTR		(RTL8712_FIFOCTRL_ + 0x6C)
-#define RX0PKTNUM		(RTL8712_FIFOCTRL_ + 0x72)
-#define RX1PKTNUM		(RTL8712_FIFOCTRL_ + 0x74)
-#define RXFLTMAP0		(RTL8712_FIFOCTRL_ + 0x76)
-#define RXFLTMAP1		(RTL8712_FIFOCTRL_ + 0x78)
-#define RXFLTMAP2		(RTL8712_FIFOCTRL_ + 0x7A)
-#define RXFLTMAP3		(RTL8712_FIFOCTRL_ + 0x7c)
-#define TBDA			(RTL8712_FIFOCTRL_ + 0x84)
-#define THPDA			(RTL8712_FIFOCTRL_ + 0x88)
-#define TCDA			(RTL8712_FIFOCTRL_ + 0x8C)
-#define TMDA			(RTL8712_FIFOCTRL_ + 0x90)
-#define HDA			(RTL8712_FIFOCTRL_ + 0x94)
-#define TVODA			(RTL8712_FIFOCTRL_ + 0x98)
-#define TVIDA			(RTL8712_FIFOCTRL_ + 0x9C)
-#define TBEDA			(RTL8712_FIFOCTRL_ + 0xA0)
-#define TBKDA			(RTL8712_FIFOCTRL_ + 0xA4)
-#define RCDA			(RTL8712_FIFOCTRL_ + 0xA8)
-#define RDSA			(RTL8712_FIFOCTRL_ + 0xAC)
-#define TXPKT_NUM_CTRL		(RTL8712_FIFOCTRL_ + 0xB0)
-#define TXQ_PGADD		(RTL8712_FIFOCTRL_ + 0xB3)
-#define TXFF_PG_NUM		(RTL8712_FIFOCTRL_ + 0xB4)
+#define RQPN (RTL8712_FIFOCTRL_ + 0x00)
+#define RXFF_BNDY (RTL8712_FIFOCTRL_ + 0x0C)
+#define RXRPT_BNDY (RTL8712_FIFOCTRL_ + 0x10)
+#define TXPKTBUF_PGBNDY (RTL8712_FIFOCTRL_ + 0x14)
+#define PBP (RTL8712_FIFOCTRL_ + 0x15)
+#define RX_DRVINFO_SZ (RTL8712_FIFOCTRL_ + 0x16)
+#define TXFF_STATUS (RTL8712_FIFOCTRL_ + 0x17)
+#define RXFF_STATUS (RTL8712_FIFOCTRL_ + 0x18)
+#define TXFF_EMPTY_TH (RTL8712_FIFOCTRL_ + 0x19)
+#define SDIO_RX_BLKSZ (RTL8712_FIFOCTRL_ + 0x1C)
+#define RXDMA_RXCTRL (RTL8712_FIFOCTRL_ + 0x1D)
+#define RXPKT_NUM (RTL8712_FIFOCTRL_ + 0x1E)
+#define RXPKT_NUM_C2H (RTL8712_FIFOCTRL_ + 0x1F)
+#define C2HCMD_UDT_SIZE (RTL8712_FIFOCTRL_ + 0x20)
+#define C2HCMD_UDT_ADDR (RTL8712_FIFOCTRL_ + 0x22)
+#define FIFOPAGE2 (RTL8712_FIFOCTRL_ + 0x24)
+#define FIFOPAGE1 (RTL8712_FIFOCTRL_ + 0x28)
+#define FW_RSVD_PG_CTRL (RTL8712_FIFOCTRL_ + 0x30)
+#define TXRPTFF_RDPTR (RTL8712_FIFOCTRL_ + 0x40)
+#define TXRPTFF_WTPTR (RTL8712_FIFOCTRL_ + 0x44)
+#define C2HFF_RDPTR (RTL8712_FIFOCTRL_ + 0x48)
+#define C2HFF_WTPTR (RTL8712_FIFOCTRL_ + 0x4C)
+#define RXFF0_RDPTR (RTL8712_FIFOCTRL_ + 0x50)
+#define RXFF0_WTPTR (RTL8712_FIFOCTRL_ + 0x54)
+#define RXFF1_RDPTR (RTL8712_FIFOCTRL_ + 0x58)
+#define RXFF1_WTPTR (RTL8712_FIFOCTRL_ + 0x5C)
+#define RXRPT0FF_RDPTR (RTL8712_FIFOCTRL_ + 0x60)
+#define RXRPT0FF_WTPTR (RTL8712_FIFOCTRL_ + 0x64)
+#define RXRPT1FF_RDPTR (RTL8712_FIFOCTRL_ + 0x68)
+#define RXRPT1FF_WTPTR (RTL8712_FIFOCTRL_ + 0x6C)
+#define RX0PKTNUM (RTL8712_FIFOCTRL_ + 0x72)
+#define RX1PKTNUM (RTL8712_FIFOCTRL_ + 0x74)
+#define RXFLTMAP0 (RTL8712_FIFOCTRL_ + 0x76)
+#define RXFLTMAP1 (RTL8712_FIFOCTRL_ + 0x78)
+#define RXFLTMAP2 (RTL8712_FIFOCTRL_ + 0x7A)
+#define RXFLTMAP3 (RTL8712_FIFOCTRL_ + 0x7c)
+#define TBDA (RTL8712_FIFOCTRL_ + 0x84)
+#define THPDA (RTL8712_FIFOCTRL_ + 0x88)
+#define TCDA (RTL8712_FIFOCTRL_ + 0x8C)
+#define TMDA (RTL8712_FIFOCTRL_ + 0x90)
+#define HDA (RTL8712_FIFOCTRL_ + 0x94)
+#define TVODA (RTL8712_FIFOCTRL_ + 0x98)
+#define TVIDA (RTL8712_FIFOCTRL_ + 0x9C)
+#define TBEDA (RTL8712_FIFOCTRL_ + 0xA0)
+#define TBKDA (RTL8712_FIFOCTRL_ + 0xA4)
+#define RCDA (RTL8712_FIFOCTRL_ + 0xA8)
+#define RDSA (RTL8712_FIFOCTRL_ + 0xAC)
+#define TXPKT_NUM_CTRL (RTL8712_FIFOCTRL_ + 0xB0)
+#define TXQ_PGADD (RTL8712_FIFOCTRL_ + 0xB3)
+#define TXFF_PG_NUM (RTL8712_FIFOCTRL_ + 0xB4)
 
-#endif	/* __RTL8712_FIFOCTRL_REGDEF_H__ */
+#endif /* __RTL8712_FIFOCTRL_REGDEF_H__ */
diff --git a/drivers/staging/rtl8712/rtl8712_gp_bitdef.h b/drivers/staging/rtl8712/rtl8712_gp_bitdef.h
index ee651fb3fde3..812b958c23c2 100644
--- a/drivers/staging/rtl8712/rtl8712_gp_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_gp_bitdef.h
@@ -15,34 +15,34 @@
 #define __RTL8712_GP_BITDEF_H__
 
 /*GPIO_CTRL*/
-#define	_GPIO_MOD_MSK			0xFF000000
-#define	_GPIO_MOD_SHT			24
-#define	_GPIO_IO_SEL_MSK		0x00FF0000
-#define	_GPIO_IO_SEL_SHT		16
-#define	_GPIO_OUT_MSK			0x0000FF00
-#define	_GPIO_OUT_SHT			8
-#define	_GPIO_IN_MSK			0x000000FF
-#define	_GPIO_IN_SHT			0
+#define _GPIO_MOD_MSK 0xFF000000
+#define _GPIO_MOD_SHT 24
+#define _GPIO_IO_SEL_MSK 0x00FF0000
+#define _GPIO_IO_SEL_SHT 16
+#define _GPIO_OUT_MSK 0x0000FF00
+#define _GPIO_OUT_SHT 8
+#define _GPIO_IN_MSK 0x000000FF
+#define _GPIO_IN_SHT 0
 
 /*SYS_PINMUX_CFG*/
-#define	_GPIOSEL_MSK			0x0003
-#define	_GPIOSEL_SHT			0
+#define _GPIOSEL_MSK 0x0003
+#define _GPIOSEL_SHT 0
 
 /*LED_CFG*/
-#define _LED1SV				BIT(7)
-#define _LED1CM_MSK			0x0070
-#define _LED1CM_SHT			4
-#define _LED0SV				BIT(3)
-#define _LED0CM_MSK			0x0007
-#define _LED0CM_SHT			0
+#define _LED1SV BIT(7)
+#define _LED1CM_MSK 0x0070
+#define _LED1CM_SHT 4
+#define _LED0SV BIT(3)
+#define _LED0CM_MSK 0x0007
+#define _LED0CM_SHT 0
 
 /*PHY_REG*/
-#define _HST_RDRDY_SHT			0
-#define _HST_RDRDY_MSK			0xFF
-#define _HST_RDRDY			BIT(_HST_RDRDY_SHT)
-#define _CPU_WTBUSY_SHT			1
-#define _CPU_WTBUSY_MSK			0xFF
-#define _CPU_WTBUSY			BIT(_CPU_WTBUSY_SHT)
+#define _HST_RDRDY_SHT 0
+#define _HST_RDRDY_MSK 0xFF
+#define _HST_RDRDY BIT(_HST_RDRDY_SHT)
+#define _CPU_WTBUSY_SHT 1
+#define _CPU_WTBUSY_MSK 0xFF
+#define _CPU_WTBUSY BIT(_CPU_WTBUSY_SHT)
 
 /* 11. General Purpose Registers   (Offset: 0x02E0 - 0x02FF)*/
 
@@ -50,19 +50,19 @@
 
 /*----------------------------------------------------------------------------*/
 
-#define		GPIOMUX_EN	BIT(3)	/* When this bit is set to "1",
+#define GPIOMUX_EN \
+	BIT(3) /* When this bit is set to "1",
 					 * GPIO PINs will switch to MAC
 					 * GPIO Function
 					 */
-#define		GPIOSEL_GPIO	0	/* UART or JTAG or pure GPIO*/
-#define		GPIOSEL_PHYDBG	1	/* PHYDBG*/
-#define		GPIOSEL_BT	2	/* BT_coex*/
-#define		GPIOSEL_WLANDBG	3	/* WLANDBG*/
-#define		GPIOSEL_GPIO_MASK	(~(BIT(0) | BIT(1)))
+#define GPIOSEL_GPIO 0 /* UART or JTAG or pure GPIO*/
+#define GPIOSEL_PHYDBG 1 /* PHYDBG*/
+#define GPIOSEL_BT 2 /* BT_coex*/
+#define GPIOSEL_WLANDBG 3 /* WLANDBG*/
+#define GPIOSEL_GPIO_MASK (~(BIT(0) | BIT(1)))
 /* HW Radio OFF switch (GPIO BIT) */
-#define		HAL_8192S_HW_GPIO_OFF_BIT	BIT(3)
-#define		HAL_8192S_HW_GPIO_OFF_MASK	0xF7
-#define		HAL_8192S_HW_GPIO_WPS_BIT	BIT(4)
-
-#endif	/*__RTL8712_GP_BITDEF_H__*/
+#define HAL_8192S_HW_GPIO_OFF_BIT BIT(3)
+#define HAL_8192S_HW_GPIO_OFF_MASK 0xF7
+#define HAL_8192S_HW_GPIO_WPS_BIT BIT(4)
 
+#endif /*__RTL8712_GP_BITDEF_H__*/
diff --git a/drivers/staging/rtl8712/rtl8712_gp_regdef.h b/drivers/staging/rtl8712/rtl8712_gp_regdef.h
index 892a7fb13923..81d518f4b119 100644
--- a/drivers/staging/rtl8712/rtl8712_gp_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_gp_regdef.h
@@ -14,16 +14,15 @@
 #ifndef __RTL8712_GP_REGDEF_H__
 #define __RTL8712_GP_REGDEF_H__
 
-#define PSTIMER			(RTL8712_GP_ + 0x00)
-#define TIMER1			(RTL8712_GP_ + 0x04)
-#define TIMER2			(RTL8712_GP_ + 0x08)
-#define GPIO_CTRL		(RTL8712_GP_ + 0x0C)
-#define GPIO_IO_SEL		(RTL8712_GP_ + 0x0E)
-#define GPIO_INTCTRL		(RTL8712_GP_ + 0x10)
-#define MAC_PINMUX_CTRL		(RTL8712_GP_ + 0x11)
-#define LEDCFG			(RTL8712_GP_ + 0x12)
-#define PHY_REG_RPT		(RTL8712_GP_ + 0x13)
-#define PHY_REG_DATA		(RTL8712_GP_ + 0x14)
-
-#endif	/*__RTL8712_GP_REGDEF_H__ */
+#define PSTIMER (RTL8712_GP_ + 0x00)
+#define TIMER1 (RTL8712_GP_ + 0x04)
+#define TIMER2 (RTL8712_GP_ + 0x08)
+#define GPIO_CTRL (RTL8712_GP_ + 0x0C)
+#define GPIO_IO_SEL (RTL8712_GP_ + 0x0E)
+#define GPIO_INTCTRL (RTL8712_GP_ + 0x10)
+#define MAC_PINMUX_CTRL (RTL8712_GP_ + 0x11)
+#define LEDCFG (RTL8712_GP_ + 0x12)
+#define PHY_REG_RPT (RTL8712_GP_ + 0x13)
+#define PHY_REG_DATA (RTL8712_GP_ + 0x14)
 
+#endif /*__RTL8712_GP_REGDEF_H__ */
diff --git a/drivers/staging/rtl8712/rtl8712_hal.h b/drivers/staging/rtl8712/rtl8712_hal.h
index 66cc4645e2d1..c31771ea503c 100644
--- a/drivers/staging/rtl8712/rtl8712_hal.h
+++ b/drivers/staging/rtl8712/rtl8712_hal.h
@@ -16,9 +16,9 @@
 
 enum _HW_VERSION {
 	RTL8712_FPGA,
-	RTL8712_1stCUT,	/*A Cut (RTL8712_ASIC)*/
-	RTL8712_2ndCUT,	/*B Cut*/
-	RTL8712_3rdCUT,	/*C Cut*/
+	RTL8712_1stCUT, /*A Cut (RTL8712_ASIC)*/
+	RTL8712_2ndCUT, /*B Cut*/
+	RTL8712_3rdCUT, /*C Cut*/
 };
 
 enum _LOOPBACK_TYPE {
@@ -34,11 +34,7 @@ enum RTL871X_HCI_TYPE {
 	RTL8712_USB,
 };
 
-enum RTL8712_RF_CONFIG {
-	RTL8712_RF_1T1R,
-	RTL8712_RF_1T2R,
-	RTL8712_RF_2T2R
-};
+enum RTL8712_RF_CONFIG { RTL8712_RF_1T1R, RTL8712_RF_1T2R, RTL8712_RF_2T2R };
 
 enum _RTL8712_HCI_TYPE_ {
 	RTL8712_HCI_TYPE_PCIE = 0x01,
@@ -51,29 +47,29 @@ enum _RTL8712_HCI_TYPE_ {
 	RTL8712_HCI_TYPE_72SDIO = 0x14
 };
 
-struct fw_priv {   /*8-bytes alignment required*/
+struct fw_priv { /*8-bytes alignment required*/
 	/*--- long word 0 ----*/
-	unsigned char signature_0;  /*0x12: CE product, 0x92: IT product*/
-	unsigned char signature_1;  /*0x87: CE product, 0x81: IT product*/
+	unsigned char signature_0; /*0x12: CE product, 0x92: IT product*/
+	unsigned char signature_1; /*0x87: CE product, 0x81: IT product*/
 	unsigned char hci_sel; /*0x81: PCI-AP, 01:PCIe, 02: 92S-U, 0x82: USB-AP,
 				* 0x12: 72S-U, 03:SDIO
 				*/
 	unsigned char chip_version; /*the same value as register value*/
 	unsigned char customer_ID_0; /*customer  ID low byte*/
 	unsigned char customer_ID_1; /*customer  ID high byte*/
-	unsigned char rf_config;  /*0x11:  1T1R, 0x12: 1T2R, 0x92: 1T2R turbo,
+	unsigned char rf_config; /*0x11:  1T1R, 0x12: 1T2R, 0x92: 1T2R turbo,
 				   * 0x22: 2T2R
 				   */
-	unsigned char usb_ep_num;  /* 4: 4EP, 6: 6EP, 11: 11EP*/
+	unsigned char usb_ep_num; /* 4: 4EP, 6: 6EP, 11: 11EP*/
 	/*--- long word 1 ----*/
 	unsigned char regulatory_class_0; /*regulatory class bit map 0*/
 	unsigned char regulatory_class_1; /*regulatory class bit map 1*/
 	unsigned char regulatory_class_2; /*regulatory class bit map 2*/
 	unsigned char regulatory_class_3; /*regulatory class bit map 3*/
-	unsigned char rfintfs;    /* 0:SWSI, 1:HWSI, 2:HWPI*/
+	unsigned char rfintfs; /* 0:SWSI, 1:HWSI, 2:HWPI*/
 	unsigned char def_nettype;
 	unsigned char turbo_mode;
-	unsigned char low_power_mode;/* 0: normal mode, 1: low power mode*/
+	unsigned char low_power_mode; /* 0: normal mode, 1: low power mode*/
 	/*--- long word 2 ----*/
 	unsigned char lbk_mode; /*0x00: normal, 0x03: MACLBK, 0x01: PHYLBK*/
 	unsigned char mp_mode; /* 1: for MP use, 0: for normal driver */
@@ -84,59 +80,59 @@ struct fw_priv {   /*8-bytes alignment required*/
 	unsigned char rsvd024;
 	unsigned char rsvd025;
 	/*--- long word 3 ----*/
-	unsigned char qos_en;    /*1: QoS enable*/
-	unsigned char bw_40MHz_en;   /*1: 40MHz BW enable*/
-	unsigned char AMSDU2AMPDU_en;   /*1: 4181 convert AMSDU to AMPDU,
+	unsigned char qos_en; /*1: QoS enable*/
+	unsigned char bw_40MHz_en; /*1: 40MHz BW enable*/
+	unsigned char AMSDU2AMPDU_en; /*1: 4181 convert AMSDU to AMPDU,
 					 * 0: disable
 					 */
-	unsigned char AMPDU_en;   /*1: 11n AMPDU enable*/
+	unsigned char AMPDU_en; /*1: 11n AMPDU enable*/
 	unsigned char rate_control_offload; /*1: FW offloads,0: driver handles*/
-	unsigned char aggregation_offload;  /*1: FW offloads,0: driver handles*/
+	unsigned char aggregation_offload; /*1: FW offloads,0: driver handles*/
 	unsigned char rsvd030;
 	unsigned char rsvd031;
 	/*--- long word 4 ----*/
-	unsigned char beacon_offload;   /* 1. FW offloads, 0: driver handles*/
-	unsigned char MLME_offload;   /* 2. FW offloads, 0: driver handles*/
-	unsigned char hwpc_offload;   /* 3. FW offloads, 0: driver handles*/
+	unsigned char beacon_offload; /* 1. FW offloads, 0: driver handles*/
+	unsigned char MLME_offload; /* 2. FW offloads, 0: driver handles*/
+	unsigned char hwpc_offload; /* 3. FW offloads, 0: driver handles*/
 	unsigned char tcp_checksum_offload; /*4. FW offloads,0: driver handles*/
-	unsigned char tcp_offload;    /* 5. FW offloads, 0: driver handles*/
+	unsigned char tcp_offload; /* 5. FW offloads, 0: driver handles*/
 	unsigned char ps_control_offload; /* 6. FW offloads, 0: driver handles*/
-	unsigned char WWLAN_offload;   /* 7. FW offloads, 0: driver handles*/
+	unsigned char WWLAN_offload; /* 7. FW offloads, 0: driver handles*/
 	unsigned char rsvd040;
 	/*--- long word 5 ----*/
-	unsigned char tcp_tx_frame_len_L;  /*tcp tx packet length low byte*/
-	unsigned char tcp_tx_frame_len_H;  /*tcp tx packet length high byte*/
-	unsigned char tcp_rx_frame_len_L;  /*tcp rx packet length low byte*/
-	unsigned char tcp_rx_frame_len_H;  /*tcp rx packet length high byte*/
+	unsigned char tcp_tx_frame_len_L; /*tcp tx packet length low byte*/
+	unsigned char tcp_tx_frame_len_H; /*tcp tx packet length high byte*/
+	unsigned char tcp_rx_frame_len_L; /*tcp rx packet length low byte*/
+	unsigned char tcp_rx_frame_len_H; /*tcp rx packet length high byte*/
 	unsigned char rsvd050;
 	unsigned char rsvd051;
 	unsigned char rsvd052;
 	unsigned char rsvd053;
 };
 
-struct fw_hdr {/*8-byte alignment required*/
-	unsigned short	signature;
-	unsigned short	version;	/* 0x8000 ~ 0x8FFF for FPGA version,
+struct fw_hdr { /*8-byte alignment required*/
+	unsigned short signature;
+	unsigned short version; /* 0x8000 ~ 0x8FFF for FPGA version,
 					 * 0x0000 ~ 0x7FFF for ASIC version,
 					 */
-	unsigned int		dmem_size;    /*define the size of boot loader*/
-	unsigned int		img_IMEM_size; /*define the size of FW in IMEM*/
-	unsigned int		img_SRAM_size; /*define the size of FW in SRAM*/
-	unsigned int		fw_priv_sz; /*define the size of DMEM variable*/
-	unsigned short	efuse_addr;
-	unsigned short	h2ccnd_resp_addr;
-	unsigned int		SVNRevision;
-	unsigned int		release_time; /*Mon:Day:Hr:Min*/
-	struct fw_priv	fwpriv;
+	unsigned int dmem_size; /*define the size of boot loader*/
+	unsigned int img_IMEM_size; /*define the size of FW in IMEM*/
+	unsigned int img_SRAM_size; /*define the size of FW in SRAM*/
+	unsigned int fw_priv_sz; /*define the size of DMEM variable*/
+	unsigned short efuse_addr;
+	unsigned short h2ccnd_resp_addr;
+	unsigned int SVNRevision;
+	unsigned int release_time; /*Mon:Day:Hr:Min*/
+	struct fw_priv fwpriv;
 };
 
 struct hal_priv {
 	/*Endpoint handles*/
-	struct  net_device *pipehdls_r8712[10];
+	struct net_device *pipehdls_r8712[10];
 	u8 (*hal_bus_init)(struct _adapter *adapter);
 };
 
-uint	 rtl8712_hal_init(struct _adapter *padapter);
+uint rtl8712_hal_init(struct _adapter *padapter);
 int rtl871x_load_fw(struct _adapter *padapter);
 
 #endif
diff --git a/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h b/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h
index e9732a1bcd7e..9e8ab4f18d28 100644
--- a/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h
@@ -9,36 +9,35 @@
 
 /*HIMR*/
 /*HISR*/
-#define	_CPUERR					BIT(29)
-#define	_ATIMEND				BIT(28)
-#define	_TXBCNOK				BIT(27)
-#define	_TXBCNERR				BIT(26)
-#define	_BCNDMAINT4				BIT(25)
-#define	_BCNDMAINT3				BIT(24)
-#define	_BCNDMAINT2				BIT(23)
-#define	_BCNDMAINT1				BIT(22)
-#define	_BCNDOK4				BIT(21)
-#define	_BCNDOK3				BIT(20)
-#define	_BCNDOK2				BIT(19)
-#define	_BCNDOK1				BIT(18)
-#define	_TIMEOUT2				BIT(17)
-#define	_TIMEOUT1				BIT(16)
-#define	_TXFOVW					BIT(15)
-#define	_PSTIMEOUT				BIT(14)
-#define	_BCNDMAINT0				BIT(13)
-#define	_FOVW					BIT(12)
-#define	_RDU					BIT(11)
-#define	_RXCMDOK				BIT(10)
-#define	_BCNDOK0				BIT(9)
-#define	_HIGHDOK				BIT(8)
-#define	_COMDOK					BIT(7)
-#define	_MGTDOK					BIT(6)
-#define	_HCCADOK				BIT(5)
-#define	_BKDOK					BIT(4)
-#define	_BEDOK					BIT(3)
-#define	_VIDOK					BIT(2)
-#define	_VODOK					BIT(1)
-#define	_RXOK					BIT(0)
-
-#endif	/*__RTL8712_INTERRUPT_BITDEF_H__*/
+#define _CPUERR BIT(29)
+#define _ATIMEND BIT(28)
+#define _TXBCNOK BIT(27)
+#define _TXBCNERR BIT(26)
+#define _BCNDMAINT4 BIT(25)
+#define _BCNDMAINT3 BIT(24)
+#define _BCNDMAINT2 BIT(23)
+#define _BCNDMAINT1 BIT(22)
+#define _BCNDOK4 BIT(21)
+#define _BCNDOK3 BIT(20)
+#define _BCNDOK2 BIT(19)
+#define _BCNDOK1 BIT(18)
+#define _TIMEOUT2 BIT(17)
+#define _TIMEOUT1 BIT(16)
+#define _TXFOVW BIT(15)
+#define _PSTIMEOUT BIT(14)
+#define _BCNDMAINT0 BIT(13)
+#define _FOVW BIT(12)
+#define _RDU BIT(11)
+#define _RXCMDOK BIT(10)
+#define _BCNDOK0 BIT(9)
+#define _HIGHDOK BIT(8)
+#define _COMDOK BIT(7)
+#define _MGTDOK BIT(6)
+#define _HCCADOK BIT(5)
+#define _BKDOK BIT(4)
+#define _BEDOK BIT(3)
+#define _VIDOK BIT(2)
+#define _VODOK BIT(1)
+#define _RXOK BIT(0)
 
+#endif /*__RTL8712_INTERRUPT_BITDEF_H__*/
diff --git a/drivers/staging/rtl8712/rtl8712_led.c b/drivers/staging/rtl8712/rtl8712_led.c
index 6d9be5dec4e7..a6e1daf58682 100644
--- a/drivers/staging/rtl8712/rtl8712_led.c
+++ b/drivers/staging/rtl8712/rtl8712_led.c
@@ -23,15 +23,15 @@
  *
  * Default LED behavior.
  */
-#define LED_BLINK_NORMAL_INTERVAL	100
-#define LED_BLINK_SLOWLY_INTERVAL	200
-#define LED_BLINK_LONG_INTERVAL	400
+#define LED_BLINK_NORMAL_INTERVAL 100
+#define LED_BLINK_SLOWLY_INTERVAL 200
+#define LED_BLINK_LONG_INTERVAL 400
 
-#define LED_BLINK_NO_LINK_INTERVAL_ALPHA	1000
-#define LED_BLINK_LINK_INTERVAL_ALPHA		500
-#define LED_BLINK_SCAN_INTERVAL_ALPHA		180
-#define LED_BLINK_FASTER_INTERVAL_ALPHA		50
-#define LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA	5000
+#define LED_BLINK_NO_LINK_INTERVAL_ALPHA 1000
+#define LED_BLINK_LINK_INTERVAL_ALPHA 500
+#define LED_BLINK_SCAN_INTERVAL_ALPHA 180
+#define LED_BLINK_FASTER_INTERVAL_ALPHA 50
+#define LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA 5000
 
 /*===========================================================================
  * LED object.
@@ -49,13 +49,13 @@ enum _LED_STATE_871x {
 			     * for scanning.
 			     */
 	LED_NO_LINK_BLINK = 7, /* LED is blinking during no link state. */
-	LED_BLINK_StartToBlink = 8,/* Customized for Sercomm Printer
+	LED_BLINK_StartToBlink = 8, /* Customized for Sercomm Printer
 				    * Server case
 				    */
-	LED_BLINK_WPS = 9,	/* LED is blinkg during WPS communication */
+	LED_BLINK_WPS = 9, /* LED is blinkg during WPS communication */
 	LED_TXRX_BLINK = 10,
-	LED_BLINK_WPS_STOP = 11,	/*for ALPHA */
-	LED_BLINK_WPS_STOP_OVERLAP = 12,	/*for BELKIN */
+	LED_BLINK_WPS_STOP = 11, /*for ALPHA */
+	LED_BLINK_WPS_STOP_OVERLAP = 12, /*for BELKIN */
 };
 
 /*===========================================================================
@@ -75,7 +75,7 @@ static void BlinkWorkItemCallback(struct work_struct *work);
  *		Initialize an LED_871x object.
  */
 static void InitLed871x(struct _adapter *padapter, struct LED_871x *pLed,
-			enum LED_PIN_871x	LedPin)
+			enum LED_PIN_871x LedPin)
 {
 	pLed->padapter = padapter;
 	pLed->LedPin = LedPin;
@@ -135,7 +135,7 @@ static void SwLedOn(struct _adapter *padapter, struct LED_871x *pLed)
  */
 static void SwLedOff(struct _adapter *padapter, struct LED_871x *pLed)
 {
-	u8	LedCfg;
+	u8 LedCfg;
 
 	if (padapter->surprise_removed || padapter->driver_stopped)
 		return;
@@ -166,7 +166,7 @@ static void SwLedOff(struct _adapter *padapter, struct LED_871x *pLed)
  */
 void r8712_InitSwLeds(struct _adapter *padapter)
 {
-	struct led_priv	*pledpriv = &padapter->ledpriv;
+	struct led_priv *pledpriv = &padapter->ledpriv;
 
 	pledpriv->LedControlHandler = LedControl871x;
 	InitLed871x(padapter, &pledpriv->SwLed0, LED_PIN_LED0);
@@ -178,7 +178,7 @@ void r8712_InitSwLeds(struct _adapter *padapter)
  */
 void r8712_DeInitSwLeds(struct _adapter *padapter)
 {
-	struct led_priv	*ledpriv = &padapter->ledpriv;
+	struct led_priv *ledpriv = &padapter->ledpriv;
 
 	DeInitLed871x(&ledpriv->SwLed0);
 	DeInitLed871x(&ledpriv->SwLed1);
@@ -212,7 +212,7 @@ static void SwLedBlink(struct LED_871x *pLed)
 			bStopBlinking = true;
 		if (check_fwstate(pmlmepriv, _FW_LINKED) &&
 		    ((pmlmepriv->fw_state & WIFI_ADHOC_STATE) ||
-		    (pmlmepriv->fw_state & WIFI_ADHOC_MASTER_STATE)))
+		     (pmlmepriv->fw_state & WIFI_ADHOC_MASTER_STATE)))
 			bStopBlinking = true;
 		else if (pLed->BlinkTimes == 0)
 			bStopBlinking = true;
@@ -226,10 +226,9 @@ static void SwLedBlink(struct LED_871x *pLed)
 		break;
 	}
 	if (bStopBlinking) {
-		if (check_fwstate(pmlmepriv, _FW_LINKED) &&
-		    !pLed->bLedOn)
+		if (check_fwstate(pmlmepriv, _FW_LINKED) && !pLed->bLedOn)
 			SwLedOn(padapter, pLed);
-		else if (check_fwstate(pmlmepriv, _FW_LINKED) &&  pLed->bLedOn)
+		else if (check_fwstate(pmlmepriv, _FW_LINKED) && pLed->bLedOn)
 			SwLedOff(padapter, pLed);
 		pLed->BlinkTimes = 0;
 		pLed->bLedBlinkInProgress = false;
@@ -243,21 +242,25 @@ static void SwLedBlink(struct LED_871x *pLed)
 		/* Schedule a timer to toggle LED state. */
 		switch (pLed->CurrLedState) {
 		case LED_BLINK_NORMAL:
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
+			mod_timer(&pLed->BlinkTimer,
+				  jiffies + msecs_to_jiffies(
+						    LED_BLINK_NORMAL_INTERVAL));
 			break;
 		case LED_BLINK_SLOWLY:
 		case LED_BLINK_StartToBlink:
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SLOWLY_INTERVAL));
+			mod_timer(&pLed->BlinkTimer,
+				  jiffies + msecs_to_jiffies(
+						    LED_BLINK_SLOWLY_INTERVAL));
 			break;
 		case LED_BLINK_WPS:
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_LONG_INTERVAL));
+			mod_timer(&pLed->BlinkTimer,
+				  jiffies + msecs_to_jiffies(
+						    LED_BLINK_LONG_INTERVAL));
 			break;
 		default:
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SLOWLY_INTERVAL));
+			mod_timer(&pLed->BlinkTimer,
+				  jiffies + msecs_to_jiffies(
+						    LED_BLINK_SLOWLY_INTERVAL));
 			break;
 		}
 	}
@@ -302,16 +305,18 @@ static void SwLedBlink1(struct LED_871x *pLed)
 			pLed->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies + msecs_to_jiffies(
+					    LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 		break;
 	case LED_BLINK_NORMAL:
 		if (pLed->bLedOn)
 			pLed->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies + msecs_to_jiffies(
+					    LED_BLINK_LINK_INTERVAL_ALPHA));
 		break;
 	case LED_SCAN_BLINK:
 		pLed->BlinkTimes--;
@@ -325,8 +330,11 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = LED_STATE_OFF;
 				else
 					pLed->BlinkingLedState = LED_STATE_ON;
-				mod_timer(&pLed->BlinkTimer, jiffies +
-					  msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
+				mod_timer(
+					&pLed->BlinkTimer,
+					jiffies +
+						msecs_to_jiffies(
+							LED_BLINK_LINK_INTERVAL_ALPHA));
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedNoLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_SLOWLY;
@@ -334,8 +342,11 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = LED_STATE_OFF;
 				else
 					pLed->BlinkingLedState = LED_STATE_ON;
-				mod_timer(&pLed->BlinkTimer, jiffies +
-					  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+				mod_timer(
+					&pLed->BlinkTimer,
+					jiffies +
+						msecs_to_jiffies(
+							LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 			}
 			pLed->bLedScanBlinkInProgress = false;
 		} else {
@@ -343,8 +354,11 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_TXRX_BLINK:
@@ -359,8 +373,11 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = LED_STATE_OFF;
 				else
 					pLed->BlinkingLedState = LED_STATE_ON;
-				mod_timer(&pLed->BlinkTimer, jiffies +
-					  msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
+				mod_timer(
+					&pLed->BlinkTimer,
+					jiffies +
+						msecs_to_jiffies(
+							LED_BLINK_LINK_INTERVAL_ALPHA));
 			} else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				pLed->bLedNoLinkBlinkInProgress = true;
 				pLed->CurrLedState = LED_BLINK_SLOWLY;
@@ -368,8 +385,11 @@ static void SwLedBlink1(struct LED_871x *pLed)
 					pLed->BlinkingLedState = LED_STATE_OFF;
 				else
 					pLed->BlinkingLedState = LED_STATE_ON;
-				mod_timer(&pLed->BlinkTimer, jiffies +
-					  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+				mod_timer(
+					&pLed->BlinkTimer,
+					jiffies +
+						msecs_to_jiffies(
+							LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 			}
 			pLed->BlinkTimes = 0;
 			pLed->bLedBlinkInProgress = false;
@@ -378,8 +398,11 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_FASTER_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_BLINK_WPS:
@@ -387,14 +410,18 @@ static void SwLedBlink1(struct LED_871x *pLed)
 			pLed->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies + msecs_to_jiffies(
+					    LED_BLINK_SCAN_INTERVAL_ALPHA));
 		break;
-	case LED_BLINK_WPS_STOP:	/* WPS success */
+	case LED_BLINK_WPS_STOP: /* WPS success */
 		if (pLed->BlinkingLedState == LED_STATE_ON) {
 			pLed->BlinkingLedState = LED_STATE_OFF;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA));
 			bStopBlinking = false;
 		} else {
 			bStopBlinking = true;
@@ -406,8 +433,11 @@ static void SwLedBlink1(struct LED_871x *pLed)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_LINK_INTERVAL_ALPHA));
 		}
 		pLed->bLedWPSBlinkInProgress = false;
 		break;
@@ -448,8 +478,11 @@ static void SwLedBlink2(struct LED_871x *pLed)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_TXRX_BLINK:
@@ -472,8 +505,11 @@ static void SwLedBlink2(struct LED_871x *pLed)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_FASTER_INTERVAL_ALPHA));
 		}
 		break;
 	default:
@@ -490,9 +526,8 @@ static void SwLedBlink3(struct LED_871x *pLed)
 	/* Change LED according to BlinkingLedState specified. */
 	if (pLed->BlinkingLedState == LED_STATE_ON)
 		SwLedOn(padapter, pLed);
-	else
-		if (pLed->CurrLedState != LED_BLINK_WPS_STOP)
-			SwLedOff(padapter, pLed);
+	else if (pLed->CurrLedState != LED_BLINK_WPS_STOP)
+		SwLedOff(padapter, pLed);
 	switch (pLed->CurrLedState) {
 	case LED_SCAN_BLINK:
 		pLed->BlinkTimes--;
@@ -516,8 +551,11 @@ static void SwLedBlink3(struct LED_871x *pLed)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_TXRX_BLINK:
@@ -542,8 +580,11 @@ static void SwLedBlink3(struct LED_871x *pLed)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_FASTER_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_BLINK_WPS:
@@ -551,14 +592,18 @@ static void SwLedBlink3(struct LED_871x *pLed)
 			pLed->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies + msecs_to_jiffies(
+					    LED_BLINK_SCAN_INTERVAL_ALPHA));
 		break;
-	case LED_BLINK_WPS_STOP:	/*WPS success*/
+	case LED_BLINK_WPS_STOP: /*WPS success*/
 		if (pLed->BlinkingLedState == LED_STATE_ON) {
 			pLed->BlinkingLedState = LED_STATE_OFF;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA));
 			bStopBlinking = false;
 		} else {
 			bStopBlinking = true;
@@ -578,7 +623,7 @@ static void SwLedBlink3(struct LED_871x *pLed)
 static void SwLedBlink4(struct LED_871x *pLed)
 {
 	struct _adapter *padapter = pLed->padapter;
-	struct led_priv	*ledpriv = &padapter->ledpriv;
+	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct LED_871x *pLed1 = &ledpriv->SwLed1;
 	u8 bStopBlinking = false;
 
@@ -599,18 +644,21 @@ static void SwLedBlink4(struct LED_871x *pLed)
 			pLed->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies + msecs_to_jiffies(
+					    LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 		break;
 	case LED_BLINK_StartToBlink:
 		if (pLed->bLedOn) {
 			pLed->BlinkingLedState = LED_STATE_OFF;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SLOWLY_INTERVAL));
+			mod_timer(&pLed->BlinkTimer,
+				  jiffies + msecs_to_jiffies(
+						    LED_BLINK_SLOWLY_INTERVAL));
 		} else {
 			pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
+			mod_timer(&pLed->BlinkTimer,
+				  jiffies + msecs_to_jiffies(
+						    LED_BLINK_NORMAL_INTERVAL));
 		}
 		break;
 	case LED_SCAN_BLINK:
@@ -624,16 +672,22 @@ static void SwLedBlink4(struct LED_871x *pLed)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 			pLed->bLedScanBlinkInProgress = false;
 		} else {
 			if (pLed->bLedOn)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_TXRX_BLINK:
@@ -647,38 +701,47 @@ static void SwLedBlink4(struct LED_871x *pLed)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 			pLed->bLedBlinkInProgress = false;
 		} else {
 			if (pLed->bLedOn)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_FASTER_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_BLINK_WPS:
 		if (pLed->bLedOn) {
 			pLed->BlinkingLedState = LED_STATE_OFF;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SLOWLY_INTERVAL));
+			mod_timer(&pLed->BlinkTimer,
+				  jiffies + msecs_to_jiffies(
+						    LED_BLINK_SLOWLY_INTERVAL));
 		} else {
 			pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
+			mod_timer(&pLed->BlinkTimer,
+				  jiffies + msecs_to_jiffies(
+						    LED_BLINK_NORMAL_INTERVAL));
 		}
 		break;
-	case LED_BLINK_WPS_STOP:	/*WPS authentication fail*/
+	case LED_BLINK_WPS_STOP: /*WPS authentication fail*/
 		if (pLed->bLedOn)
 			pLed->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies +
+				  msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
 		break;
-	case LED_BLINK_WPS_STOP_OVERLAP:	/*WPS session overlap */
+	case LED_BLINK_WPS_STOP_OVERLAP: /*WPS session overlap */
 		pLed->BlinkTimes--;
 		if (pLed->BlinkTimes == 0) {
 			if (pLed->bLedOn)
@@ -689,15 +752,19 @@ static void SwLedBlink4(struct LED_871x *pLed)
 		if (bStopBlinking) {
 			pLed->BlinkTimes = 10;
 			pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_LINK_INTERVAL_ALPHA));
 		} else {
 			if (pLed->bLedOn)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
+			mod_timer(&pLed->BlinkTimer,
+				  jiffies + msecs_to_jiffies(
+						    LED_BLINK_NORMAL_INTERVAL));
 		}
 		break;
 	default:
@@ -724,16 +791,22 @@ static void SwLedBlink5(struct LED_871x *pLed)
 			pLed->CurrLedState = LED_STATE_ON;
 			pLed->BlinkingLedState = LED_STATE_ON;
 			if (!pLed->bLedOn)
-				mod_timer(&pLed->BlinkTimer, jiffies +
-					  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+				mod_timer(
+					&pLed->BlinkTimer,
+					jiffies +
+						msecs_to_jiffies(
+							LED_BLINK_FASTER_INTERVAL_ALPHA));
 			pLed->bLedScanBlinkInProgress = false;
 		} else {
 			if (pLed->bLedOn)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_TXRX_BLINK:
@@ -744,16 +817,22 @@ static void SwLedBlink5(struct LED_871x *pLed)
 			pLed->CurrLedState = LED_STATE_ON;
 			pLed->BlinkingLedState = LED_STATE_ON;
 			if (!pLed->bLedOn)
-				mod_timer(&pLed->BlinkTimer, jiffies +
-					  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+				mod_timer(
+					&pLed->BlinkTimer,
+					jiffies +
+						msecs_to_jiffies(
+							LED_BLINK_FASTER_INTERVAL_ALPHA));
 			pLed->bLedBlinkInProgress = false;
 		} else {
 			if (pLed->bLedOn)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_FASTER_INTERVAL_ALPHA));
 		}
 		break;
 	default:
@@ -787,8 +866,11 @@ static void SwLedBlink6(struct LED_871x *pLed)
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_FASTER_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_BLINK_WPS:
@@ -796,8 +878,9 @@ static void SwLedBlink6(struct LED_871x *pLed)
 			pLed->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies + msecs_to_jiffies(
+					    LED_BLINK_SCAN_INTERVAL_ALPHA));
 		break;
 
 	default:
@@ -811,7 +894,7 @@ static void SwLedBlink6(struct LED_871x *pLed)
  */
 static void BlinkTimerCallback(struct timer_list *t)
 {
-	struct LED_871x  *pLed = from_timer(pLed, t, BlinkTimer);
+	struct LED_871x *pLed = from_timer(pLed, t, BlinkTimer);
 
 	/* This fixed the crash problem on Fedora 12 when trying to do the
 	 * insmod;ifconfig up;rmmod commands.
@@ -827,9 +910,9 @@ static void BlinkTimerCallback(struct timer_list *t)
  */
 static void BlinkWorkItemCallback(struct work_struct *work)
 {
-	struct LED_871x *pLed = container_of(work, struct LED_871x,
-				BlinkWorkItem);
-	struct led_priv	*ledpriv = &pLed->padapter->ledpriv;
+	struct LED_871x *pLed =
+		container_of(work, struct LED_871x, BlinkWorkItem);
+	struct led_priv *ledpriv = &pLed->padapter->ledpriv;
 
 	switch (ledpriv->LedStrategy) {
 	case SW_LED_MODE0:
@@ -899,8 +982,11 @@ static void SwLedControlMode1(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_LINK:
@@ -922,8 +1008,11 @@ static void SwLedControlMode1(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_LINK_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_SITE_SURVEY:
@@ -952,8 +1041,11 @@ static void SwLedControlMode1(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_TX:
@@ -977,8 +1069,11 @@ static void SwLedControlMode1(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_FASTER_INTERVAL_ALPHA));
 		}
 		break;
 
@@ -1007,8 +1102,11 @@ static void SwLedControlMode1(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_STOP_WPS:
@@ -1035,8 +1133,11 @@ static void SwLedControlMode1(struct _adapter *padapter,
 		pLed->CurrLedState = LED_BLINK_WPS_STOP;
 		if (pLed->bLedOn) {
 			pLed->BlinkingLedState = LED_STATE_OFF;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA));
 		} else {
 			pLed->BlinkingLedState = LED_STATE_ON;
 			mod_timer(&pLed->BlinkTimer,
@@ -1054,8 +1155,9 @@ static void SwLedControlMode1(struct _adapter *padapter,
 			pLed->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies + msecs_to_jiffies(
+					    LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 		break;
 	case LED_CTL_POWER_OFF:
 		pLed->CurrLedState = LED_STATE_OFF;
@@ -1080,8 +1182,7 @@ static void SwLedControlMode1(struct _adapter *padapter,
 			del_timer(&pLed->BlinkTimer);
 			pLed->bLedScanBlinkInProgress = false;
 		}
-		mod_timer(&pLed->BlinkTimer,
-			  jiffies + msecs_to_jiffies(0));
+		mod_timer(&pLed->BlinkTimer, jiffies + msecs_to_jiffies(0));
 		break;
 	default:
 		break;
@@ -1091,7 +1192,7 @@ static void SwLedControlMode1(struct _adapter *padapter,
 static void SwLedControlMode2(struct _adapter *padapter,
 			      enum LED_CTL_MODE LedAction)
 {
-	struct led_priv	 *ledpriv = &padapter->ledpriv;
+	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct LED_871x *pLed = &ledpriv->SwLed0;
 
@@ -1114,8 +1215,11 @@ static void SwLedControlMode2(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 
@@ -1133,8 +1237,11 @@ static void SwLedControlMode2(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_FASTER_INTERVAL_ALPHA));
 		}
 		break;
 
@@ -1150,8 +1257,7 @@ static void SwLedControlMode2(struct _adapter *padapter,
 			pLed->bLedScanBlinkInProgress = false;
 		}
 
-		mod_timer(&pLed->BlinkTimer,
-			  jiffies + msecs_to_jiffies(0));
+		mod_timer(&pLed->BlinkTimer, jiffies + msecs_to_jiffies(0));
 		break;
 
 	case LED_CTL_START_WPS: /*wait until xinpin finish*/
@@ -1177,16 +1283,14 @@ static void SwLedControlMode2(struct _adapter *padapter,
 		pLed->bLedWPSBlinkInProgress = false;
 		pLed->CurrLedState = LED_STATE_ON;
 		pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer,
-			  jiffies + msecs_to_jiffies(0));
+		mod_timer(&pLed->BlinkTimer, jiffies + msecs_to_jiffies(0));
 		break;
 
 	case LED_CTL_STOP_WPS_FAIL:
 		pLed->bLedWPSBlinkInProgress = false;
 		pLed->CurrLedState = LED_STATE_OFF;
 		pLed->BlinkingLedState = LED_STATE_OFF;
-		mod_timer(&pLed->BlinkTimer,
-			  jiffies + msecs_to_jiffies(0));
+		mod_timer(&pLed->BlinkTimer, jiffies + msecs_to_jiffies(0));
 		break;
 
 	case LED_CTL_START_TO_LINK:
@@ -1213,8 +1317,7 @@ static void SwLedControlMode2(struct _adapter *padapter,
 			del_timer(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
-		mod_timer(&pLed->BlinkTimer,
-			  jiffies + msecs_to_jiffies(0));
+		mod_timer(&pLed->BlinkTimer, jiffies + msecs_to_jiffies(0));
 		break;
 	default:
 		break;
@@ -1224,7 +1327,7 @@ static void SwLedControlMode2(struct _adapter *padapter,
 static void SwLedControlMode3(struct _adapter *padapter,
 			      enum LED_CTL_MODE LedAction)
 {
-	struct led_priv	*ledpriv = &padapter->ledpriv;
+	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct LED_871x *pLed = &ledpriv->SwLed0;
 
@@ -1246,8 +1349,11 @@ static void SwLedControlMode3(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_TX:
@@ -1264,8 +1370,11 @@ static void SwLedControlMode3(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_FASTER_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_LINK:
@@ -1281,8 +1390,7 @@ static void SwLedControlMode3(struct _adapter *padapter,
 			del_timer(&pLed->BlinkTimer);
 			pLed->bLedScanBlinkInProgress = false;
 		}
-		mod_timer(&pLed->BlinkTimer,
-			  jiffies + msecs_to_jiffies(0));
+		mod_timer(&pLed->BlinkTimer, jiffies + msecs_to_jiffies(0));
 		break;
 	case LED_CTL_START_WPS: /* wait until xinpin finish */
 	case LED_CTL_START_WPS_BOTTON:
@@ -1301,8 +1409,11 @@ static void SwLedControlMode3(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_STOP_WPS:
@@ -1315,8 +1426,11 @@ static void SwLedControlMode3(struct _adapter *padapter,
 		pLed->CurrLedState = LED_BLINK_WPS_STOP;
 		if (pLed->bLedOn) {
 			pLed->BlinkingLedState = LED_STATE_OFF;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA));
 		} else {
 			pLed->BlinkingLedState = LED_STATE_ON;
 			mod_timer(&pLed->BlinkTimer,
@@ -1330,8 +1444,7 @@ static void SwLedControlMode3(struct _adapter *padapter,
 		}
 		pLed->CurrLedState = LED_STATE_OFF;
 		pLed->BlinkingLedState = LED_STATE_OFF;
-		mod_timer(&pLed->BlinkTimer,
-			  jiffies + msecs_to_jiffies(0));
+		mod_timer(&pLed->BlinkTimer, jiffies + msecs_to_jiffies(0));
 		break;
 	case LED_CTL_START_TO_LINK:
 	case LED_CTL_NO_LINK:
@@ -1357,8 +1470,7 @@ static void SwLedControlMode3(struct _adapter *padapter,
 			del_timer(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
 		}
-		mod_timer(&pLed->BlinkTimer,
-			  jiffies + msecs_to_jiffies(0));
+		mod_timer(&pLed->BlinkTimer, jiffies + msecs_to_jiffies(0));
 		break;
 	default:
 		break;
@@ -1368,7 +1480,7 @@ static void SwLedControlMode3(struct _adapter *padapter,
 static void SwLedControlMode4(struct _adapter *padapter,
 			      enum LED_CTL_MODE LedAction)
 {
-	struct led_priv	*ledpriv = &padapter->ledpriv;
+	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct LED_871x *pLed = &ledpriv->SwLed0;
 	struct LED_871x *pLed1 = &ledpriv->SwLed1;
@@ -1400,12 +1512,18 @@ static void SwLedControlMode4(struct _adapter *padapter,
 			pLed->CurrLedState = LED_BLINK_StartToBlink;
 			if (pLed->bLedOn) {
 				pLed->BlinkingLedState = LED_STATE_OFF;
-				mod_timer(&pLed->BlinkTimer, jiffies +
-					  msecs_to_jiffies(LED_BLINK_SLOWLY_INTERVAL));
+				mod_timer(
+					&pLed->BlinkTimer,
+					jiffies +
+						msecs_to_jiffies(
+							LED_BLINK_SLOWLY_INTERVAL));
 			} else {
 				pLed->BlinkingLedState = LED_STATE_ON;
-				mod_timer(&pLed->BlinkTimer, jiffies +
-					  msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
+				mod_timer(
+					&pLed->BlinkTimer,
+					jiffies +
+						msecs_to_jiffies(
+							LED_BLINK_NORMAL_INTERVAL));
 			}
 		}
 		break;
@@ -1420,7 +1538,8 @@ static void SwLedControlMode4(struct _adapter *padapter,
 				pLed1->CurrLedState = LED_STATE_OFF;
 				if (pLed1->bLedOn)
 					mod_timer(&pLed->BlinkTimer,
-						  jiffies + msecs_to_jiffies(0));
+						  jiffies +
+							  msecs_to_jiffies(0));
 			}
 		}
 		if (!pLed->bLedNoLinkBlinkInProgress) {
@@ -1437,8 +1556,11 @@ static void SwLedControlMode4(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_SITE_SURVEY:
@@ -1463,8 +1585,11 @@ static void SwLedControlMode4(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_TX:
@@ -1484,8 +1609,11 @@ static void SwLedControlMode4(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_FASTER_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_START_WPS: /*wait until xinpin finish*/
@@ -1516,16 +1644,22 @@ static void SwLedControlMode4(struct _adapter *padapter,
 			pLed->CurrLedState = LED_BLINK_WPS;
 			if (pLed->bLedOn) {
 				pLed->BlinkingLedState = LED_STATE_OFF;
-				mod_timer(&pLed->BlinkTimer, jiffies +
-					  msecs_to_jiffies(LED_BLINK_SLOWLY_INTERVAL));
+				mod_timer(
+					&pLed->BlinkTimer,
+					jiffies +
+						msecs_to_jiffies(
+							LED_BLINK_SLOWLY_INTERVAL));
 			} else {
 				pLed->BlinkingLedState = LED_STATE_ON;
-				mod_timer(&pLed->BlinkTimer, jiffies +
-					  msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
+				mod_timer(
+					&pLed->BlinkTimer,
+					jiffies +
+						msecs_to_jiffies(
+							LED_BLINK_NORMAL_INTERVAL));
 			}
 		}
 		break;
-	case LED_CTL_STOP_WPS:	/*WPS connect success*/
+	case LED_CTL_STOP_WPS: /*WPS connect success*/
 		if (pLed->bLedWPSBlinkInProgress) {
 			del_timer(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
@@ -1536,10 +1670,11 @@ static void SwLedControlMode4(struct _adapter *padapter,
 			pLed->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies + msecs_to_jiffies(
+					    LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 		break;
-	case LED_CTL_STOP_WPS_FAIL:	/*WPS authentication fail*/
+	case LED_CTL_STOP_WPS_FAIL: /*WPS authentication fail*/
 		if (pLed->bLedWPSBlinkInProgress) {
 			del_timer(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
@@ -1550,8 +1685,9 @@ static void SwLedControlMode4(struct _adapter *padapter,
 			pLed->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies + msecs_to_jiffies(
+					    LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 		/*LED1 settings*/
 		if (pLed1->bLedWPSBlinkInProgress)
 			del_timer(&pLed1->BlinkTimer);
@@ -1562,10 +1698,11 @@ static void SwLedControlMode4(struct _adapter *padapter,
 			pLed1->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed1->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies +
+				  msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
 		break;
-	case LED_CTL_STOP_WPS_FAIL_OVERLAP:	/*WPS session overlap*/
+	case LED_CTL_STOP_WPS_FAIL_OVERLAP: /*WPS session overlap*/
 		if (pLed->bLedWPSBlinkInProgress) {
 			del_timer(&pLed->BlinkTimer);
 			pLed->bLedWPSBlinkInProgress = false;
@@ -1576,8 +1713,9 @@ static void SwLedControlMode4(struct _adapter *padapter,
 			pLed->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies + msecs_to_jiffies(
+					    LED_BLINK_NO_LINK_INTERVAL_ALPHA));
 		/*LED1 settings*/
 		if (pLed1->bLedWPSBlinkInProgress)
 			del_timer(&pLed1->BlinkTimer);
@@ -1589,8 +1727,9 @@ static void SwLedControlMode4(struct _adapter *padapter,
 			pLed1->BlinkingLedState = LED_STATE_OFF;
 		else
 			pLed1->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer, jiffies +
-			  msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
+		mod_timer(&pLed->BlinkTimer,
+			  jiffies +
+				  msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
 		break;
 	case LED_CTL_POWER_OFF:
 		pLed->CurrLedState = LED_STATE_OFF;
@@ -1635,7 +1774,7 @@ static void SwLedControlMode4(struct _adapter *padapter,
 static void SwLedControlMode5(struct _adapter *padapter,
 			      enum LED_CTL_MODE LedAction)
 {
-	struct led_priv	*ledpriv = &padapter->ledpriv;
+	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct LED_871x *pLed = &ledpriv->SwLed0;
 
@@ -1645,14 +1784,13 @@ static void SwLedControlMode5(struct _adapter *padapter,
 	switch (LedAction) {
 	case LED_CTL_POWER_ON:
 	case LED_CTL_NO_LINK:
-	case LED_CTL_LINK:	/* solid blue */
+	case LED_CTL_LINK: /* solid blue */
 		if (pLed->CurrLedState == LED_SCAN_BLINK)
 			return;
 		pLed->CurrLedState = LED_STATE_ON;
 		pLed->BlinkingLedState = LED_STATE_ON;
 		pLed->bLedBlinkInProgress = false;
-		mod_timer(&pLed->BlinkTimer,
-			  jiffies + msecs_to_jiffies(0));
+		mod_timer(&pLed->BlinkTimer, jiffies + msecs_to_jiffies(0));
 		break;
 	case LED_CTL_SITE_SURVEY:
 		if (pmlmepriv->sitesurveyctrl.traffic_busy &&
@@ -1670,8 +1808,11 @@ static void SwLedControlMode5(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_TX:
@@ -1686,8 +1827,11 @@ static void SwLedControlMode5(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_FASTER_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_POWER_OFF:
@@ -1707,14 +1851,14 @@ static void SwLedControlMode5(struct _adapter *padapter,
 static void SwLedControlMode6(struct _adapter *padapter,
 			      enum LED_CTL_MODE LedAction)
 {
-	struct led_priv	*ledpriv = &padapter->ledpriv;
+	struct led_priv *ledpriv = &padapter->ledpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct LED_871x *pLed = &ledpriv->SwLed0;
 
 	switch (LedAction) {
 	case LED_CTL_POWER_ON:
 	case LED_CTL_NO_LINK:
-	case LED_CTL_LINK:	/*solid blue*/
+	case LED_CTL_LINK: /*solid blue*/
 	case LED_CTL_SITE_SURVEY:
 		if (IS_LED_WPS_BLINKING(pLed))
 			return;
@@ -1736,8 +1880,11 @@ static void SwLedControlMode6(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_FASTER_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_START_WPS: /*wait until xinpin finish*/
@@ -1753,8 +1900,11 @@ static void SwLedControlMode6(struct _adapter *padapter,
 				pLed->BlinkingLedState = LED_STATE_OFF;
 			else
 				pLed->BlinkingLedState = LED_STATE_ON;
-			mod_timer(&pLed->BlinkTimer, jiffies +
-				  msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
+			mod_timer(
+				&pLed->BlinkTimer,
+				jiffies +
+					msecs_to_jiffies(
+						LED_BLINK_SCAN_INTERVAL_ALPHA));
 		}
 		break;
 	case LED_CTL_STOP_WPS_FAIL:
@@ -1765,8 +1915,7 @@ static void SwLedControlMode6(struct _adapter *padapter,
 		}
 		pLed->CurrLedState = LED_STATE_ON;
 		pLed->BlinkingLedState = LED_STATE_ON;
-		mod_timer(&pLed->BlinkTimer,
-			  jiffies + msecs_to_jiffies(0));
+		mod_timer(&pLed->BlinkTimer, jiffies + msecs_to_jiffies(0));
 		break;
 	case LED_CTL_POWER_OFF:
 		pLed->CurrLedState = LED_STATE_OFF;
@@ -1791,7 +1940,7 @@ static void SwLedControlMode6(struct _adapter *padapter,
  */
 void LedControl871x(struct _adapter *padapter, enum LED_CTL_MODE LedAction)
 {
-	struct led_priv	*ledpriv = &padapter->ledpriv;
+	struct led_priv *ledpriv = &padapter->ledpriv;
 
 	if (!ledpriv->bRegUseLed)
 		return;
diff --git a/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h b/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h
index 46d758d3f3a4..991da09d80bc 100644
--- a/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h
@@ -11,21 +11,20 @@
 /*BSSID*/
 
 /*HWVID*/
-#define	_HWVID_MSK				0x0F
+#define _HWVID_MSK 0x0F
 
 /*MAR*/
 /*MBIDCANCONTENT*/
 
 /*MBIDCANCFG*/
-#define	_POOLING				BIT(31)
-#define	_WRITE_EN				BIT(16)
-#define	_CAM_ADDR_MSK			0x001F
-#define	_CAM_ADDR_SHT			0
+#define _POOLING BIT(31)
+#define _WRITE_EN BIT(16)
+#define _CAM_ADDR_MSK 0x001F
+#define _CAM_ADDR_SHT 0
 
 /*BUILDTIME*/
-#define _BUILDTIME_MSK			0x3FFFFFFF
+#define _BUILDTIME_MSK 0x3FFFFFFF
 
 /*BUILDUSER*/
 
 #endif /* __RTL8712_MACSETTING_BITDEF_H__*/
-
diff --git a/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h b/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h
index 64740d99c252..3b4872d795c7 100644
--- a/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h
@@ -7,14 +7,13 @@
 #ifndef __RTL8712_MACSETTING_REGDEF_H__
 #define __RTL8712_MACSETTING_REGDEF_H__
 
-#define MACID				(RTL8712_MACIDSETTING_ + 0x0000)
-#define BSSIDR				(RTL8712_MACIDSETTING_ + 0x0008)
-#define HWVID				(RTL8712_MACIDSETTING_ + 0x000E)
-#define MAR				(RTL8712_MACIDSETTING_ + 0x0010)
-#define MBIDCANCONTENT			(RTL8712_MACIDSETTING_ + 0x0018)
-#define MBIDCANCFG			(RTL8712_MACIDSETTING_ + 0x0020)
-#define BUILDTIME			(RTL8712_MACIDSETTING_ + 0x0024)
-#define BUILDUSER			(RTL8712_MACIDSETTING_ + 0x0028)
+#define MACID (RTL8712_MACIDSETTING_ + 0x0000)
+#define BSSIDR (RTL8712_MACIDSETTING_ + 0x0008)
+#define HWVID (RTL8712_MACIDSETTING_ + 0x000E)
+#define MAR (RTL8712_MACIDSETTING_ + 0x0010)
+#define MBIDCANCONTENT (RTL8712_MACIDSETTING_ + 0x0018)
+#define MBIDCANCFG (RTL8712_MACIDSETTING_ + 0x0020)
+#define BUILDTIME (RTL8712_MACIDSETTING_ + 0x0024)
+#define BUILDUSER (RTL8712_MACIDSETTING_ + 0x0028)
 
 #endif /*__RTL8712_MACSETTING_REGDEF_H__*/
-
diff --git a/drivers/staging/rtl8712/rtl8712_powersave_bitdef.h b/drivers/staging/rtl8712/rtl8712_powersave_bitdef.h
index 53e0d6b440f3..3f9e4889f201 100644
--- a/drivers/staging/rtl8712/rtl8712_powersave_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_powersave_bitdef.h
@@ -8,32 +8,32 @@
 #define __RTL8712_POWERSAVE_BITDEF_H__
 
 /*WOWCTRL*/
-#define	_UWF			BIT(3)
-#define	_MAGIC			BIT(2)
-#define	_WOW_EN			BIT(1)
-#define	_PMEN			BIT(0)
+#define _UWF BIT(3)
+#define _MAGIC BIT(2)
+#define _WOW_EN BIT(1)
+#define _PMEN BIT(0)
 
 /*PSSTATUS*/
-#define	_PSSTATUS_SEL_MSK		0x0F
+#define _PSSTATUS_SEL_MSK 0x0F
 
 /*PSSWITCH*/
-#define	_PSSWITCH_ACT			BIT(7)
-#define	_PSSWITCH_SEL_MSK		0x0F
-#define	_PSSWITCH_SEL_SHT		0
+#define _PSSWITCH_ACT BIT(7)
+#define _PSSWITCH_SEL_MSK 0x0F
+#define _PSSWITCH_SEL_SHT 0
 
 /*LPNAV_CTRL*/
-#define	_LPNAV_EN			BIT(31)
-#define	_LPNAV_EARLY_MSK		0x7FFF0000
-#define	_LPNAV_EARLY_SHT		16
-#define	_LPNAV_TH_MSK			0x0000FFFF
-#define	_LPNAV_TH_SHT			0
+#define _LPNAV_EN BIT(31)
+#define _LPNAV_EARLY_MSK 0x7FFF0000
+#define _LPNAV_EARLY_SHT 16
+#define _LPNAV_TH_MSK 0x0000FFFF
+#define _LPNAV_TH_SHT 0
 
 /*RPWM*/
 /*CPWM*/
-#define	_TOGGLING			BIT(7)
-#define	_WWLAN				BIT(3)
-#define	_RPS_ST				BIT(2)
-#define	_WLAN_TRX			BIT(1)
-#define	_SYS_CLK			BIT(0)
+#define _TOGGLING BIT(7)
+#define _WWLAN BIT(3)
+#define _RPS_ST BIT(2)
+#define _WLAN_TRX BIT(1)
+#define _SYS_CLK BIT(0)
 
 #endif /* __RTL8712_POWERSAVE_BITDEF_H__*/
diff --git a/drivers/staging/rtl8712/rtl8712_powersave_regdef.h b/drivers/staging/rtl8712/rtl8712_powersave_regdef.h
index 1bcfde4b1c11..bdcefdc91211 100644
--- a/drivers/staging/rtl8712/rtl8712_powersave_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_powersave_regdef.h
@@ -7,20 +7,19 @@
 #ifndef __RTL8712_POWERSAVE_REGDEF_H__
 #define __RTL8712_POWERSAVE_REGDEF_H__
 
-#define WOWCTRL				(RTL8712_POWERSAVE_ + 0x00)
-#define PSSTATUS			(RTL8712_POWERSAVE_ + 0x01)
-#define PSSWITCH			(RTL8712_POWERSAVE_ + 0x02)
-#define MIMOPS_WAITPERIOD		(RTL8712_POWERSAVE_ + 0x03)
-#define LPNAV_CTRL			(RTL8712_POWERSAVE_ + 0x04)
-#define WFM0				(RTL8712_POWERSAVE_ + 0x10)
-#define WFM1				(RTL8712_POWERSAVE_ + 0x20)
-#define WFM2				(RTL8712_POWERSAVE_ + 0x30)
-#define WFM3				(RTL8712_POWERSAVE_ + 0x40)
-#define WFM4				(RTL8712_POWERSAVE_ + 0x50)
-#define WFM5				(RTL8712_POWERSAVE_ + 0x60)
-#define WFCRC				(RTL8712_POWERSAVE_ + 0x70)
-#define RPWM				(RTL8712_POWERSAVE_ + 0x7C)
-#define CPWM				(RTL8712_POWERSAVE_ + 0x7D)
+#define WOWCTRL (RTL8712_POWERSAVE_ + 0x00)
+#define PSSTATUS (RTL8712_POWERSAVE_ + 0x01)
+#define PSSWITCH (RTL8712_POWERSAVE_ + 0x02)
+#define MIMOPS_WAITPERIOD (RTL8712_POWERSAVE_ + 0x03)
+#define LPNAV_CTRL (RTL8712_POWERSAVE_ + 0x04)
+#define WFM0 (RTL8712_POWERSAVE_ + 0x10)
+#define WFM1 (RTL8712_POWERSAVE_ + 0x20)
+#define WFM2 (RTL8712_POWERSAVE_ + 0x30)
+#define WFM3 (RTL8712_POWERSAVE_ + 0x40)
+#define WFM4 (RTL8712_POWERSAVE_ + 0x50)
+#define WFM5 (RTL8712_POWERSAVE_ + 0x60)
+#define WFCRC (RTL8712_POWERSAVE_ + 0x70)
+#define RPWM (RTL8712_POWERSAVE_ + 0x7C)
+#define CPWM (RTL8712_POWERSAVE_ + 0x7D)
 
 #endif /* __RTL8712_POWERSAVE_REGDEF_H__ */
-
diff --git a/drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h
index 1de51c48f9c1..d8fa183b1068 100644
--- a/drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h
@@ -8,29 +8,28 @@
 #define __RTL8712_RATECTRL_BITDEF_H__
 
 /*INIRTSMCS_SEL*/
-#define	_INIRTSMCS_SEL_MSK		0x3F
+#define _INIRTSMCS_SEL_MSK 0x3F
 
 /* RRSR*/
-#define	_RRSR_SHORT			BIT(23)
-#define	_RRSR_RSC_MSK		0x600000
-#define	_RRSR_RSC_SHT		21
-#define	_RRSR_BITMAP_MSK	0x0FFFFF
-#define	_RRSR_BITMAP_SHT	0
+#define _RRSR_SHORT BIT(23)
+#define _RRSR_RSC_MSK 0x600000
+#define _RRSR_RSC_SHT 21
+#define _RRSR_BITMAP_MSK 0x0FFFFF
+#define _RRSR_BITMAP_SHT 0
 
 /* AGGLEN_LMT_H*/
-#define	_AGGLMT_MCS32_MSK			0xF0
-#define	_AGGLMT_MCS32_SHT			4
-#define	_AGGLMT_MCS15_SGI_MSK		0x0F
-#define	_AGGLMT_MCS15_SGI_SHT		0
+#define _AGGLMT_MCS32_MSK 0xF0
+#define _AGGLMT_MCS32_SHT 4
+#define _AGGLMT_MCS15_SGI_MSK 0x0F
+#define _AGGLMT_MCS15_SGI_SHT 0
 
 /* DARFRC*/
 /* RARFRC*/
 /* MCS_TXAGC*/
 /* CCK_TXAGC*/
-#define	_CCK_MSK			0xFF00
-#define	_CCK_SHT			8
-#define	_BARKER_MSK			0x00FF
-#define	_BARKER_SHT			0
-
-#endif	/*	__RTL8712_RATECTRL_BITDEF_H__*/
+#define _CCK_MSK 0xFF00
+#define _CCK_SHT 8
+#define _BARKER_MSK 0x00FF
+#define _BARKER_SHT 0
 
+#endif /*	__RTL8712_RATECTRL_BITDEF_H__*/
diff --git a/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h b/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h
index 9ed5653f3f7f..65acc960b500 100644
--- a/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h
@@ -14,30 +14,29 @@
 #ifndef __RTL8712_RATECTRL_REGDEF_H__
 #define __RTL8712_RATECTRL_REGDEF_H__
 
-#define INIMCS_SEL			(RTL8712_RATECTRL_ + 0x00)
-#define INIRTSMCS_SEL		(RTL8712_RATECTRL_ + 0x20)
-#define RRSR				(RTL8712_RATECTRL_ + 0x21)
-#define ARFR0				(RTL8712_RATECTRL_ + 0x24)
-#define ARFR1				(RTL8712_RATECTRL_ + 0x28)
-#define ARFR2				(RTL8712_RATECTRL_ + 0x2C)
-#define ARFR3				(RTL8712_RATECTRL_ + 0x30)
-#define ARFR4				(RTL8712_RATECTRL_ + 0x34)
-#define ARFR5				(RTL8712_RATECTRL_ + 0x38)
-#define ARFR6				(RTL8712_RATECTRL_ + 0x3C)
-#define ARFR7				(RTL8712_RATECTRL_ + 0x40)
-#define AGGLEN_LMT_H		(RTL8712_RATECTRL_ + 0x47)
-#define AGGLEN_LMT_L		(RTL8712_RATECTRL_ + 0x48)
-#define DARFRC				(RTL8712_RATECTRL_ + 0x50)
-#define RARFRC				(RTL8712_RATECTRL_ + 0x58)
-#define MCS_TXAGC0			(RTL8712_RATECTRL_ + 0x60)
-#define MCS_TXAGC1			(RTL8712_RATECTRL_ + 0x61)
-#define MCS_TXAGC2			(RTL8712_RATECTRL_ + 0x62)
-#define MCS_TXAGC3			(RTL8712_RATECTRL_ + 0x63)
-#define MCS_TXAGC4			(RTL8712_RATECTRL_ + 0x64)
-#define MCS_TXAGC5			(RTL8712_RATECTRL_ + 0x65)
-#define MCS_TXAGC6			(RTL8712_RATECTRL_ + 0x66)
-#define MCS_TXAGC7			(RTL8712_RATECTRL_ + 0x67)
-#define CCK_TXAGC			(RTL8712_RATECTRL_ + 0x68)
-
-#endif	/*__RTL8712_RATECTRL_REGDEF_H__*/
+#define INIMCS_SEL (RTL8712_RATECTRL_ + 0x00)
+#define INIRTSMCS_SEL (RTL8712_RATECTRL_ + 0x20)
+#define RRSR (RTL8712_RATECTRL_ + 0x21)
+#define ARFR0 (RTL8712_RATECTRL_ + 0x24)
+#define ARFR1 (RTL8712_RATECTRL_ + 0x28)
+#define ARFR2 (RTL8712_RATECTRL_ + 0x2C)
+#define ARFR3 (RTL8712_RATECTRL_ + 0x30)
+#define ARFR4 (RTL8712_RATECTRL_ + 0x34)
+#define ARFR5 (RTL8712_RATECTRL_ + 0x38)
+#define ARFR6 (RTL8712_RATECTRL_ + 0x3C)
+#define ARFR7 (RTL8712_RATECTRL_ + 0x40)
+#define AGGLEN_LMT_H (RTL8712_RATECTRL_ + 0x47)
+#define AGGLEN_LMT_L (RTL8712_RATECTRL_ + 0x48)
+#define DARFRC (RTL8712_RATECTRL_ + 0x50)
+#define RARFRC (RTL8712_RATECTRL_ + 0x58)
+#define MCS_TXAGC0 (RTL8712_RATECTRL_ + 0x60)
+#define MCS_TXAGC1 (RTL8712_RATECTRL_ + 0x61)
+#define MCS_TXAGC2 (RTL8712_RATECTRL_ + 0x62)
+#define MCS_TXAGC3 (RTL8712_RATECTRL_ + 0x63)
+#define MCS_TXAGC4 (RTL8712_RATECTRL_ + 0x64)
+#define MCS_TXAGC5 (RTL8712_RATECTRL_ + 0x65)
+#define MCS_TXAGC6 (RTL8712_RATECTRL_ + 0x66)
+#define MCS_TXAGC7 (RTL8712_RATECTRL_ + 0x67)
+#define CCK_TXAGC (RTL8712_RATECTRL_ + 0x68)
 
+#endif /*__RTL8712_RATECTRL_REGDEF_H__*/
diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index ab344d676bb9..d008e3226aa0 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -30,8 +30,7 @@
 
 static void recv_tasklet(struct tasklet_struct *t);
 
-int r8712_init_recv_priv(struct recv_priv *precvpriv,
-			 struct _adapter *padapter)
+int r8712_init_recv_priv(struct recv_priv *precvpriv, struct _adapter *padapter)
 {
 	int i;
 	struct recv_buf *precvbuf;
@@ -46,7 +45,7 @@ int r8712_init_recv_priv(struct recv_priv *precvpriv,
 	if (!precvpriv->pallocated_recv_buf)
 		return -ENOMEM;
 	precvpriv->precv_buf = precvpriv->pallocated_recv_buf + 4 -
-			      ((addr_t)(precvpriv->pallocated_recv_buf) & 3);
+			       ((addr_t)(precvpriv->pallocated_recv_buf) & 3);
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 	for (i = 0; i < NR_RECVBUFF; i++) {
 		INIT_LIST_HEAD(&precvbuf->list);
@@ -65,8 +64,8 @@ int r8712_init_recv_priv(struct recv_priv *precvpriv,
 
 	skb_queue_head_init(&precvpriv->free_recv_skb_queue);
 	for (i = 0; i < NR_PREALLOC_RECV_SKB; i++) {
-		pskb = netdev_alloc_skb(padapter->pnetdev, MAX_RECVBUF_SZ +
-		       RECVBUFF_ALIGN_SZ);
+		pskb = netdev_alloc_skb(padapter->pnetdev,
+					MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
 		if (pskb) {
 			tmpaddr = (addr_t)pskb->data;
 			alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
@@ -92,10 +91,12 @@ void r8712_free_recv_priv(struct recv_priv *precvpriv)
 	kfree(precvpriv->pallocated_recv_buf);
 	skb_queue_purge(&precvpriv->rx_skb_queue);
 	if (skb_queue_len(&precvpriv->rx_skb_queue))
-		netdev_warn(padapter->pnetdev, "r8712u: rx_skb_queue not empty\n");
+		netdev_warn(padapter->pnetdev,
+			    "r8712u: rx_skb_queue not empty\n");
 	skb_queue_purge(&precvpriv->free_recv_skb_queue);
 	if (skb_queue_len(&precvpriv->free_recv_skb_queue))
-		netdev_warn(padapter->pnetdev, "r8712u: free_recv_skb_queue not empty %d\n",
+		netdev_warn(padapter->pnetdev,
+			    "r8712u: free_recv_skb_queue not empty %d\n",
 			    skb_queue_len(&precvpriv->free_recv_skb_queue));
 }
 
@@ -113,14 +114,14 @@ void r8712_init_recvbuf(struct _adapter *padapter, struct recv_buf *precvbuf)
 }
 
 void r8712_free_recvframe(union recv_frame *precvframe,
-			  struct  __queue *pfree_recv_queue)
+			  struct __queue *pfree_recv_queue)
 {
 	unsigned long irqL;
 	struct _adapter *padapter = precvframe->u.hdr.adapter;
 	struct recv_priv *precvpriv = &padapter->recvpriv;
 
 	if (precvframe->u.hdr.pkt) {
-		dev_kfree_skb_any(precvframe->u.hdr.pkt);/*free skb by driver*/
+		dev_kfree_skb_any(precvframe->u.hdr.pkt); /*free skb by driver*/
 		precvframe->u.hdr.pkt = NULL;
 	}
 	spin_lock_irqsave(&pfree_recv_queue->lock, irqL);
@@ -166,14 +167,14 @@ static void update_recvframe_attrib_from_recvstat(struct rx_pkt_attrib *pattrib,
 
 /*perform defrag*/
 static union recv_frame *recvframe_defrag(struct _adapter *adapter,
-					  struct  __queue *defrag_q)
+					  struct __queue *defrag_q)
 {
 	struct list_head *plist, *phead;
 	u8 wlanhdr_offset;
-	u8	curfragnum;
+	u8 curfragnum;
 	struct recv_frame_hdr *pfhdr, *pnfhdr;
 	union recv_frame *prframe, *pnextrframe;
-	struct  __queue	*pfree_recv_queue;
+	struct __queue *pfree_recv_queue;
 
 	pfree_recv_queue = &adapter->recvpriv.free_recv_queue;
 	phead = &defrag_q->queue;
@@ -229,15 +230,15 @@ static union recv_frame *recvframe_defrag(struct _adapter *adapter,
 union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
 					     union recv_frame *precv_frame)
 {
-	u8	ismfrag;
-	u8	fragnum;
-	u8   *psta_addr;
+	u8 ismfrag;
+	u8 fragnum;
+	u8 *psta_addr;
 	struct recv_frame_hdr *pfhdr;
 	struct sta_info *psta;
-	struct	sta_priv *pstapriv;
+	struct sta_priv *pstapriv;
 	struct list_head *phead;
 	union recv_frame *prtnframe = NULL;
-	struct  __queue *pfree_recv_queue, *pdefrag_q;
+	struct __queue *pfree_recv_queue, *pdefrag_q;
 
 	pstapriv = &padapter->stapriv;
 	pfhdr = &precv_frame->u.hdr;
@@ -252,8 +253,8 @@ union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
 	else
 		pdefrag_q = &psta->sta_recvpriv.defrag_q;
 
-	if ((ismfrag == 0) && (fragnum == 0))
-		prtnframe = precv_frame;/*isn't a fragment frame*/
+	if (ismfrag == 0 && fragnum == 0)
+		prtnframe = precv_frame; /*isn't a fragment frame*/
 	if (ismfrag == 1) {
 		/* 0~(n-1) fragment frame
 		 * enqueue to defraf_g
@@ -263,7 +264,8 @@ union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
 				/*the first fragment*/
 				if (!list_empty(&pdefrag_q->queue)) {
 					/*free current defrag_q */
-					r8712_free_recvframe_queue(pdefrag_q, pfree_recv_queue);
+					r8712_free_recvframe_queue(
+						pdefrag_q, pfree_recv_queue);
 				}
 			}
 			/* Then enqueue the 0~(n-1) fragment to the defrag_q */
@@ -278,7 +280,7 @@ union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
 			prtnframe = NULL;
 		}
 	}
-	if ((ismfrag == 0) && (fragnum != 0)) {
+	if (ismfrag == 0 && fragnum != 0) {
 		/* the last fragment frame
 		 * enqueue the last fragment
 		 */
@@ -296,7 +298,7 @@ union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
 			prtnframe = NULL;
 		}
 	}
-	if (prtnframe && (prtnframe->u.hdr.attrib.privacy)) {
+	if (prtnframe && prtnframe->u.hdr.attrib.privacy) {
 		/* after defrag we must check tkip mic code */
 		if (r8712_recvframe_chkmic(padapter, prtnframe) == _FAIL) {
 			r8712_free_recvframe(prtnframe, pfree_recv_queue);
@@ -308,14 +310,14 @@ union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
 
 static void amsdu_to_msdu(struct _adapter *padapter, union recv_frame *prframe)
 {
-	int	a_len, padding_len;
-	u16	eth_type, nSubframe_Length;
-	u8	nr_subframes, i;
+	int a_len, padding_len;
+	u16 eth_type, nSubframe_Length;
+	u8 nr_subframes, i;
 	unsigned char *pdata;
 	struct rx_pkt_attrib *pattrib;
 	_pkt *sub_skb, *subframes[MAX_SUBFRAME_COUNT];
 	struct recv_priv *precvpriv = &padapter->recvpriv;
-	struct  __queue *pfree_recv_queue = &precvpriv->free_recv_queue;
+	struct __queue *pfree_recv_queue = &precvpriv->free_recv_queue;
 
 	nr_subframes = 0;
 	pattrib = &prframe->u.hdr.attrib;
@@ -328,11 +330,13 @@ static void amsdu_to_msdu(struct _adapter *padapter, union recv_frame *prframe)
 		/* Offset 12 denote 2 mac address */
 		nSubframe_Length = *((u16 *)(pdata + 12));
 		/*==m==>change the length order*/
-		nSubframe_Length = (nSubframe_Length >> 8) +
-				   (nSubframe_Length << 8);
+		nSubframe_Length =
+			(nSubframe_Length >> 8) + (nSubframe_Length << 8);
 		if (a_len < (ETHERNET_HEADER_SIZE + nSubframe_Length)) {
-			netdev_warn(padapter->pnetdev, "r8712u: nRemain_Length is %d and nSubframe_Length is: %d\n",
-				    a_len, nSubframe_Length);
+			netdev_warn(
+				padapter->pnetdev,
+				"r8712u: nRemain_Length is %d and nSubframe_Length is: %d\n",
+				a_len, nSubframe_Length);
 			goto exit;
 		}
 		/* move the data point to data content */
@@ -346,7 +350,9 @@ static void amsdu_to_msdu(struct _adapter *padapter, union recv_frame *prframe)
 		skb_put_data(sub_skb, pdata, nSubframe_Length);
 		subframes[nr_subframes++] = sub_skb;
 		if (nr_subframes >= MAX_SUBFRAME_COUNT) {
-			netdev_warn(padapter->pnetdev, "r8712u: ParseSubframe(): Too many Subframes! Packets dropped!\n");
+			netdev_warn(
+				padapter->pnetdev,
+				"r8712u: ParseSubframe(): Too many Subframes! Packets dropped!\n");
 			break;
 		}
 		pdata += nSubframe_Length;
@@ -390,10 +396,10 @@ static void amsdu_to_msdu(struct _adapter *padapter, union recv_frame *prframe)
 		/* Indicate the packets to upper layer */
 		if (sub_skb) {
 			sub_skb->protocol =
-				 eth_type_trans(sub_skb, padapter->pnetdev);
+				eth_type_trans(sub_skb, padapter->pnetdev);
 			sub_skb->dev = padapter->pnetdev;
-			if ((pattrib->tcpchk_valid == 1) &&
-			    (pattrib->tcp_chkrpt == 1)) {
+			if (pattrib->tcpchk_valid == 1 &&
+			    pattrib->tcp_chkrpt == 1) {
 				sub_skb->ip_summed = CHECKSUM_UNNECESSARY;
 			} else {
 				sub_skb->ip_summed = CHECKSUM_NONE;
@@ -420,10 +426,10 @@ void r8712_rxcmd_event_hdl(struct _adapter *padapter, void *prxcmdbuf)
 	drvinfo_sz <<= 3;
 	poffset += RXDESC_SIZE + drvinfo_sz;
 	do {
-		voffset  = *(__le32 *)poffset;
+		voffset = *(__le32 *)poffset;
 		cmd_len = (u16)(le32_to_cpu(voffset) & 0xffff);
 		r8712_event_handle(padapter, (__le32 *)poffset);
-		poffset += (cmd_len + 8);/*8 bytes alignment*/
+		poffset += (cmd_len + 8); /*8 bytes alignment*/
 	} while (le32_to_cpu(voffset) & BIT(31));
 }
 
@@ -445,14 +451,14 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl,
 	 * 2. Incoming SeqNum is larger than the WinEnd => Window shift N
 	 */
 	if (SN_EQUAL(seq_num, preorder_ctrl->indicate_seq))
-		preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq +
-					      1) % 4096;
+		preorder_ctrl->indicate_seq =
+			(preorder_ctrl->indicate_seq + 1) % 4096;
 	else if (SN_LESS(wend, seq_num)) {
 		if (seq_num >= (wsize - 1))
 			preorder_ctrl->indicate_seq = seq_num + 1 - wsize;
 		else
-			preorder_ctrl->indicate_seq = 4095 - (wsize -
-						      (seq_num + 1)) + 1;
+			preorder_ctrl->indicate_seq =
+				4095 - (wsize - (seq_num + 1)) + 1;
 	}
 	return true;
 }
@@ -463,8 +469,8 @@ static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl,
 	struct list_head *phead, *plist;
 	union recv_frame *pnextrframe;
 	struct rx_pkt_attrib *pnextattrib;
-	struct  __queue *ppending_recvframe_queue =
-					&preorder_ctrl->pending_recvframe_queue;
+	struct __queue *ppending_recvframe_queue =
+		&preorder_ctrl->pending_recvframe_queue;
 	struct rx_pkt_attrib *pattrib = &prframe->u.hdr.attrib;
 
 	phead = &ppending_recvframe_queue->queue;
@@ -494,8 +500,8 @@ int r8712_recv_indicatepkts_in_order(struct _adapter *padapter,
 	union recv_frame *prframe;
 	struct rx_pkt_attrib *pattrib;
 	int bPktInBuf = false;
-	struct  __queue *ppending_recvframe_queue =
-			 &preorder_ctrl->pending_recvframe_queue;
+	struct __queue *ppending_recvframe_queue =
+		&preorder_ctrl->pending_recvframe_queue;
 
 	phead = &ppending_recvframe_queue->queue;
 	plist = phead->next;
@@ -520,7 +526,8 @@ int r8712_recv_indicatepkts_in_order(struct _adapter *padapter,
 			if (SN_EQUAL(preorder_ctrl->indicate_seq,
 				     pattrib->seq_num))
 				preorder_ctrl->indicate_seq =
-				  (preorder_ctrl->indicate_seq + 1) % 4096;
+					(preorder_ctrl->indicate_seq + 1) %
+					4096;
 			/*indicate this recv_frame*/
 			if (!pattrib->amsdu) {
 				if (!padapter->driver_stopped &&
@@ -548,8 +555,8 @@ static int recv_indicatepkt_reorder(struct _adapter *padapter,
 	unsigned long irql;
 	struct rx_pkt_attrib *pattrib = &prframe->u.hdr.attrib;
 	struct recv_reorder_ctrl *preorder_ctrl = prframe->u.hdr.preorder_ctrl;
-	struct  __queue *ppending_recvframe_queue =
-			 &preorder_ctrl->pending_recvframe_queue;
+	struct __queue *ppending_recvframe_queue =
+		&preorder_ctrl->pending_recvframe_queue;
 
 	if (!pattrib->amsdu) {
 		/* s1. */
@@ -601,8 +608,8 @@ void r8712_reordering_ctrl_timeout_handler(void *pcontext)
 	unsigned long irql;
 	struct recv_reorder_ctrl *preorder_ctrl = pcontext;
 	struct _adapter *padapter = preorder_ctrl->padapter;
-	struct  __queue *ppending_recvframe_queue =
-				 &preorder_ctrl->pending_recvframe_queue;
+	struct __queue *ppending_recvframe_queue =
+		&preorder_ctrl->pending_recvframe_queue;
 
 	if (padapter->driver_stopped || padapter->surprise_removed)
 		return;
@@ -616,7 +623,7 @@ static int r8712_process_recv_indicatepkts(struct _adapter *padapter,
 {
 	int retval = _SUCCESS;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv	*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	if (phtpriv->ht_option == 1) { /*B/G/N Mode*/
 		if (recv_indicatepkt_reorder(padapter, prframe)) {
@@ -641,10 +648,10 @@ static int r8712_process_recv_indicatepkts(struct _adapter *padapter,
 
 static u8 query_rx_pwr_percentage(s8 antpower)
 {
-	if ((antpower <= -100) || (antpower >= 20))
-		return	0;
+	if (antpower <= -100 || antpower >= 20)
+		return 0;
 	else if (antpower >= 0)
-		return	100;
+		return 100;
 	else
 		return 100 + antpower;
 }
@@ -685,7 +692,7 @@ s32 r8712_signal_scale_mapping(s32 cur_sig)
 	return ret_sig;
 }
 
-static s32  translate2dbm(struct _adapter *padapter, u8 signal_strength_idx)
+static s32 translate2dbm(struct _adapter *padapter, u8 signal_strength_idx)
 {
 	s32 signal_power; /* in dBm.*/
 	/* Translate to dBm (x=0.5y-95).*/
@@ -729,20 +736,20 @@ static void query_rx_phy_status(struct _adapter *padapter,
 			 * RNA gain.
 			 */
 			case 0x3:
-				rx_pwr_all = -40 - (pcck_buf->cck_agc_rpt &
-					     0x3e);
+				rx_pwr_all =
+					-40 - (pcck_buf->cck_agc_rpt & 0x3e);
 				break;
 			case 0x2:
-				rx_pwr_all = -20 - (pcck_buf->cck_agc_rpt &
-					     0x3e);
+				rx_pwr_all =
+					-20 - (pcck_buf->cck_agc_rpt & 0x3e);
 				break;
 			case 0x1:
-				rx_pwr_all = -2 - (pcck_buf->cck_agc_rpt &
-					     0x3e);
+				rx_pwr_all =
+					-2 - (pcck_buf->cck_agc_rpt & 0x3e);
 				break;
 			case 0x0:
-				rx_pwr_all = 14 - (pcck_buf->cck_agc_rpt &
-					     0x3e);
+				rx_pwr_all =
+					14 - (pcck_buf->cck_agc_rpt & 0x3e);
 				break;
 			}
 		} else {
@@ -751,20 +758,24 @@ static void query_rx_phy_status(struct _adapter *padapter,
 			report >>= 5;
 			switch (report) {
 			case 0x3:
-				rx_pwr_all = -40 - ((pcck_buf->cck_agc_rpt &
-					     0x1f) << 1);
+				rx_pwr_all =
+					-40 -
+					((pcck_buf->cck_agc_rpt & 0x1f) << 1);
 				break;
 			case 0x2:
-				rx_pwr_all = -20 - ((pcck_buf->cck_agc_rpt &
-					     0x1f) << 1);
+				rx_pwr_all =
+					-20 -
+					((pcck_buf->cck_agc_rpt & 0x1f) << 1);
 				break;
 			case 0x1:
-				rx_pwr_all = -2 - ((pcck_buf->cck_agc_rpt &
-					     0x1f) << 1);
+				rx_pwr_all =
+					-2 -
+					((pcck_buf->cck_agc_rpt & 0x1f) << 1);
 				break;
 			case 0x0:
-				rx_pwr_all = 14 - ((pcck_buf->cck_agc_rpt &
-					     0x1f) << 1);
+				rx_pwr_all =
+					14 -
+					((pcck_buf->cck_agc_rpt & 0x1f) << 1);
 				break;
 			}
 		}
@@ -802,11 +813,13 @@ static void query_rx_phy_status(struct _adapter *padapter,
 		prframe->u.hdr.attrib.rx_mimo_signal_qual[1] = -1;
 	} else {
 		/* (1)Get RSSI for HT rate */
-		for (i = 0; i < ((padapter->registrypriv.rf_config) &
-			    0x0f); i++) {
+		for (i = 0; i < ((padapter->registrypriv.rf_config) & 0x0f);
+		     i++) {
 			rf_rx_num++;
-			rx_pwr[i] = ((pphy_head[PHY_STAT_GAIN_TRSW_SHT + i]
-				    & 0x3F) * 2) - 110;
+			rx_pwr[i] = ((pphy_head[PHY_STAT_GAIN_TRSW_SHT + i] &
+				      0x3F) *
+				     2) -
+				    110;
 			/* Translate DBM to percentage. */
 			rssi = query_rx_pwr_percentage(rx_pwr[i]);
 			total_rssi += rssi;
@@ -814,8 +827,9 @@ static void query_rx_phy_status(struct _adapter *padapter,
 		/* (2)PWDB, Average PWDB calculated by hardware (for
 		 * rate adaptive)
 		 */
-		rx_pwr_all = (((pphy_head[PHY_STAT_PWDB_ALL_SHT]) >> 1) & 0x7f)
-			     - 106;
+		rx_pwr_all =
+			(((pphy_head[PHY_STAT_PWDB_ALL_SHT]) >> 1) & 0x7f) -
+			106;
 		pwdb_all = query_rx_pwr_percentage(rx_pwr_all);
 
 		{
@@ -830,12 +844,13 @@ static void query_rx_phy_status(struct _adapter *padapter,
 				max_spatial_stream = 1;
 			}
 			for (i = 0; i < max_spatial_stream; i++) {
-				evm = evm_db2percentage((pphy_head
-				      [PHY_STAT_RXEVM_SHT + i]));/*dbm*/
+				evm = evm_db2percentage(
+					(pphy_head[PHY_STAT_RXEVM_SHT +
+						   i])); /*dbm*/
 				prframe->u.hdr.attrib.signal_qual =
-					 (u8)(evm & 0xff);
+					(u8)(evm & 0xff);
 				prframe->u.hdr.attrib.rx_mimo_signal_qual[i] =
-					 (u8)(evm & 0xff);
+					(u8)(evm & 0xff);
 			}
 		}
 	}
@@ -845,19 +860,19 @@ static void query_rx_phy_status(struct _adapter *padapter,
 	 */
 	if (bcck_rate) {
 		prframe->u.hdr.attrib.signal_strength =
-			 (u8)r8712_signal_scale_mapping(pwdb_all);
+			(u8)r8712_signal_scale_mapping(pwdb_all);
 	} else {
 		if (rf_rx_num != 0)
 			prframe->u.hdr.attrib.signal_strength =
-				 (u8)(r8712_signal_scale_mapping(total_rssi /=
-				 rf_rx_num));
+				(u8)(r8712_signal_scale_mapping(total_rssi /=
+								rf_rx_num));
 	}
 }
 
 static void process_link_qual(struct _adapter *padapter,
 			      union recv_frame *prframe)
 {
-	u32	last_evm = 0, avg_val;
+	u32 last_evm = 0, avg_val;
 	struct rx_pkt_attrib *pattrib;
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
 
@@ -908,7 +923,7 @@ static void process_phy_info(struct _adapter *padapter,
 {
 	query_rx_phy_status(padapter, prframe);
 	process_rssi(padapter, prframe);
-	process_link_qual(padapter,  prframe);
+	process_link_qual(padapter, prframe);
 }
 
 int recv_func(struct _adapter *padapter, void *pcontext)
@@ -916,8 +931,8 @@ int recv_func(struct _adapter *padapter, void *pcontext)
 	struct rx_pkt_attrib *pattrib;
 	union recv_frame *prframe, *orig_prframe;
 	int retval = _SUCCESS;
-	struct  __queue *pfree_recv_queue = &padapter->recvpriv.free_recv_queue;
-	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct __queue *pfree_recv_queue = &padapter->recvpriv.free_recv_queue;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	prframe = pcontext;
 	orig_prframe = prframe;
@@ -966,13 +981,13 @@ int recv_func(struct _adapter *padapter, void *pcontext)
 static void recvbuf2recvframe(struct _adapter *padapter, struct sk_buff *pskb)
 {
 	u8 *pbuf, shift_sz = 0;
-	u8	frag, mf;
-	uint	pkt_len;
+	u8 frag, mf;
+	uint pkt_len;
 	u32 transfer_len;
 	struct recv_stat *prxstat;
-	u16	pkt_cnt, drvinfo_sz, pkt_offset, tmp_len, alloc_sz;
-	struct  __queue *pfree_recv_queue;
-	_pkt  *pkt_copy = NULL;
+	u16 pkt_cnt, drvinfo_sz, pkt_offset, tmp_len, alloc_sz;
+	struct __queue *pfree_recv_queue;
+	_pkt *pkt_copy = NULL;
 	union recv_frame *precvframe = NULL;
 	struct recv_priv *precvpriv = &padapter->recvpriv;
 
@@ -980,7 +995,7 @@ static void recvbuf2recvframe(struct _adapter *padapter, struct sk_buff *pskb)
 	pbuf = pskb->data;
 	prxstat = (struct recv_stat *)pbuf;
 	pkt_cnt = (le32_to_cpu(prxstat->rxdw2) >> 16) & 0xff;
-	pkt_len =  le32_to_cpu(prxstat->rxdw0) & 0x00003fff;
+	pkt_len = le32_to_cpu(prxstat->rxdw0) & 0x00003fff;
 	transfer_len = pskb->len;
 	/* Test throughput with Netgear 3700 (No security) with Chariot 3T3R
 	 * pairs. The packet count will be a big number so that the containing
@@ -994,7 +1009,7 @@ static void recvbuf2recvframe(struct _adapter *padapter, struct sk_buff *pskb)
 	}
 	do {
 		prxstat = (struct recv_stat *)pbuf;
-		pkt_len =  le32_to_cpu(prxstat->rxdw0) & 0x00003fff;
+		pkt_len = le32_to_cpu(prxstat->rxdw0) & 0x00003fff;
 		/* more fragment bit */
 		mf = (le32_to_cpu(prxstat->rxdw1) >> 27) & 0x1;
 		/* ragmentation number */
@@ -1018,7 +1033,7 @@ static void recvbuf2recvframe(struct _adapter *padapter, struct sk_buff *pskb)
 		/* for first fragment packet, driver need allocate 1536 +
 		 * drvinfo_sz + RXDESC_SIZE to defrag packet.
 		 */
-		if ((mf == 1) && (frag == 0))
+		if (mf == 1 && frag == 0)
 			/*1658+6=1664, 1664 is 128 alignment.*/
 			alloc_sz = max_t(u16, tmp_len, 1658);
 		else
@@ -1059,8 +1074,8 @@ static void recvbuf2recvframe(struct _adapter *padapter, struct sk_buff *pskb)
 static void recv_tasklet(struct tasklet_struct *t)
 {
 	struct sk_buff *pskb;
-	struct _adapter *padapter = from_tasklet(padapter, t,
-						 recvpriv.recv_tasklet);
+	struct _adapter *padapter =
+		from_tasklet(padapter, t, recvpriv.recv_tasklet);
 	struct recv_priv *precvpriv = &padapter->recvpriv;
 
 	while (NULL != (pskb = skb_dequeue(&precvpriv->rx_skb_queue))) {
diff --git a/drivers/staging/rtl8712/rtl8712_recv.h b/drivers/staging/rtl8712/rtl8712_recv.h
index a1360dcf91ce..bb101a027fef 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.h
+++ b/drivers/staging/rtl8712/rtl8712_recv.h
@@ -24,7 +24,7 @@
 #define NR_RECVBUFF (8)
 
 #define NR_PREALLOC_RECV_SKB (8)
-#define RXDESC_SIZE	24
+#define RXDESC_SIZE 24
 #define RXDESC_OFFSET RXDESC_SIZE
 #define RECV_BLK_SZ 512
 #define RECV_BLK_CNT 16
@@ -33,9 +33,9 @@
 #define RECVBUFF_ALIGN_SZ 512
 #define RSVD_ROOM_SZ (0)
 /*These definition is used for Rx packet reordering.*/
-#define SN_LESS(a, b)		(((a-b) & 0x800) != 0)
-#define SN_EQUAL(a, b)	(a == b)
-#define REORDER_WAIT_TIME	30 /* (ms)*/
+#define SN_LESS(a, b) (((a - b) & 0x800) != 0)
+#define SN_EQUAL(a, b) (a == b)
+#define REORDER_WAIT_TIME 30 /* (ms)*/
 
 struct recv_stat {
 	__le32 rxdw0;
@@ -51,9 +51,9 @@ struct phy_cck_rx_status {
 	 * LSB bit present 0.5. And MSB 7 bts present a signed value.
 	 * Range from -64~+63.5.
 	 */
-	u8	adc_pwdb_X[4];
-	u8	sq_rpt;
-	u8	cck_agc_rpt;
+	u8 adc_pwdb_X[4];
+	u8 sq_rpt;
+	u8 cck_agc_rpt;
 };
 
 struct phy_stat {
@@ -88,13 +88,13 @@ union recvstat {
 struct recv_buf {
 	struct list_head list;
 	spinlock_t recvbuf_lock;
-	u32	ref_cnt;
-	struct _adapter  *adapter;
+	u32 ref_cnt;
+	struct _adapter *adapter;
 	struct urb *purb;
 	_pkt *pskb;
-	u8  irp_pending;
-	u32  transfer_len;
-	uint  len;
+	u8 irp_pending;
+	u32 transfer_len;
+	uint len;
 	u8 *phead;
 	u8 *pdata;
 	u8 *ptail;
@@ -113,12 +113,12 @@ struct recv_buf {
  */
 struct recv_frame_hdr {
 	struct list_head list;
-	_pkt	*pkt;
+	_pkt *pkt;
 	_pkt *pkt_newalloc;
-	struct _adapter  *adapter;
+	struct _adapter *adapter;
 	u8 fragcnt;
 	struct rx_pkt_attrib attrib;
-	uint  len;
+	uint len;
 	u8 *rx_head;
 	u8 *rx_data;
 	u8 *rx_tail;
@@ -142,4 +142,3 @@ s32 r8712_signal_scale_mapping(s32 cur_sig);
 void r8712_reordering_ctrl_timeout_handler(void *pcontext);
 
 #endif
-
diff --git a/drivers/staging/rtl8712/rtl8712_regdef.h b/drivers/staging/rtl8712/rtl8712_regdef.h
index 28aec9aa539f..616a78106df0 100644
--- a/drivers/staging/rtl8712/rtl8712_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_regdef.h
@@ -26,7 +26,6 @@
 #include "rtl8712_gp_regdef.h"
 #include "rtl8712_debugctrl_regdef.h"
 
-#define HIMR	(RTL8712_INTERRUPT_ + 0x08)
+#define HIMR (RTL8712_INTERRUPT_ + 0x08)
 
 #endif /* __RTL8712_REGDEF_H__*/
-
diff --git a/drivers/staging/rtl8712/rtl8712_security_bitdef.h b/drivers/staging/rtl8712/rtl8712_security_bitdef.h
index 44275ef455a0..00e6675a4e9c 100644
--- a/drivers/staging/rtl8712/rtl8712_security_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_security_bitdef.h
@@ -8,27 +8,26 @@
 #define __RTL8712_SECURITY_BITDEF_H__
 
 /*CAMCMD*/
-#define	_SECCAM_POLLING				BIT(31)
-#define	_SECCAM_CLR					BIT(30)
-#define	_SECCAM_WE					BIT(16)
-#define	_SECCAM_ADR_MSK				0x000000FF
-#define	_SECCAM_ADR_SHT				0
+#define _SECCAM_POLLING BIT(31)
+#define _SECCAM_CLR BIT(30)
+#define _SECCAM_WE BIT(16)
+#define _SECCAM_ADR_MSK 0x000000FF
+#define _SECCAM_ADR_SHT 0
 
 /*CAMDBG*/
-#define	_SECCAM_INFO				BIT(31)
-#define	_SEC_KEYFOUND				BIT(30)
-#define	_SEC_CONFIG_MSK				0x3F000000
-#define	_SEC_CONFIG_SHT				24
-#define	_SEC_KEYCONTENT_MSK			0x00FFFFFF
-#define	_SEC_KEYCONTENT_SHT			0
+#define _SECCAM_INFO BIT(31)
+#define _SEC_KEYFOUND BIT(30)
+#define _SEC_CONFIG_MSK 0x3F000000
+#define _SEC_CONFIG_SHT 24
+#define _SEC_KEYCONTENT_MSK 0x00FFFFFF
+#define _SEC_KEYCONTENT_SHT 0
 
 /*SECCFG*/
-#define	_NOSKMC						BIT(5)
-#define	_SKBYA2						BIT(4)
-#define	_RXDEC						BIT(3)
-#define	_TXENC						BIT(2)
-#define	_RXUSEDK					BIT(1)
-#define	_TXUSEDK					BIT(0)
-
-#endif	/*__RTL8712_SECURITY_BITDEF_H__*/
+#define _NOSKMC BIT(5)
+#define _SKBYA2 BIT(4)
+#define _RXDEC BIT(3)
+#define _TXENC BIT(2)
+#define _RXUSEDK BIT(1)
+#define _TXUSEDK BIT(0)
 
+#endif /*__RTL8712_SECURITY_BITDEF_H__*/
diff --git a/drivers/staging/rtl8712/rtl8712_spec.h b/drivers/staging/rtl8712/rtl8712_spec.h
index 613a410e5714..3f03f501d3dc 100644
--- a/drivers/staging/rtl8712/rtl8712_spec.h
+++ b/drivers/staging/rtl8712/rtl8712_spec.h
@@ -14,102 +14,103 @@
 #ifndef __RTL8712_SPEC_H__
 #define __RTL8712_SPEC_H__
 
-#define RTL8712_IOBASE_TXPKT		0x10200000	/*IOBASE_TXPKT*/
-#define RTL8712_IOBASE_RXPKT		0x10210000	/*IOBASE_RXPKT*/
-#define RTL8712_IOBASE_RXCMD		0x10220000	/*IOBASE_RXCMD*/
-#define RTL8712_IOBASE_TXSTATUS		0x10230000	/*IOBASE_TXSTATUS*/
-#define RTL8712_IOBASE_RXSTATUS		0x10240000	/*IOBASE_RXSTATUS*/
-#define RTL8712_IOBASE_IOREG		0x10250000	/*IOBASE_IOREG ADDR*/
-#define RTL8712_IOBASE_SCHEDULER	0x10260000	/*IOBASE_SCHEDULE*/
-
-#define RTL8712_IOBASE_TRXDMA		0x10270000	/*IOBASE_TRXDMA*/
-#define RTL8712_IOBASE_TXLLT		0x10280000	/*IOBASE_TXLLT*/
-#define RTL8712_IOBASE_WMAC		0x10290000	/*IOBASE_WMAC*/
-#define RTL8712_IOBASE_FW2HW		0x102A0000	/*IOBASE_FW2HW*/
-#define RTL8712_IOBASE_ACCESS_PHYREG	0x102B0000	/*IOBASE_ACCESS_PHYREG*/
-
-#define RTL8712_IOBASE_FF	0x10300000 /*IOBASE_FIFO 0x1031000~0x103AFFFF*/
+#define RTL8712_IOBASE_TXPKT 0x10200000 /*IOBASE_TXPKT*/
+#define RTL8712_IOBASE_RXPKT 0x10210000 /*IOBASE_RXPKT*/
+#define RTL8712_IOBASE_RXCMD 0x10220000 /*IOBASE_RXCMD*/
+#define RTL8712_IOBASE_TXSTATUS 0x10230000 /*IOBASE_TXSTATUS*/
+#define RTL8712_IOBASE_RXSTATUS 0x10240000 /*IOBASE_RXSTATUS*/
+#define RTL8712_IOBASE_IOREG 0x10250000 /*IOBASE_IOREG ADDR*/
+#define RTL8712_IOBASE_SCHEDULER 0x10260000 /*IOBASE_SCHEDULE*/
+
+#define RTL8712_IOBASE_TRXDMA 0x10270000 /*IOBASE_TRXDMA*/
+#define RTL8712_IOBASE_TXLLT 0x10280000 /*IOBASE_TXLLT*/
+#define RTL8712_IOBASE_WMAC 0x10290000 /*IOBASE_WMAC*/
+#define RTL8712_IOBASE_FW2HW 0x102A0000 /*IOBASE_FW2HW*/
+#define RTL8712_IOBASE_ACCESS_PHYREG 0x102B0000 /*IOBASE_ACCESS_PHYREG*/
+
+#define RTL8712_IOBASE_FF 0x10300000 /*IOBASE_FIFO 0x1031000~0x103AFFFF*/
 
 /*IOREG Offset for 8712*/
-#define RTL8712_SYSCFG_		RTL8712_IOBASE_IOREG
-#define RTL8712_CMDCTRL_	(RTL8712_IOBASE_IOREG + 0x40)
-#define RTL8712_MACIDSETTING_	(RTL8712_IOBASE_IOREG + 0x50)
-#define RTL8712_TIMECTRL_	(RTL8712_IOBASE_IOREG + 0x80)
-#define RTL8712_FIFOCTRL_	(RTL8712_IOBASE_IOREG + 0xA0)
-#define RTL8712_RATECTRL_	(RTL8712_IOBASE_IOREG + 0x160)
-#define RTL8712_EDCASETTING_	(RTL8712_IOBASE_IOREG + 0x1D0)
-#define RTL8712_WMAC_		(RTL8712_IOBASE_IOREG + 0x200)
-#define RTL8712_SECURITY_	(RTL8712_IOBASE_IOREG + 0x240)
-#define RTL8712_POWERSAVE_	(RTL8712_IOBASE_IOREG + 0x260)
-#define RTL8712_GP_		(RTL8712_IOBASE_IOREG + 0x2E0)
-#define RTL8712_INTERRUPT_	(RTL8712_IOBASE_IOREG + 0x300)
-#define RTL8712_DEBUGCTRL_	(RTL8712_IOBASE_IOREG + 0x310)
-#define RTL8712_OFFLOAD_	(RTL8712_IOBASE_IOREG + 0x2D0)
+#define RTL8712_SYSCFG_ RTL8712_IOBASE_IOREG
+#define RTL8712_CMDCTRL_ (RTL8712_IOBASE_IOREG + 0x40)
+#define RTL8712_MACIDSETTING_ (RTL8712_IOBASE_IOREG + 0x50)
+#define RTL8712_TIMECTRL_ (RTL8712_IOBASE_IOREG + 0x80)
+#define RTL8712_FIFOCTRL_ (RTL8712_IOBASE_IOREG + 0xA0)
+#define RTL8712_RATECTRL_ (RTL8712_IOBASE_IOREG + 0x160)
+#define RTL8712_EDCASETTING_ (RTL8712_IOBASE_IOREG + 0x1D0)
+#define RTL8712_WMAC_ (RTL8712_IOBASE_IOREG + 0x200)
+#define RTL8712_SECURITY_ (RTL8712_IOBASE_IOREG + 0x240)
+#define RTL8712_POWERSAVE_ (RTL8712_IOBASE_IOREG + 0x260)
+#define RTL8712_GP_ (RTL8712_IOBASE_IOREG + 0x2E0)
+#define RTL8712_INTERRUPT_ (RTL8712_IOBASE_IOREG + 0x300)
+#define RTL8712_DEBUGCTRL_ (RTL8712_IOBASE_IOREG + 0x310)
+#define RTL8712_OFFLOAD_ (RTL8712_IOBASE_IOREG + 0x2D0)
 
 /*FIFO for 8712*/
-#define RTL8712_DMA_BCNQ	(RTL8712_IOBASE_FF + 0x10000)
-#define RTL8712_DMA_MGTQ	(RTL8712_IOBASE_FF + 0x20000)
-#define RTL8712_DMA_BMCQ	(RTL8712_IOBASE_FF + 0x30000)
-#define RTL8712_DMA_VOQ		(RTL8712_IOBASE_FF + 0x40000)
-#define RTL8712_DMA_VIQ		(RTL8712_IOBASE_FF + 0x50000)
-#define RTL8712_DMA_BEQ		(RTL8712_IOBASE_FF + 0x60000)
-#define RTL8712_DMA_BKQ		(RTL8712_IOBASE_FF + 0x70000)
-#define RTL8712_DMA_RX0FF	(RTL8712_IOBASE_FF + 0x80000)
-#define RTL8712_DMA_H2CCMD	(RTL8712_IOBASE_FF + 0x90000)
-#define RTL8712_DMA_C2HCMD	(RTL8712_IOBASE_FF + 0xA0000)
+#define RTL8712_DMA_BCNQ (RTL8712_IOBASE_FF + 0x10000)
+#define RTL8712_DMA_MGTQ (RTL8712_IOBASE_FF + 0x20000)
+#define RTL8712_DMA_BMCQ (RTL8712_IOBASE_FF + 0x30000)
+#define RTL8712_DMA_VOQ (RTL8712_IOBASE_FF + 0x40000)
+#define RTL8712_DMA_VIQ (RTL8712_IOBASE_FF + 0x50000)
+#define RTL8712_DMA_BEQ (RTL8712_IOBASE_FF + 0x60000)
+#define RTL8712_DMA_BKQ (RTL8712_IOBASE_FF + 0x70000)
+#define RTL8712_DMA_RX0FF (RTL8712_IOBASE_FF + 0x80000)
+#define RTL8712_DMA_H2CCMD (RTL8712_IOBASE_FF + 0x90000)
+#define RTL8712_DMA_C2HCMD (RTL8712_IOBASE_FF + 0xA0000)
 
 /*------------------------------*/
 
 /*BIT 16 15*/
-#define	DID_SDIO_LOCAL			0	/* 0 0*/
-#define	DID_WLAN_IOREG			1	/* 0 1*/
-#define	DID_WLAN_FIFO			3	/* 1 1*/
-#define   DID_UNDEFINE				(-1)
+#define DID_SDIO_LOCAL 0 /* 0 0*/
+#define DID_WLAN_IOREG 1 /* 0 1*/
+#define DID_WLAN_FIFO 3 /* 1 1*/
+#define DID_UNDEFINE (-1)
 
-#define CMD_ADDR_MAPPING_SHIFT		2	/*SDIO CMD ADDR MAPPING,
+#define CMD_ADDR_MAPPING_SHIFT \
+	2 /*SDIO CMD ADDR MAPPING,
 						 *shift 2 bit for match
 						 * offset[14:2]
 						 */
 
 /*Offset for SDIO LOCAL*/
-#define	OFFSET_SDIO_LOCAL				0x0FFF
+#define OFFSET_SDIO_LOCAL 0x0FFF
 
 /*Offset for WLAN IOREG*/
-#define OFFSET_WLAN_IOREG				0x0FFF
+#define OFFSET_WLAN_IOREG 0x0FFF
 
 /*Offset for WLAN FIFO*/
-#define	OFFSET_TX_BCNQ				0x0300
-#define	OFFSET_TX_HIQ					0x0310
-#define	OFFSET_TX_CMDQ				0x0320
-#define	OFFSET_TX_MGTQ				0x0330
-#define	OFFSET_TX_HCCAQ				0x0340
-#define	OFFSET_TX_VOQ					0x0350
-#define	OFFSET_TX_VIQ					0x0360
-#define	OFFSET_TX_BEQ					0x0370
-#define	OFFSET_TX_BKQ					0x0380
-#define	OFFSET_RX_RX0FFQ				0x0390
-#define	OFFSET_RX_C2HFFQ				0x03A0
-
-#define	BK_QID_01	1
-#define	BK_QID_02	2
-#define	BE_QID_01	0
-#define	BE_QID_02	3
-#define	VI_QID_01	4
-#define	VI_QID_02	5
-#define	VO_QID_01	6
-#define	VO_QID_02	7
-#define	HCCA_QID_01	8
-#define	HCCA_QID_02	9
-#define	HCCA_QID_03	10
-#define	HCCA_QID_04	11
-#define	HCCA_QID_05	12
-#define	HCCA_QID_06	13
-#define	HCCA_QID_07	14
-#define	HCCA_QID_08	15
-#define	HI_QID		17
-#define	CMD_QID	19
-#define	MGT_QID	18
-#define	BCN_QID	16
+#define OFFSET_TX_BCNQ 0x0300
+#define OFFSET_TX_HIQ 0x0310
+#define OFFSET_TX_CMDQ 0x0320
+#define OFFSET_TX_MGTQ 0x0330
+#define OFFSET_TX_HCCAQ 0x0340
+#define OFFSET_TX_VOQ 0x0350
+#define OFFSET_TX_VIQ 0x0360
+#define OFFSET_TX_BEQ 0x0370
+#define OFFSET_TX_BKQ 0x0380
+#define OFFSET_RX_RX0FFQ 0x0390
+#define OFFSET_RX_C2HFFQ 0x03A0
+
+#define BK_QID_01 1
+#define BK_QID_02 2
+#define BE_QID_01 0
+#define BE_QID_02 3
+#define VI_QID_01 4
+#define VI_QID_02 5
+#define VO_QID_01 6
+#define VO_QID_02 7
+#define HCCA_QID_01 8
+#define HCCA_QID_02 9
+#define HCCA_QID_03 10
+#define HCCA_QID_04 11
+#define HCCA_QID_05 12
+#define HCCA_QID_06 13
+#define HCCA_QID_07 14
+#define HCCA_QID_08 15
+#define HI_QID 17
+#define CMD_QID 19
+#define MGT_QID 18
+#define BCN_QID 16
 
 #include "rtl8712_regdef.h"
 
@@ -118,4 +119,3 @@
 #include "basic_types.h"
 
 #endif /* __RTL8712_SPEC_H__ */
-
diff --git a/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h b/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h
index d92df3fbd2b1..93c2f79be34a 100644
--- a/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h
@@ -20,144 +20,152 @@
 /*SYS_CLKR*/
 
 /*SYS_IOS_CTRL*/
-#define iso_LDR2RP_SHT		8 /* EE Loader to Retention Path*/
-#define iso_LDR2RP		BIT(iso_LDR2RP_SHT) /* 1:isolation, 0:attach*/
+#define iso_LDR2RP_SHT 8 /* EE Loader to Retention Path*/
+#define iso_LDR2RP BIT(iso_LDR2RP_SHT) /* 1:isolation, 0:attach*/
 
 /*SYS_CTRL*/
-#define FEN_DIO_SDIO_SHT	0
-#define FEN_DIO_SDIO		BIT(FEN_DIO_SDIO_SHT)
-#define FEN_SDIO_SHT		1
-#define FEN_SDIO		BIT(FEN_SDIO_SHT)
-#define FEN_USBA_SHT		2
-#define FEN_USBA		BIT(FEN_USBA_SHT)
-#define FEN_UPLL_SHT		3
-#define FEN_UPLL		BIT(FEN_UPLL_SHT)
-#define FEN_USBD_SHT		4
-#define FEN_USBD		BIT(FEN_USBD_SHT)
-#define FEN_DIO_PCIE_SHT	5
-#define FEN_DIO_PCIE		BIT(FEN_DIO_PCIE_SHT)
-#define FEN_PCIEA_SHT		6
-#define FEN_PCIEA		BIT(FEN_PCIEA_SHT)
-#define FEN_PPLL_SHT		7
-#define FEN_PPLL		BIT(FEN_PPLL_SHT)
-#define FEN_PCIED_SHT		8
-#define FEN_PCIED		BIT(FEN_PCIED_SHT)
-#define FEN_CPUEN_SHT		10
-#define FEN_CPUEN		BIT(FEN_CPUEN_SHT)
-#define FEN_DCORE_SHT		11
-#define FEN_DCORE		BIT(FEN_DCORE_SHT)
-#define FEN_ELDR_SHT		12
-#define FEN_ELDR		BIT(FEN_ELDR_SHT)
-#define PWC_DV2LDR_SHT		13
-#define PWC_DV2LDR		BIT(PWC_DV2LDR_SHT) /* Loader Power Enable*/
+#define FEN_DIO_SDIO_SHT 0
+#define FEN_DIO_SDIO BIT(FEN_DIO_SDIO_SHT)
+#define FEN_SDIO_SHT 1
+#define FEN_SDIO BIT(FEN_SDIO_SHT)
+#define FEN_USBA_SHT 2
+#define FEN_USBA BIT(FEN_USBA_SHT)
+#define FEN_UPLL_SHT 3
+#define FEN_UPLL BIT(FEN_UPLL_SHT)
+#define FEN_USBD_SHT 4
+#define FEN_USBD BIT(FEN_USBD_SHT)
+#define FEN_DIO_PCIE_SHT 5
+#define FEN_DIO_PCIE BIT(FEN_DIO_PCIE_SHT)
+#define FEN_PCIEA_SHT 6
+#define FEN_PCIEA BIT(FEN_PCIEA_SHT)
+#define FEN_PPLL_SHT 7
+#define FEN_PPLL BIT(FEN_PPLL_SHT)
+#define FEN_PCIED_SHT 8
+#define FEN_PCIED BIT(FEN_PCIED_SHT)
+#define FEN_CPUEN_SHT 10
+#define FEN_CPUEN BIT(FEN_CPUEN_SHT)
+#define FEN_DCORE_SHT 11
+#define FEN_DCORE BIT(FEN_DCORE_SHT)
+#define FEN_ELDR_SHT 12
+#define FEN_ELDR BIT(FEN_ELDR_SHT)
+#define PWC_DV2LDR_SHT 13
+#define PWC_DV2LDR BIT(PWC_DV2LDR_SHT) /* Loader Power Enable*/
 
 /*=== SYS_CLKR ===*/
-#define SYS_CLKSEL_SHT		0
-#define SYS_CLKSEL		BIT(SYS_CLKSEL_SHT) /* System Clock 80MHz*/
-#define PS_CLKSEL_SHT		1
-#define PS_CLKSEL		BIT(PS_CLKSEL_SHT) /*System power save
+#define SYS_CLKSEL_SHT 0
+#define SYS_CLKSEL BIT(SYS_CLKSEL_SHT) /* System Clock 80MHz*/
+#define PS_CLKSEL_SHT 1
+#define PS_CLKSEL \
+	BIT(PS_CLKSEL_SHT) /*System power save
 						    * clock select.
 						    */
-#define CPU_CLKSEL_SHT		2
-#define CPU_CLKSEL		BIT(CPU_CLKSEL_SHT) /* System Clock select,
+#define CPU_CLKSEL_SHT 2
+#define CPU_CLKSEL \
+	BIT(CPU_CLKSEL_SHT) /* System Clock select,
 						     * 1: AFE source,
 						     * 0: System clock(L-Bus)
 						     */
-#define INT32K_EN_SHT		3
-#define INT32K_EN		BIT(INT32K_EN_SHT)
-#define MACSLP_SHT		4
-#define MACSLP			BIT(MACSLP_SHT)
-#define MAC_CLK_EN_SHT		11
-#define MAC_CLK_EN		BIT(MAC_CLK_EN_SHT) /* MAC Clock Enable.*/
-#define SYS_CLK_EN_SHT		12
-#define SYS_CLK_EN		BIT(SYS_CLK_EN_SHT)
-#define RING_CLK_EN_SHT		13
-#define RING_CLK_EN		BIT(RING_CLK_EN_SHT)
-#define SWHW_SEL_SHT		14
-#define SWHW_SEL		BIT(SWHW_SEL_SHT) /* Load done,
+#define INT32K_EN_SHT 3
+#define INT32K_EN BIT(INT32K_EN_SHT)
+#define MACSLP_SHT 4
+#define MACSLP BIT(MACSLP_SHT)
+#define MAC_CLK_EN_SHT 11
+#define MAC_CLK_EN BIT(MAC_CLK_EN_SHT) /* MAC Clock Enable.*/
+#define SYS_CLK_EN_SHT 12
+#define SYS_CLK_EN BIT(SYS_CLK_EN_SHT)
+#define RING_CLK_EN_SHT 13
+#define RING_CLK_EN BIT(RING_CLK_EN_SHT)
+#define SWHW_SEL_SHT 14
+#define SWHW_SEL \
+	BIT(SWHW_SEL_SHT) /* Load done,
 						   * control path switch.
 						   */
-#define FWHW_SEL_SHT		15
-#define FWHW_SEL		BIT(FWHW_SEL_SHT) /* Sleep exit,
+#define FWHW_SEL_SHT 15
+#define FWHW_SEL \
+	BIT(FWHW_SEL_SHT) /* Sleep exit,
 						   * control path switch.
 						   */
 
 /*9346CR*/
-#define	_VPDIDX_MSK		0xFF00
-#define	_VPDIDX_SHT		8
-#define	_EEM_MSK		0x00C0
-#define	_EEM_SHT		6
-#define	_EEM0			BIT(6)
-#define	_EEM1			BIT(7)
-#define	_EEPROM_EN		BIT(5)
-#define	_9356SEL		BIT(4)
-#define	_EECS			BIT(3)
-#define	_EESK			BIT(2)
-#define	_EEDI			BIT(1)
-#define	_EEDO			BIT(0)
+#define _VPDIDX_MSK 0xFF00
+#define _VPDIDX_SHT 8
+#define _EEM_MSK 0x00C0
+#define _EEM_SHT 6
+#define _EEM0 BIT(6)
+#define _EEM1 BIT(7)
+#define _EEPROM_EN BIT(5)
+#define _9356SEL BIT(4)
+#define _EECS BIT(3)
+#define _EESK BIT(2)
+#define _EEDI BIT(1)
+#define _EEDO BIT(0)
 
 /*AFE_MISC*/
-#define	AFE_MISC_USB_MBEN_SHT	7
-#define	AFE_MISC_USB_MBEN	BIT(AFE_MISC_USB_MBEN_SHT)
-#define	AFE_MISC_USB_BGEN_SHT	6
-#define	AFE_MISC_USB_BGEN	BIT(AFE_MISC_USB_BGEN_SHT)
-#define	AFE_MISC_LD12_VDAJ_SHT	4
-#define	AFE_MISC_LD12_VDAJ_MSK	0X0030
-#define	AFE_MISC_LD12_VDAJ	BIT(AFE_MISC_LD12_VDAJ_SHT)
-#define	AFE_MISC_I32_EN_SHT	3
-#define	AFE_MISC_I32_EN		BIT(AFE_MISC_I32_EN_SHT)
-#define	AFE_MISC_E32_EN_SHT	2
-#define	AFE_MISC_E32_EN		BIT(AFE_MISC_E32_EN_SHT)
-#define	AFE_MISC_MBEN_SHT	1
-#define	AFE_MISC_MBEN		BIT(AFE_MISC_MBEN_SHT)/* Enable AFE Macro
+#define AFE_MISC_USB_MBEN_SHT 7
+#define AFE_MISC_USB_MBEN BIT(AFE_MISC_USB_MBEN_SHT)
+#define AFE_MISC_USB_BGEN_SHT 6
+#define AFE_MISC_USB_BGEN BIT(AFE_MISC_USB_BGEN_SHT)
+#define AFE_MISC_LD12_VDAJ_SHT 4
+#define AFE_MISC_LD12_VDAJ_MSK 0X0030
+#define AFE_MISC_LD12_VDAJ BIT(AFE_MISC_LD12_VDAJ_SHT)
+#define AFE_MISC_I32_EN_SHT 3
+#define AFE_MISC_I32_EN BIT(AFE_MISC_I32_EN_SHT)
+#define AFE_MISC_E32_EN_SHT 2
+#define AFE_MISC_E32_EN BIT(AFE_MISC_E32_EN_SHT)
+#define AFE_MISC_MBEN_SHT 1
+#define AFE_MISC_MBEN \
+	BIT(AFE_MISC_MBEN_SHT) /* Enable AFE Macro
 						       * Block's Mbias.
 						       */
-#define	AFE_MISC_BGEN_SHT	0
-#define	AFE_MISC_BGEN		BIT(AFE_MISC_BGEN_SHT)/* Enable AFE Macro
+#define AFE_MISC_BGEN_SHT 0
+#define AFE_MISC_BGEN \
+	BIT(AFE_MISC_BGEN_SHT) /* Enable AFE Macro
 						       * Block's Bandgap.
 						       */
 
 /*--------------------------------------------------------------------------*/
 /*       SPS1_CTRL bits				(Offset 0x18-1E, 56bits)*/
 /*--------------------------------------------------------------------------*/
-#define	SPS1_SWEN		BIT(1)	/* Enable vsps18 SW Macro Block.*/
-#define	SPS1_LDEN		BIT(0)	/* Enable VSPS12 LDO Macro block.*/
+#define SPS1_SWEN BIT(1) /* Enable vsps18 SW Macro Block.*/
+#define SPS1_LDEN BIT(0) /* Enable VSPS12 LDO Macro block.*/
 
 /*----------------------------------------------------------------------------*/
 /*       LDOA15_CTRL bits		(Offset 0x20, 8bits)*/
 /*----------------------------------------------------------------------------*/
-#define	LDA15_EN		BIT(0)	/* Enable LDOA15 Macro Block*/
+#define LDA15_EN BIT(0) /* Enable LDOA15 Macro Block*/
 
 /*----------------------------------------------------------------------------*/
 /*       8192S LDOV12D_CTRL bit		(Offset 0x21, 8bits)*/
 /*----------------------------------------------------------------------------*/
-#define	LDV12_EN		BIT(0)	/* Enable LDOVD12 Macro Block*/
-#define	LDV12_SDBY		BIT(1)	/* LDOVD12 standby mode*/
+#define LDV12_EN BIT(0) /* Enable LDOVD12 Macro Block*/
+#define LDV12_SDBY BIT(1) /* LDOVD12 standby mode*/
 
 /*CLK_PS_CTRL*/
-#define	_CLK_GATE_EN		BIT(0)
+#define _CLK_GATE_EN BIT(0)
 
 /* EFUSE_CTRL*/
-#define EF_FLAG			BIT(31)		/* Access Flag, Write:1;
+#define EF_FLAG \
+	BIT(31) /* Access Flag, Write:1;
 						 *	        Read:0
 						 */
-#define EF_PGPD			0x70000000	/* E-fuse Program time*/
-#define EF_RDT			0x0F000000	/* E-fuse read time: in the
+#define EF_PGPD 0x70000000 /* E-fuse Program time*/
+#define EF_RDT \
+	0x0F000000 /* E-fuse read time: in the
 						 * unit of cycle time
 						 */
-#define EF_PDN_EN		BIT(19)		/* EFuse Power down enable*/
-#define ALD_EN			BIT(18)		/* Autoload Enable*/
-#define EF_ADDR			0x0003FF00	/* Access Address*/
-#define EF_DATA			0x000000FF	/* Access Data*/
+#define EF_PDN_EN BIT(19) /* EFuse Power down enable*/
+#define ALD_EN BIT(18) /* Autoload Enable*/
+#define EF_ADDR 0x0003FF00 /* Access Address*/
+#define EF_DATA 0x000000FF /* Access Data*/
 
 /* EFUSE_TEST*/
-#define LDOE25_EN		BIT(31)		/* Enable LDOE25 Macro Block*/
+#define LDOE25_EN BIT(31) /* Enable LDOE25 Macro Block*/
 
 /* EFUSE_CLK_CTRL*/
-#define EFUSE_CLK_EN		BIT(1)		/* E-Fuse Clock Enable*/
-#define EFUSE_CLK_SEL		BIT(0)		/* E-Fuse Clock Select,
+#define EFUSE_CLK_EN BIT(1) /* E-Fuse Clock Enable*/
+#define EFUSE_CLK_SEL \
+	BIT(0) /* E-Fuse Clock Select,
 						 * 0:500K, 1:40M
 						 */
 
-#endif	/*__RTL8712_SYSCFG_BITDEF_H__*/
-
+#endif /*__RTL8712_SYSCFG_BITDEF_H__*/
diff --git a/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h b/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h
index da5efcdedabe..0c649cb4f0e1 100644
--- a/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h
@@ -14,29 +14,28 @@
 #ifndef __RTL8712_SYSCFG_REGDEF_H__
 #define __RTL8712_SYSCFG_REGDEF_H__
 
-#define SYS_ISO_CTRL		(RTL8712_SYSCFG_ + 0x0000)
-#define SYS_FUNC_EN		(RTL8712_SYSCFG_ + 0x0002)
-#define PMC_FSM			(RTL8712_SYSCFG_ + 0x0004)
-#define SYS_CLKR		(RTL8712_SYSCFG_ + 0x0008)
-#define EE_9346CR		(RTL8712_SYSCFG_ + 0x000A)
-#define EE_VPD			(RTL8712_SYSCFG_ + 0x000C)
-#define AFE_MISC		(RTL8712_SYSCFG_ + 0x0010)
-#define SPS0_CTRL		(RTL8712_SYSCFG_ + 0x0011)
-#define SPS1_CTRL		(RTL8712_SYSCFG_ + 0x0018)
-#define RF_CTRL			(RTL8712_SYSCFG_ + 0x001F)
-#define LDOA15_CTRL		(RTL8712_SYSCFG_ + 0x0020)
-#define LDOV12D_CTRL		(RTL8712_SYSCFG_ + 0x0021)
-#define LDOHCI12_CTRL		(RTL8712_SYSCFG_ + 0x0022)
-#define LDO_USB_CTRL		(RTL8712_SYSCFG_ + 0x0023)
-#define LPLDO_CTRL		(RTL8712_SYSCFG_ + 0x0024)
-#define AFE_XTAL_CTRL		(RTL8712_SYSCFG_ + 0x0026)
-#define AFE_PLL_CTRL		(RTL8712_SYSCFG_ + 0x0028)
-#define EFUSE_CTRL		(RTL8712_SYSCFG_ + 0x0030)
-#define EFUSE_TEST		(RTL8712_SYSCFG_ + 0x0034)
-#define PWR_DATA		(RTL8712_SYSCFG_ + 0x0038)
-#define DPS_TIMER		(RTL8712_SYSCFG_ + 0x003C)
-#define RCLK_MON		(RTL8712_SYSCFG_ + 0x003E)
-#define EFUSE_CLK_CTRL		(RTL8712_SYSCFG_ + 0x02F8)
+#define SYS_ISO_CTRL (RTL8712_SYSCFG_ + 0x0000)
+#define SYS_FUNC_EN (RTL8712_SYSCFG_ + 0x0002)
+#define PMC_FSM (RTL8712_SYSCFG_ + 0x0004)
+#define SYS_CLKR (RTL8712_SYSCFG_ + 0x0008)
+#define EE_9346CR (RTL8712_SYSCFG_ + 0x000A)
+#define EE_VPD (RTL8712_SYSCFG_ + 0x000C)
+#define AFE_MISC (RTL8712_SYSCFG_ + 0x0010)
+#define SPS0_CTRL (RTL8712_SYSCFG_ + 0x0011)
+#define SPS1_CTRL (RTL8712_SYSCFG_ + 0x0018)
+#define RF_CTRL (RTL8712_SYSCFG_ + 0x001F)
+#define LDOA15_CTRL (RTL8712_SYSCFG_ + 0x0020)
+#define LDOV12D_CTRL (RTL8712_SYSCFG_ + 0x0021)
+#define LDOHCI12_CTRL (RTL8712_SYSCFG_ + 0x0022)
+#define LDO_USB_CTRL (RTL8712_SYSCFG_ + 0x0023)
+#define LPLDO_CTRL (RTL8712_SYSCFG_ + 0x0024)
+#define AFE_XTAL_CTRL (RTL8712_SYSCFG_ + 0x0026)
+#define AFE_PLL_CTRL (RTL8712_SYSCFG_ + 0x0028)
+#define EFUSE_CTRL (RTL8712_SYSCFG_ + 0x0030)
+#define EFUSE_TEST (RTL8712_SYSCFG_ + 0x0034)
+#define PWR_DATA (RTL8712_SYSCFG_ + 0x0038)
+#define DPS_TIMER (RTL8712_SYSCFG_ + 0x003C)
+#define RCLK_MON (RTL8712_SYSCFG_ + 0x003E)
+#define EFUSE_CLK_CTRL (RTL8712_SYSCFG_ + 0x02F8)
 
 #endif /*__RTL8712_SYSCFG_REGDEF_H__*/
-
diff --git a/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h b/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h
index d7bc9dd5cecd..206a1ecbd50d 100644
--- a/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h
@@ -12,19 +12,19 @@
 /*USTIME*/
 
 /*TUBASE*/
-#define	_TUBASE_MSK			0x07FF
+#define _TUBASE_MSK 0x07FF
 
 /*SIFS_CCK*/
-#define	_SIFS_CCK_TRX_MSK		0xFF00
-#define	_SIFS_CCK_TRX_SHT		0x8
-#define	_SIFS_CCK_CTX_MSK		0x00FF
-#define	_SIFS_CCK_CTX_SHT		0
+#define _SIFS_CCK_TRX_MSK 0xFF00
+#define _SIFS_CCK_TRX_SHT 0x8
+#define _SIFS_CCK_CTX_MSK 0x00FF
+#define _SIFS_CCK_CTX_SHT 0
 
 /*SIFS_OFDM*/
-#define	_SIFS_OFDM_TRX_MSK		0xFF00
-#define	_SIFS_OFDM_TRX_SHT		0x8
-#define	_SIFS_OFDM_CTX_MSK		0x00FF
-#define	_SIFS_OFDM_CTX_SHT		0
+#define _SIFS_OFDM_TRX_MSK 0xFF00
+#define _SIFS_OFDM_TRX_SHT 0x8
+#define _SIFS_OFDM_CTX_MSK 0x00FF
+#define _SIFS_OFDM_CTX_SHT 0
 
 /*PIFS*/
 /*ACKTO*/
@@ -33,17 +33,16 @@
 /*ATIMWND*/
 
 /*DRVERLYINT*/
-#define	_ENSWBCN				BIT(15)
-#define	_DRVERLY_TU_MSK			0x0FF0
-#define	_DRVERLY_TU_SHT			4
-#define	_DRVERLY_US_MSK			0x000F
-#define	_DRVERLY_US_SHT			0
+#define _ENSWBCN BIT(15)
+#define _DRVERLY_TU_MSK 0x0FF0
+#define _DRVERLY_TU_SHT 4
+#define _DRVERLY_US_MSK 0x000F
+#define _DRVERLY_US_SHT 0
 
 /*BCNDMATIM*/
-#define	_BCNDMATIM_MSK			0x03FF
+#define _BCNDMATIM_MSK 0x03FF
 
 /*BCNERRTH*/
 /*MLT*/
 
 #endif /* __RTL8712_TIMECTRL_BITDEF_H__*/
-
diff --git a/drivers/staging/rtl8712/rtl8712_timectrl_regdef.h b/drivers/staging/rtl8712/rtl8712_timectrl_regdef.h
index b51603f1b880..b5a63229ba45 100644
--- a/drivers/staging/rtl8712/rtl8712_timectrl_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_timectrl_regdef.h
@@ -7,20 +7,20 @@
 #ifndef __RTL8712_TIMECTRL_REGDEF_H__
 #define __RTL8712_TIMECTRL_REGDEF_H__
 
-#define TSFTR			(RTL8712_TIMECTRL_ + 0x00)
-#define USTIME			(RTL8712_TIMECTRL_ + 0x08)
-#define SLOT			(RTL8712_TIMECTRL_ + 0x09)
-#define TUBASE			(RTL8712_TIMECTRL_ + 0x0A)
-#define SIFS_CCK		(RTL8712_TIMECTRL_ + 0x0C)
-#define SIFS_OFDM		(RTL8712_TIMECTRL_ + 0x0E)
-#define PIFS			(RTL8712_TIMECTRL_ + 0x10)
-#define ACKTO			(RTL8712_TIMECTRL_ + 0x11)
-#define EIFS			(RTL8712_TIMECTRL_ + 0x12)
-#define BCNITV			(RTL8712_TIMECTRL_ + 0x14)
-#define ATIMWND			(RTL8712_TIMECTRL_ + 0x16)
-#define DRVERLYINT		(RTL8712_TIMECTRL_ + 0x18)
-#define BCNDMATIM		(RTL8712_TIMECTRL_ + 0x1A)
-#define BCNERRTH		(RTL8712_TIMECTRL_ + 0x1C)
-#define MLT			(RTL8712_TIMECTRL_ + 0x1D)
+#define TSFTR (RTL8712_TIMECTRL_ + 0x00)
+#define USTIME (RTL8712_TIMECTRL_ + 0x08)
+#define SLOT (RTL8712_TIMECTRL_ + 0x09)
+#define TUBASE (RTL8712_TIMECTRL_ + 0x0A)
+#define SIFS_CCK (RTL8712_TIMECTRL_ + 0x0C)
+#define SIFS_OFDM (RTL8712_TIMECTRL_ + 0x0E)
+#define PIFS (RTL8712_TIMECTRL_ + 0x10)
+#define ACKTO (RTL8712_TIMECTRL_ + 0x11)
+#define EIFS (RTL8712_TIMECTRL_ + 0x12)
+#define BCNITV (RTL8712_TIMECTRL_ + 0x14)
+#define ATIMWND (RTL8712_TIMECTRL_ + 0x16)
+#define DRVERLYINT (RTL8712_TIMECTRL_ + 0x18)
+#define BCNDMATIM (RTL8712_TIMECTRL_ + 0x1A)
+#define BCNERRTH (RTL8712_TIMECTRL_ + 0x1C)
+#define MLT (RTL8712_TIMECTRL_ + 0x1D)
 
 #endif /* __RTL8712_TIMECTRL_REGDEF_H__ */
diff --git a/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h b/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h
index ea164e482347..e6ff88feb402 100644
--- a/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h
+++ b/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h
@@ -15,35 +15,34 @@
 #define __RTL8712_WMAC_BITDEF_H__
 
 /*NAVCTRL*/
-#define	_NAV_UPPER_EN			BIT(18)
-#define	_NAV_MTO_EN				BIT(17)
-#define	_NAV_UPPER				BIT(16)
-#define	_NAV_MTO_MSK			0xFF00
-#define	_NAV_MTO_SHT			8
-#define	_RTSRST_MSK				0x00FF
-#define	_RTSRST_SHT				0
+#define _NAV_UPPER_EN BIT(18)
+#define _NAV_MTO_EN BIT(17)
+#define _NAV_UPPER BIT(16)
+#define _NAV_MTO_MSK 0xFF00
+#define _NAV_MTO_SHT 8
+#define _RTSRST_MSK 0x00FF
+#define _RTSRST_SHT 0
 
 /*BWOPMODE*/
-#define	_20MHZBW				BIT(2)
+#define _20MHZBW BIT(2)
 
 /*BACAMCMD*/
-#define	_BACAM_POLL				BIT(31)
-#define	_BACAM_RST				BIT(17)
-#define	_BACAM_RW				BIT(16)
-#define	_BACAM_ADDR_MSK			0x0000007F
-#define	_BACAM_ADDR_SHT			0
+#define _BACAM_POLL BIT(31)
+#define _BACAM_RST BIT(17)
+#define _BACAM_RW BIT(16)
+#define _BACAM_ADDR_MSK 0x0000007F
+#define _BACAM_ADDR_SHT 0
 
 /*LBDLY*/
-#define	_LBDLY_MSK				0x1F
+#define _LBDLY_MSK 0x1F
 
 /*FWDLY*/
-#define	_FWDLY_MSK				0x0F
+#define _FWDLY_MSK 0x0F
 
 /*RXERR_RPT*/
-#define	_RXERR_RPT_SEL_MSK		0xF0000000
-#define	_RXERR_RPT_SEL_SHT		28
-#define	_RPT_CNT_MSK			0x000FFFFF
-#define	_RPT_CNT_SHT			0
-
-#endif	/*__RTL8712_WMAC_BITDEF_H__*/
+#define _RXERR_RPT_SEL_MSK 0xF0000000
+#define _RXERR_RPT_SEL_SHT 28
+#define _RPT_CNT_MSK 0x000FFFFF
+#define _RPT_CNT_SHT 0
 
+#endif /*__RTL8712_WMAC_BITDEF_H__*/
diff --git a/drivers/staging/rtl8712/rtl8712_wmac_regdef.h b/drivers/staging/rtl8712/rtl8712_wmac_regdef.h
index dfe3e9fbed43..83141b14ad1f 100644
--- a/drivers/staging/rtl8712/rtl8712_wmac_regdef.h
+++ b/drivers/staging/rtl8712/rtl8712_wmac_regdef.h
@@ -14,23 +14,22 @@
 #ifndef __RTL8712_WMAC_REGDEF_H__
 #define __RTL8712_WMAC_REGDEF_H__
 
-#define NAVCTRL				(RTL8712_WMAC_ + 0x00)
-#define BWOPMODE			(RTL8712_WMAC_ + 0x03)
-#define BACAMCMD			(RTL8712_WMAC_ + 0x04)
-#define BACAMCONTENT			(RTL8712_WMAC_ + 0x08)
-#define LBDLY				(RTL8712_WMAC_ + 0x10)
-#define FWDLY				(RTL8712_WMAC_ + 0x11)
-#define HWPC_RX_CTRL			(RTL8712_WMAC_ + 0x18)
-#define MQ				(RTL8712_WMAC_ + 0x20)
-#define MA				(RTL8712_WMAC_ + 0x22)
-#define MS				(RTL8712_WMAC_ + 0x24)
-#define CLM_RESULT			(RTL8712_WMAC_ + 0x27)
-#define NHM_RPI_CNT			(RTL8712_WMAC_ + 0x28)
-#define RXERR_RPT			(RTL8712_WMAC_ + 0x30)
-#define NAV_PROT_LEN			(RTL8712_WMAC_ + 0x34)
-#define CFEND_TH			(RTL8712_WMAC_ + 0x36)
-#define AMPDU_MIN_SPACE			(RTL8712_WMAC_ + 0x37)
-#define	TXOP_STALL_CTRL			(RTL8712_WMAC_ + 0x38)
+#define NAVCTRL (RTL8712_WMAC_ + 0x00)
+#define BWOPMODE (RTL8712_WMAC_ + 0x03)
+#define BACAMCMD (RTL8712_WMAC_ + 0x04)
+#define BACAMCONTENT (RTL8712_WMAC_ + 0x08)
+#define LBDLY (RTL8712_WMAC_ + 0x10)
+#define FWDLY (RTL8712_WMAC_ + 0x11)
+#define HWPC_RX_CTRL (RTL8712_WMAC_ + 0x18)
+#define MQ (RTL8712_WMAC_ + 0x20)
+#define MA (RTL8712_WMAC_ + 0x22)
+#define MS (RTL8712_WMAC_ + 0x24)
+#define CLM_RESULT (RTL8712_WMAC_ + 0x27)
+#define NHM_RPI_CNT (RTL8712_WMAC_ + 0x28)
+#define RXERR_RPT (RTL8712_WMAC_ + 0x30)
+#define NAV_PROT_LEN (RTL8712_WMAC_ + 0x34)
+#define CFEND_TH (RTL8712_WMAC_ + 0x36)
+#define AMPDU_MIN_SPACE (RTL8712_WMAC_ + 0x37)
+#define TXOP_STALL_CTRL (RTL8712_WMAC_ + 0x38)
 
 #endif /*__RTL8712_WMAC_REGDEF_H__*/
-
diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
index 12f2fdb1b3cb..0ac9c756f382 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.c
+++ b/drivers/staging/rtl8712/rtl8712_xmit.c
@@ -74,7 +74,7 @@ int r8712_txframes_sta_ac_pending(struct _adapter *padapter,
 	case 3:
 	default:
 		ptxservq = &psta->sta_xmitpriv.be_q;
-	break;
+		break;
 	}
 	return ptxservq->qcnt;
 }
@@ -124,13 +124,13 @@ static u32 get_ff_hwaddr(struct xmit_frame *pxmitframe)
 		case 3:
 		case 1:
 		case 2:
-			addr = RTL8712_DMA_BEQ;/*RTL8712_EP_LO;*/
+			addr = RTL8712_DMA_BEQ; /*RTL8712_EP_LO;*/
 			break;
 		case 4:
 		case 5:
 		case 6:
 		case 7:
-			addr = RTL8712_DMA_VOQ;/*RTL8712_EP_HI;*/
+			addr = RTL8712_DMA_VOQ; /*RTL8712_EP_HI;*/
 			break;
 		case 0x10:
 		case 0x11:
@@ -139,7 +139,7 @@ static u32 get_ff_hwaddr(struct xmit_frame *pxmitframe)
 			addr = RTL8712_DMA_H2CCMD;
 			break;
 		default:
-			addr = RTL8712_DMA_BEQ;/*RTL8712_EP_LO;*/
+			addr = RTL8712_DMA_BEQ; /*RTL8712_EP_LO;*/
 			break;
 		}
 	}
@@ -147,17 +147,18 @@ static u32 get_ff_hwaddr(struct xmit_frame *pxmitframe)
 }
 
 static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv,
-						struct hw_xmit *phwxmit, struct tx_servq *ptxservq,
-						struct  __queue *pframe_queue)
+						struct hw_xmit *phwxmit,
+						struct tx_servq *ptxservq,
+						struct __queue *pframe_queue)
 {
 	struct list_head *xmitframe_plist, *xmitframe_phead;
-	struct	xmit_frame *pxmitframe = NULL;
+	struct xmit_frame *pxmitframe = NULL;
 
 	xmitframe_phead = &pframe_queue->queue;
 	xmitframe_plist = xmitframe_phead->next;
 	if (!end_of_queue_search(xmitframe_phead, xmitframe_plist)) {
-		pxmitframe = container_of(xmitframe_plist,
-					  struct xmit_frame, list);
+		pxmitframe =
+			container_of(xmitframe_plist, struct xmit_frame, list);
 		list_del_init(&pxmitframe->list);
 		ptxservq->qcnt--;
 		phwxmit->txcmdcnt++;
@@ -166,22 +167,27 @@ static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv,
 }
 
 static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
-					    struct hw_xmit *phwxmit_i, sint entry)
+					    struct hw_xmit *phwxmit_i,
+					    sint entry)
 {
 	unsigned long irqL0;
 	struct list_head *sta_plist, *sta_phead;
 	struct hw_xmit *phwxmit;
 	struct tx_servq *ptxservq = NULL;
-	struct  __queue *pframe_queue = NULL;
-	struct	xmit_frame *pxmitframe = NULL;
+	struct __queue *pframe_queue = NULL;
+	struct xmit_frame *pxmitframe = NULL;
 	int i, inx[4];
 	int j, acirp_cnt[4];
 
 	/*entry indx: 0->vo, 1->vi, 2->be, 3->bk.*/
-	inx[0] = 0; acirp_cnt[0] = pxmitpriv->voq_cnt;
-	inx[1] = 1; acirp_cnt[1] = pxmitpriv->viq_cnt;
-	inx[2] = 2; acirp_cnt[2] = pxmitpriv->beq_cnt;
-	inx[3] = 3; acirp_cnt[3] = pxmitpriv->bkq_cnt;
+	inx[0] = 0;
+	acirp_cnt[0] = pxmitpriv->voq_cnt;
+	inx[1] = 1;
+	acirp_cnt[1] = pxmitpriv->viq_cnt;
+	inx[2] = 2;
+	acirp_cnt[2] = pxmitpriv->beq_cnt;
+	inx[3] = 3;
+	acirp_cnt[3] = pxmitpriv->bkq_cnt;
 	for (i = 0; i < 4; i++) {
 		for (j = i + 1; j < 4; j++) {
 			if (acirp_cnt[j] < acirp_cnt[i]) {
@@ -196,10 +202,11 @@ static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
 		sta_phead = &phwxmit->sta_queue->queue;
 		sta_plist = sta_phead->next;
 		while (!end_of_queue_search(sta_phead, sta_plist)) {
-			ptxservq = container_of(sta_plist, struct tx_servq, tx_pending);
+			ptxservq = container_of(sta_plist, struct tx_servq,
+						tx_pending);
 			pframe_queue = &ptxservq->sta_pending;
-			pxmitframe = dequeue_one_xmitframe(pxmitpriv, phwxmit, ptxservq,
-							   pframe_queue);
+			pxmitframe = dequeue_one_xmitframe(
+				pxmitpriv, phwxmit, ptxservq, pframe_queue);
 			if (pxmitframe) {
 				phwxmit->accnt--;
 				goto exit_dequeue_xframe_ex;
@@ -219,7 +226,8 @@ static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
 	return pxmitframe;
 }
 
-void r8712_do_queue_select(struct _adapter *padapter, struct pkt_attrib *pattrib)
+void r8712_do_queue_select(struct _adapter *padapter,
+			   struct pkt_attrib *pattrib)
 {
 	unsigned int qsel = 0;
 	struct dvobj_priv *pdvobj = &padapter->dvobjpriv;
@@ -250,9 +258,8 @@ void r8712_construct_txaggr_cmd_desc(struct xmit_buf *pxmitbuf)
 	/* Fill up TxCmd Descriptor according as USB FW Tx Aggregation info.*/
 	/* dw0 */
 	ptx_desc->txdw0 = cpu_to_le32(CMD_HDR_SZ & 0xffff);
-	ptx_desc->txdw0 |=
-		cpu_to_le32(((TXDESC_SIZE + OFFSET_SZ) << OFFSET_SHT) &
-			    0x00ff0000);
+	ptx_desc->txdw0 |= cpu_to_le32(
+		((TXDESC_SIZE + OFFSET_SZ) << OFFSET_SHT) & 0x00ff0000);
 	ptx_desc->txdw0 |= cpu_to_le32(OWN | FSG | LSG);
 
 	/* dw1 */
@@ -261,12 +268,12 @@ void r8712_construct_txaggr_cmd_desc(struct xmit_buf *pxmitbuf)
 
 void r8712_construct_txaggr_cmd_hdr(struct xmit_buf *pxmitbuf)
 {
-	struct xmit_frame *pxmitframe = (struct xmit_frame *)
-		pxmitbuf->priv_data;
+	struct xmit_frame *pxmitframe =
+		(struct xmit_frame *)pxmitbuf->priv_data;
 	struct _adapter *padapter = pxmitframe->padapter;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
-	struct cmd_hdr *pcmd_hdr = (struct cmd_hdr  *)
-		(pxmitbuf->pbuf + TXDESC_SIZE);
+	struct cmd_hdr *pcmd_hdr =
+		(struct cmd_hdr *)(pxmitbuf->pbuf + TXDESC_SIZE);
 
 	/* Fill up Cmd Header for USB FW Tx Aggregation.*/
 	/* dw0 */
@@ -288,13 +295,15 @@ void r8712_append_mpdu_unit(struct xmit_buf *pxmitbuf,
 	/* free skb struct */
 	r8712_xmit_complete(padapter, pxmitframe);
 	if (pxmitframe->attrib.ether_type != 0x0806) {
-		if ((pxmitframe->attrib.ether_type != 0x888e) &&
-		    (pxmitframe->attrib.dhcp_pkt != 1)) {
-			r8712_issue_addbareq_cmd(padapter, pxmitframe->attrib.priority);
+		if (pxmitframe->attrib.ether_type != 0x888e &&
+		    pxmitframe->attrib.dhcp_pkt != 1) {
+			r8712_issue_addbareq_cmd(padapter,
+						 pxmitframe->attrib.priority);
 		}
 	}
 	pxmitframe->last[0] = 1;
-	update_txdesc(pxmitframe, (uint *)(pxmitframe->buf_addr), pxmitframe->attrib.last_txcmdsz);
+	update_txdesc(pxmitframe, (uint *)(pxmitframe->buf_addr),
+		      pxmitframe->attrib.last_txcmdsz);
 	/*padding zero */
 	last_txcmdsz = pxmitframe->attrib.last_txcmdsz;
 	padding_sz = (8 - (last_txcmdsz % 8));
@@ -306,10 +315,10 @@ void r8712_append_mpdu_unit(struct xmit_buf *pxmitbuf,
 			  i) = 0;
 	}
 	/* Add the new mpdu's length */
-	ptx_desc->txdw0 = cpu_to_le32((ptx_desc->txdw0 & 0xffff0000) |
+	ptx_desc->txdw0 = cpu_to_le32(
+		(ptx_desc->txdw0 & 0xffff0000) |
 		((ptx_desc->txdw0 & 0x0000ffff) +
-			((TXDESC_SIZE + last_txcmdsz + padding_sz) &
-			 0x0000ffff)));
+		 ((TXDESC_SIZE + last_txcmdsz + padding_sz) & 0x0000ffff)));
 }
 
 void r8712_xmitframe_aggr_1st(struct xmit_buf *pxmitbuf,
@@ -328,21 +337,22 @@ void r8712_xmitframe_aggr_1st(struct xmit_buf *pxmitbuf,
 	pxmitbuf->aggr_nr = 1;
 }
 
-u16 r8712_xmitframe_aggr_next(struct xmit_buf *pxmitbuf, struct xmit_frame *pxmitframe)
+u16 r8712_xmitframe_aggr_next(struct xmit_buf *pxmitbuf,
+			      struct xmit_frame *pxmitframe)
 {
 	pxmitframe->pxmitbuf = pxmitbuf;
 	pxmitbuf->priv_data = pxmitframe;
 	pxmitframe->pxmit_urb[0] = pxmitbuf->pxmit_urb[0];
 	/* buffer addr assoc */
-	pxmitframe->buf_addr = pxmitbuf->pbuf + TXDESC_SIZE +
+	pxmitframe->buf_addr =
+		pxmitbuf->pbuf + TXDESC_SIZE +
 		(((struct tx_desc *)pxmitbuf->pbuf)->txdw0 & 0x0000ffff);
 	r8712_append_mpdu_unit(pxmitbuf, pxmitframe);
-	r8712_free_xmitframe_ex(&pxmitframe->padapter->xmitpriv,
-				pxmitframe);
+	r8712_free_xmitframe_ex(&pxmitframe->padapter->xmitpriv, pxmitframe);
 	pxmitbuf->aggr_nr++;
 
 	return TXDESC_SIZE +
-		(((struct tx_desc *)pxmitbuf->pbuf)->txdw0 & 0x0000ffff);
+	       (((struct tx_desc *)pxmitbuf->pbuf)->txdw0 & 0x0000ffff);
 }
 
 void r8712_dump_aggr_xframe(struct xmit_buf *pxmitbuf,
@@ -351,15 +361,15 @@ void r8712_dump_aggr_xframe(struct xmit_buf *pxmitbuf,
 	struct _adapter *padapter = pxmitframe->padapter;
 	struct dvobj_priv *pdvobj = &padapter->dvobjpriv;
 	struct tx_desc *ptxdesc = pxmitbuf->pbuf;
-	struct cmd_hdr *pcmd_hdr = (struct cmd_hdr *)
-		(pxmitbuf->pbuf + TXDESC_SIZE);
+	struct cmd_hdr *pcmd_hdr =
+		(struct cmd_hdr *)(pxmitbuf->pbuf + TXDESC_SIZE);
 	u16 total_length = (u16)(ptxdesc->txdw0 & 0xffff);
 
 	/* use 1st xmitframe as media */
 	xmitframe_xmitbuf_attach(pxmitframe, pxmitbuf);
-	pcmd_hdr->cmd_dw0 = cpu_to_le32(((total_length - CMD_HDR_SZ) &
-					 0x0000ffff) | (pcmd_hdr->cmd_dw0 &
-							0xffff0000));
+	pcmd_hdr->cmd_dw0 =
+		cpu_to_le32(((total_length - CMD_HDR_SZ) & 0x0000ffff) |
+			    (pcmd_hdr->cmd_dw0 & 0xffff0000));
 
 	/* urb length in cmd_dw1 */
 	pcmd_hdr->cmd_dw1 = cpu_to_le32((pxmitbuf->aggr_nr & 0xff) |
@@ -368,21 +378,21 @@ void r8712_dump_aggr_xframe(struct xmit_buf *pxmitbuf,
 	pxmitframe->bpending[0] = false;
 	pxmitframe->mem_addr = pxmitbuf->pbuf;
 
-	if ((pdvobj->ishighspeed && ((total_length + TXDESC_SIZE) % 0x200) == 0) ||
-	    ((!pdvobj->ishighspeed && ((total_length + TXDESC_SIZE) %
-	    0x40) == 0))) {
-		ptxdesc->txdw0 |= cpu_to_le32
-			(((TXDESC_SIZE + OFFSET_SZ + 8) << OFFSET_SHT) &
-			 0x00ff0000);
+	if ((pdvobj->ishighspeed &&
+	     ((total_length + TXDESC_SIZE) % 0x200) == 0) ||
+	    ((!pdvobj->ishighspeed &&
+	      ((total_length + TXDESC_SIZE) % 0x40) == 0))) {
+		ptxdesc->txdw0 |= cpu_to_le32(
+			((TXDESC_SIZE + OFFSET_SZ + 8) << OFFSET_SHT) &
+			0x00ff0000);
 		/*32 bytes for TX Desc + 8 bytes pending*/
 	} else {
-		ptxdesc->txdw0 |= cpu_to_le32
-			(((TXDESC_SIZE + OFFSET_SZ) << OFFSET_SHT) &
-			 0x00ff0000);
+		ptxdesc->txdw0 |= cpu_to_le32(
+			((TXDESC_SIZE + OFFSET_SZ) << OFFSET_SHT) & 0x00ff0000);
 		/*default = 32 bytes for TX Desc*/
 	}
-	r8712_write_port(pxmitframe->padapter, RTL8712_DMA_H2CCMD, total_length + TXDESC_SIZE,
-			 (u8 *)pxmitframe);
+	r8712_write_port(pxmitframe->padapter, RTL8712_DMA_H2CCMD,
+			 total_length + TXDESC_SIZE, (u8 *)pxmitframe);
 }
 
 #endif
@@ -422,12 +432,13 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 	}
 	if (blnSetTxDescOffset) {
 		/* 32 bytes for TX Desc + 8 bytes pending */
-		ptxdesc->txdw0 |= cpu_to_le32(((TXDESC_SIZE + OFFSET_SZ + 8) <<
-			      OFFSET_SHT) & 0x00ff0000);
+		ptxdesc->txdw0 |= cpu_to_le32(
+			((TXDESC_SIZE + OFFSET_SZ + 8) << OFFSET_SHT) &
+			0x00ff0000);
 	} else {
 		/* default = 32 bytes for TX Desc */
-		ptxdesc->txdw0 |= cpu_to_le32(((TXDESC_SIZE + OFFSET_SZ) <<
-				  OFFSET_SHT) & 0x00ff0000);
+		ptxdesc->txdw0 |= cpu_to_le32(
+			((TXDESC_SIZE + OFFSET_SZ) << OFFSET_SHT) & 0x00ff0000);
 	}
 	ptxdesc->txdw0 |= cpu_to_le32(OWN | FSG | LSG);
 	if (pxmitframe->frame_tag == DATA_FRAMETAG) {
@@ -437,29 +448,28 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 #ifdef CONFIG_R8712_TX_AGGR
 		/* dirty workaround, need to check if it is aggr cmd. */
 		if ((u8 *)pmem != (u8 *)pxmitframe->pxmitbuf->pbuf) {
-			ptxdesc->txdw0 |= cpu_to_le32
-				((0x3 << TYPE_SHT) & TYPE_MSK);
+			ptxdesc->txdw0 |=
+				cpu_to_le32((0x3 << TYPE_SHT) & TYPE_MSK);
 			qsel = (uint)(pattrib->qsel & 0x0000001f);
 			if (qsel == 2)
 				qsel = 0;
-			ptxdesc->txdw1 |= cpu_to_le32
-				((qsel << QSEL_SHT) & 0x00001f00);
-			ptxdesc->txdw2 = cpu_to_le32
-				((qsel << RTS_RC_SHT) & 0x001f0000);
-			ptxdesc->txdw6 |= cpu_to_le32
-				((0x5 << RSVD6_SHT) & RSVD6_MSK);
+			ptxdesc->txdw1 |=
+				cpu_to_le32((qsel << QSEL_SHT) & 0x00001f00);
+			ptxdesc->txdw2 =
+				cpu_to_le32((qsel << RTS_RC_SHT) & 0x001f0000);
+			ptxdesc->txdw6 |=
+				cpu_to_le32((0x5 << RSVD6_SHT) & RSVD6_MSK);
 		} else {
-			ptxdesc->txdw0 |= cpu_to_le32
-				((0x3 << TYPE_SHT) & TYPE_MSK);
-			ptxdesc->txdw1 |= cpu_to_le32
-				((0x13 << QSEL_SHT) & 0x00001f00);
+			ptxdesc->txdw0 |=
+				cpu_to_le32((0x3 << TYPE_SHT) & TYPE_MSK);
+			ptxdesc->txdw1 |=
+				cpu_to_le32((0x13 << QSEL_SHT) & 0x00001f00);
 			qsel = (uint)(pattrib->qsel & 0x0000001f);
 			if (qsel == 2)
 				qsel = 0;
-			ptxdesc->txdw2 = cpu_to_le32
-				((qsel << RTS_RC_SHT) & 0x0001f000);
-			ptxdesc->txdw7 |= cpu_to_le32
-				(pcmdpriv->cmd_seq << 24);
+			ptxdesc->txdw2 =
+				cpu_to_le32((qsel << RTS_RC_SHT) & 0x0001f000);
+			ptxdesc->txdw7 |= cpu_to_le32(pcmdpriv->cmd_seq << 24);
 			pcmdpriv->cmd_seq++;
 		}
 		pattrib->qsel = 0x13;
@@ -468,26 +478,26 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 		ptxdesc->txdw1 |= cpu_to_le32((qsel << QSEL_SHT) & 0x00001f00);
 #endif
 		if (!pqospriv->qos_option)
-			ptxdesc->txdw1 |= cpu_to_le32(BIT(16));/*Non-QoS*/
-		if ((pattrib->encrypt > 0) && !pattrib->bswenc) {
-			switch (pattrib->encrypt) {	/*SEC_TYPE*/
+			ptxdesc->txdw1 |= cpu_to_le32(BIT(16)); /*Non-QoS*/
+		if (pattrib->encrypt > 0 && !pattrib->bswenc) {
+			switch (pattrib->encrypt) { /*SEC_TYPE*/
 			case _WEP40_:
 			case _WEP104_:
-				ptxdesc->txdw1 |= cpu_to_le32((0x01 << 22) &
-						  0x00c00000);
-				/*KEY_ID when WEP is used;*/
 				ptxdesc->txdw1 |=
-					cpu_to_le32((psecuritypriv->PrivacyKeyIndex << 17) &
-						    0x00060000);
+					cpu_to_le32((0x01 << 22) & 0x00c00000);
+				/*KEY_ID when WEP is used;*/
+				ptxdesc->txdw1 |= cpu_to_le32(
+					(psecuritypriv->PrivacyKeyIndex << 17) &
+					0x00060000);
 				break;
 			case _TKIP_:
 			case _TKIP_WTMIC_:
-				ptxdesc->txdw1 |= cpu_to_le32((0x02 << 22) &
-						  0x00c00000);
+				ptxdesc->txdw1 |=
+					cpu_to_le32((0x02 << 22) & 0x00c00000);
 				break;
 			case _AES_:
-				ptxdesc->txdw1 |= cpu_to_le32((0x03 << 22) &
-						  0x00c00000);
+				ptxdesc->txdw1 |=
+					cpu_to_le32((0x03 << 22) & 0x00c00000);
 				break;
 			case _NO_PRIVACY_:
 			default:
@@ -508,10 +518,9 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 		 * the AC Queue list correctly.
 		 */
 		ptxdesc->txdw3 = cpu_to_le32((pattrib->priority << SEQ_SHT) &
-				 0x0fff0000);
-		if ((pattrib->ether_type != 0x888e) &&
-		    (pattrib->ether_type != 0x0806) &&
-		    (pattrib->dhcp_pkt != 1)) {
+					     0x0fff0000);
+		if (pattrib->ether_type != 0x888e &&
+		    pattrib->ether_type != 0x0806 && pattrib->dhcp_pkt != 1) {
 			/*Not EAP & ARP type data packet*/
 			if (phtpriv->ht_option == 1) { /*B/G/N Mode*/
 				if (!phtpriv->ampdu_enable)
@@ -524,7 +533,7 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 			 */
 			/*driver uses data rate*/
 			ptxdesc->txdw4 = cpu_to_le32(0x80000000);
-			ptxdesc->txdw5 = cpu_to_le32(0x001f8000);/*1M*/
+			ptxdesc->txdw5 = cpu_to_le32(0x001f8000); /*1M*/
 		}
 		if (pattrib->pctrl == 1) { /* mp tx packets */
 			struct tx_desc *ptxdesc_mp;
@@ -539,7 +548,7 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 			ptxdesc->txdw4 = ptxdesc_mp->txdw4;
 			/* offset 20 */
 			ptxdesc->txdw5 = ptxdesc_mp->txdw5;
-			pattrib->pctrl = 0;/* reset to zero; */
+			pattrib->pctrl = 0; /* reset to zero; */
 		}
 	} else if (pxmitframe->frame_tag == MGNT_FRAMETAG) {
 		/* offset 4 */
@@ -547,7 +556,7 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 		ptxdesc->txdw1 |= cpu_to_le32((0x05) & 0x1f);
 		qsel = (uint)(pattrib->qsel & 0x0000001f);
 		ptxdesc->txdw1 |= cpu_to_le32((qsel << QSEL_SHT) & 0x00001f00);
-		ptxdesc->txdw1 |= cpu_to_le32(BIT(16));/* Non-QoS */
+		ptxdesc->txdw1 |= cpu_to_le32(BIT(16)); /* Non-QoS */
 		/* offset 8 */
 		if (bmcst)
 			ptxdesc->txdw2 |= cpu_to_le32(BMC);
@@ -561,11 +570,11 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 		 * the AC Queue list correctly.
 		 */
 		ptxdesc->txdw3 = cpu_to_le32((pattrib->priority << SEQ_SHT) &
-					      0x0fff0000);
+					     0x0fff0000);
 		/* offset 16 */
-		ptxdesc->txdw4 = cpu_to_le32(0x80002040);/*gtest*/
+		ptxdesc->txdw4 = cpu_to_le32(0x80002040); /*gtest*/
 		/* offset 20 */
-		ptxdesc->txdw5 = cpu_to_le32(0x001f8000);/* gtest 1M */
+		ptxdesc->txdw5 = cpu_to_le32(0x001f8000); /* gtest 1M */
 	} else if (pxmitframe->frame_tag == TXAGG_FRAMETAG) {
 		/* offset 4 */
 		qsel = 0x13;
@@ -576,12 +585,12 @@ static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int sz)
 		ptxdesc->txdw1 |= cpu_to_le32((qsel << QSEL_SHT) & 0x00001f00);
 		/*offset 8*/
 		/*offset 12*/
-		ptxdesc->txdw3 = cpu_to_le32((pattrib->seqnum << SEQ_SHT) &
-					      0x0fff0000);
+		ptxdesc->txdw3 =
+			cpu_to_le32((pattrib->seqnum << SEQ_SHT) & 0x0fff0000);
 		/*offset 16*/
-		ptxdesc->txdw4 = cpu_to_le32(0x80002040);/*gtest*/
+		ptxdesc->txdw4 = cpu_to_le32(0x80002040); /*gtest*/
 		/*offset 20*/
-		ptxdesc->txdw5 = cpu_to_le32(0x001f9600);/*gtest*/
+		ptxdesc->txdw5 = cpu_to_le32(0x001f9600); /*gtest*/
 	}
 }
 
@@ -617,7 +626,8 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 		 * 2. aggr if 2nd xframe is dequeued, else dump directly
 		 */
 		if (AGGR_NR_HIGH_BOUND > 1)
-			p2ndxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
+			p2ndxmitframe =
+				dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
 		if (pxmitframe->frame_tag != DATA_FRAMETAG) {
 			r8712_free_xmitbuf(pxmitpriv, pxmitbuf);
 			return false;
@@ -631,16 +641,18 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 		if (p2ndxmitframe) {
 			u16 total_length;
 
-			total_length = r8712_xmitframe_aggr_next(pxmitbuf, p2ndxmitframe);
+			total_length = r8712_xmitframe_aggr_next(pxmitbuf,
+								 p2ndxmitframe);
 			do {
-				p2ndxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
+				p2ndxmitframe = dequeue_xframe_ex(
+					pxmitpriv, phwxmits, hwentry);
 				if (p2ndxmitframe)
-					total_length =
-						r8712_xmitframe_aggr_next(pxmitbuf, p2ndxmitframe);
+					total_length = r8712_xmitframe_aggr_next(
+						pxmitbuf, p2ndxmitframe);
 				else
 					break;
 			} while (total_length <= 0x1800 &&
-				pxmitbuf->aggr_nr <= AGGR_NR_HIGH_BOUND);
+				 pxmitbuf->aggr_nr <= AGGR_NR_HIGH_BOUND);
 		}
 		if (pxmitbuf->aggr_nr > 0)
 			r8712_dump_aggr_xframe(pxmitbuf, pxmitframe);
@@ -650,8 +662,8 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
 		xmitframe_xmitbuf_attach(pxmitframe, pxmitbuf);
 		if (pxmitframe->frame_tag == DATA_FRAMETAG) {
 			if (pxmitframe->attrib.priority <= 15)
-				res = r8712_xmitframe_coalesce(padapter, pxmitframe->pkt,
-							       pxmitframe);
+				res = r8712_xmitframe_coalesce(
+					padapter, pxmitframe->pkt, pxmitframe);
 			/* always return ndis_packet after
 			 * r8712_xmitframe_coalesce
 			 */
@@ -688,8 +700,8 @@ static void dump_xframe(struct _adapter *padapter,
 	for (t = 0; t < pattrib->nr_frags; t++) {
 		if (t != (pattrib->nr_frags - 1)) {
 			sz = pxmitpriv->frag_len;
-			sz = sz - 4 - (psecuritypriv->sw_encrypt ? 0 :
-			     pattrib->icv_len);
+			sz = sz - 4 -
+			     (psecuritypriv->sw_encrypt ? 0 : pattrib->icv_len);
 			pxmitframe->last[t] = 0;
 		} else {
 			sz = pattrib->last_txcmdsz;
diff --git a/drivers/staging/rtl8712/rtl8712_xmit.h b/drivers/staging/rtl8712/rtl8712_xmit.h
index 5cd651a0de75..6db76e21e847 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.h
+++ b/drivers/staging/rtl8712/rtl8712_xmit.h
@@ -14,18 +14,18 @@
 #ifndef _RTL8712_XMIT_H_
 #define _RTL8712_XMIT_H_
 
-#define HWXMIT_ENTRY	4
+#define HWXMIT_ENTRY 4
 
-#define VO_QUEUE_INX	0
-#define VI_QUEUE_INX	1
-#define BE_QUEUE_INX	2
-#define BK_QUEUE_INX	3
-#define TS_QUEUE_INX	4
-#define MGT_QUEUE_INX	5
-#define BMC_QUEUE_INX	6
-#define BCN_QUEUE_INX	7
+#define VO_QUEUE_INX 0
+#define VI_QUEUE_INX 1
+#define BE_QUEUE_INX 2
+#define BK_QUEUE_INX 3
+#define TS_QUEUE_INX 4
+#define MGT_QUEUE_INX 5
+#define BMC_QUEUE_INX 6
+#define BCN_QUEUE_INX 7
 
-#define HW_QUEUE_ENTRY	8
+#define HW_QUEUE_ENTRY 8
 
 #define TXDESC_SIZE 32
 #define TXDESC_OFFSET TXDESC_SIZE
@@ -47,9 +47,9 @@
 /*OFFSET 0*/
 #define OFFSET_SZ (0)
 #define OFFSET_SHT (16)
-#define OWN	BIT(31)
-#define FSG	BIT(27)
-#define LSG	BIT(26)
+#define OWN BIT(31)
+#define FSG BIT(27)
+#define LSG BIT(26)
 #define TYPE_SHT (24)
 #define TYPE_MSK (0x03000000)
 
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8712/rtl871x_cmd.c
index ffeb91dd28c4..dc1dba0b8afb 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.c
+++ b/drivers/staging/rtl8712/rtl871x_cmd.c
@@ -48,24 +48,24 @@ int r8712_init_cmd_priv(struct cmd_priv *pcmdpriv)
 	init_completion(&pcmdpriv->cmd_queue_comp);
 	init_completion(&pcmdpriv->terminate_cmdthread_comp);
 
-	_init_queue(&(pcmdpriv->cmd_queue));
+	_init_queue(&pcmdpriv->cmd_queue);
 
 	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
 	pcmdpriv->cmd_seq = 1;
-	pcmdpriv->cmd_allocated_buf = kmalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ,
-					      GFP_ATOMIC);
+	pcmdpriv->cmd_allocated_buf =
+		kmalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ, GFP_ATOMIC);
 	if (!pcmdpriv->cmd_allocated_buf)
 		return -ENOMEM;
-	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf  +  CMDBUFF_ALIGN_SZ -
+	pcmdpriv->cmd_buf = pcmdpriv->cmd_allocated_buf + CMDBUFF_ALIGN_SZ -
 			    ((addr_t)(pcmdpriv->cmd_allocated_buf) &
-			    (CMDBUFF_ALIGN_SZ - 1));
+			     (CMDBUFF_ALIGN_SZ - 1));
 	pcmdpriv->rsp_allocated_buf = kmalloc(MAX_RSPSZ + 4, GFP_ATOMIC);
 	if (!pcmdpriv->rsp_allocated_buf) {
 		kfree(pcmdpriv->cmd_allocated_buf);
 		pcmdpriv->cmd_allocated_buf = NULL;
 		return -ENOMEM;
 	}
-	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 -
+	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf + 4 -
 			    ((addr_t)(pcmdpriv->rsp_allocated_buf) & 3);
 	pcmdpriv->cmd_issued_cnt = 0;
 	pcmdpriv->cmd_done_cnt = 0;
@@ -81,7 +81,7 @@ int r8712_init_evt_priv(struct evt_priv *pevtpriv)
 
 	if (!pevtpriv->evt_allocated_buf)
 		return -ENOMEM;
-	pevtpriv->evt_buf = pevtpriv->evt_allocated_buf  +  4 -
+	pevtpriv->evt_buf = pevtpriv->evt_allocated_buf + 4 -
 			    ((addr_t)(pevtpriv->evt_allocated_buf) & 3);
 	pevtpriv->evt_done_cnt = 0;
 	return 0;
@@ -126,14 +126,13 @@ void r8712_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *obj)
 	complete(&pcmdpriv->cmd_queue_comp);
 }
 
-struct cmd_obj *r8712_dequeue_cmd(struct  __queue *queue)
+struct cmd_obj *r8712_dequeue_cmd(struct __queue *queue)
 {
 	unsigned long irqL;
 	struct cmd_obj *obj;
 
 	spin_lock_irqsave(&queue->lock, irqL);
-	obj = list_first_entry_or_null(&queue->queue,
-				       struct cmd_obj, list);
+	obj = list_first_entry_or_null(&queue->queue, struct cmd_obj, list);
 	if (obj)
 		list_del_init(&obj->list);
 	spin_unlock_irqrestore(&queue->lock, irqL);
@@ -143,7 +142,7 @@ struct cmd_obj *r8712_dequeue_cmd(struct  __queue *queue)
 void r8712_enqueue_cmd_ex(struct cmd_priv *pcmdpriv, struct cmd_obj *obj)
 {
 	unsigned long irqL;
-	struct  __queue *queue;
+	struct __queue *queue;
 
 	if (!obj)
 		return;
@@ -158,8 +157,7 @@ void r8712_enqueue_cmd_ex(struct cmd_priv *pcmdpriv, struct cmd_obj *obj)
 
 void r8712_free_cmd_obj(struct cmd_obj *pcmd)
 {
-	if ((pcmd->cmdcode != _JoinBss_CMD_) &&
-	    (pcmd->cmdcode != _CreateBss_CMD_))
+	if (pcmd->cmdcode != _JoinBss_CMD_ && pcmd->cmdcode != _CreateBss_CMD_)
 		kfree(pcmd->parmbuf);
 	if (pcmd->rsp) {
 		if (pcmd->rspsz != 0)
@@ -172,8 +170,8 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
 			struct ndis_802_11_ssid *pssid)
 	__must_hold(&padapter->mlmepriv.lock)
 {
-	struct cmd_obj	*ph2c;
-	struct sitesurvey_parm	*psurveyPara;
+	struct cmd_obj *ph2c;
+	struct sitesurvey_parm *psurveyPara;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
@@ -208,9 +206,9 @@ u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
 
 int r8712_setdatarate_cmd(struct _adapter *padapter, u8 *rateset)
 {
-	struct cmd_obj		*ph2c;
-	struct setdatarate_parm	*pbsetdataratepara;
-	struct cmd_priv		*pcmdpriv = &padapter->cmdpriv;
+	struct cmd_obj *ph2c;
+	struct setdatarate_parm *pbsetdataratepara;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	ph2c = kmalloc(sizeof(*ph2c), GFP_ATOMIC);
 	if (!ph2c)
@@ -242,16 +240,17 @@ void r8712_set_chplan_cmd(struct _adapter *padapter, int chplan)
 		kfree(ph2c);
 		return;
 	}
-	init_h2fwcmd_w_parm_no_rsp(ph2c, psetchplanpara, GEN_CMD_CODE(_SetChannelPlan));
+	init_h2fwcmd_w_parm_no_rsp(ph2c, psetchplanpara,
+				   GEN_CMD_CODE(_SetChannelPlan));
 	psetchplanpara->ChannelPlan = chplan;
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
 }
 
-int r8712_setrfreg_cmd(struct _adapter  *padapter, u8 offset, u32 val)
+int r8712_setrfreg_cmd(struct _adapter *padapter, u8 offset, u32 val)
 {
 	struct cmd_obj *ph2c;
 	struct writeRF_parm *pwriterfparm;
-	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	ph2c = kmalloc(sizeof(*ph2c), GFP_ATOMIC);
 	if (!ph2c)
@@ -285,7 +284,7 @@ int r8712_getrfreg_cmd(struct _adapter *padapter, u8 offset, u8 *pval)
 	INIT_LIST_HEAD(&ph2c->list);
 	ph2c->cmdcode = GEN_CMD_CODE(_GetRFReg);
 	ph2c->parmbuf = (unsigned char *)prdrfparm;
-	ph2c->cmdsz =  sizeof(struct readRF_parm);
+	ph2c->cmdsz = sizeof(struct readRF_parm);
 	ph2c->rsp = pval;
 	ph2c->rspsz = sizeof(struct readRF_rsp);
 	prdrfparm->offset = offset;
@@ -301,7 +300,8 @@ void r8712_getbbrfreg_cmdrsp_callback(struct _adapter *padapter,
 	padapter->mppriv.workparam.bcompleted = true;
 }
 
-void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj *pcmd)
+void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter,
+				    struct cmd_obj *pcmd)
 {
 	kfree(pcmd->parmbuf);
 	kfree(pcmd);
@@ -314,7 +314,7 @@ int r8712_createbss_cmd(struct _adapter *padapter)
 	struct cmd_obj *pcmd;
 	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	struct wlan_bssid_ex *pdev_network =
-				 &padapter->registrypriv.dev_network;
+		&padapter->registrypriv.dev_network;
 
 	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_START_TO_LINK);
 	pcmd = kmalloc(sizeof(*pcmd), GFP_ATOMIC);
@@ -329,20 +329,20 @@ int r8712_createbss_cmd(struct _adapter *padapter)
 	/* notes: translate IELength & Length after assign to cmdsz; */
 	pdev_network->Length = pcmd->cmdsz;
 	pdev_network->IELength = pdev_network->IELength;
-	pdev_network->Ssid.SsidLength =	pdev_network->Ssid.SsidLength;
+	pdev_network->Ssid.SsidLength = pdev_network->Ssid.SsidLength;
 	r8712_enqueue_cmd(pcmdpriv, pcmd);
 	return 0;
 }
 
-int r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
+int r8712_joinbss_cmd(struct _adapter *padapter, struct wlan_network *pnetwork)
 {
 	struct wlan_bssid_ex *psecnetwork;
-	struct cmd_obj		*pcmd;
-	struct cmd_priv		*pcmdpriv = &padapter->cmdpriv;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct qos_priv		*pqospriv = &pmlmepriv->qospriv;
-	struct security_priv	*psecuritypriv = &padapter->securitypriv;
-	struct registry_priv	*pregistrypriv = &padapter->registrypriv;
+	struct cmd_obj *pcmd;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct qos_priv *pqospriv = &pmlmepriv->qospriv;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 	enum NDIS_802_11_NETWORK_INFRASTRUCTURE ndis_network_mode =
 		pnetwork->network.InfrastructureMode;
 
@@ -369,13 +369,14 @@ int r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
 	}
 	psecnetwork = &psecuritypriv->sec_bss;
 	memcpy(psecnetwork, &pnetwork->network, sizeof(*psecnetwork));
-	psecuritypriv->authenticator_ie[0] = (unsigned char)
-					     psecnetwork->IELength;
+	psecuritypriv->authenticator_ie[0] =
+		(unsigned char)psecnetwork->IELength;
 	if ((psecnetwork->IELength - 12) < (256 - 1))
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12],
-		       psecnetwork->IELength - 12);
+		memcpy(&psecuritypriv->authenticator_ie[1],
+		       &psecnetwork->IEs[12], psecnetwork->IELength - 12);
 	else
-		memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], (256 - 1));
+		memcpy(&psecuritypriv->authenticator_ie[1],
+		       &psecnetwork->IEs[12], (256 - 1));
 	psecnetwork->IELength = 0;
 	/*
 	 * If the driver wants to use the bssid to create the connection.
@@ -385,14 +386,17 @@ int r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
 	if (!pmlmepriv->assoc_by_bssid)
 		ether_addr_copy(&pmlmepriv->assoc_bssid[0],
 				&pnetwork->network.MacAddress[0]);
-	psecnetwork->IELength = r8712_restruct_sec_ie(padapter, &pnetwork->network.IEs[0],
-						      &psecnetwork->IEs[0], pnetwork->network.IELength);
+	psecnetwork->IELength = r8712_restruct_sec_ie(
+		padapter, &pnetwork->network.IEs[0], &psecnetwork->IEs[0],
+		pnetwork->network.IELength);
 	pqospriv->qos_option = 0;
 	if (pregistrypriv->wmm_enable) {
 		u32 tmp_len;
 
-		tmp_len = r8712_restruct_wmm_ie(padapter, &pnetwork->network.IEs[0],
-						&psecnetwork->IEs[0], pnetwork->network.IELength,
+		tmp_len = r8712_restruct_wmm_ie(padapter,
+						&pnetwork->network.IEs[0],
+						&psecnetwork->IEs[0],
+						pnetwork->network.IELength,
 						psecnetwork->IELength);
 		if (psecnetwork->IELength != tmp_len) {
 			psecnetwork->IELength = tmp_len;
@@ -407,8 +411,8 @@ int r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
 		 * to avoid some IOT issues, especially for Realtek 8192u
 		 * SoftAP.
 		 */
-		if ((padapter->securitypriv.PrivacyAlgrthm != _WEP40_) &&
-		    (padapter->securitypriv.PrivacyAlgrthm != _WEP104_)) {
+		if (padapter->securitypriv.PrivacyAlgrthm != _WEP40_ &&
+		    padapter->securitypriv.PrivacyAlgrthm != _WEP104_) {
 			/* restructure_ht_ie */
 			r8712_restructure_ht_ie(padapter,
 						&pnetwork->network.IEs[0],
@@ -429,19 +433,30 @@ int r8712_joinbss_cmd(struct _adapter  *padapter, struct wlan_network *pnetwork)
 #ifdef __BIG_ENDIAN
 	/* wlan_network endian conversion */
 	psecnetwork->Length = cpu_to_le32(psecnetwork->Length);
-	psecnetwork->Ssid.SsidLength = cpu_to_le32(psecnetwork->Ssid.SsidLength);
+	psecnetwork->Ssid.SsidLength =
+		cpu_to_le32(psecnetwork->Ssid.SsidLength);
 	psecnetwork->Privacy = cpu_to_le32(psecnetwork->Privacy);
 	psecnetwork->Rssi = cpu_to_le32(psecnetwork->Rssi);
-	psecnetwork->NetworkTypeInUse = cpu_to_le32(psecnetwork->NetworkTypeInUse);
-	psecnetwork->Configuration.ATIMWindow = cpu_to_le32(psecnetwork->Configuration.ATIMWindow);
-	psecnetwork->Configuration.BeaconPeriod = cpu_to_le32(psecnetwork->Configuration.BeaconPeriod);
-	psecnetwork->Configuration.DSConfig = cpu_to_le32(psecnetwork->Configuration.DSConfig);
-	psecnetwork->Configuration.FHConfig.DwellTime = cpu_to_le32(psecnetwork->Configuration.FHConfig.DwellTime);
-	psecnetwork->Configuration.FHConfig.HopPattern = cpu_to_le32(psecnetwork->Configuration.FHConfig.HopPattern);
-	psecnetwork->Configuration.FHConfig.HopSet = cpu_to_le32(psecnetwork->Configuration.FHConfig.HopSet);
-	psecnetwork->Configuration.FHConfig.Length = cpu_to_le32(psecnetwork->Configuration.FHConfig.Length);
-	psecnetwork->Configuration.Length = cpu_to_le32(psecnetwork->Configuration.Length);
-	psecnetwork->InfrastructureMode = cpu_to_le32(psecnetwork->InfrastructureMode);
+	psecnetwork->NetworkTypeInUse =
+		cpu_to_le32(psecnetwork->NetworkTypeInUse);
+	psecnetwork->Configuration.ATIMWindow =
+		cpu_to_le32(psecnetwork->Configuration.ATIMWindow);
+	psecnetwork->Configuration.BeaconPeriod =
+		cpu_to_le32(psecnetwork->Configuration.BeaconPeriod);
+	psecnetwork->Configuration.DSConfig =
+		cpu_to_le32(psecnetwork->Configuration.DSConfig);
+	psecnetwork->Configuration.FHConfig.DwellTime =
+		cpu_to_le32(psecnetwork->Configuration.FHConfig.DwellTime);
+	psecnetwork->Configuration.FHConfig.HopPattern =
+		cpu_to_le32(psecnetwork->Configuration.FHConfig.HopPattern);
+	psecnetwork->Configuration.FHConfig.HopSet =
+		cpu_to_le32(psecnetwork->Configuration.FHConfig.HopSet);
+	psecnetwork->Configuration.FHConfig.Length =
+		cpu_to_le32(psecnetwork->Configuration.FHConfig.Length);
+	psecnetwork->Configuration.Length =
+		cpu_to_le32(psecnetwork->Configuration.Length);
+	psecnetwork->InfrastructureMode =
+		cpu_to_le32(psecnetwork->InfrastructureMode);
 	psecnetwork->IELength = cpu_to_le32(psecnetwork->IELength);
 #endif
 	INIT_LIST_HEAD(&pcmd->list);
@@ -467,7 +482,8 @@ void r8712_disassoc_cmd(struct _adapter *padapter) /* for sta_mode */
 		kfree(pdisconnect_cmd);
 		return;
 	}
-	init_h2fwcmd_w_parm_no_rsp(pdisconnect_cmd, pdisconnect, _DisConnect_CMD_);
+	init_h2fwcmd_w_parm_no_rsp(pdisconnect_cmd, pdisconnect,
+				   _DisConnect_CMD_);
 	r8712_enqueue_cmd(pcmdpriv, pdisconnect_cmd);
 }
 
@@ -521,24 +537,26 @@ void r8712_setstakey_cmd(struct _adapter *padapter, u8 *psta, u8 unicast_key)
 	ph2c->rspsz = sizeof(struct set_stakey_rsp);
 	ether_addr_copy(psetstakey_para->addr, sta->hwaddr);
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
-		psetstakey_para->algorithm = (unsigned char)
-					    psecuritypriv->PrivacyAlgrthm;
+		psetstakey_para->algorithm =
+			(unsigned char)psecuritypriv->PrivacyAlgrthm;
 	else
-		GET_ENCRY_ALGO(psecuritypriv, sta, psetstakey_para->algorithm, false);
+		GET_ENCRY_ALGO(psecuritypriv, sta, psetstakey_para->algorithm,
+			       false);
 	if (unicast_key)
 		memcpy(&psetstakey_para->key, &sta->x_UncstKey, 16);
 	else
 		memcpy(&psetstakey_para->key,
-		       &psecuritypriv->XGrpKey[psecuritypriv->XGrpKeyid - 1].skey,
+		       &psecuritypriv->XGrpKey[psecuritypriv->XGrpKeyid - 1]
+				.skey,
 		       16);
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
 }
 
 void r8712_setMacAddr_cmd(struct _adapter *padapter, const u8 *mac_addr)
 {
-	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	struct cmd_obj *ph2c;
-	struct SetMacAddr_param	*psetMacAddr_para;
+	struct SetMacAddr_param *psetMacAddr_para;
 
 	ph2c = kmalloc(sizeof(*ph2c), GFP_ATOMIC);
 	if (!ph2c)
@@ -555,9 +573,9 @@ void r8712_setMacAddr_cmd(struct _adapter *padapter, const u8 *mac_addr)
 
 void r8712_addbareq_cmd(struct _adapter *padapter, u8 tid)
 {
-	struct cmd_priv		*pcmdpriv = &padapter->cmdpriv;
-	struct cmd_obj		*ph2c;
-	struct addBaReq_parm	*paddbareq_parm;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+	struct cmd_obj *ph2c;
+	struct addBaReq_parm *paddbareq_parm;
 
 	ph2c = kmalloc(sizeof(*ph2c), GFP_ATOMIC);
 	if (!ph2c)
@@ -568,15 +586,16 @@ void r8712_addbareq_cmd(struct _adapter *padapter, u8 tid)
 		return;
 	}
 	paddbareq_parm->tid = tid;
-	init_h2fwcmd_w_parm_no_rsp(ph2c, paddbareq_parm, GEN_CMD_CODE(_AddBAReq));
+	init_h2fwcmd_w_parm_no_rsp(ph2c, paddbareq_parm,
+				   GEN_CMD_CODE(_AddBAReq));
 	r8712_enqueue_cmd_ex(pcmdpriv, ph2c);
 }
 
 void r8712_wdg_wk_cmd(struct _adapter *padapter)
 {
 	struct cmd_obj *ph2c;
-	struct drvint_cmd_parm  *pdrvintcmd_param;
-	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
+	struct drvint_cmd_parm *pdrvintcmd_param;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
 	ph2c = kmalloc(sizeof(*ph2c), GFP_ATOMIC);
 	if (!ph2c)
@@ -595,7 +614,7 @@ void r8712_wdg_wk_cmd(struct _adapter *padapter)
 
 void r8712_survey_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcmd)
 {
-	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	if (pcmd->res != H2C_SUCCESS)
 		clr_fwstate(pmlmepriv, _FW_UNDER_SURVEY);
@@ -622,21 +641,24 @@ void r8712_joinbss_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcmd)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	if (pcmd->res != H2C_SUCCESS)
-		mod_timer(&pmlmepriv->assoc_timer, jiffies + msecs_to_jiffies(1));
+		mod_timer(&pmlmepriv->assoc_timer,
+			  jiffies + msecs_to_jiffies(1));
 	r8712_free_cmd_obj(pcmd);
 }
 
-void r8712_createbss_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcmd)
+void r8712_createbss_cmd_callback(struct _adapter *padapter,
+				  struct cmd_obj *pcmd)
 {
 	unsigned long irqL;
 	struct sta_info *psta = NULL;
 	struct wlan_network *pwlan = NULL;
-	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)pcmd->parmbuf;
-	struct wlan_network *tgt_network = &(pmlmepriv->cur_network);
+	struct wlan_network *tgt_network = &pmlmepriv->cur_network;
 
 	if (pcmd->res != H2C_SUCCESS)
-		mod_timer(&pmlmepriv->assoc_timer, jiffies + msecs_to_jiffies(1));
+		mod_timer(&pmlmepriv->assoc_timer,
+			  jiffies + msecs_to_jiffies(1));
 	del_timer(&pmlmepriv->assoc_timer);
 #ifdef __BIG_ENDIAN
 	/* endian_convert */
@@ -645,21 +667,31 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcm
 	pnetwork->Privacy = le32_to_cpu(pnetwork->Privacy);
 	pnetwork->Rssi = le32_to_cpu(pnetwork->Rssi);
 	pnetwork->NetworkTypeInUse = le32_to_cpu(pnetwork->NetworkTypeInUse);
-	pnetwork->Configuration.ATIMWindow = le32_to_cpu(pnetwork->Configuration.ATIMWindow);
-	pnetwork->Configuration.DSConfig = le32_to_cpu(pnetwork->Configuration.DSConfig);
-	pnetwork->Configuration.FHConfig.DwellTime = le32_to_cpu(pnetwork->Configuration.FHConfig.DwellTime);
-	pnetwork->Configuration.FHConfig.HopPattern = le32_to_cpu(pnetwork->Configuration.FHConfig.HopPattern);
-	pnetwork->Configuration.FHConfig.HopSet = le32_to_cpu(pnetwork->Configuration.FHConfig.HopSet);
-	pnetwork->Configuration.FHConfig.Length = le32_to_cpu(pnetwork->Configuration.FHConfig.Length);
-	pnetwork->Configuration.Length = le32_to_cpu(pnetwork->Configuration.Length);
-	pnetwork->InfrastructureMode = le32_to_cpu(pnetwork->InfrastructureMode);
+	pnetwork->Configuration.ATIMWindow =
+		le32_to_cpu(pnetwork->Configuration.ATIMWindow);
+	pnetwork->Configuration.DSConfig =
+		le32_to_cpu(pnetwork->Configuration.DSConfig);
+	pnetwork->Configuration.FHConfig.DwellTime =
+		le32_to_cpu(pnetwork->Configuration.FHConfig.DwellTime);
+	pnetwork->Configuration.FHConfig.HopPattern =
+		le32_to_cpu(pnetwork->Configuration.FHConfig.HopPattern);
+	pnetwork->Configuration.FHConfig.HopSet =
+		le32_to_cpu(pnetwork->Configuration.FHConfig.HopSet);
+	pnetwork->Configuration.FHConfig.Length =
+		le32_to_cpu(pnetwork->Configuration.FHConfig.Length);
+	pnetwork->Configuration.Length =
+		le32_to_cpu(pnetwork->Configuration.Length);
+	pnetwork->InfrastructureMode =
+		le32_to_cpu(pnetwork->InfrastructureMode);
 	pnetwork->IELength = le32_to_cpu(pnetwork->IELength);
 #endif
 	spin_lock_irqsave(&pmlmepriv->lock, irqL);
-	if ((pmlmepriv->fw_state) & WIFI_AP_STATE) {
-		psta = r8712_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
+	if (pmlmepriv->fw_state & WIFI_AP_STATE) {
+		psta = r8712_get_stainfo(&padapter->stapriv,
+					 pnetwork->MacAddress);
 		if (!psta) {
-			psta = r8712_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
+			psta = r8712_alloc_stainfo(&padapter->stapriv,
+						   pnetwork->MacAddress);
 			if (!psta)
 				goto createbss_cmd_fail;
 		}
@@ -667,17 +699,20 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcm
 	} else {
 		pwlan = _r8712_alloc_network(pmlmepriv);
 		if (!pwlan) {
-			pwlan = r8712_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
+			pwlan = r8712_get_oldest_wlan_network(
+				&pmlmepriv->scanned_queue);
 			if (!pwlan)
 				goto createbss_cmd_fail;
 			pwlan->last_scanned = jiffies;
 		} else {
-			list_add_tail(&(pwlan->list), &pmlmepriv->scanned_queue.queue);
+			list_add_tail(&pwlan->list,
+				      &pmlmepriv->scanned_queue.queue);
 		}
 		pnetwork->Length = r8712_get_wlan_bssid_ex_sz(pnetwork);
-		memcpy(&(pwlan->network), pnetwork, pnetwork->Length);
+		memcpy(&pwlan->network, pnetwork, pnetwork->Length);
 		pwlan->fixed = true;
-		memcpy(&tgt_network->network, pnetwork, (r8712_get_wlan_bssid_ex_sz(pnetwork)));
+		memcpy(&tgt_network->network, pnetwork,
+		       (r8712_get_wlan_bssid_ex_sz(pnetwork)));
 		if (pmlmepriv->fw_state & _FW_UNDER_LINKING)
 			pmlmepriv->fw_state ^= _FW_UNDER_LINKING;
 		/*
@@ -690,11 +725,14 @@ void r8712_createbss_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcm
 	r8712_free_cmd_obj(pcmd);
 }
 
-void r8712_setstaKey_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj *pcmd)
+void r8712_setstaKey_cmdrsp_callback(struct _adapter *padapter,
+				     struct cmd_obj *pcmd)
 {
 	struct sta_priv *pstapriv = &padapter->stapriv;
-	struct set_stakey_rsp *psetstakey_rsp = (struct set_stakey_rsp *) (pcmd->rsp);
-	struct sta_info *psta = r8712_get_stainfo(pstapriv, psetstakey_rsp->addr);
+	struct set_stakey_rsp *psetstakey_rsp =
+		(struct set_stakey_rsp *)(pcmd->rsp);
+	struct sta_info *psta =
+		r8712_get_stainfo(pstapriv, psetstakey_rsp->addr);
 
 	if (!psta)
 		goto exit;
@@ -706,26 +744,31 @@ void r8712_setstaKey_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj *
 void r8712_setassocsta_cmdrsp_callback(struct _adapter *padapter,
 				       struct cmd_obj *pcmd)
 {
-	unsigned long	irqL;
+	unsigned long irqL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct set_assocsta_parm *passocsta_parm = (struct set_assocsta_parm *)(pcmd->parmbuf);
-	struct set_assocsta_rsp *passocsta_rsp = (struct set_assocsta_rsp *) (pcmd->rsp);
-	struct sta_info *psta = r8712_get_stainfo(pstapriv, passocsta_parm->addr);
+	struct set_assocsta_parm *passocsta_parm =
+		(struct set_assocsta_parm *)(pcmd->parmbuf);
+	struct set_assocsta_rsp *passocsta_rsp =
+		(struct set_assocsta_rsp *)(pcmd->rsp);
+	struct sta_info *psta =
+		r8712_get_stainfo(pstapriv, passocsta_parm->addr);
 
 	if (!psta)
 		return;
 	psta->aid = psta->mac_id = passocsta_rsp->cam_id;
 	spin_lock_irqsave(&pmlmepriv->lock, irqL);
-	if ((check_fwstate(pmlmepriv, WIFI_MP_STATE)) && (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)))
+	if ((check_fwstate(pmlmepriv, WIFI_MP_STATE)) &&
+	    (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)))
 		pmlmepriv->fw_state ^= _FW_UNDER_LINKING;
 	set_fwstate(pmlmepriv, _FW_LINKED);
 	spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
 	r8712_free_cmd_obj(pcmd);
 }
 
-void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl, u32 tryPktCnt,
-				u32 tryPktInterval, u32 firstStageTO)
+void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl,
+				u32 tryPktCnt, u32 tryPktInterval,
+				u32 firstStageTO)
 {
 	struct cmd_obj *ph2c;
 	struct DisconnectCtrlEx_param *param;
@@ -745,6 +788,7 @@ void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl, u32
 	param->TryPktInterval = (unsigned char)tryPktInterval;
 	param->FirstStageTO = (unsigned int)firstStageTO;
 
-	init_h2fwcmd_w_parm_no_rsp(ph2c, param, GEN_CMD_CODE(_DisconnectCtrlEx));
+	init_h2fwcmd_w_parm_no_rsp(ph2c, param,
+				   GEN_CMD_CODE(_DisconnectCtrlEx));
 	r8712_enqueue_cmd(pcmdpriv, ph2c);
 }
diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
index 268844af57f0..5966c0f06a4d 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.h
+++ b/drivers/staging/rtl8712/rtl871x_cmd.h
@@ -16,35 +16,35 @@
 
 #include "wlan_bssdef.h"
 #include "rtl871x_rf.h"
-#define C2H_MEM_SZ (16*1024)
+#define C2H_MEM_SZ (16 * 1024)
 
 #include "osdep_service.h"
 #include "ieee80211.h"
 
-#define FREE_CMDOBJ_SZ	128
-#define MAX_CMDSZ	512
-#define MAX_RSPSZ	512
-#define MAX_EVTSZ	1024
+#define FREE_CMDOBJ_SZ 128
+#define MAX_CMDSZ 512
+#define MAX_RSPSZ 512
+#define MAX_EVTSZ 1024
 #define CMDBUFF_ALIGN_SZ 512
 
 struct cmd_obj {
-	u16	cmdcode;
-	u8	res;
-	u8	*parmbuf;
-	u32	cmdsz;
-	u8	*rsp;
-	u32	rspsz;
+	u16 cmdcode;
+	u8 res;
+	u8 *parmbuf;
+	u32 cmdsz;
+	u8 *rsp;
+	u32 rspsz;
 	struct list_head list;
 };
 
 struct cmd_priv {
 	struct completion cmd_queue_comp;
 	struct completion terminate_cmdthread_comp;
-	struct  __queue	cmd_queue;
+	struct __queue cmd_queue;
 	u8 cmd_seq;
-	u8 *cmd_buf;	/*shall be non-paged, and 4 bytes aligned*/
+	u8 *cmd_buf; /*shall be non-paged, and 4 bytes aligned*/
 	u8 *cmd_allocated_buf;
-	u8 *rsp_buf;	/*shall be non-paged, and 4 bytes aligned*/
+	u8 *rsp_buf; /*shall be non-paged, and 4 bytes aligned*/
 	u8 *rsp_allocated_buf;
 	u32 cmd_issued_cnt;
 	u32 cmd_done_cnt;
@@ -60,27 +60,27 @@ struct evt_obj {
 	struct list_head list;
 };
 
-struct	evt_priv {
-	struct  __queue	evt_queue;
-	u8	event_seq;
-	u8	*evt_buf;	/*shall be non-paged, and 4 bytes aligned*/
-	u8	*evt_allocated_buf;
-	u32	evt_done_cnt;
+struct evt_priv {
+	struct __queue evt_queue;
+	u8 event_seq;
+	u8 *evt_buf; /*shall be non-paged, and 4 bytes aligned*/
+	u8 *evt_allocated_buf;
+	u32 evt_done_cnt;
 };
 
 #define init_h2fwcmd_w_parm_no_rsp(pcmd, pparm, code) \
-do {\
-	INIT_LIST_HEAD(&pcmd->list);\
-	pcmd->cmdcode = code;\
-	pcmd->parmbuf = (u8 *)(pparm);\
-	pcmd->cmdsz = sizeof(*pparm);\
-	pcmd->rsp = NULL;\
-	pcmd->rspsz = 0;\
-} while (0)
+	do {                                          \
+		INIT_LIST_HEAD(&pcmd->list);          \
+		pcmd->cmdcode = code;                 \
+		pcmd->parmbuf = (u8 *)(pparm);        \
+		pcmd->cmdsz = sizeof(*pparm);         \
+		pcmd->rsp = NULL;                     \
+		pcmd->rspsz = 0;                      \
+	} while (0)
 
 void r8712_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *obj);
 void r8712_enqueue_cmd_ex(struct cmd_priv *pcmdpriv, struct cmd_obj *obj);
-struct cmd_obj *r8712_dequeue_cmd(struct  __queue *queue);
+struct cmd_obj *r8712_dequeue_cmd(struct __queue *queue);
 void r8712_free_cmd_obj(struct cmd_obj *pcmd);
 int r8712_cmd_thread(void *context);
 int r8712_init_cmd_priv(struct cmd_priv *pcmdpriv);
@@ -88,11 +88,7 @@ void r8712_free_cmd_priv(struct cmd_priv *pcmdpriv);
 int r8712_init_evt_priv(struct evt_priv *pevtpriv);
 void r8712_free_evt_priv(struct evt_priv *pevtpriv);
 
-enum rtl871x_drvint_cid {
-	NONE_WK_CID,
-	WDG_WK_CID,
-	MAX_WK_CID
-};
+enum rtl871x_drvint_cid { NONE_WK_CID, WDG_WK_CID, MAX_WK_CID };
 
 enum RFINTFS {
 	SWSI,
@@ -132,9 +128,9 @@ struct disconnect_parm {
  * #define IW_MODE_SECOND	5	// Secondary master/repeater (backup)
  * #define IW_MODE_MONITOR	6	// Passive monitor (listen only)
  */
-struct	setopmode_parm {
-	u8	mode;
-	u8	rsvd[3];
+struct setopmode_parm {
+	u8 mode;
+	u8 rsvd[3];
 };
 
 /*
@@ -143,10 +139,10 @@ struct	setopmode_parm {
  * Command-Event Mode
  */
 struct sitesurvey_parm {
-	__le32	passive_mode;	/*active: 1, passive: 0 */
-	__le32	bsslimit;	/* 1 ~ 48 */
-	__le32	ss_ssidlen;
-	u8	ss_ssid[IW_ESSID_MAX_SIZE + 1];
+	__le32 passive_mode; /*active: 1, passive: 0 */
+	__le32 bsslimit; /* 1 ~ 48 */
+	__le32 ss_ssidlen;
+	u8 ss_ssid[IW_ESSID_MAX_SIZE + 1];
 };
 
 /*
@@ -155,8 +151,8 @@ struct sitesurvey_parm {
  * Command Mode
  */
 struct setauth_parm {
-	u8 mode;  /*0: legacy open, 1: legacy shared 2: 802.1x*/
-	u8 _1x;   /*0: PSK, 1: TLS*/
+	u8 mode; /*0: legacy open, 1: legacy shared 2: 802.1x*/
+	u8 _1x; /*0: PSK, 1: TLS*/
 	u8 rsvd[2];
 };
 
@@ -171,14 +167,14 @@ struct setauth_parm {
  * when 802.1x ==> keyid > 2 ==> unicast key
  */
 struct setkey_parm {
-	u8	algorithm;	/* encryption algorithm, could be none, wep40,
+	u8 algorithm; /* encryption algorithm, could be none, wep40,
 				 * TKIP, CCMP, wep104
 				 */
-	u8	keyid;
-	u8	grpkey;		/* 1: this is the grpkey for 802.1x.
+	u8 keyid;
+	u8 grpkey; /* 1: this is the grpkey for 802.1x.
 				 * 0: this is the unicast key for 802.1x
 				 */
-	u8	key[16];	/* this could be 40 or 104 */
+	u8 key[16]; /* this could be 40 or 104 */
 };
 
 /*
@@ -188,19 +184,19 @@ struct setkey_parm {
  * when shared key ==> algorithm/keyid
  */
 struct set_stakey_parm {
-	u8	addr[ETH_ALEN];
-	u8	algorithm;
-	u8	key[16];
+	u8 addr[ETH_ALEN];
+	u8 algorithm;
+	u8 key[16];
 };
 
 struct set_stakey_rsp {
-	u8	addr[ETH_ALEN];
-	u8	keyid;
-	u8	rsvd;
+	u8 addr[ETH_ALEN];
+	u8 keyid;
+	u8 rsvd;
 };
 
 struct SetMacAddr_param {
-	u8	MacAddr[ETH_ALEN];
+	u8 MacAddr[ETH_ALEN];
 };
 
 /*
@@ -214,12 +210,12 @@ struct SetMacAddr_param {
  *
  */
 struct set_assocsta_parm {
-	u8	addr[ETH_ALEN];
+	u8 addr[ETH_ALEN];
 };
 
 struct set_assocsta_rsp {
-	u8	cam_id;
-	u8	rsvd[3];
+	u8 cam_id;
+	u8 rsvd[3];
 };
 
 /*
@@ -233,7 +229,7 @@ struct set_assocsta_rsp {
  *
  */
 struct del_assocsta_parm {
-	u8	addr[ETH_ALEN];
+	u8 addr[ETH_ALEN];
 };
 
 /*
@@ -245,9 +241,9 @@ struct del_assocsta_parm {
  *
  */
 struct setstapwrstate_parm {
-	u8	staid;
-	u8	status;
-	u8	hwaddr[6];
+	u8 staid;
+	u8 status;
+	u8 hwaddr[6];
 };
 
 /*
@@ -258,8 +254,8 @@ struct setstapwrstate_parm {
  *	Command Mode
  *
  */
-struct	setbasicrate_parm {
-	u8	basicrates[NumRates];
+struct setbasicrate_parm {
+	u8 basicrates[NumRates];
 };
 
 /*
@@ -287,8 +283,8 @@ struct getbasicrate_rsp {
  *
  */
 struct setdatarate_parm {
-	u8	mac_id;
-	u8	datarates[NumRates];
+	u8 mac_id;
+	u8 datarates[NumRates];
 };
 
 enum _RT_CHANNEL_DOMAIN {
@@ -311,7 +307,7 @@ enum _RT_CHANNEL_DOMAIN {
 	RT_CHANNEL_DOMAIN_NCC = 13,
 	RT_CHANNEL_DOMAIN_5G = 14,
 	RT_CHANNEL_DOMAIN_5G_40M = 15,
- /*===== Add new channel plan above this line===============*/
+	/*===== Add new channel plan above this line===============*/
 	RT_CHANNEL_DOMAIN_MAX,
 };
 
@@ -329,7 +325,6 @@ struct SetChannelPlan_param {
  */
 struct getdatarate_parm {
 	u32 rsvd;
-
 };
 
 struct getdatarate_rsp {
@@ -367,55 +362,55 @@ struct getdatarate_rsp {
  *	Command-Rsp Mode
  *
  */
-struct	getphy_rsp {
-	u8	rfchannel;
-	u8	modem;
+struct getphy_rsp {
+	u8 rfchannel;
+	u8 modem;
 };
 
 struct readBB_parm {
-	u8	offset;
+	u8 offset;
 };
 
 struct readBB_rsp {
-	u8	value;
+	u8 value;
 };
 
 struct readTSSI_parm {
-	u8	offset;
+	u8 offset;
 };
 
 struct readTSSI_rsp {
-	u8	value;
+	u8 value;
 };
 
 struct writeBB_parm {
-	u8	offset;
-	u8	value;
+	u8 offset;
+	u8 value;
 };
 
 struct writePTM_parm {
-	u8	type;
+	u8 type;
 };
 
 struct readRF_parm {
-	u8	offset;
+	u8 offset;
 };
 
 struct readRF_rsp {
-	u32	value;
+	u32 value;
 };
 
 struct writeRF_parm {
-	u32	offset;
-	u32	value;
+	u32 offset;
+	u32 value;
 };
 
 struct setrfintfs_parm {
-	u8	rfintfs;
+	u8 rfintfs;
 };
 
 struct getrfintfs_parm {
-	u8	rfintfs;
+	u8 rfintfs;
 };
 
 /*
@@ -481,19 +476,19 @@ struct drvint_cmd_parm {
 
 /*------------------- Below are used for RF/BB tuning ---------------------*/
 
-struct	setantenna_parm {
-	u8	tx_antset;
-	u8	rx_antset;
-	u8	tx_antenna;
-	u8	rx_antenna;
+struct setantenna_parm {
+	u8 tx_antset;
+	u8 rx_antset;
+	u8 tx_antenna;
+	u8 rx_antenna;
 };
 
-struct	enrateadaptive_parm {
-	u32	en;
+struct enrateadaptive_parm {
+	u32 en;
 };
 
 struct settxagctbl_parm {
-	u32	txagc[MAX_RATES_LENGTH];
+	u32 txagc[MAX_RATES_LENGTH];
 };
 
 struct gettxagctbl_parm {
@@ -501,82 +496,82 @@ struct gettxagctbl_parm {
 };
 
 struct gettxagctbl_rsp {
-	u32	txagc[MAX_RATES_LENGTH];
+	u32 txagc[MAX_RATES_LENGTH];
 };
 
 struct setagcctrl_parm {
-	u32	agcctrl;	/* 0: pure hw, 1: fw */
+	u32 agcctrl; /* 0: pure hw, 1: fw */
 };
 
-struct setssup_parm	{
-	u32	ss_ForceUp[MAX_RATES_LENGTH];
+struct setssup_parm {
+	u32 ss_ForceUp[MAX_RATES_LENGTH];
 };
 
-struct getssup_parm	{
+struct getssup_parm {
 	u32 rsvd;
 };
 
-struct getssup_rsp	{
-	u8	ss_ForceUp[MAX_RATES_LENGTH];
+struct getssup_rsp {
+	u8 ss_ForceUp[MAX_RATES_LENGTH];
 };
 
-struct setssdlevel_parm	{
-	u8	ss_DLevel[MAX_RATES_LENGTH];
+struct setssdlevel_parm {
+	u8 ss_DLevel[MAX_RATES_LENGTH];
 };
 
-struct getssdlevel_parm	{
+struct getssdlevel_parm {
 	u32 rsvd;
 };
 
-struct getssdlevel_rsp	{
-	u8	ss_DLevel[MAX_RATES_LENGTH];
+struct getssdlevel_rsp {
+	u8 ss_DLevel[MAX_RATES_LENGTH];
 };
 
-struct setssulevel_parm	{
-	u8	ss_ULevel[MAX_RATES_LENGTH];
+struct setssulevel_parm {
+	u8 ss_ULevel[MAX_RATES_LENGTH];
 };
 
-struct getssulevel_parm	{
+struct getssulevel_parm {
 	u32 rsvd;
 };
 
-struct getssulevel_rsp	{
-	u8	ss_ULevel[MAX_RATES_LENGTH];
+struct getssulevel_rsp {
+	u8 ss_ULevel[MAX_RATES_LENGTH];
 };
 
-struct	setcountjudge_parm {
-	u8	count_judge[MAX_RATES_LENGTH];
+struct setcountjudge_parm {
+	u8 count_judge[MAX_RATES_LENGTH];
 };
 
-struct	getcountjudge_parm {
+struct getcountjudge_parm {
 	u32 rsvd;
 };
 
-struct	getcountjudge_rsp {
-	u8	count_judge[MAX_RATES_LENGTH];
+struct getcountjudge_rsp {
+	u8 count_judge[MAX_RATES_LENGTH];
 };
 
-struct setpwrmode_parm  {
-	u8	mode;
-	u8	flag_low_traffic_en;
-	u8	flag_lpnav_en;
-	u8	flag_rf_low_snr_en;
-	u8	flag_dps_en; /* 1: dps, 0: 32k */
-	u8	bcn_rx_en;
-	u8	bcn_pass_cnt;	  /* fw report one beacon information to
+struct setpwrmode_parm {
+	u8 mode;
+	u8 flag_low_traffic_en;
+	u8 flag_lpnav_en;
+	u8 flag_rf_low_snr_en;
+	u8 flag_dps_en; /* 1: dps, 0: 32k */
+	u8 bcn_rx_en;
+	u8 bcn_pass_cnt; /* fw report one beacon information to
 				   * driver  when it receives bcn_pass_cnt
 				   * beacons.
 				   */
-	u8	bcn_to;		  /* beacon TO (ms). ¡§=0¡¨ no limit.*/
-	u16	bcn_itv;
-	u8	app_itv; /* only for VOIP mode. */
-	u8	awake_bcn_itv;
-	u8	smart_ps;
-	u8	bcn_pass_time;	/* unit: 100ms */
+	u8 bcn_to; /* beacon TO (ms). ¡§=0¡¨ no limit.*/
+	u16 bcn_itv;
+	u8 app_itv; /* only for VOIP mode. */
+	u8 awake_bcn_itv;
+	u8 smart_ps;
+	u8 bcn_pass_time; /* unit: 100ms */
 };
 
 struct setatim_parm {
-	u8 op;   /*0: add, 1:del*/
+	u8 op; /*0: add, 1:del*/
 	u8 txid; /* id of dest station.*/
 };
 
@@ -643,12 +638,12 @@ struct getcurtxpwrlevel_rsp {
 
 /*dynamic on/off DIG*/
 struct setdig_parm {
-	unsigned char dig_on;	/* 1:on , 0:off */
+	unsigned char dig_on; /* 1:on , 0:off */
 };
 
 /*dynamic on/off RA*/
 struct setra_parm {
-	unsigned char ra_on;	/* 1:on , 0:off */
+	unsigned char ra_on; /* 1:on , 0:off */
 };
 
 struct setprobereqextraie_parm {
@@ -691,10 +686,10 @@ struct DisconnectCtrlEx_param {
 	unsigned char TryPktCnt;
 	unsigned char TryPktInterval; /* Unit: ms */
 	unsigned char rsvd;
-	unsigned int  FirstStageTO; /* Unit: ms */
+	unsigned int FirstStageTO; /* Unit: ms */
 };
 
-#define GEN_CMD_CODE(cmd)	cmd ## _CMD_
+#define GEN_CMD_CODE(cmd) cmd##_CMD_
 
 /*
  * Result:
@@ -705,46 +700,55 @@ struct DisconnectCtrlEx_param {
  * 0x04: reserved.
  */
 
-#define H2C_RSP_OFFSET			512
-#define H2C_SUCCESS			0x00
-#define H2C_SUCCESS_RSP			0x01
-#define H2C_DUPLICATED			0x02
-#define H2C_DROPPED			0x03
-#define H2C_PARAMETERS_ERROR		0x04
-#define H2C_REJECTED			0x05
-#define H2C_CMD_OVERFLOW		0x06
-#define H2C_RESERVED			0x07
+#define H2C_RSP_OFFSET 512
+#define H2C_SUCCESS 0x00
+#define H2C_SUCCESS_RSP 0x01
+#define H2C_DUPLICATED 0x02
+#define H2C_DROPPED 0x03
+#define H2C_PARAMETERS_ERROR 0x04
+#define H2C_REJECTED 0x05
+#define H2C_CMD_OVERFLOW 0x06
+#define H2C_RESERVED 0x07
 
 void r8712_setMacAddr_cmd(struct _adapter *padapter, const u8 *mac_addr);
-u8 r8712_sitesurvey_cmd(struct _adapter *padapter, struct ndis_802_11_ssid *pssid);
+u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
+			struct ndis_802_11_ssid *pssid);
 int r8712_createbss_cmd(struct _adapter *padapter);
 void r8712_setstakey_cmd(struct _adapter *padapter, u8 *psta, u8 unicast_key);
 int r8712_joinbss_cmd(struct _adapter *padapter, struct wlan_network *pnetwork);
 void r8712_disassoc_cmd(struct _adapter *padapter);
-void r8712_setopmode_cmd(struct _adapter *padapter, enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype);
+void r8712_setopmode_cmd(struct _adapter *padapter,
+			 enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype);
 int r8712_setdatarate_cmd(struct _adapter *padapter, u8 *rateset);
-void r8712_set_chplan_cmd(struct _adapter  *padapter, int chplan);
+void r8712_set_chplan_cmd(struct _adapter *padapter, int chplan);
 int r8712_getrfreg_cmd(struct _adapter *padapter, u8 offset, u8 *pval);
-int r8712_setrfreg_cmd(struct _adapter  *padapter, u8 offset, u32 val);
+int r8712_setrfreg_cmd(struct _adapter *padapter, u8 offset, u32 val);
 void r8712_addbareq_cmd(struct _adapter *padapter, u8 tid);
 void r8712_wdg_wk_cmd(struct _adapter *padapter);
-void r8712_survey_cmd_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
-void r8712_disassoc_cmd_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
-void r8712_joinbss_cmd_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
-void r8712_createbss_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcmd);
-void r8712_getbbrfreg_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj *pcmd);
-void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter, struct cmd_obj *pcmd);
-void r8712_setstaKey_cmdrsp_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
-void r8712_setassocsta_cmdrsp_callback(struct _adapter  *padapter, struct cmd_obj *pcmd);
-void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl, u32 tryPktCnt,
-				u32 tryPktInterval, u32 firstStageTO);
+void r8712_survey_cmd_callback(struct _adapter *padapter, struct cmd_obj *pcmd);
+void r8712_disassoc_cmd_callback(struct _adapter *padapter,
+				 struct cmd_obj *pcmd);
+void r8712_joinbss_cmd_callback(struct _adapter *padapter,
+				struct cmd_obj *pcmd);
+void r8712_createbss_cmd_callback(struct _adapter *padapter,
+				  struct cmd_obj *pcmd);
+void r8712_getbbrfreg_cmdrsp_callback(struct _adapter *padapter,
+				      struct cmd_obj *pcmd);
+void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter,
+				    struct cmd_obj *pcmd);
+void r8712_setstaKey_cmdrsp_callback(struct _adapter *padapter,
+				     struct cmd_obj *pcmd);
+void r8712_setassocsta_cmdrsp_callback(struct _adapter *padapter,
+				       struct cmd_obj *pcmd);
+void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvCtrl,
+				u32 tryPktCnt, u32 tryPktInterval,
+				u32 firstStageTO);
 
 struct _cmd_callback {
-	u32	cmd_code;
-	void (*callback)(struct _adapter  *padapter, struct cmd_obj *cmd);
+	u32 cmd_code;
+	void (*callback)(struct _adapter *padapter, struct cmd_obj *cmd);
 };
 
 #include "rtl8712_cmd.h"
 
 #endif /* _CMD_H_ */
-
diff --git a/drivers/staging/rtl8712/rtl871x_debug.h b/drivers/staging/rtl8712/rtl871x_debug.h
index 69c631af2a2a..cd3bfeb1b4e3 100644
--- a/drivers/staging/rtl8712/rtl871x_debug.h
+++ b/drivers/staging/rtl8712/rtl871x_debug.h
@@ -17,114 +17,114 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#define _drv_emerg_			1
-#define _drv_alert_			2
-#define _drv_crit_			3
-#define _drv_err_			4
-#define	_drv_warning_			5
-#define _drv_notice_			6
-#define _drv_info_			7
-#define _drv_dump_			8
-#define	_drv_debug_			9
+#define _drv_emerg_ 1
+#define _drv_alert_ 2
+#define _drv_crit_ 3
+#define _drv_err_ 4
+#define _drv_warning_ 5
+#define _drv_notice_ 6
+#define _drv_info_ 7
+#define _drv_dump_ 8
+#define _drv_debug_ 9
 
-#define _module_rtl871x_xmit_c_		BIT(0)
-#define _module_xmit_osdep_c_		BIT(1)
-#define _module_rtl871x_recv_c_		BIT(2)
-#define _module_recv_osdep_c_		BIT(3)
-#define _module_rtl871x_mlme_c_		BIT(4)
-#define	_module_mlme_osdep_c_		BIT(5)
-#define _module_rtl871x_sta_mgt_c_	BIT(6)
-#define _module_rtl871x_cmd_c_		BIT(7)
-#define	_module_cmd_osdep_c_		BIT(8)
-#define _module_rtl871x_io_c_		BIT(9)
-#define	_module_io_osdep_c_		BIT(10)
-#define _module_os_intfs_c_		BIT(11)
-#define _module_rtl871x_security_c_	BIT(12)
-#define _module_rtl871x_eeprom_c_	BIT(13)
-#define _module_hal_init_c_		BIT(14)
-#define _module_hci_hal_init_c_		BIT(15)
-#define _module_rtl871x_ioctl_c_	BIT(16)
-#define _module_rtl871x_ioctl_set_c_	BIT(17)
-#define _module_rtl871x_pwrctrl_c_	BIT(19)
-#define _module_hci_intfs_c_		BIT(20)
-#define _module_hci_ops_c_		BIT(21)
-#define _module_osdep_service_c_	BIT(22)
-#define _module_rtl871x_mp_ioctl_c_	BIT(23)
-#define _module_hci_ops_os_c_		BIT(24)
-#define _module_rtl871x_ioctl_os_c	BIT(25)
-#define _module_rtl8712_cmd_c_		BIT(26)
-#define _module_rtl871x_mp_c_		BIT(27)
-#define _module_rtl8712_xmit_c_		BIT(28)
-#define _module_rtl8712_efuse_c_	BIT(29)
-#define _module_rtl8712_recv_c_		BIT(30)
-#define _module_rtl8712_led_c_		BIT(31)
+#define _module_rtl871x_xmit_c_ BIT(0)
+#define _module_xmit_osdep_c_ BIT(1)
+#define _module_rtl871x_recv_c_ BIT(2)
+#define _module_recv_osdep_c_ BIT(3)
+#define _module_rtl871x_mlme_c_ BIT(4)
+#define _module_mlme_osdep_c_ BIT(5)
+#define _module_rtl871x_sta_mgt_c_ BIT(6)
+#define _module_rtl871x_cmd_c_ BIT(7)
+#define _module_cmd_osdep_c_ BIT(8)
+#define _module_rtl871x_io_c_ BIT(9)
+#define _module_io_osdep_c_ BIT(10)
+#define _module_os_intfs_c_ BIT(11)
+#define _module_rtl871x_security_c_ BIT(12)
+#define _module_rtl871x_eeprom_c_ BIT(13)
+#define _module_hal_init_c_ BIT(14)
+#define _module_hci_hal_init_c_ BIT(15)
+#define _module_rtl871x_ioctl_c_ BIT(16)
+#define _module_rtl871x_ioctl_set_c_ BIT(17)
+#define _module_rtl871x_pwrctrl_c_ BIT(19)
+#define _module_hci_intfs_c_ BIT(20)
+#define _module_hci_ops_c_ BIT(21)
+#define _module_osdep_service_c_ BIT(22)
+#define _module_rtl871x_mp_ioctl_c_ BIT(23)
+#define _module_hci_ops_os_c_ BIT(24)
+#define _module_rtl871x_ioctl_os_c BIT(25)
+#define _module_rtl8712_cmd_c_ BIT(26)
+#define _module_rtl871x_mp_c_ BIT(27)
+#define _module_rtl8712_xmit_c_ BIT(28)
+#define _module_rtl8712_efuse_c_ BIT(29)
+#define _module_rtl8712_recv_c_ BIT(30)
+#define _module_rtl8712_led_c_ BIT(31)
 
 #undef _MODULE_DEFINE_
 
 #if defined _RTL871X_XMIT_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_xmit_c_
+#define _MODULE_DEFINE_ _module_rtl871x_xmit_c_
 #elif defined _XMIT_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_xmit_osdep_c_
+#define _MODULE_DEFINE_ _module_xmit_osdep_c_
 #elif defined _RTL871X_RECV_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_recv_c_
+#define _MODULE_DEFINE_ _module_rtl871x_recv_c_
 #elif defined _RECV_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_recv_osdep_c_
+#define _MODULE_DEFINE_ _module_recv_osdep_c_
 #elif defined _RTL871X_MLME_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_mlme_c_
+#define _MODULE_DEFINE_ _module_rtl871x_mlme_c_
 #elif defined _MLME_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_mlme_osdep_c_
+#define _MODULE_DEFINE_ _module_mlme_osdep_c_
 #elif defined _RTL871X_STA_MGT_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_sta_mgt_c_
+#define _MODULE_DEFINE_ _module_rtl871x_sta_mgt_c_
 #elif defined _RTL871X_CMD_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_cmd_c_
+#define _MODULE_DEFINE_ _module_rtl871x_cmd_c_
 #elif defined _CMD_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_cmd_osdep_c_
+#define _MODULE_DEFINE_ _module_cmd_osdep_c_
 #elif defined _RTL871X_IO_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_io_c_
+#define _MODULE_DEFINE_ _module_rtl871x_io_c_
 #elif defined _IO_OSDEP_C_
-	#define _MODULE_DEFINE_	_module_io_osdep_c_
+#define _MODULE_DEFINE_ _module_io_osdep_c_
 #elif defined _OS_INTFS_C_
-	#define	_MODULE_DEFINE_	_module_os_intfs_c_
+#define _MODULE_DEFINE_ _module_os_intfs_c_
 #elif defined _RTL871X_SECURITY_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_security_c_
+#define _MODULE_DEFINE_ _module_rtl871x_security_c_
 #elif defined _RTL871X_EEPROM_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_eeprom_c_
+#define _MODULE_DEFINE_ _module_rtl871x_eeprom_c_
 #elif defined _HAL_INIT_C_
-	#define	_MODULE_DEFINE_	_module_hal_init_c_
+#define _MODULE_DEFINE_ _module_hal_init_c_
 #elif defined _HCI_HAL_INIT_C_
-	#define	_MODULE_DEFINE_	_module_hci_hal_init_c_
+#define _MODULE_DEFINE_ _module_hci_hal_init_c_
 #elif defined _RTL871X_IOCTL_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_c_
+#define _MODULE_DEFINE_ _module_rtl871x_ioctl_c_
 #elif defined _RTL871X_IOCTL_SET_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_set_c_
+#define _MODULE_DEFINE_ _module_rtl871x_ioctl_set_c_
 #elif defined _RTL871X_PWRCTRL_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_pwrctrl_c_
+#define _MODULE_DEFINE_ _module_rtl871x_pwrctrl_c_
 #elif defined _HCI_INTF_C_
-	#define	_MODULE_DEFINE_	_module_hci_intfs_c_
+#define _MODULE_DEFINE_ _module_hci_intfs_c_
 #elif defined _HCI_OPS_C_
-	#define	_MODULE_DEFINE_	_module_hci_ops_c_
+#define _MODULE_DEFINE_ _module_hci_ops_c_
 #elif defined _OSDEP_HCI_INTF_C_
-	#define	_MODULE_DEFINE_	_module_hci_intfs_c_
+#define _MODULE_DEFINE_ _module_hci_intfs_c_
 #elif defined _OSDEP_SERVICE_C_
-	#define	_MODULE_DEFINE_	_module_osdep_service_c_
+#define _MODULE_DEFINE_ _module_osdep_service_c_
 #elif defined _RTL871X_MP_IOCTL_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_mp_ioctl_c_
+#define _MODULE_DEFINE_ _module_rtl871x_mp_ioctl_c_
 #elif defined _HCI_OPS_OS_C_
-	#define	_MODULE_DEFINE_	_module_hci_ops_os_c_
+#define _MODULE_DEFINE_ _module_hci_ops_os_c_
 #elif defined _RTL871X_IOCTL_LINUX_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_os_c
+#define _MODULE_DEFINE_ _module_rtl871x_ioctl_os_c
 #elif defined _RTL871X_MP_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_mp_c_
+#define _MODULE_DEFINE_ _module_rtl871x_mp_c_
 #elif defined _RTL8712_CMD_C_
-	#define	_MODULE_DEFINE_	_module_rtl8712_cmd_c_
+#define _MODULE_DEFINE_ _module_rtl8712_cmd_c_
 #elif defined _RTL8712_XMIT_C_
-	#define	_MODULE_DEFINE_	_module_rtl8712_xmit_c_
+#define _MODULE_DEFINE_ _module_rtl8712_xmit_c_
 #elif defined _RTL8712_EFUSE_C_
-	#define	_MODULE_DEFINE_	_module_rtl8712_efuse_c_
+#define _MODULE_DEFINE_ _module_rtl8712_efuse_c_
 #elif defined _RTL8712_RECV_C_
-	#define	_MODULE_DEFINE_	_module_rtl8712_recv_c_
+#define _MODULE_DEFINE_ _module_rtl8712_recv_c_
 #else
-	#undef	_MODULE_DEFINE_
+#undef _MODULE_DEFINE_
 #endif
 
-#endif	/*__RTL871X_DEBUG_H__*/
+#endif /*__RTL871X_DEBUG_H__*/
diff --git a/drivers/staging/rtl8712/rtl871x_eeprom.c b/drivers/staging/rtl8712/rtl871x_eeprom.c
index 221bf92e1b1c..7666516fe972 100644
--- a/drivers/staging/rtl8712/rtl871x_eeprom.c
+++ b/drivers/staging/rtl8712/rtl871x_eeprom.c
@@ -87,7 +87,7 @@ static u16 shift_in_bits(struct _adapter *padapter)
 
 static void standby(struct _adapter *padapter)
 {
-	u8   x;
+	u8 x;
 
 	x = r8712_read8(padapter, EE_9346CR);
 	x &= ~(_EECS | _EESK);
@@ -100,8 +100,8 @@ static void standby(struct _adapter *padapter)
 
 static u16 wait_eeprom_cmd_done(struct _adapter *padapter)
 {
-	u8	x;
-	u16	i;
+	u8 x;
+	u16 i;
 
 	standby(padapter);
 	for (i = 0; i < 200; i++) {
@@ -150,9 +150,9 @@ void r8712_eeprom_write16(struct _adapter *padapter, u16 reg, u16 data)
 	x |= _EEM1 | _EECS;
 	r8712_write8(padapter, EE_9346CR, x);
 	shift_out_bits(padapter, EEPROM_EWEN_OPCODE, 5);
-	if (padapter->eeprom_address_size == 8)	/*CF+ and SDIO*/
+	if (padapter->eeprom_address_size == 8) /*CF+ and SDIO*/
 		shift_out_bits(padapter, 0, 6);
-	else	/* USB */
+	else /* USB */
 		shift_out_bits(padapter, 0, 4);
 	standby(padapter);
 	/* Erase this particular word.  Write the erase opcode and register
diff --git a/drivers/staging/rtl8712/rtl871x_eeprom.h b/drivers/staging/rtl8712/rtl871x_eeprom.h
index 7bdeb2aaa025..a1599cb9ad05 100644
--- a/drivers/staging/rtl8712/rtl871x_eeprom.h
+++ b/drivers/staging/rtl8712/rtl871x_eeprom.h
@@ -9,30 +9,30 @@
 
 #include "osdep_service.h"
 
-#define	RTL8712_EEPROM_ID		0x8712
-#define	EEPROM_MAX_SIZE			256
-#define	CLOCK_RATE			50	/*100us*/
+#define RTL8712_EEPROM_ID 0x8712
+#define EEPROM_MAX_SIZE 256
+#define CLOCK_RATE 50 /*100us*/
 
 /*- EEPROM opcodes*/
-#define EEPROM_READ_OPCODE		06
-#define EEPROM_WRITE_OPCODE		05
-#define EEPROM_ERASE_OPCODE		07
-#define EEPROM_EWEN_OPCODE		19      /* Erase/write enable*/
-#define EEPROM_EWDS_OPCODE		16      /* Erase/write disable*/
+#define EEPROM_READ_OPCODE 06
+#define EEPROM_WRITE_OPCODE 05
+#define EEPROM_ERASE_OPCODE 07
+#define EEPROM_EWEN_OPCODE 19 /* Erase/write enable*/
+#define EEPROM_EWDS_OPCODE 16 /* Erase/write disable*/
 
-#define	EEPROM_CID_DEFAULT		0x0
-#define	EEPROM_CID_ALPHA		0x1
-#define	EEPROM_CID_Senao		0x3
-#define	EEPROM_CID_NetCore		0x5
-#define	EEPROM_CID_CAMEO		0X8
-#define	EEPROM_CID_SITECOM		0x9
-#define	EEPROM_CID_COREGA		0xB
-#define	EEPROM_CID_EDIMAX_BELKIN	0xC
-#define	EEPROM_CID_SERCOMM_BELKIN	0xE
-#define	EEPROM_CID_CAMEO1		0xF
-#define	EEPROM_CID_WNC_COREGA		0x12
-#define	EEPROM_CID_CLEVO		0x13
-#define	EEPROM_CID_WHQL			0xFE
+#define EEPROM_CID_DEFAULT 0x0
+#define EEPROM_CID_ALPHA 0x1
+#define EEPROM_CID_Senao 0x3
+#define EEPROM_CID_NetCore 0x5
+#define EEPROM_CID_CAMEO 0X8
+#define EEPROM_CID_SITECOM 0x9
+#define EEPROM_CID_COREGA 0xB
+#define EEPROM_CID_EDIMAX_BELKIN 0xC
+#define EEPROM_CID_SERCOMM_BELKIN 0xE
+#define EEPROM_CID_CAMEO1 0xF
+#define EEPROM_CID_WNC_COREGA 0x12
+#define EEPROM_CID_CLEVO 0x13
+#define EEPROM_CID_WHQL 0xFE
 
 enum RT_CUSTOMER_ID {
 	RT_CID_DEFAULT = 0,
@@ -41,7 +41,7 @@ enum RT_CUSTOMER_ID {
 	RT_CID_8187_HW_LED = 3,
 	RT_CID_8187_NETGEAR = 4,
 	RT_CID_WHQL = 5,
-	RT_CID_819x_CAMEO  = 6,
+	RT_CID_819x_CAMEO = 6,
 	RT_CID_819x_RUNTOP = 7,
 	RT_CID_819x_Senao = 8,
 	RT_CID_TOSHIBA = 9,
@@ -84,5 +84,4 @@ struct eeprom_priv {
 void r8712_eeprom_write16(struct _adapter *padapter, u16 reg, u16 data);
 u16 r8712_eeprom_read16(struct _adapter *padapter, u16 reg);
 
-#endif  /*__RTL871X_EEPROM_H__*/
-
+#endif /*__RTL871X_EEPROM_H__*/
diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
index 0cc780cf4341..e5f0d8f0956d 100644
--- a/drivers/staging/rtl8712/rtl871x_event.h
+++ b/drivers/staging/rtl8712/rtl871x_event.h
@@ -23,7 +23,7 @@
 /*
  * Used to report a bss has been scanned
  */
-struct survey_event	{
+struct survey_event {
 	struct wlan_bssid_ex bss;
 };
 
@@ -32,8 +32,7 @@ struct survey_event	{
  * bss_cnt indicates the number of bss that has been reported.
  */
 struct surveydone_event {
-	unsigned int	bss_cnt;
-
+	unsigned int bss_cnt;
 };
 
 /*
@@ -44,7 +43,7 @@ struct surveydone_event {
  *  > 0: TID
  */
 struct joinbss_event {
-	struct	wlan_network	network;
+	struct wlan_network network;
 };
 
 /*
@@ -54,7 +53,7 @@ struct joinbss_event {
 struct stassoc_event {
 	unsigned char macaddr[6];
 	unsigned char rsvd[2];
-	__le32    cam_id;
+	__le32 cam_id;
 };
 
 struct stadel_event {
@@ -66,34 +65,34 @@ struct addba_event {
 	unsigned int tid;
 };
 
-#define GEN_EVT_CODE(event)	event ## _EVT_
+#define GEN_EVT_CODE(event) event##_EVT_
 
 struct fwevent {
-	u32	parmsize;
+	u32 parmsize;
 	void (*event_callback)(struct _adapter *dev, u8 *pbuf);
 };
 
-#define C2HEVENT_SZ			32
+#define C2HEVENT_SZ 32
 struct event_node {
 	unsigned char *node;
 	unsigned char evt_code;
 	unsigned short evt_sz;
 	/*volatile*/ int *caller_ff_tail;
-	int	caller_ff_sz;
+	int caller_ff_sz;
 };
 
 struct c2hevent_queue {
-	/*volatile*/ int	head;
-	/*volatile*/ int	tail;
-	struct	event_node	nodes[C2HEVENT_SZ];
-	unsigned char	seq;
+	/*volatile*/ int head;
+	/*volatile*/ int tail;
+	struct event_node nodes[C2HEVENT_SZ];
+	unsigned char seq;
 };
 
-#define NETWORK_QUEUE_SZ	4
+#define NETWORK_QUEUE_SZ 4
 
 struct network_queue {
-	/*volatile*/ int	head;
-	/*volatile*/ int	tail;
+	/*volatile*/ int head;
+	/*volatile*/ int tail;
 	struct wlan_bssid_ex networks[NETWORK_QUEUE_SZ];
 };
 
@@ -106,4 +105,3 @@ struct ADDBA_Req_Report_parm {
 #include "rtl8712_event.h"
 
 #endif /* _WLANEVENT_H_ */
-
diff --git a/drivers/staging/rtl8712/rtl871x_ht.h b/drivers/staging/rtl8712/rtl871x_ht.h
index ebd78665775d..d0d4346a3e27 100644
--- a/drivers/staging/rtl8712/rtl871x_ht.h
+++ b/drivers/staging/rtl8712/rtl871x_ht.h
@@ -18,16 +18,15 @@
 #include "wifi.h"
 
 struct ht_priv {
-	unsigned int	ht_option;
-	unsigned int	ampdu_enable;/*for enable Tx A-MPDU*/
-	unsigned char	baddbareq_issued[16];
-	unsigned int	tx_amsdu_enable;/*for enable Tx A-MSDU */
-	unsigned int	tx_amdsu_maxlen; /* 1: 8k, 0:4k ; default:8k, for tx */
-	unsigned int	rx_ampdu_maxlen; /* for rx reordering ctrl win_sz,
+	unsigned int ht_option;
+	unsigned int ampdu_enable; /*for enable Tx A-MPDU*/
+	unsigned char baddbareq_issued[16];
+	unsigned int tx_amsdu_enable; /*for enable Tx A-MSDU */
+	unsigned int tx_amdsu_maxlen; /* 1: 8k, 0:4k ; default:8k, for tx */
+	unsigned int rx_ampdu_maxlen; /* for rx reordering ctrl win_sz,
 					  * updated when join_callback.
 					  */
 	struct ieee80211_ht_cap ht_cap;
 };
 
-#endif	/*_RTL871X_HT_H_ */
-
+#endif /*_RTL871X_HT_H_ */
diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
index 20e080e284dd..13e75f7aa85b 100644
--- a/drivers/staging/rtl8712/rtl871x_io.c
+++ b/drivers/staging/rtl8712/rtl871x_io.c
@@ -38,10 +38,10 @@
 static uint _init_intf_hdl(struct _adapter *padapter,
 			   struct intf_hdl *pintf_hdl)
 {
-	struct	intf_priv	*pintf_priv;
+	struct intf_priv *pintf_priv;
 	void (*set_intf_option)(u32 *poption) = NULL;
 	void (*set_intf_funs)(struct intf_hdl *pintf_hdl);
-	void (*set_intf_ops)(struct _io_ops	*pops);
+	void (*set_intf_ops)(struct _io_ops *pops);
 	uint (*init_intf_priv)(struct intf_priv *pintfpriv);
 
 	set_intf_option = &(r8712_usb_set_intf_option);
@@ -88,7 +88,7 @@ static uint register_intf_hdl(u8 *dev, struct intf_hdl *pintfhdl)
 	return false;
 }
 
-static  void unregister_intf_hdl(struct intf_hdl *pintfhdl)
+static void unregister_intf_hdl(struct intf_hdl *pintfhdl)
 {
 	_unload_intf_hdl(pintfhdl->pintfpriv);
 	memset((u8 *)pintfhdl, 0, sizeof(struct intf_hdl));
@@ -107,14 +107,13 @@ uint r8712_alloc_io_queue(struct _adapter *adapter)
 	INIT_LIST_HEAD(&pio_queue->processing);
 	INIT_LIST_HEAD(&pio_queue->pending);
 	spin_lock_init(&pio_queue->lock);
-	pio_queue->pallocated_free_ioreqs_buf = kzalloc(NUM_IOREQ *
-						(sizeof(struct io_req)) + 4,
-						GFP_ATOMIC);
-	if ((pio_queue->pallocated_free_ioreqs_buf) == NULL)
+	pio_queue->pallocated_free_ioreqs_buf =
+		kzalloc(NUM_IOREQ * (sizeof(struct io_req)) + 4, GFP_ATOMIC);
+	if (pio_queue->pallocated_free_ioreqs_buf == NULL)
 		goto alloc_io_queue_fail;
-	pio_queue->free_ioreqs_buf = pio_queue->pallocated_free_ioreqs_buf + 4
-			- ((addr_t)(pio_queue->pallocated_free_ioreqs_buf)
-			& 3);
+	pio_queue->free_ioreqs_buf =
+		pio_queue->pallocated_free_ioreqs_buf + 4 -
+		((addr_t)(pio_queue->pallocated_free_ioreqs_buf) & 3);
 	pio_req = (struct io_req *)(pio_queue->free_ioreqs_buf);
 	for (i = 0; i < NUM_IOREQ; i++) {
 		INIT_LIST_HEAD(&pio_req->list);
diff --git a/drivers/staging/rtl8712/rtl871x_io.h b/drivers/staging/rtl8712/rtl871x_io.h
index f09d50a29b82..9942538318bb 100644
--- a/drivers/staging/rtl8712/rtl871x_io.h
+++ b/drivers/staging/rtl8712/rtl871x_io.h
@@ -17,57 +17,57 @@
 #include "osdep_service.h"
 #include "osdep_intf.h"
 
-#define NUM_IOREQ		8
+#define NUM_IOREQ 8
 
-#define MAX_PROT_SZ	(64-16)
+#define MAX_PROT_SZ (64 - 16)
 
-#define _IOREADY			0
-#define _IO_WAIT_COMPLETE   1
-#define _IO_WAIT_RSP        2
+#define _IOREADY 0
+#define _IO_WAIT_COMPLETE 1
+#define _IO_WAIT_RSP 2
 
 /* IO COMMAND TYPE */
-#define _IOSZ_MASK_		(0x7F)
-#define _IO_WRITE_		BIT(7)
-#define _IO_FIXED_		BIT(8)
-#define _IO_BURST_		BIT(9)
-#define _IO_BYTE_		BIT(10)
-#define _IO_HW_			BIT(11)
-#define _IO_WORD_		BIT(12)
-#define _IO_SYNC_		BIT(13)
-#define _IO_CMDMASK_	(0x1F80)
+#define _IOSZ_MASK_ (0x7F)
+#define _IO_WRITE_ BIT(7)
+#define _IO_FIXED_ BIT(8)
+#define _IO_BURST_ BIT(9)
+#define _IO_BYTE_ BIT(10)
+#define _IO_HW_ BIT(11)
+#define _IO_WORD_ BIT(12)
+#define _IO_SYNC_ BIT(13)
+#define _IO_CMDMASK_ (0x1F80)
 
 /*
  *	For prompt mode accessing, caller shall free io_req
  *	Otherwise, io_handler will free io_req
  */
 /* IO STATUS TYPE */
-#define _IO_ERR_		BIT(2)
-#define _IO_SUCCESS_	BIT(1)
-#define _IO_DONE_		BIT(0)
-#define IO_RD32			(_IO_SYNC_ | _IO_WORD_)
-#define IO_RD16			(_IO_SYNC_ | _IO_HW_)
-#define IO_RD8			(_IO_SYNC_ | _IO_BYTE_)
-#define IO_RD32_ASYNC	(_IO_WORD_)
-#define IO_RD16_ASYNC	(_IO_HW_)
-#define IO_RD8_ASYNC	(_IO_BYTE_)
-#define IO_WR32			(_IO_WRITE_ | _IO_SYNC_ | _IO_WORD_)
-#define IO_WR16			(_IO_WRITE_ | _IO_SYNC_ | _IO_HW_)
-#define IO_WR8			(_IO_WRITE_ | _IO_SYNC_ | _IO_BYTE_)
-#define IO_WR32_ASYNC	(_IO_WRITE_ | _IO_WORD_)
-#define IO_WR16_ASYNC	(_IO_WRITE_ | _IO_HW_)
-#define IO_WR8_ASYNC	(_IO_WRITE_ | _IO_BYTE_)
+#define _IO_ERR_ BIT(2)
+#define _IO_SUCCESS_ BIT(1)
+#define _IO_DONE_ BIT(0)
+#define IO_RD32 (_IO_SYNC_ | _IO_WORD_)
+#define IO_RD16 (_IO_SYNC_ | _IO_HW_)
+#define IO_RD8 (_IO_SYNC_ | _IO_BYTE_)
+#define IO_RD32_ASYNC (_IO_WORD_)
+#define IO_RD16_ASYNC (_IO_HW_)
+#define IO_RD8_ASYNC (_IO_BYTE_)
+#define IO_WR32 (_IO_WRITE_ | _IO_SYNC_ | _IO_WORD_)
+#define IO_WR16 (_IO_WRITE_ | _IO_SYNC_ | _IO_HW_)
+#define IO_WR8 (_IO_WRITE_ | _IO_SYNC_ | _IO_BYTE_)
+#define IO_WR32_ASYNC (_IO_WRITE_ | _IO_WORD_)
+#define IO_WR16_ASYNC (_IO_WRITE_ | _IO_HW_)
+#define IO_WR8_ASYNC (_IO_WRITE_ | _IO_BYTE_)
 /*
  *	Only Sync. burst accessing is provided.
  */
-#define IO_WR_BURST(x)		(IO_WRITE_ | _IO_SYNC_ | _IO_BURST_ | \
-				((x) & _IOSZ_MASK_))
-#define IO_RD_BURST(x)		(_IO_SYNC_ | _IO_BURST_ | ((x) & _IOSZ_MASK_))
+#define IO_WR_BURST(x) \
+	(IO_WRITE_ | _IO_SYNC_ | _IO_BURST_ | ((x) & _IOSZ_MASK_))
+#define IO_RD_BURST(x) (_IO_SYNC_ | _IO_BURST_ | ((x) & _IOSZ_MASK_))
 /*below is for the intf_option bit definition...*/
-#define _INTF_ASYNC_	BIT(0)	/*support async io*/
+#define _INTF_ASYNC_ BIT(0) /*support async io*/
 struct intf_priv;
-struct	intf_hdl;
+struct intf_hdl;
 struct io_queue;
-struct	_io_ops {
+struct _io_ops {
 	uint (*_sdbus_read_bytes_to_membuf)(struct intf_priv *pintfpriv,
 					    u32 addr, u32 cnt, u8 *pbuf);
 	uint (*_sdbus_read_blocks_to_membuf)(struct intf_priv *pintfpriv,
@@ -100,62 +100,62 @@ struct	_io_ops {
 
 struct io_req {
 	struct list_head list;
-	u32	addr;
-	/*volatile*/ u32	val;
-	u32	command;
-	u32	status;
-	u8	*pbuf;
+	u32 addr;
+	/*volatile*/ u32 val;
+	u32 command;
+	u32 status;
+	u8 *pbuf;
 	void (*_async_io_callback)(struct _adapter *padapter,
 				   struct io_req *pio_req, u8 *cnxt);
 	u8 *cnxt;
 };
 
-struct	intf_hdl {
-	u32	intf_option;
-	u8	*adapter;
-	u8	*intf_dev;
-	struct intf_priv	*pintfpriv;
+struct intf_hdl {
+	u32 intf_option;
+	u8 *adapter;
+	u8 *intf_dev;
+	struct intf_priv *pintfpriv;
 	void (*intf_hdl_init)(u8 *priv);
 	void (*intf_hdl_unload)(u8 *priv);
 	void (*intf_hdl_open)(u8 *priv);
 	void (*intf_hdl_close)(u8 *priv);
-	struct	_io_ops	io_ops;
+	struct _io_ops io_ops;
 };
 
 struct reg_protocol_rd {
 #ifdef __LITTLE_ENDIAN
 	/* DW1 */
-	u32		NumOfTrans:4;
-	u32		Reserved1:4;
-	u32		Reserved2:24;
+	u32 NumOfTrans : 4;
+	u32 Reserved1 : 4;
+	u32 Reserved2 : 24;
 	/* DW2 */
-	u32		ByteCount:7;
-	u32		WriteEnable:1;		/*0:read, 1:write*/
-	u32		FixOrContinuous:1;	/*0:continuous, 1: Fix*/
-	u32		BurstMode:1;
-	u32		Byte1Access:1;
-	u32		Byte2Access:1;
-	u32		Byte4Access:1;
-	u32		Reserved3:3;
-	u32		Reserved4:16;
+	u32 ByteCount : 7;
+	u32 WriteEnable : 1; /*0:read, 1:write*/
+	u32 FixOrContinuous : 1; /*0:continuous, 1: Fix*/
+	u32 BurstMode : 1;
+	u32 Byte1Access : 1;
+	u32 Byte2Access : 1;
+	u32 Byte4Access : 1;
+	u32 Reserved3 : 3;
+	u32 Reserved4 : 16;
 	/*DW3*/
-	u32		BusAddress;
+	u32 BusAddress;
 	/*DW4*/
 #else
-/*DW1*/
-	u32 Reserved1:4;
-	u32 NumOfTrans:4;
-	u32 Reserved2:24;
+	/*DW1*/
+	u32 Reserved1 : 4;
+	u32 NumOfTrans : 4;
+	u32 Reserved2 : 24;
 	/*DW2*/
-	u32 WriteEnable:1;
-	u32 ByteCount:7;
-	u32 Reserved3:3;
-	u32 Byte4Access:1;
-	u32 Byte2Access:1;
-	u32 Byte1Access:1;
-	u32 BurstMode:1;
-	u32 FixOrContinuous:1;
-	u32 Reserved4:16;
+	u32 WriteEnable : 1;
+	u32 ByteCount : 7;
+	u32 Reserved3 : 3;
+	u32 Byte4Access : 1;
+	u32 Byte2Access : 1;
+	u32 Byte1Access : 1;
+	u32 BurstMode : 1;
+	u32 FixOrContinuous : 1;
+	u32 Reserved4 : 16;
 	/*DW3*/
 	u32 BusAddress;
 	/*DW4*/
@@ -165,38 +165,38 @@ struct reg_protocol_rd {
 struct reg_protocol_wt {
 #ifdef __LITTLE_ENDIAN
 	/*DW1*/
-	u32 NumOfTrans:4;
-	u32 Reserved1:4;
-	u32 Reserved2:24;
+	u32 NumOfTrans : 4;
+	u32 Reserved1 : 4;
+	u32 Reserved2 : 24;
 	/*DW2*/
-	u32 ByteCount:7;
-	u32 WriteEnable:1;	/*0:read, 1:write*/
-	u32 FixOrContinuous:1;	/*0:continuous, 1: Fix*/
-	u32 BurstMode:1;
-	u32 Byte1Access:1;
-	u32 Byte2Access:1;
-	u32 Byte4Access:1;
-	u32 Reserved3:3;
-	u32 Reserved4:16;
+	u32 ByteCount : 7;
+	u32 WriteEnable : 1; /*0:read, 1:write*/
+	u32 FixOrContinuous : 1; /*0:continuous, 1: Fix*/
+	u32 BurstMode : 1;
+	u32 Byte1Access : 1;
+	u32 Byte2Access : 1;
+	u32 Byte4Access : 1;
+	u32 Reserved3 : 3;
+	u32 Reserved4 : 16;
 	/*DW3*/
 	u32 BusAddress;
 	/*DW4*/
 	u32 Value;
 #else
 	/*DW1*/
-	u32 Reserved1:4;
-	u32 NumOfTrans:4;
-	u32 Reserved2:24;
+	u32 Reserved1 : 4;
+	u32 NumOfTrans : 4;
+	u32 Reserved2 : 24;
 	/*DW2*/
-	u32 WriteEnable:1;
-	u32 ByteCount:7;
-	u32 Reserved3:3;
-	u32 Byte4Access:1;
-	u32 Byte2Access:1;
-	u32 Byte1Access:1;
-	u32 BurstMode:1;
-	u32 FixOrContinuous:1;
-	u32 Reserved4:16;
+	u32 WriteEnable : 1;
+	u32 ByteCount : 7;
+	u32 Reserved3 : 3;
+	u32 Byte4Access : 1;
+	u32 Byte2Access : 1;
+	u32 Byte1Access : 1;
+	u32 BurstMode : 1;
+	u32 FixOrContinuous : 1;
+	u32 Reserved4 : 16;
 	/*DW3*/
 	u32 BusAddress;
 	/*DW4*/
@@ -216,7 +216,7 @@ struct io_queue {
 	struct list_head processing;
 	u8 *free_ioreqs_buf; /* 4-byte aligned */
 	u8 *pallocated_free_ioreqs_buf;
-	struct	intf_hdl intf;
+	struct intf_hdl intf;
 };
 
 u8 r8712_read8(struct _adapter *adapter, u32 addr);
@@ -233,4 +233,4 @@ void r8712_write_port(struct _adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 uint r8712_alloc_io_queue(struct _adapter *adapter);
 void r8712_free_io_queue(struct _adapter *adapter);
 
-#endif	/*_RTL871X_IO_H_*/
+#endif /*_RTL871X_IO_H_*/
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl.h b/drivers/staging/rtl8712/rtl871x_ioctl.h
index d6332a8c7f4f..fcfadc0b29df 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl.h
+++ b/drivers/staging/rtl8712/rtl871x_ioctl.h
@@ -6,45 +6,42 @@
 #include "drv_types.h"
 
 #ifndef OID_802_11_CAPABILITY
-	#define OID_802_11_CAPABILITY                   0x0d010122
+#define OID_802_11_CAPABILITY 0x0d010122
 #endif
 
 #ifndef OID_802_11_PMKID
-	#define OID_802_11_PMKID                        0x0d010123
+#define OID_802_11_PMKID 0x0d010123
 #endif
 
 /* For DDK-defined OIDs*/
-#define OID_NDIS_SEG1	0x00010100
-#define OID_NDIS_SEG2	0x00010200
-#define OID_NDIS_SEG3	0x00020100
-#define OID_NDIS_SEG4	0x01010100
-#define OID_NDIS_SEG5	0x01020100
-#define OID_NDIS_SEG6	0x01020200
-#define OID_NDIS_SEG7	0xFD010100
-#define OID_NDIS_SEG8	0x0D010100
-#define OID_NDIS_SEG9	0x0D010200
-#define OID_NDIS_SEG10	0x0D020200
-#define SZ_OID_NDIS_SEG1	23
-#define SZ_OID_NDIS_SEG2	3
-#define SZ_OID_NDIS_SEG3	6
-#define SZ_OID_NDIS_SEG4	6
-#define SZ_OID_NDIS_SEG5	4
-#define SZ_OID_NDIS_SEG6	8
-#define SZ_OID_NDIS_SEG7	7
-#define SZ_OID_NDIS_SEG8	36
-#define SZ_OID_NDIS_SEG9	24
-#define SZ_OID_NDIS_SEG10	19
+#define OID_NDIS_SEG1 0x00010100
+#define OID_NDIS_SEG2 0x00010200
+#define OID_NDIS_SEG3 0x00020100
+#define OID_NDIS_SEG4 0x01010100
+#define OID_NDIS_SEG5 0x01020100
+#define OID_NDIS_SEG6 0x01020200
+#define OID_NDIS_SEG7 0xFD010100
+#define OID_NDIS_SEG8 0x0D010100
+#define OID_NDIS_SEG9 0x0D010200
+#define OID_NDIS_SEG10 0x0D020200
+#define SZ_OID_NDIS_SEG1 23
+#define SZ_OID_NDIS_SEG2 3
+#define SZ_OID_NDIS_SEG3 6
+#define SZ_OID_NDIS_SEG4 6
+#define SZ_OID_NDIS_SEG5 4
+#define SZ_OID_NDIS_SEG6 8
+#define SZ_OID_NDIS_SEG7 7
+#define SZ_OID_NDIS_SEG8 36
+#define SZ_OID_NDIS_SEG9 24
+#define SZ_OID_NDIS_SEG10 19
 
 /* For Realtek-defined OIDs*/
-#define OID_MP_SEG1	0xFF871100
-#define OID_MP_SEG2	0xFF818000
-#define OID_MP_SEG3	0xFF818700
-#define OID_MP_SEG4	0xFF011100
+#define OID_MP_SEG1 0xFF871100
+#define OID_MP_SEG2 0xFF818000
+#define OID_MP_SEG3 0xFF818700
+#define OID_MP_SEG4 0xFF011100
 
-enum oid_type {
-	QUERY_OID,
-	SET_OID
-};
+enum oid_type { QUERY_OID, SET_OID };
 
 struct oid_funs_node {
 	unsigned int oid_start; /*the starting number for OID*/
@@ -56,18 +53,18 @@ struct oid_funs_node {
 };
 
 struct oid_par_priv {
-	void	*adapter_context;
+	void *adapter_context;
 	uint oid;
 	void *information_buf;
 	unsigned long information_buf_len;
 	unsigned long *bytes_rw;
 	unsigned long *bytes_needed;
-	enum oid_type	type_of_oid;
+	enum oid_type type_of_oid;
 	unsigned int dbg;
 };
 
 struct oid_obj_priv {
-	unsigned char	dbg; /* 0: without OID debug message
+	unsigned char dbg; /* 0: without OID debug message
 			      * 1: with OID debug message
 			      */
 	uint (*oidfuns)(struct oid_par_priv *poid_par_priv);
@@ -75,20 +72,14 @@ struct oid_obj_priv {
 
 uint oid_null_function(struct oid_par_priv *poid_par_priv);
 
-extern struct iw_handler_def  r871x_handlers_def;
+extern struct iw_handler_def r871x_handlers_def;
 
-uint drv_query_info(struct net_device *MiniportAdapterContext,
-		    uint Oid,
-		    void *InformationBuffer,
-		    u32 InformationBufferLength,
-		    u32 *BytesWritten,
-		    u32 *BytesNeeded);
+uint drv_query_info(struct net_device *MiniportAdapterContext, uint Oid,
+		    void *InformationBuffer, u32 InformationBufferLength,
+		    u32 *BytesWritten, u32 *BytesNeeded);
 
-uint drv_set_info(struct net_device *MiniportAdapterContext,
-		  uint Oid,
-		  void *InformationBuffer,
-		  u32 InformationBufferLength,
-		  u32 *BytesRead,
-		  u32 *BytesNeeded);
+uint drv_set_info(struct net_device *MiniportAdapterContext, uint Oid,
+		  void *InformationBuffer, u32 InformationBufferLength,
+		  u32 *BytesRead, u32 *BytesNeeded);
 
 #endif
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 0653aa27b1fa..c40795136187 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -36,22 +36,19 @@
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
 
-#define RTL_IOCTL_WPA_SUPPLICANT	(SIOCIWFIRSTPRIV + 0x1E)
+#define RTL_IOCTL_WPA_SUPPLICANT (SIOCIWFIRSTPRIV + 0x1E)
 
 #define SCAN_ITEM_SIZE 768
 #define MAX_CUSTOM_LEN 64
 #define RATE_COUNT 4
 
-static const u32 rtl8180_rates[] = {1000000, 2000000, 5500000, 11000000,
-		       6000000, 9000000, 12000000, 18000000,
-		       24000000, 36000000, 48000000, 54000000};
+static const u32 rtl8180_rates[] = { 1000000,  2000000,	 5500000,  11000000,
+				     6000000,  9000000,	 12000000, 18000000,
+				     24000000, 36000000, 48000000, 54000000 };
 
-static const long ieee80211_wlan_frequencies[] = {
-	2412, 2417, 2422, 2427,
-	2432, 2437, 2442, 2447,
-	2452, 2457, 2462, 2467,
-	2472, 2484
-};
+static const long ieee80211_wlan_frequencies[] = { 2412, 2417, 2422, 2427, 2432,
+						   2437, 2442, 2447, 2452, 2457,
+						   2462, 2467, 2472, 2484 };
 
 void r8712_indicate_wx_assoc_event(struct _adapter *padapter)
 {
@@ -59,7 +56,8 @@ void r8712_indicate_wx_assoc_event(struct _adapter *padapter)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	wrqu.ap_addr.sa_family = ARPHRD_ETHER;
-	memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.MacAddress, ETH_ALEN);
+	memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.MacAddress,
+	       ETH_ALEN);
 	wireless_send_event(padapter->pnetdev, SIOCGIWAP, &wrqu, NULL);
 }
 
@@ -78,13 +76,11 @@ static inline void handle_pairwise_key(struct sta_info *psta,
 {
 	/* pairwise key */
 	memcpy(psta->x_UncstKey.skey, param->u.crypt.key,
-	       (param->u.crypt. key_len > 16 ? 16 : param->u.crypt.key_len));
+	       (param->u.crypt.key_len > 16 ? 16 : param->u.crypt.key_len));
 	if (strcmp(param->u.crypt.alg, "TKIP") == 0) { /* set mic key */
-		memcpy(psta->tkiptxmickey. skey,
-		       &param->u.crypt.key[16], 8);
-		memcpy(psta->tkiprxmickey. skey,
-		       &param->u.crypt.key[24], 8);
-		padapter->securitypriv. busetkipkey = false;
+		memcpy(psta->tkiptxmickey.skey, &param->u.crypt.key[16], 8);
+		memcpy(psta->tkiprxmickey.skey, &param->u.crypt.key[24], 8);
+		padapter->securitypriv.busetkipkey = false;
 		mod_timer(&padapter->securitypriv.tkip_timer,
 			  jiffies + msecs_to_jiffies(50));
 	}
@@ -98,31 +94,30 @@ static inline void handle_group_key(struct ieee_param *param,
 	union Keytype *gtk = padapter->securitypriv.XGrptxmickey;
 	union Keytype *grk = padapter->securitypriv.XGrprxmickey;
 
-	if (param->u.crypt.idx > 0 &&
-	    param->u.crypt.idx < 3) {
+	if (param->u.crypt.idx > 0 && param->u.crypt.idx < 3) {
 		/* group key idx is 1 or 2 */
-		memcpy(gk[param->u.crypt.idx - 1].skey,
-		       param->u.crypt.key,
+		memcpy(gk[param->u.crypt.idx - 1].skey, param->u.crypt.key,
 		       (param->u.crypt.key_len > 16 ? 16 :
-			param->u.crypt.key_len));
+						      param->u.crypt.key_len));
 		memcpy(gtk[param->u.crypt.idx - 1].skey,
 		       &param->u.crypt.key[16], 8);
 		memcpy(grk[param->u.crypt.idx - 1].skey,
 		       &param->u.crypt.key[24], 8);
 		padapter->securitypriv.binstallGrpkey = true;
-		r8712_set_key(padapter, &padapter->securitypriv, param->u.crypt.idx);
+		r8712_set_key(padapter, &padapter->securitypriv,
+			      param->u.crypt.idx);
 		if (padapter->registrypriv.power_mgnt > PS_MODE_ACTIVE) {
-			if (padapter->registrypriv.power_mgnt != padapter->pwrctrlpriv.pwr_mode)
+			if (padapter->registrypriv.power_mgnt !=
+			    padapter->pwrctrlpriv.pwr_mode)
 				mod_timer(&padapter->mlmepriv.dhcp_timer,
 					  jiffies + msecs_to_jiffies(60000));
 		}
 	}
 }
 
-static noinline_for_stack char *translate_scan_wpa(struct iw_request_info *info,
-						   struct wlan_network *pnetwork,
-						   struct iw_event *iwe,
-						   char *start, char *stop)
+static noinline_for_stack char *
+translate_scan_wpa(struct iw_request_info *info, struct wlan_network *pnetwork,
+		   struct iw_event *iwe, char *start, char *stop)
 {
 	/* parsing WPA/WPA2 IE */
 	u8 buf[MAX_WPA_IE_LEN];
@@ -130,15 +125,14 @@ static noinline_for_stack char *translate_scan_wpa(struct iw_request_info *info,
 	u16 wpa_len = 0, rsn_len = 0;
 	int n, i;
 
-	r8712_get_sec_ie(pnetwork->network.IEs,
-			 pnetwork->network.IELength, rsn_ie, &rsn_len,
-			 wpa_ie, &wpa_len);
+	r8712_get_sec_ie(pnetwork->network.IEs, pnetwork->network.IELength,
+			 rsn_ie, &rsn_len, wpa_ie, &wpa_len);
 	if (wpa_len > 0) {
 		memset(buf, 0, MAX_WPA_IE_LEN);
 		n = sprintf(buf, "wpa_ie=");
 		for (i = 0; i < wpa_len; i++) {
-			n += scnprintf(buf + n, MAX_WPA_IE_LEN - n,
-						"%02x", wpa_ie[i]);
+			n += scnprintf(buf + n, MAX_WPA_IE_LEN - n, "%02x",
+				       wpa_ie[i]);
 			if (n == MAX_WPA_IE_LEN - 1)
 				break;
 		}
@@ -155,8 +149,8 @@ static noinline_for_stack char *translate_scan_wpa(struct iw_request_info *info,
 		memset(buf, 0, MAX_WPA_IE_LEN);
 		n = sprintf(buf, "rsn_ie=");
 		for (i = 0; i < rsn_len; i++) {
-			n += scnprintf(buf + n, MAX_WPA_IE_LEN - n,
-						"%02x", rsn_ie[i]);
+			n += scnprintf(buf + n, MAX_WPA_IE_LEN - n, "%02x",
+				       rsn_ie[i]);
 			if (n == MAX_WPA_IE_LEN - 1)
 				break;
 		}
@@ -173,20 +167,21 @@ static noinline_for_stack char *translate_scan_wpa(struct iw_request_info *info,
 	return start;
 }
 
-static noinline_for_stack char *translate_scan_wps(struct iw_request_info *info,
-						   struct wlan_network *pnetwork,
-						   struct iw_event *iwe,
-						   char *start, char *stop)
+static noinline_for_stack char *
+translate_scan_wps(struct iw_request_info *info, struct wlan_network *pnetwork,
+		   struct iw_event *iwe, char *start, char *stop)
 {
 	/* parsing WPS IE */
 	u8 wps_ie[512];
 	uint wps_ielen;
 
-	if (r8712_get_wps_ie(pnetwork->network.IEs, pnetwork->network.IELength, wps_ie, &wps_ielen)) {
+	if (r8712_get_wps_ie(pnetwork->network.IEs, pnetwork->network.IELength,
+			     wps_ie, &wps_ielen)) {
 		if (wps_ielen > 2) {
 			iwe->cmd = IWEVGENIE;
 			iwe->u.data.length = (u16)wps_ielen;
-			start = iwe_stream_add_point(info, start, stop, iwe, wps_ie);
+			start = iwe_stream_add_point(info, start, stop, iwe,
+						     wps_ie);
 		}
 	}
 
@@ -195,18 +190,18 @@ static noinline_for_stack char *translate_scan_wps(struct iw_request_info *info,
 
 static char *translate_scan(struct _adapter *padapter,
 			    struct iw_request_info *info,
-			    struct wlan_network *pnetwork,
-			    char *start, char *stop)
+			    struct wlan_network *pnetwork, char *start,
+			    char *stop)
 {
 	struct iw_event iwe;
 	char *current_val;
 	s8 *p;
 	u32 i = 0, ht_ielen = 0;
-	u16	cap, ht_cap = false;
+	u16 cap, ht_cap = false;
 	u8 rssi;
 
-	if ((pnetwork->network.Configuration.DSConfig < 1) ||
-	    (pnetwork->network.Configuration.DSConfig > 14)) {
+	if (pnetwork->network.Configuration.DSConfig < 1 ||
+	    pnetwork->network.Configuration.DSConfig > 14) {
 		if (pnetwork->network.Configuration.DSConfig < 1)
 			pnetwork->network.Configuration.DSConfig = 1;
 		else
@@ -249,14 +244,16 @@ static char *translate_scan(struct _adapter *padapter,
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_CHAR_LEN);
 	/* Add mode */
 	iwe.cmd = SIOCGIWMODE;
-	memcpy((u8 *)&cap, r8712_get_capability_from_ie(pnetwork->network.IEs), 2);
+	memcpy((u8 *)&cap, r8712_get_capability_from_ie(pnetwork->network.IEs),
+	       2);
 	le16_to_cpus(&cap);
 	if (cap & (WLAN_CAPABILITY_IBSS | WLAN_CAPABILITY_ESS)) {
 		if (cap & WLAN_CAPABILITY_ESS)
 			iwe.u.mode = (u32)IW_MODE_MASTER;
 		else
 			iwe.u.mode = (u32)IW_MODE_ADHOC;
-		start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_UINT_LEN);
+		start = iwe_stream_add_event(info, start, stop, &iwe,
+					     IW_EV_UINT_LEN);
 	}
 	/* Add frequency/channel */
 	iwe.cmd = SIOCGIWFREQ;
@@ -264,15 +261,18 @@ static char *translate_scan(struct _adapter *padapter,
 		/*  check legal index */
 		u8 dsconfig = pnetwork->network.Configuration.DSConfig;
 
-		if (dsconfig >= 1 && dsconfig <= sizeof(ieee80211_wlan_frequencies) / sizeof(long))
-			iwe.u.freq.m = (s32)(ieee80211_wlan_frequencies[dsconfig - 1] * 100000);
+		if (dsconfig >= 1 &&
+		    dsconfig <=
+			    sizeof(ieee80211_wlan_frequencies) / sizeof(long))
+			iwe.u.freq.m =
+				(s32)(ieee80211_wlan_frequencies[dsconfig - 1] *
+				      100000);
 		else
 			iwe.u.freq.m = 0;
 	}
 	iwe.u.freq.e = (s16)1;
 	iwe.u.freq.i = (u8)pnetwork->network.Configuration.DSConfig;
-	start = iwe_stream_add_event(info, start, stop, &iwe,
-				     IW_EV_FREQ_LEN);
+	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_FREQ_LEN);
 	/* Add encryption capability */
 	iwe.cmd = SIOCGIWENCODE;
 	if (cap & WLAN_CAPABILITY_PRIVACY)
@@ -280,7 +280,8 @@ static char *translate_scan(struct _adapter *padapter,
 	else
 		iwe.u.data.flags = (u16)(IW_ENCODE_DISABLED);
 	iwe.u.data.length = (u16)0;
-	start = iwe_stream_add_point(info, start, stop, &iwe, pnetwork->network.Ssid.Ssid);
+	start = iwe_stream_add_point(info, start, stop, &iwe,
+				     pnetwork->network.Ssid.Ssid);
 	/*Add basic and extended rates */
 	current_val = start + iwe_stream_lcp_len(info);
 	iwe.cmd = SIOCGIWRATE;
@@ -290,9 +291,10 @@ static char *translate_scan(struct _adapter *padapter,
 	i = 0;
 	while (pnetwork->network.rates[i] != 0) {
 		/* Bit rate given in 500 kb/s units */
-		iwe.u.bitrate.value = (pnetwork->network.rates[i++] & 0x7F) * 500000;
-		current_val = iwe_stream_add_value(info, start, current_val, stop, &iwe,
-						   IW_EV_PARAM_LEN);
+		iwe.u.bitrate.value =
+			(pnetwork->network.rates[i++] & 0x7F) * 500000;
+		current_val = iwe_stream_add_value(info, start, current_val,
+						   stop, &iwe, IW_EV_PARAM_LEN);
 	}
 	/* Check if we added any event */
 	if ((current_val - start) > iwe_stream_lcp_len(info))
@@ -306,8 +308,9 @@ static char *translate_scan(struct _adapter *padapter,
 	iwe.cmd = IWEVQUAL;
 	rssi = r8712_signal_scale_mapping(pnetwork->network.Rssi);
 	/* we only update signal_level (signal strength) that is rssi. */
-	iwe.u.qual.updated = (u8)(IW_QUAL_QUAL_INVALID | IW_QUAL_LEVEL_UPDATED | IW_QUAL_NOISE_INVALID);
-	iwe.u.qual.level = rssi;  /* signal strength */
+	iwe.u.qual.updated = (u8)(IW_QUAL_QUAL_INVALID | IW_QUAL_LEVEL_UPDATED |
+				  IW_QUAL_NOISE_INVALID);
+	iwe.u.qual.level = rssi; /* signal strength */
 	iwe.u.qual.qual = 0; /* signal quality */
 	iwe.u.qual.noise = 0; /* noise level */
 	start = iwe_stream_add_event(info, start, stop, &iwe, IW_EV_QUAL_LEN);
@@ -322,20 +325,20 @@ static int wpa_set_auth_algs(struct net_device *dev, u32 value)
 
 	if ((value & AUTH_ALG_SHARED_KEY) && (value & AUTH_ALG_OPEN_SYSTEM)) {
 		padapter->securitypriv.ndisencryptstatus =
-						 Ndis802_11Encryption1Enabled;
+			Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.ndisauthtype =
-						 Ndis802_11AuthModeAutoSwitch;
+			Ndis802_11AuthModeAutoSwitch;
 		padapter->securitypriv.AuthAlgrthm = 3;
 	} else if (value & AUTH_ALG_SHARED_KEY) {
 		padapter->securitypriv.ndisencryptstatus =
-						 Ndis802_11Encryption1Enabled;
+			Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.ndisauthtype = Ndis802_11AuthModeShared;
 		padapter->securitypriv.AuthAlgrthm = 1;
 	} else if (value & AUTH_ALG_OPEN_SYSTEM) {
 		if (padapter->securitypriv.ndisauthtype <
-						 Ndis802_11AuthModeWPAPSK) {
+		    Ndis802_11AuthModeWPAPSK) {
 			padapter->securitypriv.ndisauthtype =
-						 Ndis802_11AuthModeOpen;
+				Ndis802_11AuthModeOpen;
 			padapter->securitypriv.AuthAlgrthm = 0;
 		}
 	} else {
@@ -349,15 +352,15 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 {
 	int ret = 0;
 	u32 wep_key_idx, wep_key_len = 0;
-	struct NDIS_802_11_WEP	 *pwep = NULL;
+	struct NDIS_802_11_WEP *pwep = NULL;
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
-	if (param_len != (u32)((u8 *) param->u.crypt.key - (u8 *)param) +
-			 param->u.crypt.key_len)
+	if (param_len != (u32)((u8 *)param->u.crypt.key - (u8 *)param) +
+				 param->u.crypt.key_len)
 		return -EINVAL;
 	if (!is_broadcast_ether_addr(param->sta_addr))
 		return -EINVAL;
@@ -369,7 +372,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 	if (strcmp(param->u.crypt.alg, "WEP") == 0) {
 		netdev_info(dev, "r8712u: %s: crypt.alg = WEP\n", __func__);
 		padapter->securitypriv.ndisencryptstatus =
-			     Ndis802_11Encryption1Enabled;
+			Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.PrivacyAlgrthm = _WEP40_;
 		padapter->securitypriv.XGrpPrivacy = _WEP40_;
 		wep_key_idx = param->u.crypt.idx;
@@ -385,7 +388,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 			return -ENOMEM;
 		pwep->KeyLength = wep_key_len;
 		pwep->Length = wep_key_len +
-			offsetof(struct NDIS_802_11_WEP, KeyMaterial);
+			       offsetof(struct NDIS_802_11_WEP, KeyMaterial);
 		if (wep_key_len == 13) {
 			padapter->securitypriv.PrivacyAlgrthm = _WEP104_;
 			padapter->securitypriv.XGrpPrivacy = _WEP104_;
@@ -406,10 +409,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 				goto exit;
 			}
 			memcpy(&psecuritypriv->DefKey[wep_key_idx].skey[0],
-			       pwep->KeyMaterial,
-			       pwep->KeyLength);
-			psecuritypriv->DefKeylen[wep_key_idx] =
-				pwep->KeyLength;
+			       pwep->KeyMaterial, pwep->KeyLength);
+			psecuritypriv->DefKeylen[wep_key_idx] = pwep->KeyLength;
 			r8712_set_key(padapter, psecuritypriv, wep_key_idx);
 		}
 		goto exit;
@@ -419,16 +420,17 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		struct sta_priv *pstapriv = &padapter->stapriv;
 		struct security_priv *spriv = &padapter->securitypriv;
 
-		if (check_fwstate(pmlmepriv, WIFI_STATION_STATE |
-		    WIFI_MP_STATE)) { /* sta mode */
+		if (check_fwstate(pmlmepriv,
+				  WIFI_STATION_STATE |
+					  WIFI_MP_STATE)) { /* sta mode */
 			psta = r8712_get_stainfo(pstapriv,
 						 get_bssid(pmlmepriv));
 			if (psta) {
 				psta->ieee8021x_blocked = false;
 				if (spriv->ndisencryptstatus ==
-				    Ndis802_11Encryption2Enabled ||
+					    Ndis802_11Encryption2Enabled ||
 				    spriv->ndisencryptstatus ==
-				    Ndis802_11Encryption3Enabled)
+					    Ndis802_11Encryption3Enabled)
 					psta->XPrivacy = spriv->PrivacyAlgrthm;
 				if (param->u.crypt.set_tx == 1)
 					handle_pairwise_key(psta, param,
@@ -440,9 +442,9 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 			if (pbcmc_sta) {
 				pbcmc_sta->ieee8021x_blocked = false;
 				if (spriv->ndisencryptstatus ==
-				    Ndis802_11Encryption2Enabled ||
+					    Ndis802_11Encryption2Enabled ||
 				    spriv->ndisencryptstatus ==
-				    Ndis802_11Encryption3Enabled)
+					    Ndis802_11Encryption3Enabled)
 					pbcmc_sta->XPrivacy =
 						spriv->PrivacyAlgrthm;
 			}
@@ -467,87 +469,100 @@ static int r871x_set_wpa_ie(struct _adapter *padapter, char *pie,
 		if (!buf)
 			return -ENOMEM;
 		if (ielen < RSN_HEADER_LEN) {
-			ret  = -EINVAL;
+			ret = -EINVAL;
 			goto exit;
 		}
 		if (r8712_parse_wpa_ie(buf, ielen, &group_cipher,
 				       &pairwise_cipher) == 0) {
 			padapter->securitypriv.AuthAlgrthm = 2;
 			padapter->securitypriv.ndisauthtype =
-				  Ndis802_11AuthModeWPAPSK;
+				Ndis802_11AuthModeWPAPSK;
 		}
 		if (r8712_parse_wpa2_ie(buf, ielen, &group_cipher,
 					&pairwise_cipher) == 0) {
 			padapter->securitypriv.AuthAlgrthm = 2;
 			padapter->securitypriv.ndisauthtype =
-				  Ndis802_11AuthModeWPA2PSK;
+				Ndis802_11AuthModeWPA2PSK;
 		}
 		switch (group_cipher) {
 		case WPA_CIPHER_NONE:
 			padapter->securitypriv.XGrpPrivacy = _NO_PRIVACY_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
+			padapter->securitypriv.ndisencryptstatus =
+				Ndis802_11EncryptionDisabled;
 			break;
 		case WPA_CIPHER_WEP40:
 			padapter->securitypriv.XGrpPrivacy = _WEP40_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
+			padapter->securitypriv.ndisencryptstatus =
+				Ndis802_11Encryption1Enabled;
 			break;
 		case WPA_CIPHER_TKIP:
 			padapter->securitypriv.XGrpPrivacy = _TKIP_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
+			padapter->securitypriv.ndisencryptstatus =
+				Ndis802_11Encryption2Enabled;
 			break;
 		case WPA_CIPHER_CCMP:
 			padapter->securitypriv.XGrpPrivacy = _AES_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
+			padapter->securitypriv.ndisencryptstatus =
+				Ndis802_11Encryption3Enabled;
 			break;
 		case WPA_CIPHER_WEP104:
 			padapter->securitypriv.XGrpPrivacy = _WEP104_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
+			padapter->securitypriv.ndisencryptstatus =
+				Ndis802_11Encryption1Enabled;
 			break;
 		}
 		switch (pairwise_cipher) {
 		case WPA_CIPHER_NONE:
 			padapter->securitypriv.PrivacyAlgrthm = _NO_PRIVACY_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11EncryptionDisabled;
+			padapter->securitypriv.ndisencryptstatus =
+				Ndis802_11EncryptionDisabled;
 			break;
 		case WPA_CIPHER_WEP40:
 			padapter->securitypriv.PrivacyAlgrthm = _WEP40_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
+			padapter->securitypriv.ndisencryptstatus =
+				Ndis802_11Encryption1Enabled;
 			break;
 		case WPA_CIPHER_TKIP:
 			padapter->securitypriv.PrivacyAlgrthm = _TKIP_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption2Enabled;
+			padapter->securitypriv.ndisencryptstatus =
+				Ndis802_11Encryption2Enabled;
 			break;
 		case WPA_CIPHER_CCMP:
 			padapter->securitypriv.PrivacyAlgrthm = _AES_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption3Enabled;
+			padapter->securitypriv.ndisencryptstatus =
+				Ndis802_11Encryption3Enabled;
 			break;
 		case WPA_CIPHER_WEP104:
 			padapter->securitypriv.PrivacyAlgrthm = _WEP104_;
-			padapter->securitypriv.ndisencryptstatus = Ndis802_11Encryption1Enabled;
+			padapter->securitypriv.ndisencryptstatus =
+				Ndis802_11Encryption1Enabled;
 			break;
 		}
 		padapter->securitypriv.wps_phase = false;
-		{/* set wps_ie */
+		{ /* set wps_ie */
 			u16 cnt = 0;
-			u8 eid, wps_oui[4] = {0x0, 0x50, 0xf2, 0x04};
+			u8 eid, wps_oui[4] = { 0x0, 0x50, 0xf2, 0x04 };
 
 			while (cnt < ielen) {
 				eid = buf[cnt];
 
-				if ((eid == WLAN_EID_VENDOR_SPECIFIC) &&
+				if (eid == WLAN_EID_VENDOR_SPECIFIC &&
 				    (!memcmp(&buf[cnt + 2], wps_oui, 4))) {
-					netdev_info(padapter->pnetdev, "r8712u: SET WPS_IE\n");
+					netdev_info(padapter->pnetdev,
+						    "r8712u: SET WPS_IE\n");
 					padapter->securitypriv.wps_ie_len =
-					    ((buf[cnt + 1] + 2) <
-					    (MAX_WPA_IE_LEN << 2)) ?
-					    (buf[cnt + 1] + 2) :
-					    (MAX_WPA_IE_LEN << 2);
+						((buf[cnt + 1] + 2) <
+						 (MAX_WPA_IE_LEN << 2)) ?
+							(buf[cnt + 1] + 2) :
+							(MAX_WPA_IE_LEN << 2);
 					memcpy(padapter->securitypriv.wps_ie,
 					       &buf[cnt],
-					       padapter->securitypriv.wps_ie_len);
-					padapter->securitypriv.wps_phase =
-								 true;
-					netdev_info(padapter->pnetdev, "r8712u: SET WPS_IE, wps_phase==true\n");
+					       padapter->securitypriv
+						       .wps_ie_len);
+					padapter->securitypriv.wps_phase = true;
+					netdev_info(
+						padapter->pnetdev,
+						"r8712u: SET WPS_IE, wps_phase==true\n");
 					cnt += buf[cnt + 1] + 2;
 					break;
 				}
@@ -561,18 +576,20 @@ static int r871x_set_wpa_ie(struct _adapter *padapter, char *pie,
 	return ret;
 }
 
-static int r8711_wx_get_name(struct net_device *dev, struct iw_request_info *info,
+static int r8711_wx_get_name(struct net_device *dev,
+			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	u32 ht_ielen = 0;
 	char *p;
 	u8 ht_cap = false;
-	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct wlan_bssid_ex *pcur_bss = &pmlmepriv->cur_network.network;
 	u8 *prates;
 
-	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE) == true) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE) ==
+	    true) {
 		/* parsing HT_CAP_IE */
 		p = r8712_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY,
 				 &ht_ielen, pcur_bss->IELength - 12);
@@ -581,25 +598,20 @@ static int r8711_wx_get_name(struct net_device *dev, struct iw_request_info *inf
 		prates = pcur_bss->rates;
 		if (r8712_is_cckratesonly_included(prates)) {
 			if (ht_cap)
-				snprintf(wrqu->name, IFNAMSIZ,
-					 "IEEE 802.11bn");
+				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bn");
 			else
-				snprintf(wrqu->name, IFNAMSIZ,
-					 "IEEE 802.11b");
+				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11b");
 		} else if (r8712_is_cckrates_included(prates)) {
 			if (ht_cap)
 				snprintf(wrqu->name, IFNAMSIZ,
 					 "IEEE 802.11bgn");
 			else
-				snprintf(wrqu->name, IFNAMSIZ,
-					 "IEEE 802.11bg");
+				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11bg");
 		} else {
 			if (ht_cap)
-				snprintf(wrqu->name, IFNAMSIZ,
-					 "IEEE 802.11gn");
+				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11gn");
 			else
-				snprintf(wrqu->name, IFNAMSIZ,
-					 "IEEE 802.11g");
+				snprintf(wrqu->name, IFNAMSIZ, "IEEE 802.11g");
 		}
 	} else {
 		snprintf(wrqu->name, IFNAMSIZ, "unassociated");
@@ -608,12 +620,11 @@ static int r8711_wx_get_name(struct net_device *dev, struct iw_request_info *inf
 }
 
 static const long frequency_list[] = {
-	2412, 2417, 2422, 2427, 2432, 2437, 2442, 2447, 2452, 2457, 2462,
-	2467, 2472, 2484, 4915, 4920, 4925, 4935, 4940, 4945, 4960, 4980,
-	5035, 5040, 5045, 5055, 5060, 5080, 5170, 5180, 5190, 5200, 5210,
-	5220, 5230, 5240, 5260, 5280, 5300, 5320, 5500, 5520, 5540, 5560,
-	5580, 5600, 5620, 5640, 5660, 5680, 5700, 5745, 5765, 5785, 5805,
-	5825
+	2412, 2417, 2422, 2427, 2432, 2437, 2442, 2447, 2452, 2457, 2462, 2467,
+	2472, 2484, 4915, 4920, 4925, 4935, 4940, 4945, 4960, 4980, 5035, 5040,
+	5045, 5055, 5060, 5080, 5170, 5180, 5190, 5200, 5210, 5220, 5230, 5240,
+	5260, 5280, 5300, 5320, 5500, 5520, 5540, 5560, 5580, 5600, 5620, 5640,
+	5660, 5680, 5700, 5745, 5765, 5785, 5805, 5825
 };
 
 static int r8711_wx_set_freq(struct net_device *dev,
@@ -624,8 +635,8 @@ static int r8711_wx_set_freq(struct net_device *dev,
 	struct iw_freq *fwrq = &wrqu->freq;
 	int rc = 0;
 
-/* If setting by frequency, convert to a channel */
-	if ((fwrq->e == 1) && (fwrq->m >= 241200000) && (fwrq->m <= 248700000)) {
+	/* If setting by frequency, convert to a channel */
+	if (fwrq->e == 1 && fwrq->m >= 241200000 && fwrq->m <= 248700000) {
 		int f = fwrq->m / 100000;
 		int c = 0;
 
@@ -635,12 +646,12 @@ static int r8711_wx_set_freq(struct net_device *dev,
 		fwrq->m = c + 1;
 	}
 	/* Setting by channel number */
-	if ((fwrq->m > 14) || (fwrq->e > 0)) {
+	if (fwrq->m > 14 || fwrq->e > 0) {
 		rc = -EOPNOTSUPP;
 	} else {
 		int channel = fwrq->m;
 
-		if ((channel < 1) || (channel > 14)) {
+		if (channel < 1 || channel > 14) {
 			rc = -EINVAL;
 		} else {
 			/* Yes ! We can set it !!! */
@@ -650,7 +661,8 @@ static int r8711_wx_set_freq(struct net_device *dev,
 	return rc;
 }
 
-static int r8711_wx_get_freq(struct net_device *dev, struct iw_request_info *info,
+static int r8711_wx_get_freq(struct net_device *dev,
+			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
@@ -660,16 +672,16 @@ static int r8711_wx_get_freq(struct net_device *dev, struct iw_request_info *inf
 	if (!check_fwstate(pmlmepriv, _FW_LINKED))
 		return -ENOLINK;
 
-	wrqu->freq.m = ieee80211_wlan_frequencies[
-		       pcur_bss->Configuration.DSConfig - 1] * 100000;
+	wrqu->freq.m =
+		ieee80211_wlan_frequencies[pcur_bss->Configuration.DSConfig - 1] *
+		100000;
 	wrqu->freq.e = 1;
 	wrqu->freq.i = pcur_bss->Configuration.DSConfig;
 
 	return 0;
 }
 
-static int r8711_wx_set_mode(struct net_device *dev,
-			     struct iw_request_info *a,
+static int r8711_wx_set_mode(struct net_device *dev, struct iw_request_info *a,
 			     union iwreq_data *wrqu, char *b)
 {
 	struct _adapter *padapter = netdev_priv(dev);
@@ -723,14 +735,14 @@ static int r871x_wx_set_pmkid(struct net_device *dev, struct iw_request_info *a,
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	struct iw_pmksa *pPMK = (struct iw_pmksa *) extra;
+	struct iw_pmksa *pPMK = (struct iw_pmksa *)extra;
 	struct RT_PMKID_LIST *pl = psecuritypriv->PMKIDList;
-	u8 strZeroMacAddress[ETH_ALEN] = {0x00};
-	u8 strIssueBssid[ETH_ALEN] = {0x00};
+	u8 strZeroMacAddress[ETH_ALEN] = { 0x00 };
+	u8 strIssueBssid[ETH_ALEN] = { 0x00 };
 	u8 j, blInserted = false;
 	int intReturn = false;
 
-/*
+	/*
  *	There are the BSSID information in the bssid.sa_data array.
  *	If cmd is IW_PMKSA_FLUSH, it means the wpa_supplicant wants to clear
  *	all the PMKID information. If cmd is IW_PMKSA_ADD, it means the
@@ -753,8 +765,10 @@ static int r871x_wx_set_pmkid(struct net_device *dev, struct iw_request_info *a,
 				/* BSSID is matched, the same AP => rewrite
 				 * with new PMKID.
 				 */
-				netdev_info(dev, "r8712u: %s: BSSID exists in the PMKList.\n",
-					    __func__);
+				netdev_info(
+					dev,
+					"r8712u: %s: BSSID exists in the PMKList.\n",
+					__func__);
 				memcpy(pl[j].PMKID, pPMK->pmkid, IW_PMKID_LEN);
 				pl[j].bUsed = true;
 				psecuritypriv->PMKIDIndex = j + 1;
@@ -764,12 +778,14 @@ static int r871x_wx_set_pmkid(struct net_device *dev, struct iw_request_info *a,
 		}
 		if (!blInserted) {
 			/* Find a new entry */
-			netdev_info(dev, "r8712u: %s: Use the new entry index = %d for this PMKID.\n",
-				    __func__, psecuritypriv->PMKIDIndex);
+			netdev_info(
+				dev,
+				"r8712u: %s: Use the new entry index = %d for this PMKID.\n",
+				__func__, psecuritypriv->PMKIDIndex);
 			memcpy(pl[psecuritypriv->PMKIDIndex].Bssid,
 			       strIssueBssid, ETH_ALEN);
-			memcpy(pl[psecuritypriv->PMKIDIndex].PMKID,
-			       pPMK->pmkid, IW_PMKID_LEN);
+			memcpy(pl[psecuritypriv->PMKIDIndex].PMKID, pPMK->pmkid,
+			       IW_PMKID_LEN);
 			pl[psecuritypriv->PMKIDIndex].bUsed = true;
 			psecuritypriv->PMKIDIndex++;
 			if (psecuritypriv->PMKIDIndex == NUM_PMKID_CACHE)
@@ -808,12 +824,13 @@ static int r8711_wx_get_sens(struct net_device *dev,
 			     union iwreq_data *wrqu, char *extra)
 {
 	wrqu->sens.value = 0;
-	wrqu->sens.fixed = 0;	/* no auto select */
+	wrqu->sens.fixed = 0; /* no auto select */
 	wrqu->sens.disabled = 1;
 	return 0;
 }
 
-static int r8711_wx_get_range(struct net_device *dev, struct iw_request_info *info,
+static int r8711_wx_get_range(struct net_device *dev,
+			      struct iw_request_info *info,
 			      union iwreq_data *wrqu, char *extra)
 {
 	struct iw_range *range = (struct iw_range *)extra;
@@ -862,10 +879,8 @@ static int r8711_wx_get_range(struct net_device *dev, struct iw_request_info *in
 			break;
 	}
 	range->num_frequency = val;
-	range->enc_capa = IW_ENC_CAPA_WPA |
-			  IW_ENC_CAPA_WPA2 |
-			  IW_ENC_CAPA_CIPHER_TKIP |
-			  IW_ENC_CAPA_CIPHER_CCMP;
+	range->enc_capa = IW_ENC_CAPA_WPA | IW_ENC_CAPA_WPA2 |
+			  IW_ENC_CAPA_CIPHER_TKIP | IW_ENC_CAPA_CIPHER_CCMP;
 	return 0;
 }
 
@@ -875,8 +890,7 @@ static int r8711_wx_get_rate(struct net_device *dev,
 
 static int r871x_wx_set_priv(struct net_device *dev,
 			     struct iw_request_info *info,
-			     union iwreq_data *awrq,
-			     char *extra)
+			     union iwreq_data *awrq, char *extra)
 {
 	int ret = 0, len = 0;
 	char *ext;
@@ -892,7 +906,7 @@ static int r871x_wx_set_priv(struct net_device *dev,
 		/*Return received signal strength indicator in -db for */
 		/* current AP */
 		/*<ssid> Rssi xx */
-		struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+		struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 		struct wlan_network *pcur_network = &pmlmepriv->cur_network;
 		/*static u8 xxxx; */
 		if (check_fwstate(pmlmepriv, _FW_LINKED)) {
@@ -901,7 +915,7 @@ static int r871x_wx_set_priv(struct net_device *dev,
 				/*(xxxx=xxxx+10) */
 				((padapter->recvpriv.fw_rssi) >> 1) - 95
 				/*pcur_network->network.Rssi */
-				);
+			);
 		} else {
 			sprintf(ext, "OK");
 		}
@@ -939,28 +953,34 @@ static int r871x_wx_set_priv(struct net_device *dev,
 	} else if (!strncmp(ext, "DCE-E", 5)) {
 		/*Set scan type to passive */
 		/*OK if successful */
-		r8712_disconnectCtrlEx_cmd(padapter
-			, 1 /*u32 enableDrvCtrl */
-			, 5 /*u32 tryPktCnt */
-			, 100 /*u32 tryPktInterval */
-			, 5000 /*u32 firstStageTO */
+		r8712_disconnectCtrlEx_cmd(padapter, 1 /*u32 enableDrvCtrl */
+					   ,
+					   5 /*u32 tryPktCnt */
+					   ,
+					   100 /*u32 tryPktInterval */
+					   ,
+					   5000 /*u32 firstStageTO */
 		);
 		sprintf(ext, "OK");
 	} else if (!strncmp(ext, "DCE-D", 5)) {
 		/*Set scan type to passive */
 		/*OK if successfu */
-		r8712_disconnectCtrlEx_cmd(padapter
-			, 0 /*u32 enableDrvCtrl */
-			, 5 /*u32 tryPktCnt */
-			, 100 /*u32 tryPktInterval */
-			, 5000 /*u32 firstStageTO */
+		r8712_disconnectCtrlEx_cmd(padapter, 0 /*u32 enableDrvCtrl */
+					   ,
+					   5 /*u32 tryPktCnt */
+					   ,
+					   100 /*u32 tryPktInterval */
+					   ,
+					   5000 /*u32 firstStageTO */
 		);
 		sprintf(ext, "OK");
 	} else {
-		netdev_info(dev, "r8712u: %s: unknown Command %s.\n", __func__, ext);
+		netdev_info(dev, "r8712u: %s: unknown Command %s.\n", __func__,
+			    ext);
 		goto FREE_EXT;
 	}
-	if (copy_to_user(dwrq->pointer, ext, min(dwrq->length, (__u16)(strlen(ext) + 1))))
+	if (copy_to_user(dwrq->pointer, ext,
+			 min(dwrq->length, (__u16)(strlen(ext) + 1))))
 		ret = -EFAULT;
 
 FREE_EXT:
@@ -981,19 +1001,20 @@ static int r871x_wx_set_priv(struct net_device *dev,
  * For this operation to succeed, there is no need for the interface to be up.
  *
  */
-static int r8711_wx_set_wap(struct net_device *dev, struct iw_request_info *info,
+static int r8711_wx_set_wap(struct net_device *dev,
+			    struct iw_request_info *info,
 			    union iwreq_data *awrq, char *extra)
 {
 	int ret = -EINPROGRESS;
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct  __queue *queue = &pmlmepriv->scanned_queue;
+	struct __queue *queue = &pmlmepriv->scanned_queue;
 	struct sockaddr *temp = (struct sockaddr *)awrq;
 	unsigned long irqL;
 	struct list_head *phead;
 	u8 *dst_bssid;
 	struct wlan_network *pnetwork = NULL;
-	enum NDIS_802_11_AUTHENTICATION_MODE	authmode;
+	enum NDIS_802_11_AUTHENTICATION_MODE authmode;
 
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		return -EBUSY;
@@ -1013,8 +1034,8 @@ static int r8711_wx_set_wap(struct net_device *dev, struct iw_request_info *info
 		pmlmepriv->pscanned = pmlmepriv->pscanned->next;
 		dst_bssid = pnetwork->network.MacAddress;
 		if (!memcmp(dst_bssid, temp->sa_data, ETH_ALEN)) {
-			r8712_set_802_11_infrastructure_mode(padapter,
-			    pnetwork->network.InfrastructureMode);
+			r8712_set_802_11_infrastructure_mode(
+				padapter, pnetwork->network.InfrastructureMode);
 			break;
 		}
 	}
@@ -1030,7 +1051,8 @@ static int r8711_wx_set_wap(struct net_device *dev, struct iw_request_info *info
 	return ret;
 }
 
-static int r8711_wx_get_wap(struct net_device *dev, struct iw_request_info *info,
+static int r8711_wx_get_wap(struct net_device *dev,
+			    struct iw_request_info *info,
 			    union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
@@ -1038,7 +1060,8 @@ static int r8711_wx_get_wap(struct net_device *dev, struct iw_request_info *info
 	struct wlan_bssid_ex *pcur_bss = &pmlmepriv->cur_network.network;
 
 	wrqu->ap_addr.sa_family = ARPHRD_ETHER;
-	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE | WIFI_AP_STATE))
+	if (check_fwstate(pmlmepriv,
+			  _FW_LINKED | WIFI_ADHOC_MASTER_STATE | WIFI_AP_STATE))
 		ether_addr_copy(wrqu->ap_addr.sa_data, pcur_bss->MacAddress);
 	else
 		eth_zero_addr(wrqu->ap_addr.sa_data);
@@ -1051,7 +1074,7 @@ static int r871x_wx_set_mlme(struct net_device *dev,
 {
 	int ret = 0;
 	struct _adapter *padapter = netdev_priv(dev);
-	struct iw_mlme *mlme = (struct iw_mlme *) extra;
+	struct iw_mlme *mlme = (struct iw_mlme *)extra;
 
 	if (!mlme)
 		return -1;
@@ -1086,16 +1109,16 @@ static int r8711_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 	u8 status = true;
 
 	if (padapter->driver_stopped) {
-		netdev_info(dev, "In %s: driver_stopped=%d\n",
-			    __func__, padapter->driver_stopped);
+		netdev_info(dev, "In %s: driver_stopped=%d\n", __func__,
+			    padapter->driver_stopped);
 		return -1;
 	}
 	if (!padapter->bup)
 		return -ENETDOWN;
 	if (!padapter->hw_init_completed)
 		return -1;
-	if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING)) ||
-	    (pmlmepriv->sitesurveyctrl.traffic_busy))
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) ||
+	    pmlmepriv->sitesurveyctrl.traffic_busy)
 		return 0;
 	if (wrqu->data.length == sizeof(struct iw_scan_req)) {
 		struct iw_scan_req *req = (struct iw_scan_req *)extra;
@@ -1105,13 +1128,15 @@ static int r8711_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
 			unsigned long irqL;
 			u32 len = min_t(u8, req->essid_len, IW_ESSID_MAX_SIZE);
 
-			memset((unsigned char *)&ssid, 0, sizeof(struct ndis_802_11_ssid));
+			memset((unsigned char *)&ssid, 0,
+			       sizeof(struct ndis_802_11_ssid));
 			memcpy(ssid.Ssid, req->essid, len);
 			ssid.SsidLength = len;
 			spin_lock_irqsave(&pmlmepriv->lock, irqL);
-			if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY |
-			     _FW_UNDER_LINKING)) ||
-			    (pmlmepriv->sitesurveyctrl.traffic_busy)) {
+			if ((check_fwstate(pmlmepriv,
+					   _FW_UNDER_SURVEY |
+						   _FW_UNDER_LINKING)) ||
+			    pmlmepriv->sitesurveyctrl.traffic_busy) {
 				if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 					status = false;
 			} else {
@@ -1132,7 +1157,7 @@ static int r8711_wx_get_scan(struct net_device *dev, struct iw_request_info *a,
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct  __queue *queue = &pmlmepriv->scanned_queue;
+	struct __queue *queue = &pmlmepriv->scanned_queue;
 	struct wlan_network *pnetwork = NULL;
 	unsigned long irqL;
 	struct list_head *plist, *phead;
@@ -1185,9 +1210,9 @@ static int r8711_wx_set_essid(struct net_device *dev, struct iw_request_info *a,
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct  __queue *queue = &pmlmepriv->scanned_queue;
+	struct __queue *queue = &pmlmepriv->scanned_queue;
 	struct wlan_network *pnetwork = NULL;
-	enum NDIS_802_11_AUTHENTICATION_MODE	authmode;
+	enum NDIS_802_11_AUTHENTICATION_MODE authmode;
 	struct ndis_802_11_ssid ndis_ssid;
 	u8 *dst_ssid, *src_ssid;
 	struct list_head *phead;
@@ -1202,7 +1227,8 @@ static int r8711_wx_set_essid(struct net_device *dev, struct iw_request_info *a,
 	authmode = padapter->securitypriv.ndisauthtype;
 	if (wrqu->essid.flags && wrqu->essid.length) {
 		len = (wrqu->essid.length < IW_ESSID_MAX_SIZE) ?
-		       wrqu->essid.length : IW_ESSID_MAX_SIZE;
+			      wrqu->essid.length :
+			      IW_ESSID_MAX_SIZE;
 		memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
 		ndis_ssid.SsidLength = len;
 		memcpy(ndis_ssid.Ssid, extra, len);
@@ -1216,22 +1242,21 @@ static int r8711_wx_set_essid(struct net_device *dev, struct iw_request_info *a,
 						struct wlan_network, list);
 			pmlmepriv->pscanned = pmlmepriv->pscanned->next;
 			dst_ssid = pnetwork->network.Ssid.Ssid;
-			if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength))
-			    && (pnetwork->network.Ssid.SsidLength ==
-			     ndis_ssid.SsidLength)) {
-				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
-					if (pnetwork->network.
-						InfrastructureMode
-						!=
-						padapter->mlmepriv.
-						cur_network.network.
-						InfrastructureMode)
+			if (!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength) &&
+			    pnetwork->network.Ssid.SsidLength ==
+				    ndis_ssid.SsidLength) {
+				if (check_fwstate(pmlmepriv,
+						  WIFI_ADHOC_STATE)) {
+					if (pnetwork->network
+						    .InfrastructureMode !=
+					    padapter->mlmepriv.cur_network
+						    .network.InfrastructureMode)
 						continue;
 				}
 
 				r8712_set_802_11_infrastructure_mode(
-				     padapter,
-				     pnetwork->network.InfrastructureMode);
+					padapter,
+					pnetwork->network.InfrastructureMode);
 				break;
 			}
 		}
@@ -1268,7 +1293,7 @@ static int r8711_wx_set_rate(struct net_device *dev, struct iw_request_info *a,
 	u32 fixed = wrqu->bitrate.fixed;
 	u32 ratevalue = 0;
 	u8 datarates[NumRates];
-	u8 mpdatarate[NumRates] = {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff};
+	u8 mpdatarate[NumRates] = { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff };
 	int i;
 
 	if (target_rate == -1) {
@@ -1330,7 +1355,8 @@ static int r8711_wx_set_rate(struct net_device *dev, struct iw_request_info *a,
 	return r8712_setdatarate_cmd(padapter, datarates);
 }
 
-static int r8711_wx_get_rate(struct net_device *dev, struct iw_request_info *info,
+static int r8711_wx_get_rate(struct net_device *dev,
+			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
@@ -1355,46 +1381,50 @@ static int r8711_wx_get_rate(struct net_device *dev, struct iw_request_info *inf
 		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 		memcpy(&mcs_rate, &pht_capie->mcs, 2);
 		bw_40MHz = (le16_to_cpu(pht_capie->cap_info) &
-			    IEEE80211_HT_CAP_SUP_WIDTH_20_40) ? 1 : 0;
-		short_GI = (le16_to_cpu(pht_capie->cap_info) &
-			    (IEEE80211_HT_CAP_SGI_20 |
-			    IEEE80211_HT_CAP_SGI_40)) ? 1 : 0;
-	}
-	while ((pcur_bss->rates[i] != 0) &&
-	       (pcur_bss->rates[i] != 0xFF)) {
+			    IEEE80211_HT_CAP_SUP_WIDTH_20_40) ?
+				   1 :
+				   0;
+		short_GI =
+			(le16_to_cpu(pht_capie->cap_info) &
+			 (IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40)) ?
+				1 :
+				0;
+	}
+	while ((pcur_bss->rates[i] != 0) && (pcur_bss->rates[i] != 0xFF)) {
 		rate = pcur_bss->rates[i] & 0x7F;
 		if (rate > max_rate)
 			max_rate = rate;
-		wrqu->bitrate.fixed = 0;	/* no auto select */
+		wrqu->bitrate.fixed = 0; /* no auto select */
 		wrqu->bitrate.value = rate * 500000;
 		i++;
 	}
 	if (ht_cap) {
 		if (mcs_rate & 0x8000 /* MCS15 */
-		    &&
-		    rf_type == RTL8712_RF_2T2R)
+		    && rf_type == RTL8712_RF_2T2R)
 			max_rate = (bw_40MHz) ? ((short_GI) ? 300 : 270) :
-			((short_GI) ? 144 : 130);
+						((short_GI) ? 144 : 130);
 		else /* default MCS7 */
 			max_rate = (bw_40MHz) ? ((short_GI) ? 150 : 135) :
-			((short_GI) ? 72 : 65);
+						((short_GI) ? 72 : 65);
 		max_rate *= 2; /* Mbps/2 */
 	}
 	wrqu->bitrate.value = max_rate * 500000;
 	return 0;
 }
 
-static int r8711_wx_get_rts(struct net_device *dev, struct iw_request_info *info,
+static int r8711_wx_get_rts(struct net_device *dev,
+			    struct iw_request_info *info,
 			    union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 
 	wrqu->rts.value = padapter->registrypriv.rts_thresh;
-	wrqu->rts.fixed = 0;	/* no auto select */
+	wrqu->rts.fixed = 0; /* no auto select */
 	return 0;
 }
 
-static int r8711_wx_set_frag(struct net_device *dev, struct iw_request_info *info,
+static int r8711_wx_set_frag(struct net_device *dev,
+			     struct iw_request_info *info,
 			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
@@ -1411,33 +1441,33 @@ static int r8711_wx_set_frag(struct net_device *dev, struct iw_request_info *inf
 }
 
 static int r8711_wx_get_frag(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 
 	wrqu->frag.value = padapter->xmitpriv.frag_len;
-	wrqu->frag.fixed = 0;	/* no auto select */
+	wrqu->frag.fixed = 0; /* no auto select */
 	return 0;
 }
 
 static int r8711_wx_get_retry(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 {
 	wrqu->retry.value = 7;
-	wrqu->retry.fixed = 0;	/* no auto select */
+	wrqu->retry.fixed = 0; /* no auto select */
 	wrqu->retry.disabled = 1;
 	return 0;
 }
 
 static int r8711_wx_set_enc(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *keybuf)
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *keybuf)
 {
 	u32 key;
 	u32 keyindex_provided;
-	struct NDIS_802_11_WEP	 wep;
+	struct NDIS_802_11_WEP wep;
 	enum NDIS_802_11_AUTHENTICATION_MODE authmode;
 	struct iw_point *erq = &wrqu->encoding;
 	struct _adapter *padapter = netdev_priv(dev);
@@ -1447,7 +1477,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 	if (erq->flags & IW_ENCODE_DISABLED) {
 		netdev_info(dev, "r8712u: %s: EncryptionDisabled\n", __func__);
 		padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11EncryptionDisabled;
+			Ndis802_11EncryptionDisabled;
 		padapter->securitypriv.PrivacyAlgrthm = _NO_PRIVACY_;
 		padapter->securitypriv.XGrpPrivacy = _NO_PRIVACY_;
 		padapter->securitypriv.AuthAlgrthm = 0; /* open system */
@@ -1468,17 +1498,17 @@ static int r8711_wx_set_enc(struct net_device *dev,
 	if (erq->flags & IW_ENCODE_OPEN) {
 		netdev_info(dev, "r8712u: %s: IW_ENCODE_OPEN\n", __func__);
 		padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11Encryption1Enabled;
+			Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.AuthAlgrthm = 0; /* open system */
 		padapter->securitypriv.PrivacyAlgrthm = _NO_PRIVACY_;
 		padapter->securitypriv.XGrpPrivacy = _NO_PRIVACY_;
 		authmode = Ndis802_11AuthModeOpen;
 		padapter->securitypriv.ndisauthtype = authmode;
 	} else if (erq->flags & IW_ENCODE_RESTRICTED) {
-		netdev_info(dev,
-				"r8712u: %s: IW_ENCODE_RESTRICTED\n", __func__);
+		netdev_info(dev, "r8712u: %s: IW_ENCODE_RESTRICTED\n",
+			    __func__);
 		padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11Encryption1Enabled;
+			Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.AuthAlgrthm = 1; /* shared system */
 		padapter->securitypriv.PrivacyAlgrthm = _WEP40_;
 		padapter->securitypriv.XGrpPrivacy = _WEP40_;
@@ -1486,7 +1516,7 @@ static int r8711_wx_set_enc(struct net_device *dev,
 		padapter->securitypriv.ndisauthtype = authmode;
 	} else {
 		padapter->securitypriv.ndisencryptstatus =
-				 Ndis802_11Encryption1Enabled;
+			Ndis802_11Encryption1Enabled;
 		padapter->securitypriv.AuthAlgrthm = 0; /* open system */
 		padapter->securitypriv.PrivacyAlgrthm = _NO_PRIVACY_;
 		padapter->securitypriv.XGrpPrivacy = _NO_PRIVACY_;
@@ -1506,22 +1536,21 @@ static int r8711_wx_set_enc(struct net_device *dev,
 			padapter->securitypriv.PrivacyKeyIndex = key;
 			switch (padapter->securitypriv.DefKeylen[key]) {
 			case 5:
-				padapter->securitypriv.PrivacyAlgrthm =
-						 _WEP40_;
+				padapter->securitypriv.PrivacyAlgrthm = _WEP40_;
 				break;
 			case 13:
 				padapter->securitypriv.PrivacyAlgrthm =
-						 _WEP104_;
+					_WEP104_;
 				break;
 			default:
 				padapter->securitypriv.PrivacyAlgrthm =
-						 _NO_PRIVACY_;
+					_NO_PRIVACY_;
 				break;
 			}
 			return 0;
 		}
 	}
-	wep.KeyIndex |= 0x80000000;	/* transmit key */
+	wep.KeyIndex |= 0x80000000; /* transmit key */
 	memcpy(wep.KeyMaterial, keybuf, wep.KeyLength);
 	if (r8712_set_802_11_add_wep(padapter, &wep))
 		return -EOPNOTSUPP;
@@ -1529,13 +1558,13 @@ static int r8711_wx_set_enc(struct net_device *dev,
 }
 
 static int r8711_wx_get_enc(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *keybuf)
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *keybuf)
 {
 	uint key;
 	struct _adapter *padapter = netdev_priv(dev);
 	struct iw_point *erq = &wrqu->encoding;
-	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	union Keytype *dk = padapter->securitypriv.DefKey;
 
 	if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
@@ -1580,8 +1609,8 @@ static int r8711_wx_get_enc(struct net_device *dev,
 	case Ndis802_11Encryption2Enabled:
 	case Ndis802_11Encryption3Enabled:
 		erq->length = 16;
-		erq->flags |= (IW_ENCODE_ENABLED | IW_ENCODE_OPEN |
-			       IW_ENCODE_NOKEY);
+		erq->flags |=
+			(IW_ENCODE_ENABLED | IW_ENCODE_OPEN | IW_ENCODE_NOKEY);
 		break;
 	default:
 		erq->length = 0;
@@ -1592,18 +1621,18 @@ static int r8711_wx_get_enc(struct net_device *dev,
 }
 
 static int r8711_wx_get_power(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 {
 	wrqu->power.value = 0;
-	wrqu->power.fixed = 0;	/* no auto select */
+	wrqu->power.fixed = 0; /* no auto select */
 	wrqu->power.disabled = 1;
 	return 0;
 }
 
 static int r871x_wx_set_gen_ie(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			       struct iw_request_info *info,
+			       union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 
@@ -1611,8 +1640,8 @@ static int r871x_wx_set_gen_ie(struct net_device *dev,
 }
 
 static int r871x_wx_set_auth(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct iw_param *param = (struct iw_param *)&wrqu->param;
@@ -1667,14 +1696,12 @@ static int r871x_wx_set_auth(struct net_device *dev,
 
 		if (paramval) {
 			padapter->securitypriv.ndisencryptstatus =
-				   Ndis802_11EncryptionDisabled;
-			padapter->securitypriv.PrivacyAlgrthm =
-				  _NO_PRIVACY_;
-			padapter->securitypriv.XGrpPrivacy =
-				  _NO_PRIVACY_;
+				Ndis802_11EncryptionDisabled;
+			padapter->securitypriv.PrivacyAlgrthm = _NO_PRIVACY_;
+			padapter->securitypriv.XGrpPrivacy = _NO_PRIVACY_;
 			padapter->securitypriv.AuthAlgrthm = 0;
 			padapter->securitypriv.ndisauthtype =
-				  Ndis802_11AuthModeOpen;
+				Ndis802_11AuthModeOpen;
 		}
 		break;
 	case IW_AUTH_80211_AUTH_ALG:
@@ -1694,8 +1721,8 @@ static int r871x_wx_set_auth(struct net_device *dev,
 }
 
 static int r871x_wx_set_enc_ext(struct net_device *dev,
-			     struct iw_request_info *info,
-			     union iwreq_data *wrqu, char *extra)
+				struct iw_request_info *info,
+				union iwreq_data *wrqu, char *extra)
 {
 	struct iw_point *pencoding = &wrqu->encoding;
 	struct iw_encode_ext *pext = (struct iw_encode_ext *)extra;
@@ -1756,9 +1783,8 @@ static int r871x_wx_get_nick(struct net_device *dev,
 	return 0;
 }
 
-static int r8711_wx_read32(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *keybuf)
+static int r8711_wx_read32(struct net_device *dev, struct iw_request_info *info,
+			   union iwreq_data *wrqu, char *keybuf)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	u32 addr;
@@ -1774,8 +1800,8 @@ static int r8711_wx_read32(struct net_device *dev,
 }
 
 static int r8711_wx_write32(struct net_device *dev,
-				 struct iw_request_info *info,
-				 union iwreq_data *wrqu, char *keybuf)
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *keybuf)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	u32 addr;
@@ -1787,23 +1813,22 @@ static int r8711_wx_write32(struct net_device *dev,
 	return 0;
 }
 
-static int dummy(struct net_device *dev,
-		struct iw_request_info *a,
-		union iwreq_data *wrqu, char *b)
+static int dummy(struct net_device *dev, struct iw_request_info *a,
+		 union iwreq_data *wrqu, char *b)
 {
 	return -EINVAL;
 }
 
 static int r8711_drvext_hdl(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *extra)
 {
 	return 0;
 }
 
 static int r871x_mp_ioctl_hdl(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			      struct iw_request_info *info,
+			      union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct iw_point *p = &wrqu->data;
@@ -1816,7 +1841,7 @@ static int r871x_mp_ioctl_hdl(struct net_device *dev,
 	uint status;
 	int ret = 0;
 
-	if ((!p->length) || (!p->pointer))
+	if (!p->length || !p->pointer)
 		return -EINVAL;
 
 	bset = (u8)(p->flags & 0xFFFF);
@@ -1831,8 +1856,7 @@ static int r871x_mp_ioctl_hdl(struct net_device *dev,
 		goto _r871x_mp_ioctl_hdl_exit;
 	}
 	phandler = mp_ioctl_hdl + poidparam->subcode;
-	if ((phandler->paramsize != 0) &&
-	    (poidparam->len < phandler->paramsize)) {
+	if (phandler->paramsize != 0 && poidparam->len < phandler->paramsize) {
 		ret = -EINVAL;
 		goto _r871x_mp_ioctl_hdl_exit;
 	}
@@ -1858,9 +1882,11 @@ static int r871x_mp_ioctl_hdl(struct net_device *dev,
 		status = phandler->handler(&oid_par);
 		/* todo:check status, BytesNeeded, etc. */
 	} else {
-		netdev_info(dev, "r8712u: %s: err!, subcode=%d, oid=%d, handler=%p\n",
-			    __func__, poidparam->subcode, phandler->oid,
-			    phandler->handler);
+		netdev_info(
+			dev,
+			"r8712u: %s: err!, subcode=%d, oid=%d, handler=%p\n",
+			__func__, poidparam->subcode, phandler->oid,
+			phandler->handler);
 		ret = -EFAULT;
 		goto _r871x_mp_ioctl_hdl_exit;
 	}
@@ -1878,12 +1904,12 @@ static int r871x_mp_ioctl_hdl(struct net_device *dev,
 }
 
 static int r871x_get_ap_info(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			     struct iw_request_info *info,
+			     union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct  __queue *queue = &pmlmepriv->scanned_queue;
+	struct __queue *queue = &pmlmepriv->scanned_queue;
 	struct iw_point *pdata = &wrqu->data;
 	struct wlan_network *pnetwork = NULL;
 	u32 cnt = 0, wpa_ielen;
@@ -1895,8 +1921,7 @@ static int r871x_get_ap_info(struct net_device *dev,
 
 	if (padapter->driver_stopped || !pdata)
 		return -EINVAL;
-	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY |
-			     _FW_UNDER_LINKING)) {
+	while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING)) {
 		msleep(30);
 		cnt++;
 		if (cnt > 100)
@@ -1926,15 +1951,17 @@ static int r871x_get_ap_info(struct net_device *dev,
 		netdev_info(dev, "r8712u: BSSID:%pM\n", bssid);
 		if (ether_addr_equal(bssid, pnetwork->network.MacAddress)) {
 			/* BSSID match, then check if supporting wpa/wpa2 */
-			pbuf = r8712_get_wpa_ie(&pnetwork->network.IEs[12],
-			       &wpa_ielen, pnetwork->network.IELength - 12);
-			if (pbuf && (wpa_ielen > 0)) {
+			pbuf = r8712_get_wpa_ie(
+				&pnetwork->network.IEs[12], &wpa_ielen,
+				pnetwork->network.IELength - 12);
+			if (pbuf && wpa_ielen > 0) {
 				pdata->flags = 1;
 				break;
 			}
-			pbuf = r8712_get_wpa2_ie(&pnetwork->network.IEs[12],
-			       &wpa_ielen, pnetwork->network.IELength - 12);
-			if (pbuf && (wpa_ielen > 0)) {
+			pbuf = r8712_get_wpa2_ie(
+				&pnetwork->network.IEs[12], &wpa_ielen,
+				pnetwork->network.IELength - 12);
+			if (pbuf && wpa_ielen > 0) {
 				pdata->flags = 2;
 				break;
 			}
@@ -1944,15 +1971,14 @@ static int r871x_get_ap_info(struct net_device *dev,
 	spin_unlock_irqrestore(&pmlmepriv->scanned_queue.lock, irqL);
 	if (pdata->length >= 34) {
 		if (copy_to_user((u8 __user *)pdata->pointer + 32,
-		    (u8 *)&pdata->flags, 1))
+				 (u8 *)&pdata->flags, 1))
 			return -EINVAL;
 	}
 	return 0;
 }
 
-static int r871x_set_pid(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+static int r871x_set_pid(struct net_device *dev, struct iw_request_info *info,
+			 union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct iw_point *pdata = &wrqu->data;
@@ -1965,8 +1991,8 @@ static int r871x_set_pid(struct net_device *dev,
 }
 
 static int r871x_set_chplan(struct net_device *dev,
-				struct iw_request_info *info,
-				union iwreq_data *wrqu, char *extra)
+			    struct iw_request_info *info,
+			    union iwreq_data *wrqu, char *extra)
 {
 	int ret = 0;
 	struct _adapter *padapter = netdev_priv(dev);
@@ -1985,13 +2011,12 @@ static int r871x_set_chplan(struct net_device *dev,
 	return ret;
 }
 
-static int r871x_wps_start(struct net_device *dev,
-			   struct iw_request_info *info,
+static int r871x_wps_start(struct net_device *dev, struct iw_request_info *info,
 			   union iwreq_data *wrqu, char *extra)
 {
 	struct _adapter *padapter = netdev_priv(dev);
 	struct iw_point *pdata = &wrqu->data;
-	u32   u32wps_start = 0;
+	u32 u32wps_start = 0;
 
 	if (padapter->driver_stopped || !pdata)
 		return -EINVAL;
@@ -2001,13 +2026,12 @@ static int r871x_wps_start(struct net_device *dev,
 		u32wps_start = *extra;
 	if (u32wps_start == 1) /* WPS Start */
 		padapter->ledpriv.LedControlHandler(padapter,
-			   LED_CTL_START_WPS);
+						    LED_CTL_START_WPS);
 	else if (u32wps_start == 2) /* WPS Stop because of wps success */
-		padapter->ledpriv.LedControlHandler(padapter,
-			   LED_CTL_STOP_WPS);
+		padapter->ledpriv.LedControlHandler(padapter, LED_CTL_STOP_WPS);
 	else if (u32wps_start == 3) /* WPS Stop because of wps fail */
 		padapter->ledpriv.LedControlHandler(padapter,
-			   LED_CTL_STOP_WPS_FAIL);
+						    LED_CTL_STOP_WPS_FAIL);
 	return 0;
 }
 
@@ -2096,18 +2120,18 @@ static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point *p)
 	switch (param->cmd) {
 	case IEEE_CMD_SET_WPA_PARAM:
 		ret = wpa_set_param(dev, param->u.wpa_param.name,
-		      param->u.wpa_param.value);
+				    param->u.wpa_param.value);
 		break;
 	case IEEE_CMD_SET_WPA_IE:
-		ret =  r871x_set_wpa_ie(padapter, (char *)param->u.wpa_ie.data,
-		       (u16)param->u.wpa_ie.len);
+		ret = r871x_set_wpa_ie(padapter, (char *)param->u.wpa_ie.data,
+				       (u16)param->u.wpa_ie.len);
 		break;
 	case IEEE_CMD_SET_ENCRYPTION:
 		ret = wpa_set_encryption(dev, param, p->length);
 		break;
 	case IEEE_CMD_MLME:
 		ret = wpa_mlme(dev, param->u.mlme.command,
-		      param->u.mlme.reason_code);
+			       param->u.mlme.reason_code);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
@@ -2134,108 +2158,87 @@ int r871x_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 }
 
 static iw_handler r8711_handlers[] = {
-	NULL,				/* SIOCSIWCOMMIT */
-	r8711_wx_get_name,		/* SIOCGIWNAME */
-	dummy,				/* SIOCSIWNWID */
-	dummy,				/* SIOCGIWNWID */
-	r8711_wx_set_freq,		/* SIOCSIWFREQ */
-	r8711_wx_get_freq,		/* SIOCGIWFREQ */
-	r8711_wx_set_mode,		/* SIOCSIWMODE */
-	r8711_wx_get_mode,		/* SIOCGIWMODE */
-	dummy,				/* SIOCSIWSENS */
-	r8711_wx_get_sens,		/* SIOCGIWSENS */
-	NULL,				/* SIOCSIWRANGE */
-	r8711_wx_get_range,		/* SIOCGIWRANGE */
-	r871x_wx_set_priv,		/* SIOCSIWPRIV */
-	NULL,				/* SIOCGIWPRIV */
-	NULL,				/* SIOCSIWSTATS */
-	NULL,				/* SIOCGIWSTATS */
-	dummy,				/* SIOCSIWSPY */
-	dummy,				/* SIOCGIWSPY */
-	NULL,				/* SIOCGIWTHRSPY */
-	NULL,				/* SIOCWIWTHRSPY */
-	r8711_wx_set_wap,		/* SIOCSIWAP */
-	r8711_wx_get_wap,		/* SIOCGIWAP */
-	r871x_wx_set_mlme,		/* request MLME operation;
+	NULL, /* SIOCSIWCOMMIT */
+	r8711_wx_get_name, /* SIOCGIWNAME */
+	dummy, /* SIOCSIWNWID */
+	dummy, /* SIOCGIWNWID */
+	r8711_wx_set_freq, /* SIOCSIWFREQ */
+	r8711_wx_get_freq, /* SIOCGIWFREQ */
+	r8711_wx_set_mode, /* SIOCSIWMODE */
+	r8711_wx_get_mode, /* SIOCGIWMODE */
+	dummy, /* SIOCSIWSENS */
+	r8711_wx_get_sens, /* SIOCGIWSENS */
+	NULL, /* SIOCSIWRANGE */
+	r8711_wx_get_range, /* SIOCGIWRANGE */
+	r871x_wx_set_priv, /* SIOCSIWPRIV */
+	NULL, /* SIOCGIWPRIV */
+	NULL, /* SIOCSIWSTATS */
+	NULL, /* SIOCGIWSTATS */
+	dummy, /* SIOCSIWSPY */
+	dummy, /* SIOCGIWSPY */
+	NULL, /* SIOCGIWTHRSPY */
+	NULL, /* SIOCWIWTHRSPY */
+	r8711_wx_set_wap, /* SIOCSIWAP */
+	r8711_wx_get_wap, /* SIOCGIWAP */
+	r871x_wx_set_mlme, /* request MLME operation;
 					 *  uses struct iw_mlme
 					 */
-	dummy,				/* SIOCGIWAPLIST -- deprecated */
-	r8711_wx_set_scan,		/* SIOCSIWSCAN */
-	r8711_wx_get_scan,		/* SIOCGIWSCAN */
-	r8711_wx_set_essid,		/* SIOCSIWESSID */
-	r8711_wx_get_essid,		/* SIOCGIWESSID */
-	dummy,				/* SIOCSIWNICKN */
-	r871x_wx_get_nick,		/* SIOCGIWNICKN */
-	NULL,				/* -- hole -- */
-	NULL,				/* -- hole -- */
-	r8711_wx_set_rate,		/* SIOCSIWRATE */
-	r8711_wx_get_rate,		/* SIOCGIWRATE */
-	dummy,				/* SIOCSIWRTS */
-	r8711_wx_get_rts,		/* SIOCGIWRTS */
-	r8711_wx_set_frag,		/* SIOCSIWFRAG */
-	r8711_wx_get_frag,		/* SIOCGIWFRAG */
-	dummy,				/* SIOCSIWTXPOW */
-	dummy,				/* SIOCGIWTXPOW */
-	dummy,				/* SIOCSIWRETRY */
-	r8711_wx_get_retry,		/* SIOCGIWRETRY */
-	r8711_wx_set_enc,		/* SIOCSIWENCODE */
-	r8711_wx_get_enc,		/* SIOCGIWENCODE */
-	dummy,				/* SIOCSIWPOWER */
-	r8711_wx_get_power,		/* SIOCGIWPOWER */
-	NULL,				/*---hole---*/
-	NULL,				/*---hole---*/
-	r871x_wx_set_gen_ie,		/* SIOCSIWGENIE */
-	NULL,				/* SIOCGIWGENIE */
-	r871x_wx_set_auth,		/* SIOCSIWAUTH */
-	NULL,				/* SIOCGIWAUTH */
-	r871x_wx_set_enc_ext,		/* SIOCSIWENCODEEXT */
-	NULL,				/* SIOCGIWENCODEEXT */
-	r871x_wx_set_pmkid,		/* SIOCSIWPMKSA */
-	NULL,				/*---hole---*/
+	dummy, /* SIOCGIWAPLIST -- deprecated */
+	r8711_wx_set_scan, /* SIOCSIWSCAN */
+	r8711_wx_get_scan, /* SIOCGIWSCAN */
+	r8711_wx_set_essid, /* SIOCSIWESSID */
+	r8711_wx_get_essid, /* SIOCGIWESSID */
+	dummy, /* SIOCSIWNICKN */
+	r871x_wx_get_nick, /* SIOCGIWNICKN */
+	NULL, /* -- hole -- */
+	NULL, /* -- hole -- */
+	r8711_wx_set_rate, /* SIOCSIWRATE */
+	r8711_wx_get_rate, /* SIOCGIWRATE */
+	dummy, /* SIOCSIWRTS */
+	r8711_wx_get_rts, /* SIOCGIWRTS */
+	r8711_wx_set_frag, /* SIOCSIWFRAG */
+	r8711_wx_get_frag, /* SIOCGIWFRAG */
+	dummy, /* SIOCSIWTXPOW */
+	dummy, /* SIOCGIWTXPOW */
+	dummy, /* SIOCSIWRETRY */
+	r8711_wx_get_retry, /* SIOCGIWRETRY */
+	r8711_wx_set_enc, /* SIOCSIWENCODE */
+	r8711_wx_get_enc, /* SIOCGIWENCODE */
+	dummy, /* SIOCSIWPOWER */
+	r8711_wx_get_power, /* SIOCGIWPOWER */
+	NULL, /*---hole---*/
+	NULL, /*---hole---*/
+	r871x_wx_set_gen_ie, /* SIOCSIWGENIE */
+	NULL, /* SIOCGIWGENIE */
+	r871x_wx_set_auth, /* SIOCSIWAUTH */
+	NULL, /* SIOCGIWAUTH */
+	r871x_wx_set_enc_ext, /* SIOCSIWENCODEEXT */
+	NULL, /* SIOCGIWENCODEEXT */
+	r871x_wx_set_pmkid, /* SIOCSIWPMKSA */
+	NULL, /*---hole---*/
 };
 
 static const struct iw_priv_args r8711_private_args[] = {
-	{
-		SIOCIWFIRSTPRIV + 0x0,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "read32"
-	},
-	{
-		SIOCIWFIRSTPRIV + 0x1,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "write32"
-	},
-	{
-		SIOCIWFIRSTPRIV + 0x2, 0, 0, "driver_ext"
-	},
-	{
-		SIOCIWFIRSTPRIV + 0x3, 0, 0, "mp_ioctl"
-	},
-	{
-		SIOCIWFIRSTPRIV + 0x4,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "apinfo"
-	},
-	{
-		SIOCIWFIRSTPRIV + 0x5,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "setpid"
-	},
-	{
-		SIOCIWFIRSTPRIV + 0x6,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "wps_start"
-	},
-	{
-		SIOCIWFIRSTPRIV + 0x7,
-		IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "chplan"
-	}
+	{ SIOCIWFIRSTPRIV + 0x0, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
+	  "read32" },
+	{ SIOCIWFIRSTPRIV + 0x1, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
+	  "write32" },
+	{ SIOCIWFIRSTPRIV + 0x2, 0, 0, "driver_ext" },
+	{ SIOCIWFIRSTPRIV + 0x3, 0, 0, "mp_ioctl" },
+	{ SIOCIWFIRSTPRIV + 0x4, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
+	  "apinfo" },
+	{ SIOCIWFIRSTPRIV + 0x5, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
+	  "setpid" },
+	{ SIOCIWFIRSTPRIV + 0x6, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
+	  "wps_start" },
+	{ SIOCIWFIRSTPRIV + 0x7, IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0,
+	  "chplan" }
 };
 
 static iw_handler r8711_private_handler[] = {
-	r8711_wx_read32,
-	r8711_wx_write32,
-	r8711_drvext_hdl,
-	r871x_mp_ioctl_hdl,
-	r871x_get_ap_info, /*for MM DTV platform*/
-	r871x_set_pid,
-	r871x_wps_start,
-	r871x_set_chplan
+	r8711_wx_read32,    r8711_wx_write32,  r8711_drvext_hdl,
+	r871x_mp_ioctl_hdl, r871x_get_ap_info, /*for MM DTV platform*/
+	r871x_set_pid,	    r871x_wps_start,   r871x_set_chplan
 };
 
 static struct iw_statistics *r871x_get_wireless_stats(struct net_device *dev)
@@ -2269,7 +2272,7 @@ struct iw_handler_def r871x_handlers_def = {
 	.private = r8711_private_handler,
 	.private_args = (struct iw_priv_args *)r8711_private_args,
 	.num_private = ARRAY_SIZE(r8711_private_handler),
-	.num_private_args = sizeof(r8711_private_args) /
-			    sizeof(struct iw_priv_args),
+	.num_private_args =
+		sizeof(r8711_private_args) / sizeof(struct iw_priv_args),
 	.get_wireless_stats = r871x_get_wireless_stats
 };
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
index 2b539335206a..12b627f8003d 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
@@ -14,7 +14,7 @@
  *
  ******************************************************************************/
 
-#define  _RTL871X_IOCTL_RTL_C_
+#define _RTL871X_IOCTL_RTL_C_
 
 #include <linux/rndis.h>
 #include "osdep_service.h"
@@ -41,9 +41,9 @@ uint oid_rt_get_small_packet_crc_hdl(struct oid_par_priv *poid_par_priv)
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
-	if (poid_par_priv->information_buf_len >=  sizeof(u32)) {
+	if (poid_par_priv->information_buf_len >= sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =
-				padapter->recvpriv.rx_smallpacket_crcerr;
+			padapter->recvpriv.rx_smallpacket_crcerr;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
 		return RNDIS_STATUS_INVALID_LENGTH;
@@ -57,9 +57,9 @@ uint oid_rt_get_middle_packet_crc_hdl(struct oid_par_priv *poid_par_priv)
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
-	if (poid_par_priv->information_buf_len >=  sizeof(u32)) {
+	if (poid_par_priv->information_buf_len >= sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =
-				padapter->recvpriv.rx_middlepacket_crcerr;
+			padapter->recvpriv.rx_middlepacket_crcerr;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
 		return RNDIS_STATUS_INVALID_LENGTH;
@@ -73,9 +73,9 @@ uint oid_rt_get_large_packet_crc_hdl(struct oid_par_priv *poid_par_priv)
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
-	if (poid_par_priv->information_buf_len >=  sizeof(u32)) {
+	if (poid_par_priv->information_buf_len >= sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =
-				 padapter->recvpriv.rx_largepacket_crcerr;
+			padapter->recvpriv.rx_largepacket_crcerr;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
 		return RNDIS_STATUS_INVALID_LENGTH;
@@ -104,10 +104,9 @@ uint oid_rt_get_rx_total_packet_hdl(struct oid_par_priv *poid_par_priv)
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
-	if (poid_par_priv->information_buf_len >=  sizeof(u32)) {
+	if (poid_par_priv->information_buf_len >= sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =
-					 padapter->recvpriv.rx_pkts +
-					 padapter->recvpriv.rx_drop;
+			padapter->recvpriv.rx_pkts + padapter->recvpriv.rx_drop;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
 		return RNDIS_STATUS_INVALID_LENGTH;
@@ -137,7 +136,7 @@ uint oid_rt_get_rx_icv_err_hdl(struct oid_par_priv *poid_par_priv)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (poid_par_priv->information_buf_len >= sizeof(u32)) {
 		*(uint *)poid_par_priv->information_buf =
-					 padapter->recvpriv.rx_icv_err;
+			padapter->recvpriv.rx_icv_err;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
 		return RNDIS_STATUS_INVALID_LENGTH;
@@ -145,8 +144,7 @@ uint oid_rt_get_rx_icv_err_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_set_encryption_algorithm_hdl(struct oid_par_priv
-						*poid_par_priv)
+uint oid_rt_set_encryption_algorithm_hdl(struct oid_par_priv *poid_par_priv)
 {
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -194,8 +192,7 @@ uint oid_rt_get_channelplan_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_set_channelplan_hdl(struct oid_par_priv
-				       *poid_par_priv)
+uint oid_rt_set_channelplan_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *padapter = poid_par_priv->adapter_context;
 	struct eeprom_priv *peeprompriv = &padapter->eeprompriv;
@@ -206,8 +203,7 @@ uint oid_rt_set_channelplan_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_set_preamble_mode_hdl(struct oid_par_priv
-					 *poid_par_priv)
+uint oid_rt_set_preamble_mode_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *padapter = poid_par_priv->adapter_context;
 	u32 preamblemode = 0;
@@ -237,14 +233,12 @@ uint oid_rt_set_bcn_intvl_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_dedicate_probe_hdl(struct oid_par_priv
-				      *poid_par_priv)
+uint oid_rt_dedicate_probe_hdl(struct oid_par_priv *poid_par_priv)
 {
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_get_total_tx_bytes_hdl(struct oid_par_priv
-					  *poid_par_priv)
+uint oid_rt_get_total_tx_bytes_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *padapter = poid_par_priv->adapter_context;
 
@@ -252,7 +246,7 @@ uint oid_rt_get_total_tx_bytes_hdl(struct oid_par_priv
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (poid_par_priv->information_buf_len >= sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =
-						 padapter->xmitpriv.tx_bytes;
+			padapter->xmitpriv.tx_bytes;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
 		return RNDIS_STATUS_INVALID_LENGTH;
@@ -260,8 +254,7 @@ uint oid_rt_get_total_tx_bytes_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_get_total_rx_bytes_hdl(struct oid_par_priv
-					  *poid_par_priv)
+uint oid_rt_get_total_rx_bytes_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *padapter = poid_par_priv->adapter_context;
 
@@ -269,7 +262,7 @@ uint oid_rt_get_total_rx_bytes_hdl(struct oid_par_priv
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (poid_par_priv->information_buf_len >= sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =
-					   padapter->recvpriv.rx_bytes;
+			padapter->recvpriv.rx_bytes;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
 		return RNDIS_STATUS_INVALID_LENGTH;
@@ -277,22 +270,19 @@ uint oid_rt_get_total_rx_bytes_hdl(struct oid_par_priv
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_current_tx_power_level_hdl(struct oid_par_priv
-					      *poid_par_priv)
+uint oid_rt_current_tx_power_level_hdl(struct oid_par_priv *poid_par_priv)
 {
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_get_enc_key_mismatch_count_hdl(struct oid_par_priv
-						  *poid_par_priv)
+uint oid_rt_get_enc_key_mismatch_count_hdl(struct oid_par_priv *poid_par_priv)
 {
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_get_enc_key_match_count_hdl(struct oid_par_priv
-					       *poid_par_priv)
+uint oid_rt_get_enc_key_match_count_hdl(struct oid_par_priv *poid_par_priv)
 {
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -302,9 +292,9 @@ uint oid_rt_get_enc_key_match_count_hdl(struct oid_par_priv
 uint oid_rt_get_channel_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *padapter = poid_par_priv->adapter_context;
-	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct NDIS_802_11_CONFIGURATION *pnic_Config;
-	u32   channelnum;
+	u32 channelnum;
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -319,8 +309,7 @@ uint oid_rt_get_channel_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_get_hardware_radio_off_hdl(struct oid_par_priv
-			 *poid_par_priv)
+uint oid_rt_get_hardware_radio_off_hdl(struct oid_par_priv *poid_par_priv)
 {
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -334,8 +323,7 @@ uint oid_rt_get_key_mismatch_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_supported_wireless_mode_hdl(struct oid_par_priv
-					       *poid_par_priv)
+uint oid_rt_supported_wireless_mode_hdl(struct oid_par_priv *poid_par_priv)
 {
 	u32 ulInfo = 0;
 
@@ -345,7 +333,7 @@ uint oid_rt_supported_wireless_mode_hdl(struct oid_par_priv
 		ulInfo |= 0x0100; /* WIRELESS_MODE_B */
 		ulInfo |= 0x0200; /* WIRELESS_MODE_G */
 		ulInfo |= 0x0400; /* WIRELESS_MODE_A */
-		*(u32 *) poid_par_priv->information_buf = ulInfo;
+		*(u32 *)poid_par_priv->information_buf = ulInfo;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
 		return RNDIS_STATUS_INVALID_LENGTH;
@@ -372,36 +360,32 @@ uint oid_rt_forced_data_rate_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_wireless_mode_for_scan_list_hdl(struct oid_par_priv
-						   *poid_par_priv)
+uint oid_rt_wireless_mode_for_scan_list_hdl(struct oid_par_priv *poid_par_priv)
 {
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_get_bss_wireless_mode_hdl(struct oid_par_priv
-					     *poid_par_priv)
+uint oid_rt_get_bss_wireless_mode_hdl(struct oid_par_priv *poid_par_priv)
 {
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_scan_with_magic_packet_hdl(struct oid_par_priv
-					      *poid_par_priv)
+uint oid_rt_scan_with_magic_packet_hdl(struct oid_par_priv *poid_par_priv)
 {
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_ap_get_associated_station_list_hdl(struct oid_par_priv
-						      *poid_par_priv)
+uint oid_rt_ap_get_associated_station_list_hdl(
+	struct oid_par_priv *poid_par_priv)
 {
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_ap_switch_into_ap_mode_hdl(struct oid_par_priv*
-					      poid_par_priv)
+uint oid_rt_ap_switch_into_ap_mode_hdl(struct oid_par_priv *poid_par_priv)
 {
 	return RNDIS_STATUS_SUCCESS;
 }
@@ -418,20 +402,20 @@ uint oid_rt_ap_set_passphrase_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_rf_write_registry_hdl(struct oid_par_priv*
-					     poid_par_priv)
+uint oid_rt_pro_rf_write_registry_hdl(struct oid_par_priv *poid_par_priv)
 {
 	uint status = RNDIS_STATUS_SUCCESS;
 	struct _adapter *Adapter = poid_par_priv->adapter_context;
 
 	if (poid_par_priv->type_of_oid != SET_OID) /* QUERY_OID */
 		return RNDIS_STATUS_NOT_ACCEPTED;
-	if (poid_par_priv->information_buf_len ==
-	   (sizeof(unsigned long) * 3)) {
-		if (r8712_setrfreg_cmd(Adapter,
-			*(unsigned char *)poid_par_priv->information_buf,
-			(unsigned long)(*((unsigned long *)
-					poid_par_priv->information_buf + 2))))
+	if (poid_par_priv->information_buf_len == (sizeof(unsigned long) * 3)) {
+		if (r8712_setrfreg_cmd(
+			    Adapter,
+			    *(unsigned char *)poid_par_priv->information_buf,
+			    (unsigned long)(*((unsigned long *)poid_par_priv
+						      ->information_buf +
+					      2))))
 			status = RNDIS_STATUS_NOT_ACCEPTED;
 	} else {
 		status = RNDIS_STATUS_INVALID_LENGTH;
@@ -446,8 +430,7 @@ uint oid_rt_pro_rf_read_registry_hdl(struct oid_par_priv *poid_par_priv)
 
 	if (poid_par_priv->type_of_oid != SET_OID) /* QUERY_OID */
 		return RNDIS_STATUS_NOT_ACCEPTED;
-	if (poid_par_priv->information_buf_len == (sizeof(unsigned long) *
-						   3)) {
+	if (poid_par_priv->information_buf_len == (sizeof(unsigned long) * 3)) {
 		if (Adapter->mppriv.act_in_progress) {
 			status = RNDIS_STATUS_NOT_ACCEPTED;
 		} else {
@@ -455,11 +438,11 @@ uint oid_rt_pro_rf_read_registry_hdl(struct oid_par_priv *poid_par_priv)
 			Adapter->mppriv.act_in_progress = true;
 			Adapter->mppriv.workparam.bcompleted = false;
 			Adapter->mppriv.workparam.act_type = MPT_READ_RF;
-			Adapter->mppriv.workparam.io_offset = *(unsigned long *)
-						poid_par_priv->information_buf;
+			Adapter->mppriv.workparam.io_offset =
+				*(unsigned long *)poid_par_priv->information_buf;
 			Adapter->mppriv.workparam.io_value = 0xcccccccc;
 
-		/* RegOffsetValue	- The offset of RF register to read.
+			/* RegOffsetValue	- The offset of RF register to read.
 		 * RegDataWidth	- The data width of RF register to read.
 		 * RegDataValue	- The value to read.
 		 * RegOffsetValue = *((unsigned long *)InformationBuffer);
@@ -467,9 +450,10 @@ uint oid_rt_pro_rf_read_registry_hdl(struct oid_par_priv *poid_par_priv)
 		 * RegDataValue =  *((unsigned long *)InformationBuffer+2);
 		 */
 			if (r8712_getrfreg_cmd(Adapter,
-			    *(unsigned char *)poid_par_priv->information_buf,
-			    (unsigned char *)&Adapter->mppriv.workparam.io_value
-			    ))
+					       *(unsigned char *)poid_par_priv
+							->information_buf,
+					       (unsigned char *)&Adapter->mppriv
+						       .workparam.io_value))
 				status = RNDIS_STATUS_NOT_ACCEPTED;
 		}
 	} else {
@@ -478,17 +462,12 @@ uint oid_rt_pro_rf_read_registry_hdl(struct oid_par_priv *poid_par_priv)
 	return status;
 }
 
-enum _CONNECT_STATE_ {
-	CHECKINGSTATUS,
-	ASSOCIATED,
-	ADHOCMODE,
-	NOTASSOCIATED
-};
+enum _CONNECT_STATE_ { CHECKINGSTATUS, ASSOCIATED, ADHOCMODE, NOTASSOCIATED };
 
 uint oid_rt_get_connect_state_hdl(struct oid_par_priv *poid_par_priv)
 {
 	struct _adapter *padapter = poid_par_priv->adapter_context;
-	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	u32 ulInfo;
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
@@ -507,7 +486,7 @@ uint oid_rt_get_connect_state_hdl(struct oid_par_priv *poid_par_priv)
 	else
 		ulInfo = NOTASSOCIATED;
 	*(u32 *)poid_par_priv->information_buf = ulInfo;
-	*poid_par_priv->bytes_rw =  poid_par_priv->information_buf_len;
+	*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	return RNDIS_STATUS_SUCCESS;
 }
 
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
index 7c0b880ac686..c74672ca25a9 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
@@ -18,92 +18,51 @@
 #include "drv_types.h"
 
 /*************** oid_rtl_seg_01_01 **************/
-uint oid_rt_get_signal_quality_hdl(
-			struct oid_par_priv *poid_par_priv);/*84*/
-uint oid_rt_get_small_packet_crc_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_middle_packet_crc_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_large_packet_crc_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_tx_retry_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_rx_retry_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_rx_total_packet_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_tx_beacon_ok_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_tx_beacon_err_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_rx_icv_err_hdl(
-			struct oid_par_priv *poid_par_priv);/*93*/
-uint oid_rt_set_encryption_algorithm_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_preamble_mode_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_ap_ip_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_channelplan_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_set_channelplan_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_set_preamble_mode_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_set_bcn_intvl_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_dedicate_probe_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_total_tx_bytes_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_total_rx_bytes_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_current_tx_power_level_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_enc_key_mismatch_count_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_enc_key_match_count_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_channel_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_hardware_radio_off_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_key_mismatch_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_supported_wireless_mode_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_channel_list_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_scan_in_progress_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_forced_data_rate_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_wireless_mode_for_scan_list_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_bss_wireless_mode_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_scan_with_magic_packet_hdl(
-			struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_signal_quality_hdl(struct oid_par_priv *poid_par_priv); /*84*/
+uint oid_rt_get_small_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_middle_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_large_packet_crc_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_tx_retry_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_rx_retry_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_rx_total_packet_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_tx_beacon_ok_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_tx_beacon_err_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_rx_icv_err_hdl(struct oid_par_priv *poid_par_priv); /*93*/
+uint oid_rt_set_encryption_algorithm_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_preamble_mode_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_ap_ip_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_channelplan_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_set_channelplan_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_set_preamble_mode_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_set_bcn_intvl_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_dedicate_probe_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_total_tx_bytes_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_total_rx_bytes_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_current_tx_power_level_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_enc_key_mismatch_count_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_enc_key_match_count_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_channel_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_hardware_radio_off_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_key_mismatch_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_supported_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_channel_list_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_scan_in_progress_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_forced_data_rate_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_wireless_mode_for_scan_list_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_bss_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_scan_with_magic_packet_hdl(struct oid_par_priv *poid_par_priv);
 
 /**************  oid_rtl_seg_01_03 section start **************/
 uint oid_rt_ap_get_associated_station_list_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_ap_switch_into_ap_mode_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_ap_supported_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_ap_set_passphrase_hdl(
-			struct oid_par_priv *poid_par_priv);
+	struct oid_par_priv *poid_par_priv);
+uint oid_rt_ap_switch_into_ap_mode_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_ap_supported_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_ap_set_passphrase_hdl(struct oid_par_priv *poid_par_priv);
 /* oid_rtl_seg_01_11 */
-uint oid_rt_pro_rf_write_registry_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_pro_rf_read_registry_hdl(
-			struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_rf_write_registry_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_rf_read_registry_hdl(struct oid_par_priv *poid_par_priv);
 /***************  oid_rtl_seg_03_00 section start **************/
-uint oid_rt_get_connect_state_hdl(
-			struct oid_par_priv *poid_par_priv);
-uint oid_rt_set_default_key_id_hdl(
-			struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_connect_state_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_set_default_key_id_hdl(struct oid_par_priv *poid_par_priv);
 
 #endif
-
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.c b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
index 34c9a52b4c42..361a0de16fa9 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_set.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_set.c
@@ -30,7 +30,7 @@ static u8 validate_ssid(struct ndis_802_11_ssid *ssid)
 		return false;
 	for (i = 0; i < ssid->SsidLength; i++) {
 		/* wifi, printable ascii code must be supported */
-		if (!((ssid->Ssid[i] >= 0x20) && (ssid->Ssid[i] <= 0x7e)))
+		if (!(ssid->Ssid[i] >= 0x20 && ssid->Ssid[i] <= 0x7e))
 			return false;
 	}
 	return true;
@@ -40,8 +40,8 @@ static u8 do_join(struct _adapter *padapter)
 {
 	struct list_head *plist, *phead;
 	u8 *pibss = NULL;
-	struct	mlme_priv	*pmlmepriv = &(padapter->mlmepriv);
-	struct  __queue	*queue	= &(pmlmepriv->scanned_queue);
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct __queue *queue = &pmlmepriv->scanned_queue;
 	int ret;
 
 	phead = &queue->queue;
@@ -78,8 +78,7 @@ static u8 do_join(struct _adapter *padapter)
 				&padapter->registrypriv.dev_network;
 			pmlmepriv->fw_state = WIFI_ADHOC_MASTER_STATE;
 			pibss = padapter->registrypriv.dev_network.MacAddress;
-			memcpy(&pdev_network->Ssid,
-			       &pmlmepriv->assoc_ssid,
+			memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid,
 			       sizeof(struct ndis_802_11_ssid));
 			r8712_update_registrypriv_dev_network(padapter);
 			r8712_generate_random_ibss(pibss);
@@ -89,8 +88,7 @@ static u8 do_join(struct _adapter *padapter)
 		} else {
 			/* can't associate ; reset under-linking */
 			if (pmlmepriv->fw_state & _FW_UNDER_LINKING)
-				pmlmepriv->fw_state ^=
-					_FW_UNDER_LINKING;
+				pmlmepriv->fw_state ^= _FW_UNDER_LINKING;
 			/* when set_ssid/set_bssid for do_join(), but
 			 * there are no desired bss in scanning queue
 			 * we try to issue sitesurvey first
@@ -114,15 +112,13 @@ u8 r8712_set_802_11_bssid(struct _adapter *padapter, u8 *bssid)
 		return status;
 	}
 	spin_lock_irqsave(&pmlmepriv->lock, irqL);
-	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY |
-	    _FW_UNDER_LINKING)) {
+	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING)) {
 		status = check_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 		goto _Abort_Set_BSSID;
 	}
-	if (check_fwstate(pmlmepriv,
-	    _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
+	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
 		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid,
-		    ETH_ALEN)) {
+			    ETH_ALEN)) {
 			if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 				/* driver is in
 				 * WIFI_ADHOC_MASTER_STATE
@@ -134,7 +130,7 @@ u8 r8712_set_802_11_bssid(struct _adapter *padapter, u8 *bssid)
 				r8712_ind_disconnect(padapter);
 			r8712_free_assoc_resources(padapter);
 			if ((check_fwstate(pmlmepriv,
-			     WIFI_ADHOC_MASTER_STATE))) {
+					   WIFI_ADHOC_MASTER_STATE))) {
 				_clr_fwstate_(pmlmepriv,
 					      WIFI_ADHOC_MASTER_STATE);
 				set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
@@ -166,25 +162,26 @@ void r8712_set_802_11_ssid(struct _adapter *padapter,
 		goto _Abort_Set_SSID;
 	}
 	if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
-		if ((pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength) &&
+		if (pmlmepriv->assoc_ssid.SsidLength == ssid->SsidLength &&
 		    (!memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid,
-		    ssid->SsidLength))) {
+			     ssid->SsidLength))) {
 			if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
-				if (!r8712_is_same_ibss(padapter,
-				     pnetwork)) {
+				if (!r8712_is_same_ibss(padapter, pnetwork)) {
 					/* if in WIFI_ADHOC_MASTER_STATE or
 					 *  WIFI_ADHOC_STATE, create bss or
 					 * rejoin again
 					 */
 					r8712_disassoc_cmd(padapter);
 					if (check_fwstate(pmlmepriv,
-					    _FW_LINKED))
+							  _FW_LINKED))
 						r8712_ind_disconnect(padapter);
 					r8712_free_assoc_resources(padapter);
-					if (check_fwstate(pmlmepriv,
-					     WIFI_ADHOC_MASTER_STATE)) {
-						_clr_fwstate_(pmlmepriv,
-						    WIFI_ADHOC_MASTER_STATE);
+					if (check_fwstate(
+						    pmlmepriv,
+						    WIFI_ADHOC_MASTER_STATE)) {
+						_clr_fwstate_(
+							pmlmepriv,
+							WIFI_ADHOC_MASTER_STATE);
 						set_fwstate(pmlmepriv,
 							    WIFI_ADHOC_STATE);
 					}
@@ -200,8 +197,7 @@ void r8712_set_802_11_ssid(struct _adapter *padapter,
 			if (check_fwstate(pmlmepriv, _FW_LINKED))
 				r8712_ind_disconnect(padapter);
 			r8712_free_assoc_resources(padapter);
-			if (check_fwstate(pmlmepriv,
-			    WIFI_ADHOC_MASTER_STATE)) {
+			if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
 				_clr_fwstate_(pmlmepriv,
 					      WIFI_ADHOC_MASTER_STATE);
 				set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
@@ -221,14 +217,15 @@ void r8712_set_802_11_ssid(struct _adapter *padapter,
 	spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
 }
 
-void r8712_set_802_11_infrastructure_mode(struct _adapter *padapter,
+void r8712_set_802_11_infrastructure_mode(
+	struct _adapter *padapter,
 	enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype)
 {
 	unsigned long irqL;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct wlan_network	*cur_network = &pmlmepriv->cur_network;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct wlan_network *cur_network = &pmlmepriv->cur_network;
 	enum NDIS_802_11_NETWORK_INFRASTRUCTURE *pold_state =
-				&(cur_network->network.InfrastructureMode);
+		&cur_network->network.InfrastructureMode;
 
 	if (*pold_state != networktype) {
 		spin_lock_irqsave(&pmlmepriv->lock, irqL);
@@ -236,7 +233,7 @@ void r8712_set_802_11_infrastructure_mode(struct _adapter *padapter,
 		    (*pold_state == Ndis802_11IBSS))
 			r8712_disassoc_cmd(padapter);
 		if (check_fwstate(pmlmepriv,
-		    _FW_LINKED | WIFI_ADHOC_MASTER_STATE))
+				  _FW_LINKED | WIFI_ADHOC_MASTER_STATE))
 			r8712_free_assoc_resources(padapter);
 		if (check_fwstate(pmlmepriv, _FW_LINKED) ||
 		    (*pold_state == Ndis802_11Infrastructure) ||
@@ -252,7 +249,8 @@ void r8712_set_802_11_infrastructure_mode(struct _adapter *padapter,
 		 * WIFI_ADHOC_MASTER_STATE
 		 */
 		_clr_fwstate_(pmlmepriv, WIFI_STATION_STATE | WIFI_AP_STATE |
-			      WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE);
+						 WIFI_ADHOC_STATE |
+						 WIFI_ADHOC_MASTER_STATE);
 		switch (networktype) {
 		case Ndis802_11IBSS:
 			set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
@@ -310,8 +308,9 @@ u8 r8712_set_802_11_bssid_list_scan(struct _adapter *padapter)
 	return ret;
 }
 
-u8 r8712_set_802_11_authentication_mode(struct _adapter *padapter,
-				enum NDIS_802_11_AUTHENTICATION_MODE authmode)
+u8 r8712_set_802_11_authentication_mode(
+	struct _adapter *padapter,
+	enum NDIS_802_11_AUTHENTICATION_MODE authmode)
 {
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	u8 ret;
@@ -329,7 +328,7 @@ u8 r8712_set_802_11_authentication_mode(struct _adapter *padapter,
 int r8712_set_802_11_add_wep(struct _adapter *padapter,
 			     struct NDIS_802_11_WEP *wep)
 {
-	sint	keyid;
+	sint keyid;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
 	keyid = wep->KeyIndex & 0x3fffffff;
@@ -347,7 +346,7 @@ int r8712_set_802_11_add_wep(struct _adapter *padapter,
 		break;
 	}
 	memcpy(psecuritypriv->DefKey[keyid].skey, &wep->KeyMaterial,
-		wep->KeyLength);
+	       wep->KeyLength);
 	psecuritypriv->DefKeylen[keyid] = wep->KeyLength;
 	psecuritypriv->PrivacyKeyIndex = keyid;
 	return r8712_set_key(padapter, psecuritypriv, keyid);
diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.h b/drivers/staging/rtl8712/rtl871x_ioctl_set.h
index e2de820f61d9..7e212167c30e 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_set.h
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_set.h
@@ -23,8 +23,9 @@ struct BSSIDInfo {
 	NDIS_802_11_PMKID_VALUE PMKID;
 };
 
-u8 r8712_set_802_11_authentication_mode(struct _adapter *pdapter,
-			enum NDIS_802_11_AUTHENTICATION_MODE authmode);
+u8 r8712_set_802_11_authentication_mode(
+	struct _adapter *pdapter,
+	enum NDIS_802_11_AUTHENTICATION_MODE authmode);
 
 u8 r8712_set_802_11_bssid(struct _adapter *padapter, u8 *bssid);
 
@@ -35,11 +36,11 @@ u8 r8712_set_802_11_disassociate(struct _adapter *padapter);
 
 u8 r8712_set_802_11_bssid_list_scan(struct _adapter *padapter);
 
-void r8712_set_802_11_infrastructure_mode(struct _adapter *padapter,
-			enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype);
+void r8712_set_802_11_infrastructure_mode(
+	struct _adapter *padapter,
+	enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype);
 
 void r8712_set_802_11_ssid(struct _adapter *padapter,
 			   struct ndis_802_11_ssid *ssid);
 
 #endif
-
diff --git a/drivers/staging/rtl8712/rtl871x_led.h b/drivers/staging/rtl8712/rtl871x_led.h
index 2f0768132ad8..bd9d411681f0 100644
--- a/drivers/staging/rtl8712/rtl871x_led.h
+++ b/drivers/staging/rtl8712/rtl871x_led.h
@@ -37,20 +37,16 @@ enum LED_CTL_MODE {
 	LED_CTL_STOP_WPS_FAIL_OVERLAP = 13,
 };
 
-#define IS_LED_WPS_BLINKING(_LED_871x)	\
-	(((struct LED_871x *)_LED_871x)->CurrLedState == LED_BLINK_WPS \
-	|| ((struct LED_871x *)_LED_871x)->CurrLedState == LED_BLINK_WPS_STOP \
-	|| ((struct LED_871x *)_LED_871x)->bLedWPSBlinkInProgress)
+#define IS_LED_WPS_BLINKING(_LED_871x)                                         \
+	(((struct LED_871x *)_LED_871x)->CurrLedState == LED_BLINK_WPS ||      \
+	 ((struct LED_871x *)_LED_871x)->CurrLedState == LED_BLINK_WPS_STOP || \
+	 ((struct LED_871x *)_LED_871x)->bLedWPSBlinkInProgress)
 
-#define IS_LED_BLINKING(_LED_871x)	\
-		(((struct LED_871x *)_LED_871x)->bLedWPSBlinkInProgress \
-		|| ((struct LED_871x *)_LED_871x)->bLedScanBlinkInProgress)
+#define IS_LED_BLINKING(_LED_871x)                                 \
+	(((struct LED_871x *)_LED_871x)->bLedWPSBlinkInProgress || \
+	 ((struct LED_871x *)_LED_871x)->bLedScanBlinkInProgress)
 
-enum LED_PIN_871x {
-	LED_PIN_GPIO0,
-	LED_PIN_LED0,
-	LED_PIN_LED1
-};
+enum LED_PIN_871x { LED_PIN_GPIO0, LED_PIN_LED0, LED_PIN_LED1 };
 
 /*===========================================================================
  * LED customization.
@@ -74,32 +70,32 @@ enum LED_STRATEGY_871x {
 };
 
 struct LED_871x {
-	struct _adapter		*padapter;
-	enum LED_PIN_871x	LedPin;	/* Implementation for this SW led. */
-	u32			CurrLedState; /* Current LED state. */
-	u8			bLedOn; /* true if LED is ON */
-	u8			bSWLedCtrl;
-	u8			bLedBlinkInProgress; /*true if blinking */
-	u8			bLedNoLinkBlinkInProgress;
-	u8			bLedLinkBlinkInProgress;
-	u8			bLedStartToLinkBlinkInProgress;
-	u8			bLedScanBlinkInProgress;
-	u8			bLedWPSBlinkInProgress;
-	u32			BlinkTimes; /* No. times to toggle for blink.*/
-	u32			BlinkingLedState; /* Next state for blinking,
+	struct _adapter *padapter;
+	enum LED_PIN_871x LedPin; /* Implementation for this SW led. */
+	u32 CurrLedState; /* Current LED state. */
+	u8 bLedOn; /* true if LED is ON */
+	u8 bSWLedCtrl;
+	u8 bLedBlinkInProgress; /*true if blinking */
+	u8 bLedNoLinkBlinkInProgress;
+	u8 bLedLinkBlinkInProgress;
+	u8 bLedStartToLinkBlinkInProgress;
+	u8 bLedScanBlinkInProgress;
+	u8 bLedWPSBlinkInProgress;
+	u32 BlinkTimes; /* No. times to toggle for blink.*/
+	u32 BlinkingLedState; /* Next state for blinking,
 						   * either LED_ON or OFF.
 						   */
 
-	struct timer_list	BlinkTimer; /* Timer object for led blinking.*/
-	struct work_struct	BlinkWorkItem; /* Workitem used by BlinkTimer */
+	struct timer_list BlinkTimer; /* Timer object for led blinking.*/
+	struct work_struct BlinkWorkItem; /* Workitem used by BlinkTimer */
 };
 
 struct led_priv {
 	/* add for led control */
-	struct LED_871x		SwLed0;
-	struct LED_871x		SwLed1;
-	enum LED_STRATEGY_871x	LedStrategy;
-	u8			bRegUseLed;
+	struct LED_871x SwLed0;
+	struct LED_871x SwLed1;
+	enum LED_STRATEGY_871x LedStrategy;
+	u8 bRegUseLed;
 	void (*LedControlHandler)(struct _adapter *padapter,
 				  enum LED_CTL_MODE LedAction);
 	/* add for led control */
@@ -115,4 +111,3 @@ void LedControl871x(struct _adapter *padapter, enum LED_CTL_MODE LedAction);
 void r8712_flush_led_works(struct _adapter *padapter);
 
 #endif
-
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index 70c295e97068..25153e3f888e 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -31,23 +31,23 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len);
 
 int r8712_init_mlme_priv(struct _adapter *padapter)
 {
-	sint	i;
-	u8	*pbuf;
-	struct wlan_network	*pnetwork;
-	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	sint i;
+	u8 *pbuf;
+	struct wlan_network *pnetwork;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	memset((u8 *)pmlmepriv, 0, sizeof(struct mlme_priv));
 	pmlmepriv->nic_hdl = (u8 *)padapter;
 	pmlmepriv->pscanned = NULL;
 	pmlmepriv->fw_state = 0;
 	pmlmepriv->cur_network.network.InfrastructureMode =
-				 Ndis802_11AutoUnknown;
+		Ndis802_11AutoUnknown;
 	/* Maybe someday we should rename this variable to "active_mode"(Jeff)*/
 	pmlmepriv->passive_mode = 1; /* 1: active, 0: passive. */
-	spin_lock_init(&(pmlmepriv->lock));
-	spin_lock_init(&(pmlmepriv->lock2));
-	_init_queue(&(pmlmepriv->free_bss_pool));
-	_init_queue(&(pmlmepriv->scanned_queue));
+	spin_lock_init(&pmlmepriv->lock);
+	spin_lock_init(&pmlmepriv->lock2);
+	_init_queue(&pmlmepriv->free_bss_pool);
+	_init_queue(&pmlmepriv->scanned_queue);
 	set_scanned_network_val(pmlmepriv, 0);
 	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
 	pbuf = kmalloc_array(MAX_BSS_CNT, sizeof(struct wlan_network),
@@ -57,9 +57,8 @@ int r8712_init_mlme_priv(struct _adapter *padapter)
 	pmlmepriv->free_bss_buf = pbuf;
 	pnetwork = (struct wlan_network *)pbuf;
 	for (i = 0; i < MAX_BSS_CNT; i++) {
-		INIT_LIST_HEAD(&(pnetwork->list));
-		list_add_tail(&(pnetwork->list),
-				 &(pmlmepriv->free_bss_pool.queue));
+		INIT_LIST_HEAD(&pnetwork->list);
+		list_add_tail(&pnetwork->list, &pmlmepriv->free_bss_pool.queue);
 		pnetwork++;
 	}
 	pmlmepriv->sitesurveyctrl.last_rx_pkts = 0;
@@ -74,7 +73,7 @@ struct wlan_network *_r8712_alloc_network(struct mlme_priv *pmlmepriv)
 {
 	unsigned long irqL;
 	struct wlan_network *pnetwork;
-	struct  __queue *free_queue = &pmlmepriv->free_bss_pool;
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	spin_lock_irqsave(&free_queue->lock, irqL);
 	pnetwork = list_first_entry_or_null(&free_queue->queue,
@@ -93,7 +92,7 @@ static void _free_network(struct mlme_priv *pmlmepriv,
 {
 	u32 curr_time, delta_time;
 	unsigned long irqL;
-	struct  __queue *free_queue = &(pmlmepriv->free_bss_pool);
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
 		return;
@@ -111,9 +110,9 @@ static void _free_network(struct mlme_priv *pmlmepriv,
 }
 
 static void free_network_nolock(struct mlme_priv *pmlmepriv,
-			  struct wlan_network *pnetwork)
+				struct wlan_network *pnetwork)
 {
-	struct  __queue *free_queue = &pmlmepriv->free_bss_pool;
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
 
 	if (!pnetwork)
 		return;
@@ -128,7 +127,7 @@ static void free_network_nolock(struct mlme_priv *pmlmepriv,
  * Shall be called under atomic context...
  * to avoid possible racing condition...
  */
-static struct wlan_network *r8712_find_network(struct  __queue *scanned_queue,
+static struct wlan_network *r8712_find_network(struct __queue *scanned_queue,
 					       u8 *addr)
 {
 	unsigned long irqL;
@@ -156,7 +155,7 @@ void r8712_free_network_queue(struct _adapter *padapter)
 	struct list_head *phead, *plist;
 	struct wlan_network *pnetwork;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct  __queue *scanned_queue = &pmlmepriv->scanned_queue;
+	struct __queue *scanned_queue = &pmlmepriv->scanned_queue;
 
 	spin_lock_irqsave(&scanned_queue->lock, irqL);
 	phead = &scanned_queue->queue;
@@ -209,7 +208,7 @@ void r8712_free_mlme_priv(struct mlme_priv *pmlmepriv)
 	kfree(pmlmepriv->free_bss_buf);
 }
 
-static struct	wlan_network *alloc_network(struct mlme_priv *pmlmepriv)
+static struct wlan_network *alloc_network(struct mlme_priv *pmlmepriv)
 {
 	return _r8712_alloc_network(pmlmepriv);
 }
@@ -219,46 +218,39 @@ int r8712_is_same_ibss(struct _adapter *adapter, struct wlan_network *pnetwork)
 	int ret = true;
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
-	if ((psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.Privacy == cpu_to_le32(0)))
+	if (psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_ &&
+	    pnetwork->network.Privacy == cpu_to_le32(0))
 		ret = false;
-	else if ((psecuritypriv->PrivacyAlgrthm == _NO_PRIVACY_) &&
-		 (pnetwork->network.Privacy == cpu_to_le32(1)))
+	else if (psecuritypriv->PrivacyAlgrthm == _NO_PRIVACY_ &&
+		 pnetwork->network.Privacy == cpu_to_le32(1))
 		ret = false;
 	else
 		ret = true;
 	return ret;
-
 }
 
-static int is_same_network(struct wlan_bssid_ex *src,
-			   struct wlan_bssid_ex *dst)
+static int is_same_network(struct wlan_bssid_ex *src, struct wlan_bssid_ex *dst)
 {
 	u16 s_cap, d_cap;
 
 	memcpy((u8 *)&s_cap, r8712_get_capability_from_ie(src->IEs), 2);
 	memcpy((u8 *)&d_cap, r8712_get_capability_from_ie(dst->IEs), 2);
 	return (src->Ssid.SsidLength == dst->Ssid.SsidLength) &&
-			(src->Configuration.DSConfig ==
-			dst->Configuration.DSConfig) &&
-			((!memcmp(src->MacAddress, dst->MacAddress,
-			ETH_ALEN))) &&
-			((!memcmp(src->Ssid.Ssid,
-			  dst->Ssid.Ssid,
-			  src->Ssid.SsidLength))) &&
-			((s_cap & WLAN_CAPABILITY_IBSS) ==
-			(d_cap & WLAN_CAPABILITY_IBSS)) &&
-			((s_cap & WLAN_CAPABILITY_ESS) ==
-			(d_cap & WLAN_CAPABILITY_ESS));
-
+	       (src->Configuration.DSConfig == dst->Configuration.DSConfig) &&
+	       ((!memcmp(src->MacAddress, dst->MacAddress, ETH_ALEN))) &&
+	       ((!memcmp(src->Ssid.Ssid, dst->Ssid.Ssid,
+			 src->Ssid.SsidLength))) &&
+	       ((s_cap & WLAN_CAPABILITY_IBSS) ==
+		(d_cap & WLAN_CAPABILITY_IBSS)) &&
+	       ((s_cap & WLAN_CAPABILITY_ESS) == (d_cap & WLAN_CAPABILITY_ESS));
 }
 
-struct	wlan_network *r8712_get_oldest_wlan_network(
-				struct  __queue *scanned_queue)
+struct wlan_network *
+r8712_get_oldest_wlan_network(struct __queue *scanned_queue)
 {
 	struct list_head *plist, *phead;
-	struct	wlan_network	*pwlan = NULL;
-	struct	wlan_network	*oldest = NULL;
+	struct wlan_network *pwlan = NULL;
+	struct wlan_network *oldest = NULL;
 
 	phead = &scanned_queue->queue;
 	plist = phead->next;
@@ -277,22 +269,21 @@ struct	wlan_network *r8712_get_oldest_wlan_network(
 	return oldest;
 }
 
-static void update_network(struct wlan_bssid_ex *dst,
-			   struct wlan_bssid_ex *src,
+static void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 			   struct _adapter *padapter)
 {
 	u32 last_evm = 0, tmpVal;
 	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
 
 	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) &&
-	    is_same_network(&(padapter->mlmepriv.cur_network.network), src)) {
+	    is_same_network(&padapter->mlmepriv.cur_network.network, src)) {
 		if (padapter->recvpriv.signal_qual_data.total_num++ >=
 		    PHY_LINKQUALITY_SLID_WIN_MAX) {
 			padapter->recvpriv.signal_qual_data.total_num =
-				   PHY_LINKQUALITY_SLID_WIN_MAX;
+				PHY_LINKQUALITY_SLID_WIN_MAX;
 			last_evm = sqd->elements[sqd->index];
 			padapter->recvpriv.signal_qual_data.total_val -=
-				 last_evm;
+				last_evm;
 		}
 		padapter->recvpriv.signal_qual_data.total_val += src->Rssi;
 
@@ -317,25 +308,26 @@ static void update_current_network(struct _adapter *adapter,
 {
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
-	if (is_same_network(&(pmlmepriv->cur_network.network), pnetwork)) {
-		update_network(&(pmlmepriv->cur_network.network),
-			       pnetwork, adapter);
-		r8712_update_protection(adapter,
-			       (pmlmepriv->cur_network.network.IEs) +
-			       sizeof(struct NDIS_802_11_FIXED_IEs),
-			       pmlmepriv->cur_network.network.IELength);
+	if (is_same_network(&pmlmepriv->cur_network.network, pnetwork)) {
+		update_network(&pmlmepriv->cur_network.network, pnetwork,
+			       adapter);
+		r8712_update_protection(
+			adapter,
+			(pmlmepriv->cur_network.network.IEs) +
+				sizeof(struct NDIS_802_11_FIXED_IEs),
+			pmlmepriv->cur_network.network.IELength);
 	}
 }
 
 /* Caller must hold pmlmepriv->lock first */
 static void update_scanned_network(struct _adapter *adapter,
-			    struct wlan_bssid_ex *target)
+				   struct wlan_bssid_ex *target)
 {
 	struct list_head *plist, *phead;
 
 	u32 bssid_ex_sz;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	struct  __queue *queue = &pmlmepriv->scanned_queue;
+	struct __queue *queue = &pmlmepriv->scanned_queue;
 	struct wlan_network *pnetwork = NULL;
 	struct wlan_network *oldest = NULL;
 
@@ -351,7 +343,7 @@ static void update_scanned_network(struct _adapter *adapter,
 			break;
 		if ((oldest == ((struct wlan_network *)0)) ||
 		    time_after((unsigned long)oldest->last_scanned,
-				(unsigned long)pnetwork->last_scanned))
+			       (unsigned long)pnetwork->last_scanned))
 			oldest = pnetwork;
 
 		plist = plist->next;
@@ -364,10 +356,10 @@ static void update_scanned_network(struct _adapter *adapter,
 		if (list_empty(&pmlmepriv->free_bss_pool.queue)) {
 			/* If there are no more slots, expire the oldest */
 			pnetwork = oldest;
-			target->Rssi = (pnetwork->network.Rssi +
-					target->Rssi) / 2;
+			target->Rssi =
+				(pnetwork->network.Rssi + target->Rssi) / 2;
 			memcpy(&pnetwork->network, target,
-				r8712_get_wlan_bssid_ex_sz(target));
+			       r8712_get_wlan_bssid_ex_sz(target));
 			pnetwork->last_scanned = jiffies;
 		} else {
 			/* Otherwise just pull from the free list */
@@ -392,11 +384,11 @@ static void update_scanned_network(struct _adapter *adapter,
 }
 
 static void rtl8711_add_network(struct _adapter *adapter,
-			 struct wlan_bssid_ex *pnetwork)
+				struct wlan_bssid_ex *pnetwork)
 {
 	unsigned long irqL;
 	struct mlme_priv *pmlmepriv = &(((struct _adapter *)adapter)->mlmepriv);
-	struct  __queue *queue = &pmlmepriv->scanned_queue;
+	struct __queue *queue = &pmlmepriv->scanned_queue;
 
 	spin_lock_irqsave(&queue->lock, irqL);
 	update_current_network(adapter, pnetwork);
@@ -412,26 +404,26 @@ static void rtl8711_add_network(struct _adapter *adapter,
  *			(5) others
  */
 static int is_desired_network(struct _adapter *adapter,
-				struct wlan_network *pnetwork)
+			      struct wlan_network *pnetwork)
 {
 	u8 wps_ie[512];
 	uint wps_ielen;
 	int bselected = true;
-	struct	security_priv *psecuritypriv = &adapter->securitypriv;
+	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
 	if (psecuritypriv->wps_phase) {
 		if (r8712_get_wps_ie(pnetwork->network.IEs,
-		    pnetwork->network.IELength, wps_ie,
-		    &wps_ielen))
+				     pnetwork->network.IELength, wps_ie,
+				     &wps_ielen))
 			return true;
 		return false;
 	}
-	if ((psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_) &&
-		    (pnetwork->network.Privacy == 0))
+	if (psecuritypriv->PrivacyAlgrthm != _NO_PRIVACY_ &&
+	    pnetwork->network.Privacy == 0)
 		bselected = false;
 	if (check_fwstate(&adapter->mlmepriv, WIFI_ADHOC_STATE)) {
 		if (pnetwork->network.InfrastructureMode !=
-			adapter->mlmepriv.cur_network.network.InfrastructureMode)
+		    adapter->mlmepriv.cur_network.network.InfrastructureMode)
 			bselected = false;
 	}
 	return bselected;
@@ -458,23 +450,23 @@ void r8712_survey_event_callback(struct _adapter *adapter, u8 *pbuf)
 	pnetwork->Rssi = le32_to_cpu(pnetwork->Rssi);
 	pnetwork->NetworkTypeInUse = le32_to_cpu(pnetwork->NetworkTypeInUse);
 	pnetwork->Configuration.ATIMWindow =
-		 le32_to_cpu(pnetwork->Configuration.ATIMWindow);
+		le32_to_cpu(pnetwork->Configuration.ATIMWindow);
 	pnetwork->Configuration.BeaconPeriod =
-		 le32_to_cpu(pnetwork->Configuration.BeaconPeriod);
+		le32_to_cpu(pnetwork->Configuration.BeaconPeriod);
 	pnetwork->Configuration.DSConfig =
-		 le32_to_cpu(pnetwork->Configuration.DSConfig);
+		le32_to_cpu(pnetwork->Configuration.DSConfig);
 	pnetwork->Configuration.FHConfig.DwellTime =
-		 le32_to_cpu(pnetwork->Configuration.FHConfig.DwellTime);
+		le32_to_cpu(pnetwork->Configuration.FHConfig.DwellTime);
 	pnetwork->Configuration.FHConfig.HopPattern =
-		 le32_to_cpu(pnetwork->Configuration.FHConfig.HopPattern);
+		le32_to_cpu(pnetwork->Configuration.FHConfig.HopPattern);
 	pnetwork->Configuration.FHConfig.HopSet =
-		 le32_to_cpu(pnetwork->Configuration.FHConfig.HopSet);
+		le32_to_cpu(pnetwork->Configuration.FHConfig.HopSet);
 	pnetwork->Configuration.FHConfig.Length =
-		 le32_to_cpu(pnetwork->Configuration.FHConfig.Length);
+		le32_to_cpu(pnetwork->Configuration.FHConfig.Length);
 	pnetwork->Configuration.Length =
-		 le32_to_cpu(pnetwork->Configuration.Length);
+		le32_to_cpu(pnetwork->Configuration.Length);
 	pnetwork->InfrastructureMode =
-		 le32_to_cpu(pnetwork->InfrastructureMode);
+		le32_to_cpu(pnetwork->InfrastructureMode);
 	pnetwork->IELength = le32_to_cpu(pnetwork->IELength);
 #endif
 	len = r8712_get_wlan_bssid_ex_sz(pnetwork);
@@ -483,18 +475,18 @@ void r8712_survey_event_callback(struct _adapter *adapter, u8 *pbuf)
 	spin_lock_irqsave(&pmlmepriv->lock2, flags);
 	/* update IBSS_network 's timestamp */
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
-		if (!memcmp(&(pmlmepriv->cur_network.network.MacAddress),
-		    pnetwork->MacAddress, ETH_ALEN)) {
+		if (!memcmp(&pmlmepriv->cur_network.network.MacAddress,
+			    pnetwork->MacAddress, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
 			memcpy(pmlmepriv->cur_network.network.IEs,
-				pnetwork->IEs, 8);
-			ibss_wlan = r8712_find_network(
-						&pmlmepriv->scanned_queue,
-						pnetwork->MacAddress);
+			       pnetwork->IEs, 8);
+			ibss_wlan =
+				r8712_find_network(&pmlmepriv->scanned_queue,
+						   pnetwork->MacAddress);
 			if (ibss_wlan) {
-				memcpy(ibss_wlan->network.IEs,
-					pnetwork->IEs, 8);
+				memcpy(ibss_wlan->network.IEs, pnetwork->IEs,
+				       8);
 				goto exit;
 			}
 		}
@@ -531,24 +523,29 @@ void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 			if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
 				set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 
-				if (!r8712_select_and_join_from_scan(pmlmepriv)) {
-					mod_timer(&pmlmepriv->assoc_timer, jiffies +
-						  msecs_to_jiffies(MAX_JOIN_TIMEOUT));
+				if (!r8712_select_and_join_from_scan(
+					    pmlmepriv)) {
+					mod_timer(
+						&pmlmepriv->assoc_timer,
+						jiffies +
+							msecs_to_jiffies(
+								MAX_JOIN_TIMEOUT));
 				} else {
 					struct wlan_bssid_ex *pdev_network =
-					  &(adapter->registrypriv.dev_network);
+						&adapter->registrypriv
+							 .dev_network;
 					u8 *pibss =
-						 adapter->registrypriv.dev_network.MacAddress;
+						adapter->registrypriv
+							.dev_network.MacAddress;
 					pmlmepriv->fw_state ^= _FW_UNDER_SURVEY;
 					memcpy(&pdev_network->Ssid,
-						&pmlmepriv->assoc_ssid,
-						sizeof(struct
-							 ndis_802_11_ssid));
-					r8712_update_registrypriv_dev_network
-						(adapter);
+					       &pmlmepriv->assoc_ssid,
+					       sizeof(struct ndis_802_11_ssid));
+					r8712_update_registrypriv_dev_network(
+						adapter);
 					r8712_generate_random_ibss(pibss);
 					pmlmepriv->fw_state =
-						 WIFI_ADHOC_MASTER_STATE;
+						WIFI_ADHOC_MASTER_STATE;
 					pmlmepriv->to_join = false;
 				}
 			}
@@ -556,8 +553,9 @@ void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
 			pmlmepriv->to_join = false;
 			set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 			if (!r8712_select_and_join_from_scan(pmlmepriv))
-				mod_timer(&pmlmepriv->assoc_timer, jiffies +
-					  msecs_to_jiffies(MAX_JOIN_TIMEOUT));
+				mod_timer(&pmlmepriv->assoc_timer,
+					  jiffies + msecs_to_jiffies(
+							    MAX_JOIN_TIMEOUT));
 			else
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 		}
@@ -586,18 +584,19 @@ void r8712_free_assoc_resources(struct _adapter *adapter)
 					 tgt_network->network.MacAddress);
 
 		spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
-		r8712_free_stainfo(adapter,  psta);
+		r8712_free_stainfo(adapter, psta);
 		spin_unlock_irqrestore(&pstapriv->sta_hash_lock, irqL);
 	}
 
-	if (check_fwstate(pmlmepriv,
-	    WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE | WIFI_AP_STATE))
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE |
+					     WIFI_ADHOC_MASTER_STATE |
+					     WIFI_AP_STATE))
 		r8712_free_all_stainfo(adapter);
 	if (pwlan)
 		pwlan->fixed = false;
 
-	if (((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) &&
-	     (adapter->stapriv.asoc_sta_count == 1)))
+	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) &&
+	    adapter->stapriv.asoc_sta_count == 1)
 		free_network_nolock(pmlmepriv, pwlan);
 }
 
@@ -650,12 +649,12 @@ void r8712_ind_disconnect(struct _adapter *padapter)
 void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 {
 	unsigned long irqL = 0, irqL2;
-	struct sta_info	*ptarget_sta = NULL, *pcur_sta = NULL;
-	struct sta_priv	*pstapriv = &adapter->stapriv;
-	struct mlme_priv	*pmlmepriv = &adapter->mlmepriv;
-	struct wlan_network	*cur_network = &pmlmepriv->cur_network;
-	struct wlan_network	*pcur_wlan = NULL, *ptarget_wlan = NULL;
-	unsigned int		the_same_macaddr = false;
+	struct sta_info *ptarget_sta = NULL, *pcur_sta = NULL;
+	struct sta_priv *pstapriv = &adapter->stapriv;
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct wlan_network *cur_network = &pmlmepriv->cur_network;
+	struct wlan_network *pcur_wlan = NULL, *ptarget_wlan = NULL;
+	unsigned int the_same_macaddr = false;
 	struct wlan_network *pnetwork;
 
 	if (sizeof(struct list_head) == 4 * sizeof(u32)) {
@@ -663,7 +662,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 		if (!pnetwork)
 			return;
 		memcpy((u8 *)pnetwork + 16, (u8 *)pbuf + 8,
-			sizeof(struct wlan_network) - 16);
+		       sizeof(struct wlan_network) - 16);
 	} else {
 		pnetwork = (struct wlan_network *)pbuf;
 	}
@@ -687,8 +686,8 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 		le32_to_cpu(pnetwork->network.Configuration.DSConfig);
 	pnetwork->network.Configuration.FHConfig.DwellTime =
 		le32_to_cpu(pnetwork->network.Configuration.FHConfig.DwellTime);
-	pnetwork->network.Configuration.FHConfig.HopPattern =
-		le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopPattern);
+	pnetwork->network.Configuration.FHConfig.HopPattern = le32_to_cpu(
+		pnetwork->network.Configuration.FHConfig.HopPattern);
 	pnetwork->network.Configuration.FHConfig.HopSet =
 		le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopSet);
 	pnetwork->network.Configuration.FHConfig.Length =
@@ -701,7 +700,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 #endif
 
 	the_same_macaddr = !memcmp(pnetwork->network.MacAddress,
-				cur_network->network.MacAddress, ETH_ALEN);
+				   cur_network->network.MacAddress, ETH_ALEN);
 	pnetwork->network.Length =
 		r8712_get_wlan_bssid_ex_sz(&pnetwork->network);
 	spin_lock_irqsave(&pmlmepriv->lock, irqL);
@@ -712,38 +711,43 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 			/*s1. find ptarget_wlan*/
 			if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 				if (the_same_macaddr) {
-					ptarget_wlan =
-						r8712_find_network(&pmlmepriv->scanned_queue,
+					ptarget_wlan = r8712_find_network(
+						&pmlmepriv->scanned_queue,
 						cur_network->network.MacAddress);
 				} else {
-					pcur_wlan =
-						r8712_find_network(&pmlmepriv->scanned_queue,
+					pcur_wlan = r8712_find_network(
+						&pmlmepriv->scanned_queue,
 						cur_network->network.MacAddress);
 					if (pcur_wlan)
 						pcur_wlan->fixed = false;
 
-					pcur_sta = r8712_get_stainfo(pstapriv,
+					pcur_sta = r8712_get_stainfo(
+						pstapriv,
 						cur_network->network.MacAddress);
-					spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL2);
+					spin_lock_irqsave(
+						&pstapriv->sta_hash_lock,
+						irqL2);
 					r8712_free_stainfo(adapter, pcur_sta);
-					spin_unlock_irqrestore(&(pstapriv->sta_hash_lock), irqL2);
+					spin_unlock_irqrestore(
+						&pstapriv->sta_hash_lock,
+						irqL2);
 
-					ptarget_wlan =
-						r8712_find_network(&pmlmepriv->scanned_queue,
+					ptarget_wlan = r8712_find_network(
+						&pmlmepriv->scanned_queue,
 						pnetwork->network.MacAddress);
 					if (ptarget_wlan)
 						ptarget_wlan->fixed = true;
 				}
 			} else {
-				ptarget_wlan = r8712_find_network(&pmlmepriv->scanned_queue,
-						pnetwork->network.MacAddress);
+				ptarget_wlan = r8712_find_network(
+					&pmlmepriv->scanned_queue,
+					pnetwork->network.MacAddress);
 				if (ptarget_wlan)
 					ptarget_wlan->fixed = true;
 			}
 
 			if (!ptarget_wlan) {
-				if (check_fwstate(pmlmepriv,
-					_FW_UNDER_LINKING))
+				if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
 					pmlmepriv->fw_state ^=
 						_FW_UNDER_LINKING;
 				goto ignore_joinbss_callback;
@@ -752,47 +756,57 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 			/*s2. find ptarget_sta & update ptarget_sta*/
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 				if (the_same_macaddr) {
-					ptarget_sta =
-						r8712_get_stainfo(pstapriv,
+					ptarget_sta = r8712_get_stainfo(
+						pstapriv,
 						pnetwork->network.MacAddress);
 					if (!ptarget_sta)
-						ptarget_sta =
-						r8712_alloc_stainfo(pstapriv,
-						pnetwork->network.MacAddress);
+						ptarget_sta = r8712_alloc_stainfo(
+							pstapriv,
+							pnetwork->network
+								.MacAddress);
 				} else {
-					ptarget_sta =
-						r8712_alloc_stainfo(pstapriv,
+					ptarget_sta = r8712_alloc_stainfo(
+						pstapriv,
 						pnetwork->network.MacAddress);
 				}
 				if (ptarget_sta) /*update ptarget_sta*/ {
 					ptarget_sta->aid = pnetwork->join_res;
 					ptarget_sta->qos_option = 1;
 					ptarget_sta->mac_id = 5;
-					if (adapter->securitypriv.AuthAlgrthm == 2) {
-						adapter->securitypriv.binstallGrpkey = false;
-						adapter->securitypriv.busetkipkey = false;
-						adapter->securitypriv.bgrpkey_handshake = false;
-						ptarget_sta->ieee8021x_blocked = true;
+					if (adapter->securitypriv.AuthAlgrthm ==
+					    2) {
+						adapter->securitypriv
+							.binstallGrpkey = false;
+						adapter->securitypriv
+							.busetkipkey = false;
+						adapter->securitypriv
+							.bgrpkey_handshake =
+							false;
+						ptarget_sta->ieee8021x_blocked =
+							true;
 						ptarget_sta->XPrivacy =
-							adapter->securitypriv.PrivacyAlgrthm;
-						memset((u8 *)&ptarget_sta->x_UncstKey,
-							0,
-							sizeof(union Keytype));
-						memset((u8 *)&ptarget_sta->tkiprxmickey,
-							0,
-							sizeof(union Keytype));
-						memset((u8 *)&ptarget_sta->tkiptxmickey,
-							0,
-							sizeof(union Keytype));
+							adapter->securitypriv
+								.PrivacyAlgrthm;
+						memset((u8 *)&ptarget_sta
+							       ->x_UncstKey,
+						       0,
+						       sizeof(union Keytype));
+						memset((u8 *)&ptarget_sta
+							       ->tkiprxmickey,
+						       0,
+						       sizeof(union Keytype));
+						memset((u8 *)&ptarget_sta
+							       ->tkiptxmickey,
+						       0,
+						       sizeof(union Keytype));
 						memset((u8 *)&ptarget_sta->txpn,
-							0,
-							sizeof(union pn48));
+						       0, sizeof(union pn48));
 						memset((u8 *)&ptarget_sta->rxpn,
-							0,
-							sizeof(union pn48));
+						       0, sizeof(union pn48));
 					}
 				} else {
-					if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
+					if (check_fwstate(pmlmepriv,
+							  _FW_UNDER_LINKING))
 						pmlmepriv->fw_state ^=
 							_FW_UNDER_LINKING;
 					goto ignore_joinbss_callback;
@@ -801,7 +815,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 
 			/*s3. update cur_network & indicate connect*/
 			memcpy(&cur_network->network, &pnetwork->network,
-				pnetwork->network.Length);
+			       pnetwork->network.Length);
 			cur_network->aid = pnetwork->join_res;
 			/*update fw_state will clr _FW_UNDER_LINKING*/
 			switch (pnetwork->network.InfrastructureMode) {
@@ -815,13 +829,14 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 				pmlmepriv->fw_state = WIFI_NULL_STATE;
 				break;
 			}
-			r8712_update_protection(adapter,
+			r8712_update_protection(
+				adapter,
 				(cur_network->network.IEs) +
-				sizeof(struct NDIS_802_11_FIXED_IEs),
+					sizeof(struct NDIS_802_11_FIXED_IEs),
 				(cur_network->network.IELength));
 			/*TODO: update HT_Capability*/
 			update_ht_cap(adapter, cur_network->network.IEs,
-				cur_network->network.IELength);
+				      cur_network->network.IELength);
 			/*indicate connect*/
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 				r8712_indicate_connect(adapter);
@@ -832,7 +847,7 @@ void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
 	} else {
 		if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
 			mod_timer(&pmlmepriv->assoc_timer,
-				jiffies + msecs_to_jiffies(1));
+				  jiffies + msecs_to_jiffies(1));
 			_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 		}
 	}
@@ -846,8 +861,8 @@ void r8712_stassoc_event_callback(struct _adapter *adapter, u8 *pbuf)
 {
 	unsigned long irqL;
 	struct sta_info *psta;
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
-	struct stassoc_event *pstassoc	= (struct stassoc_event *)pbuf;
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	struct stassoc_event *pstassoc = (struct stassoc_event *)pbuf;
 
 	/* to do: */
 	if (!r8712_access_ctrl(&adapter->acl_list, pstassoc->macaddr))
@@ -900,28 +915,29 @@ void r8712_stadel_event_callback(struct _adapter *adapter, u8 *pbuf)
 		r8712_ind_disconnect(adapter);
 		r8712_free_assoc_resources(adapter);
 	}
-	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE |
-	    WIFI_ADHOC_STATE)) {
+	if (check_fwstate(pmlmepriv,
+			  WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE)) {
 		psta = r8712_get_stainfo(&adapter->stapriv, pstadel->macaddr);
 		spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
 		r8712_free_stainfo(adapter, psta);
 		spin_unlock_irqrestore(&pstapriv->sta_hash_lock, irqL);
 		if (adapter->stapriv.asoc_sta_count == 1) {
 			/*a sta + bc/mc_stainfo (not Ibss_stainfo) */
-			pwlan = r8712_find_network(&pmlmepriv->scanned_queue,
+			pwlan = r8712_find_network(
+				&pmlmepriv->scanned_queue,
 				tgt_network->network.MacAddress);
 			if (pwlan) {
 				pwlan->fixed = false;
 				free_network_nolock(pmlmepriv, pwlan);
 			}
 			/*re-create ibss*/
-			pdev_network = &(adapter->registrypriv.dev_network);
+			pdev_network = &adapter->registrypriv.dev_network;
 			pibss = adapter->registrypriv.dev_network.MacAddress;
 			memcpy(pdev_network, &tgt_network->network,
-				r8712_get_wlan_bssid_ex_sz(&tgt_network->network));
-			memcpy(&pdev_network->Ssid,
-				&pmlmepriv->assoc_ssid,
-				sizeof(struct ndis_802_11_ssid));
+			       r8712_get_wlan_bssid_ex_sz(
+				       &tgt_network->network));
+			memcpy(&pdev_network->Ssid, &pmlmepriv->assoc_ssid,
+			       sizeof(struct ndis_802_11_ssid));
 			r8712_update_registrypriv_dev_network(adapter);
 			r8712_generate_random_ibss(pibss);
 			if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
@@ -936,7 +952,7 @@ void r8712_stadel_event_callback(struct _adapter *adapter, u8 *pbuf)
 void r8712_cpwm_event_callback(struct _adapter *adapter, u8 *pbuf)
 {
 	struct reportpwrstate_parm *preportpwrstate =
-			 (struct reportpwrstate_parm *)pbuf;
+		(struct reportpwrstate_parm *)pbuf;
 
 	preportpwrstate->state |= (u8)(adapter->pwrctrlpriv.cpwm_tog + 0x80);
 	r8712_cpwm_int_hdl(adapter, preportpwrstate);
@@ -953,16 +969,16 @@ void r8712_cpwm_event_callback(struct _adapter *adapter, u8 *pbuf)
  */
 void r8712_got_addbareq_event_callback(struct _adapter *adapter, u8 *pbuf)
 {
-	struct	ADDBA_Req_Report_parm *pAddbareq_pram =
-			 (struct ADDBA_Req_Report_parm *)pbuf;
-	struct	sta_info *psta;
-	struct	sta_priv *pstapriv = &adapter->stapriv;
-	struct	recv_reorder_ctrl *precvreorder_ctrl = NULL;
+	struct ADDBA_Req_Report_parm *pAddbareq_pram =
+		(struct ADDBA_Req_Report_parm *)pbuf;
+	struct sta_info *psta;
+	struct sta_priv *pstapriv = &adapter->stapriv;
+	struct recv_reorder_ctrl *precvreorder_ctrl = NULL;
 
 	psta = r8712_get_stainfo(pstapriv, pAddbareq_pram->MacAddress);
 	if (psta) {
 		precvreorder_ctrl =
-			 &psta->recvreorder_ctrl[pAddbareq_pram->tid];
+			&psta->recvreorder_ctrl[pAddbareq_pram->tid];
 		/* set the indicate_seq to 0xffff so that the rx reorder
 		 * can store any following data packet.
 		 */
@@ -979,19 +995,19 @@ void r8712_wpspbc_event_callback(struct _adapter *adapter, u8 *pbuf)
 void _r8712_sitesurvey_ctrl_handler(struct _adapter *adapter)
 {
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	struct sitesurvey_ctrl	*psitesurveyctrl = &pmlmepriv->sitesurveyctrl;
-	struct registry_priv	*pregistrypriv = &adapter->registrypriv;
+	struct sitesurvey_ctrl *psitesurveyctrl = &pmlmepriv->sitesurveyctrl;
+	struct registry_priv *pregistrypriv = &adapter->registrypriv;
 	u64 current_tx_pkts;
 	uint current_rx_pkts;
 
-	current_tx_pkts = (adapter->xmitpriv.tx_pkts) -
-			  (psitesurveyctrl->last_tx_pkts);
-	current_rx_pkts = (adapter->recvpriv.rx_pkts) -
-			  (psitesurveyctrl->last_rx_pkts);
+	current_tx_pkts =
+		(adapter->xmitpriv.tx_pkts) - (psitesurveyctrl->last_tx_pkts);
+	current_rx_pkts =
+		(adapter->recvpriv.rx_pkts) - (psitesurveyctrl->last_rx_pkts);
 	psitesurveyctrl->last_tx_pkts = adapter->xmitpriv.tx_pkts;
 	psitesurveyctrl->last_rx_pkts = adapter->recvpriv.rx_pkts;
-	if ((current_tx_pkts > pregistrypriv->busy_thresh) ||
-	    (current_rx_pkts > pregistrypriv->busy_thresh))
+	if (current_tx_pkts > pregistrypriv->busy_thresh ||
+	    current_rx_pkts > pregistrypriv->busy_thresh)
 		psitesurveyctrl->traffic_busy = true;
 	else
 		psitesurveyctrl->traffic_busy = false;
@@ -1018,24 +1034,24 @@ void _r8712_join_timeout_handler(struct _adapter *adapter)
 	spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
 }
 
-void r8712_scan_timeout_handler (struct _adapter *adapter)
+void r8712_scan_timeout_handler(struct _adapter *adapter)
 {
 	unsigned long irqL;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	spin_lock_irqsave(&pmlmepriv->lock, irqL);
 	_clr_fwstate_(pmlmepriv, _FW_UNDER_SURVEY);
-	pmlmepriv->to_join = false;	/* scan fail, so clear to_join flag */
+	pmlmepriv->to_join = false; /* scan fail, so clear to_join flag */
 	spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
 }
 
-void _r8712_dhcp_timeout_handler (struct _adapter *adapter)
+void _r8712_dhcp_timeout_handler(struct _adapter *adapter)
 {
 	if (adapter->driver_stopped || adapter->surprise_removed)
 		return;
 	if (adapter->pwrctrlpriv.pwr_mode != adapter->registrypriv.power_mgnt)
 		r8712_set_ps_mode(adapter, adapter->registrypriv.power_mgnt,
-			    adapter->registrypriv.smart_ps);
+				  adapter->registrypriv.smart_ps);
 }
 
 int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
@@ -1043,7 +1059,7 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 	struct list_head *phead;
 	unsigned char *dst_ssid, *src_ssid;
 	struct _adapter *adapter;
-	struct  __queue *queue = NULL;
+	struct __queue *queue = NULL;
 	struct wlan_network *pnetwork = NULL;
 	struct wlan_network *pnetwork_max_rssi = NULL;
 
@@ -1067,9 +1083,12 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 			src_ssid = pmlmepriv->assoc_bssid;
 			if (!memcmp(dst_ssid, src_ssid, ETH_ALEN)) {
 				if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-					if (is_same_network(&pmlmepriv->cur_network.network,
-					    &pnetwork->network)) {
-						_clr_fwstate_(pmlmepriv,
+					if (is_same_network(
+						    &pmlmepriv->cur_network
+							     .network,
+						    &pnetwork->network)) {
+						_clr_fwstate_(
+							pmlmepriv,
 							_FW_UNDER_LINKING);
 						/*r8712_indicate_connect again*/
 						r8712_indicate_connect(adapter);
@@ -1086,10 +1105,10 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 		}
 		dst_ssid = pnetwork->network.Ssid.Ssid;
 		src_ssid = pmlmepriv->assoc_ssid.Ssid;
-		if ((pnetwork->network.Ssid.SsidLength ==
-		    pmlmepriv->assoc_ssid.SsidLength) &&
-		    (!memcmp(dst_ssid, src_ssid,
-		     pmlmepriv->assoc_ssid.SsidLength))) {
+		if (pnetwork->network.Ssid.SsidLength ==
+			    pmlmepriv->assoc_ssid.SsidLength &&
+		    !memcmp(dst_ssid, src_ssid,
+			    pmlmepriv->assoc_ssid.SsidLength)) {
 			if (pmlmepriv->assoc_by_rssi) {
 				/* if the ssid is the same, select the bss
 				 * which has the max rssi
@@ -1118,7 +1137,7 @@ int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
 int r8712_set_auth(struct _adapter *adapter,
 		   struct security_priv *psecuritypriv)
 {
-	struct cmd_priv	*pcmdpriv = &adapter->cmdpriv;
+	struct cmd_priv *pcmdpriv = &adapter->cmdpriv;
 	struct cmd_obj *pcmd;
 	struct setauth_parm *psetauthparm;
 
@@ -1142,8 +1161,7 @@ int r8712_set_auth(struct _adapter *adapter,
 	return 0;
 }
 
-int r8712_set_key(struct _adapter *adapter,
-		  struct security_priv *psecuritypriv,
+int r8712_set_key(struct _adapter *adapter, struct security_priv *psecuritypriv,
 		  sint keyid)
 {
 	struct cmd_priv *pcmdpriv = &adapter->cmdpriv;
@@ -1161,24 +1179,22 @@ int r8712_set_key(struct _adapter *adapter,
 		goto err_free_cmd;
 	}
 	if (psecuritypriv->AuthAlgrthm == 2) { /* 802.1X */
-		psetkeyparm->algorithm =
-			 (u8)psecuritypriv->XGrpPrivacy;
+		psetkeyparm->algorithm = (u8)psecuritypriv->XGrpPrivacy;
 	} else { /* WEP */
-		psetkeyparm->algorithm =
-			 (u8)psecuritypriv->PrivacyAlgrthm;
+		psetkeyparm->algorithm = (u8)psecuritypriv->PrivacyAlgrthm;
 	}
 	psetkeyparm->keyid = (u8)keyid;
 
 	switch (psetkeyparm->algorithm) {
 	case _WEP40_:
 		keylen = 5;
-		memcpy(psetkeyparm->key,
-			psecuritypriv->DefKey[keyid].skey, keylen);
+		memcpy(psetkeyparm->key, psecuritypriv->DefKey[keyid].skey,
+		       keylen);
 		break;
 	case _WEP104_:
 		keylen = 13;
-		memcpy(psetkeyparm->key,
-			psecuritypriv->DefKey[keyid].skey, keylen);
+		memcpy(psetkeyparm->key, psecuritypriv->DefKey[keyid].skey,
+		       keylen);
 		break;
 	case _TKIP_:
 		if (keyid < 1 || keyid > 2) {
@@ -1186,8 +1202,8 @@ int r8712_set_key(struct _adapter *adapter,
 			goto err_free_parm;
 		}
 		keylen = 16;
-		memcpy(psetkeyparm->key,
-			&psecuritypriv->XGrpKey[keyid - 1], keylen);
+		memcpy(psetkeyparm->key, &psecuritypriv->XGrpKey[keyid - 1],
+		       keylen);
 		psetkeyparm->grpkey = 1;
 		break;
 	case _AES_:
@@ -1196,8 +1212,8 @@ int r8712_set_key(struct _adapter *adapter,
 			goto err_free_parm;
 		}
 		keylen = 16;
-		memcpy(psetkeyparm->key,
-			&psecuritypriv->XGrpKey[keyid - 1], keylen);
+		memcpy(psetkeyparm->key, &psecuritypriv->XGrpKey[keyid - 1],
+		       keylen);
 		psetkeyparm->grpkey = 1;
 		break;
 	default:
@@ -1206,7 +1222,7 @@ int r8712_set_key(struct _adapter *adapter,
 	}
 	pcmd->cmdcode = _SetKey_CMD_;
 	pcmd->parmbuf = (u8 *)psetkeyparm;
-	pcmd->cmdsz =  (sizeof(struct setkey_parm));
+	pcmd->cmdsz = (sizeof(struct setkey_parm));
 	pcmd->rsp = NULL;
 	pcmd->rspsz = 0;
 	INIT_LIST_HEAD(&pcmd->list);
@@ -1222,7 +1238,7 @@ int r8712_set_key(struct _adapter *adapter,
 
 /* adjust IEs for r8712_joinbss_cmd in WMM */
 int r8712_restruct_wmm_ie(struct _adapter *adapter, u8 *in_ie, u8 *out_ie,
-		    uint in_len, uint initial_out_len)
+			  uint in_len, uint initial_out_len)
 {
 	unsigned int ielength = 0;
 	unsigned int i, j;
@@ -1262,17 +1278,18 @@ static int SecIsInPMKIDList(struct _adapter *Adapter, u8 *bssid)
 	int i;
 
 	for (i = 0; i < NUM_PMKID_CACHE; i++)
-		if (p->PMKIDList[i].bUsed && !memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN))
+		if (p->PMKIDList[i].bUsed &&
+		    !memcmp(p->PMKIDList[i].Bssid, bssid, ETH_ALEN))
 			return i;
 	return -1;
 }
 
-sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
-		     u8 *out_ie, uint in_len)
+sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie, u8 *out_ie,
+			   uint in_len)
 {
 	u8 authmode = 0, match;
 	u8 sec_ie[IW_CUSTOM_MAX], uncst_oui[4], bkup_ie[255];
-	u8 wpa_oui[4] = {0x0, 0x50, 0xf2, 0x01};
+	u8 wpa_oui[4] = { 0x0, 0x50, 0xf2, 0x01 };
 	uint ielength, cnt, remove_cnt;
 	int iEntry;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
@@ -1280,15 +1297,15 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 	uint ndisauthmode = psecuritypriv->ndisauthtype;
 	uint ndissecuritytype = psecuritypriv->ndisencryptstatus;
 
-	if ((ndisauthmode == Ndis802_11AuthModeWPA) ||
-	    (ndisauthmode == Ndis802_11AuthModeWPAPSK)) {
+	if (ndisauthmode == Ndis802_11AuthModeWPA ||
+	    ndisauthmode == Ndis802_11AuthModeWPAPSK) {
 		authmode = _WPA_IE_ID_;
 		uncst_oui[0] = 0x0;
 		uncst_oui[1] = 0x50;
 		uncst_oui[2] = 0xf2;
 	}
-	if ((ndisauthmode == Ndis802_11AuthModeWPA2) ||
-	    (ndisauthmode == Ndis802_11AuthModeWPA2PSK)) {
+	if (ndisauthmode == Ndis802_11AuthModeWPA2 ||
+	    ndisauthmode == Ndis802_11AuthModeWPA2PSK) {
 		authmode = _WPA2_IE_ID_;
 		uncst_oui[0] = 0x0;
 		uncst_oui[1] = 0x0f;
@@ -1315,24 +1332,24 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 	match = false;
 	while (cnt < in_len) {
 		if (in_ie[cnt] == authmode) {
-			if ((authmode == _WPA_IE_ID_) &&
-			    (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
+			if (authmode == _WPA_IE_ID_ &&
+			    !memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4)) {
 				memcpy(&sec_ie[0], &in_ie[cnt],
-					in_ie[cnt + 1] + 2);
+				       in_ie[cnt + 1] + 2);
 				match = true;
 				break;
 			}
 			if (authmode == _WPA2_IE_ID_) {
 				memcpy(&sec_ie[0], &in_ie[cnt],
-					in_ie[cnt + 1] + 2);
+				       in_ie[cnt + 1] + 2);
 				match = true;
 				break;
 			}
-			if (((authmode == _WPA_IE_ID_) &&
-			     (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) ||
-			     (authmode == _WPA2_IE_ID_))
+			if ((authmode == _WPA_IE_ID_ &&
+			     !memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4)) ||
+			    authmode == _WPA2_IE_ID_)
 				memcpy(&bkup_ie[0], &in_ie[cnt],
-					in_ie[cnt + 1] + 2);
+				       in_ie[cnt + 1] + 2);
 		}
 		cnt += in_ie[cnt + 1] + 2; /*get next*/
 	}
@@ -1348,7 +1365,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 					match = false;
 					break;
 				}
-				if ((sec_ie[6] != 0x01) || (sec_ie[7] != 0x0)) {
+				if (sec_ie[6] != 0x01 || sec_ie[7] != 0x0) {
 					/*IE Ver error*/
 					match = false;
 					break;
@@ -1360,24 +1377,24 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 					switch (sec_ie[11]) {
 					case 0x0: /*none*/
 						psecuritypriv->XGrpPrivacy =
-								_NO_PRIVACY_;
+							_NO_PRIVACY_;
 						break;
 					case 0x1: /*WEP_40*/
 						psecuritypriv->XGrpPrivacy =
-								_WEP40_;
+							_WEP40_;
 						break;
 					case 0x2: /*TKIP*/
 						psecuritypriv->XGrpPrivacy =
-								_TKIP_;
+							_TKIP_;
 						break;
 					case 0x3: /*AESCCMP*/
 					case 0x4:
 						psecuritypriv->XGrpPrivacy =
-								_AES_;
+							_AES_;
 						break;
 					case 0x5: /*WEP_104*/
 						psecuritypriv->XGrpPrivacy =
-								_WEP104_;
+							_WEP104_;
 						break;
 					}
 				} else {
@@ -1386,8 +1403,8 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 				}
 				if (sec_ie[12] == 0x01) {
 					/*check the unicast encryption type*/
-					if (memcmp(&sec_ie[14],
-					    &uncst_oui[0], 4)) {
+					if (memcmp(&sec_ie[14], &uncst_oui[0],
+						   4)) {
 						match = false;
 						break;
 
@@ -1402,9 +1419,8 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 					memcpy(&sec_ie[14], &uncst_oui[0], 4);
 					/*remove the other unicast suit*/
 					memcpy(&sec_ie[18],
-						&sec_ie[18 + remove_cnt],
-						sec_ie[1] - 18 + 2 -
-						remove_cnt);
+					       &sec_ie[18 + remove_cnt],
+					       sec_ie[1] - 18 + 2 - remove_cnt);
 					sec_ie[1] = sec_ie[1] - remove_cnt;
 				}
 				break;
@@ -1415,7 +1431,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 			 * algorithm, and set the bc/mc encryption algorithm
 			 */
 			while (true) {
-				if ((sec_ie[2] != 0x01) || (sec_ie[3] != 0x0)) {
+				if (sec_ie[2] != 0x01 || sec_ie[3] != 0x0) {
 					/*IE Ver error*/
 					match = false;
 					break;
@@ -1425,23 +1441,23 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 					switch (sec_ie[7]) {
 					case 0x1: /*WEP_40*/
 						psecuritypriv->XGrpPrivacy =
-								_WEP40_;
+							_WEP40_;
 						break;
 					case 0x2: /*TKIP*/
 						psecuritypriv->XGrpPrivacy =
-								_TKIP_;
+							_TKIP_;
 						break;
 					case 0x4: /*AESWRAP*/
 						psecuritypriv->XGrpPrivacy =
-								_AES_;
+							_AES_;
 						break;
 					case 0x5: /*WEP_104*/
 						psecuritypriv->XGrpPrivacy =
-								_WEP104_;
+							_WEP104_;
 						break;
 					default: /*one*/
 						psecuritypriv->XGrpPrivacy =
-								_NO_PRIVACY_;
+							_NO_PRIVACY_;
 						break;
 					}
 				} else {
@@ -1450,8 +1466,8 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 				}
 				if (sec_ie[8] == 0x01) {
 					/*check the unicast encryption type*/
-					if (memcmp(&sec_ie[10],
-						     &uncst_oui[0], 4)) {
+					if (memcmp(&sec_ie[10], &uncst_oui[0],
+						   4)) {
 						match = false;
 						break;
 					} /*else the uncst_oui is match*/
@@ -1465,8 +1481,8 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 					memcpy(&sec_ie[10], &uncst_oui[0], 4);
 					/*remove the other unicast suit*/
 					memcpy(&sec_ie[14],
-						&sec_ie[14 + remove_cnt],
-						(sec_ie[1] - 14 + 2 -
+					       &sec_ie[14 + remove_cnt],
+					       (sec_ie[1] - 14 + 2 -
 						remove_cnt));
 					sec_ie[1] = sec_ie[1] - remove_cnt;
 				}
@@ -1474,7 +1490,7 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 			}
 		}
 	}
-	if ((authmode == _WPA_IE_ID_) || (authmode == _WPA2_IE_ID_)) {
+	if (authmode == _WPA_IE_ID_ || authmode == _WPA2_IE_ID_) {
 		/*copy fixed ie*/
 		memcpy(out_ie, in_ie, 12);
 		ielength = 12;
@@ -1505,12 +1521,12 @@ sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
 	if (authmode == _WPA2_IE_ID_) {
 		out_ie[ielength] = 1;
 		ielength++;
-		out_ie[ielength] = 0;	/*PMKID count = 0x0100*/
+		out_ie[ielength] = 0; /*PMKID count = 0x0100*/
 		ielength++;
 		memcpy(&out_ie[ielength],
-			&psecuritypriv->PMKIDList[iEntry].PMKID, 16);
+		       &psecuritypriv->PMKIDList[iEntry].PMKID, 16);
 		ielength += 16;
-		out_ie[13] += 18;/*PMKID length = 2+16*/
+		out_ie[13] += 18; /*PMKID length = 2+16*/
 	}
 	return ielength;
 }
@@ -1524,9 +1540,9 @@ void r8712_init_registrypriv_dev_network(struct _adapter *adapter)
 
 	memcpy(pdev_network->MacAddress, myhwaddr, ETH_ALEN);
 	memcpy(&pdev_network->Ssid, &pregistrypriv->ssid,
-		sizeof(struct ndis_802_11_ssid));
+	       sizeof(struct ndis_802_11_ssid));
 	pdev_network->Configuration.Length =
-			 sizeof(struct NDIS_802_11_CONFIGURATION);
+		sizeof(struct NDIS_802_11_CONFIGURATION);
 	pdev_network->Configuration.BeaconPeriod = 100;
 	pdev_network->Configuration.FHConfig.Length = 0;
 	pdev_network->Configuration.FHConfig.HopPattern = 0;
@@ -1537,13 +1553,14 @@ void r8712_init_registrypriv_dev_network(struct _adapter *adapter)
 void r8712_update_registrypriv_dev_network(struct _adapter *adapter)
 {
 	int sz = 0;
-	struct registry_priv	*pregistrypriv = &adapter->registrypriv;
-	struct wlan_bssid_ex	*pdev_network = &pregistrypriv->dev_network;
-	struct security_priv	*psecuritypriv = &adapter->securitypriv;
-	struct wlan_network	*cur_network = &adapter->mlmepriv.cur_network;
+	struct registry_priv *pregistrypriv = &adapter->registrypriv;
+	struct wlan_bssid_ex *pdev_network = &pregistrypriv->dev_network;
+	struct security_priv *psecuritypriv = &adapter->securitypriv;
+	struct wlan_network *cur_network = &adapter->mlmepriv.cur_network;
 
-	pdev_network->Privacy = cpu_to_le32(psecuritypriv->PrivacyAlgrthm
-					    > 0 ? 1 : 0); /* adhoc no 802.1x */
+	pdev_network->Privacy = cpu_to_le32(psecuritypriv->PrivacyAlgrthm > 0 ?
+						    1 :
+						    0); /* adhoc no 802.1x */
 	pdev_network->Rssi = 0;
 	switch (pregistrypriv->wireless_mode) {
 	case WIRELESS_11B:
@@ -1563,7 +1580,8 @@ void r8712_update_registrypriv_dev_network(struct _adapter *adapter)
 	pdev_network->Configuration.DSConfig = pregistrypriv->channel;
 	if (cur_network->network.InfrastructureMode == Ndis802_11IBSS)
 		pdev_network->Configuration.ATIMWindow = 3;
-	pdev_network->InfrastructureMode = cur_network->network.InfrastructureMode;
+	pdev_network->InfrastructureMode =
+		cur_network->network.InfrastructureMode;
 	/* 1. Supported rates
 	 * 2. IE
 	 */
@@ -1576,18 +1594,18 @@ void r8712_update_registrypriv_dev_network(struct _adapter *adapter)
 void r8712_joinbss_reset(struct _adapter *padapter)
 {
 	int i;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv		*phtpriv = &pmlmepriv->htpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	/* todo: if you want to do something io/reg/hw setting before join_bss,
 	 * please add code here
 	 */
-	phtpriv->ampdu_enable = false;/*reset to disabled*/
+	phtpriv->ampdu_enable = false; /*reset to disabled*/
 	for (i = 0; i < 16; i++)
-		phtpriv->baddbareq_issued[i] = false;/*reset it*/
+		phtpriv->baddbareq_issued[i] = false; /*reset it*/
 	if (phtpriv->ht_option) {
 		/* validate  usb rx aggregation */
-		r8712_write8(padapter, 0x102500D9, 48);/*TH = 48 pages, 6k*/
+		r8712_write8(padapter, 0x102500D9, 48); /*TH = 48 pages, 6k*/
 	} else {
 		/* invalidate  usb rx aggregation */
 		/* TH=1 => means that invalidate usb rx aggregation */
@@ -1602,14 +1620,15 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 	u32 ielen, out_len;
 	unsigned char *p;
 	struct ieee80211_ht_cap ht_capie;
-	unsigned char WMM_IE[] = {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01, 0x00};
+	unsigned char WMM_IE[] = { 0x00, 0x50, 0xf2, 0x02, 0x00, 0x01, 0x00 };
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct qos_priv *pqospriv = &pmlmepriv->qospriv;
 	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
 	phtpriv->ht_option = 0;
-	p = r8712_get_ie(in_ie + 12, WLAN_EID_HT_CAPABILITY, &ielen, in_len - 12);
-	if (p && (ielen > 0)) {
+	p = r8712_get_ie(in_ie + 12, WLAN_EID_HT_CAPABILITY, &ielen,
+			 in_len - 12);
+	if (p && ielen > 0) {
 		if (pqospriv->qos_option == 0) {
 			out_len = *pout_len;
 			r8712_set_ie(out_ie + out_len, WLAN_EID_VENDOR_SPECIFIC,
@@ -1618,14 +1637,14 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 		}
 		out_len = *pout_len;
 		memset(&ht_capie, 0, sizeof(struct ieee80211_ht_cap));
-		ht_capie.cap_info = cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
-				    IEEE80211_HT_CAP_SGI_20 |
-				    IEEE80211_HT_CAP_SGI_40 |
-				    IEEE80211_HT_CAP_TX_STBC |
-				    IEEE80211_HT_CAP_MAX_AMSDU |
-				    IEEE80211_HT_CAP_DSSSCCK40);
-		ht_capie.ampdu_params_info = (IEEE80211_HT_AMPDU_PARM_FACTOR &
-				0x03) | (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
+		ht_capie.cap_info = cpu_to_le16(
+			IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
+			IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40 |
+			IEEE80211_HT_CAP_TX_STBC | IEEE80211_HT_CAP_MAX_AMSDU |
+			IEEE80211_HT_CAP_DSSSCCK40);
+		ht_capie.ampdu_params_info =
+			(IEEE80211_HT_AMPDU_PARM_FACTOR & 0x03) |
+			(IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
 		r8712_set_ie(out_ie + out_len, WLAN_EID_HT_CAPABILITY,
 			     sizeof(struct ieee80211_ht_cap),
 			     (unsigned char *)&ht_capie, pout_len);
@@ -1646,20 +1665,18 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	struct wlan_network *pcur_network = &(pmlmepriv->cur_network);
+	struct wlan_network *pcur_network = &pmlmepriv->cur_network;
 
 	if (!phtpriv->ht_option)
 		return;
 	/* maybe needs check if ap supports rx ampdu. */
-	if (!phtpriv->ampdu_enable &&
-	    (pregistrypriv->ampdu_enable == 1))
+	if (!phtpriv->ampdu_enable && pregistrypriv->ampdu_enable == 1)
 		phtpriv->ampdu_enable = true;
 	/*check Max Rx A-MPDU Size*/
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-				WLAN_EID_HT_CAPABILITY,
-				&len, ie_len -
-				sizeof(struct NDIS_802_11_FIXED_IEs));
+			 WLAN_EID_HT_CAPABILITY, &len,
+			 ie_len - sizeof(struct NDIS_802_11_FIXED_IEs));
 	if (p && len > 0) {
 		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 		max_ampdu_sz = (pht_capie->ampdu_params_info &
@@ -1692,16 +1709,16 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	}
 	len = 0;
 	p = r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
-		   WLAN_EID_HT_OPERATION, &len,
-		   ie_len - sizeof(struct NDIS_802_11_FIXED_IEs));
+			 WLAN_EID_HT_OPERATION, &len,
+			 ie_len - sizeof(struct NDIS_802_11_FIXED_IEs));
 }
 
 void r8712_issue_addbareq_cmd(struct _adapter *padapter, int priority)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	struct ht_priv	 *phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 
-	if ((phtpriv->ht_option == 1) && (phtpriv->ampdu_enable)) {
+	if (phtpriv->ht_option == 1 && phtpriv->ampdu_enable) {
 		if (!phtpriv->baddbareq_issued[priority]) {
 			r8712_addbareq_cmd(padapter, (u8)priority);
 			phtpriv->baddbareq_issued[priority] = true;
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.h b/drivers/staging/rtl8712/rtl871x_mlme.h
index d7d25f240111..25f3463f2cfb 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.h
+++ b/drivers/staging/rtl8712/rtl871x_mlme.h
@@ -18,43 +18,47 @@
 #include "drv_types.h"
 #include "wlan_bssdef.h"
 
-#define	MAX_BSS_CNT	64
-#define   MAX_JOIN_TIMEOUT	6000
-
-#define		SCANNING_TIMEOUT	4500
-
-#define	SCANQUEUE_LIFETIME 20 /* unit:sec */
-
-#define		WIFI_NULL_STATE	0x00000000
-#define	WIFI_ASOC_STATE		0x00000001	/* Under Linked state...*/
-#define		WIFI_REASOC_STATE 0x00000002
-#define	WIFI_SLEEP_STATE	0x00000004
-#define	WIFI_STATION_STATE	0x00000008
-#define	WIFI_AP_STATE		0x00000010
-#define	WIFI_ADHOC_STATE	0x00000020
-#define   WIFI_ADHOC_MASTER_STATE 0x00000040
-#define   WIFI_UNDER_LINKING	0x00000080
-#define WIFI_SITE_MONITOR	0x00000800	/* to indicate the station
+#define MAX_BSS_CNT 64
+#define MAX_JOIN_TIMEOUT 6000
+
+#define SCANNING_TIMEOUT 4500
+
+#define SCANQUEUE_LIFETIME 20 /* unit:sec */
+
+#define WIFI_NULL_STATE 0x00000000
+#define WIFI_ASOC_STATE 0x00000001 /* Under Linked state...*/
+#define WIFI_REASOC_STATE 0x00000002
+#define WIFI_SLEEP_STATE 0x00000004
+#define WIFI_STATION_STATE 0x00000008
+#define WIFI_AP_STATE 0x00000010
+#define WIFI_ADHOC_STATE 0x00000020
+#define WIFI_ADHOC_MASTER_STATE 0x00000040
+#define WIFI_UNDER_LINKING 0x00000080
+#define WIFI_SITE_MONITOR \
+	0x00000800 /* to indicate the station
 						 * is under site surveying
 						 */
-#define	WIFI_MP_STATE		0x00010000
-#define	WIFI_MP_CTX_BACKGROUND	0x00020000	/* in cont. tx background*/
-#define	WIFI_MP_CTX_ST		0x00040000	/* in cont. tx with
+#define WIFI_MP_STATE 0x00010000
+#define WIFI_MP_CTX_BACKGROUND 0x00020000 /* in cont. tx background*/
+#define WIFI_MP_CTX_ST \
+	0x00040000 /* in cont. tx with
 						 * single-tone
 						 */
-#define	WIFI_MP_CTX_BACKGROUND_PENDING	0x00080000 /* pending in cont, tx
+#define WIFI_MP_CTX_BACKGROUND_PENDING \
+	0x00080000 /* pending in cont, tx
 						    * background due
 						    * to out of skb
 						    */
-#define	WIFI_MP_CTX_CCK_HW	0x00100000	/* in continuous tx*/
-#define	WIFI_MP_CTX_CCK_CS	0x00200000	/* in cont, tx with carrier
+#define WIFI_MP_CTX_CCK_HW 0x00100000 /* in continuous tx*/
+#define WIFI_MP_CTX_CCK_CS \
+	0x00200000 /* in cont, tx with carrier
 						 * suppression
 						 */
-#define   WIFI_MP_LPBK_STATE	0x00400000
+#define WIFI_MP_LPBK_STATE 0x00400000
 
-#define _FW_UNDER_LINKING	WIFI_UNDER_LINKING
-#define _FW_LINKED		WIFI_ASOC_STATE
-#define _FW_UNDER_SURVEY	WIFI_SITE_MONITOR
+#define _FW_UNDER_LINKING WIFI_UNDER_LINKING
+#define _FW_LINKED WIFI_ASOC_STATE
+#define _FW_UNDER_SURVEY WIFI_SITE_MONITOR
 
 /*
  * there are several "locks" in mlme_priv,
@@ -66,29 +70,29 @@
  * SHALL not lock up more than one lock at a time!
  */
 
-#define traffic_threshold	10
-#define	traffic_scan_period	500
+#define traffic_threshold 10
+#define traffic_scan_period 500
 
 struct sitesurvey_ctrl {
-	u64	last_tx_pkts;
-	uint	last_rx_pkts;
-	sint	traffic_busy;
+	u64 last_tx_pkts;
+	uint last_rx_pkts;
+	sint traffic_busy;
 	struct timer_list sitesurvey_ctrl_timer;
 };
 
 struct mlme_priv {
 	spinlock_t lock;
 	spinlock_t lock2;
-	sint	fw_state;	/*shall we protect this variable? */
+	sint fw_state; /*shall we protect this variable? */
 	u8 to_join; /*flag*/
 	u8 *nic_hdl;
 	struct list_head *pscanned;
-	struct  __queue free_bss_pool;
-	struct  __queue scanned_queue;
+	struct __queue free_bss_pool;
+	struct __queue scanned_queue;
 	u8 *free_bss_buf;
 	unsigned long num_of_scanned;
 	u8 passive_mode; /*add for Android's SCAN-ACTIVE/SCAN-PASSIVE */
-	struct ndis_802_11_ssid	assoc_ssid;
+	struct ndis_802_11_ssid assoc_ssid;
 	u8 assoc_bssid[6];
 	struct wlan_network cur_network;
 	struct sitesurvey_ctrl sitesurveyctrl;
@@ -98,7 +102,7 @@ struct mlme_priv {
 	struct timer_list scan_to_timer; /* driver handles scan_timeout.*/
 	struct timer_list dhcp_timer; /* set dhcp to if driver in ps mode.*/
 	struct qos_priv qospriv;
-	struct ht_priv	htpriv;
+	struct ht_priv htpriv;
 	struct timer_list wdg_timer; /*watchdog periodic timer*/
 };
 
@@ -151,7 +155,7 @@ static inline void clr_fwstate(struct mlme_priv *pmlmepriv, sint state)
 }
 
 static inline void set_scanned_network_val(struct mlme_priv *pmlmepriv,
-					     sint val)
+					   sint val)
 {
 	unsigned long irqL;
 
@@ -172,22 +176,22 @@ void r8712_free_network_queue(struct _adapter *adapter);
 int r8712_init_mlme_priv(struct _adapter *adapter);
 void r8712_free_mlme_priv(struct mlme_priv *pmlmepriv);
 int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv);
-int r8712_set_key(struct _adapter *adapter,
-		  struct security_priv *psecuritypriv, sint keyid);
+int r8712_set_key(struct _adapter *adapter, struct security_priv *psecuritypriv,
+		  sint keyid);
 int r8712_set_auth(struct _adapter *adapter,
 		   struct security_priv *psecuritypriv);
 uint r8712_get_wlan_bssid_ex_sz(struct wlan_bssid_ex *bss);
 void r8712_generate_random_ibss(u8 *pibss);
 u8 *r8712_get_capability_from_ie(u8 *ie);
-struct wlan_network *r8712_get_oldest_wlan_network(
-				struct  __queue *scanned_queue);
+struct wlan_network *
+r8712_get_oldest_wlan_network(struct __queue *scanned_queue);
 void r8712_free_assoc_resources(struct _adapter *adapter);
 void r8712_ind_disconnect(struct _adapter *adapter);
 void r8712_indicate_connect(struct _adapter *adapter);
-int r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
-			  u8 *out_ie, uint in_len);
-int r8712_restruct_wmm_ie(struct _adapter *adapter, u8 *in_ie,
-			  u8 *out_ie, uint in_len, uint initial_out_len);
+int r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie, u8 *out_ie,
+			  uint in_len);
+int r8712_restruct_wmm_ie(struct _adapter *adapter, u8 *in_ie, u8 *out_ie,
+			  uint in_len, uint initial_out_len);
 void r8712_init_registrypriv_dev_network(struct _adapter *adapter);
 void r8712_update_registrypriv_dev_network(struct _adapter *adapter);
 void _r8712_sitesurvey_ctrl_handler(struct _adapter *adapter);
diff --git a/drivers/staging/rtl8712/rtl871x_mp.c b/drivers/staging/rtl8712/rtl871x_mp.c
index 099c512c8519..e9f23792d90c 100644
--- a/drivers/staging/rtl8712/rtl871x_mp.c
+++ b/drivers/staging/rtl8712/rtl871x_mp.c
@@ -41,20 +41,19 @@ static int init_mp_priv(struct mp_priv *pmp_priv)
 	_init_mp_priv_(pmp_priv);
 	_init_queue(&pmp_priv->free_mp_xmitqueue);
 	pmp_priv->pallocated_mp_xmitframe_buf = NULL;
-	pmp_priv->pallocated_mp_xmitframe_buf = kmalloc(NR_MP_XMITFRAME *
-				sizeof(struct mp_xmit_frame) + 4,
-				GFP_ATOMIC);
+	pmp_priv->pallocated_mp_xmitframe_buf = kmalloc(
+		NR_MP_XMITFRAME * sizeof(struct mp_xmit_frame) + 4, GFP_ATOMIC);
 	if (!pmp_priv->pallocated_mp_xmitframe_buf)
 		return -ENOMEM;
 
-	pmp_priv->pmp_xmtframe_buf = pmp_priv->pallocated_mp_xmitframe_buf +
-			 4 -
-			 ((addr_t)(pmp_priv->pallocated_mp_xmitframe_buf) & 3);
+	pmp_priv->pmp_xmtframe_buf =
+		pmp_priv->pallocated_mp_xmitframe_buf + 4 -
+		((addr_t)(pmp_priv->pallocated_mp_xmitframe_buf) & 3);
 	pmp_xmitframe = (struct mp_xmit_frame *)pmp_priv->pmp_xmtframe_buf;
 	for (i = 0; i < NR_MP_XMITFRAME; i++) {
-		INIT_LIST_HEAD(&(pmp_xmitframe->list));
-		list_add_tail(&(pmp_xmitframe->list),
-				 &(pmp_priv->free_mp_xmitqueue.queue));
+		INIT_LIST_HEAD(&pmp_xmitframe->list);
+		list_add_tail(&pmp_xmitframe->list,
+			      &pmp_priv->free_mp_xmitqueue.queue);
 		pmp_xmitframe->pkt = NULL;
 		pmp_xmitframe->frame_tag = MP_FRAMETAG;
 		pmp_xmitframe->padapter = pmp_priv->papdater;
@@ -91,9 +90,9 @@ void mp871xdeinit(struct _adapter *padapter)
 static u32 fw_iocmd_read(struct _adapter *pAdapter, struct IOCMD_STRUCT iocmd)
 {
 	u32 cmd32 = 0, val32 = 0;
-	u8 iocmd_class	= iocmd.cmdclass;
-	u16 iocmd_value	= iocmd.value;
-	u8 iocmd_idx	= iocmd.index;
+	u8 iocmd_class = iocmd.cmdclass;
+	u16 iocmd_value = iocmd.value;
+	u8 iocmd_idx = iocmd.index;
 
 	cmd32 = (iocmd_class << 24) | (iocmd_value << 8) | iocmd_idx;
 	if (r8712_fw_cmd(pAdapter, cmd32))
@@ -103,13 +102,13 @@ static u32 fw_iocmd_read(struct _adapter *pAdapter, struct IOCMD_STRUCT iocmd)
 	return val32;
 }
 
-static u8 fw_iocmd_write(struct _adapter *pAdapter,
-			 struct IOCMD_STRUCT iocmd, u32 value)
+static u8 fw_iocmd_write(struct _adapter *pAdapter, struct IOCMD_STRUCT iocmd,
+			 u32 value)
 {
 	u32 cmd32 = 0;
-	u8 iocmd_class	= iocmd.cmdclass;
-	u32 iocmd_value	= iocmd.value;
-	u8 iocmd_idx	= iocmd.index;
+	u8 iocmd_class = iocmd.cmdclass;
+	u32 iocmd_value = iocmd.value;
+	u8 iocmd_idx = iocmd.index;
 
 	r8712_fw_cmd_data(pAdapter, &value, 0);
 	msleep(100);
@@ -120,14 +119,14 @@ static u8 fw_iocmd_write(struct _adapter *pAdapter,
 /* offset : 0X800~0XFFF */
 u32 r8712_bb_reg_read(struct _adapter *pAdapter, u16 offset)
 {
-	u8 shift = offset & 0x0003;	/* 4 byte access */
-	u16 bb_addr = offset & 0x0FFC;	/* 4 byte access */
+	u8 shift = offset & 0x0003; /* 4 byte access */
+	u16 bb_addr = offset & 0x0FFC; /* 4 byte access */
 	u32 bb_val = 0;
 	struct IOCMD_STRUCT iocmd;
 
-	iocmd.cmdclass	= IOCMD_CLASS_BB_RF;
-	iocmd.value	= bb_addr;
-	iocmd.index	= IOCMD_BB_READ_IDX;
+	iocmd.cmdclass = IOCMD_CLASS_BB_RF;
+	iocmd.value = bb_addr;
+	iocmd.index = IOCMD_BB_READ_IDX;
 	bb_val = fw_iocmd_read(pAdapter, iocmd);
 	if (shift != 0) {
 		u32 bb_val2 = 0;
@@ -144,13 +143,13 @@ u32 r8712_bb_reg_read(struct _adapter *pAdapter, u16 offset)
 /* offset : 0X800~0XFFF */
 u8 r8712_bb_reg_write(struct _adapter *pAdapter, u16 offset, u32 value)
 {
-	u8 shift = offset & 0x0003;	/* 4 byte access */
-	u16 bb_addr = offset & 0x0FFC;	/* 4 byte access */
+	u8 shift = offset & 0x0003; /* 4 byte access */
+	u16 bb_addr = offset & 0x0FFC; /* 4 byte access */
 	struct IOCMD_STRUCT iocmd;
 
-	iocmd.cmdclass	= IOCMD_CLASS_BB_RF;
-	iocmd.value	= bb_addr;
-	iocmd.index	= IOCMD_BB_WRITE_IDX;
+	iocmd.cmdclass = IOCMD_CLASS_BB_RF;
+	iocmd.value = bb_addr;
+	iocmd.index = IOCMD_BB_WRITE_IDX;
 	if (shift != 0) {
 		u32 oldValue = 0;
 		u32 newValue = value;
@@ -174,9 +173,9 @@ u32 r8712_rf_reg_read(struct _adapter *pAdapter, u8 path, u8 offset)
 	u16 rf_addr = (path << 8) | offset;
 	struct IOCMD_STRUCT iocmd;
 
-	iocmd.cmdclass	= IOCMD_CLASS_BB_RF;
-	iocmd.value	= rf_addr;
-	iocmd.index	= IOCMD_RF_READ_IDX;
+	iocmd.cmdclass = IOCMD_CLASS_BB_RF;
+	iocmd.value = rf_addr;
+	iocmd.index = IOCMD_RF_READ_IDX;
 	return fw_iocmd_read(pAdapter, iocmd);
 }
 
@@ -185,9 +184,9 @@ u8 r8712_rf_reg_write(struct _adapter *pAdapter, u8 path, u8 offset, u32 value)
 	u16 rf_addr = (path << 8) | offset;
 	struct IOCMD_STRUCT iocmd;
 
-	iocmd.cmdclass	= IOCMD_CLASS_BB_RF;
-	iocmd.value	= rf_addr;
-	iocmd.index	= IOCMD_RF_WRIT_IDX;
+	iocmd.cmdclass = IOCMD_CLASS_BB_RF;
+	iocmd.value = rf_addr;
+	iocmd.index = IOCMD_RF_WRIT_IDX;
 	return fw_iocmd_write(pAdapter, iocmd, value);
 }
 
@@ -196,7 +195,7 @@ static u32 bitshift(u32 bitmask)
 	u32 i;
 
 	for (i = 0; i <= 31; i++)
-		if (((bitmask >> i) &  0x1) == 1)
+		if (((bitmask >> i) & 0x1) == 1)
 			break;
 	return i;
 }
@@ -210,9 +209,7 @@ static u32 get_bb_reg(struct _adapter *pAdapter, u16 offset, u32 bitmask)
 	return (org_value & bitmask) >> bit_shift;
 }
 
-static u8 set_bb_reg(struct _adapter *pAdapter,
-		     u16 offset,
-		     u32 bitmask,
+static u8 set_bb_reg(struct _adapter *pAdapter, u16 offset, u32 bitmask,
 		     u32 value)
 {
 	u32 org_value, bit_shift, new_value;
@@ -238,7 +235,7 @@ static u32 get_rf_reg(struct _adapter *pAdapter, u8 path, u8 offset,
 }
 
 static u8 set_rf_reg(struct _adapter *pAdapter, u8 path, u8 offset, u32 bitmask,
-	      u32 value)
+		     u32 value)
 {
 	u32 org_value, bit_shift, new_value;
 
@@ -290,8 +287,7 @@ static void SetOFDMTxPower(struct _adapter *pAdapter, u8 TxPower)
 {
 	u32 TxAGC = 0;
 
-	TxAGC |= ((TxPower << 24) | (TxPower << 16) | (TxPower << 8) |
-		  TxPower);
+	TxAGC |= ((TxPower << 24) | (TxPower << 16) | (TxPower << 8) | TxPower);
 	set_bb_reg(pAdapter, rTxAGC_Rate18_06, bTxAGCRate18_06, TxAGC);
 	set_bb_reg(pAdapter, rTxAGC_Rate54_24, bTxAGCRate54_24, TxAGC);
 	set_bb_reg(pAdapter, rTxAGC_Mcs03_Mcs00, bTxAGCRateMCS3_MCS0, TxAGC);
@@ -317,7 +313,7 @@ void r8712_SetTxAGCOffset(struct _adapter *pAdapter, u32 ulTxAGCOffset)
 	TxAGCOffset_D = (ulTxAGCOffset & 0x00ff0000) >> 16;
 	tmpAGC = TxAGCOffset_D << 8 | TxAGCOffset_C << 4 | TxAGCOffset_B;
 	set_bb_reg(pAdapter, rFPGA0_TxGainStage,
-			(bXBTxAGC | bXCTxAGC | bXDTxAGC), tmpAGC);
+		   (bXBTxAGC | bXCTxAGC | bXDTxAGC), tmpAGC);
 }
 
 void r8712_SetDataRate(struct _adapter *pAdapter)
@@ -376,12 +372,12 @@ void r8712_SwitchBandwidth(struct _adapter *pAdapter)
 	/* 3 3.Set RF related register */
 	switch (Bandwidth) {
 	case HT_CHANNEL_WIDTH_20:
-		set_rf_reg(pAdapter, RF_PATH_A, RF_CHNLBW,
-			   BIT(10) | BIT(11), 0x01);
+		set_rf_reg(pAdapter, RF_PATH_A, RF_CHNLBW, BIT(10) | BIT(11),
+			   0x01);
 		break;
 	case HT_CHANNEL_WIDTH_40:
-		set_rf_reg(pAdapter, RF_PATH_A, RF_CHNLBW,
-			   BIT(10) | BIT(11), 0x00);
+		set_rf_reg(pAdapter, RF_PATH_A, RF_CHNLBW, BIT(10) | BIT(11),
+			   0x00);
 		break;
 	default:
 		break;
@@ -390,29 +386,29 @@ void r8712_SwitchBandwidth(struct _adapter *pAdapter)
 
 /*------------------------------Define structure----------------------------*/
 struct R_ANTENNA_SELECT_OFDM {
-	u32	r_tx_antenna:4;
-	u32	r_ant_l:4;
-	u32	r_ant_non_ht:4;
-	u32	r_ant_ht1:4;
-	u32	r_ant_ht2:4;
-	u32	r_ant_ht_s1:4;
-	u32	r_ant_non_ht_s1:4;
-	u32	OFDM_TXSC:2;
-	u32	Reserved:2;
+	u32 r_tx_antenna : 4;
+	u32 r_ant_l : 4;
+	u32 r_ant_non_ht : 4;
+	u32 r_ant_ht1 : 4;
+	u32 r_ant_ht2 : 4;
+	u32 r_ant_ht_s1 : 4;
+	u32 r_ant_non_ht_s1 : 4;
+	u32 OFDM_TXSC : 2;
+	u32 Reserved : 2;
 };
 
 struct R_ANTENNA_SELECT_CCK {
-	u8	r_cckrx_enable_2:2;
-	u8	r_cckrx_enable:2;
-	u8	r_ccktx_enable:4;
+	u8 r_cckrx_enable_2 : 2;
+	u8 r_cckrx_enable : 2;
+	u8 r_ccktx_enable : 4;
 };
 
 void r8712_SwitchAntenna(struct _adapter *pAdapter)
 {
-	u32	ofdm_tx_en_val = 0, ofdm_tx_ant_sel_val = 0;
-	u8	ofdm_rx_ant_sel_val = 0;
-	u8	cck_ant_select_val = 0;
-	u32	cck_ant_sel_val = 0;
+	u32 ofdm_tx_en_val = 0, ofdm_tx_ant_sel_val = 0;
+	u8 ofdm_rx_ant_sel_val = 0;
+	u8 cck_ant_select_val = 0;
+	u32 cck_ant_sel_val = 0;
 	struct R_ANTENNA_SELECT_CCK *p_cck_txrx;
 
 	p_cck_txrx = (struct R_ANTENNA_SELECT_CCK *)&cck_ant_select_val;
@@ -423,17 +419,17 @@ void r8712_SwitchAntenna(struct _adapter *pAdapter)
 		set_bb_reg(pAdapter, rFPGA0_XA_HSSIParameter2, 0xe, 2);
 		set_bb_reg(pAdapter, rFPGA0_XB_HSSIParameter2, 0xe, 1);
 		ofdm_tx_en_val = 0x3;
-		ofdm_tx_ant_sel_val = 0x11111111;/* Power save */
+		ofdm_tx_ant_sel_val = 0x11111111; /* Power save */
 		p_cck_txrx->r_ccktx_enable = 0x8;
 		break;
 	case ANTENNA_B:
 		set_bb_reg(pAdapter, rFPGA0_XA_HSSIParameter2, 0xe, 1);
 		set_bb_reg(pAdapter, rFPGA0_XB_HSSIParameter2, 0xe, 2);
 		ofdm_tx_en_val = 0x3;
-		ofdm_tx_ant_sel_val = 0x22222222;/* Power save */
+		ofdm_tx_ant_sel_val = 0x22222222; /* Power save */
 		p_cck_txrx->r_ccktx_enable = 0x4;
 		break;
-	case ANTENNA_AB:	/* For 8192S */
+	case ANTENNA_AB: /* For 8192S */
 		set_bb_reg(pAdapter, rFPGA0_XA_HSSIParameter2, 0xe, 2);
 		set_bb_reg(pAdapter, rFPGA0_XB_HSSIParameter2, 0xe, 2);
 		ofdm_tx_en_val = 0x3;
@@ -449,12 +445,12 @@ void r8712_SwitchAntenna(struct _adapter *pAdapter)
 	set_bb_reg(pAdapter, rFPGA0_TxInfo, 0x0000000f, ofdm_tx_en_val);
 	switch (pAdapter->mppriv.antenna_rx) {
 	case ANTENNA_A:
-		ofdm_rx_ant_sel_val = 0x1;	/* A */
+		ofdm_rx_ant_sel_val = 0x1; /* A */
 		p_cck_txrx->r_cckrx_enable = 0x0; /* default: A */
 		p_cck_txrx->r_cckrx_enable_2 = 0x0; /* option: A */
 		break;
 	case ANTENNA_B:
-		ofdm_rx_ant_sel_val = 0x2;	/* B */
+		ofdm_rx_ant_sel_val = 0x2; /* B */
 		p_cck_txrx->r_cckrx_enable = 0x1; /* default: B */
 		p_cck_txrx->r_cckrx_enable_2 = 0x1; /* option: B */
 		break;
@@ -515,8 +511,7 @@ void r8712_SetSingleCarrierTx(struct _adapter *pAdapter, u8 bStart)
 	} else { /* Stop Single Carrier.*/
 		/* Turn off all test modes.*/
 		set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bDisable);
-		set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier,
-			   bDisable);
+		set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bDisable);
 		set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
 		msleep(20);
 		/*BB Reset*/
@@ -614,7 +609,7 @@ static void SetCCKContinuousTx(struct _adapter *pAdapter, u8 bStart)
 		set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bDisable);
 		set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
 		/*Set CCK Tx Test Rate*/
-		cckrate  = pAdapter->mppriv.curr_rateidx;
+		cckrate = pAdapter->mppriv.curr_rateidx;
 		set_bb_reg(pAdapter, rCCK0_System, bCCKTxRate, cckrate);
 		/*transmit mode*/
 		set_bb_reg(pAdapter, rCCK0_System, bCCKBBMode, 0x2);
@@ -649,8 +644,7 @@ static void SetOFDMContinuousTx(struct _adapter *pAdapter, u8 bStart)
 		set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
 	} else {
 		set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bDisable);
-		set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier,
-			   bDisable);
+		set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bDisable);
 		set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
 		msleep(20);
 		/*BB Reset*/
@@ -664,8 +658,8 @@ void r8712_SetContinuousTx(struct _adapter *pAdapter, u8 bStart)
 	/* ADC turn off [bit24-21] adc port0 ~ port1 */
 	if (bStart) {
 		r8712_bb_reg_write(pAdapter, rRx_Wait_CCCA,
-				   r8712_bb_reg_read(pAdapter,
-				   rRx_Wait_CCCA) & 0xFE1FFFFF);
+				   r8712_bb_reg_read(pAdapter, rRx_Wait_CCCA) &
+					   0xFE1FFFFF);
 		msleep(100);
 	}
 	if (pAdapter->mppriv.curr_rateidx <= MPT_RATE_11M)
@@ -676,8 +670,8 @@ void r8712_SetContinuousTx(struct _adapter *pAdapter, u8 bStart)
 	/* ADC turn on [bit24-21] adc port0 ~ port1 */
 	if (!bStart)
 		r8712_bb_reg_write(pAdapter, rRx_Wait_CCCA,
-				   r8712_bb_reg_read(pAdapter,
-				   rRx_Wait_CCCA) | 0x01E00000);
+				   r8712_bb_reg_read(pAdapter, rRx_Wait_CCCA) |
+					   0x01E00000);
 }
 
 void r8712_ResetPhyRxPktCount(struct _adapter *pAdapter)
@@ -686,8 +680,8 @@ void r8712_ResetPhyRxPktCount(struct _adapter *pAdapter)
 
 	for (i = OFDM_PPDU_BIT; i <= HT_MPDU_FAIL_BIT; i++) {
 		phyrx_set = 0;
-		phyrx_set |= (i << 28);		/*select*/
-		phyrx_set |= 0x08000000;	/* set counter to zero*/
+		phyrx_set |= (i << 28); /*select*/
+		phyrx_set |= 0x08000000; /* set counter to zero*/
 		r8712_write32(pAdapter, RXERR_RPT, phyrx_set);
 	}
 }
@@ -708,8 +702,8 @@ static u32 GetPhyRxPktCounts(struct _adapter *pAdapter, u32 selbit)
 u32 r8712_GetPhyRxPktReceived(struct _adapter *pAdapter)
 {
 	u32 OFDM_cnt = GetPhyRxPktCounts(pAdapter, OFDM_MPDU_OK_BIT);
-	u32 CCK_cnt  = GetPhyRxPktCounts(pAdapter, CCK_MPDU_OK_BIT);
-	u32 HT_cnt   = GetPhyRxPktCounts(pAdapter, HT_MPDU_OK_BIT);
+	u32 CCK_cnt = GetPhyRxPktCounts(pAdapter, CCK_MPDU_OK_BIT);
+	u32 HT_cnt = GetPhyRxPktCounts(pAdapter, HT_MPDU_OK_BIT);
 
 	return OFDM_cnt + CCK_cnt + HT_cnt;
 }
@@ -717,8 +711,8 @@ u32 r8712_GetPhyRxPktReceived(struct _adapter *pAdapter)
 u32 r8712_GetPhyRxPktCRC32Error(struct _adapter *pAdapter)
 {
 	u32 OFDM_cnt = GetPhyRxPktCounts(pAdapter, OFDM_MPDU_FAIL_BIT);
-	u32 CCK_cnt  = GetPhyRxPktCounts(pAdapter, CCK_MPDU_FAIL_BIT);
-	u32 HT_cnt   = GetPhyRxPktCounts(pAdapter, HT_MPDU_FAIL_BIT);
+	u32 CCK_cnt = GetPhyRxPktCounts(pAdapter, CCK_MPDU_FAIL_BIT);
+	u32 HT_cnt = GetPhyRxPktCounts(pAdapter, HT_MPDU_FAIL_BIT);
 
 	return OFDM_cnt + CCK_cnt + HT_cnt;
 }
diff --git a/drivers/staging/rtl8712/rtl871x_mp.h b/drivers/staging/rtl8712/rtl871x_mp.h
index 0a60b1e6ccaf..148fed6f8116 100644
--- a/drivers/staging/rtl8712/rtl871x_mp.h
+++ b/drivers/staging/rtl8712/rtl871x_mp.h
@@ -14,38 +14,38 @@
 #ifndef __RTL871X_MP_H_
 #define __RTL871X_MP_H_
 
-#define MPT_NOOP			0
-#define MPT_READ_MAC_1BYTE		1
-#define MPT_READ_MAC_2BYTE		2
-#define MPT_READ_MAC_4BYTE		3
-#define MPT_WRITE_MAC_1BYTE		4
-#define MPT_WRITE_MAC_2BYTE		5
-#define MPT_WRITE_MAC_4BYTE		6
-#define MPT_READ_BB_CCK			7
-#define MPT_WRITE_BB_CCK		8
-#define MPT_READ_BB_OFDM		9
-#define MPT_WRITE_BB_OFDM		10
-#define MPT_READ_RF			11
-#define MPT_WRITE_RF			12
-#define MPT_READ_EEPROM_1BYTE		13
-#define MPT_WRITE_EEPROM_1BYTE		14
-#define MPT_READ_EEPROM_2BYTE		15
-#define MPT_WRITE_EEPROM_2BYTE		16
-#define MPT_SET_CSTHRESHOLD		21
-#define MPT_SET_INITGAIN		22
-#define MPT_SWITCH_BAND			23
-#define MPT_SWITCH_CHANNEL		24
-#define MPT_SET_DATARATE		25
-#define MPT_SWITCH_ANTENNA		26
-#define MPT_SET_TX_POWER		27
-#define MPT_SET_CONT_TX			28
-#define MPT_SET_SINGLE_CARRIER		29
-#define MPT_SET_CARRIER_SUPPRESSION	30
-#define MPT_GET_RATE_TABLE		31
-#define MPT_READ_TSSI			32
-#define MPT_GET_THERMAL_METER		33
-#define MAX_MP_XMITBUF_SZ	2048
-#define NR_MP_XMITFRAME		8
+#define MPT_NOOP 0
+#define MPT_READ_MAC_1BYTE 1
+#define MPT_READ_MAC_2BYTE 2
+#define MPT_READ_MAC_4BYTE 3
+#define MPT_WRITE_MAC_1BYTE 4
+#define MPT_WRITE_MAC_2BYTE 5
+#define MPT_WRITE_MAC_4BYTE 6
+#define MPT_READ_BB_CCK 7
+#define MPT_WRITE_BB_CCK 8
+#define MPT_READ_BB_OFDM 9
+#define MPT_WRITE_BB_OFDM 10
+#define MPT_READ_RF 11
+#define MPT_WRITE_RF 12
+#define MPT_READ_EEPROM_1BYTE 13
+#define MPT_WRITE_EEPROM_1BYTE 14
+#define MPT_READ_EEPROM_2BYTE 15
+#define MPT_WRITE_EEPROM_2BYTE 16
+#define MPT_SET_CSTHRESHOLD 21
+#define MPT_SET_INITGAIN 22
+#define MPT_SWITCH_BAND 23
+#define MPT_SWITCH_CHANNEL 24
+#define MPT_SET_DATARATE 25
+#define MPT_SWITCH_ANTENNA 26
+#define MPT_SET_TX_POWER 27
+#define MPT_SET_CONT_TX 28
+#define MPT_SET_SINGLE_CARRIER 29
+#define MPT_SET_CARRIER_SUPPRESSION 30
+#define MPT_GET_RATE_TABLE 31
+#define MPT_READ_TSSI 32
+#define MPT_GET_THERMAL_METER 33
+#define MAX_MP_XMITBUF_SZ 2048
+#define NR_MP_XMITFRAME 8
 
 struct mp_xmit_frame {
 	struct list_head list;
@@ -95,20 +95,20 @@ struct mp_priv {
 	struct wlan_network mp_network;
 	unsigned char network_macaddr[6];
 	/*Testing Flag*/
-	u32 mode;/*0 for normal type packet,
+	u32 mode; /*0 for normal type packet,
 		  * 1 for loopback packet (16bytes TXCMD)
 		  */
 	sint prev_fw_state;
 	u8 *pallocated_mp_xmitframe_buf;
 	u8 *pmp_xmtframe_buf;
-	struct  __queue free_mp_xmitqueue;
+	struct __queue free_mp_xmitqueue;
 	u32 free_mp_xmitframe_cnt;
 };
 
 struct IOCMD_STRUCT {
-	u8	cmdclass;
-	u16	value;
-	u8	index;
+	u8 cmdclass;
+	u16 value;
+	u8 index;
 };
 
 struct rf_reg_param {
@@ -124,52 +124,52 @@ struct bb_reg_param {
 
 /* ======================================================================= */
 
-#define LOWER	true
-#define RAISE	false
-#define IOCMD_CTRL_REG			0x10250370
-#define IOCMD_DATA_REG			0x10250374
-#define IOCMD_GET_THERMAL_METER		0xFD000028
-#define IOCMD_CLASS_BB_RF		0xF0
-#define IOCMD_BB_READ_IDX		0x00
-#define IOCMD_BB_WRITE_IDX		0x01
-#define IOCMD_RF_READ_IDX		0x02
-#define IOCMD_RF_WRIT_IDX		0x03
-#define BB_REG_BASE_ADDR		0x800
-#define RF_PATH_A	0
-#define RF_PATH_B	1
-#define RF_PATH_C	2
-#define RF_PATH_D	3
-#define MAX_RF_PATH_NUMS	2
-#define _2MAC_MODE_	0
-#define _LOOPBOOK_MODE_	1
+#define LOWER true
+#define RAISE false
+#define IOCMD_CTRL_REG 0x10250370
+#define IOCMD_DATA_REG 0x10250374
+#define IOCMD_GET_THERMAL_METER 0xFD000028
+#define IOCMD_CLASS_BB_RF 0xF0
+#define IOCMD_BB_READ_IDX 0x00
+#define IOCMD_BB_WRITE_IDX 0x01
+#define IOCMD_RF_READ_IDX 0x02
+#define IOCMD_RF_WRIT_IDX 0x03
+#define BB_REG_BASE_ADDR 0x800
+#define RF_PATH_A 0
+#define RF_PATH_B 1
+#define RF_PATH_C 2
+#define RF_PATH_D 3
+#define MAX_RF_PATH_NUMS 2
+#define _2MAC_MODE_ 0
+#define _LOOPBOOK_MODE_ 1
 
 /* MP set force data rate base on the definition. */
 enum {
 	/* CCK rate. */
-	MPT_RATE_1M,	/* 0 */
+	MPT_RATE_1M, /* 0 */
 	MPT_RATE_2M,
 	MPT_RATE_55M,
-	MPT_RATE_11M,	/* 3 */
+	MPT_RATE_11M, /* 3 */
 
 	/* OFDM rate. */
-	MPT_RATE_6M,	/* 4 */
+	MPT_RATE_6M, /* 4 */
 	MPT_RATE_9M,
 	MPT_RATE_12M,
 	MPT_RATE_18M,
 	MPT_RATE_24M,
 	MPT_RATE_36M,
 	MPT_RATE_48M,
-	MPT_RATE_54M,	/* 11 */
+	MPT_RATE_54M, /* 11 */
 
 	/* HT rate. */
-	MPT_RATE_MCS0,	/* 12 */
+	MPT_RATE_MCS0, /* 12 */
 	MPT_RATE_MCS1,
 	MPT_RATE_MCS2,
 	MPT_RATE_MCS3,
 	MPT_RATE_MCS4,
 	MPT_RATE_MCS5,
 	MPT_RATE_MCS6,
-	MPT_RATE_MCS7,	/* 19 */
+	MPT_RATE_MCS7, /* 19 */
 	MPT_RATE_MCS8,
 	MPT_RATE_MCS9,
 	MPT_RATE_MCS10,
@@ -177,7 +177,7 @@ enum {
 	MPT_RATE_MCS12,
 	MPT_RATE_MCS13,
 	MPT_RATE_MCS14,
-	MPT_RATE_MCS15,	/* 27 */
+	MPT_RATE_MCS15, /* 27 */
 	MPT_RATE_LAST
 };
 
@@ -187,16 +187,13 @@ enum HT_CHANNEL_WIDTH {
 	HT_CHANNEL_WIDTH_40 = 1,
 };
 
-#define MAX_TX_PWR_INDEX_N_MODE 64	/* 0x3F */
+#define MAX_TX_PWR_INDEX_N_MODE 64 /* 0x3F */
 
-enum POWER_MODE {
-	POWER_LOW = 0,
-	POWER_NORMAL
-};
+enum POWER_MODE { POWER_LOW = 0, POWER_NORMAL };
 
-#define RX_PKT_BROADCAST	1
-#define RX_PKT_DEST_ADDR	2
-#define RX_PKT_PHY_MATCH	3
+#define RX_PKT_BROADCAST 1
+#define RX_PKT_DEST_ADDR 2
+#define RX_PKT_PHY_MATCH 3
 
 #define RPTMaxCount 0x000FFFFF
 
@@ -230,31 +227,29 @@ enum RXPHY_BITMASK {
 };
 
 enum ENCRY_CTRL_STATE {
-	HW_CONTROL,		/*hw encryption& decryption*/
-	SW_CONTROL,		/*sw encryption& decryption*/
-	HW_ENCRY_SW_DECRY,	/*hw encryption & sw decryption*/
-	SW_ENCRY_HW_DECRY	/*sw encryption & hw decryption*/
+	HW_CONTROL, /*hw encryption& decryption*/
+	SW_CONTROL, /*sw encryption& decryption*/
+	HW_ENCRY_SW_DECRY, /*hw encryption & sw decryption*/
+	SW_ENCRY_HW_DECRY /*sw encryption & hw decryption*/
 };
 
 /* Bandwidth Offset */
-#define HAL_PRIME_CHNL_OFFSET_DONT_CARE	0
-#define HAL_PRIME_CHNL_OFFSET_LOWER	1
-#define HAL_PRIME_CHNL_OFFSET_UPPER	2
+#define HAL_PRIME_CHNL_OFFSET_DONT_CARE 0
+#define HAL_PRIME_CHNL_OFFSET_LOWER 1
+#define HAL_PRIME_CHNL_OFFSET_UPPER 2
 /*=======================================================================*/
 void mp871xinit(struct _adapter *padapter);
 void mp871xdeinit(struct _adapter *padapter);
 u32 r8712_bb_reg_read(struct _adapter *Adapter, u16 offset);
 u8 r8712_bb_reg_write(struct _adapter *Adapter, u16 offset, u32 value);
 u32 r8712_rf_reg_read(struct _adapter *Adapter, u8 path, u8 offset);
-u8 r8712_rf_reg_write(struct _adapter *Adapter, u8 path,
-		      u8 offset, u32 value);
+u8 r8712_rf_reg_write(struct _adapter *Adapter, u8 path, u8 offset, u32 value);
 u32 r8712_get_bb_reg(struct _adapter *Adapter, u16 offset, u32 bitmask);
-u8 r8712_set_bb_reg(struct _adapter *Adapter, u16 offset,
-		    u32 bitmask, u32 value);
-u32 r8712_get_rf_reg(struct _adapter *Adapter, u8 path, u8 offset,
-		     u32 bitmask);
-u8 r8712_set_rf_reg(struct _adapter *Adapter, u8 path, u8 offset,
-		    u32 bitmask, u32 value);
+u8 r8712_set_bb_reg(struct _adapter *Adapter, u16 offset, u32 bitmask,
+		    u32 value);
+u32 r8712_get_rf_reg(struct _adapter *Adapter, u8 path, u8 offset, u32 bitmask);
+u8 r8712_set_rf_reg(struct _adapter *Adapter, u8 path, u8 offset, u32 bitmask,
+		    u32 value);
 
 void r8712_SetChannel(struct _adapter *pAdapter);
 void r8712_SetTxPower(struct _adapter *pAdapte);
@@ -272,4 +267,3 @@ u32 r8712_GetPhyRxPktReceived(struct _adapter *pAdapter);
 u32 r8712_GetPhyRxPktCRC32Error(struct _adapter *pAdapter);
 
 #endif /*__RTL871X_MP_H_*/
-
diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
index 26fa09b45c90..22ab451c3712 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
+++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
@@ -29,21 +29,21 @@ uint oid_null_function(struct oid_par_priv *poid_par_priv)
 uint oid_rt_wireless_mode_hdl(struct oid_par_priv *poid_par_priv)
 {
 	uint status = RNDIS_STATUS_SUCCESS;
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid == SET_OID) {
 		if (poid_par_priv->information_buf_len >= sizeof(u8))
 			Adapter->registrypriv.wireless_mode =
-					*(u8 *)poid_par_priv->information_buf;
+				*(u8 *)poid_par_priv->information_buf;
 		else
 			status = RNDIS_STATUS_INVALID_LENGTH;
 	} else if (poid_par_priv->type_of_oid == QUERY_OID) {
 		if (poid_par_priv->information_buf_len >= sizeof(u8)) {
 			*(u8 *)poid_par_priv->information_buf =
-					 Adapter->registrypriv.wireless_mode;
+				Adapter->registrypriv.wireless_mode;
 			*poid_par_priv->bytes_rw =
-					poid_par_priv->information_buf_len;
+				poid_par_priv->information_buf_len;
 		} else {
 			status = RNDIS_STATUS_INVALID_LENGTH;
 		}
@@ -55,8 +55,8 @@ uint oid_rt_wireless_mode_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_write_bb_reg_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 	struct bb_reg_param *pbbreg;
 	u16 offset;
 	u32 value;
@@ -76,8 +76,8 @@ uint oid_rt_pro_write_bb_reg_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_read_bb_reg_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 	struct bb_reg_param *pbbreg;
 	u16 offset;
 	u32 value;
@@ -98,8 +98,8 @@ uint oid_rt_pro_read_bb_reg_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_write_rf_reg_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 	struct rf_reg_param *pbbreg;
 	u8 path;
 	u8 offset;
@@ -121,8 +121,8 @@ uint oid_rt_pro_write_rf_reg_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_read_rf_reg_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 	struct rf_reg_param *pbbreg;
 	u8 path;
 	u8 offset;
@@ -163,7 +163,7 @@ static int mp_start_test(struct _adapter *padapter)
 	memcpy(bssid->MacAddress, pmppriv->network_macaddr, ETH_ALEN);
 	bssid->Ssid.SsidLength = 16;
 	memcpy(bssid->Ssid.Ssid, (unsigned char *)"mp_pseudo_adhoc",
-		bssid->Ssid.SsidLength);
+	       bssid->Ssid.SsidLength);
 	bssid->InfrastructureMode = Ndis802_11IBSS;
 	bssid->NetworkTypeInUse = Ndis802_11DS;
 	bssid->IELength = 0;
@@ -238,8 +238,8 @@ static int mp_stop_test(struct _adapter *padapter)
 
 uint oid_rt_pro_set_data_rate_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 	u32 ratevalue;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
@@ -256,16 +256,16 @@ uint oid_rt_pro_set_data_rate_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_start_test_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 	uint status = RNDIS_STATUS_SUCCESS;
 	u32 mode;
 	u8 val8;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
-		return  RNDIS_STATUS_NOT_ACCEPTED;
+		return RNDIS_STATUS_NOT_ACCEPTED;
 	mode = *((u32 *)poid_par_priv->information_buf);
-	Adapter->mppriv.mode = mode;/* 1 for loopback*/
+	Adapter->mppriv.mode = mode; /* 1 for loopback*/
 	if (mp_start_test(Adapter))
 		status = RNDIS_STATUS_NOT_ACCEPTED;
 	r8712_write8(Adapter, MSR, 1); /* Link in ad hoc network, 0x1025004C */
@@ -285,8 +285,8 @@ uint oid_rt_pro_start_test_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_stop_test_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -297,9 +297,9 @@ uint oid_rt_pro_stop_test_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_set_channel_direct_call_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
-	u32		Channel;
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
+	u32 Channel;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -315,8 +315,8 @@ uint oid_rt_pro_set_channel_direct_call_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_set_antenna_bb_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 	u32 antenna;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
@@ -332,8 +332,8 @@ uint oid_rt_pro_set_antenna_bb_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_set_tx_power_control_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 	u32 tx_pwr_idx;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
@@ -350,15 +350,15 @@ uint oid_rt_pro_set_tx_power_control_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_query_tx_packet_sent_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 
 	if (poid_par_priv->information_buf_len == sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =
-					Adapter->mppriv.tx_pktcount;
+			Adapter->mppriv.tx_pktcount;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
 		return RNDIS_STATUS_INVALID_LENGTH;
@@ -368,15 +368,15 @@ uint oid_rt_pro_query_tx_packet_sent_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_query_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 
 	if (poid_par_priv->information_buf_len == sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =
-					Adapter->mppriv.rx_pktcount;
+			Adapter->mppriv.rx_pktcount;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
 		return RNDIS_STATUS_INVALID_LENGTH;
@@ -384,17 +384,18 @@ uint oid_rt_pro_query_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_query_rx_packet_crc32_error_hdl(struct oid_par_priv *poid_par_priv)
+uint oid_rt_pro_query_rx_packet_crc32_error_hdl(
+	struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 
 	if (poid_par_priv->information_buf_len == sizeof(u32)) {
 		*(u32 *)poid_par_priv->information_buf =
-					Adapter->mppriv.rx_crcerrpktcount;
+			Adapter->mppriv.rx_crcerrpktcount;
 		*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	} else {
 		return RNDIS_STATUS_INVALID_LENGTH;
@@ -404,8 +405,8 @@ uint oid_rt_pro_query_rx_packet_crc32_error_hdl(struct oid_par_priv *poid_par_pr
 
 uint oid_rt_pro_reset_tx_packet_sent_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -415,8 +416,8 @@ uint oid_rt_pro_reset_tx_packet_sent_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_reset_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -431,8 +432,8 @@ uint oid_rt_pro_reset_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_reset_phy_rx_packet_count_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -442,38 +443,38 @@ uint oid_rt_reset_phy_rx_packet_count_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_get_phy_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (poid_par_priv->information_buf_len != sizeof(u32))
 		return RNDIS_STATUS_INVALID_LENGTH;
 	*(u32 *)poid_par_priv->information_buf =
-					 r8712_GetPhyRxPktReceived(Adapter);
+		r8712_GetPhyRxPktReceived(Adapter);
 	*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	return RNDIS_STATUS_SUCCESS;
 }
 
 uint oid_rt_get_phy_rx_packet_crc32_error_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (poid_par_priv->information_buf_len != sizeof(u32))
 		return RNDIS_STATUS_INVALID_LENGTH;
 	*(u32 *)poid_par_priv->information_buf =
-					 r8712_GetPhyRxPktCRC32Error(Adapter);
+		r8712_GetPhyRxPktCRC32Error(Adapter);
 	*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	return RNDIS_STATUS_SUCCESS;
 }
 
 uint oid_rt_pro_set_modulation_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -484,9 +485,9 @@ uint oid_rt_pro_set_modulation_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_set_continuous_tx_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
-	u32		bStartTest;
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
+	u32 bStartTest;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -497,9 +498,9 @@ uint oid_rt_pro_set_continuous_tx_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_set_single_carrier_tx_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
-	u32		bStartTest;
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
+	u32 bStartTest;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -508,11 +509,12 @@ uint oid_rt_pro_set_single_carrier_tx_hdl(struct oid_par_priv *poid_par_priv)
 	return RNDIS_STATUS_SUCCESS;
 }
 
-uint oid_rt_pro_set_carrier_suppression_tx_hdl(struct oid_par_priv *poid_par_priv)
+uint oid_rt_pro_set_carrier_suppression_tx_hdl(
+	struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
-	u32		bStartTest;
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
+	u32 bStartTest;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -523,9 +525,9 @@ uint oid_rt_pro_set_carrier_suppression_tx_hdl(struct oid_par_priv *poid_par_pri
 
 uint oid_rt_pro_set_single_tone_tx_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
-	u32		bStartTest;
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
+	u32 bStartTest;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -536,17 +538,17 @@ uint oid_rt_pro_set_single_tone_tx_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 	uint status = RNDIS_STATUS_SUCCESS;
 	struct mp_rw_reg *RegRWStruct;
-	u16		offset;
+	u16 offset;
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	RegRWStruct = (struct mp_rw_reg *)poid_par_priv->information_buf;
-	if ((RegRWStruct->offset >= 0x10250800) &&
-	    (RegRWStruct->offset <= 0x10250FFF)) {
+	if (RegRWStruct->offset >= 0x10250800 &&
+	    RegRWStruct->offset <= 0x10250FFF) {
 		/*baseband register*/
 		/*0ffset :0x800~0xfff*/
 		offset = (u16)(RegRWStruct->offset) & 0xFFF;
@@ -554,16 +556,16 @@ uint oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 	} else {
 		switch (RegRWStruct->width) {
 		case 1:
-			RegRWStruct->value = r8712_read8(Adapter,
-						   RegRWStruct->offset);
+			RegRWStruct->value =
+				r8712_read8(Adapter, RegRWStruct->offset);
 			break;
 		case 2:
-			RegRWStruct->value = r8712_read16(Adapter,
-						    RegRWStruct->offset);
+			RegRWStruct->value =
+				r8712_read16(Adapter, RegRWStruct->offset);
 			break;
 		case 4:
-			RegRWStruct->value = r8712_read32(Adapter,
-						    RegRWStruct->offset);
+			RegRWStruct->value =
+				r8712_read32(Adapter, RegRWStruct->offset);
 			break;
 		default:
 			status = RNDIS_STATUS_NOT_ACCEPTED;
@@ -576,19 +578,19 @@ uint oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 	uint status = RNDIS_STATUS_SUCCESS;
 	struct mp_rw_reg *RegRWStruct;
-	u16		offset;
-	u32		value;
+	u16 offset;
+	u32 value;
 	u32 oldValue = 0;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	RegRWStruct = (struct mp_rw_reg *)poid_par_priv->information_buf;
-	if ((RegRWStruct->offset >= 0x10250800) &&
-	    (RegRWStruct->offset <= 0x10250FFF)) {
+	if (RegRWStruct->offset >= 0x10250800 &&
+	    RegRWStruct->offset <= 0x10250FFF) {
 		/*baseband register*/
 		offset = (u16)(RegRWStruct->offset) & 0xFFF;
 		value = RegRWStruct->value;
@@ -611,15 +613,15 @@ uint oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
 		switch (RegRWStruct->width) {
 		case 1:
 			r8712_write8(Adapter, RegRWStruct->offset,
-			       (unsigned char)RegRWStruct->value);
+				     (unsigned char)RegRWStruct->value);
 			break;
 		case 2:
 			r8712_write16(Adapter, RegRWStruct->offset,
-				(unsigned short)RegRWStruct->value);
+				      (unsigned short)RegRWStruct->value);
 			break;
 		case 4:
 			r8712_write32(Adapter, RegRWStruct->offset,
-				(unsigned int)RegRWStruct->value);
+				      (unsigned int)RegRWStruct->value);
 			break;
 		default:
 			status = RNDIS_STATUS_NOT_ACCEPTED;
@@ -631,8 +633,8 @@ uint oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_get_thermal_meter_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -652,15 +654,15 @@ uint oid_rt_get_thermal_meter_hdl(struct oid_par_priv *poid_par_priv)
 	Adapter->mppriv.workparam.bcompleted = true;
 	Adapter->mppriv.act_in_progress = false;
 	*(u32 *)poid_par_priv->information_buf =
-				 Adapter->mppriv.workparam.io_value;
+		Adapter->mppriv.workparam.io_value;
 	*poid_par_priv->bytes_rw = sizeof(u32);
 	return RNDIS_STATUS_SUCCESS;
 }
 
 uint oid_rt_pro_read_efuse_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	uint status = RNDIS_STATUS_SUCCESS;
 
@@ -678,8 +680,8 @@ uint oid_rt_pro_read_efuse_hdl(struct oid_par_priv *poid_par_priv)
 	cnts = pefuse->cnts;
 	data = pefuse->data;
 	memset(data, 0xFF, cnts);
-	if ((addr > 511) || (cnts < 1) || (cnts > 512) || (addr + cnts) >
-	     EFUSE_MAX_SIZE)
+	if (addr > 511 || cnts < 1 || cnts > 512 ||
+	    (addr + cnts) > EFUSE_MAX_SIZE)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (!r8712_efuse_access(Adapter, true, addr, cnts, data))
 		status = RNDIS_STATUS_FAILURE;
@@ -690,8 +692,8 @@ uint oid_rt_pro_read_efuse_hdl(struct oid_par_priv *poid_par_priv)
 /*------------------------------------------------------------------------*/
 uint oid_rt_pro_write_efuse_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	uint status = RNDIS_STATUS_SUCCESS;
 
@@ -707,7 +709,7 @@ uint oid_rt_pro_write_efuse_hdl(struct oid_par_priv *poid_par_priv)
 	cnts = pefuse->cnts;
 	data = pefuse->data;
 
-	if ((addr > 511) || (cnts < 1) || (cnts > 512) ||
+	if (addr > 511 || cnts < 1 || cnts > 512 ||
 	    (addr + cnts) > r8712_efuse_get_max_size(Adapter))
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (!r8712_efuse_access(Adapter, false, addr, cnts, data))
@@ -719,8 +721,8 @@ uint oid_rt_pro_write_efuse_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_get_efuse_current_size_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
@@ -728,7 +730,7 @@ uint oid_rt_get_efuse_current_size_hdl(struct oid_par_priv *poid_par_priv)
 		return RNDIS_STATUS_INVALID_LENGTH;
 	r8712_efuse_reg_init(Adapter);
 	*(int *)poid_par_priv->information_buf =
-				 r8712_efuse_get_current_size(Adapter);
+		r8712_efuse_get_current_size(Adapter);
 	r8712_efuse_reg_uninit(Adapter);
 	*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	return RNDIS_STATUS_SUCCESS;
@@ -736,15 +738,15 @@ uint oid_rt_get_efuse_current_size_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_get_efuse_max_size_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (poid_par_priv->information_buf_len < sizeof(u32))
 		return RNDIS_STATUS_INVALID_LENGTH;
 	*(int *)poid_par_priv->information_buf =
-					 r8712_efuse_get_max_size(Adapter);
+		r8712_efuse_get_max_size(Adapter);
 	*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	return RNDIS_STATUS_SUCCESS;
 }
@@ -762,10 +764,10 @@ uint oid_rt_pro_efuse_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_pro_efuse_map_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 	uint status = RNDIS_STATUS_SUCCESS;
-	u8		*data;
+	u8 *data;
 
 	*poid_par_priv->bytes_rw = 0;
 	if (poid_par_priv->information_buf_len < EFUSE_MAP_MAX_SIZE)
@@ -780,7 +782,7 @@ uint oid_rt_pro_efuse_map_hdl(struct oid_par_priv *poid_par_priv)
 		/* SET_OID */
 		if (r8712_efuse_reg_init(Adapter)) {
 			if (r8712_efuse_map_write(Adapter, 0,
-			    EFUSE_MAP_MAX_SIZE, data))
+						  EFUSE_MAP_MAX_SIZE, data))
 				*poid_par_priv->bytes_rw = EFUSE_MAP_MAX_SIZE;
 			else
 				status = RNDIS_STATUS_FAILURE;
@@ -794,15 +796,15 @@ uint oid_rt_pro_efuse_map_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_set_bandwidth_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
-	u32		bandwidth;
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
+	u32 bandwidth;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (poid_par_priv->information_buf_len < sizeof(u32))
 		return RNDIS_STATUS_INVALID_LENGTH;
-	bandwidth = *((u32 *)poid_par_priv->information_buf);/*4*/
+	bandwidth = *((u32 *)poid_par_priv->information_buf); /*4*/
 	if (bandwidth != HT_CHANNEL_WIDTH_20)
 		bandwidth = HT_CHANNEL_WIDTH_40;
 	Adapter->mppriv.curr_bandwidth = (u8)bandwidth;
@@ -812,17 +814,17 @@ uint oid_rt_set_bandwidth_hdl(struct oid_par_priv *poid_par_priv)
 
 uint oid_rt_set_rx_packet_type_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
-	u8		rx_pkt_type;
-	u32		rcr_val32;
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
+	u8 rx_pkt_type;
+	u32 rcr_val32;
 
 	if (poid_par_priv->type_of_oid != SET_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (poid_par_priv->information_buf_len < sizeof(u8))
 		return RNDIS_STATUS_INVALID_LENGTH;
-	rx_pkt_type = *((u8 *)poid_par_priv->information_buf);/*4*/
-	rcr_val32 = r8712_read32(Adapter, RCR);/*RCR = 0x10250048*/
+	rx_pkt_type = *((u8 *)poid_par_priv->information_buf); /*4*/
+	rcr_val32 = r8712_read32(Adapter, RCR); /*RCR = 0x10250048*/
 	rcr_val32 &= ~(RCR_CBSSID | RCR_AB | RCR_AM | RCR_APM | RCR_AAP);
 	switch (rx_pkt_type) {
 	case RX_PKT_BROADCAST:
@@ -835,11 +837,8 @@ uint oid_rt_set_rx_packet_type_hdl(struct oid_par_priv *poid_par_priv)
 		rcr_val32 |= (RCR_APM | RCR_ACRC32);
 		break;
 	default:
-		rcr_val32 &= ~(RCR_AAP |
-			       RCR_APM |
-			       RCR_AM |
-			       RCR_AB |
-			       RCR_ACRC32);
+		rcr_val32 &=
+			~(RCR_AAP | RCR_APM | RCR_AM | RCR_AB | RCR_ACRC32);
 		break;
 	}
 	if (rx_pkt_type == RX_PKT_DEST_ADDR)
@@ -869,15 +868,15 @@ uint oid_rt_set_power_down_hdl(struct oid_par_priv *poid_par_priv)
 /*-------------------------------------------------------------------------- */
 uint oid_rt_get_power_mode_hdl(struct oid_par_priv *poid_par_priv)
 {
-	struct _adapter *Adapter = (struct _adapter *)
-				   (poid_par_priv->adapter_context);
+	struct _adapter *Adapter =
+		(struct _adapter *)(poid_par_priv->adapter_context);
 
 	if (poid_par_priv->type_of_oid != QUERY_OID)
 		return RNDIS_STATUS_NOT_ACCEPTED;
 	if (poid_par_priv->information_buf_len < sizeof(u32))
 		return RNDIS_STATUS_INVALID_LENGTH;
 	*(int *)poid_par_priv->information_buf =
-		 Adapter->registrypriv.low_power ? POWER_LOW : POWER_NORMAL;
+		Adapter->registrypriv.low_power ? POWER_LOW : POWER_NORMAL;
 	*poid_par_priv->bytes_rw = poid_par_priv->information_buf_len;
 	return RNDIS_STATUS_SUCCESS;
 }
diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.h b/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
index aa4d5ce471f2..3d1038eeaa14 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
+++ b/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
@@ -21,11 +21,11 @@
 #include "rtl871x_ioctl_rtl.h"
 #include "rtl8712_efuse.h"
 
-#define TESTFWCMDNUMBER			1000000
-#define TEST_H2CINT_WAIT_TIME		500
-#define TEST_C2HINT_WAIT_TIME		500
-#define HCI_TEST_SYSCFG_HWMASK		1
-#define _BUSCLK_40M			(4 << 2)
+#define TESTFWCMDNUMBER 1000000
+#define TEST_H2CINT_WAIT_TIME 500
+#define TEST_C2HINT_WAIT_TIME 500
+#define HCI_TEST_SYSCFG_HWMASK 1
+#define _BUSCLK_40M (4 << 2)
 
 struct CFG_DBG_MSG_STRUCT {
 	u32 DebugLevel;
@@ -46,9 +46,9 @@ struct eeprom_rw_param {
 };
 
 struct EFUSE_ACCESS_STRUCT {
-	u16	start_addr;
-	u16	cnts;
-	u8	data[];
+	u16 start_addr;
+	u16 cnts;
+	u8 data[];
 };
 
 struct burst_rw_reg {
@@ -58,12 +58,12 @@ struct burst_rw_reg {
 };
 
 struct usb_vendor_req {
-	u8	bRequest;
-	u16	wValue;
-	u16	wIndex;
-	u16	wLength;
-	u8	u8Dir;/*0:OUT, 1:IN */
-	u8	u8InData;
+	u8 bRequest;
+	u16 wValue;
+	u16 wIndex;
+	u16 wLength;
+	u8 u8Dir; /*0:OUT, 1:IN */
+	u8 u8InData;
 };
 
 struct DR_VARIABLE_STRUCT {
@@ -75,36 +75,25 @@ struct DR_VARIABLE_STRUCT {
 uint oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv);
 /* oid_rtl_seg_81_80_00 */
-uint oid_rt_pro_set_data_rate_hdl(
-				struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_set_data_rate_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_pro_start_test_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_pro_stop_test_hdl(struct oid_par_priv *poid_par_priv);
-uint oid_rt_pro_set_channel_direct_call_hdl(
-				struct oid_par_priv *poid_par_priv);
-uint oid_rt_pro_set_antenna_bb_hdl(
-				struct oid_par_priv *poid_par_priv);
-uint oid_rt_pro_set_tx_power_control_hdl(
-				struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_set_channel_direct_call_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_set_antenna_bb_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_set_tx_power_control_hdl(struct oid_par_priv *poid_par_priv);
 /* oid_rtl_seg_81_80_20 */
-uint oid_rt_pro_query_tx_packet_sent_hdl(
-				struct oid_par_priv *poid_par_priv);
-uint oid_rt_pro_query_rx_packet_received_hdl(
-				struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_query_tx_packet_sent_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_query_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_pro_query_rx_packet_crc32_error_hdl(
-				struct oid_par_priv *poid_par_priv);
-uint oid_rt_pro_reset_tx_packet_sent_hdl(
-				struct oid_par_priv *poid_par_priv);
-uint oid_rt_pro_reset_rx_packet_received_hdl(
-				struct oid_par_priv *poid_par_priv);
+	struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_reset_tx_packet_sent_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_reset_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_pro_set_modulation_hdl(struct oid_par_priv *poid_par_priv);
-uint oid_rt_pro_set_continuous_tx_hdl(
-				struct oid_par_priv *poid_par_priv);
-uint oid_rt_pro_set_single_carrier_tx_hdl(
-				struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_set_continuous_tx_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_set_single_carrier_tx_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_pro_set_carrier_suppression_tx_hdl(
-				struct oid_par_priv *poid_par_priv);
-uint oid_rt_pro_set_single_tone_tx_hdl(
-				struct oid_par_priv *poid_par_priv);
+	struct oid_par_priv *poid_par_priv);
+uint oid_rt_pro_set_single_tone_tx_hdl(struct oid_par_priv *poid_par_priv);
 /* oid_rtl_seg_81_87 */
 uint oid_rt_pro_write_bb_reg_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_pro_read_bb_reg_hdl(struct oid_par_priv *poid_par_priv);
@@ -114,25 +103,19 @@ uint oid_rt_pro_read_rf_reg_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_wireless_mode_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_pro_read_efuse_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_pro_write_efuse_hdl(struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_efuse_current_size_hdl(
-				struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_efuse_current_size_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_pro_efuse_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_pro_efuse_map_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_set_bandwidth_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_set_rx_packet_type_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_get_efuse_max_size_hdl(struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_thermal_meter_hdl(
-				struct oid_par_priv *poid_par_priv);
-uint oid_rt_reset_phy_rx_packet_count_hdl(
-				struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_phy_rx_packet_received_hdl(
-				struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_thermal_meter_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_reset_phy_rx_packet_count_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_phy_rx_packet_received_hdl(struct oid_par_priv *poid_par_priv);
 uint oid_rt_get_phy_rx_packet_crc32_error_hdl(
-				struct oid_par_priv *poid_par_priv);
-uint oid_rt_set_power_down_hdl(
-				struct oid_par_priv *poid_par_priv);
-uint oid_rt_get_power_mode_hdl(
-				struct oid_par_priv *poid_par_priv);
+	struct oid_par_priv *poid_par_priv);
+uint oid_rt_set_power_down_hdl(struct oid_par_priv *poid_par_priv);
+uint oid_rt_get_power_mode_hdl(struct oid_par_priv *poid_par_priv);
 #ifdef _RTL871X_MP_IOCTL_C_ /* CAUTION!!! */
 /* This ifdef _MUST_ be left in!! */
 
@@ -148,11 +131,7 @@ extern struct oid_obj_priv oid_rtl_seg_87_12_00[32];
 
 #endif /* _RTL871X_MP_IOCTL_C_ */
 
-enum MP_MODE {
-	MP_START_MODE,
-	MP_STOP_MODE,
-	MP_ERR_MODE
-};
+enum MP_MODE { MP_START_MODE, MP_STOP_MODE, MP_ERR_MODE };
 
 struct rwreg_param {
 	unsigned int offset;
@@ -199,44 +178,44 @@ struct mp_ioctl_param {
 	unsigned char data[];
 };
 
-#define GEN_MP_IOCTL_SUBCODE(code) _MP_IOCTL_ ## code ## _CMD_
+#define GEN_MP_IOCTL_SUBCODE(code) _MP_IOCTL_##code##_CMD_
 
 enum RTL871X_MP_IOCTL_SUBCODE {
-	GEN_MP_IOCTL_SUBCODE(MP_START),			/*0*/
-	GEN_MP_IOCTL_SUBCODE(MP_STOP),			/*1*/
-	GEN_MP_IOCTL_SUBCODE(READ_REG),			/*2*/
+	GEN_MP_IOCTL_SUBCODE(MP_START), /*0*/
+	GEN_MP_IOCTL_SUBCODE(MP_STOP), /*1*/
+	GEN_MP_IOCTL_SUBCODE(READ_REG), /*2*/
 	GEN_MP_IOCTL_SUBCODE(WRITE_REG),
-	GEN_MP_IOCTL_SUBCODE(SET_CHANNEL),		/*4*/
-	GEN_MP_IOCTL_SUBCODE(SET_TXPOWER),		/*5*/
-	GEN_MP_IOCTL_SUBCODE(SET_DATARATE),		/*6*/
-	GEN_MP_IOCTL_SUBCODE(READ_BB_REG),		/*7*/
+	GEN_MP_IOCTL_SUBCODE(SET_CHANNEL), /*4*/
+	GEN_MP_IOCTL_SUBCODE(SET_TXPOWER), /*5*/
+	GEN_MP_IOCTL_SUBCODE(SET_DATARATE), /*6*/
+	GEN_MP_IOCTL_SUBCODE(READ_BB_REG), /*7*/
 	GEN_MP_IOCTL_SUBCODE(WRITE_BB_REG),
-	GEN_MP_IOCTL_SUBCODE(READ_RF_REG),		/*9*/
+	GEN_MP_IOCTL_SUBCODE(READ_RF_REG), /*9*/
 	GEN_MP_IOCTL_SUBCODE(WRITE_RF_REG),
 	GEN_MP_IOCTL_SUBCODE(SET_RF_INTFS),
-	GEN_MP_IOCTL_SUBCODE(IOCTL_XMIT_PACKET),	/*12*/
-	GEN_MP_IOCTL_SUBCODE(PS_STATE),			/*13*/
-	GEN_MP_IOCTL_SUBCODE(READ16_EEPROM),		/*14*/
-	GEN_MP_IOCTL_SUBCODE(WRITE16_EEPROM),		/*15*/
-	GEN_MP_IOCTL_SUBCODE(SET_PTM),			/*16*/
-	GEN_MP_IOCTL_SUBCODE(READ_TSSI),		/*17*/
-	GEN_MP_IOCTL_SUBCODE(CNTU_TX),			/*18*/
-	GEN_MP_IOCTL_SUBCODE(SET_BANDWIDTH),		/*19*/
-	GEN_MP_IOCTL_SUBCODE(SET_RX_PKT_TYPE),		/*20*/
-	GEN_MP_IOCTL_SUBCODE(RESET_PHY_RX_PKT_CNT),	/*21*/
-	GEN_MP_IOCTL_SUBCODE(GET_PHY_RX_PKT_RECV),	/*22*/
-	GEN_MP_IOCTL_SUBCODE(GET_PHY_RX_PKT_ERROR),	/*23*/
-	GEN_MP_IOCTL_SUBCODE(SET_POWER_DOWN),		/*24*/
-	GEN_MP_IOCTL_SUBCODE(GET_THERMAL_METER),	/*25*/
-	GEN_MP_IOCTL_SUBCODE(GET_POWER_MODE),		/*26*/
-	GEN_MP_IOCTL_SUBCODE(EFUSE),			/*27*/
-	GEN_MP_IOCTL_SUBCODE(EFUSE_MAP),		/*28*/
-	GEN_MP_IOCTL_SUBCODE(GET_EFUSE_MAX_SIZE),	/*29*/
-	GEN_MP_IOCTL_SUBCODE(GET_EFUSE_CURRENT_SIZE),	/*30*/
-	GEN_MP_IOCTL_SUBCODE(SC_TX),			/*31*/
-	GEN_MP_IOCTL_SUBCODE(CS_TX),			/*32*/
-	GEN_MP_IOCTL_SUBCODE(ST_TX),			/*33*/
-	GEN_MP_IOCTL_SUBCODE(SET_ANTENNA),		/*34*/
+	GEN_MP_IOCTL_SUBCODE(IOCTL_XMIT_PACKET), /*12*/
+	GEN_MP_IOCTL_SUBCODE(PS_STATE), /*13*/
+	GEN_MP_IOCTL_SUBCODE(READ16_EEPROM), /*14*/
+	GEN_MP_IOCTL_SUBCODE(WRITE16_EEPROM), /*15*/
+	GEN_MP_IOCTL_SUBCODE(SET_PTM), /*16*/
+	GEN_MP_IOCTL_SUBCODE(READ_TSSI), /*17*/
+	GEN_MP_IOCTL_SUBCODE(CNTU_TX), /*18*/
+	GEN_MP_IOCTL_SUBCODE(SET_BANDWIDTH), /*19*/
+	GEN_MP_IOCTL_SUBCODE(SET_RX_PKT_TYPE), /*20*/
+	GEN_MP_IOCTL_SUBCODE(RESET_PHY_RX_PKT_CNT), /*21*/
+	GEN_MP_IOCTL_SUBCODE(GET_PHY_RX_PKT_RECV), /*22*/
+	GEN_MP_IOCTL_SUBCODE(GET_PHY_RX_PKT_ERROR), /*23*/
+	GEN_MP_IOCTL_SUBCODE(SET_POWER_DOWN), /*24*/
+	GEN_MP_IOCTL_SUBCODE(GET_THERMAL_METER), /*25*/
+	GEN_MP_IOCTL_SUBCODE(GET_POWER_MODE), /*26*/
+	GEN_MP_IOCTL_SUBCODE(EFUSE), /*27*/
+	GEN_MP_IOCTL_SUBCODE(EFUSE_MAP), /*28*/
+	GEN_MP_IOCTL_SUBCODE(GET_EFUSE_MAX_SIZE), /*29*/
+	GEN_MP_IOCTL_SUBCODE(GET_EFUSE_CURRENT_SIZE), /*30*/
+	GEN_MP_IOCTL_SUBCODE(SC_TX), /*31*/
+	GEN_MP_IOCTL_SUBCODE(CS_TX), /*32*/
+	GEN_MP_IOCTL_SUBCODE(ST_TX), /*33*/
+	GEN_MP_IOCTL_SUBCODE(SET_ANTENNA), /*34*/
 	MAX_MP_IOCTL_SUBCODE,
 };
 
@@ -246,78 +225,65 @@ unsigned int mp_ioctl_xmit_packet_hdl(struct oid_par_priv *poid_par_priv);
 /* This ifdef _MUST_ be left in!! */
 
 static struct mp_ioctl_handler mp_ioctl_hdl[] = {
-	{sizeof(u32), oid_rt_pro_start_test_hdl,
-			     OID_RT_PRO_START_TEST},/*0*/
-	{sizeof(u32), oid_rt_pro_stop_test_hdl,
-			     OID_RT_PRO_STOP_TEST},/*1*/
-	{sizeof(struct rwreg_param),
-			     oid_rt_pro_read_register_hdl,
-			     OID_RT_PRO_READ_REGISTER},/*2*/
-	{sizeof(struct rwreg_param),
-			     oid_rt_pro_write_register_hdl,
-			     OID_RT_PRO_WRITE_REGISTER},
-	{sizeof(u32),
-			     oid_rt_pro_set_channel_direct_call_hdl,
-			     OID_RT_PRO_SET_CHANNEL_DIRECT_CALL},
-	{sizeof(struct txpower_param),
-			     oid_rt_pro_set_tx_power_control_hdl,
-			     OID_RT_PRO_SET_TX_POWER_CONTROL},
-	{sizeof(u32),
-			     oid_rt_pro_set_data_rate_hdl,
-			     OID_RT_PRO_SET_DATA_RATE},
-	{sizeof(struct bb_reg_param),
-			     oid_rt_pro_read_bb_reg_hdl,
-			     OID_RT_PRO_READ_BB_REG},/*7*/
-	{sizeof(struct bb_reg_param),
-			     oid_rt_pro_write_bb_reg_hdl,
-			     OID_RT_PRO_WRITE_BB_REG},
-	{sizeof(struct rwreg_param),
-			     oid_rt_pro_read_rf_reg_hdl,
-			     OID_RT_PRO_RF_READ_REGISTRY},/*9*/
-	{sizeof(struct rwreg_param),
-			     oid_rt_pro_write_rf_reg_hdl,
-			     OID_RT_PRO_RF_WRITE_REGISTRY},
-	{sizeof(struct rfintfs_parm), NULL, 0},
-	{0, mp_ioctl_xmit_packet_hdl, 0},/*12*/
-	{sizeof(struct psmode_param), NULL, 0},/*13*/
-	{sizeof(struct eeprom_rw_param), NULL, 0},/*14*/
-	{sizeof(struct eeprom_rw_param), NULL, 0},/*15*/
-	{sizeof(unsigned char), NULL, 0},/*16*/
-	{sizeof(u32), NULL, 0},/*17*/
-	{sizeof(u32), oid_rt_pro_set_continuous_tx_hdl,
-			     OID_RT_PRO_SET_CONTINUOUS_TX},/*18*/
-	{sizeof(u32), oid_rt_set_bandwidth_hdl,
-			     OID_RT_SET_BANDWIDTH},/*19*/
-	{sizeof(u32), oid_rt_set_rx_packet_type_hdl,
-			     OID_RT_SET_RX_PACKET_TYPE},/*20*/
-	{0, oid_rt_reset_phy_rx_packet_count_hdl,
-			     OID_RT_RESET_PHY_RX_PACKET_COUNT},/*21*/
-	{sizeof(u32), oid_rt_get_phy_rx_packet_received_hdl,
-			     OID_RT_GET_PHY_RX_PACKET_RECEIVED},/*22*/
-	{sizeof(u32), oid_rt_get_phy_rx_packet_crc32_error_hdl,
-			     OID_RT_GET_PHY_RX_PACKET_CRC32_ERROR},/*23*/
-	{sizeof(unsigned char), oid_rt_set_power_down_hdl,
-			     OID_RT_SET_POWER_DOWN},/*24*/
-	{sizeof(u32), oid_rt_get_thermal_meter_hdl,
-			     OID_RT_PRO_GET_THERMAL_METER},/*25*/
-	{sizeof(u32), oid_rt_get_power_mode_hdl,
-			     OID_RT_GET_POWER_MODE},/*26*/
-	{sizeof(struct EFUSE_ACCESS_STRUCT),
-			     oid_rt_pro_efuse_hdl, OID_RT_PRO_EFUSE},/*27*/
-	{EFUSE_MAP_MAX_SIZE, oid_rt_pro_efuse_map_hdl,
-			     OID_RT_PRO_EFUSE_MAP},/*28*/
-	{sizeof(u32), oid_rt_get_efuse_max_size_hdl,
-			     OID_RT_GET_EFUSE_MAX_SIZE},/*29*/
-	{sizeof(u32), oid_rt_get_efuse_current_size_hdl,
-			     OID_RT_GET_EFUSE_CURRENT_SIZE},/*30*/
-	{sizeof(u32), oid_rt_pro_set_single_carrier_tx_hdl,
-			     OID_RT_PRO_SET_SINGLE_CARRIER_TX},/*31*/
-	{sizeof(u32), oid_rt_pro_set_carrier_suppression_tx_hdl,
-			     OID_RT_PRO_SET_CARRIER_SUPPRESSION_TX},/*32*/
-	{sizeof(u32), oid_rt_pro_set_single_tone_tx_hdl,
-			     OID_RT_PRO_SET_SINGLE_TONE_TX},/*33*/
-	{sizeof(u32), oid_rt_pro_set_antenna_bb_hdl,
-			     OID_RT_PRO_SET_ANTENNA_BB},/*34*/
+	{ sizeof(u32), oid_rt_pro_start_test_hdl, OID_RT_PRO_START_TEST }, /*0*/
+	{ sizeof(u32), oid_rt_pro_stop_test_hdl, OID_RT_PRO_STOP_TEST }, /*1*/
+	{ sizeof(struct rwreg_param), oid_rt_pro_read_register_hdl,
+	  OID_RT_PRO_READ_REGISTER }, /*2*/
+	{ sizeof(struct rwreg_param), oid_rt_pro_write_register_hdl,
+	  OID_RT_PRO_WRITE_REGISTER },
+	{ sizeof(u32), oid_rt_pro_set_channel_direct_call_hdl,
+	  OID_RT_PRO_SET_CHANNEL_DIRECT_CALL },
+	{ sizeof(struct txpower_param), oid_rt_pro_set_tx_power_control_hdl,
+	  OID_RT_PRO_SET_TX_POWER_CONTROL },
+	{ sizeof(u32), oid_rt_pro_set_data_rate_hdl, OID_RT_PRO_SET_DATA_RATE },
+	{ sizeof(struct bb_reg_param), oid_rt_pro_read_bb_reg_hdl,
+	  OID_RT_PRO_READ_BB_REG }, /*7*/
+	{ sizeof(struct bb_reg_param), oid_rt_pro_write_bb_reg_hdl,
+	  OID_RT_PRO_WRITE_BB_REG },
+	{ sizeof(struct rwreg_param), oid_rt_pro_read_rf_reg_hdl,
+	  OID_RT_PRO_RF_READ_REGISTRY }, /*9*/
+	{ sizeof(struct rwreg_param), oid_rt_pro_write_rf_reg_hdl,
+	  OID_RT_PRO_RF_WRITE_REGISTRY },
+	{ sizeof(struct rfintfs_parm), NULL, 0 },
+	{ 0, mp_ioctl_xmit_packet_hdl, 0 }, /*12*/
+	{ sizeof(struct psmode_param), NULL, 0 }, /*13*/
+	{ sizeof(struct eeprom_rw_param), NULL, 0 }, /*14*/
+	{ sizeof(struct eeprom_rw_param), NULL, 0 }, /*15*/
+	{ sizeof(unsigned char), NULL, 0 }, /*16*/
+	{ sizeof(u32), NULL, 0 }, /*17*/
+	{ sizeof(u32), oid_rt_pro_set_continuous_tx_hdl,
+	  OID_RT_PRO_SET_CONTINUOUS_TX }, /*18*/
+	{ sizeof(u32), oid_rt_set_bandwidth_hdl, OID_RT_SET_BANDWIDTH }, /*19*/
+	{ sizeof(u32), oid_rt_set_rx_packet_type_hdl,
+	  OID_RT_SET_RX_PACKET_TYPE }, /*20*/
+	{ 0, oid_rt_reset_phy_rx_packet_count_hdl,
+	  OID_RT_RESET_PHY_RX_PACKET_COUNT }, /*21*/
+	{ sizeof(u32), oid_rt_get_phy_rx_packet_received_hdl,
+	  OID_RT_GET_PHY_RX_PACKET_RECEIVED }, /*22*/
+	{ sizeof(u32), oid_rt_get_phy_rx_packet_crc32_error_hdl,
+	  OID_RT_GET_PHY_RX_PACKET_CRC32_ERROR }, /*23*/
+	{ sizeof(unsigned char), oid_rt_set_power_down_hdl,
+	  OID_RT_SET_POWER_DOWN }, /*24*/
+	{ sizeof(u32), oid_rt_get_thermal_meter_hdl,
+	  OID_RT_PRO_GET_THERMAL_METER }, /*25*/
+	{ sizeof(u32), oid_rt_get_power_mode_hdl,
+	  OID_RT_GET_POWER_MODE }, /*26*/
+	{ sizeof(struct EFUSE_ACCESS_STRUCT), oid_rt_pro_efuse_hdl,
+	  OID_RT_PRO_EFUSE }, /*27*/
+	{ EFUSE_MAP_MAX_SIZE, oid_rt_pro_efuse_map_hdl,
+	  OID_RT_PRO_EFUSE_MAP }, /*28*/
+	{ sizeof(u32), oid_rt_get_efuse_max_size_hdl,
+	  OID_RT_GET_EFUSE_MAX_SIZE }, /*29*/
+	{ sizeof(u32), oid_rt_get_efuse_current_size_hdl,
+	  OID_RT_GET_EFUSE_CURRENT_SIZE }, /*30*/
+	{ sizeof(u32), oid_rt_pro_set_single_carrier_tx_hdl,
+	  OID_RT_PRO_SET_SINGLE_CARRIER_TX }, /*31*/
+	{ sizeof(u32), oid_rt_pro_set_carrier_suppression_tx_hdl,
+	  OID_RT_PRO_SET_CARRIER_SUPPRESSION_TX }, /*32*/
+	{ sizeof(u32), oid_rt_pro_set_single_tone_tx_hdl,
+	  OID_RT_PRO_SET_SINGLE_TONE_TX }, /*33*/
+	{ sizeof(u32), oid_rt_pro_set_antenna_bb_hdl,
+	  OID_RT_PRO_SET_ANTENNA_BB }, /*34*/
 };
 
 #else /* _RTL871X_MP_IOCTL_C_ */
@@ -325,4 +291,3 @@ extern struct mp_ioctl_handler mp_ioctl_hdl[];
 #endif /* _RTL871X_MP_IOCTL_C_ */
 
 #endif
-
diff --git a/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h b/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
index bb9f83d58225..cd43384b6603 100644
--- a/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
+++ b/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
@@ -43,33 +43,33 @@
  * 1. PMAC duplicate register due to connection: RF_Mode, TRxRN, NumOf L-STF
  * 1. Page1(0x100)
  */
-#define	rPMAC_Reset			0x100
-#define	rPMAC_TxStart			0x104
-#define	rPMAC_TxLegacySIG		0x108
-#define	rPMAC_TxHTSIG1			0x10c
-#define	rPMAC_TxHTSIG2			0x110
-#define	rPMAC_PHYDebug			0x114
-#define	rPMAC_TxPacketNum		0x118
-#define	rPMAC_TxIdle			0x11c
-#define	rPMAC_TxMACHeader0		0x120
-#define	rPMAC_TxMACHeader1		0x124
-#define	rPMAC_TxMACHeader2		0x128
-#define	rPMAC_TxMACHeader3		0x12c
-#define	rPMAC_TxMACHeader4		0x130
-#define	rPMAC_TxMACHeader5		0x134
-#define	rPMAC_TxDataType		0x138
-#define	rPMAC_TxRandomSeed		0x13c
-#define	rPMAC_CCKPLCPPreamble		0x140
-#define	rPMAC_CCKPLCPHeader		0x144
-#define	rPMAC_CCKCRC16			0x148
-#define	rPMAC_OFDMRxCRC32OK		0x170
-#define	rPMAC_OFDMRxCRC32Er		0x174
-#define	rPMAC_OFDMRxParityEr		0x178
-#define	rPMAC_OFDMRxCRC8Er		0x17c
-#define	rPMAC_CCKCRxRC16Er		0x180
-#define	rPMAC_CCKCRxRC32Er		0x184
-#define	rPMAC_CCKCRxRC32OK		0x188
-#define	rPMAC_TxStatus			0x18c
+#define rPMAC_Reset 0x100
+#define rPMAC_TxStart 0x104
+#define rPMAC_TxLegacySIG 0x108
+#define rPMAC_TxHTSIG1 0x10c
+#define rPMAC_TxHTSIG2 0x110
+#define rPMAC_PHYDebug 0x114
+#define rPMAC_TxPacketNum 0x118
+#define rPMAC_TxIdle 0x11c
+#define rPMAC_TxMACHeader0 0x120
+#define rPMAC_TxMACHeader1 0x124
+#define rPMAC_TxMACHeader2 0x128
+#define rPMAC_TxMACHeader3 0x12c
+#define rPMAC_TxMACHeader4 0x130
+#define rPMAC_TxMACHeader5 0x134
+#define rPMAC_TxDataType 0x138
+#define rPMAC_TxRandomSeed 0x13c
+#define rPMAC_CCKPLCPPreamble 0x140
+#define rPMAC_CCKPLCPHeader 0x144
+#define rPMAC_CCKCRC16 0x148
+#define rPMAC_OFDMRxCRC32OK 0x170
+#define rPMAC_OFDMRxCRC32Er 0x174
+#define rPMAC_OFDMRxParityEr 0x178
+#define rPMAC_OFDMRxCRC8Er 0x17c
+#define rPMAC_CCKCRxRC16Er 0x180
+#define rPMAC_CCKCRxRC32Er 0x184
+#define rPMAC_CCKCRxRC32OK 0x188
+#define rPMAC_TxStatus 0x18c
 
 /*
  * 2. Page2(0x200)
@@ -81,68 +81,70 @@
  *
  * 3. Page8(0x800)
  */
-#define	rFPGA0_RFMOD			0x800	/*RF mode & CCK TxSC RF
+#define rFPGA0_RFMOD \
+	0x800 /*RF mode & CCK TxSC RF
 						 * BW Setting??
 						 */
-#define	rFPGA0_TxInfo			0x804	/* Status report?? */
-#define	rFPGA0_PSDFunction		0x808
-#define	rFPGA0_TxGainStage		0x80c	/* Set TX PWR init gain? */
-#define	rFPGA0_RFTiming1		0x810	/* Useless now */
-#define	rFPGA0_RFTiming2		0x814
-#define	rFPGA0_XA_HSSIParameter1	0x820	/* RF 3 wire register */
-#define	rFPGA0_XA_HSSIParameter2	0x824
-#define	rFPGA0_XB_HSSIParameter1	0x828
-#define	rFPGA0_XB_HSSIParameter2	0x82c
-#define	rFPGA0_XC_HSSIParameter1	0x830
-#define	rFPGA0_XC_HSSIParameter2	0x834
-#define	rFPGA0_XD_HSSIParameter1	0x838
-#define	rFPGA0_XD_HSSIParameter2	0x83c
-#define	rFPGA0_XA_LSSIParameter		0x840
-#define	rFPGA0_XB_LSSIParameter		0x844
-#define	rFPGA0_XC_LSSIParameter		0x848
-#define	rFPGA0_XD_LSSIParameter		0x84c
-
-#define	rFPGA0_RFWakeUpParameter	0x850	/* Useless now */
-#define	rFPGA0_RFSleepUpParameter	0x854
-
-#define	rFPGA0_XAB_SwitchControl	0x858	/* RF Channel switch */
-#define	rFPGA0_XCD_SwitchControl	0x85c
-
-#define	rFPGA0_XA_RFInterfaceOE		0x860	/* RF Channel switch */
-#define	rFPGA0_XB_RFInterfaceOE		0x864
-#define	rFPGA0_XC_RFInterfaceOE		0x868
-#define	rFPGA0_XD_RFInterfaceOE		0x86c
-#define	rFPGA0_XAB_RFInterfaceSW	0x870	/* RF Interface Software Ctrl */
-#define	rFPGA0_XCD_RFInterfaceSW	0x874
-
-#define	rFPGA0_XAB_RFParameter		0x878	/* RF Parameter */
-#define	rFPGA0_XCD_RFParameter		0x87c
-
-#define	rFPGA0_AnalogParameter1		0x880	/* Crystal cap setting
+#define rFPGA0_TxInfo 0x804 /* Status report?? */
+#define rFPGA0_PSDFunction 0x808
+#define rFPGA0_TxGainStage 0x80c /* Set TX PWR init gain? */
+#define rFPGA0_RFTiming1 0x810 /* Useless now */
+#define rFPGA0_RFTiming2 0x814
+#define rFPGA0_XA_HSSIParameter1 0x820 /* RF 3 wire register */
+#define rFPGA0_XA_HSSIParameter2 0x824
+#define rFPGA0_XB_HSSIParameter1 0x828
+#define rFPGA0_XB_HSSIParameter2 0x82c
+#define rFPGA0_XC_HSSIParameter1 0x830
+#define rFPGA0_XC_HSSIParameter2 0x834
+#define rFPGA0_XD_HSSIParameter1 0x838
+#define rFPGA0_XD_HSSIParameter2 0x83c
+#define rFPGA0_XA_LSSIParameter 0x840
+#define rFPGA0_XB_LSSIParameter 0x844
+#define rFPGA0_XC_LSSIParameter 0x848
+#define rFPGA0_XD_LSSIParameter 0x84c
+
+#define rFPGA0_RFWakeUpParameter 0x850 /* Useless now */
+#define rFPGA0_RFSleepUpParameter 0x854
+
+#define rFPGA0_XAB_SwitchControl 0x858 /* RF Channel switch */
+#define rFPGA0_XCD_SwitchControl 0x85c
+
+#define rFPGA0_XA_RFInterfaceOE 0x860 /* RF Channel switch */
+#define rFPGA0_XB_RFInterfaceOE 0x864
+#define rFPGA0_XC_RFInterfaceOE 0x868
+#define rFPGA0_XD_RFInterfaceOE 0x86c
+#define rFPGA0_XAB_RFInterfaceSW 0x870 /* RF Interface Software Ctrl */
+#define rFPGA0_XCD_RFInterfaceSW 0x874
+
+#define rFPGA0_XAB_RFParameter 0x878 /* RF Parameter */
+#define rFPGA0_XCD_RFParameter 0x87c
+
+#define rFPGA0_AnalogParameter1 \
+	0x880 /* Crystal cap setting
 						 * RF-R/W protection
 						 * for parameter4??
 						 */
-#define	rFPGA0_AnalogParameter2		0x884
-#define	rFPGA0_AnalogParameter3		0x888	/* Useless now */
-#define	rFPGA0_AnalogParameter4		0x88c
+#define rFPGA0_AnalogParameter2 0x884
+#define rFPGA0_AnalogParameter3 0x888 /* Useless now */
+#define rFPGA0_AnalogParameter4 0x88c
 
-#define	rFPGA0_XA_LSSIReadBack		0x8a0	/* Transceiver LSSI Readback */
-#define	rFPGA0_XB_LSSIReadBack		0x8a4
-#define	rFPGA0_XC_LSSIReadBack		0x8a8
-#define	rFPGA0_XD_LSSIReadBack		0x8ac
+#define rFPGA0_XA_LSSIReadBack 0x8a0 /* Transceiver LSSI Readback */
+#define rFPGA0_XB_LSSIReadBack 0x8a4
+#define rFPGA0_XC_LSSIReadBack 0x8a8
+#define rFPGA0_XD_LSSIReadBack 0x8ac
 
-#define	rFPGA0_PSDReport		0x8b4	/* Useless now */
-#define	rFPGA0_XAB_RFInterfaceRB	0x8e0	/* Useless now */
-#define	rFPGA0_XCD_RFInterfaceRB	0x8e4	/* Useless now */
+#define rFPGA0_PSDReport 0x8b4 /* Useless now */
+#define rFPGA0_XAB_RFInterfaceRB 0x8e0 /* Useless now */
+#define rFPGA0_XCD_RFInterfaceRB 0x8e4 /* Useless now */
 
 /*
  * 4. Page9(0x900)
  */
-#define	rFPGA1_RFMOD			0x900	/* RF mode & OFDM TxSC */
+#define rFPGA1_RFMOD 0x900 /* RF mode & OFDM TxSC */
 
-#define	rFPGA1_TxBlock			0x904	/* Useless now */
-#define	rFPGA1_DebugSelect		0x908	/* Useless now */
-#define	rFPGA1_TxInfo			0x90c	/* Useless now */
+#define rFPGA1_TxBlock 0x904 /* Useless now */
+#define rFPGA1_DebugSelect 0x908 /* Useless now */
+#define rFPGA1_TxInfo 0x90c /* Useless now */
 
 /*
  * 5. PageA(0xA00)
@@ -150,151 +152,155 @@
  * Set Control channel to upper or lower.
  * These settings are required only for 40MHz
  */
-#define	rCCK0_System			0xa00
+#define rCCK0_System 0xa00
 
-#define	rCCK0_AFESetting		0xa04	/* Disable init gain now */
-#define	rCCK0_CCA			0xa08	/* Disable init gain now */
+#define rCCK0_AFESetting 0xa04 /* Disable init gain now */
+#define rCCK0_CCA 0xa08 /* Disable init gain now */
 
-#define	rCCK0_RxAGC1			0xa0c
+#define rCCK0_RxAGC1 0xa0c
 /* AGC default value, saturation level
  * Antenna Diversity, RX AGC, LNA Threshold, RX LNA Threshold useless now.
  * Not the same as 90 series
  */
-#define	rCCK0_RxAGC2			0xa10	/* AGC & DAGC */
+#define rCCK0_RxAGC2 0xa10 /* AGC & DAGC */
 
-#define	rCCK0_RxHP			0xa14
+#define rCCK0_RxHP 0xa14
 
-#define	rCCK0_DSPParameter1		0xa18	/* Timing recovery & Channel
+#define rCCK0_DSPParameter1 \
+	0xa18 /* Timing recovery & Channel
 						 * estimation threshold
 						 */
-#define	rCCK0_DSPParameter2		0xa1c	/* SQ threshold */
+#define rCCK0_DSPParameter2 0xa1c /* SQ threshold */
 
-#define	rCCK0_TxFilter1			0xa20
-#define	rCCK0_TxFilter2			0xa24
-#define	rCCK0_DebugPort			0xa28	/* debug port and Tx filter3 */
-#define	rCCK0_FalseAlarmReport		0xa2c	/* 0xa2d useless now 0xa30-a4f
+#define rCCK0_TxFilter1 0xa20
+#define rCCK0_TxFilter2 0xa24
+#define rCCK0_DebugPort 0xa28 /* debug port and Tx filter3 */
+#define rCCK0_FalseAlarmReport \
+	0xa2c /* 0xa2d useless now 0xa30-a4f
 						 * channel report
 						 */
-#define	rCCK0_TRSSIReport		0xa50
-#define	rCCK0_RxReport			0xa54   /* 0xa57 */
-#define	rCCK0_FACounterLower		0xa5c   /* 0xa5b */
-#define	rCCK0_FACounterUpper		0xa58   /* 0xa5c */
+#define rCCK0_TRSSIReport 0xa50
+#define rCCK0_RxReport 0xa54 /* 0xa57 */
+#define rCCK0_FACounterLower 0xa5c /* 0xa5b */
+#define rCCK0_FACounterUpper 0xa58 /* 0xa5c */
 
 /*
  * 6. PageC(0xC00)
  */
-#define	rOFDM0_LSTF			0xc00
-#define	rOFDM0_TRxPathEnable		0xc04
-#define	rOFDM0_TRMuxPar			0xc08
-#define	rOFDM0_TRSWIsolation		0xc0c
+#define rOFDM0_LSTF 0xc00
+#define rOFDM0_TRxPathEnable 0xc04
+#define rOFDM0_TRMuxPar 0xc08
+#define rOFDM0_TRSWIsolation 0xc0c
 
 /*RxIQ DC offset, Rx digital filter, DC notch filter */
-#define	rOFDM0_XARxAFE			0xc10
-#define	rOFDM0_XARxIQImbalance		0xc14  /* RxIQ imbalance matrix */
-#define	rOFDM0_XBRxAFE			0xc18
-#define	rOFDM0_XBRxIQImbalance		0xc1c
-#define	rOFDM0_XCRxAFE			0xc20
-#define	rOFDM0_XCRxIQImbalance		0xc24
-#define	rOFDM0_XDRxAFE			0xc28
-#define	rOFDM0_XDRxIQImbalance		0xc2c
-
-#define	rOFDM0_RxDetector1		0xc30  /* PD,BW & SBD DM tune
+#define rOFDM0_XARxAFE 0xc10
+#define rOFDM0_XARxIQImbalance 0xc14 /* RxIQ imbalance matrix */
+#define rOFDM0_XBRxAFE 0xc18
+#define rOFDM0_XBRxIQImbalance 0xc1c
+#define rOFDM0_XCRxAFE 0xc20
+#define rOFDM0_XCRxIQImbalance 0xc24
+#define rOFDM0_XDRxAFE 0xc28
+#define rOFDM0_XDRxIQImbalance 0xc2c
+
+#define rOFDM0_RxDetector1 \
+	0xc30 /* PD,BW & SBD DM tune
 						* init gain
 						*/
-#define	rOFDM0_RxDetector2		0xc34  /* SBD & Fame Sync. */
-#define	rOFDM0_RxDetector3		0xc38  /* Frame Sync. */
-#define	rOFDM0_RxDetector4		0xc3c  /* PD, SBD, Frame Sync &
+#define rOFDM0_RxDetector2 0xc34 /* SBD & Fame Sync. */
+#define rOFDM0_RxDetector3 0xc38 /* Frame Sync. */
+#define rOFDM0_RxDetector4 \
+	0xc3c /* PD, SBD, Frame Sync &
 						* Short-GI
 						*/
 
-#define	rOFDM0_RxDSP			0xc40  /* Rx Sync Path */
-#define	rOFDM0_CFOandDAGC		0xc44  /* CFO & DAGC */
-#define	rOFDM0_CCADropThreshold		0xc48 /* CCA Drop threshold */
-#define	rOFDM0_ECCAThreshold		0xc4c /* energy CCA */
-
-#define	rOFDM0_XAAGCCore1		0xc50	/* DIG */
-#define	rOFDM0_XAAGCCore2		0xc54
-#define	rOFDM0_XBAGCCore1		0xc58
-#define	rOFDM0_XBAGCCore2		0xc5c
-#define	rOFDM0_XCAGCCore1		0xc60
-#define	rOFDM0_XCAGCCore2		0xc64
-#define	rOFDM0_XDAGCCore1		0xc68
-#define	rOFDM0_XDAGCCore2		0xc6c
-#define	rOFDM0_AGCParameter1		0xc70
-#define	rOFDM0_AGCParameter2		0xc74
-#define	rOFDM0_AGCRSSITable		0xc78
-#define	rOFDM0_HTSTFAGC			0xc7c
-
-#define	rOFDM0_XATxIQImbalance		0xc80	/* TX PWR TRACK and DIG */
-#define	rOFDM0_XATxAFE			0xc84
-#define	rOFDM0_XBTxIQImbalance		0xc88
-#define	rOFDM0_XBTxAFE			0xc8c
-#define	rOFDM0_XCTxIQImbalance		0xc90
-#define	rOFDM0_XCTxAFE			0xc94
-#define	rOFDM0_XDTxIQImbalance		0xc98
-#define	rOFDM0_XDTxAFE			0xc9c
-
-#define	rOFDM0_RxHPParameter		0xce0
-#define	rOFDM0_TxPseudoNoiseWgt		0xce4
-#define	rOFDM0_FrameSync		0xcf0
-#define	rOFDM0_DFSReport		0xcf4
-#define	rOFDM0_TxCoeff1			0xca4
-#define	rOFDM0_TxCoeff2			0xca8
-#define	rOFDM0_TxCoeff3			0xcac
-#define	rOFDM0_TxCoeff4			0xcb0
-#define	rOFDM0_TxCoeff5			0xcb4
-#define	rOFDM0_TxCoeff6			0xcb8
+#define rOFDM0_RxDSP 0xc40 /* Rx Sync Path */
+#define rOFDM0_CFOandDAGC 0xc44 /* CFO & DAGC */
+#define rOFDM0_CCADropThreshold 0xc48 /* CCA Drop threshold */
+#define rOFDM0_ECCAThreshold 0xc4c /* energy CCA */
+
+#define rOFDM0_XAAGCCore1 0xc50 /* DIG */
+#define rOFDM0_XAAGCCore2 0xc54
+#define rOFDM0_XBAGCCore1 0xc58
+#define rOFDM0_XBAGCCore2 0xc5c
+#define rOFDM0_XCAGCCore1 0xc60
+#define rOFDM0_XCAGCCore2 0xc64
+#define rOFDM0_XDAGCCore1 0xc68
+#define rOFDM0_XDAGCCore2 0xc6c
+#define rOFDM0_AGCParameter1 0xc70
+#define rOFDM0_AGCParameter2 0xc74
+#define rOFDM0_AGCRSSITable 0xc78
+#define rOFDM0_HTSTFAGC 0xc7c
+
+#define rOFDM0_XATxIQImbalance 0xc80 /* TX PWR TRACK and DIG */
+#define rOFDM0_XATxAFE 0xc84
+#define rOFDM0_XBTxIQImbalance 0xc88
+#define rOFDM0_XBTxAFE 0xc8c
+#define rOFDM0_XCTxIQImbalance 0xc90
+#define rOFDM0_XCTxAFE 0xc94
+#define rOFDM0_XDTxIQImbalance 0xc98
+#define rOFDM0_XDTxAFE 0xc9c
+
+#define rOFDM0_RxHPParameter 0xce0
+#define rOFDM0_TxPseudoNoiseWgt 0xce4
+#define rOFDM0_FrameSync 0xcf0
+#define rOFDM0_DFSReport 0xcf4
+#define rOFDM0_TxCoeff1 0xca4
+#define rOFDM0_TxCoeff2 0xca8
+#define rOFDM0_TxCoeff3 0xcac
+#define rOFDM0_TxCoeff4 0xcb0
+#define rOFDM0_TxCoeff5 0xcb4
+#define rOFDM0_TxCoeff6 0xcb8
 
 /*
  * 7. PageD(0xD00)
  */
-#define	rOFDM1_LSTF			0xd00
-#define	rOFDM1_TRxPathEnable		0xd04
-
-#define	rOFDM1_CFO			0xd08	/* No setting now */
-#define	rOFDM1_CSI1			0xd10
-#define	rOFDM1_SBD			0xd14
-#define	rOFDM1_CSI2			0xd18
-#define	rOFDM1_CFOTracking		0xd2c
-#define	rOFDM1_TRxMesaure1		0xd34
-#define	rOFDM1_IntfDet			0xd3c
-#define	rOFDM1_PseudoNoiseStateAB	0xd50
-#define	rOFDM1_PseudoNoiseStateCD	0xd54
-#define	rOFDM1_RxPseudoNoiseWgt		0xd58
-
-#define	rOFDM_PHYCounter1		0xda0  /* cca, parity fail */
-#define	rOFDM_PHYCounter2		0xda4  /* rate illegal, crc8 fail */
-#define	rOFDM_PHYCounter3		0xda8  /* MCS not support */
-#define	rOFDM_ShortCFOAB		0xdac  /* No setting now */
-#define	rOFDM_ShortCFOCD		0xdb0
-#define	rOFDM_LongCFOAB			0xdb4
-#define	rOFDM_LongCFOCD			0xdb8
-#define	rOFDM_TailCFOAB			0xdbc
-#define	rOFDM_TailCFOCD			0xdc0
-#define	rOFDM_PWMeasure1		0xdc4
-#define	rOFDM_PWMeasure2		0xdc8
-#define	rOFDM_BWReport			0xdcc
-#define	rOFDM_AGCReport			0xdd0
-#define	rOFDM_RxSNR			0xdd4
-#define	rOFDM_RxEVMCSI			0xdd8
-#define	rOFDM_SIGReport			0xddc
+#define rOFDM1_LSTF 0xd00
+#define rOFDM1_TRxPathEnable 0xd04
+
+#define rOFDM1_CFO 0xd08 /* No setting now */
+#define rOFDM1_CSI1 0xd10
+#define rOFDM1_SBD 0xd14
+#define rOFDM1_CSI2 0xd18
+#define rOFDM1_CFOTracking 0xd2c
+#define rOFDM1_TRxMesaure1 0xd34
+#define rOFDM1_IntfDet 0xd3c
+#define rOFDM1_PseudoNoiseStateAB 0xd50
+#define rOFDM1_PseudoNoiseStateCD 0xd54
+#define rOFDM1_RxPseudoNoiseWgt 0xd58
+
+#define rOFDM_PHYCounter1 0xda0 /* cca, parity fail */
+#define rOFDM_PHYCounter2 0xda4 /* rate illegal, crc8 fail */
+#define rOFDM_PHYCounter3 0xda8 /* MCS not support */
+#define rOFDM_ShortCFOAB 0xdac /* No setting now */
+#define rOFDM_ShortCFOCD 0xdb0
+#define rOFDM_LongCFOAB 0xdb4
+#define rOFDM_LongCFOCD 0xdb8
+#define rOFDM_TailCFOAB 0xdbc
+#define rOFDM_TailCFOCD 0xdc0
+#define rOFDM_PWMeasure1 0xdc4
+#define rOFDM_PWMeasure2 0xdc8
+#define rOFDM_BWReport 0xdcc
+#define rOFDM_AGCReport 0xdd0
+#define rOFDM_RxSNR 0xdd4
+#define rOFDM_RxEVMCSI 0xdd8
+#define rOFDM_SIGReport 0xddc
 
 /*
  * 8. PageE(0xE00)
  */
-#define	rTxAGC_Rate18_06		0xe00
-#define	rTxAGC_Rate54_24		0xe04
-#define	rTxAGC_CCK_Mcs32		0xe08
-#define	rTxAGC_Mcs03_Mcs00		0xe10
-#define	rTxAGC_Mcs07_Mcs04		0xe14
-#define	rTxAGC_Mcs11_Mcs08		0xe18
-#define	rTxAGC_Mcs15_Mcs12		0xe1c
+#define rTxAGC_Rate18_06 0xe00
+#define rTxAGC_Rate54_24 0xe04
+#define rTxAGC_CCK_Mcs32 0xe08
+#define rTxAGC_Mcs03_Mcs00 0xe10
+#define rTxAGC_Mcs07_Mcs04 0xe14
+#define rTxAGC_Mcs11_Mcs08 0xe18
+#define rTxAGC_Mcs15_Mcs12 0xe1c
 
 /* Analog- control in RX_WAIT_CCA : REG: EE0
  * [Analog- Power & Control Register]
  */
-#define		rRx_Wait_CCCA		0xe70
-#define	rAnapar_Ctrl_BB			0xee0
+#define rRx_Wait_CCCA 0xe70
+#define rAnapar_Ctrl_BB 0xee0
 
 /*
  * 7. RF Register 0x00-0x2E (RF 8256)
@@ -302,733 +308,731 @@
  *
  * Zebra1
  */
-#define	rZebra1_HSSIEnable		0x0	/* Useless now */
-#define	rZebra1_TRxEnable1		0x1
-#define	rZebra1_TRxEnable2		0x2
-#define	rZebra1_AGC			0x4
-#define	rZebra1_ChargePump		0x5
-#define	rZebra1_Channel			0x7	/* RF channel switch */
-#define	rZebra1_TxGain			0x8	/* Useless now */
-#define	rZebra1_TxLPF			0x9
-#define	rZebra1_RxLPF			0xb
-#define	rZebra1_RxHPFCorner		0xc
+#define rZebra1_HSSIEnable 0x0 /* Useless now */
+#define rZebra1_TRxEnable1 0x1
+#define rZebra1_TRxEnable2 0x2
+#define rZebra1_AGC 0x4
+#define rZebra1_ChargePump 0x5
+#define rZebra1_Channel 0x7 /* RF channel switch */
+#define rZebra1_TxGain 0x8 /* Useless now */
+#define rZebra1_TxLPF 0x9
+#define rZebra1_RxLPF 0xb
+#define rZebra1_RxHPFCorner 0xc
 
 /* Zebra4 */
-#define	rGlobalCtrl			0	/* Useless now */
-#define	rRTL8256_TxLPF			19
-#define	rRTL8256_RxLPF			11
+#define rGlobalCtrl 0 /* Useless now */
+#define rRTL8256_TxLPF 19
+#define rRTL8256_RxLPF 11
 
 /* RTL8258 */
-#define	rRTL8258_TxLPF			0x11	/* Useless now */
-#define	rRTL8258_RxLPF			0x13
-#define	rRTL8258_RSSILPF		0xa
+#define rRTL8258_TxLPF 0x11 /* Useless now */
+#define rRTL8258_RxLPF 0x13
+#define rRTL8258_RSSILPF 0xa
 
 /* RL6052 Register definition */
-#define	RF_AC				0x00
-#define	RF_IQADJ_G1			0x01
-#define	RF_IQADJ_G2			0x02
-#define	RF_POW_TRSW			0x05
-
-#define	RF_GAIN_RX			0x06
-#define	RF_GAIN_TX			0x07
-
-#define	RF_TXM_IDAC			0x08
-#define	RF_BS_IQGEN			0x0F
-
-#define	RF_MODE1			0x10
-#define	RF_MODE2			0x11
-
-#define	RF_RX_AGC_HP			0x12
-#define	RF_TX_AGC			0x13
-#define	RF_BIAS				0x14
-#define	RF_IPA				0x15
-#define	RF_POW_ABILITY			0x17
-#define	RF_MODE_AG			0x18
-#define	rRfChannel			0x18	/* RF channel and BW switch */
-#define	RF_CHNLBW			0x18	/* RF channel and BW switch */
-#define	RF_TOP				0x19
-#define	RF_RX_G1			0x1A
-#define	RF_RX_G2			0x1B
-#define	RF_RX_BB2			0x1C
-#define	RF_RX_BB1			0x1D
-
-#define	RF_RCK1				0x1E
-#define	RF_RCK2				0x1F
-
-#define	RF_TX_G1			0x20
-#define	RF_TX_G2			0x21
-#define	RF_TX_G3			0x22
-
-#define	RF_TX_BB1			0x23
-#define	RF_T_METER			0x24
-
-#define	RF_SYN_G1			0x25	/* RF TX Power control */
-#define	RF_SYN_G2			0x26	/* RF TX Power control */
-#define	RF_SYN_G3			0x27	/* RF TX Power control */
-#define	RF_SYN_G4			0x28	/* RF TX Power control */
-#define	RF_SYN_G5			0x29	/* RF TX Power control */
-#define	RF_SYN_G6			0x2A	/* RF TX Power control */
-#define	RF_SYN_G7			0x2B	/* RF TX Power control */
-#define	RF_SYN_G8			0x2C	/* RF TX Power control */
-
-#define	RF_RCK_OS			0x30	/* RF TX PA control */
-
-#define	RF_TXPA_G1			0x31	/* RF TX PA control */
-#define	RF_TXPA_G2			0x32	/* RF TX PA control */
-#define	RF_TXPA_G3			0x33	/* RF TX PA control */
+#define RF_AC 0x00
+#define RF_IQADJ_G1 0x01
+#define RF_IQADJ_G2 0x02
+#define RF_POW_TRSW 0x05
+
+#define RF_GAIN_RX 0x06
+#define RF_GAIN_TX 0x07
+
+#define RF_TXM_IDAC 0x08
+#define RF_BS_IQGEN 0x0F
+
+#define RF_MODE1 0x10
+#define RF_MODE2 0x11
+
+#define RF_RX_AGC_HP 0x12
+#define RF_TX_AGC 0x13
+#define RF_BIAS 0x14
+#define RF_IPA 0x15
+#define RF_POW_ABILITY 0x17
+#define RF_MODE_AG 0x18
+#define rRfChannel 0x18 /* RF channel and BW switch */
+#define RF_CHNLBW 0x18 /* RF channel and BW switch */
+#define RF_TOP 0x19
+#define RF_RX_G1 0x1A
+#define RF_RX_G2 0x1B
+#define RF_RX_BB2 0x1C
+#define RF_RX_BB1 0x1D
+
+#define RF_RCK1 0x1E
+#define RF_RCK2 0x1F
+
+#define RF_TX_G1 0x20
+#define RF_TX_G2 0x21
+#define RF_TX_G3 0x22
+
+#define RF_TX_BB1 0x23
+#define RF_T_METER 0x24
+
+#define RF_SYN_G1 0x25 /* RF TX Power control */
+#define RF_SYN_G2 0x26 /* RF TX Power control */
+#define RF_SYN_G3 0x27 /* RF TX Power control */
+#define RF_SYN_G4 0x28 /* RF TX Power control */
+#define RF_SYN_G5 0x29 /* RF TX Power control */
+#define RF_SYN_G6 0x2A /* RF TX Power control */
+#define RF_SYN_G7 0x2B /* RF TX Power control */
+#define RF_SYN_G8 0x2C /* RF TX Power control */
+
+#define RF_RCK_OS 0x30 /* RF TX PA control */
+
+#define RF_TXPA_G1 0x31 /* RF TX PA control */
+#define RF_TXPA_G2 0x32 /* RF TX PA control */
+#define RF_TXPA_G3 0x33 /* RF TX PA control */
 
 /*
  * Bit Mask
  *
  * 1. Page1(0x100)
  */
-#define	bBBResetB			0x100	/* Useless now? */
-#define	bGlobalResetB			0x200
-#define	bOFDMTxStart			0x4
-#define	bCCKTxStart			0x8
-#define	bCRC32Debug			0x100
-#define	bPMACLoopback			0x10
-#define	bTxLSIG				0xffffff
-#define	bOFDMTxRate			0xf
-#define	bOFDMTxReserved			0x10
-#define	bOFDMTxLength			0x1ffe0
-#define	bOFDMTxParity			0x20000
-#define	bTxHTSIG1			0xffffff
-#define	bTxHTMCSRate			0x7f
-#define	bTxHTBW				0x80
-#define	bTxHTLength			0xffff00
-#define	bTxHTSIG2			0xffffff
-#define	bTxHTSmoothing			0x1
-#define	bTxHTSounding			0x2
-#define	bTxHTReserved			0x4
-#define	bTxHTAggreation			0x8
-#define	bTxHTSTBC			0x30
-#define	bTxHTAdvanceCoding		0x40
-#define	bTxHTShortGI			0x80
-#define	bTxHTNumberHT_LTF		0x300
-#define	bTxHTCRC8			0x3fc00
-#define	bCounterReset			0x10000
-#define	bNumOfOFDMTx			0xffff
-#define	bNumOfCCKTx			0xffff0000
-#define	bTxIdleInterval			0xffff
-#define	bOFDMService			0xffff0000
-#define	bTxMACHeader			0xffffffff
-#define	bTxDataInit			0xff
-#define	bTxHTMode			0x100
-#define	bTxDataType			0x30000
-#define	bTxRandomSeed			0xffffffff
-#define	bCCKTxPreamble			0x1
-#define	bCCKTxSFD			0xffff0000
-#define	bCCKTxSIG			0xff
-#define	bCCKTxService			0xff00
-#define	bCCKLengthExt			0x8000
-#define	bCCKTxLength			0xffff0000
-#define	bCCKTxCRC16			0xffff
-#define	bCCKTxStatus			0x1
-#define	bOFDMTxStatus			0x2
-#define IS_BB_REG_OFFSET_92S(_Offset)	((_Offset >= 0x800) && \
-					(_Offset <= 0xfff))
+#define bBBResetB 0x100 /* Useless now? */
+#define bGlobalResetB 0x200
+#define bOFDMTxStart 0x4
+#define bCCKTxStart 0x8
+#define bCRC32Debug 0x100
+#define bPMACLoopback 0x10
+#define bTxLSIG 0xffffff
+#define bOFDMTxRate 0xf
+#define bOFDMTxReserved 0x10
+#define bOFDMTxLength 0x1ffe0
+#define bOFDMTxParity 0x20000
+#define bTxHTSIG1 0xffffff
+#define bTxHTMCSRate 0x7f
+#define bTxHTBW 0x80
+#define bTxHTLength 0xffff00
+#define bTxHTSIG2 0xffffff
+#define bTxHTSmoothing 0x1
+#define bTxHTSounding 0x2
+#define bTxHTReserved 0x4
+#define bTxHTAggreation 0x8
+#define bTxHTSTBC 0x30
+#define bTxHTAdvanceCoding 0x40
+#define bTxHTShortGI 0x80
+#define bTxHTNumberHT_LTF 0x300
+#define bTxHTCRC8 0x3fc00
+#define bCounterReset 0x10000
+#define bNumOfOFDMTx 0xffff
+#define bNumOfCCKTx 0xffff0000
+#define bTxIdleInterval 0xffff
+#define bOFDMService 0xffff0000
+#define bTxMACHeader 0xffffffff
+#define bTxDataInit 0xff
+#define bTxHTMode 0x100
+#define bTxDataType 0x30000
+#define bTxRandomSeed 0xffffffff
+#define bCCKTxPreamble 0x1
+#define bCCKTxSFD 0xffff0000
+#define bCCKTxSIG 0xff
+#define bCCKTxService 0xff00
+#define bCCKLengthExt 0x8000
+#define bCCKTxLength 0xffff0000
+#define bCCKTxCRC16 0xffff
+#define bCCKTxStatus 0x1
+#define bOFDMTxStatus 0x2
+#define IS_BB_REG_OFFSET_92S(_Offset) ((_Offset >= 0x800) && (_Offset <= 0xfff))
 
 /* 2. Page8(0x800) */
-#define	bRFMOD			0x1	/* Reg 0x800 rFPGA0_RFMOD */
-#define	bJapanMode		0x2
-#define	bCCKTxSC		0x30
-#define	bCCKEn			0x1000000
-#define	bOFDMEn			0x2000000
-
-#define	bOFDMRxADCPhase         0x10000	/* Useless now */
-#define	bOFDMTxDACPhase         0x40000
-#define	bXATxAGC                0x3f
-#define	bXBTxAGC                0xf00	/* Reg 80c rFPGA0_TxGainStage */
-#define	bXCTxAGC                0xf000
-#define	bXDTxAGC                0xf0000
-
-#define	bPAStart		0xf0000000	/* Useless now */
-#define	bTRStart		0x00f00000
-#define	bRFStart		0x0000f000
-#define	bBBStart		0x000000f0
-#define	bBBCCKStart		0x0000000f
-#define	bPAEnd			0xf          /* Reg0x814 */
-#define	bTREnd			0x0f000000
-#define	bRFEnd			0x000f0000
-#define	bCCAMask		0x000000f0   /* T2R */
-#define	bR2RCCAMask		0x00000f00
-#define	bHSSI_R2TDelay		0xf8000000
-#define	bHSSI_T2RDelay		0xf80000
-#define	bContTxHSSI		0x400     /* change gain at continue Tx */
-#define	bIGFromCCK		0x200
-#define	bAGCAddress		0x3f
-#define	bRxHPTx			0x7000
-#define	bRxHPT2R		0x38000
-#define	bRxHPCCKIni		0xc0000
-#define	bAGCTxCode		0xc00000
-#define	bAGCRxCode		0x300000
-#define	b3WireDataLength	0x800	/* Reg 0x820~84f rFPGA0_XA_HSSIParm1 */
-#define	b3WireAddressLength	0x400
-#define	b3WireRFPowerDown	0x1	/* Useless now */
-#define	b5GPAPEPolarity		0x40000000
-#define	b2GPAPEPolarity		0x80000000
-#define	bRFSW_TxDefaultAnt	0x3
-#define	bRFSW_TxOptionAnt	0x30
-#define	bRFSW_RxDefaultAnt	0x300
-#define	bRFSW_RxOptionAnt	0x3000
-#define	bRFSI_3WireData		0x1
-#define	bRFSI_3WireClock	0x2
-#define	bRFSI_3WireLoad		0x4
-#define	bRFSI_3WireRW		0x8
-#define	bRFSI_3Wire		0xf
-#define	bRFSI_RFENV		0x10	/* Reg 0x870 rFPGA0_XAB_RFInterfaceSW */
-#define	bRFSI_TRSW		0x20	/* Useless now */
-#define	bRFSI_TRSWB		0x40
-#define	bRFSI_ANTSW		0x100
-#define	bRFSI_ANTSWB		0x200
-#define	bRFSI_PAPE		0x400
-#define	bRFSI_PAPE5G		0x800
-#define	bBandSelect		0x1
-#define	bHTSIG2_GI		0x80
-#define	bHTSIG2_Smoothing	0x01
-#define	bHTSIG2_Sounding	0x02
-#define	bHTSIG2_Aggreaton	0x08
-#define	bHTSIG2_STBC		0x30
-#define	bHTSIG2_AdvCoding	0x40
-#define	bHTSIG2_NumOfHTLTF	0x300
-#define	bHTSIG2_CRC8		0x3fc
-#define	bHTSIG1_MCS		0x7f
-#define	bHTSIG1_BandWidth	0x80
-#define	bHTSIG1_HTLength	0xffff
-#define	bLSIG_Rate		0xf
-#define	bLSIG_Reserved		0x10
-#define	bLSIG_Length		0x1fffe
-#define	bLSIG_Parity		0x20
-#define	bCCKRxPhase		0x4
-#define	bLSSIReadAddress	0x7f800000   /* T65 RF */
-#define	bLSSIReadEdge		0x80000000   /* LSSI "Read" edge signal */
-#define	bLSSIReadBackData	0xfffff		/* T65 RF */
-#define	bLSSIReadOKFlag		0x1000	/* Useless now */
-#define	bCCKSampleRate		0x8       /*0: 44MHz, 1:88MHz*/
-#define	bRegulator0Standby	0x1
-#define	bRegulatorPLLStandby	0x2
-#define	bRegulator1Standby	0x4
-#define	bPLLPowerUp		0x8
-#define	bDPLLPowerUp		0x10
-#define	bDA10PowerUp		0x20
-#define	bAD7PowerUp		0x200
-#define	bDA6PowerUp		0x2000
-#define	bXtalPowerUp		0x4000
-#define	b40MDClkPowerUP		0x8000
-#define	bDA6DebugMode		0x20000
-#define	bDA6Swing		0x380000
+#define bRFMOD 0x1 /* Reg 0x800 rFPGA0_RFMOD */
+#define bJapanMode 0x2
+#define bCCKTxSC 0x30
+#define bCCKEn 0x1000000
+#define bOFDMEn 0x2000000
+
+#define bOFDMRxADCPhase 0x10000 /* Useless now */
+#define bOFDMTxDACPhase 0x40000
+#define bXATxAGC 0x3f
+#define bXBTxAGC 0xf00 /* Reg 80c rFPGA0_TxGainStage */
+#define bXCTxAGC 0xf000
+#define bXDTxAGC 0xf0000
+
+#define bPAStart 0xf0000000 /* Useless now */
+#define bTRStart 0x00f00000
+#define bRFStart 0x0000f000
+#define bBBStart 0x000000f0
+#define bBBCCKStart 0x0000000f
+#define bPAEnd 0xf /* Reg0x814 */
+#define bTREnd 0x0f000000
+#define bRFEnd 0x000f0000
+#define bCCAMask 0x000000f0 /* T2R */
+#define bR2RCCAMask 0x00000f00
+#define bHSSI_R2TDelay 0xf8000000
+#define bHSSI_T2RDelay 0xf80000
+#define bContTxHSSI 0x400 /* change gain at continue Tx */
+#define bIGFromCCK 0x200
+#define bAGCAddress 0x3f
+#define bRxHPTx 0x7000
+#define bRxHPT2R 0x38000
+#define bRxHPCCKIni 0xc0000
+#define bAGCTxCode 0xc00000
+#define bAGCRxCode 0x300000
+#define b3WireDataLength 0x800 /* Reg 0x820~84f rFPGA0_XA_HSSIParm1 */
+#define b3WireAddressLength 0x400
+#define b3WireRFPowerDown 0x1 /* Useless now */
+#define b5GPAPEPolarity 0x40000000
+#define b2GPAPEPolarity 0x80000000
+#define bRFSW_TxDefaultAnt 0x3
+#define bRFSW_TxOptionAnt 0x30
+#define bRFSW_RxDefaultAnt 0x300
+#define bRFSW_RxOptionAnt 0x3000
+#define bRFSI_3WireData 0x1
+#define bRFSI_3WireClock 0x2
+#define bRFSI_3WireLoad 0x4
+#define bRFSI_3WireRW 0x8
+#define bRFSI_3Wire 0xf
+#define bRFSI_RFENV 0x10 /* Reg 0x870 rFPGA0_XAB_RFInterfaceSW */
+#define bRFSI_TRSW 0x20 /* Useless now */
+#define bRFSI_TRSWB 0x40
+#define bRFSI_ANTSW 0x100
+#define bRFSI_ANTSWB 0x200
+#define bRFSI_PAPE 0x400
+#define bRFSI_PAPE5G 0x800
+#define bBandSelect 0x1
+#define bHTSIG2_GI 0x80
+#define bHTSIG2_Smoothing 0x01
+#define bHTSIG2_Sounding 0x02
+#define bHTSIG2_Aggreaton 0x08
+#define bHTSIG2_STBC 0x30
+#define bHTSIG2_AdvCoding 0x40
+#define bHTSIG2_NumOfHTLTF 0x300
+#define bHTSIG2_CRC8 0x3fc
+#define bHTSIG1_MCS 0x7f
+#define bHTSIG1_BandWidth 0x80
+#define bHTSIG1_HTLength 0xffff
+#define bLSIG_Rate 0xf
+#define bLSIG_Reserved 0x10
+#define bLSIG_Length 0x1fffe
+#define bLSIG_Parity 0x20
+#define bCCKRxPhase 0x4
+#define bLSSIReadAddress 0x7f800000 /* T65 RF */
+#define bLSSIReadEdge 0x80000000 /* LSSI "Read" edge signal */
+#define bLSSIReadBackData 0xfffff /* T65 RF */
+#define bLSSIReadOKFlag 0x1000 /* Useless now */
+#define bCCKSampleRate 0x8 /*0: 44MHz, 1:88MHz*/
+#define bRegulator0Standby 0x1
+#define bRegulatorPLLStandby 0x2
+#define bRegulator1Standby 0x4
+#define bPLLPowerUp 0x8
+#define bDPLLPowerUp 0x10
+#define bDA10PowerUp 0x20
+#define bAD7PowerUp 0x200
+#define bDA6PowerUp 0x2000
+#define bXtalPowerUp 0x4000
+#define b40MDClkPowerUP 0x8000
+#define bDA6DebugMode 0x20000
+#define bDA6Swing 0x380000
 
 /* Reg 0x880 rFPGA0_AnalogParameter1 20/40 CCK support switch 40/80 BB MHZ */
-#define	bADClkPhase		0x4000000
+#define bADClkPhase 0x4000000
 
-#define	b80MClkDelay		0x18000000	/* Useless */
-#define	bAFEWatchDogEnable	0x20000000
+#define b80MClkDelay 0x18000000 /* Useless */
+#define bAFEWatchDogEnable 0x20000000
 
 /* Reg 0x884 rFPGA0_AnalogParameter2 Crystal cap */
-#define	bXtalCap01		0xc0000000
-#define	bXtalCap23		0x3
-#define	bXtalCap92x		0x0f000000
-#define bXtalCap		0x0f000000
-#define	bIntDifClkEnable	0x400	/* Useless */
-#define	bExtSigClkEnable	0x800
-#define	bBandgapMbiasPowerUp	0x10000
-#define	bAD11SHGain		0xc0000
-#define	bAD11InputRange		0x700000
-#define	bAD11OPCurrent		0x3800000
-#define	bIPathLoopback		0x4000000
-#define	bQPathLoopback		0x8000000
-#define	bAFELoopback		0x10000000
-#define	bDA10Swing		0x7e0
-#define	bDA10Reverse		0x800
-#define	bDAClkSource		0x1000
-#define	bAD7InputRange		0x6000
-#define	bAD7Gain		0x38000
-#define	bAD7OutputCMMode	0x40000
-#define	bAD7InputCMMode		0x380000
-#define	bAD7Current		0xc00000
-#define	bRegulatorAdjust	0x7000000
-#define	bAD11PowerUpAtTx	0x1
-#define	bDA10PSAtTx		0x10
-#define	bAD11PowerUpAtRx	0x100
-#define	bDA10PSAtRx		0x1000
-#define	bCCKRxAGCFormat		0x200
-#define	bPSDFFTSamplepPoint	0xc000
-#define	bPSDAverageNum		0x3000
-#define	bIQPathControl		0xc00
-#define	bPSDFreq		0x3ff
-#define	bPSDAntennaPath		0x30
-#define	bPSDIQSwitch		0x40
-#define	bPSDRxTrigger		0x400000
-#define	bPSDTxTrigger		0x80000000
-#define	bPSDSineToneScale	0x7f000000
-#define	bPSDReport		0xffff
+#define bXtalCap01 0xc0000000
+#define bXtalCap23 0x3
+#define bXtalCap92x 0x0f000000
+#define bXtalCap 0x0f000000
+#define bIntDifClkEnable 0x400 /* Useless */
+#define bExtSigClkEnable 0x800
+#define bBandgapMbiasPowerUp 0x10000
+#define bAD11SHGain 0xc0000
+#define bAD11InputRange 0x700000
+#define bAD11OPCurrent 0x3800000
+#define bIPathLoopback 0x4000000
+#define bQPathLoopback 0x8000000
+#define bAFELoopback 0x10000000
+#define bDA10Swing 0x7e0
+#define bDA10Reverse 0x800
+#define bDAClkSource 0x1000
+#define bAD7InputRange 0x6000
+#define bAD7Gain 0x38000
+#define bAD7OutputCMMode 0x40000
+#define bAD7InputCMMode 0x380000
+#define bAD7Current 0xc00000
+#define bRegulatorAdjust 0x7000000
+#define bAD11PowerUpAtTx 0x1
+#define bDA10PSAtTx 0x10
+#define bAD11PowerUpAtRx 0x100
+#define bDA10PSAtRx 0x1000
+#define bCCKRxAGCFormat 0x200
+#define bPSDFFTSamplepPoint 0xc000
+#define bPSDAverageNum 0x3000
+#define bIQPathControl 0xc00
+#define bPSDFreq 0x3ff
+#define bPSDAntennaPath 0x30
+#define bPSDIQSwitch 0x40
+#define bPSDRxTrigger 0x400000
+#define bPSDTxTrigger 0x80000000
+#define bPSDSineToneScale 0x7f000000
+#define bPSDReport 0xffff
 
 /* 3. Page9(0x900) */
-#define	bOFDMTxSC		0x30000000	/* Useless */
-#define	bCCKTxOn		0x1
-#define	bOFDMTxOn		0x2
-#define	bDebugPage		0xfff  /* reset debug page and HWord, LWord */
-#define	bDebugItem		0xff   /* reset debug page and LWord */
-#define	bAntL			0x10
-#define	bAntNonHT		0x100
-#define	bAntHT1			0x1000
-#define	bAntHT2			0x10000
-#define	bAntHT1S1		0x100000
-#define	bAntNonHTS1		0x1000000
+#define bOFDMTxSC 0x30000000 /* Useless */
+#define bCCKTxOn 0x1
+#define bOFDMTxOn 0x2
+#define bDebugPage 0xfff /* reset debug page and HWord, LWord */
+#define bDebugItem 0xff /* reset debug page and LWord */
+#define bAntL 0x10
+#define bAntNonHT 0x100
+#define bAntHT1 0x1000
+#define bAntHT2 0x10000
+#define bAntHT1S1 0x100000
+#define bAntNonHTS1 0x1000000
 
 /* 4. PageA(0xA00) */
-#define	bCCKBBMode		0x3	/* Useless */
-#define	bCCKTxPowerSaving	0x80
-#define	bCCKRxPowerSaving	0x40
-
-#define	bCCKSideBand		0x10	/* Reg 0xa00 rCCK0_System 20/40 switch*/
-#define	bCCKScramble		0x8	/* Useless */
-#define	bCCKAntDiversity	0x8000
-#define	bCCKCarrierRecovery	0x4000
-#define	bCCKTxRate		0x3000
-#define	bCCKDCCancel		0x0800
-#define	bCCKISICancel		0x0400
-#define	bCCKMatchFilter		0x0200
-#define	bCCKEqualizer		0x0100
-#define	bCCKPreambleDetect	0x800000
-#define	bCCKFastFalseCCA	0x400000
-#define	bCCKChEstStart		0x300000
-#define	bCCKCCACount		0x080000
-#define	bCCKcs_lim		0x070000
-#define	bCCKBistMode		0x80000000
-#define	bCCKCCAMask		0x40000000
-#define	bCCKTxDACPhase		0x4
-#define	bCCKRxADCPhase		0x20000000   /* r_rx_clk */
-#define	bCCKr_cp_mode0		0x0100
-#define	bCCKTxDCOffset		0xf0
-#define	bCCKRxDCOffset		0xf
-#define	bCCKCCAMode		0xc000
-#define	bCCKFalseCS_lim		0x3f00
-#define	bCCKCS_ratio		0xc00000
-#define	bCCKCorgBit_sel		0x300000
-#define	bCCKPD_lim		0x0f0000
-#define	bCCKNewCCA		0x80000000
-#define	bCCKRxHPofIG		0x8000
-#define	bCCKRxIG		0x7f00
-#define	bCCKLNAPolarity		0x800000
-#define	bCCKRx1stGain		0x7f0000
-#define	bCCKRFExtend		0x20000000 /* CCK Rx initial gain polarity */
-#define	bCCKRxAGCSatLevel	0x1f000000
-#define	bCCKRxAGCSatCount       0xe0
-#define	bCCKRxRFSettle          0x1f       /* AGCsamp_dly */
-#define	bCCKFixedRxAGC          0x8000
-#define	bCCKAntennaPolarity     0x2000
-#define	bCCKTxFilterType        0x0c00
-#define	bCCKRxAGCReportType	0x0300
-#define	bCCKRxDAGCEn            0x80000000
-#define	bCCKRxDAGCPeriod        0x20000000
-#define	bCCKRxDAGCSatLevel	0x1f000000
-#define	bCCKTimingRecovery      0x800000
-#define	bCCKTxC0                0x3f0000
-#define	bCCKTxC1                0x3f000000
-#define	bCCKTxC2                0x3f
-#define	bCCKTxC3                0x3f00
-#define	bCCKTxC4                0x3f0000
-#define	bCCKTxC5		0x3f000000
-#define	bCCKTxC6		0x3f
-#define	bCCKTxC7		0x3f00
-#define	bCCKDebugPort		0xff0000
-#define	bCCKDACDebug		0x0f000000
-#define	bCCKFalseAlarmEnable	0x8000
-#define	bCCKFalseAlarmRead	0x4000
-#define	bCCKTRSSI		0x7f
-#define	bCCKRxAGCReport		0xfe
-#define	bCCKRxReport_AntSel	0x80000000
-#define	bCCKRxReport_MFOff	0x40000000
-#define	bCCKRxRxReport_SQLoss	0x20000000
-#define	bCCKRxReport_Pktloss	0x10000000
-#define	bCCKRxReport_Lockedbit	0x08000000
-#define	bCCKRxReport_RateError	0x04000000
-#define	bCCKRxReport_RxRate	0x03000000
-#define	bCCKRxFACounterLower	0xff
-#define	bCCKRxFACounterUpper	0xff000000
-#define	bCCKRxHPAGCStart	0xe000
-#define	bCCKRxHPAGCFinal	0x1c00
-#define	bCCKRxFalseAlarmEnable	0x8000
-#define	bCCKFACounterFreeze	0x4000
-#define	bCCKTxPathSel		0x10000000
-#define	bCCKDefaultRxPath	0xc000000
-#define	bCCKOptionRxPath	0x3000000
+#define bCCKBBMode 0x3 /* Useless */
+#define bCCKTxPowerSaving 0x80
+#define bCCKRxPowerSaving 0x40
+
+#define bCCKSideBand 0x10 /* Reg 0xa00 rCCK0_System 20/40 switch*/
+#define bCCKScramble 0x8 /* Useless */
+#define bCCKAntDiversity 0x8000
+#define bCCKCarrierRecovery 0x4000
+#define bCCKTxRate 0x3000
+#define bCCKDCCancel 0x0800
+#define bCCKISICancel 0x0400
+#define bCCKMatchFilter 0x0200
+#define bCCKEqualizer 0x0100
+#define bCCKPreambleDetect 0x800000
+#define bCCKFastFalseCCA 0x400000
+#define bCCKChEstStart 0x300000
+#define bCCKCCACount 0x080000
+#define bCCKcs_lim 0x070000
+#define bCCKBistMode 0x80000000
+#define bCCKCCAMask 0x40000000
+#define bCCKTxDACPhase 0x4
+#define bCCKRxADCPhase 0x20000000 /* r_rx_clk */
+#define bCCKr_cp_mode0 0x0100
+#define bCCKTxDCOffset 0xf0
+#define bCCKRxDCOffset 0xf
+#define bCCKCCAMode 0xc000
+#define bCCKFalseCS_lim 0x3f00
+#define bCCKCS_ratio 0xc00000
+#define bCCKCorgBit_sel 0x300000
+#define bCCKPD_lim 0x0f0000
+#define bCCKNewCCA 0x80000000
+#define bCCKRxHPofIG 0x8000
+#define bCCKRxIG 0x7f00
+#define bCCKLNAPolarity 0x800000
+#define bCCKRx1stGain 0x7f0000
+#define bCCKRFExtend 0x20000000 /* CCK Rx initial gain polarity */
+#define bCCKRxAGCSatLevel 0x1f000000
+#define bCCKRxAGCSatCount 0xe0
+#define bCCKRxRFSettle 0x1f /* AGCsamp_dly */
+#define bCCKFixedRxAGC 0x8000
+#define bCCKAntennaPolarity 0x2000
+#define bCCKTxFilterType 0x0c00
+#define bCCKRxAGCReportType 0x0300
+#define bCCKRxDAGCEn 0x80000000
+#define bCCKRxDAGCPeriod 0x20000000
+#define bCCKRxDAGCSatLevel 0x1f000000
+#define bCCKTimingRecovery 0x800000
+#define bCCKTxC0 0x3f0000
+#define bCCKTxC1 0x3f000000
+#define bCCKTxC2 0x3f
+#define bCCKTxC3 0x3f00
+#define bCCKTxC4 0x3f0000
+#define bCCKTxC5 0x3f000000
+#define bCCKTxC6 0x3f
+#define bCCKTxC7 0x3f00
+#define bCCKDebugPort 0xff0000
+#define bCCKDACDebug 0x0f000000
+#define bCCKFalseAlarmEnable 0x8000
+#define bCCKFalseAlarmRead 0x4000
+#define bCCKTRSSI 0x7f
+#define bCCKRxAGCReport 0xfe
+#define bCCKRxReport_AntSel 0x80000000
+#define bCCKRxReport_MFOff 0x40000000
+#define bCCKRxRxReport_SQLoss 0x20000000
+#define bCCKRxReport_Pktloss 0x10000000
+#define bCCKRxReport_Lockedbit 0x08000000
+#define bCCKRxReport_RateError 0x04000000
+#define bCCKRxReport_RxRate 0x03000000
+#define bCCKRxFACounterLower 0xff
+#define bCCKRxFACounterUpper 0xff000000
+#define bCCKRxHPAGCStart 0xe000
+#define bCCKRxHPAGCFinal 0x1c00
+#define bCCKRxFalseAlarmEnable 0x8000
+#define bCCKFACounterFreeze 0x4000
+#define bCCKTxPathSel 0x10000000
+#define bCCKDefaultRxPath 0xc000000
+#define bCCKOptionRxPath 0x3000000
 
 /* 5. PageC(0xC00) */
-#define	bNumOfSTF		0x3	/* Useless */
-#define	bShift_L                0xc0
-#define	bGI_TH			0xc
-#define	bRxPathA		0x1
-#define	bRxPathB		0x2
-#define	bRxPathC		0x4
-#define	bRxPathD		0x8
-#define	bTxPathA		0x1
-#define	bTxPathB		0x2
-#define	bTxPathC		0x4
-#define	bTxPathD		0x8
-#define	bTRSSIFreq		0x200
-#define	bADCBackoff		0x3000
-#define	bDFIRBackoff		0xc000
-#define	bTRSSILatchPhase	0x10000
-#define	bRxIDCOffset		0xff
-#define	bRxQDCOffset		0xff00
-#define	bRxDFIRMode		0x1800000
-#define	bRxDCNFType		0xe000000
-#define	bRXIQImb_A		0x3ff
-#define	bRXIQImb_B		0xfc00
-#define	bRXIQImb_C		0x3f0000
-#define	bRXIQImb_D		0xffc00000
-#define	bDC_dc_Notch		0x60000
-#define	bRxNBINotch		0x1f000000
-#define	bPD_TH			0xf
-#define	bPD_TH_Opt2		0xc000
-#define	bPWED_TH		0x700
-#define	bIfMF_Win_L		0x800
-#define	bPD_Option		0x1000
-#define	bMF_Win_L		0xe000
-#define	bBW_Search_L		0x30000
-#define	bwin_enh_L		0xc0000
-#define	bBW_TH			0x700000
-#define	bED_TH2			0x3800000
-#define	bBW_option		0x4000000
-#define	bRatio_TH		0x18000000
-#define	bWindow_L		0xe0000000
-#define	bSBD_Option		0x1
-#define	bFrame_TH		0x1c
-#define	bFS_Option		0x60
-#define	bDC_Slope_check		0x80
-#define	bFGuard_Counter_DC_L	0xe00
-#define	bFrame_Weight_Short	0x7000
-#define	bSub_Tune		0xe00000
-#define	bFrame_DC_Length	0xe000000
-#define	bSBD_start_offset	0x30000000
-#define	bFrame_TH_2		0x7
-#define	bFrame_GI2_TH		0x38
-#define	bGI2_Sync_en		0x40
-#define	bSarch_Short_Early	0x300
-#define	bSarch_Short_Late	0xc00
-#define	bSarch_GI2_Late		0x70000
-#define	bCFOAntSum		0x1
-#define	bCFOAcc			0x2
-#define	bCFOStartOffset		0xc
-#define	bCFOLookBack		0x70
-#define	bCFOSumWeight		0x80
-#define	bDAGCEnable		0x10000
-#define	bTXIQImb_A		0x3ff
-#define	bTXIQImb_B		0xfc00
-#define	bTXIQImb_C		0x3f0000
-#define	bTXIQImb_D		0xffc00000
-#define	bTxIDCOffset		0xff
-#define	bTxQDCOffset		0xff00
-#define	bTxDFIRMode		0x10000
-#define	bTxPesudoNoiseOn	0x4000000
-#define	bTxPesudoNoise_A	0xff
-#define	bTxPesudoNoise_B	0xff00
-#define	bTxPesudoNoise_C	0xff0000
-#define	bTxPesudoNoise_D	0xff000000
-#define	bCCADropOption		0x20000
-#define	bCCADropThres		0xfff00000
-#define	bEDCCA_H		0xf
-#define	bEDCCA_L		0xf0
-#define	bLambda_ED              0x300
-#define	bRxInitialGain          0x7f
-#define	bRxAntDivEn             0x80
-#define	bRxAGCAddressForLNA     0x7f00
-#define	bRxHighPowerFlow        0x8000
-#define	bRxAGCFreezeThres       0xc0000
-#define	bRxFreezeStep_AGC1      0x300000
-#define	bRxFreezeStep_AGC2      0xc00000
-#define	bRxFreezeStep_AGC3      0x3000000
-#define	bRxFreezeStep_AGC0      0xc000000
-#define	bRxRssi_Cmp_En          0x10000000
-#define	bRxQuickAGCEn           0x20000000
-#define	bRxAGCFreezeThresMode   0x40000000
-#define	bRxOverFlowCheckType    0x80000000
-#define	bRxAGCShift             0x7f
-#define	bTRSW_Tri_Only          0x80
-#define	bPowerThres             0x300
-#define	bRxAGCEn                0x1
-#define	bRxAGCTogetherEn        0x2
-#define	bRxAGCMin               0x4
-#define	bRxHP_Ini               0x7
-#define	bRxHP_TRLNA             0x70
-#define	bRxHP_RSSI              0x700
-#define	bRxHP_BBP1              0x7000
-#define	bRxHP_BBP2              0x70000
-#define	bRxHP_BBP3              0x700000
-#define	bRSSI_H                 0x7f0000     /* the threshold for high power */
-#define	bRSSI_Gen               0x7f000000   /* the threshold for ant divers */
-#define	bRxSettle_TRSW          0x7
-#define	bRxSettle_LNA           0x38
-#define	bRxSettle_RSSI          0x1c0
-#define	bRxSettle_BBP           0xe00
-#define	bRxSettle_RxHP          0x7000
-#define	bRxSettle_AntSW_RSSI    0x38000
-#define	bRxSettle_AntSW         0xc0000
-#define	bRxProcessTime_DAGC     0x300000
-#define	bRxSettle_HSSI          0x400000
-#define	bRxProcessTime_BBPPW    0x800000
-#define	bRxAntennaPowerShift    0x3000000
-#define	bRSSITableSelect        0xc000000
-#define	bRxHP_Final             0x7000000
-#define	bRxHTSettle_BBP         0x7
-#define	bRxHTSettle_HSSI        0x8
-#define	bRxHTSettle_RxHP        0x70
-#define	bRxHTSettle_BBPPW       0x80
-#define	bRxHTSettle_Idle        0x300
-#define	bRxHTSettle_Reserved    0x1c00
-#define	bRxHTRxHPEn             0x8000
-#define	bRxHTAGCFreezeThres     0x30000
-#define	bRxHTAGCTogetherEn      0x40000
-#define	bRxHTAGCMin             0x80000
-#define	bRxHTAGCEn              0x100000
-#define	bRxHTDAGCEn             0x200000
-#define	bRxHTRxHP_BBP           0x1c00000
-#define	bRxHTRxHP_Final         0xe0000000
-#define	bRxPWRatioTH            0x3
-#define	bRxPWRatioEn            0x4
-#define	bRxMFHold               0x3800
-#define	bRxPD_Delay_TH1         0x38
-#define	bRxPD_Delay_TH2         0x1c0
-#define	bRxPD_DC_COUNT_MAX      0x600
-#define	bRxPD_Delay_TH          0x8000
-#define	bRxProcess_Delay        0xf0000
-#define	bRxSearchrange_GI2_Early 0x700000
-#define	bRxFrame_Guard_Counter_L 0x3800000
-#define	bRxSGI_Guard_L          0xc000000
-#define	bRxSGI_Search_L         0x30000000
-#define	bRxSGI_TH               0xc0000000
-#define	bDFSCnt0                0xff
-#define	bDFSCnt1                0xff00
-#define	bDFSFlag                0xf0000
-#define	bMFWeightSum            0x300000
-#define	bMinIdxTH               0x7f000000
-#define	bDAFormat               0x40000
-#define	bTxChEmuEnable          0x01000000
-#define	bTRSWIsolation_A        0x7f
-#define	bTRSWIsolation_B        0x7f00
-#define	bTRSWIsolation_C        0x7f0000
-#define	bTRSWIsolation_D        0x7f000000
-#define	bExtLNAGain             0x7c00
+#define bNumOfSTF 0x3 /* Useless */
+#define bShift_L 0xc0
+#define bGI_TH 0xc
+#define bRxPathA 0x1
+#define bRxPathB 0x2
+#define bRxPathC 0x4
+#define bRxPathD 0x8
+#define bTxPathA 0x1
+#define bTxPathB 0x2
+#define bTxPathC 0x4
+#define bTxPathD 0x8
+#define bTRSSIFreq 0x200
+#define bADCBackoff 0x3000
+#define bDFIRBackoff 0xc000
+#define bTRSSILatchPhase 0x10000
+#define bRxIDCOffset 0xff
+#define bRxQDCOffset 0xff00
+#define bRxDFIRMode 0x1800000
+#define bRxDCNFType 0xe000000
+#define bRXIQImb_A 0x3ff
+#define bRXIQImb_B 0xfc00
+#define bRXIQImb_C 0x3f0000
+#define bRXIQImb_D 0xffc00000
+#define bDC_dc_Notch 0x60000
+#define bRxNBINotch 0x1f000000
+#define bPD_TH 0xf
+#define bPD_TH_Opt2 0xc000
+#define bPWED_TH 0x700
+#define bIfMF_Win_L 0x800
+#define bPD_Option 0x1000
+#define bMF_Win_L 0xe000
+#define bBW_Search_L 0x30000
+#define bwin_enh_L 0xc0000
+#define bBW_TH 0x700000
+#define bED_TH2 0x3800000
+#define bBW_option 0x4000000
+#define bRatio_TH 0x18000000
+#define bWindow_L 0xe0000000
+#define bSBD_Option 0x1
+#define bFrame_TH 0x1c
+#define bFS_Option 0x60
+#define bDC_Slope_check 0x80
+#define bFGuard_Counter_DC_L 0xe00
+#define bFrame_Weight_Short 0x7000
+#define bSub_Tune 0xe00000
+#define bFrame_DC_Length 0xe000000
+#define bSBD_start_offset 0x30000000
+#define bFrame_TH_2 0x7
+#define bFrame_GI2_TH 0x38
+#define bGI2_Sync_en 0x40
+#define bSarch_Short_Early 0x300
+#define bSarch_Short_Late 0xc00
+#define bSarch_GI2_Late 0x70000
+#define bCFOAntSum 0x1
+#define bCFOAcc 0x2
+#define bCFOStartOffset 0xc
+#define bCFOLookBack 0x70
+#define bCFOSumWeight 0x80
+#define bDAGCEnable 0x10000
+#define bTXIQImb_A 0x3ff
+#define bTXIQImb_B 0xfc00
+#define bTXIQImb_C 0x3f0000
+#define bTXIQImb_D 0xffc00000
+#define bTxIDCOffset 0xff
+#define bTxQDCOffset 0xff00
+#define bTxDFIRMode 0x10000
+#define bTxPesudoNoiseOn 0x4000000
+#define bTxPesudoNoise_A 0xff
+#define bTxPesudoNoise_B 0xff00
+#define bTxPesudoNoise_C 0xff0000
+#define bTxPesudoNoise_D 0xff000000
+#define bCCADropOption 0x20000
+#define bCCADropThres 0xfff00000
+#define bEDCCA_H 0xf
+#define bEDCCA_L 0xf0
+#define bLambda_ED 0x300
+#define bRxInitialGain 0x7f
+#define bRxAntDivEn 0x80
+#define bRxAGCAddressForLNA 0x7f00
+#define bRxHighPowerFlow 0x8000
+#define bRxAGCFreezeThres 0xc0000
+#define bRxFreezeStep_AGC1 0x300000
+#define bRxFreezeStep_AGC2 0xc00000
+#define bRxFreezeStep_AGC3 0x3000000
+#define bRxFreezeStep_AGC0 0xc000000
+#define bRxRssi_Cmp_En 0x10000000
+#define bRxQuickAGCEn 0x20000000
+#define bRxAGCFreezeThresMode 0x40000000
+#define bRxOverFlowCheckType 0x80000000
+#define bRxAGCShift 0x7f
+#define bTRSW_Tri_Only 0x80
+#define bPowerThres 0x300
+#define bRxAGCEn 0x1
+#define bRxAGCTogetherEn 0x2
+#define bRxAGCMin 0x4
+#define bRxHP_Ini 0x7
+#define bRxHP_TRLNA 0x70
+#define bRxHP_RSSI 0x700
+#define bRxHP_BBP1 0x7000
+#define bRxHP_BBP2 0x70000
+#define bRxHP_BBP3 0x700000
+#define bRSSI_H 0x7f0000 /* the threshold for high power */
+#define bRSSI_Gen 0x7f000000 /* the threshold for ant divers */
+#define bRxSettle_TRSW 0x7
+#define bRxSettle_LNA 0x38
+#define bRxSettle_RSSI 0x1c0
+#define bRxSettle_BBP 0xe00
+#define bRxSettle_RxHP 0x7000
+#define bRxSettle_AntSW_RSSI 0x38000
+#define bRxSettle_AntSW 0xc0000
+#define bRxProcessTime_DAGC 0x300000
+#define bRxSettle_HSSI 0x400000
+#define bRxProcessTime_BBPPW 0x800000
+#define bRxAntennaPowerShift 0x3000000
+#define bRSSITableSelect 0xc000000
+#define bRxHP_Final 0x7000000
+#define bRxHTSettle_BBP 0x7
+#define bRxHTSettle_HSSI 0x8
+#define bRxHTSettle_RxHP 0x70
+#define bRxHTSettle_BBPPW 0x80
+#define bRxHTSettle_Idle 0x300
+#define bRxHTSettle_Reserved 0x1c00
+#define bRxHTRxHPEn 0x8000
+#define bRxHTAGCFreezeThres 0x30000
+#define bRxHTAGCTogetherEn 0x40000
+#define bRxHTAGCMin 0x80000
+#define bRxHTAGCEn 0x100000
+#define bRxHTDAGCEn 0x200000
+#define bRxHTRxHP_BBP 0x1c00000
+#define bRxHTRxHP_Final 0xe0000000
+#define bRxPWRatioTH 0x3
+#define bRxPWRatioEn 0x4
+#define bRxMFHold 0x3800
+#define bRxPD_Delay_TH1 0x38
+#define bRxPD_Delay_TH2 0x1c0
+#define bRxPD_DC_COUNT_MAX 0x600
+#define bRxPD_Delay_TH 0x8000
+#define bRxProcess_Delay 0xf0000
+#define bRxSearchrange_GI2_Early 0x700000
+#define bRxFrame_Guard_Counter_L 0x3800000
+#define bRxSGI_Guard_L 0xc000000
+#define bRxSGI_Search_L 0x30000000
+#define bRxSGI_TH 0xc0000000
+#define bDFSCnt0 0xff
+#define bDFSCnt1 0xff00
+#define bDFSFlag 0xf0000
+#define bMFWeightSum 0x300000
+#define bMinIdxTH 0x7f000000
+#define bDAFormat 0x40000
+#define bTxChEmuEnable 0x01000000
+#define bTRSWIsolation_A 0x7f
+#define bTRSWIsolation_B 0x7f00
+#define bTRSWIsolation_C 0x7f0000
+#define bTRSWIsolation_D 0x7f000000
+#define bExtLNAGain 0x7c00
 
 /* 6. PageE(0xE00) */
-#define	bSTBCEn                 0x4	/* Useless */
-#define	bAntennaMapping         0x10
-#define	bNss                    0x20
-#define	bCFOAntSumD             0x200
-#define	bPHYCounterReset        0x8000000
-#define	bCFOReportGet           0x4000000
-#define	bOFDMContinueTx         0x10000000
-#define	bOFDMSingleCarrier      0x20000000
-#define	bOFDMSingleTone         0x40000000
-#define	bHTDetect               0x100
-#define	bCFOEn                  0x10000
-#define	bCFOValue               0xfff00000
-#define	bSigTone_Re             0x3f
-#define	bSigTone_Im             0x7f00
-#define	bCounter_CCA            0xffff
-#define	bCounter_ParityFail     0xffff0000
-#define	bCounter_RateIllegal    0xffff
-#define	bCounter_CRC8Fail       0xffff0000
-#define	bCounter_MCSNoSupport   0xffff
-#define	bCounter_FastSync       0xffff
-#define	bShortCFO               0xfff
-#define	bShortCFOTLength        12   /* total */
-#define	bShortCFOFLength        11   /* fraction */
-#define	bLongCFO                0x7ff
-#define	bLongCFOTLength         11
-#define	bLongCFOFLength         11
-#define	bTailCFO                0x1fff
-#define	bTailCFOTLength         13
-#define	bTailCFOFLength         12
-#define	bmax_en_pwdB            0xffff
-#define	bCC_power_dB            0xffff0000
-#define	bnoise_pwdB             0xffff
-#define	bPowerMeasTLength       10
-#define	bPowerMeasFLength       3
-#define	bRx_HT_BW               0x1
-#define	bRxSC                   0x6
-#define	bRx_HT                  0x8
-#define	bNB_intf_det_on         0x1
-#define	bIntf_win_len_cfg       0x30
-#define	bNB_Intf_TH_cfg         0x1c0
-#define	bRFGain                 0x3f
-#define	bTableSel               0x40
-#define	bTRSW                   0x80
-#define	bRxSNR_A                0xff
-#define	bRxSNR_B                0xff00
-#define	bRxSNR_C                0xff0000
-#define	bRxSNR_D                0xff000000
-#define	bSNREVMTLength          8
-#define	bSNREVMFLength          1
-#define	bCSI1st                 0xff
-#define	bCSI2nd                 0xff00
-#define	bRxEVM1st               0xff0000
-#define	bRxEVM2nd               0xff000000
-#define	bSIGEVM                 0xff
-#define	bPWDB                   0xff00
-#define	bSGIEN                  0x10000
-
-#define	bSFactorQAM1            0xf	/* Useless */
-#define	bSFactorQAM2            0xf0
-#define	bSFactorQAM3            0xf00
-#define	bSFactorQAM4            0xf000
-#define	bSFactorQAM5            0xf0000
-#define	bSFactorQAM6            0xf0000
-#define	bSFactorQAM7            0xf00000
-#define	bSFactorQAM8            0xf000000
-#define	bSFactorQAM9            0xf0000000
-#define	bCSIScheme              0x100000
-
-#define	bNoiseLvlTopSet         0x3	/* Useless */
-#define	bChSmooth               0x4
-#define	bChSmoothCfg1           0x38
-#define	bChSmoothCfg2           0x1c0
-#define	bChSmoothCfg3           0xe00
-#define	bChSmoothCfg4           0x7000
-#define	bMRCMode                0x800000
-#define	bTHEVMCfg               0x7000000
-
-#define	bLoopFitType            0x1	/* Useless */
-#define	bUpdCFO                 0x40
-#define	bUpdCFOOffData          0x80
-#define	bAdvUpdCFO              0x100
-#define	bAdvTimeCtrl            0x800
-#define	bUpdClko                0x1000
-#define	bFC                     0x6000
-#define	bTrackingMode           0x8000
-#define	bPhCmpEnable            0x10000
-#define	bUpdClkoLTF             0x20000
-#define	bComChCFO               0x40000
-#define	bCSIEstiMode            0x80000
-#define	bAdvUpdEqz              0x100000
-#define	bUChCfg                 0x7000000
-#define	bUpdEqz			0x8000000
-
-#define	bTxAGCRate18_06		0x7f7f7f7f	/* Useless */
-#define	bTxAGCRate54_24		0x7f7f7f7f
-#define	bTxAGCRateMCS32		0x7f
-#define	bTxAGCRateCCK		0x7f00
-#define	bTxAGCRateMCS3_MCS0	0x7f7f7f7f
-#define	bTxAGCRateMCS7_MCS4	0x7f7f7f7f
-#define	bTxAGCRateMCS11_MCS8	0x7f7f7f7f
-#define	bTxAGCRateMCS15_MCS12	0x7f7f7f7f
+#define bSTBCEn 0x4 /* Useless */
+#define bAntennaMapping 0x10
+#define bNss 0x20
+#define bCFOAntSumD 0x200
+#define bPHYCounterReset 0x8000000
+#define bCFOReportGet 0x4000000
+#define bOFDMContinueTx 0x10000000
+#define bOFDMSingleCarrier 0x20000000
+#define bOFDMSingleTone 0x40000000
+#define bHTDetect 0x100
+#define bCFOEn 0x10000
+#define bCFOValue 0xfff00000
+#define bSigTone_Re 0x3f
+#define bSigTone_Im 0x7f00
+#define bCounter_CCA 0xffff
+#define bCounter_ParityFail 0xffff0000
+#define bCounter_RateIllegal 0xffff
+#define bCounter_CRC8Fail 0xffff0000
+#define bCounter_MCSNoSupport 0xffff
+#define bCounter_FastSync 0xffff
+#define bShortCFO 0xfff
+#define bShortCFOTLength 12 /* total */
+#define bShortCFOFLength 11 /* fraction */
+#define bLongCFO 0x7ff
+#define bLongCFOTLength 11
+#define bLongCFOFLength 11
+#define bTailCFO 0x1fff
+#define bTailCFOTLength 13
+#define bTailCFOFLength 12
+#define bmax_en_pwdB 0xffff
+#define bCC_power_dB 0xffff0000
+#define bnoise_pwdB 0xffff
+#define bPowerMeasTLength 10
+#define bPowerMeasFLength 3
+#define bRx_HT_BW 0x1
+#define bRxSC 0x6
+#define bRx_HT 0x8
+#define bNB_intf_det_on 0x1
+#define bIntf_win_len_cfg 0x30
+#define bNB_Intf_TH_cfg 0x1c0
+#define bRFGain 0x3f
+#define bTableSel 0x40
+#define bTRSW 0x80
+#define bRxSNR_A 0xff
+#define bRxSNR_B 0xff00
+#define bRxSNR_C 0xff0000
+#define bRxSNR_D 0xff000000
+#define bSNREVMTLength 8
+#define bSNREVMFLength 1
+#define bCSI1st 0xff
+#define bCSI2nd 0xff00
+#define bRxEVM1st 0xff0000
+#define bRxEVM2nd 0xff000000
+#define bSIGEVM 0xff
+#define bPWDB 0xff00
+#define bSGIEN 0x10000
+
+#define bSFactorQAM1 0xf /* Useless */
+#define bSFactorQAM2 0xf0
+#define bSFactorQAM3 0xf00
+#define bSFactorQAM4 0xf000
+#define bSFactorQAM5 0xf0000
+#define bSFactorQAM6 0xf0000
+#define bSFactorQAM7 0xf00000
+#define bSFactorQAM8 0xf000000
+#define bSFactorQAM9 0xf0000000
+#define bCSIScheme 0x100000
+
+#define bNoiseLvlTopSet 0x3 /* Useless */
+#define bChSmooth 0x4
+#define bChSmoothCfg1 0x38
+#define bChSmoothCfg2 0x1c0
+#define bChSmoothCfg3 0xe00
+#define bChSmoothCfg4 0x7000
+#define bMRCMode 0x800000
+#define bTHEVMCfg 0x7000000
+
+#define bLoopFitType 0x1 /* Useless */
+#define bUpdCFO 0x40
+#define bUpdCFOOffData 0x80
+#define bAdvUpdCFO 0x100
+#define bAdvTimeCtrl 0x800
+#define bUpdClko 0x1000
+#define bFC 0x6000
+#define bTrackingMode 0x8000
+#define bPhCmpEnable 0x10000
+#define bUpdClkoLTF 0x20000
+#define bComChCFO 0x40000
+#define bCSIEstiMode 0x80000
+#define bAdvUpdEqz 0x100000
+#define bUChCfg 0x7000000
+#define bUpdEqz 0x8000000
+
+#define bTxAGCRate18_06 0x7f7f7f7f /* Useless */
+#define bTxAGCRate54_24 0x7f7f7f7f
+#define bTxAGCRateMCS32 0x7f
+#define bTxAGCRateCCK 0x7f00
+#define bTxAGCRateMCS3_MCS0 0x7f7f7f7f
+#define bTxAGCRateMCS7_MCS4 0x7f7f7f7f
+#define bTxAGCRateMCS11_MCS8 0x7f7f7f7f
+#define bTxAGCRateMCS15_MCS12 0x7f7f7f7f
 
 /* Rx Pseduo noise */
-#define	bRxPesudoNoiseOn         0x20000000	/* Useless */
-#define	bRxPesudoNoise_A         0xff
-#define	bRxPesudoNoise_B         0xff00
-#define	bRxPesudoNoise_C         0xff0000
-#define	bRxPesudoNoise_D         0xff000000
-#define	bPesudoNoiseState_A      0xffff
-#define	bPesudoNoiseState_B      0xffff0000
-#define	bPesudoNoiseState_C      0xffff
-#define	bPesudoNoiseState_D      0xffff0000
+#define bRxPesudoNoiseOn 0x20000000 /* Useless */
+#define bRxPesudoNoise_A 0xff
+#define bRxPesudoNoise_B 0xff00
+#define bRxPesudoNoise_C 0xff0000
+#define bRxPesudoNoise_D 0xff000000
+#define bPesudoNoiseState_A 0xffff
+#define bPesudoNoiseState_B 0xffff0000
+#define bPesudoNoiseState_C 0xffff
+#define bPesudoNoiseState_D 0xffff0000
 
 /* 7. RF Register
  * Zebra1
  */
-#define	bZebra1_HSSIEnable        0x8		/* Useless */
-#define	bZebra1_TRxControl        0xc00
-#define	bZebra1_TRxGainSetting    0x07f
-#define	bZebra1_RxCorner          0xc00
-#define	bZebra1_TxChargePump      0x38
-#define	bZebra1_RxChargePump      0x7
-#define	bZebra1_ChannelNum        0xf80
-#define	bZebra1_TxLPFBW           0x400
-#define	bZebra1_RxLPFBW           0x600
+#define bZebra1_HSSIEnable 0x8 /* Useless */
+#define bZebra1_TRxControl 0xc00
+#define bZebra1_TRxGainSetting 0x07f
+#define bZebra1_RxCorner 0xc00
+#define bZebra1_TxChargePump 0x38
+#define bZebra1_RxChargePump 0x7
+#define bZebra1_ChannelNum 0xf80
+#define bZebra1_TxLPFBW 0x400
+#define bZebra1_RxLPFBW 0x600
 
 /*Zebra4 */
-#define	bRTL8256RegModeCtrl1      0x100	/* Useless */
-#define	bRTL8256RegModeCtrl0      0x40
-#define	bRTL8256_TxLPFBW          0x18
-#define	bRTL8256_RxLPFBW          0x600
+#define bRTL8256RegModeCtrl1 0x100 /* Useless */
+#define bRTL8256RegModeCtrl0 0x40
+#define bRTL8256_TxLPFBW 0x18
+#define bRTL8256_RxLPFBW 0x600
 
 /* RTL8258 */
-#define	bRTL8258_TxLPFBW          0xc	/* Useless */
-#define	bRTL8258_RxLPFBW          0xc00
-#define	bRTL8258_RSSILPFBW        0xc0
+#define bRTL8258_TxLPFBW 0xc /* Useless */
+#define bRTL8258_RxLPFBW 0xc00
+#define bRTL8258_RSSILPFBW 0xc0
 
 /*
  * Other Definition
  */
 
 /* byte endable for sb_write */
-#define	bByte0                    0x1	/* Useless */
-#define	bByte1                    0x2
-#define	bByte2                    0x4
-#define	bByte3                    0x8
-#define	bWord0                    0x3
-#define	bWord1                    0xc
-#define	bDWord                    0xf
+#define bByte0 0x1 /* Useless */
+#define bByte1 0x2
+#define bByte2 0x4
+#define bByte3 0x8
+#define bWord0 0x3
+#define bWord1 0xc
+#define bDWord 0xf
 
 /* for PutRegsetting & GetRegSetting BitMask */
-#define	bMaskByte0                0xff	/* Reg 0xc50 rOFDM0_XAAGCCore~0xC6f */
-#define	bMaskByte1                0xff00
-#define	bMaskByte2                0xff0000
-#define	bMaskByte3                0xff000000
-#define	bMaskHWord                0xffff0000
-#define	bMaskLWord                0x0000ffff
-#define	bMaskDWord                0xffffffff
+#define bMaskByte0 0xff /* Reg 0xc50 rOFDM0_XAAGCCore~0xC6f */
+#define bMaskByte1 0xff00
+#define bMaskByte2 0xff0000
+#define bMaskByte3 0xff000000
+#define bMaskHWord 0xffff0000
+#define bMaskLWord 0x0000ffff
+#define bMaskDWord 0xffffffff
 
 /* for PutRFRegsetting & GetRFRegSetting BitMask */
-#define	bRFRegOffsetMask	0xfffff
-#define	bEnable                   0x1	/* Useless */
-#define	bDisable                  0x0
+#define bRFRegOffsetMask 0xfffff
+#define bEnable 0x1 /* Useless */
+#define bDisable 0x0
 
-#define	LeftAntenna               0x0	/* Useless */
-#define	RightAntenna              0x1
+#define LeftAntenna 0x0 /* Useless */
+#define RightAntenna 0x1
 
-#define	tCheckTxStatus            500   /* 500ms Useless */
-#define	tUpdateRxCounter          100   /* 100ms */
+#define tCheckTxStatus 500 /* 500ms Useless */
+#define tUpdateRxCounter 100 /* 100ms */
 
-#define	rateCCK     0	/* Useless */
-#define	rateOFDM    1
-#define	rateHT      2
+#define rateCCK 0 /* Useless */
+#define rateOFDM 1
+#define rateHT 2
 
 /* define Register-End */
-#define	bPMAC_End       0x1ff	/* Useless */
-#define	bFPGAPHY0_End   0x8ff
-#define	bFPGAPHY1_End   0x9ff
-#define	bCCKPHY0_End    0xaff
-#define	bOFDMPHY0_End   0xcff
-#define	bOFDMPHY1_End   0xdff
+#define bPMAC_End 0x1ff /* Useless */
+#define bFPGAPHY0_End 0x8ff
+#define bFPGAPHY1_End 0x9ff
+#define bCCKPHY0_End 0xaff
+#define bOFDMPHY0_End 0xcff
+#define bOFDMPHY1_End 0xdff
 
-#define	bPMACControl	0x0	/* Useless */
-#define	bWMACControl	0x1
-#define	bWNICControl	0x2
+#define bPMACControl 0x0 /* Useless */
+#define bWMACControl 0x1
+#define bWNICControl 0x2
 
-#define	ANTENNA_A	0x1	/* Useless */
-#define	ANTENNA_B	0x2
-#define	ANTENNA_AB	0x3	/* ANTENNA_A |ANTENNA_B */
+#define ANTENNA_A 0x1 /* Useless */
+#define ANTENNA_B 0x2
+#define ANTENNA_AB 0x3 /* ANTENNA_A |ANTENNA_B */
 
-#define	ANTENNA_C	0x4
-#define	ANTENNA_D	0x8
+#define ANTENNA_C 0x4
+#define ANTENNA_D 0x8
 
 /* accept all physical address */
-#define RCR_AAP		BIT(0)
-#define RCR_APM		BIT(1)		/* accept physical match */
-#define RCR_AM		BIT(2)		/* accept multicast */
-#define RCR_AB		BIT(3)		/* accept broadcast */
-#define RCR_ACRC32	BIT(5)		/* accept error packet */
-#define RCR_9356SEL	BIT(6)
-#define RCR_AICV	BIT(12)		/* Accept ICV error packet */
-#define RCR_RXFTH0	(BIT(13)|BIT(14)|BIT(15))	/* Rx FIFO threshold */
-#define RCR_ADF		BIT(18)		/* Accept Data(frame type) frame */
-#define RCR_ACF		BIT(19)		/* Accept control frame */
-#define RCR_AMF		BIT(20)		/* Accept management frame */
-#define RCR_ADD3	BIT(21)
-#define RCR_APWRMGT	BIT(22)		/* Accept power management packet */
-#define RCR_CBSSID	BIT(23)		/* Accept BSSID match packet */
-#define RCR_ENMARP	BIT(28)		/* enable mac auto reset phy */
-#define RCR_EnCS1	BIT(29)		/* enable carrier sense method 1 */
-#define RCR_EnCS2	BIT(30)		/* enable carrier sense method 2 */
+#define RCR_AAP BIT(0)
+#define RCR_APM BIT(1) /* accept physical match */
+#define RCR_AM BIT(2) /* accept multicast */
+#define RCR_AB BIT(3) /* accept broadcast */
+#define RCR_ACRC32 BIT(5) /* accept error packet */
+#define RCR_9356SEL BIT(6)
+#define RCR_AICV BIT(12) /* Accept ICV error packet */
+#define RCR_RXFTH0 (BIT(13) | BIT(14) | BIT(15)) /* Rx FIFO threshold */
+#define RCR_ADF BIT(18) /* Accept Data(frame type) frame */
+#define RCR_ACF BIT(19) /* Accept control frame */
+#define RCR_AMF BIT(20) /* Accept management frame */
+#define RCR_ADD3 BIT(21)
+#define RCR_APWRMGT BIT(22) /* Accept power management packet */
+#define RCR_CBSSID BIT(23) /* Accept BSSID match packet */
+#define RCR_ENMARP BIT(28) /* enable mac auto reset phy */
+#define RCR_EnCS1 BIT(29) /* enable carrier sense method 1 */
+#define RCR_EnCS2 BIT(30) /* enable carrier sense method 2 */
 /* Rx Early mode is performed for packet size greater than 1536 */
-#define RCR_OnlyErlPkt	BIT(31)
+#define RCR_OnlyErlPkt BIT(31)
 
 /*--------------------------Define Parameters-------------------------------*/
 
-#endif	/*__INC_HAL8192SPHYREG_H */
-
+#endif /*__INC_HAL8192SPHYREG_H */
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.c b/drivers/staging/rtl8712/rtl871x_pwrctrl.c
index cd6d9ff0bebc..e87c8b9a0e29 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.c
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.c
@@ -25,7 +25,7 @@
 
 void r8712_set_rpwm(struct _adapter *padapter, u8 val8)
 {
-	u8	rpwm;
+	u8 rpwm;
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 
 	if (pwrpriv->rpwm == val8) {
@@ -39,7 +39,7 @@ void r8712_set_rpwm(struct _adapter *padapter, u8 val8)
 	case PS_STATE_S1:
 		pwrpriv->cpwm = val8;
 		break;
-	case PS_STATE_S2:/* only for USB normal powersave mode use,
+	case PS_STATE_S2: /* only for USB normal powersave mode use,
 			  * temp mark some code.
 			  */
 	case PS_STATE_S3:
@@ -64,7 +64,7 @@ void r8712_set_ps_mode(struct _adapter *padapter, uint ps_mode, uint smart_ps)
 	/* if driver is in active state, we dont need set smart_ps.*/
 	if (ps_mode == PS_MODE_ACTIVE)
 		smart_ps = 0;
-	if ((pwrpriv->pwr_mode != ps_mode) || (pwrpriv->smart_ps != smart_ps)) {
+	if (pwrpriv->pwr_mode != ps_mode || pwrpriv->smart_ps != smart_ps) {
 		if (pwrpriv->pwr_mode == PS_MODE_ACTIVE)
 			pwrpriv->bSleep = true;
 		else
@@ -86,17 +86,17 @@ void r8712_set_ps_mode(struct _adapter *padapter, uint ps_mode, uint smart_ps)
 void r8712_cpwm_int_hdl(struct _adapter *padapter,
 			struct reportpwrstate_parm *preportpwrstate)
 {
-	struct pwrctrl_priv *pwrpriv = &(padapter->pwrctrlpriv);
-	struct cmd_priv	*pcmdpriv = &(padapter->cmdpriv);
+	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 
-	if (pwrpriv->cpwm_tog == ((preportpwrstate->state) & 0x80))
+	if (pwrpriv->cpwm_tog == (preportpwrstate->state & 0x80))
 		return;
 	del_timer(&padapter->pwrctrlpriv.rpwm_check_timer);
 	mutex_lock(&pwrpriv->mutex_lock);
 	pwrpriv->cpwm = (preportpwrstate->state) & 0xf;
 	if (pwrpriv->cpwm >= PS_STATE_S2) {
 		if (pwrpriv->alives & CMD_ALIVE)
-			complete(&(pcmdpriv->cmd_queue_comp));
+			complete(&pcmdpriv->cmd_queue_comp);
 	}
 	pwrpriv->cpwm_tog = (preportpwrstate->state) & 0x80;
 	mutex_unlock(&pwrpriv->mutex_lock);
@@ -104,7 +104,7 @@ void r8712_cpwm_int_hdl(struct _adapter *padapter,
 
 static inline void register_task_alive(struct pwrctrl_priv *pwrctrl, uint tag)
 {
-		pwrctrl->alives |= tag;
+	pwrctrl->alives |= tag;
 }
 
 static inline void unregister_task_alive(struct pwrctrl_priv *pwrctrl, uint tag)
@@ -113,7 +113,7 @@ static inline void unregister_task_alive(struct pwrctrl_priv *pwrctrl, uint tag)
 		pwrctrl->alives ^= tag;
 }
 
-static void _rpwm_check_handler (struct _adapter *padapter)
+static void _rpwm_check_handler(struct _adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 
@@ -125,10 +125,10 @@ static void _rpwm_check_handler (struct _adapter *padapter)
 
 static void SetPSModeWorkItemCallback(struct work_struct *work)
 {
-	struct pwrctrl_priv *pwrpriv = container_of(work,
-				       struct pwrctrl_priv, SetPSModeWorkItem);
-	struct _adapter *padapter = container_of(pwrpriv,
-				    struct _adapter, pwrctrlpriv);
+	struct pwrctrl_priv *pwrpriv =
+		container_of(work, struct pwrctrl_priv, SetPSModeWorkItem);
+	struct _adapter *padapter =
+		container_of(pwrpriv, struct _adapter, pwrctrlpriv);
 	if (!pwrpriv->bSleep) {
 		mutex_lock(&pwrpriv->mutex_lock);
 		if (pwrpriv->pwr_mode == PS_MODE_ACTIVE)
@@ -139,10 +139,10 @@ static void SetPSModeWorkItemCallback(struct work_struct *work)
 
 static void rpwm_workitem_callback(struct work_struct *work)
 {
-	struct pwrctrl_priv *pwrpriv = container_of(work,
-				       struct pwrctrl_priv, rpwm_workitem);
-	struct _adapter *padapter = container_of(pwrpriv,
-				    struct _adapter, pwrctrlpriv);
+	struct pwrctrl_priv *pwrpriv =
+		container_of(work, struct pwrctrl_priv, rpwm_workitem);
+	struct _adapter *padapter =
+		container_of(pwrpriv, struct _adapter, pwrctrlpriv);
 	if (pwrpriv->cpwm != pwrpriv->rpwm) {
 		mutex_lock(&pwrpriv->mutex_lock);
 		r8712_read8(padapter, SDIO_HCPWM);
@@ -152,7 +152,7 @@ static void rpwm_workitem_callback(struct work_struct *work)
 	}
 }
 
-static void rpwm_check_handler (struct timer_list *t)
+static void rpwm_check_handler(struct timer_list *t)
 {
 	struct _adapter *adapter =
 		from_timer(adapter, t, pwrctrlpriv.rpwm_check_timer);
@@ -170,7 +170,7 @@ void r8712_init_pwrctrl_priv(struct _adapter *padapter)
 	pwrctrlpriv->pwr_mode = PS_MODE_ACTIVE;
 	pwrctrlpriv->smart_ps = 0;
 	pwrctrlpriv->tog = 0x80;
-/* clear RPWM to ensure driver and fw back to initial state. */
+	/* clear RPWM to ensure driver and fw back to initial state. */
 	r8712_write8(padapter, 0x1025FE58, 0);
 	INIT_WORK(&pwrctrlpriv->SetPSModeWorkItem, SetPSModeWorkItemCallback);
 	INIT_WORK(&pwrctrlpriv->rpwm_workitem, rpwm_workitem_callback);
@@ -214,11 +214,10 @@ void r8712_unregister_cmd_alive(struct _adapter *padapter)
 
 	mutex_lock(&pwrctrl->mutex_lock);
 	unregister_task_alive(pwrctrl, CMD_ALIVE);
-	if ((pwrctrl->cpwm > PS_STATE_S2) &&
-	   (pwrctrl->pwr_mode > PS_MODE_ACTIVE)) {
-		if ((pwrctrl->alives == 0) &&
-		    (check_fwstate(&padapter->mlmepriv,
-		     _FW_UNDER_LINKING) != true)) {
+	if (pwrctrl->cpwm > PS_STATE_S2 && pwrctrl->pwr_mode > PS_MODE_ACTIVE) {
+		if (pwrctrl->alives == 0 &&
+		    check_fwstate(&padapter->mlmepriv, _FW_UNDER_LINKING) !=
+			    true) {
 			r8712_set_rpwm(padapter, PS_STATE_S0);
 		}
 	}
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.h b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
index b35b9c7920eb..f84841cbc5cd 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.h
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
@@ -17,10 +17,10 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#define CMD_ALIVE	BIT(2)
+#define CMD_ALIVE BIT(2)
 
 enum Power_Mgnt {
-	PS_MODE_ACTIVE	= 0,
+	PS_MODE_ACTIVE = 0,
 	PS_MODE_MIN,
 	PS_MODE_MAX,
 	PS_MODE_DTIM,
@@ -41,30 +41,30 @@ enum Power_Mgnt {
  * BIT[4] = sub-state
  */
 
-#define		PS_DPS				BIT(0)
-#define		PS_LCLK				(PS_DPS)
-#define	PS_RF_OFF			BIT(1)
-#define	PS_ALL_ON			BIT(2)
-#define	PS_ST_ACTIVE		BIT(3)
-#define	PS_LP				BIT(4)	/* low performance */
+#define PS_DPS BIT(0)
+#define PS_LCLK (PS_DPS)
+#define PS_RF_OFF BIT(1)
+#define PS_ALL_ON BIT(2)
+#define PS_ST_ACTIVE BIT(3)
+#define PS_LP BIT(4) /* low performance */
 
-#define	PS_STATE_MASK		(0x0F)
-#define	PS_STATE_HW_MASK	(0x07)
-#define		PS_SEQ_MASK		(0xc0)
+#define PS_STATE_MASK (0x0F)
+#define PS_STATE_HW_MASK (0x07)
+#define PS_SEQ_MASK (0xc0)
 
-#define	PS_STATE(x)			(PS_STATE_MASK & (x))
-#define	PS_STATE_HW(x)	(PS_STATE_HW_MASK & (x))
-#define	PS_SEQ(x)			(PS_SEQ_MASK & (x))
+#define PS_STATE(x) (PS_STATE_MASK & (x))
+#define PS_STATE_HW(x) (PS_STATE_HW_MASK & (x))
+#define PS_SEQ(x) (PS_SEQ_MASK & (x))
 
-#define	PS_STATE_S0		(PS_DPS)
-#define		PS_STATE_S1		(PS_LCLK)
-#define	PS_STATE_S2		(PS_RF_OFF)
-#define		PS_STATE_S3		(PS_ALL_ON)
-#define	PS_STATE_S4		((PS_ST_ACTIVE) | (PS_ALL_ON))
+#define PS_STATE_S0 (PS_DPS)
+#define PS_STATE_S1 (PS_LCLK)
+#define PS_STATE_S2 (PS_RF_OFF)
+#define PS_STATE_S3 (PS_ALL_ON)
+#define PS_STATE_S4 ((PS_ST_ACTIVE) | (PS_ALL_ON))
 
-#define		PS_IS_RF_ON(x)		((x) & (PS_ALL_ON))
-#define		PS_IS_ACTIVE(x)		((x) & (PS_ST_ACTIVE))
-#define		CLR_PS_STATE(x)	((x) = ((x) & (0xF0)))
+#define PS_IS_RF_ON(x) ((x) & (PS_ALL_ON))
+#define PS_IS_ACTIVE(x) ((x) & (PS_ST_ACTIVE))
+#define CLR_PS_STATE(x) ((x) = ((x) & (0xF0)))
 
 struct reportpwrstate_parm {
 	unsigned char mode;
@@ -72,7 +72,7 @@ struct reportpwrstate_parm {
 	unsigned short rsvd;
 };
 
-struct	pwrctrl_priv {
+struct pwrctrl_priv {
 	struct mutex mutex_lock;
 	/*volatile*/ u8 rpwm; /* requested power state for fw */
 	/* fw current power state. updated when 1. read from HCPWM or
@@ -85,19 +85,19 @@ struct	pwrctrl_priv {
 	uint pwr_mode;
 	uint smart_ps;
 	uint alives;
-	uint ImrContent;	/* used to store original imr. */
+	uint ImrContent; /* used to store original imr. */
 	uint bSleep; /* sleep -> active is different from active -> sleep. */
 
 	struct work_struct SetPSModeWorkItem;
 	struct work_struct rpwm_workitem;
 	struct timer_list rpwm_check_timer;
-	u8	rpwm_retry;
-	uint	bSetPSModeWorkItemInProgress;
+	u8 rpwm_retry;
+	uint bSetPSModeWorkItemInProgress;
 
 	spinlock_t pnp_pwr_mgnt_lock;
-	s32	pnp_current_pwr_state;
-	u8	pnp_bstop_trx;
-	u8	pnp_wwirp_pending;
+	s32 pnp_current_pwr_state;
+	u8 pnp_bstop_trx;
+	u8 pnp_wwirp_pending;
 };
 
 void r8712_init_pwrctrl_priv(struct _adapter *adapter);
@@ -105,9 +105,8 @@ int r8712_register_cmd_alive(struct _adapter *padapter);
 void r8712_unregister_cmd_alive(struct _adapter *padapter);
 void r8712_cpwm_int_hdl(struct _adapter *padapter,
 			struct reportpwrstate_parm *preportpwrstate);
-void r8712_set_ps_mode(struct _adapter *padapter, uint ps_mode,
-			uint smart_ps);
+void r8712_set_ps_mode(struct _adapter *padapter, uint ps_mode, uint smart_ps);
 void r8712_set_rpwm(struct _adapter *padapter, u8 val8);
 void r8712_flush_rwctrl_works(struct _adapter *padapter);
 
-#endif  /* __RTL871X_PWRCTRL_H_ */
+#endif /* __RTL871X_PWRCTRL_H_ */
diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index 8a3566214af7..ee194fddc554 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -30,10 +30,10 @@
 #include "usb_ops.h"
 #include "wifi.h"
 
-static const u8 SNAP_ETH_TYPE_IPX[2] = {0x81, 0x37};
+static const u8 SNAP_ETH_TYPE_IPX[2] = { 0x81, 0x37 };
 
 /* Datagram Delivery Protocol */
-static const u8 SNAP_ETH_TYPE_APPLETALK_AARP[2] = {0x80, 0xf3};
+static const u8 SNAP_ETH_TYPE_APPLETALK_AARP[2] = { 0x80, 0xf3 };
 
 void _r8712_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 {
@@ -49,26 +49,26 @@ int _r8712_init_recv_priv(struct recv_priv *precvpriv,
 	sint i;
 	union recv_frame *precvframe;
 
-	memset((unsigned char *)precvpriv, 0, sizeof(struct  recv_priv));
+	memset((unsigned char *)precvpriv, 0, sizeof(struct recv_priv));
 	spin_lock_init(&precvpriv->lock);
 	_init_queue(&precvpriv->free_recv_queue);
 	_init_queue(&precvpriv->recv_pending_queue);
 	precvpriv->adapter = padapter;
 	precvpriv->free_recvframe_cnt = NR_RECVFRAME;
-	precvpriv->pallocated_frame_buf = kzalloc(NR_RECVFRAME *
-				sizeof(union recv_frame) + RXFRAME_ALIGN_SZ,
-				GFP_ATOMIC);
+	precvpriv->pallocated_frame_buf = kzalloc(
+		NR_RECVFRAME * sizeof(union recv_frame) + RXFRAME_ALIGN_SZ,
+		GFP_ATOMIC);
 	if (!precvpriv->pallocated_frame_buf)
 		return -ENOMEM;
-	precvpriv->precv_frame_buf = precvpriv->pallocated_frame_buf +
-				    RXFRAME_ALIGN_SZ -
-				    ((addr_t)(precvpriv->pallocated_frame_buf) &
-				    (RXFRAME_ALIGN_SZ - 1));
+	precvpriv->precv_frame_buf =
+		precvpriv->pallocated_frame_buf + RXFRAME_ALIGN_SZ -
+		((addr_t)(precvpriv->pallocated_frame_buf) &
+		 (RXFRAME_ALIGN_SZ - 1));
 	precvframe = (union recv_frame *)precvpriv->precv_frame_buf;
 	for (i = 0; i < NR_RECVFRAME; i++) {
-		INIT_LIST_HEAD(&(precvframe->u.list));
-		list_add_tail(&(precvframe->u.list),
-			      &(precvpriv->free_recv_queue.queue));
+		INIT_LIST_HEAD(&precvframe->u.list);
+		list_add_tail(&precvframe->u.list,
+			      &precvpriv->free_recv_queue.queue);
 		r8712_os_recv_resource_alloc(padapter, precvframe);
 		precvframe->u.hdr.adapter = padapter;
 		precvframe++;
@@ -90,7 +90,7 @@ void _r8712_free_recv_priv(struct recv_priv *precvpriv)
 union recv_frame *r8712_alloc_recvframe(struct __queue *pfree_recv_queue)
 {
 	unsigned long irqL;
-	union recv_frame  *precvframe;
+	union recv_frame *precvframe;
 	struct _adapter *padapter;
 	struct recv_priv *precvpriv;
 
@@ -115,10 +115,10 @@ union recv_frame *r8712_alloc_recvframe(struct __queue *pfree_recv_queue)
  * pframequeue: defrag_queue : will be accessed in recv_thread  (passive)
  * using spin_lock to protect
  */
-void r8712_free_recvframe_queue(struct  __queue *pframequeue,
-				struct  __queue *pfree_recv_queue)
+void r8712_free_recvframe_queue(struct __queue *pframequeue,
+				struct __queue *pfree_recv_queue)
 {
-	union	recv_frame *precvframe;
+	union recv_frame *precvframe;
 	struct list_head *plist, *phead;
 
 	spin_lock(&pframequeue->lock);
@@ -136,14 +136,14 @@ sint r8712_recvframe_chkmic(struct _adapter *adapter,
 			    union recv_frame *precvframe)
 {
 	sint i, res = _SUCCESS;
-	u32	datalen;
+	u32 datalen;
 	u8 miccode[8];
 	u8 bmic_err = false;
 	u8 *pframe, *payload, *pframemic;
-	u8   *mickey, idx, *iv;
-	struct	sta_info *stainfo;
-	struct	rx_pkt_attrib *prxattrib = &precvframe->u.hdr.attrib;
-	struct	security_priv *psecuritypriv = &adapter->securitypriv;
+	u8 *mickey, idx, *iv;
+	struct sta_info *stainfo;
+	struct rx_pkt_attrib *prxattrib = &precvframe->u.hdr.attrib;
+	struct security_priv *psecuritypriv = &adapter->securitypriv;
 
 	stainfo = r8712_get_stainfo(&adapter->stapriv, &prxattrib->ta[0]);
 	if (prxattrib->encrypt == _TKIP_) {
@@ -153,8 +153,11 @@ sint r8712_recvframe_chkmic(struct _adapter *adapter,
 				iv = precvframe->u.hdr.rx_data +
 				     prxattrib->hdrlen;
 				idx = iv[3];
-				mickey = &psecuritypriv->XGrprxmickey[(((idx >>
-					 6) & 0x3)) - 1].skey[0];
+				mickey = &psecuritypriv
+						  ->XGrprxmickey[(((idx >> 6) &
+								   0x3)) -
+								 1]
+						  .skey[0];
 				if (!psecuritypriv->binstallGrpkey)
 					return _FAIL;
 			} else {
@@ -164,8 +167,8 @@ sint r8712_recvframe_chkmic(struct _adapter *adapter,
 			datalen = precvframe->u.hdr.len - prxattrib->hdrlen -
 				  prxattrib->iv_len - prxattrib->icv_len - 8;
 			pframe = precvframe->u.hdr.rx_data;
-			payload = pframe + prxattrib->hdrlen +
-				  prxattrib->iv_len;
+			payload =
+				pframe + prxattrib->hdrlen + prxattrib->iv_len;
 			seccalctkipmic(mickey, pframe, payload, datalen,
 				       &miccode[0],
 				       (unsigned char)prxattrib->priority);
@@ -177,8 +180,10 @@ sint r8712_recvframe_chkmic(struct _adapter *adapter,
 			}
 			if (bmic_err) {
 				if (prxattrib->bdecrypted)
-					r8712_handle_tkip_mic_err(adapter,
-								  (u8)is_multicast_ether_addr(prxattrib->ra));
+					r8712_handle_tkip_mic_err(
+						adapter,
+						(u8)is_multicast_ether_addr(
+							prxattrib->ra));
 				res = _FAIL;
 			} else {
 				/* mic checked ok */
@@ -200,8 +205,8 @@ union recv_frame *r8712_decryptor(struct _adapter *padapter,
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	union recv_frame *return_packet = precv_frame;
 
-	if ((prxattrib->encrypt > 0) && ((prxattrib->bdecrypted == 0) ||
-					 psecuritypriv->sw_decrypt)) {
+	if (prxattrib->encrypt > 0 &&
+	    (prxattrib->bdecrypted == 0 || psecuritypriv->sw_decrypt)) {
 		psecuritypriv->hw_decrypted = false;
 		switch (prxattrib->encrypt) {
 		case _WEP40_:
@@ -215,7 +220,7 @@ union recv_frame *r8712_decryptor(struct _adapter *padapter,
 			r8712_aes_decrypt(padapter, (u8 *)precv_frame);
 			break;
 		default:
-				break;
+			break;
 		}
 	} else if (prxattrib->bdecrypted == 1) {
 		psecuritypriv->hw_decrypted = true;
@@ -231,7 +236,7 @@ union recv_frame *r8712_portctrl(struct _adapter *adapter,
 	uint auth_alg;
 	struct recv_frame_hdr *pfhdr;
 	struct sta_info *psta;
-	struct	sta_priv *pstapriv;
+	struct sta_priv *pstapriv;
 	union recv_frame *prtnframe;
 	u16 ether_type;
 
@@ -254,8 +259,9 @@ union recv_frame *r8712_portctrl(struct _adapter *adapter,
 				prtnframe = precv_frame;
 			} else {
 				/*free this frame*/
-				r8712_free_recvframe(precv_frame,
-						     &adapter->recvpriv.free_recv_queue);
+				r8712_free_recvframe(
+					precv_frame,
+					&adapter->recvpriv.free_recv_queue);
 				prtnframe = NULL;
 			}
 		} else {
@@ -281,7 +287,7 @@ static sint recv_decache(union recv_frame *precv_frame, u8 bretry,
 {
 	sint tid = precv_frame->u.hdr.attrib.priority;
 	u16 seq_ctrl = ((precv_frame->u.hdr.attrib.seq_num & 0xffff) << 4) |
-			(precv_frame->u.hdr.attrib.frag_num & 0xf);
+		       (precv_frame->u.hdr.attrib.frag_num & 0xf);
 
 	if (tid > 15)
 		return _FAIL;
@@ -298,9 +304,9 @@ static sint sta2sta_data_frame(struct _adapter *adapter,
 	u8 *ptr = precv_frame->u.hdr.rx_data;
 	sint ret = _SUCCESS;
 	struct rx_pkt_attrib *pattrib = &precv_frame->u.hdr.attrib;
-	struct	sta_priv *pstapriv = &adapter->stapriv;
-	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	u8 *mybssid  = get_bssid(pmlmepriv);
+	struct sta_priv *pstapriv = &adapter->stapriv;
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	u8 *mybssid = get_bssid(pmlmepriv);
 	u8 *myhwaddr = myid(&adapter->eeprompriv);
 	u8 *sta_addr = NULL;
 	bool bmcast = is_multicast_ether_addr(pattrib->dst);
@@ -310,7 +316,7 @@ static sint sta2sta_data_frame(struct _adapter *adapter,
 		/* filter packets that SA is myself or multicast or broadcast */
 		if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN))
 			return _FAIL;
-		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast))
+		if (memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && !bmcast)
 			return _FAIL;
 		if (is_zero_ether_addr(pattrib->bssid) ||
 		    is_zero_ether_addr(mybssid) ||
@@ -347,7 +353,7 @@ static sint sta2sta_data_frame(struct _adapter *adapter,
 		memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
 		sta_addr = mybssid;
 	} else {
-		ret  = _FAIL;
+		ret = _FAIL;
 	}
 	if (bmcast)
 		*psta = r8712_get_bcmc_stainfo(adapter);
@@ -367,22 +373,23 @@ static sint ap2sta_data_frame(struct _adapter *adapter,
 {
 	u8 *ptr = precv_frame->u.hdr.rx_data;
 	struct rx_pkt_attrib *pattrib = &precv_frame->u.hdr.attrib;
-	struct	sta_priv *pstapriv = &adapter->stapriv;
-	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	u8 *mybssid  = get_bssid(pmlmepriv);
+	struct sta_priv *pstapriv = &adapter->stapriv;
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	u8 *mybssid = get_bssid(pmlmepriv);
 	u8 *myhwaddr = myid(&adapter->eeprompriv);
 	bool bmcast = is_multicast_ether_addr(pattrib->dst);
 
 	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) &&
 	    check_fwstate(pmlmepriv, _FW_LINKED)) {
 		/* if NULL-frame, drop packet */
-		if ((GetFrameSubType(ptr)) == (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_NULLFUNC))
+		if ((GetFrameSubType(ptr)) ==
+		    (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_NULLFUNC))
 			return _FAIL;
 		/* drop QoS-SubType Data, including QoS NULL,
 		 * excluding QoS-Data
 		 */
 		if ((GetFrameSubType(ptr) & WIFI_QOS_DATA_TYPE) ==
-		     WIFI_QOS_DATA_TYPE) {
+		    WIFI_QOS_DATA_TYPE) {
 			if (GetFrameSubType(ptr) & (BIT(4) | BIT(5) | BIT(6)))
 				return _FAIL;
 		}
@@ -392,12 +399,12 @@ static sint ap2sta_data_frame(struct _adapter *adapter,
 			return _FAIL;
 
 		/* da should be for me */
-		if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast))
+		if (memcmp(myhwaddr, pattrib->dst, ETH_ALEN) && !bmcast)
 			return _FAIL;
 		/* check BSSID */
 		if (is_zero_ether_addr(pattrib->bssid) ||
 		    is_zero_ether_addr(mybssid) ||
-		     (memcmp(pattrib->bssid, mybssid, ETH_ALEN)))
+		    (memcmp(pattrib->bssid, mybssid, ETH_ALEN)))
 			return _FAIL;
 		if (bmcast)
 			*psta = r8712_get_bcmc_stainfo(adapter);
@@ -412,7 +419,7 @@ static sint ap2sta_data_frame(struct _adapter *adapter,
 		memcpy(pattrib->bssid, GetAddr3Ptr(ptr), ETH_ALEN);
 		memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
 		memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
-		memcpy(pattrib->bssid,  mybssid, ETH_ALEN);
+		memcpy(pattrib->bssid, mybssid, ETH_ALEN);
 		*psta = r8712_get_stainfo(pstapriv, pattrib->bssid);
 		if (!*psta)
 			return _FAIL;
@@ -427,9 +434,9 @@ static sint sta2ap_data_frame(struct _adapter *adapter,
 			      struct sta_info **psta)
 {
 	struct rx_pkt_attrib *pattrib = &precv_frame->u.hdr.attrib;
-	struct	sta_priv *pstapriv = &adapter->stapriv;
-	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
-	unsigned char *mybssid  = get_bssid(pmlmepriv);
+	struct sta_priv *pstapriv = &adapter->stapriv;
+	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
+	unsigned char *mybssid = get_bssid(pmlmepriv);
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		/* For AP mode, if DA is non-MCAST, then it must be BSSID,
@@ -517,10 +524,10 @@ static sint validate_recv_data_frame(struct _adapter *adapter,
 		pattrib->hdrlen = (pattrib->to_fr_ds == 3) ? 30 : 24;
 	}
 
-	if (pattrib->order)/*HT-CTRL 11n*/
+	if (pattrib->order) /*HT-CTRL 11n*/
 		pattrib->hdrlen += 4;
 	precv_frame->u.hdr.preorder_ctrl =
-			 &psta->recvreorder_ctrl[pattrib->priority];
+		&psta->recvreorder_ctrl[pattrib->priority];
 
 	/* decache, drop duplicate recv packets */
 	if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) ==
@@ -551,12 +558,12 @@ sint r8712_validate_recv_frame(struct _adapter *adapter,
 	struct rx_pkt_attrib *pattrib = &precv_frame->u.hdr.attrib;
 
 	u8 *ptr = precv_frame->u.hdr.rx_data;
-	u8  ver = (unsigned char)(*ptr) & 0x3;
+	u8 ver = (unsigned char)(*ptr) & 0x3;
 
 	/*add version chk*/
 	if (ver != 0)
 		return _FAIL;
-	type =  GetFrameType(ptr);
+	type = GetFrameType(ptr);
 	subtype = GetFrameSubType(ptr); /*bit(7)~bit(2)*/
 	pattrib->to_fr_ds = get_tofr_ds(ptr);
 	pattrib->frag_num = GetFragNum(ptr);
@@ -564,7 +571,7 @@ sint r8712_validate_recv_frame(struct _adapter *adapter,
 	pattrib->pw_save = GetPwrMgt(ptr);
 	pattrib->mfrag = GetMFrag(ptr);
 	pattrib->mdata = GetMData(ptr);
-	pattrib->privacy =  GetPrivacy(ptr);
+	pattrib->privacy = GetPrivacy(ptr);
 	pattrib->order = GetOrder(ptr);
 	switch (type) {
 	case IEEE80211_FTYPE_MGMT:
@@ -586,12 +593,12 @@ sint r8712_validate_recv_frame(struct _adapter *adapter,
 int r8712_wlanhdr_to_ethhdr(union recv_frame *precvframe)
 {
 	/*remove the wlanhdr and add the eth_hdr*/
-	sint	rmv_len;
-	u16	len;
-	u8	bsnaphdr;
-	u8	*psnap_type;
+	sint rmv_len;
+	u16 len;
+	u8 bsnaphdr;
+	u8 *psnap_type;
 	struct ieee80211_snap_hdr *psnap;
-	struct _adapter	*adapter = precvframe->u.hdr.adapter;
+	struct _adapter *adapter = precvframe->u.hdr.adapter;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
 
 	u8 *ptr = precvframe->u.hdr.rx_data; /*point to frame_ctrl field*/
@@ -600,13 +607,13 @@ int r8712_wlanhdr_to_ethhdr(union recv_frame *precvframe)
 	if (pattrib->encrypt)
 		recvframe_pull_tail(precvframe, pattrib->icv_len);
 	psnap = (struct ieee80211_snap_hdr *)(ptr + pattrib->hdrlen +
-		 pattrib->iv_len);
+					      pattrib->iv_len);
 	psnap_type = ptr + pattrib->hdrlen + pattrib->iv_len + SNAP_SIZE;
 	/* convert hdr + possible LLC headers into Ethernet header */
 	if ((!memcmp(psnap, (void *)rfc1042_header, SNAP_SIZE) &&
 	     (memcmp(psnap_type, (void *)SNAP_ETH_TYPE_IPX, 2)) &&
-	    (memcmp(psnap_type, (void *)SNAP_ETH_TYPE_APPLETALK_AARP, 2))) ||
-	     !memcmp(psnap, (void *)bridge_tunnel_header, SNAP_SIZE)) {
+	     (memcmp(psnap_type, (void *)SNAP_ETH_TYPE_APPLETALK_AARP, 2))) ||
+	    !memcmp(psnap, (void *)bridge_tunnel_header, SNAP_SIZE)) {
 		/* remove RFC1042 or Bridge-Tunnel encapsulation and
 		 * replace EtherType
 		 */
@@ -615,23 +622,24 @@ int r8712_wlanhdr_to_ethhdr(union recv_frame *precvframe)
 		/* Leave Ethernet header part of hdr and full payload */
 		bsnaphdr = false;
 	}
-	rmv_len = pattrib->hdrlen + pattrib->iv_len +
-		  (bsnaphdr ? SNAP_SIZE : 0);
+	rmv_len =
+		pattrib->hdrlen + pattrib->iv_len + (bsnaphdr ? SNAP_SIZE : 0);
 	len = precvframe->u.hdr.len - rmv_len;
 	if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
 		ptr += rmv_len;
 		*ptr = 0x87;
 		*(ptr + 1) = 0x12;
 		/* append rx status for mp test packets */
-		ptr = recvframe_pull(precvframe, (rmv_len -
-		      sizeof(struct ethhdr) + 2) - 24);
+		ptr = recvframe_pull(
+			precvframe, (rmv_len - sizeof(struct ethhdr) + 2) - 24);
 		if (!ptr)
 			return -ENOMEM;
 		memcpy(ptr, get_rxmem(precvframe), 24);
 		ptr += 24;
 	} else {
-		ptr = recvframe_pull(precvframe, (rmv_len -
-		      sizeof(struct ethhdr) + (bsnaphdr ? 2 : 0)));
+		ptr = recvframe_pull(
+			precvframe,
+			(rmv_len - sizeof(struct ethhdr) + (bsnaphdr ? 2 : 0)));
 		if (!ptr)
 			return -ENOMEM;
 	}
@@ -654,7 +662,7 @@ void r8712_recv_entry(union recv_frame *precvframe)
 	s32 ret = _SUCCESS;
 
 	padapter = precvframe->u.hdr.adapter;
-	precvpriv = &(padapter->recvpriv);
+	precvpriv = &padapter->recvpriv;
 
 	padapter->ledpriv.LedControlHandler(padapter, LED_CTL_RX);
 
@@ -662,8 +670,8 @@ void r8712_recv_entry(union recv_frame *precvframe)
 	if (ret == _FAIL)
 		goto _recv_entry_drop;
 	precvpriv->rx_pkts++;
-	precvpriv->rx_bytes += (uint)(precvframe->u.hdr.rx_tail -
-				precvframe->u.hdr.rx_data);
+	precvpriv->rx_bytes +=
+		(uint)(precvframe->u.hdr.rx_tail - precvframe->u.hdr.rx_data);
 	return;
 _recv_entry_drop:
 	precvpriv->rx_drop++;
diff --git a/drivers/staging/rtl8712/rtl871x_recv.h b/drivers/staging/rtl8712/rtl871x_recv.h
index 0760bccbf389..216d65d250c0 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.h
+++ b/drivers/staging/rtl8712/rtl871x_recv.h
@@ -7,67 +7,67 @@
 
 #define NR_RECVFRAME 256
 
-#define RXFRAME_ALIGN	8
-#define RXFRAME_ALIGN_SZ	(1 << RXFRAME_ALIGN)
+#define RXFRAME_ALIGN 8
+#define RXFRAME_ALIGN_SZ (1 << RXFRAME_ALIGN)
 
-#define MAX_SUBFRAME_COUNT	64
+#define MAX_SUBFRAME_COUNT 64
 
 /* for Rx reordering buffer control */
 struct recv_reorder_ctrl {
-	struct _adapter	*padapter;
+	struct _adapter *padapter;
 	u16 indicate_seq; /* =wstart_b, init_value=0xffff */
 	u16 wend_b;
 	u8 wsize_b;
-	struct  __queue pending_recvframe_queue;
+	struct __queue pending_recvframe_queue;
 	struct timer_list reordering_ctrl_timer;
 };
 
-struct	stainfo_rxcache	{
-	u16	tid_rxseq[16];
+struct stainfo_rxcache {
+	u16 tid_rxseq[16];
 };
 
-#define		PHY_RSSI_SLID_WIN_MAX			100
-#define		PHY_LINKQUALITY_SLID_WIN_MAX		20
+#define PHY_RSSI_SLID_WIN_MAX 100
+#define PHY_LINKQUALITY_SLID_WIN_MAX 20
 
 struct smooth_rssi_data {
-	u32	elements[100];	/* array to store values */
-	u32	index;		/* index to current array to store */
-	u32	total_num;	/* num of valid elements */
-	u32	total_val;	/* sum of valid elements */
+	u32 elements[100]; /* array to store values */
+	u32 index; /* index to current array to store */
+	u32 total_num; /* num of valid elements */
+	u32 total_val; /* sum of valid elements */
 };
 
 struct rx_pkt_attrib {
-	u8	amsdu;
-	u8	order;
-	u8	qos;
-	u8	to_fr_ds;
-	u8	frag_num;
-	u16	seq_num;
-	u8   pw_save;
-	u8    mfrag;
-	u8    mdata;
-	u8	privacy; /* in frame_ctrl field */
-	u8	bdecrypted;
-	int	hdrlen;	 /* the WLAN Header Len */
-	int	encrypt; /* 0 no encrypt. != 0 encrypt algorithm */
-	int	iv_len;
-	int	icv_len;
-	int	priority;
-	int	ack_policy;
-	u8	crc_err;
-	u8	dst[ETH_ALEN];
-	u8	src[ETH_ALEN];
-	u8	ta[ETH_ALEN];
-	u8	ra[ETH_ALEN];
-	u8	bssid[ETH_ALEN];
-	u8	tcpchk_valid; /* 0: invalid, 1: valid */
-	u8	ip_chkrpt; /* 0: incorrect, 1: correct */
-	u8	tcp_chkrpt; /* 0: incorrect, 1: correct */
-	u8	signal_qual;
-	s8	rx_mimo_signal_qual[2];
-	u8	mcs_rate;
-	u8	htc;
-	u8	signal_strength;
+	u8 amsdu;
+	u8 order;
+	u8 qos;
+	u8 to_fr_ds;
+	u8 frag_num;
+	u16 seq_num;
+	u8 pw_save;
+	u8 mfrag;
+	u8 mdata;
+	u8 privacy; /* in frame_ctrl field */
+	u8 bdecrypted;
+	int hdrlen; /* the WLAN Header Len */
+	int encrypt; /* 0 no encrypt. != 0 encrypt algorithm */
+	int iv_len;
+	int icv_len;
+	int priority;
+	int ack_policy;
+	u8 crc_err;
+	u8 dst[ETH_ALEN];
+	u8 src[ETH_ALEN];
+	u8 ta[ETH_ALEN];
+	u8 ra[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+	u8 tcpchk_valid; /* 0: invalid, 1: valid */
+	u8 ip_chkrpt; /* 0: incorrect, 1: correct */
+	u8 tcp_chkrpt; /* 0: incorrect, 1: correct */
+	u8 signal_qual;
+	s8 rx_mimo_signal_qual[2];
+	u8 mcs_rate;
+	u8 htc;
+	u8 signal_strength;
 };
 
 /*
@@ -79,28 +79,28 @@ struct rx_pkt_attrib {
  */
 struct recv_priv {
 	spinlock_t lock;
-	struct  __queue	free_recv_queue;
-	struct  __queue	recv_pending_queue;
+	struct __queue free_recv_queue;
+	struct __queue recv_pending_queue;
 	u8 *pallocated_frame_buf;
 	u8 *precv_frame_buf;
 	uint free_recvframe_cnt;
-	struct _adapter	*adapter;
-	uint	rx_bytes;
-	uint	rx_pkts;
-	uint	rx_drop;
-	uint  rx_icv_err;
-	uint  rx_largepacket_crcerr;
-	uint  rx_smallpacket_crcerr;
-	uint  rx_middlepacket_crcerr;
-	u8  rx_pending_cnt;
-	uint	ff_hwaddr;
+	struct _adapter *adapter;
+	uint rx_bytes;
+	uint rx_pkts;
+	uint rx_drop;
+	uint rx_icv_err;
+	uint rx_largepacket_crcerr;
+	uint rx_smallpacket_crcerr;
+	uint rx_middlepacket_crcerr;
+	u8 rx_pending_cnt;
+	uint ff_hwaddr;
 	struct tasklet_struct recv_tasklet;
 	struct sk_buff_head free_recv_skb_queue;
 	struct sk_buff_head rx_skb_queue;
 	u8 *pallocated_recv_buf;
-	u8 *precv_buf;    /* 4 alignment */
-	struct  __queue	free_recv_buf_queue;
-	u32	free_recv_buf_queue_cnt;
+	u8 *precv_buf; /* 4 alignment */
+	struct __queue free_recv_buf_queue;
+	u32 free_recv_buf_queue_cnt;
 	/* For the phy information */
 	s8 rssi;
 	u8 signal;
@@ -112,22 +112,22 @@ struct recv_priv {
 
 struct sta_recv_priv {
 	spinlock_t lock;
-	sint	option;
-	struct  __queue defrag_q; /* keeping the fragment frame until defrag */
-	struct	stainfo_rxcache rxcache;
-	uint	sta_rx_bytes;
-	uint	sta_rx_pkts;
-	uint	sta_rx_fail;
+	sint option;
+	struct __queue defrag_q; /* keeping the fragment frame until defrag */
+	struct stainfo_rxcache rxcache;
+	uint sta_rx_bytes;
+	uint sta_rx_pkts;
+	uint sta_rx_fail;
 };
 
 #include "rtl8712_recv.h"
 
 /* get a free recv_frame from pfree_recv_queue */
-union recv_frame *r8712_alloc_recvframe(struct  __queue *pfree_recv_queue);
+union recv_frame *r8712_alloc_recvframe(struct __queue *pfree_recv_queue);
 void r8712_free_recvframe(union recv_frame *precvframe,
-			  struct  __queue *pfree_recv_queue);
-void r8712_free_recvframe_queue(struct  __queue *pframequeue,
-				 struct  __queue *pfree_recv_queue);
+			  struct __queue *pfree_recv_queue);
+void r8712_free_recvframe_queue(struct __queue *pframequeue,
+				struct __queue *pfree_recv_queue);
 int r8712_wlanhdr_to_ethhdr(union recv_frame *precvframe);
 int recv_func(struct _adapter *padapter, void *pcontext);
 
@@ -192,7 +192,7 @@ static inline u8 *recvframe_pull_tail(union recv_frame *precvframe, sint sz)
 
 struct sta_info;
 
-void	_r8712_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv);
+void _r8712_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv);
 sint r8712_recvframe_chkmic(struct _adapter *adapter,
 			    union recv_frame *precvframe);
 union recv_frame *r8712_decryptor(struct _adapter *adapter,
@@ -205,4 +205,3 @@ union recv_frame *r8712_portctrl(struct _adapter *adapter,
 				 union recv_frame *precv_frame);
 
 #endif
-
diff --git a/drivers/staging/rtl8712/rtl871x_rf.h b/drivers/staging/rtl8712/rtl871x_rf.h
index 7d98921a48fa..fe0301bc7993 100644
--- a/drivers/staging/rtl8712/rtl871x_rf.h
+++ b/drivers/staging/rtl8712/rtl871x_rf.h
@@ -11,34 +11,34 @@
  * Larry Finger <Larry.Finger@lwfinger.net>
  *
  ******************************************************************************/
-#ifndef	__RTL871X_RF_H_
+#ifndef __RTL871X_RF_H_
 #define __RTL871X_RF_H_
 
 #include "rtl871x_cmd.h"
 #include "rtl871x_mp_phy_regdef.h"
 
-#define OFDM_PHY		1
-#define MIXED_PHY		2
-#define CCK_PHY		3
-#define NumRates	(13)
+#define OFDM_PHY 1
+#define MIXED_PHY 2
+#define CCK_PHY 3
+#define NumRates (13)
 #define RTL8711_RF_MAX_SENS 6
 #define RTL8711_RF_DEF_SENS 4
-#define NUM_CHANNELS	15
+#define NUM_CHANNELS 15
 
-struct	regulatory_class {
-	u32	starting_freq;		/*MHz, */
-	u8	channel_set[NUM_CHANNELS];
-	u8	channel_cck_power[NUM_CHANNELS]; /*dbm*/
-	u8	channel_ofdm_power[NUM_CHANNELS];/*dbm*/
-	u8	txpower_limit;		/*dbm*/
-	u8	channel_spacing;	/*MHz*/
-	u8	modem;
+struct regulatory_class {
+	u32 starting_freq; /*MHz, */
+	u8 channel_set[NUM_CHANNELS];
+	u8 channel_cck_power[NUM_CHANNELS]; /*dbm*/
+	u8 channel_ofdm_power[NUM_CHANNELS]; /*dbm*/
+	u8 txpower_limit; /*dbm*/
+	u8 channel_spacing; /*MHz*/
+	u8 modem;
 };
 
-enum	_REG_PREAMBLE_MODE {
-	PREAMBLE_LONG	= 1,
-	PREAMBLE_AUTO	= 2,
-	PREAMBLE_SHORT	= 3,
+enum _REG_PREAMBLE_MODE {
+	PREAMBLE_LONG = 1,
+	PREAMBLE_AUTO = 2,
+	PREAMBLE_SHORT = 3,
 };
 
 enum {
diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging/rtl8712/rtl871x_security.c
index e46a5dbc7b65..4621f5570622 100644
--- a/drivers/staging/rtl8712/rtl871x_security.c
+++ b/drivers/staging/rtl8712/rtl871x_security.c
@@ -14,7 +14,7 @@
  *
  ******************************************************************************/
 
-#define  _RTL871X_SECURITY_C_
+#define _RTL871X_SECURITY_C_
 
 #include <linux/compiler.h>
 #include <linux/kernel.h>
@@ -46,11 +46,11 @@ struct arc4context {
 
 static void arcfour_init(struct arc4context *parc4ctx, u8 *key, u32 key_len)
 {
-	u32	t, u;
-	u32	keyindex;
-	u32	stateindex;
+	u32 t, u;
+	u32 keyindex;
+	u32 stateindex;
 	u8 *state;
-	u32	counter;
+	u32 counter;
 
 	state = parc4ctx->state;
 	parc4ctx->x = 0;
@@ -89,8 +89,8 @@ static u32 arcfour_byte(struct arc4context *parc4ctx)
 	return state[(sx + sy) & 0xff];
 }
 
-static void arcfour_encrypt(struct arc4context	*parc4ctx,
-		     u8 *dest, u8 *src, u32 len)
+static void arcfour_encrypt(struct arc4context *parc4ctx, u8 *dest, u8 *src,
+			    u32 len)
 {
 	u32 i;
 
@@ -103,10 +103,10 @@ static u32 crc32_table[256];
 
 static u8 crc32_reverseBit(u8 data)
 {
-	return ((u8)(data << 7) & 0x80) | ((data << 5) & 0x40) | ((data << 3)
-		 & 0x20) | ((data << 1) & 0x10) | ((data >> 1) & 0x08) |
-		 ((data >> 3) & 0x04) | ((data >> 5) & 0x02) | ((data >> 7) &
-		 0x01);
+	return ((u8)(data << 7) & 0x80) | ((data << 5) & 0x40) |
+	       ((data << 3) & 0x20) | ((data << 1) & 0x10) |
+	       ((data >> 1) & 0x08) | ((data >> 3) & 0x04) |
+	       ((data >> 5) & 0x02) | ((data >> 7) & 0x01);
 }
 
 static void crc32_init(void)
@@ -122,7 +122,8 @@ static void crc32_init(void)
 	for (i = 0; i < 256; ++i) {
 		k = crc32_reverseBit((u8)i);
 		for (c = ((u32)k) << 24, j = 8; j > 0; --j)
-			c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY_BE : (c << 1);
+			c = c & 0x80000000 ? (c << 1) ^ CRC32_POLY_BE :
+					     (c << 1);
 		p1 = (u8 *)&crc32_table[i];
 		p1[0] = crc32_reverseBit(p[3]);
 		p1[1] = crc32_reverseBit(p[2]);
@@ -135,64 +136,63 @@ static void crc32_init(void)
 static u32 getcrc32(u8 *buf, u32 len)
 {
 	u8 *p;
-	u32  crc;
+	u32 crc;
 
 	if (!bcrc32initialized)
 		crc32_init();
 	crc = 0xffffffff; /* preload shift register, per CRC-32 spec */
 	for (p = buf; len > 0; ++p, --len)
 		crc = crc32_table[(crc ^ *p) & 0xff] ^ (crc >> 8);
-	return ~crc;    /* transmit complement, per CRC-32 spec */
+	return ~crc; /* transmit complement, per CRC-32 spec */
 }
 
 /*
  * Need to consider the fragment situation
  */
 void r8712_wep_encrypt(struct _adapter *padapter, u8 *pxmitframe)
-{	/* exclude ICV */
-	unsigned char	crc[4];
-	struct arc4context  mycontext;
+{ /* exclude ICV */
+	unsigned char crc[4];
+	struct arc4context mycontext;
 	u32 curfragnum, length, keylength, pki;
-	u8 *pframe, *payload, *iv;    /*,*wepkey*/
+	u8 *pframe, *payload, *iv; /*,*wepkey*/
 	u8 wepkey[16];
-	struct	pkt_attrib  *pattrib = &((struct xmit_frame *)
-				       pxmitframe)->attrib;
-	struct	security_priv *psecuritypriv = &padapter->securitypriv;
-	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct pkt_attrib *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
 	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
 		return;
 	pframe = ((struct xmit_frame *)pxmitframe)->buf_addr + TXDESC_OFFSET;
 	/*start to encrypt each fragment*/
-	if ((pattrib->encrypt == _WEP40_) || (pattrib->encrypt == _WEP104_)) {
+	if (pattrib->encrypt == _WEP40_ || pattrib->encrypt == _WEP104_) {
 		pki = psecuritypriv->PrivacyKeyIndex;
 		keylength = psecuritypriv->DefKeylen[pki];
 		for (curfragnum = 0; curfragnum < pattrib->nr_frags;
 		     curfragnum++) {
 			iv = pframe + pattrib->hdrlen;
 			memcpy(&wepkey[0], iv, 3);
-			memcpy(&wepkey[3], &psecuritypriv->DefKey[
-				psecuritypriv->PrivacyKeyIndex].skey[0],
-				keylength);
+			memcpy(&wepkey[3],
+			       &psecuritypriv
+					->DefKey[psecuritypriv->PrivacyKeyIndex]
+					.skey[0],
+			       keylength);
 			payload = pframe + pattrib->iv_len + pattrib->hdrlen;
 			if ((curfragnum + 1) == pattrib->nr_frags) {
 				length = pattrib->last_txcmdsz -
-					pattrib->hdrlen -
-					pattrib->iv_len -
-					pattrib->icv_len;
-				*((__le32 *)crc) = cpu_to_le32(getcrc32(
-						payload, length));
+					 pattrib->hdrlen - pattrib->iv_len -
+					 pattrib->icv_len;
+				*((__le32 *)crc) =
+					cpu_to_le32(getcrc32(payload, length));
 				arcfour_init(&mycontext, wepkey, 3 + keylength);
 				arcfour_encrypt(&mycontext, payload, payload,
 						length);
 				arcfour_encrypt(&mycontext, payload + length,
 						crc, 4);
 			} else {
-				length = pxmitpriv->frag_len -
-					 pattrib->hdrlen - pattrib->iv_len -
-					 pattrib->icv_len;
-				*((__le32 *)crc) = cpu_to_le32(getcrc32(
-						payload, length));
+				length = pxmitpriv->frag_len - pattrib->hdrlen -
+					 pattrib->iv_len - pattrib->icv_len;
+				*((__le32 *)crc) =
+					cpu_to_le32(getcrc32(payload, length));
 				arcfour_init(&mycontext, wepkey, 3 + keylength);
 				arcfour_encrypt(&mycontext, payload, payload,
 						length);
@@ -205,36 +205,36 @@ void r8712_wep_encrypt(struct _adapter *padapter, u8 *pxmitframe)
 	}
 }
 
-void r8712_wep_decrypt(struct _adapter  *padapter, u8 *precvframe)
+void r8712_wep_decrypt(struct _adapter *padapter, u8 *precvframe)
 {
 	/* exclude ICV */
 	u8 crc[4];
-	struct arc4context  mycontext;
+	struct arc4context mycontext;
 	u32 length, keylength;
 	u8 *pframe, *payload, *iv, wepkey[16];
-	u8  keyindex;
-	struct rx_pkt_attrib  *prxattrib = &(((union recv_frame *)
-					  precvframe)->u.hdr.attrib);
+	u8 keyindex;
+	struct rx_pkt_attrib *prxattrib =
+		&(((union recv_frame *)precvframe)->u.hdr.attrib);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
-	pframe = (unsigned char *)((union recv_frame *)precvframe)->
-		  u.hdr.rx_data;
+	pframe =
+		(unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
 	/* start to decrypt recvframe */
-	if ((prxattrib->encrypt == _WEP40_) || (prxattrib->encrypt ==
-	     _WEP104_)) {
+	if (prxattrib->encrypt == _WEP40_ || prxattrib->encrypt == _WEP104_) {
 		iv = pframe + prxattrib->hdrlen;
 		keyindex = (iv[3] & 0x3);
 		keylength = psecuritypriv->DefKeylen[keyindex];
 		memcpy(&wepkey[0], iv, 3);
-		memcpy(&wepkey[3], &psecuritypriv->DefKey[
-			psecuritypriv->PrivacyKeyIndex].skey[0],
-			keylength);
-		length = ((union recv_frame *)precvframe)->
-			   u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len;
+		memcpy(&wepkey[3],
+		       &psecuritypriv->DefKey[psecuritypriv->PrivacyKeyIndex]
+				.skey[0],
+		       keylength);
+		length = ((union recv_frame *)precvframe)->u.hdr.len -
+			 prxattrib->hdrlen - prxattrib->iv_len;
 		payload = pframe + prxattrib->iv_len + prxattrib->hdrlen;
 		/* decrypt payload include icv */
 		arcfour_init(&mycontext, wepkey, 3 + keylength);
-		arcfour_encrypt(&mycontext, payload, payload,  length);
+		arcfour_encrypt(&mycontext, payload, payload, length);
 		/* calculate icv and compare the icv */
 		*((__le32 *)crc) = cpu_to_le32(getcrc32(payload, length - 4));
 	}
@@ -266,7 +266,7 @@ static void secmicputuint32(u8 *p, u32 val)
 
 static void secmicclear(struct mic_data *pmicdata)
 {
-/* Reset the state to the empty message. */
+	/* Reset the state to the empty message. */
 	pmicdata->L = pmicdata->K0;
 	pmicdata->R = pmicdata->K1;
 	pmicdata->nBytesInM = 0;
@@ -335,22 +335,21 @@ void r8712_secgetmic(struct mic_data *pmicdata, u8 *dst)
 void seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_code,
 		    u8 pri)
 {
-
-	struct mic_data	micdata;
-	u8 priority[4] = {0x0, 0x0, 0x0, 0x0};
+	struct mic_data micdata;
+	u8 priority[4] = { 0x0, 0x0, 0x0, 0x0 };
 
 	r8712_secmicsetkey(&micdata, key);
 	priority[0] = pri;
 	/* Michael MIC pseudo header: DA, SA, 3 x 0, Priority */
-	if (header[1] & 1) {   /* ToDS==1 */
-		r8712_secmicappend(&micdata, &header[16], 6);  /* DA */
-		if (header[1] & 2)  /* From Ds==1 */
+	if (header[1] & 1) { /* ToDS==1 */
+		r8712_secmicappend(&micdata, &header[16], 6); /* DA */
+		if (header[1] & 2) /* From Ds==1 */
 			r8712_secmicappend(&micdata, &header[24], 6);
 		else
 			r8712_secmicappend(&micdata, &header[10], 6);
-	} else {	/* ToDS==0 */
-		r8712_secmicappend(&micdata, &header[4], 6);   /* DA */
-		if (header[1] & 2)  /* From Ds==1 */
+	} else { /* ToDS==0 */
+		r8712_secmicappend(&micdata, &header[4], 6); /* DA */
+		if (header[1] & 2) /* From Ds==1 */
 			r8712_secmicappend(&micdata, &header[16], 6);
 		else
 			r8712_secmicappend(&micdata, &header[10], 6);
@@ -361,97 +360,122 @@ void seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_code,
 }
 
 /* macros for extraction/creation of unsigned char/unsigned short values  */
-#define RotR1(v16)   ((((v16) >> 1) & 0x7FFF) ^ (((v16) & 1) << 15))
-#define   Lo8(v16)   ((u8)((v16) & 0x00FF))
-#define   Hi8(v16)   ((u8)(((v16) >> 8) & 0x00FF))
-#define  Lo16(v32)   ((u16)((v32) & 0xFFFF))
-#define  Hi16(v32)   ((u16)(((v32) >> 16) & 0xFFFF))
-#define  Mk16(hi, lo) ((lo) ^ (((u16)(hi)) << 8))
+#define RotR1(v16) ((((v16) >> 1) & 0x7FFF) ^ (((v16) & 1) << 15))
+#define Lo8(v16) ((u8)((v16) & 0x00FF))
+#define Hi8(v16) ((u8)(((v16) >> 8) & 0x00FF))
+#define Lo16(v32) ((u16)((v32) & 0xFFFF))
+#define Hi16(v32) ((u16)(((v32) >> 16) & 0xFFFF))
+#define Mk16(hi, lo) ((lo) ^ (((u16)(hi)) << 8))
 
 /* select the Nth 16-bit word of the temporal key unsigned char array TK[]   */
-#define  TK16(N)  Mk16(tk[2 * (N) + 1], tk[2 * (N)])
+#define TK16(N) Mk16(tk[2 * (N) + 1], tk[2 * (N)])
 
 /* S-box lookup: 16 bits --> 16 bits */
-#define _S_(v16)  (Sbox1[0][Lo8(v16)] ^ Sbox1[1][Hi8(v16)])
+#define _S_(v16) (Sbox1[0][Lo8(v16)] ^ Sbox1[1][Hi8(v16)])
 
 /* fixed algorithm "parameters" */
-#define PHASE1_LOOP_CNT   8    /* this needs to be "big enough"     */
-#define TA_SIZE           6    /*  48-bit transmitter address       */
-#define TK_SIZE          16    /* 128-bit temporal key              */
-#define P1K_SIZE         10    /*  80-bit Phase1 key                */
-#define RC4_KEY_SIZE     16    /* 128-bit RC4KEY (104 bits unknown) */
+#define PHASE1_LOOP_CNT 8 /* this needs to be "big enough"     */
+#define TA_SIZE 6 /*  48-bit transmitter address       */
+#define TK_SIZE 16 /* 128-bit temporal key              */
+#define P1K_SIZE 10 /*  80-bit Phase1 key                */
+#define RC4_KEY_SIZE 16 /* 128-bit RC4KEY (104 bits unknown) */
 
 /* 2-unsigned char by 2-unsigned char subset of the full AES S-box table */
-static const unsigned short Sbox1[2][256] = {/* Sbox for hash (can be in ROM) */
-	{
-	0xC6A5, 0xF884, 0xEE99, 0xF68D, 0xFF0D, 0xD6BD, 0xDEB1, 0x9154,
-	0x6050, 0x0203, 0xCEA9, 0x567D, 0xE719, 0xB562, 0x4DE6, 0xEC9A,
-	0x8F45, 0x1F9D, 0x8940, 0xFA87, 0xEF15, 0xB2EB, 0x8EC9, 0xFB0B,
-	0x41EC, 0xB367, 0x5FFD, 0x45EA, 0x23BF, 0x53F7, 0xE496, 0x9B5B,
-	0x75C2, 0xE11C, 0x3DAE, 0x4C6A, 0x6C5A, 0x7E41, 0xF502, 0x834F,
-	0x685C, 0x51F4, 0xD134, 0xF908, 0xE293, 0xAB73, 0x6253, 0x2A3F,
-	0x080C, 0x9552, 0x4665, 0x9D5E, 0x3028, 0x37A1, 0x0A0F, 0x2FB5,
-	0x0E09, 0x2436, 0x1B9B, 0xDF3D, 0xCD26, 0x4E69, 0x7FCD, 0xEA9F,
-	0x121B, 0x1D9E, 0x5874, 0x342E, 0x362D, 0xDCB2, 0xB4EE, 0x5BFB,
-	0xA4F6, 0x764D, 0xB761, 0x7DCE, 0x527B, 0xDD3E, 0x5E71, 0x1397,
-	0xA6F5, 0xB968, 0x0000, 0xC12C, 0x4060, 0xE31F, 0x79C8, 0xB6ED,
-	0xD4BE, 0x8D46, 0x67D9, 0x724B, 0x94DE, 0x98D4, 0xB0E8, 0x854A,
-	0xBB6B, 0xC52A, 0x4FE5, 0xED16, 0x86C5, 0x9AD7, 0x6655, 0x1194,
-	0x8ACF, 0xE910, 0x0406, 0xFE81, 0xA0F0, 0x7844, 0x25BA, 0x4BE3,
-	0xA2F3, 0x5DFE, 0x80C0, 0x058A, 0x3FAD, 0x21BC, 0x7048, 0xF104,
-	0x63DF, 0x77C1, 0xAF75, 0x4263, 0x2030, 0xE51A, 0xFD0E, 0xBF6D,
-	0x814C, 0x1814, 0x2635, 0xC32F, 0xBEE1, 0x35A2, 0x88CC, 0x2E39,
-	0x9357, 0x55F2, 0xFC82, 0x7A47, 0xC8AC, 0xBAE7, 0x322B, 0xE695,
-	0xC0A0, 0x1998, 0x9ED1, 0xA37F, 0x4466, 0x547E, 0x3BAB, 0x0B83,
-	0x8CCA, 0xC729, 0x6BD3, 0x283C, 0xA779, 0xBCE2, 0x161D, 0xAD76,
-	0xDB3B, 0x6456, 0x744E, 0x141E, 0x92DB, 0x0C0A, 0x486C, 0xB8E4,
-	0x9F5D, 0xBD6E, 0x43EF, 0xC4A6, 0x39A8, 0x31A4, 0xD337, 0xF28B,
-	0xD532, 0x8B43, 0x6E59, 0xDAB7, 0x018C, 0xB164, 0x9CD2, 0x49E0,
-	0xD8B4, 0xACFA, 0xF307, 0xCF25, 0xCAAF, 0xF48E, 0x47E9, 0x1018,
-	0x6FD5, 0xF088, 0x4A6F, 0x5C72, 0x3824, 0x57F1, 0x73C7, 0x9751,
-	0xCB23, 0xA17C, 0xE89C, 0x3E21, 0x96DD, 0x61DC, 0x0D86, 0x0F85,
-	0xE090, 0x7C42, 0x71C4, 0xCCAA, 0x90D8, 0x0605, 0xF701, 0x1C12,
-	0xC2A3, 0x6A5F, 0xAEF9, 0x69D0, 0x1791, 0x9958, 0x3A27, 0x27B9,
-	0xD938, 0xEB13, 0x2BB3, 0x2233, 0xD2BB, 0xA970, 0x0789, 0x33A7,
-	0x2DB6, 0x3C22, 0x1592, 0xC920, 0x8749, 0xAAFF, 0x5078, 0xA57A,
-	0x038F, 0x59F8, 0x0980, 0x1A17, 0x65DA, 0xD731, 0x84C6, 0xD0B8,
-	0x82C3, 0x29B0, 0x5A77, 0x1E11, 0x7BCB, 0xA8FC, 0x6DD6, 0x2C3A,
-	},
-	{  /* second half is unsigned char-reversed version of first! */
-	0xA5C6, 0x84F8, 0x99EE, 0x8DF6, 0x0DFF, 0xBDD6, 0xB1DE, 0x5491,
-	0x5060, 0x0302, 0xA9CE, 0x7D56, 0x19E7, 0x62B5, 0xE64D, 0x9AEC,
-	0x458F, 0x9D1F, 0x4089, 0x87FA, 0x15EF, 0xEBB2, 0xC98E, 0x0BFB,
-	0xEC41, 0x67B3, 0xFD5F, 0xEA45, 0xBF23, 0xF753, 0x96E4, 0x5B9B,
-	0xC275, 0x1CE1, 0xAE3D, 0x6A4C, 0x5A6C, 0x417E, 0x02F5, 0x4F83,
-	0x5C68, 0xF451, 0x34D1, 0x08F9, 0x93E2, 0x73AB, 0x5362, 0x3F2A,
-	0x0C08, 0x5295, 0x6546, 0x5E9D, 0x2830, 0xA137, 0x0F0A, 0xB52F,
-	0x090E, 0x3624, 0x9B1B, 0x3DDF, 0x26CD, 0x694E, 0xCD7F, 0x9FEA,
-	0x1B12, 0x9E1D, 0x7458, 0x2E34, 0x2D36, 0xB2DC, 0xEEB4, 0xFB5B,
-	0xF6A4, 0x4D76, 0x61B7, 0xCE7D, 0x7B52, 0x3EDD, 0x715E, 0x9713,
-	0xF5A6, 0x68B9, 0x0000, 0x2CC1, 0x6040, 0x1FE3, 0xC879, 0xEDB6,
-	0xBED4, 0x468D, 0xD967, 0x4B72, 0xDE94, 0xD498, 0xE8B0, 0x4A85,
-	0x6BBB, 0x2AC5, 0xE54F, 0x16ED, 0xC586, 0xD79A, 0x5566, 0x9411,
-	0xCF8A, 0x10E9, 0x0604, 0x81FE, 0xF0A0, 0x4478, 0xBA25, 0xE34B,
-	0xF3A2, 0xFE5D, 0xC080, 0x8A05, 0xAD3F, 0xBC21, 0x4870, 0x04F1,
-	0xDF63, 0xC177, 0x75AF, 0x6342, 0x3020, 0x1AE5, 0x0EFD, 0x6DBF,
-	0x4C81, 0x1418, 0x3526, 0x2FC3, 0xE1BE, 0xA235, 0xCC88, 0x392E,
-	0x5793, 0xF255, 0x82FC, 0x477A, 0xACC8, 0xE7BA, 0x2B32, 0x95E6,
-	0xA0C0, 0x9819, 0xD19E, 0x7FA3, 0x6644, 0x7E54, 0xAB3B, 0x830B,
-	0xCA8C, 0x29C7, 0xD36B, 0x3C28, 0x79A7, 0xE2BC, 0x1D16, 0x76AD,
-	0x3BDB, 0x5664, 0x4E74, 0x1E14, 0xDB92, 0x0A0C, 0x6C48, 0xE4B8,
-	0x5D9F, 0x6EBD, 0xEF43, 0xA6C4, 0xA839, 0xA431, 0x37D3, 0x8BF2,
-	0x32D5, 0x438B, 0x596E, 0xB7DA, 0x8C01, 0x64B1, 0xD29C, 0xE049,
-	0xB4D8, 0xFAAC, 0x07F3, 0x25CF, 0xAFCA, 0x8EF4, 0xE947, 0x1810,
-	0xD56F, 0x88F0, 0x6F4A, 0x725C, 0x2438, 0xF157, 0xC773, 0x5197,
-	0x23CB, 0x7CA1, 0x9CE8, 0x213E, 0xDD96, 0xDC61, 0x860D, 0x850F,
-	0x90E0, 0x427C, 0xC471, 0xAACC, 0xD890, 0x0506, 0x01F7, 0x121C,
-	0xA3C2, 0x5F6A, 0xF9AE, 0xD069, 0x9117, 0x5899, 0x273A, 0xB927,
-	0x38D9, 0x13EB, 0xB32B, 0x3322, 0xBBD2, 0x70A9, 0x8907, 0xA733,
-	0xB62D, 0x223C, 0x9215, 0x20C9, 0x4987, 0xFFAA, 0x7850, 0x7AA5,
-	0x8F03, 0xF859, 0x8009, 0x171A, 0xDA65, 0x31D7, 0xC684, 0xB8D0,
-	0xC382, 0xB029, 0x775A, 0x111E, 0xCB7B, 0xFCA8, 0xD66D, 0x3A2C,
-	}
-};
+static const unsigned short Sbox1
+	[2]
+	[256] = { /* Sbox for hash (can be in ROM) */
+		  {
+			  0xC6A5, 0xF884, 0xEE99, 0xF68D, 0xFF0D, 0xD6BD,
+			  0xDEB1, 0x9154, 0x6050, 0x0203, 0xCEA9, 0x567D,
+			  0xE719, 0xB562, 0x4DE6, 0xEC9A, 0x8F45, 0x1F9D,
+			  0x8940, 0xFA87, 0xEF15, 0xB2EB, 0x8EC9, 0xFB0B,
+			  0x41EC, 0xB367, 0x5FFD, 0x45EA, 0x23BF, 0x53F7,
+			  0xE496, 0x9B5B, 0x75C2, 0xE11C, 0x3DAE, 0x4C6A,
+			  0x6C5A, 0x7E41, 0xF502, 0x834F, 0x685C, 0x51F4,
+			  0xD134, 0xF908, 0xE293, 0xAB73, 0x6253, 0x2A3F,
+			  0x080C, 0x9552, 0x4665, 0x9D5E, 0x3028, 0x37A1,
+			  0x0A0F, 0x2FB5, 0x0E09, 0x2436, 0x1B9B, 0xDF3D,
+			  0xCD26, 0x4E69, 0x7FCD, 0xEA9F, 0x121B, 0x1D9E,
+			  0x5874, 0x342E, 0x362D, 0xDCB2, 0xB4EE, 0x5BFB,
+			  0xA4F6, 0x764D, 0xB761, 0x7DCE, 0x527B, 0xDD3E,
+			  0x5E71, 0x1397, 0xA6F5, 0xB968, 0x0000, 0xC12C,
+			  0x4060, 0xE31F, 0x79C8, 0xB6ED, 0xD4BE, 0x8D46,
+			  0x67D9, 0x724B, 0x94DE, 0x98D4, 0xB0E8, 0x854A,
+			  0xBB6B, 0xC52A, 0x4FE5, 0xED16, 0x86C5, 0x9AD7,
+			  0x6655, 0x1194, 0x8ACF, 0xE910, 0x0406, 0xFE81,
+			  0xA0F0, 0x7844, 0x25BA, 0x4BE3, 0xA2F3, 0x5DFE,
+			  0x80C0, 0x058A, 0x3FAD, 0x21BC, 0x7048, 0xF104,
+			  0x63DF, 0x77C1, 0xAF75, 0x4263, 0x2030, 0xE51A,
+			  0xFD0E, 0xBF6D, 0x814C, 0x1814, 0x2635, 0xC32F,
+			  0xBEE1, 0x35A2, 0x88CC, 0x2E39, 0x9357, 0x55F2,
+			  0xFC82, 0x7A47, 0xC8AC, 0xBAE7, 0x322B, 0xE695,
+			  0xC0A0, 0x1998, 0x9ED1, 0xA37F, 0x4466, 0x547E,
+			  0x3BAB, 0x0B83, 0x8CCA, 0xC729, 0x6BD3, 0x283C,
+			  0xA779, 0xBCE2, 0x161D, 0xAD76, 0xDB3B, 0x6456,
+			  0x744E, 0x141E, 0x92DB, 0x0C0A, 0x486C, 0xB8E4,
+			  0x9F5D, 0xBD6E, 0x43EF, 0xC4A6, 0x39A8, 0x31A4,
+			  0xD337, 0xF28B, 0xD532, 0x8B43, 0x6E59, 0xDAB7,
+			  0x018C, 0xB164, 0x9CD2, 0x49E0, 0xD8B4, 0xACFA,
+			  0xF307, 0xCF25, 0xCAAF, 0xF48E, 0x47E9, 0x1018,
+			  0x6FD5, 0xF088, 0x4A6F, 0x5C72, 0x3824, 0x57F1,
+			  0x73C7, 0x9751, 0xCB23, 0xA17C, 0xE89C, 0x3E21,
+			  0x96DD, 0x61DC, 0x0D86, 0x0F85, 0xE090, 0x7C42,
+			  0x71C4, 0xCCAA, 0x90D8, 0x0605, 0xF701, 0x1C12,
+			  0xC2A3, 0x6A5F, 0xAEF9, 0x69D0, 0x1791, 0x9958,
+			  0x3A27, 0x27B9, 0xD938, 0xEB13, 0x2BB3, 0x2233,
+			  0xD2BB, 0xA970, 0x0789, 0x33A7, 0x2DB6, 0x3C22,
+			  0x1592, 0xC920, 0x8749, 0xAAFF, 0x5078, 0xA57A,
+			  0x038F, 0x59F8, 0x0980, 0x1A17, 0x65DA, 0xD731,
+			  0x84C6, 0xD0B8, 0x82C3, 0x29B0, 0x5A77, 0x1E11,
+			  0x7BCB, 0xA8FC, 0x6DD6, 0x2C3A,
+		  },
+		  {
+			  /* second half is unsigned char-reversed version of first! */
+			  0xA5C6, 0x84F8, 0x99EE, 0x8DF6, 0x0DFF, 0xBDD6,
+			  0xB1DE, 0x5491, 0x5060, 0x0302, 0xA9CE, 0x7D56,
+			  0x19E7, 0x62B5, 0xE64D, 0x9AEC, 0x458F, 0x9D1F,
+			  0x4089, 0x87FA, 0x15EF, 0xEBB2, 0xC98E, 0x0BFB,
+			  0xEC41, 0x67B3, 0xFD5F, 0xEA45, 0xBF23, 0xF753,
+			  0x96E4, 0x5B9B, 0xC275, 0x1CE1, 0xAE3D, 0x6A4C,
+			  0x5A6C, 0x417E, 0x02F5, 0x4F83, 0x5C68, 0xF451,
+			  0x34D1, 0x08F9, 0x93E2, 0x73AB, 0x5362, 0x3F2A,
+			  0x0C08, 0x5295, 0x6546, 0x5E9D, 0x2830, 0xA137,
+			  0x0F0A, 0xB52F, 0x090E, 0x3624, 0x9B1B, 0x3DDF,
+			  0x26CD, 0x694E, 0xCD7F, 0x9FEA, 0x1B12, 0x9E1D,
+			  0x7458, 0x2E34, 0x2D36, 0xB2DC, 0xEEB4, 0xFB5B,
+			  0xF6A4, 0x4D76, 0x61B7, 0xCE7D, 0x7B52, 0x3EDD,
+			  0x715E, 0x9713, 0xF5A6, 0x68B9, 0x0000, 0x2CC1,
+			  0x6040, 0x1FE3, 0xC879, 0xEDB6, 0xBED4, 0x468D,
+			  0xD967, 0x4B72, 0xDE94, 0xD498, 0xE8B0, 0x4A85,
+			  0x6BBB, 0x2AC5, 0xE54F, 0x16ED, 0xC586, 0xD79A,
+			  0x5566, 0x9411, 0xCF8A, 0x10E9, 0x0604, 0x81FE,
+			  0xF0A0, 0x4478, 0xBA25, 0xE34B, 0xF3A2, 0xFE5D,
+			  0xC080, 0x8A05, 0xAD3F, 0xBC21, 0x4870, 0x04F1,
+			  0xDF63, 0xC177, 0x75AF, 0x6342, 0x3020, 0x1AE5,
+			  0x0EFD, 0x6DBF, 0x4C81, 0x1418, 0x3526, 0x2FC3,
+			  0xE1BE, 0xA235, 0xCC88, 0x392E, 0x5793, 0xF255,
+			  0x82FC, 0x477A, 0xACC8, 0xE7BA, 0x2B32, 0x95E6,
+			  0xA0C0, 0x9819, 0xD19E, 0x7FA3, 0x6644, 0x7E54,
+			  0xAB3B, 0x830B, 0xCA8C, 0x29C7, 0xD36B, 0x3C28,
+			  0x79A7, 0xE2BC, 0x1D16, 0x76AD, 0x3BDB, 0x5664,
+			  0x4E74, 0x1E14, 0xDB92, 0x0A0C, 0x6C48, 0xE4B8,
+			  0x5D9F, 0x6EBD, 0xEF43, 0xA6C4, 0xA839, 0xA431,
+			  0x37D3, 0x8BF2, 0x32D5, 0x438B, 0x596E, 0xB7DA,
+			  0x8C01, 0x64B1, 0xD29C, 0xE049, 0xB4D8, 0xFAAC,
+			  0x07F3, 0x25CF, 0xAFCA, 0x8EF4, 0xE947, 0x1810,
+			  0xD56F, 0x88F0, 0x6F4A, 0x725C, 0x2438, 0xF157,
+			  0xC773, 0x5197, 0x23CB, 0x7CA1, 0x9CE8, 0x213E,
+			  0xDD96, 0xDC61, 0x860D, 0x850F, 0x90E0, 0x427C,
+			  0xC471, 0xAACC, 0xD890, 0x0506, 0x01F7, 0x121C,
+			  0xA3C2, 0x5F6A, 0xF9AE, 0xD069, 0x9117, 0x5899,
+			  0x273A, 0xB927, 0x38D9, 0x13EB, 0xB32B, 0x3322,
+			  0xBBD2, 0x70A9, 0x8907, 0xA733, 0xB62D, 0x223C,
+			  0x9215, 0x20C9, 0x4987, 0xFFAA, 0x7850, 0x7AA5,
+			  0x8F03, 0xF859, 0x8009, 0x171A, 0xDA65, 0x31D7,
+			  0xC684, 0xB8D0, 0xC382, 0xB029, 0x775A, 0x111E,
+			  0xCB7B, 0xFCA8, 0xD66D, 0x3A2C,
+		  }
+	};
 
 /*
  **********************************************************************
@@ -472,7 +496,7 @@ static const unsigned short Sbox1[2][256] = {/* Sbox for hash (can be in ROM) */
  */
 static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 {
-	sint  i;
+	sint i;
 
 	/* Initialize the 80 bits of P1K[] from IV32 and TA[0..5]     */
 	p1k[0] = Lo16(iv32);
@@ -482,13 +506,13 @@ static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
 	p1k[4] = Mk16(ta[5], ta[4]);
 	/* Now compute an unbalanced Feistel cipher with 80-bit block */
 	/* size on the 80-bit block P1K[], using the 128-bit key TK[] */
-	for (i = 0; i < PHASE1_LOOP_CNT; i++) {  /* Each add is mod 2**16 */
+	for (i = 0; i < PHASE1_LOOP_CNT; i++) { /* Each add is mod 2**16 */
 		p1k[0] += _S_(p1k[4] ^ TK16((i & 1) + 0));
 		p1k[1] += _S_(p1k[0] ^ TK16((i & 1) + 2));
 		p1k[2] += _S_(p1k[1] ^ TK16((i & 1) + 4));
 		p1k[3] += _S_(p1k[2] ^ TK16((i & 1) + 6));
 		p1k[4] += _S_(p1k[3] ^ TK16((i & 1) + 0));
-		p1k[4] +=  (unsigned short)i;	/* avoid "slide attacks" */
+		p1k[4] += (unsigned short)i; /* avoid "slide attacks" */
 	}
 }
 
@@ -517,27 +541,27 @@ static void phase1(u16 *p1k, const u8 *tk, const u8 *ta, u32 iv32)
  */
 static void phase2(u8 *rc4key, const u8 *tk, const u16 *p1k, u16 iv16)
 {
-	sint  i;
-	u16 PPK[6];			/* temporary key for mixing    */
+	sint i;
+	u16 PPK[6]; /* temporary key for mixing    */
 
 	/* Note: all adds in the PPK[] equations below are mod 2**16 */
 	for (i = 0; i < 5; i++)
 		PPK[i] = p1k[i]; /* first, copy P1K to PPK */
-	PPK[5]  =  p1k[4] + iv16; /* next,  add in IV16 */
+	PPK[5] = p1k[4] + iv16; /* next,  add in IV16 */
 	/* Bijective non-linear mixing of the 96 bits of PPK[0..5] */
-	PPK[0] += _S_(PPK[5] ^ TK16(0));   /* Mix key in each "round" */
+	PPK[0] += _S_(PPK[5] ^ TK16(0)); /* Mix key in each "round" */
 	PPK[1] += _S_(PPK[0] ^ TK16(1));
 	PPK[2] += _S_(PPK[1] ^ TK16(2));
 	PPK[3] += _S_(PPK[2] ^ TK16(3));
 	PPK[4] += _S_(PPK[3] ^ TK16(4));
-	PPK[5] += _S_(PPK[4] ^ TK16(5));   /* Total # S-box lookups == 6  */
+	PPK[5] += _S_(PPK[4] ^ TK16(5)); /* Total # S-box lookups == 6  */
 	/* Final sweep: bijective, "linear". Rotates kill LSB correlations   */
-	PPK[0] +=  RotR1(PPK[5] ^ TK16(6));
-	PPK[1] +=  RotR1(PPK[0] ^ TK16(7));   /* Use all of TK[] in Phase2   */
-	PPK[2] +=  RotR1(PPK[1]);
-	PPK[3] +=  RotR1(PPK[2]);
-	PPK[4] +=  RotR1(PPK[3]);
-	PPK[5] +=  RotR1(PPK[4]);
+	PPK[0] += RotR1(PPK[5] ^ TK16(6));
+	PPK[1] += RotR1(PPK[0] ^ TK16(7)); /* Use all of TK[] in Phase2   */
+	PPK[2] += RotR1(PPK[1]);
+	PPK[3] += RotR1(PPK[2]);
+	PPK[4] += RotR1(PPK[3]);
+	PPK[5] += RotR1(PPK[4]);
 	/* Note: At this point, for a given key TK[0..15], the 96-bit output */
 	/* value PPK[0..5] is guaranteed to be unique, as a function   */
 	/* of the 96-bit "input" value   {TA,IV32,IV16}. That is, P1K  */
@@ -556,7 +580,7 @@ static void phase2(u8 *rc4key, const u8 *tk, const u16 *p1k, u16 iv16)
 
 /*The hlen isn't include the IV*/
 u32 r8712_tkip_encrypt(struct _adapter *padapter, u8 *pxmitframe)
-{	/*  exclude ICV */
+{ /*  exclude ICV */
 	u16 pnl;
 	u32 pnh;
 	u8 rc4key[16];
@@ -582,7 +606,7 @@ u32 r8712_tkip_encrypt(struct _adapter *padapter, u8 *pxmitframe)
 			stainfo = pattrib->psta;
 		else
 			stainfo = r8712_get_stainfo(&padapter->stapriv,
-				  &pattrib->ra[0]);
+						    &pattrib->ra[0]);
 		if (stainfo) {
 			prwskey = &stainfo->x_UncstKey.skey[0];
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags;
@@ -600,26 +624,27 @@ u32 r8712_tkip_encrypt(struct _adapter *padapter, u8 *pxmitframe)
 				if ((curfragnum + 1) == pattrib->nr_frags) {
 					/* 4 the last fragment */
 					length = pattrib->last_txcmdsz -
-					     pattrib->hdrlen -
-					     pattrib->iv_len -
-					     pattrib->icv_len;
+						 pattrib->hdrlen -
+						 pattrib->iv_len -
+						 pattrib->icv_len;
 					*((__le32 *)crc) = cpu_to_le32(
 						getcrc32(payload, length));
 					arcfour_init(&mycontext, rc4key, 16);
 					arcfour_encrypt(&mycontext, payload,
 							payload, length);
-					arcfour_encrypt(&mycontext, payload +
-							length, crc, 4);
+					arcfour_encrypt(&mycontext,
+							payload + length, crc,
+							4);
 				} else {
 					length = pxmitpriv->frag_len -
 						 pattrib->hdrlen -
 						 pattrib->iv_len -
 						 pattrib->icv_len;
-					*((__le32 *)crc) = cpu_to_le32(getcrc32(
-							payload, length));
+					*((__le32 *)crc) = cpu_to_le32(
+						getcrc32(payload, length));
 					arcfour_init(&mycontext, rc4key, 16);
 					arcfour_encrypt(&mycontext, payload,
-							 payload, length);
+							payload, length);
 					arcfour_encrypt(&mycontext,
 							payload + length, crc,
 							4);
@@ -636,7 +661,7 @@ u32 r8712_tkip_encrypt(struct _adapter *padapter, u8 *pxmitframe)
 
 /* The hlen doesn't include the IV */
 void r8712_tkip_decrypt(struct _adapter *padapter, u8 *precvframe)
-{	/* exclude ICV */
+{ /* exclude ICV */
 	u16 pnl;
 	u32 pnh;
 	u8 rc4key[16];
@@ -646,28 +671,30 @@ void r8712_tkip_decrypt(struct _adapter *padapter, u8 *precvframe)
 	u32 length;
 	u8 *pframe, *payload, *iv, *prwskey, idx = 0;
 	union pn48 txpn;
-	struct	sta_info *stainfo;
-	struct	rx_pkt_attrib *prxattrib = &((union recv_frame *)
-					   precvframe)->u.hdr.attrib;
-	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
+	struct sta_info *stainfo;
+	struct rx_pkt_attrib *prxattrib =
+		&((union recv_frame *)precvframe)->u.hdr.attrib;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
-	pframe = (unsigned char *)((union recv_frame *)
-				   precvframe)->u.hdr.rx_data;
+	pframe =
+		(unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
 	/* 4 start to decrypt recvframe */
 	if (prxattrib->encrypt == _TKIP_) {
 		stainfo = r8712_get_stainfo(&padapter->stapriv,
 					    &prxattrib->ta[0]);
 		if (stainfo) {
 			iv = pframe + prxattrib->hdrlen;
-			payload = pframe + prxattrib->iv_len +
-				  prxattrib->hdrlen;
-			length = ((union recv_frame *)precvframe)->
-				 u.hdr.len - prxattrib->hdrlen -
-				 prxattrib->iv_len;
+			payload =
+				pframe + prxattrib->iv_len + prxattrib->hdrlen;
+			length = ((union recv_frame *)precvframe)->u.hdr.len -
+				 prxattrib->hdrlen - prxattrib->iv_len;
 			if (is_multicast_ether_addr(prxattrib->ra)) {
 				idx = iv[3];
-				prwskey = &psecuritypriv->XGrpKey[
-					 ((idx >> 6) & 0x3) - 1].skey[0];
+				prwskey =
+					&psecuritypriv
+						 ->XGrpKey[((idx >> 6) & 0x3) -
+							   1]
+						 .skey[0];
 				if (!psecuritypriv->binstallGrpkey)
 					return;
 			} else {
@@ -677,58 +704,48 @@ void r8712_tkip_decrypt(struct _adapter *padapter, u8 *precvframe)
 			pnl = (u16)(txpn.val);
 			pnh = (u32)(txpn.val >> 16);
 			phase1((u16 *)&ttkey[0], prwskey, &prxattrib->ta[0],
-				pnh);
-			phase2(&rc4key[0], prwskey, (unsigned short *)
-			       &ttkey[0], pnl);
+			       pnh);
+			phase2(&rc4key[0], prwskey, (unsigned short *)&ttkey[0],
+			       pnl);
 			/* 4 decrypt payload include icv */
 			arcfour_init(&mycontext, rc4key, 16);
 			arcfour_encrypt(&mycontext, payload, payload, length);
-			*((__le32 *)crc) = cpu_to_le32(getcrc32(payload,
-					length - 4));
+			*((__le32 *)crc) =
+				cpu_to_le32(getcrc32(payload, length - 4));
 		}
 	}
 }
 
 /* 3 =====AES related===== */
 
-#define MAX_MSG_SIZE	2048
+#define MAX_MSG_SIZE 2048
 /*****************************/
 /******** SBOX Table *********/
 /*****************************/
 
 static const u8 sbox_table[256] = {
-	0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
-	0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
-	0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,
-	0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
-	0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc,
-	0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
-	0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a,
-	0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
-	0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0,
-	0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
-	0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b,
-	0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
-	0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85,
-	0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
-	0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5,
-	0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
-	0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17,
-	0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
-	0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88,
-	0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
-	0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c,
-	0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
-	0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9,
-	0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
-	0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6,
-	0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
-	0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e,
-	0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
-	0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94,
-	0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
-	0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68,
-	0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16
+	0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b,
+	0xfe, 0xd7, 0xab, 0x76, 0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,
+	0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0, 0xb7, 0xfd, 0x93, 0x26,
+	0x36, 0x3f, 0xf7, 0xcc, 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
+	0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a, 0x07, 0x12, 0x80, 0xe2,
+	0xeb, 0x27, 0xb2, 0x75, 0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0,
+	0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84, 0x53, 0xd1, 0x00, 0xed,
+	0x20, 0xfc, 0xb1, 0x5b, 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
+	0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85, 0x45, 0xf9, 0x02, 0x7f,
+	0x50, 0x3c, 0x9f, 0xa8, 0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5,
+	0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2, 0xcd, 0x0c, 0x13, 0xec,
+	0x5f, 0x97, 0x44, 0x17, 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
+	0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88, 0x46, 0xee, 0xb8, 0x14,
+	0xde, 0x5e, 0x0b, 0xdb, 0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c,
+	0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79, 0xe7, 0xc8, 0x37, 0x6d,
+	0x8d, 0xd5, 0x4e, 0xa9, 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
+	0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6, 0xe8, 0xdd, 0x74, 0x1f,
+	0x4b, 0xbd, 0x8b, 0x8a, 0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e,
+	0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e, 0xe1, 0xf8, 0x98, 0x11,
+	0x69, 0xd9, 0x8e, 0x94, 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
+	0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68, 0x41, 0x99, 0x2d, 0x0f,
+	0xb0, 0x54, 0xbb, 0x16
 };
 
 /****************************************/
@@ -761,10 +778,8 @@ static void next_key(u8 *key, sint round)
 {
 	u8 rcon;
 	u8 sbox_key[4];
-	static const u8 rcon_table[12] = {
-		0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80,
-		0x1b, 0x36, 0x36, 0x36
-	};
+	static const u8 rcon_table[12] = { 0x01, 0x02, 0x04, 0x08, 0x10, 0x20,
+					   0x40, 0x80, 0x1b, 0x36, 0x36, 0x36 };
 
 	sbox_key[0] = sbox(key[13]);
 	sbox_key[1] = sbox(key[14]);
@@ -788,16 +803,16 @@ static void byte_sub(u8 *in, u8 *out)
 
 static void shift_row(u8 *in, u8 *out)
 {
-	out[0] =  in[0];
-	out[1] =  in[5];
-	out[2] =  in[10];
-	out[3] =  in[15];
-	out[4] =  in[4];
-	out[5] =  in[9];
-	out[6] =  in[14];
-	out[7] =  in[3];
-	out[8] =  in[8];
-	out[9] =  in[13];
+	out[0] = in[0];
+	out[1] = in[5];
+	out[2] = in[10];
+	out[3] = in[15];
+	out[4] = in[4];
+	out[5] = in[9];
+	out[6] = in[14];
+	out[7] = in[3];
+	out[8] = in[8];
+	out[9] = in[13];
 	out[10] = in[2];
 	out[11] = in[7];
 	out[12] = in[12];
@@ -824,11 +839,11 @@ static void mix_column(u8 *in, u8 *out)
 		else
 			add1b[i] = 0x00;
 	}
-	swap_halves[0] = in[2];    /* Swap halves */
+	swap_halves[0] = in[2]; /* Swap halves */
 	swap_halves[1] = in[3];
 	swap_halves[2] = in[0];
 	swap_halves[3] = in[1];
-	rotl[0] = in[3];        /* Rotate left 8 bits */
+	rotl[0] = in[3]; /* Rotate left 8 bits */
 	rotl[1] = in[0];
 	rotl[2] = in[1];
 	rotl[3] = in[2];
@@ -836,7 +851,7 @@ static void mix_column(u8 *in, u8 *out)
 	andf7[1] = in[1] & 0x7f;
 	andf7[2] = in[2] & 0x7f;
 	andf7[3] = in[3] & 0x7f;
-	for (i = 3; i > 0; i--) {   /* logical shift left 1 bit */
+	for (i = 3; i > 0; i--) { /* logical shift left 1 bit */
 		andf7[i] = andf7[i] << 1;
 		if ((andf7[i - 1] & 0x80) == 0x80)
 			andf7[i] = (andf7[i] | 0x01);
@@ -845,7 +860,7 @@ static void mix_column(u8 *in, u8 *out)
 	andf7[0] = andf7[0] & 0xfe;
 	xor_32(add1b, andf7, add1bf7);
 	xor_32(in, add1bf7, rotr);
-	temp[0] = rotr[0];         /* Rotate right 8 bits */
+	temp[0] = rotr[0]; /* Rotate right 8 bits */
 	rotr[0] = rotr[1];
 	rotr[1] = rotr[2];
 	rotr[2] = rotr[3];
@@ -873,7 +888,7 @@ static void aes128k128d(u8 *key, u8 *data, u8 *ciphertext)
 			byte_sub(ciphertext, intermediatea);
 			shift_row(intermediatea, intermediateb);
 			xor_128(intermediateb, round_key, ciphertext);
-		} else {   /* 1 - 9 */
+		} else { /* 1 - 9 */
 			byte_sub(ciphertext, intermediatea);
 			shift_row(intermediatea, intermediateb);
 			mix_column(&intermediateb[0], &intermediatea[0]);
@@ -897,9 +912,9 @@ static void construct_mic_iv(u8 *mic_iv, sint qc_exists, sint a4_exists,
 
 	mic_iv[0] = 0x59;
 	if (qc_exists && a4_exists)
-		mic_iv[1] = mpdu[30] & 0x0f;    /* QoS_TC           */
+		mic_iv[1] = mpdu[30] & 0x0f; /* QoS_TC           */
 	if (qc_exists && !a4_exists)
-		mic_iv[1] = mpdu[24] & 0x0f;   /* mute bits 7-4    */
+		mic_iv[1] = mpdu[24] & 0x0f; /* mute bits 7-4    */
 	if (!qc_exists)
 		mic_iv[1] = 0x00;
 	for (i = 2; i < 8; i++)
@@ -919,16 +934,16 @@ static void construct_mic_header1(u8 *mic_header1, sint header_length, u8 *mpdu)
 {
 	mic_header1[0] = (u8)((header_length - 2) / 256);
 	mic_header1[1] = (u8)((header_length - 2) % 256);
-	mic_header1[2] = mpdu[0] & 0xcf;    /* Mute CF poll & CF ack bits */
+	mic_header1[2] = mpdu[0] & 0xcf; /* Mute CF poll & CF ack bits */
 	/* Mute retry, more data and pwr mgt bits */
 	mic_header1[3] = mpdu[1] & 0xc7;
-	mic_header1[4] = mpdu[4];       /* A1 */
+	mic_header1[4] = mpdu[4]; /* A1 */
 	mic_header1[5] = mpdu[5];
 	mic_header1[6] = mpdu[6];
 	mic_header1[7] = mpdu[7];
 	mic_header1[8] = mpdu[8];
 	mic_header1[9] = mpdu[9];
-	mic_header1[10] = mpdu[10];     /* A2 */
+	mic_header1[10] = mpdu[10]; /* A2 */
 	mic_header1[11] = mpdu[11];
 	mic_header1[12] = mpdu[12];
 	mic_header1[13] = mpdu[13];
@@ -942,13 +957,13 @@ static void construct_mic_header1(u8 *mic_header1, sint header_length, u8 *mpdu)
 /* header fields.                               */
 /************************************************/
 static void construct_mic_header2(u8 *mic_header2, u8 *mpdu, sint a4_exists,
-			   sint qc_exists)
+				  sint qc_exists)
 {
 	sint i;
 
 	for (i = 0; i < 16; i++)
 		mic_header2[i] = 0x00;
-	mic_header2[0] = mpdu[16];    /* A3 */
+	mic_header2[0] = mpdu[16]; /* A3 */
 	mic_header2[1] = mpdu[17];
 	mic_header2[2] = mpdu[18];
 	mic_header2[3] = mpdu[19];
@@ -958,14 +973,14 @@ static void construct_mic_header2(u8 *mic_header2, u8 *mpdu, sint a4_exists,
 	mic_header2[7] = 0x00; /* mpdu[23]; */
 	if (!qc_exists && a4_exists)
 		for (i = 0; i < 6; i++)
-			mic_header2[8 + i] = mpdu[24 + i];   /* A4 */
+			mic_header2[8 + i] = mpdu[24 + i]; /* A4 */
 	if (qc_exists && !a4_exists) {
 		mic_header2[8] = mpdu[24] & 0x0f; /* mute bits 15 - 4 */
 		mic_header2[9] = mpdu[25] & 0x00;
 	}
 	if (qc_exists && a4_exists) {
 		for (i = 0; i < 6; i++)
-			mic_header2[8 + i] = mpdu[24 + i];   /* A4 */
+			mic_header2[8 + i] = mpdu[24 + i]; /* A4 */
 		mic_header2[14] = mpdu[30] & 0x0f;
 		mic_header2[15] = mpdu[31] & 0x00;
 	}
@@ -976,16 +991,16 @@ static void construct_mic_header2(u8 *mic_header2, u8 *mpdu, sint a4_exists,
 /* Builds the last MIC header block from        */
 /* header fields.                               */
 /************************************************/
-static void construct_ctr_preload(u8 *ctr_preload,
-				  sint a4_exists, sint qc_exists,
-				  u8 *mpdu, u8 *pn_vector, sint c)
+static void construct_ctr_preload(u8 *ctr_preload, sint a4_exists,
+				  sint qc_exists, u8 *mpdu, u8 *pn_vector,
+				  sint c)
 {
 	sint i;
 
 	for (i = 0; i < 16; i++)
 		ctr_preload[i] = 0x00;
 	i = 0;
-	ctr_preload[0] = 0x01;    /* flag */
+	ctr_preload[0] = 0x01; /* flag */
 	if (qc_exists && a4_exists)
 		ctr_preload[1] = mpdu[30] & 0x0f;
 	if (qc_exists && !a4_exists)
@@ -1010,8 +1025,7 @@ static void bitwise_xor(u8 *ina, u8 *inb, u8 *out)
 		out[i] = ina[i] ^ inb[i];
 }
 
-static void aes_cipher(u8 *key, uint hdrlen,
-		       u8 *pframe, uint plen)
+static void aes_cipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
 {
 	uint qc_exists, a4_exists, i, j, payload_remainder;
 	uint num_blocks, payload_index;
@@ -1027,8 +1041,8 @@ static void aes_cipher(u8 *key, uint hdrlen,
 	u8 aes_out[16];
 	u8 padded_buffer[16];
 	u8 mic[8];
-	u16 frtype  = GetFrameType(pframe);
-	u16 frsubtype  = GetFrameSubType(pframe);
+	u16 frtype = GetFrameType(pframe);
+	u16 frsubtype = GetFrameSubType(pframe);
 
 	frsubtype >>= 4;
 	memset((void *)mic_iv, 0, 16);
@@ -1039,22 +1053,21 @@ static void aes_cipher(u8 *key, uint hdrlen,
 	memset((void *)aes_out, 0, 16);
 	memset((void *)padded_buffer, 0, 16);
 
-	if ((hdrlen == WLAN_HDR_A3_LEN) || (hdrlen ==  WLAN_HDR_A3_QOS_LEN))
+	if (hdrlen == WLAN_HDR_A3_LEN || hdrlen == WLAN_HDR_A3_QOS_LEN)
 		a4_exists = 0;
 	else
 		a4_exists = 1;
 
 	if ((frtype == (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFACK)) ||
 	    (frtype == (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFPOLL)) ||
-	    (frtype == (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFACKPOLL))) {
+	    (frtype ==
+	     (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFACKPOLL))) {
 		qc_exists = 1;
-		if (hdrlen !=  WLAN_HDR_A3_QOS_LEN)
+		if (hdrlen != WLAN_HDR_A3_QOS_LEN)
 			hdrlen += 2;
-	} else if ((frsubtype == 0x08) ||
-		   (frsubtype == 0x09) ||
-		   (frsubtype == 0x0a) ||
-		   (frsubtype == 0x0b)) {
-		if (hdrlen !=  WLAN_HDR_A3_QOS_LEN)
+	} else if ((frsubtype == 0x08) || (frsubtype == 0x09) ||
+		   (frsubtype == 0x0a) || (frsubtype == 0x0b)) {
+		if (hdrlen != WLAN_HDR_A3_QOS_LEN)
 			hdrlen += 2;
 		qc_exists = 1;
 	} else {
@@ -1100,17 +1113,17 @@ static void aes_cipher(u8 *key, uint hdrlen,
 		pframe[payload_index + j] = mic[j];
 	payload_index = hdrlen + 8;
 	for (i = 0; i < num_blocks; i++) {
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
-				      pframe, pn_vector, i + 1);
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe,
+				      pn_vector, i + 1);
 		aes128k128d(key, ctr_preload, aes_out);
 		bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
 		for (j = 0; j < 16; j++)
 			pframe[payload_index++] = chain_buffer[j];
 	}
-	if (payload_remainder > 0) {  /* If short final block, then pad it,*/
-				      /* encrypt and copy unpadded part back */
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
-				      pframe, pn_vector, num_blocks + 1);
+	if (payload_remainder > 0) { /* If short final block, then pad it,*/
+		/* encrypt and copy unpadded part back */
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe,
+				      pn_vector, num_blocks + 1);
 		for (j = 0; j < 16; j++)
 			padded_buffer[j] = 0x00;
 		for (j = 0; j < payload_remainder; j++)
@@ -1121,8 +1134,8 @@ static void aes_cipher(u8 *key, uint hdrlen,
 			pframe[payload_index++] = chain_buffer[j];
 	}
 	/* Encrypt the MIC */
-	construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
-			      pframe, pn_vector, 0);
+	construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe,
+			      pn_vector, 0);
 	for (j = 0; j < 16; j++)
 		padded_buffer[j] = 0x00;
 	for (j = 0; j < 8; j++)
@@ -1134,14 +1147,13 @@ static void aes_cipher(u8 *key, uint hdrlen,
 }
 
 u32 r8712_aes_encrypt(struct _adapter *padapter, u8 *pxmitframe)
-{	/* exclude ICV */
+{ /* exclude ICV */
 	/* Intermediate Buffers */
-	sint	curfragnum, length;
-	u8	*pframe, *prwskey;
-	struct	sta_info *stainfo;
-	struct	pkt_attrib  *pattrib = &((struct xmit_frame *)
-				       pxmitframe)->attrib;
-	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	sint curfragnum, length;
+	u8 *pframe, *prwskey;
+	struct sta_info *stainfo;
+	struct pkt_attrib *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	u32 res = _SUCCESS;
 
 	if (((struct xmit_frame *)pxmitframe)->buf_addr == NULL)
@@ -1153,7 +1165,7 @@ u32 r8712_aes_encrypt(struct _adapter *padapter, u8 *pxmitframe)
 			stainfo = pattrib->psta;
 		else
 			stainfo = r8712_get_stainfo(&padapter->stapriv,
-				  &pattrib->ra[0]);
+						    &pattrib->ra[0]);
 		if (stainfo) {
 			prwskey = &stainfo->x_UncstKey.skey[0];
 			for (curfragnum = 0; curfragnum < pattrib->nr_frags;
@@ -1183,8 +1195,7 @@ u32 r8712_aes_encrypt(struct _adapter *padapter, u8 *pxmitframe)
 	return res;
 }
 
-static void aes_decipher(u8 *key, uint hdrlen,
-			 u8 *pframe, uint plen)
+static void aes_decipher(u8 *key, uint hdrlen, u8 *pframe, uint plen)
 {
 	static u8 message[MAX_MSG_SIZE];
 	uint qc_exists, a4_exists, i, j, payload_remainder;
@@ -1199,8 +1210,8 @@ static void aes_decipher(u8 *key, uint hdrlen,
 	u8 aes_out[16];
 	u8 padded_buffer[16];
 	u8 mic[8];
-	uint frtype  = GetFrameType(pframe);
-	uint frsubtype  = GetFrameSubType(pframe);
+	uint frtype = GetFrameType(pframe);
+	uint frsubtype = GetFrameSubType(pframe);
 
 	frsubtype >>= 4;
 	memset((void *)mic_iv, 0, 16);
@@ -1220,20 +1231,19 @@ static void aes_decipher(u8 *key, uint hdrlen,
 	pn_vector[3] = pframe[hdrlen + 5];
 	pn_vector[4] = pframe[hdrlen + 6];
 	pn_vector[5] = pframe[hdrlen + 7];
-	if ((hdrlen == WLAN_HDR_A3_LEN) || (hdrlen ==  WLAN_HDR_A3_QOS_LEN))
+	if (hdrlen == WLAN_HDR_A3_LEN || hdrlen == WLAN_HDR_A3_QOS_LEN)
 		a4_exists = 0;
 	else
 		a4_exists = 1;
 	if ((frtype == (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFACK)) ||
 	    (frtype == (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFPOLL)) ||
-	    (frtype == (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFACKPOLL))) {
+	    (frtype ==
+	     (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFACKPOLL))) {
 		qc_exists = 1;
 		if (hdrlen != WLAN_HDR_A3_QOS_LEN)
 			hdrlen += 2;
-	} else if ((frsubtype == 0x08) ||
-		   (frsubtype == 0x09) ||
-		   (frsubtype == 0x0a) ||
-		   (frsubtype == 0x0b)) {
+	} else if ((frsubtype == 0x08) || (frsubtype == 0x09) ||
+		   (frsubtype == 0x0a) || (frsubtype == 0x0b)) {
 		if (hdrlen != WLAN_HDR_A3_QOS_LEN)
 			hdrlen += 2;
 		qc_exists = 1;
@@ -1243,17 +1253,17 @@ static void aes_decipher(u8 *key, uint hdrlen,
 	/* now, decrypt pframe with hdrlen offset and plen long */
 	payload_index = hdrlen + 8; /* 8 is for extiv */
 	for (i = 0; i < num_blocks; i++) {
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
-				      pframe, pn_vector, i + 1);
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe,
+				      pn_vector, i + 1);
 		aes128k128d(key, ctr_preload, aes_out);
 		bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
 		for (j = 0; j < 16; j++)
 			pframe[payload_index++] = chain_buffer[j];
 	}
-	if (payload_remainder > 0) {  /* If short final block, pad it,*/
+	if (payload_remainder > 0) { /* If short final block, pad it,*/
 		/* encrypt it and copy the unpadded part back   */
-		construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
-				      pframe, pn_vector, num_blocks + 1);
+		construct_ctr_preload(ctr_preload, a4_exists, qc_exists, pframe,
+				      pn_vector, num_blocks + 1);
 		for (j = 0; j < 16; j++)
 			padded_buffer[j] = 0x00;
 		for (j = 0; j < payload_remainder; j++)
@@ -1314,7 +1324,7 @@ static void aes_decipher(u8 *key, uint hdrlen,
 			message[payload_index++] = chain_buffer[j];
 	}
 	if (payload_remainder > 0) { /* If short final block, pad it,*/
-				     /* encrypt and copy unpadded part back */
+		/* encrypt and copy unpadded part back */
 		construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
 				      message, pn_vector, num_blocks + 1);
 		for (j = 0; j < 16; j++)
@@ -1341,17 +1351,17 @@ static void aes_decipher(u8 *key, uint hdrlen,
 }
 
 void r8712_aes_decrypt(struct _adapter *padapter, u8 *precvframe)
-{	/* exclude ICV */
+{ /* exclude ICV */
 	/* Intermediate Buffers */
-	sint		length;
-	u8	*pframe, *prwskey, *iv, idx;
-	struct	sta_info *stainfo;
-	struct	rx_pkt_attrib *prxattrib = &((union recv_frame *)
-					   precvframe)->u.hdr.attrib;
-	struct	security_priv *psecuritypriv = &padapter->securitypriv;
-
-	pframe = (unsigned char *)((union recv_frame *)precvframe)->
-		 u.hdr.rx_data;
+	sint length;
+	u8 *pframe, *prwskey, *iv, idx;
+	struct sta_info *stainfo;
+	struct rx_pkt_attrib *prxattrib =
+		&((union recv_frame *)precvframe)->u.hdr.attrib;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+
+	pframe =
+		(unsigned char *)((union recv_frame *)precvframe)->u.hdr.rx_data;
 	/* 4 start to encrypt each fragment */
 	if (prxattrib->encrypt == _AES_) {
 		stainfo = r8712_get_stainfo(&padapter->stapriv,
@@ -1360,17 +1370,19 @@ void r8712_aes_decrypt(struct _adapter *padapter, u8 *precvframe)
 			if (is_multicast_ether_addr(prxattrib->ra)) {
 				iv = pframe + prxattrib->hdrlen;
 				idx = iv[3];
-				prwskey = &psecuritypriv->XGrpKey[
-					  ((idx >> 6) & 0x3) - 1].skey[0];
+				prwskey =
+					&psecuritypriv
+						 ->XGrpKey[((idx >> 6) & 0x3) -
+							   1]
+						 .skey[0];
 				if (!psecuritypriv->binstallGrpkey)
 					return;
 
 			} else {
 				prwskey = &stainfo->x_UncstKey.skey[0];
 			}
-			length = ((union recv_frame *)precvframe)->
-				 u.hdr.len - prxattrib->hdrlen -
-				 prxattrib->iv_len;
+			length = ((union recv_frame *)precvframe)->u.hdr.len -
+				 prxattrib->hdrlen - prxattrib->iv_len;
 			aes_decipher(prwskey, prxattrib->hdrlen, pframe,
 				     length);
 		}
diff --git a/drivers/staging/rtl8712/rtl871x_security.h b/drivers/staging/rtl8712/rtl871x_security.h
index 8461b7f05359..a3af023518b7 100644
--- a/drivers/staging/rtl8712/rtl871x_security.h
+++ b/drivers/staging/rtl8712/rtl871x_security.h
@@ -17,15 +17,15 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#define _NO_PRIVACY_	0x0
-#define _WEP40_		0x1
-#define _TKIP_		0x2
-#define _TKIP_WTMIC_	0x3
-#define _AES_		0x4
-#define _WEP104_	0x5
+#define _NO_PRIVACY_ 0x0
+#define _WEP40_ 0x1
+#define _TKIP_ 0x2
+#define _TKIP_WTMIC_ 0x3
+#define _AES_ 0x4
+#define _WEP104_ 0x5
 
-#define _WPA_IE_ID_	0xdd
-#define _WPA2_IE_ID_	0x30
+#define _WPA_IE_ID_ 0xdd
+#define _WPA2_IE_ID_ 0x30
 
 #ifndef Ndis802_11AuthModeWPA2
 #define Ndis802_11AuthModeWPA2 (Ndis802_11AuthModeWPANone + 1)
@@ -77,142 +77,136 @@ struct RT_PMKID_LIST {
 };
 
 struct security_priv {
-	u32 AuthAlgrthm;		/* 802.11 auth, could be open, shared,
+	u32 AuthAlgrthm; /* 802.11 auth, could be open, shared,
 					 * 8021x and authswitch
 					 */
-	u32 PrivacyAlgrthm;		/* This specify the privacy for shared
+	u32 PrivacyAlgrthm; /* This specify the privacy for shared
 					 * auth. algorithm.
 					 */
-	u32 PrivacyKeyIndex;		/* this is only valid for legendary
+	u32 PrivacyKeyIndex; /* this is only valid for legendary
 					 * wep, 0~3 for key id.
 					 */
-	union Keytype DefKey[4];	/* this is only valid for def. key */
+	union Keytype DefKey[4]; /* this is only valid for def. key */
 	u32 DefKeylen[4];
-	u32 XGrpPrivacy;		/* This specify the privacy algthm.
+	u32 XGrpPrivacy; /* This specify the privacy algthm.
 					 * used for Grp key
 					 */
-	u32 XGrpKeyid;			/* key id used for Grp Key */
-	union Keytype	XGrpKey[2];	/* 802.1x Group Key, for
+	u32 XGrpKeyid; /* key id used for Grp Key */
+	union Keytype XGrpKey[2]; /* 802.1x Group Key, for
 					 * inx0 and inx1
 					 */
-	union Keytype	XGrptxmickey[2];
-	union Keytype	XGrprxmickey[2];
-	union pn48 Grptxpn;		/* PN48 used for Grp Key xmit. */
-	union pn48 Grprxpn;		/* PN48 used for Grp Key recv. */
-	u8 wps_hw_pbc_pressed;/*for hw pbc pressed*/
-	u8 wps_phase;/*for wps*/
+	union Keytype XGrptxmickey[2];
+	union Keytype XGrprxmickey[2];
+	union pn48 Grptxpn; /* PN48 used for Grp Key xmit. */
+	union pn48 Grprxpn; /* PN48 used for Grp Key recv. */
+	u8 wps_hw_pbc_pressed; /*for hw pbc pressed*/
+	u8 wps_phase; /*for wps*/
 	u8 wps_ie[MAX_WPA_IE_LEN << 2];
 	int wps_ie_len;
-	u8	binstallGrpkey;
-	u8	busetkipkey;
+	u8 binstallGrpkey;
+	u8 busetkipkey;
 	struct timer_list tkip_timer;
-	u8	bcheck_grpkey;
-	u8	bgrpkey_handshake;
-	s32	sw_encrypt;	/* from registry_priv */
-	s32	sw_decrypt;	/* from registry_priv */
-	s32	hw_decrypted;	/* if the rx packets is hw_decrypted==false,
+	u8 bcheck_grpkey;
+	u8 bgrpkey_handshake;
+	s32 sw_encrypt; /* from registry_priv */
+	s32 sw_decrypt; /* from registry_priv */
+	s32 hw_decrypted; /* if the rx packets is hw_decrypted==false,
 				 * it means the hw has not been ready.
 				 */
-	u32 ndisauthtype;	/* keeps the auth_type & enc_status from upper
+	u32 ndisauthtype; /* keeps the auth_type & enc_status from upper
 				 * layer ioctl(wpa_supplicant or wzc)
 				 */
 	u32 ndisencryptstatus;
-	struct wlan_bssid_ex sec_bss;  /* for joinbss (h2c buffer) usage */
+	struct wlan_bssid_ex sec_bss; /* for joinbss (h2c buffer) usage */
 	struct NDIS_802_11_WEP ndiswep;
 	u8 assoc_info[600];
 	u8 szofcapability[256]; /* for wpa2 usage */
 	u8 oidassociation[512]; /* for wpa/wpa2 usage */
-	u8 authenticator_ie[256];  /* store ap security information element */
-	u8 supplicant_ie[256];  /* store sta security information element */
+	u8 authenticator_ie[256]; /* store ap security information element */
+	u8 supplicant_ie[256]; /* store sta security information element */
 	/* for tkip countermeasure */
 	u32 last_mic_err_time;
-	u8	btkip_countermeasure;
-	u8	btkip_wait_report;
+	u8 btkip_countermeasure;
+	u8 btkip_wait_report;
 	u32 btkip_countermeasure_time;
 	/*-------------------------------------------------------------------
 	 * For WPA2 Pre-Authentication.
 	 *------------------------------------------------------------------
 	 **/
-	struct RT_PMKID_LIST		PMKIDList[NUM_PMKID_CACHE];
-	u8				PMKIDIndex;
+	struct RT_PMKID_LIST PMKIDList[NUM_PMKID_CACHE];
+	u8 PMKIDIndex;
 };
 
-#define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst) \
-do { \
-	switch (psecuritypriv->AuthAlgrthm) { \
-	case 0: \
-	case 1: \
-	case 3: \
-		encry_algo = (u8)psecuritypriv->PrivacyAlgrthm; \
-		break; \
-	case 2: \
-		if (bmcst) \
-			encry_algo = (u8)psecuritypriv->XGrpPrivacy; \
-		else \
-			encry_algo = (u8)psta->XPrivacy; \
-		break; \
-	} \
-} while (0)
-#define SET_ICE_IV_LEN(iv_len, icv_len, encrypt)\
-do {\
-	switch (encrypt) { \
-	case _WEP40_: \
-	case _WEP104_: \
-		iv_len = 4; \
-		icv_len = 4; \
-		break; \
-	case _TKIP_: \
-		iv_len = 8; \
-		icv_len = 4; \
-		break; \
-	case _AES_: \
-		iv_len = 8; \
-		icv_len = 8; \
-		break; \
-	default: \
-		iv_len = 0; \
-		icv_len = 0; \
-		break; \
-	} \
-} while (0)
-#define GET_TKIP_PN(iv, txpn) \
-do {\
-	txpn._byte_.TSC0 = iv[2];\
-	txpn._byte_.TSC1 = iv[0];\
-	txpn._byte_.TSC2 = iv[4];\
-	txpn._byte_.TSC3 = iv[5];\
-	txpn._byte_.TSC4 = iv[6];\
-	txpn._byte_.TSC5 = iv[7];\
-} while (0)
-
-#define ROL32(A, n) (((A) << (n)) | (((A) >> (32 - (n)))  & ((1UL << (n)) - 1)))
+#define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst)               \
+	do {                                                                 \
+		switch (psecuritypriv->AuthAlgrthm) {                        \
+		case 0:                                                      \
+		case 1:                                                      \
+		case 3:                                                      \
+			encry_algo = (u8)psecuritypriv->PrivacyAlgrthm;      \
+			break;                                               \
+		case 2:                                                      \
+			if (bmcst)                                           \
+				encry_algo = (u8)psecuritypriv->XGrpPrivacy; \
+			else                                                 \
+				encry_algo = (u8)psta->XPrivacy;             \
+			break;                                               \
+		}                                                            \
+	} while (0)
+#define SET_ICE_IV_LEN(iv_len, icv_len, encrypt) \
+	do {                                     \
+		switch (encrypt) {               \
+		case _WEP40_:                    \
+		case _WEP104_:                   \
+			iv_len = 4;              \
+			icv_len = 4;             \
+			break;                   \
+		case _TKIP_:                     \
+			iv_len = 8;              \
+			icv_len = 4;             \
+			break;                   \
+		case _AES_:                      \
+			iv_len = 8;              \
+			icv_len = 8;             \
+			break;                   \
+		default:                         \
+			iv_len = 0;              \
+			icv_len = 0;             \
+			break;                   \
+		}                                \
+	} while (0)
+#define GET_TKIP_PN(iv, txpn)             \
+	do {                              \
+		txpn._byte_.TSC0 = iv[2]; \
+		txpn._byte_.TSC1 = iv[0]; \
+		txpn._byte_.TSC2 = iv[4]; \
+		txpn._byte_.TSC3 = iv[5]; \
+		txpn._byte_.TSC4 = iv[6]; \
+		txpn._byte_.TSC5 = iv[7]; \
+	} while (0)
+
+#define ROL32(A, n) (((A) << (n)) | (((A) >> (32 - (n))) & ((1UL << (n)) - 1)))
 #define ROR32(A, n) ROL32((A), 32 - (n))
 
 struct mic_data {
-	u32  K0, K1;         /* Key */
-	u32  L, R;           /* Current state */
-	u32  M;              /* Message accumulator (single word) */
-	u32  nBytesInM;      /* # bytes in M */
+	u32 K0, K1; /* Key */
+	u32 L, R; /* Current state */
+	u32 M; /* Message accumulator (single word) */
+	u32 nBytesInM; /* # bytes in M */
 };
 
-void seccalctkipmic(
-	u8  *key,
-	u8  *header,
-	u8  *data,
-	u32  data_len,
-	u8  *Miccode,
-	u8   priority);
+void seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *Miccode,
+		    u8 priority);
 
 void r8712_secmicsetkey(struct mic_data *pmicdata, u8 *key);
 void r8712_secmicappend(struct mic_data *pmicdata, u8 *src, u32 nBytes);
 void r8712_secgetmic(struct mic_data *pmicdata, u8 *dst);
 u32 r8712_aes_encrypt(struct _adapter *padapter, u8 *pxmitframe);
 u32 r8712_tkip_encrypt(struct _adapter *padapter, u8 *pxmitframe);
-void r8712_wep_encrypt(struct _adapter *padapter, u8  *pxmitframe);
-void r8712_aes_decrypt(struct _adapter *padapter, u8  *precvframe);
-void r8712_tkip_decrypt(struct _adapter *padapter, u8  *precvframe);
-void r8712_wep_decrypt(struct _adapter *padapter, u8  *precvframe);
+void r8712_wep_encrypt(struct _adapter *padapter, u8 *pxmitframe);
+void r8712_aes_decrypt(struct _adapter *padapter, u8 *precvframe);
+void r8712_tkip_decrypt(struct _adapter *padapter, u8 *precvframe);
+void r8712_wep_decrypt(struct _adapter *padapter, u8 *precvframe);
 void r8712_use_tkipkey_handler(struct timer_list *t);
 
-#endif	/*__RTL871X_SECURITY_H_ */
-
+#endif /*__RTL871X_SECURITY_H_ */
diff --git a/drivers/staging/rtl8712/rtl871x_sta_mgt.c b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
index 2c806a0105bf..86ff846bc940 100644
--- a/drivers/staging/rtl8712/rtl871x_sta_mgt.c
+++ b/drivers/staging/rtl8712/rtl871x_sta_mgt.c
@@ -34,16 +34,17 @@ static void _init_stainfo(struct sta_info *psta)
 	INIT_LIST_HEAD(&psta->auth_list);
 }
 
-int _r8712_init_sta_priv(struct	sta_priv *pstapriv)
+int _r8712_init_sta_priv(struct sta_priv *pstapriv)
 {
 	struct sta_info *psta;
 	s32 i;
 
-	pstapriv->pallocated_stainfo_buf = kmalloc(sizeof(struct sta_info) *
-						   NUM_STA + 4, GFP_ATOMIC);
+	pstapriv->pallocated_stainfo_buf =
+		kmalloc(sizeof(struct sta_info) * NUM_STA + 4, GFP_ATOMIC);
 	if (!pstapriv->pallocated_stainfo_buf)
 		return -ENOMEM;
-	pstapriv->pstainfo_buf = pstapriv->pallocated_stainfo_buf + 4 -
+	pstapriv->pstainfo_buf =
+		pstapriv->pallocated_stainfo_buf + 4 -
 		((addr_t)(pstapriv->pallocated_stainfo_buf) & 3);
 	_init_queue(&pstapriv->free_sta_queue);
 	spin_lock_init(&pstapriv->sta_hash_lock);
@@ -53,7 +54,7 @@ int _r8712_init_sta_priv(struct	sta_priv *pstapriv)
 	psta = (struct sta_info *)(pstapriv->pstainfo_buf);
 	for (i = 0; i < NUM_STA; i++) {
 		_init_stainfo(psta);
-		INIT_LIST_HEAD(&(pstapriv->sta_hash[i]));
+		INIT_LIST_HEAD(&pstapriv->sta_hash[i]);
 		list_add_tail(&psta->list, &pstapriv->free_sta_queue.queue);
 		psta++;
 	}
@@ -88,13 +89,13 @@ void _r8712_free_sta_priv(struct sta_priv *pstapriv)
 
 struct sta_info *r8712_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 {
-	s32	index;
+	s32 index;
 	struct list_head *phash_list;
-	struct sta_info	*psta;
-	struct  __queue *pfree_sta_queue;
+	struct sta_info *psta;
+	struct __queue *pfree_sta_queue;
 	struct recv_reorder_ctrl *preorder_ctrl;
 	int i = 0;
-	u16  wRxSeqInitialValue = 0xffff;
+	u16 wRxSeqInitialValue = 0xffff;
 	unsigned long flags;
 
 	pfree_sta_queue = &pstapriv->free_sta_queue;
@@ -114,14 +115,14 @@ struct sta_info *r8712_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 		list_add_tail(&psta->hash_list, phash_list);
 		pstapriv->asoc_sta_count++;
 
-/* For the SMC router, the sequence number of first packet of WPS handshake
+		/* For the SMC router, the sequence number of first packet of WPS handshake
  * will be 0. In this case, this packet will be dropped by recv_decache function
  * if we use the 0x00 as the default value for tid_rxseq variable. So, we
  * initialize the tid_rxseq variable as the 0xffff.
  */
 		for (i = 0; i < 16; i++)
 			memcpy(&psta->sta_recvpriv.rxcache.tid_rxseq[i],
-				&wRxSeqInitialValue, 2);
+			       &wRxSeqInitialValue, 2);
 		/* for A-MPDU Rx reordering buffer control */
 		for (i = 0; i < 16; i++) {
 			preorder_ctrl = &psta->recvreorder_ctrl[i];
@@ -143,32 +144,32 @@ void r8712_free_stainfo(struct _adapter *padapter, struct sta_info *psta)
 {
 	int i;
 	unsigned long irqL0;
-	struct  __queue *pfree_sta_queue;
+	struct __queue *pfree_sta_queue;
 	struct recv_reorder_ctrl *preorder_ctrl;
-	struct	sta_xmit_priv *pstaxmitpriv;
-	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
-	struct	sta_priv *pstapriv = &padapter->stapriv;
+	struct sta_xmit_priv *pstaxmitpriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	if (!psta)
 		return;
 	pfree_sta_queue = &pstapriv->free_sta_queue;
 	pstaxmitpriv = &psta->sta_xmitpriv;
-	spin_lock_irqsave(&(pxmitpriv->vo_pending.lock), irqL0);
+	spin_lock_irqsave(&pxmitpriv->vo_pending.lock, irqL0);
 	r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vo_q.sta_pending);
-	list_del_init(&(pstaxmitpriv->vo_q.tx_pending));
-	spin_unlock_irqrestore(&(pxmitpriv->vo_pending.lock), irqL0);
-	spin_lock_irqsave(&(pxmitpriv->vi_pending.lock), irqL0);
+	list_del_init(&pstaxmitpriv->vo_q.tx_pending);
+	spin_unlock_irqrestore(&pxmitpriv->vo_pending.lock, irqL0);
+	spin_lock_irqsave(&pxmitpriv->vi_pending.lock, irqL0);
 	r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vi_q.sta_pending);
-	list_del_init(&(pstaxmitpriv->vi_q.tx_pending));
-	spin_unlock_irqrestore(&(pxmitpriv->vi_pending.lock), irqL0);
-	spin_lock_irqsave(&(pxmitpriv->bk_pending.lock), irqL0);
+	list_del_init(&pstaxmitpriv->vi_q.tx_pending);
+	spin_unlock_irqrestore(&pxmitpriv->vi_pending.lock, irqL0);
+	spin_lock_irqsave(&pxmitpriv->bk_pending.lock, irqL0);
 	r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->bk_q.sta_pending);
-	list_del_init(&(pstaxmitpriv->bk_q.tx_pending));
-	spin_unlock_irqrestore(&(pxmitpriv->bk_pending.lock), irqL0);
-	spin_lock_irqsave(&(pxmitpriv->be_pending.lock), irqL0);
+	list_del_init(&pstaxmitpriv->bk_q.tx_pending);
+	spin_unlock_irqrestore(&pxmitpriv->bk_pending.lock, irqL0);
+	spin_lock_irqsave(&pxmitpriv->be_pending.lock, irqL0);
 	r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->be_q.sta_pending);
-	list_del_init(&(pstaxmitpriv->be_q.tx_pending));
-	spin_unlock_irqrestore(&(pxmitpriv->be_pending.lock), irqL0);
+	list_del_init(&pstaxmitpriv->be_q.tx_pending);
+	spin_unlock_irqrestore(&pxmitpriv->be_pending.lock, irqL0);
 	list_del_init(&psta->hash_list);
 	pstapriv->asoc_sta_count--;
 	/* re-init sta_info; 20061114 */
@@ -181,10 +182,10 @@ void r8712_free_stainfo(struct _adapter *padapter, struct sta_info *psta)
 		preorder_ctrl = &psta->recvreorder_ctrl[i];
 		del_timer(&preorder_ctrl->reordering_ctrl_timer);
 	}
-	spin_lock(&(pfree_sta_queue->lock));
+	spin_lock(&pfree_sta_queue->lock);
 	/* insert into free_sta_queue; 20061114 */
 	list_add_tail(&psta->list, &pfree_sta_queue->queue);
-	spin_unlock(&(pfree_sta_queue->lock));
+	spin_unlock(&pfree_sta_queue->lock);
 }
 
 /* free all stainfo which in sta_hash[all] */
@@ -194,18 +195,17 @@ void r8712_free_all_stainfo(struct _adapter *padapter)
 	struct list_head *plist, *phead;
 	s32 index;
 	struct sta_info *psta = NULL;
-	struct	sta_priv *pstapriv = &padapter->stapriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct sta_info *pbcmc_stainfo = r8712_get_bcmc_stainfo(padapter);
 
 	if (pstapriv->asoc_sta_count == 1)
 		return;
 	spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
 	for (index = 0; index < NUM_STA; index++) {
-		phead = &(pstapriv->sta_hash[index]);
+		phead = &pstapriv->sta_hash[index];
 		plist = phead->next;
 		while (!end_of_queue_search(phead, plist)) {
-			psta = container_of(plist,
-					    struct sta_info, hash_list);
+			psta = container_of(plist, struct sta_info, hash_list);
 			plist = plist->next;
 			if (pbcmc_stainfo != psta)
 				r8712_free_stainfo(padapter, psta);
@@ -217,16 +217,16 @@ void r8712_free_all_stainfo(struct _adapter *padapter)
 /* any station allocated can be searched by hash list */
 struct sta_info *r8712_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 {
-	unsigned long	 irqL;
+	unsigned long irqL;
 	struct list_head *plist, *phead;
 	struct sta_info *psta = NULL;
-	u32	index;
+	u32 index;
 
 	if (!hwaddr)
 		return NULL;
 	index = wifi_mac_hash(hwaddr);
 	spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
-	phead = &(pstapriv->sta_hash[index]);
+	phead = &pstapriv->sta_hash[index];
 	plist = phead->next;
 	while (!end_of_queue_search(phead, plist)) {
 		psta = container_of(plist, struct sta_info, hash_list);
@@ -243,8 +243,8 @@ struct sta_info *r8712_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 
 void r8712_init_bcmc_stainfo(struct _adapter *padapter)
 {
-	unsigned char bcast_addr[6] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-	struct	sta_priv *pstapriv = &padapter->stapriv;
+	unsigned char bcast_addr[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+	struct sta_priv *pstapriv = &padapter->stapriv;
 
 	r8712_alloc_stainfo(pstapriv, bcast_addr);
 }
@@ -252,7 +252,7 @@ void r8712_init_bcmc_stainfo(struct _adapter *padapter)
 struct sta_info *r8712_get_bcmc_stainfo(struct _adapter *padapter)
 {
 	struct sta_priv *pstapriv = &padapter->stapriv;
-	u8 bc_addr[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	u8 bc_addr[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
 	return r8712_get_stainfo(pstapriv, bc_addr);
 }
diff --git a/drivers/staging/rtl8712/rtl871x_wlan_sme.h b/drivers/staging/rtl8712/rtl871x_wlan_sme.h
index 97ea1451426c..59d9fbf6c042 100644
--- a/drivers/staging/rtl8712/rtl871x_wlan_sme.h
+++ b/drivers/staging/rtl8712/rtl871x_wlan_sme.h
@@ -14,22 +14,21 @@
 #ifndef _RTL871X_WLAN_SME_H_
 #define _RTL871X_WLAN_SME_H_
 
-#define MSR_APMODE		0x0C
-#define MSR_STAMODE	0x08
-#define MSR_ADHOCMODE	0x04
-#define MSR_NOLINKMODE	0x00
-#define		_1M_RATE_	0
-#define		_2M_RATE_	1
-#define		_5M_RATE_	2
-#define		_11M_RATE_	3
-#define		_6M_RATE_	4
-#define		_9M_RATE_	5
-#define		_12M_RATE_	6
-#define		_18M_RATE_	7
-#define		_24M_RATE_	8
-#define		_36M_RATE_	9
-#define		_48M_RATE_	10
-#define		_54M_RATE_	11
+#define MSR_APMODE 0x0C
+#define MSR_STAMODE 0x08
+#define MSR_ADHOCMODE 0x04
+#define MSR_NOLINKMODE 0x00
+#define _1M_RATE_ 0
+#define _2M_RATE_ 1
+#define _5M_RATE_ 2
+#define _11M_RATE_ 3
+#define _6M_RATE_ 4
+#define _9M_RATE_ 5
+#define _12M_RATE_ 6
+#define _18M_RATE_ 7
+#define _24M_RATE_ 8
+#define _36M_RATE_ 9
+#define _48M_RATE_ 10
+#define _54M_RATE_ 11
 
 #endif
-
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 408616e9afcf..b0c27388db2b 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -24,8 +24,8 @@
 #include <linux/usb.h>
 #include <linux/ieee80211.h>
 
-static const u8 P802_1H_OUI[P80211_OUI_LEN] = {0x00, 0x00, 0xf8};
-static const u8 RFC1042_OUI[P80211_OUI_LEN] = {0x00, 0x00, 0x00};
+static const u8 P802_1H_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0xf8 };
+static const u8 RFC1042_OUI[P80211_OUI_LEN] = { 0x00, 0x00, 0x00 };
 static void init_hwxmits(struct hw_xmit *phwxmit, sint entry);
 static void alloc_hwxmits(struct _adapter *padapter);
 static void free_hwxmits(struct _adapter *padapter);
@@ -39,8 +39,7 @@ static void _init_txservq(struct tx_servq *ptxservq)
 
 void _r8712_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
 {
-	memset((unsigned char *)psta_xmitpriv, 0,
-		 sizeof(struct sta_xmit_priv));
+	memset((unsigned char *)psta_xmitpriv, 0, sizeof(struct sta_xmit_priv));
 	spin_lock_init(&psta_xmitpriv->lock);
 	_init_txservq(&psta_xmitpriv->be_q);
 	_init_txservq(&psta_xmitpriv->bk_q);
@@ -77,25 +76,25 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	 * and initialize free_xmit_frame below.
 	 * Please also apply  free_txobj to link_up all the xmit_frames...
 	 */
-	pxmitpriv->pallocated_frame_buf =
-		kmalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4,
-			GFP_ATOMIC);
+	pxmitpriv->pallocated_frame_buf = kmalloc(
+		NR_XMITFRAME * sizeof(struct xmit_frame) + 4, GFP_ATOMIC);
 	if (!pxmitpriv->pallocated_frame_buf) {
 		pxmitpriv->pxmit_frame_buf = NULL;
 		return -ENOMEM;
 	}
-	pxmitpriv->pxmit_frame_buf = pxmitpriv->pallocated_frame_buf + 4 -
-			((addr_t) (pxmitpriv->pallocated_frame_buf) & 3);
-	pxframe = (struct xmit_frame *) pxmitpriv->pxmit_frame_buf;
+	pxmitpriv->pxmit_frame_buf =
+		pxmitpriv->pallocated_frame_buf + 4 -
+		((addr_t)(pxmitpriv->pallocated_frame_buf) & 3);
+	pxframe = (struct xmit_frame *)pxmitpriv->pxmit_frame_buf;
 	for (i = 0; i < NR_XMITFRAME; i++) {
-		INIT_LIST_HEAD(&(pxframe->list));
+		INIT_LIST_HEAD(&pxframe->list);
 		pxframe->padapter = padapter;
 		pxframe->frame_tag = DATA_FRAMETAG;
 		pxframe->pkt = NULL;
 		pxframe->buf_addr = NULL;
 		pxframe->pxmitbuf = NULL;
-		list_add_tail(&(pxframe->list),
-				 &(pxmitpriv->free_xmit_queue.queue));
+		list_add_tail(&pxframe->list,
+			      &pxmitpriv->free_xmit_queue.queue);
 		pxframe++;
 	}
 	pxmitpriv->free_xmitframe_cnt = NR_XMITFRAME;
@@ -117,7 +116,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	/*init xmit_buf*/
 	_init_queue(&pxmitpriv->free_xmitbuf_queue);
 	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
-	pxmitpriv->pxmitbuf = kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf), GFP_ATOMIC);
+	pxmitpriv->pxmitbuf =
+		kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf), GFP_ATOMIC);
 	if (!pxmitpriv->pxmitbuf)
 		goto clean_up_frame_buf;
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
@@ -130,14 +130,14 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 			goto clean_up_alloc_buf;
 		}
 		pxmitbuf->pbuf = pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
-				 ((addr_t) (pxmitbuf->pallocated_buf) &
-				 (XMITBUF_ALIGN_SZ - 1));
+				 ((addr_t)(pxmitbuf->pallocated_buf) &
+				  (XMITBUF_ALIGN_SZ - 1));
 		if (r8712_xmit_resource_alloc(padapter, pxmitbuf)) {
 			j = 1;
 			goto clean_up_alloc_buf;
 		}
 		list_add_tail(&pxmitbuf->list,
-				 &(pxmitpriv->free_xmitbuf_queue.queue));
+			      &pxmitpriv->free_xmitbuf_queue.queue);
 		pxmitbuf++;
 	}
 	pxmitpriv->free_xmitbuf_cnt = NR_XMITBUFF;
@@ -157,9 +157,9 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	for (j = 0; j < i; j++) {
 		int k;
 
-		pxmitbuf--;			/* reset pointer */
+		pxmitbuf--; /* reset pointer */
 		kfree(pxmitbuf->pallocated_buf);
-		for (k = 0; k < 8; k++)		/* delete xmit urb's */
+		for (k = 0; k < 8; k++) /* delete xmit urb's */
 			usb_free_urb(pxmitbuf->pxmit_urb[k]);
 	}
 	kfree(pxmitpriv->pxmitbuf);
@@ -174,8 +174,8 @@ void _free_xmit_priv(struct xmit_priv *pxmitpriv)
 {
 	int i;
 	struct _adapter *padapter = pxmitpriv->adapter;
-	struct xmit_frame *pxmitframe = (struct xmit_frame *)
-					pxmitpriv->pxmit_frame_buf;
+	struct xmit_frame *pxmitframe =
+		(struct xmit_frame *)pxmitpriv->pxmit_frame_buf;
 	struct xmit_buf *pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
 
 	if (!pxmitpriv->pxmit_frame_buf)
@@ -204,10 +204,10 @@ int r8712_update_attrib(struct _adapter *padapter, _pkt *pkt,
 	struct tx_cmd txdesc;
 
 	bool bmcast;
-	struct sta_priv		*pstapriv = &padapter->stapriv;
-	struct security_priv	*psecuritypriv = &padapter->securitypriv;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct qos_priv		*pqospriv = &pmlmepriv->qospriv;
+	struct sta_priv *pstapriv = &padapter->stapriv;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct qos_priv *pqospriv = &pmlmepriv->qospriv;
 
 	_r8712_open_pktfile(pkt, &pktfile);
 
@@ -266,10 +266,10 @@ int r8712_update_attrib(struct _adapter *padapter, _pkt *pkt,
 
 		_r8712_pktfile_read(&pktfile, &tmp[0], 24);
 		pattrib->dhcp_pkt = 0;
-		if (pktfile.pkt_len > 282) {/*MINIMUM_DHCP_PACKET_SIZE)*/
-			if (pattrib->ether_type == ETH_P_IP) {/* IP header*/
-				if (((tmp[21] == 68) && (tmp[23] == 67)) ||
-					((tmp[21] == 67) && (tmp[23] == 68))) {
+		if (pktfile.pkt_len > 282) { /*MINIMUM_DHCP_PACKET_SIZE)*/
+			if (pattrib->ether_type == ETH_P_IP) { /* IP header*/
+				if ((tmp[21] == 68 && tmp[23] == 67) ||
+				    (tmp[21] == 67 && tmp[23] == 68)) {
 					/* 68 : UDP BOOTP client
 					 * 67 : UDP BOOTP server
 					 * Use low rate to send DHCP packet.
@@ -291,7 +291,7 @@ int r8712_update_attrib(struct _adapter *padapter, _pkt *pkt,
 			pattrib->mac_id = 5;
 		} else {
 			psta = r8712_get_stainfo(pstapriv, pattrib->ra);
-			if (!psta)  /* drop the pkt */
+			if (!psta) /* drop the pkt */
 				return -ENOMEM;
 			if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
 				pattrib->mac_id = 5;
@@ -320,7 +320,7 @@ int r8712_update_attrib(struct _adapter *padapter, _pkt *pkt,
 	}
 	if (psta->ieee8021x_blocked) {
 		pattrib->encrypt = 0;
-		if ((pattrib->ether_type != 0x888e) &&
+		if (pattrib->ether_type != 0x888e &&
 		    !check_fwstate(pmlmepriv, WIFI_MP_STATE))
 			return -EINVAL;
 	} else {
@@ -349,8 +349,7 @@ int r8712_update_attrib(struct _adapter *padapter, _pkt *pkt,
 	}
 
 	if (pattrib->encrypt &&
-	    (padapter->securitypriv.sw_encrypt ||
-	    !psecuritypriv->hw_decrypted))
+	    (padapter->securitypriv.sw_encrypt || !psecuritypriv->hw_decrypted))
 		pattrib->bswenc = true;
 	else
 		pattrib->bswenc = false;
@@ -358,30 +357,30 @@ int r8712_update_attrib(struct _adapter *padapter, _pkt *pkt,
 	 * some settings above.
 	 */
 	if (check_fwstate(pmlmepriv, WIFI_MP_STATE))
-		pattrib->priority =
-		    (le32_to_cpu(txdesc.txdw1) >> QSEL_SHT) & 0x1f;
+		pattrib->priority = (le32_to_cpu(txdesc.txdw1) >> QSEL_SHT) &
+				    0x1f;
 	return 0;
 }
 
 static int xmitframe_addmic(struct _adapter *padapter,
 			    struct xmit_frame *pxmitframe)
 {
-	u32	curfragnum, length;
-	u8	*pframe, *payload, mic[8];
-	struct	mic_data micdata;
-	struct	sta_info *stainfo;
-	struct	qos_priv *pqospriv = &(padapter->mlmepriv.qospriv);
-	struct	pkt_attrib  *pattrib = &pxmitframe->attrib;
-	struct	security_priv *psecpriv = &padapter->securitypriv;
-	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	u32 curfragnum, length;
+	u8 *pframe, *payload, mic[8];
+	struct mic_data micdata;
+	struct sta_info *stainfo;
+	struct qos_priv *pqospriv = &padapter->mlmepriv.qospriv;
+	struct pkt_attrib *pattrib = &pxmitframe->attrib;
+	struct security_priv *psecpriv = &padapter->securitypriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	u8 priority[4] = {};
 	bool bmcst = is_multicast_ether_addr(pattrib->ra);
 
 	if (pattrib->psta)
 		stainfo = pattrib->psta;
 	else
-		stainfo = r8712_get_stainfo(&padapter->stapriv,
-					    &pattrib->ra[0]);
+		stainfo =
+			r8712_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
 	if (pattrib->encrypt == _TKIP_) {
 		/*encode mic code*/
 		if (stainfo) {
@@ -390,34 +389,37 @@ static int xmitframe_addmic(struct _adapter *padapter,
 			pframe = pxmitframe->buf_addr + TXDESC_OFFSET;
 			if (bmcst) {
 				if (!memcmp(psecpriv->XGrptxmickey
-				   [psecpriv->XGrpKeyid].skey,
-				   null_key, 16))
+						    [psecpriv->XGrpKeyid]
+							    .skey,
+					    null_key, 16))
 					return -ENOMEM;
 				/*start to calculate the mic code*/
 				r8712_secmicsetkey(&micdata,
-					psecpriv->XGrptxmickey
-					[psecpriv->XGrpKeyid].skey);
+						   psecpriv->XGrptxmickey
+							   [psecpriv->XGrpKeyid]
+								   .skey);
 			} else {
 				if (!memcmp(&stainfo->tkiptxmickey.skey[0],
 					    null_key, 16))
 					return -ENOMEM;
 				/* start to calculate the mic code */
-				r8712_secmicsetkey(&micdata,
-					     &stainfo->tkiptxmickey.skey[0]);
+				r8712_secmicsetkey(
+					&micdata,
+					&stainfo->tkiptxmickey.skey[0]);
 			}
-			if (pframe[1] & 1) {   /* ToDS==1 */
-				r8712_secmicappend(&micdata,
-						   &pframe[16], 6); /*DA*/
-				if (pframe[1] & 2)  /* From Ds==1 */
+			if (pframe[1] & 1) { /* ToDS==1 */
+				r8712_secmicappend(&micdata, &pframe[16],
+						   6); /*DA*/
+				if (pframe[1] & 2) /* From Ds==1 */
 					r8712_secmicappend(&micdata,
 							   &pframe[24], 6);
 				else
 					r8712_secmicappend(&micdata,
 							   &pframe[10], 6);
-			} else {	/* ToDS==0 */
-				r8712_secmicappend(&micdata,
-						   &pframe[4], 6); /* DA */
-				if (pframe[1] & 2)  /* From Ds==1 */
+			} else { /* ToDS==0 */
+				r8712_secmicappend(&micdata, &pframe[4],
+						   6); /* DA */
+				if (pframe[1] & 2) /* From Ds==1 */
 					r8712_secmicappend(&micdata,
 							   &pframe[16], 6);
 				else
@@ -434,29 +436,32 @@ static int xmitframe_addmic(struct _adapter *padapter,
 				payload += pattrib->hdrlen + pattrib->iv_len;
 				if ((curfragnum + 1) == pattrib->nr_frags) {
 					length = pattrib->last_txcmdsz -
-						  pattrib->hdrlen -
-						  pattrib->iv_len -
-						  ((psecpriv->sw_encrypt)
-						  ? pattrib->icv_len : 0);
+						 pattrib->hdrlen -
+						 pattrib->iv_len -
+						 ((psecpriv->sw_encrypt) ?
+							  pattrib->icv_len :
+							  0);
 					r8712_secmicappend(&micdata, payload,
 							   length);
 					payload = payload + length;
 				} else {
 					length = pxmitpriv->frag_len -
-					    pattrib->hdrlen - pattrib->iv_len -
-					    ((psecpriv->sw_encrypt) ?
-					    pattrib->icv_len : 0);
+						 pattrib->hdrlen -
+						 pattrib->iv_len -
+						 ((psecpriv->sw_encrypt) ?
+							  pattrib->icv_len :
+							  0);
 					r8712_secmicappend(&micdata, payload,
 							   length);
 					payload = payload + length +
 						  pattrib->icv_len;
 				}
 			}
-			r8712_secgetmic(&micdata, &(mic[0]));
+			r8712_secgetmic(&micdata, &mic[0]);
 			/* add mic code  and add the mic code length in
 			 * last_txcmdsz
 			 */
-			memcpy(payload, &(mic[0]), 8);
+			memcpy(payload, &mic[0], 8);
 			pattrib->last_txcmdsz += 8;
 			payload = payload - pattrib->last_txcmdsz + 8;
 		}
@@ -467,7 +472,7 @@ static int xmitframe_addmic(struct _adapter *padapter,
 static sint xmitframe_swencrypt(struct _adapter *padapter,
 				struct xmit_frame *pxmitframe)
 {
-	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
+	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 
 	if (pattrib->bswenc) {
 		switch (pattrib->encrypt) {
@@ -482,7 +487,7 @@ static sint xmitframe_swencrypt(struct _adapter *padapter,
 			r8712_aes_encrypt(padapter, (u8 *)pxmitframe);
 			break;
 		default:
-				break;
+			break;
 		}
 	}
 	return _SUCCESS;
@@ -506,7 +511,7 @@ static int make_wlanhdr(struct _adapter *padapter, u8 *hdr,
 
 	bssid = get_bssid(pmlmepriv);
 
-	if (check_fwstate(pmlmepriv,  WIFI_STATION_STATE)) {
+	if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
 		/* to_ds = 1, fr_ds = 0; */
 		SetToDs(fctrl);
 		ether_addr_copy(pwlanhdr->addr1, bssid);
@@ -596,20 +601,20 @@ static sint r8712_put_snap(u8 *data, u16 h_proto)
  * 6. apply sw-encrypt, if necessary.
  */
 sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
-			struct xmit_frame *pxmitframe)
+			      struct xmit_frame *pxmitframe)
 {
 	struct pkt_file pktfile;
 
-	sint	frg_len, mpdu_len, llc_sz;
-	u32	mem_sz;
-	u8	frg_inx;
+	sint frg_len, mpdu_len, llc_sz;
+	u32 mem_sz;
+	u8 frg_inx;
 	addr_t addr;
 	u8 *pframe, *mem_start, *ptxdesc;
-	struct sta_info		*psta;
-	struct security_priv	*psecpriv = &padapter->securitypriv;
-	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
-	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
-	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
+	struct sta_info *psta;
+	struct security_priv *psecpriv = &padapter->securitypriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 	u8 *pbuf_start;
 	bool bmcst = is_multicast_ether_addr(pattrib->ra);
 
@@ -624,7 +629,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 	if (make_wlanhdr(padapter, mem_start, pattrib))
 		return _FAIL;
 	_r8712_open_pktfile(pkt, &pktfile);
-	_r8712_pktfile_read(&pktfile, NULL, (uint) pattrib->pkt_hdrlen);
+	_r8712_pktfile_read(&pktfile, NULL, (uint)pattrib->pkt_hdrlen);
 	if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
 		/* truncate TXDESC_SIZE bytes txcmd if at mp mode for 871x */
 		if (pattrib->ether_type == 0x8712) {
@@ -653,9 +658,8 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 					break;
 				case _TKIP_:
 					if (bmcst)
-						TKIP_IV(pattrib->iv,
-						    psta->txpn,
-						    (u8)psecpriv->XGrpKeyid);
+						TKIP_IV(pattrib->iv, psta->txpn,
+							(u8)psecpriv->XGrpKeyid);
 					else
 						TKIP_IV(pattrib->iv, psta->txpn,
 							0);
@@ -663,7 +667,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 				case _AES_:
 					if (bmcst)
 						AES_IV(pattrib->iv, psta->txpn,
-						    (u8)psecpriv->XGrpKeyid);
+						       (u8)psecpriv->XGrpKeyid);
 					else
 						AES_IV(pattrib->iv, psta->txpn,
 						       0);
@@ -679,28 +683,27 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 			pframe += llc_sz;
 			mpdu_len -= llc_sz;
 		}
-		if ((pattrib->icv_len > 0) && (pattrib->bswenc))
+		if (pattrib->icv_len > 0 && pattrib->bswenc)
 			mpdu_len -= pattrib->icv_len;
 		if (bmcst)
 			mem_sz = _r8712_pktfile_read(&pktfile, pframe,
-				 pattrib->pktlen);
+						     pattrib->pktlen);
 		else
-			mem_sz = _r8712_pktfile_read(&pktfile, pframe,
-				 mpdu_len);
+			mem_sz =
+				_r8712_pktfile_read(&pktfile, pframe, mpdu_len);
 		pframe += mem_sz;
-		if ((pattrib->icv_len > 0) && (pattrib->bswenc)) {
+		if (pattrib->icv_len > 0 && pattrib->bswenc) {
 			memcpy(pframe, pattrib->icv, pattrib->icv_len);
 			pframe += pattrib->icv_len;
 		}
 		frg_inx++;
 		if (bmcst || r8712_endofpktfile(&pktfile)) {
 			pattrib->nr_frags = frg_inx;
-			pattrib->last_txcmdsz = pattrib->hdrlen +
-						pattrib->iv_len +
-						((pattrib->nr_frags == 1) ?
-						llc_sz : 0) +
-						((pattrib->bswenc) ?
-						pattrib->icv_len : 0) + mem_sz;
+			pattrib->last_txcmdsz =
+				pattrib->hdrlen + pattrib->iv_len +
+				((pattrib->nr_frags == 1) ? llc_sz : 0) +
+				((pattrib->bswenc) ? pattrib->icv_len : 0) +
+				mem_sz;
 			ClearMFrag(mem_start);
 			break;
 		}
@@ -717,11 +720,11 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 
 void r8712_update_protection(struct _adapter *padapter, u8 *ie, uint ie_len)
 {
-	uint	protection;
-	u8	*perp;
-	uint	erp_len;
-	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
-	struct	registry_priv *pregistrypriv = &padapter->registrypriv;
+	uint protection;
+	u8 *perp;
+	uint erp_len;
+	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
+	struct registry_priv *pregistrypriv = &padapter->registrypriv;
 
 	switch (pxmitpriv->vcs_setting) {
 	case DISABLE_VCS:
@@ -753,7 +756,7 @@ struct xmit_buf *r8712_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 {
 	unsigned long irqL;
 	struct xmit_buf *pxmitbuf;
-	struct  __queue *pfree_xmitbuf_queue = &pxmitpriv->free_xmitbuf_queue;
+	struct __queue *pfree_xmitbuf_queue = &pxmitpriv->free_xmitbuf_queue;
 
 	spin_lock_irqsave(&pfree_xmitbuf_queue->lock, irqL);
 	pxmitbuf = list_first_entry_or_null(&pfree_xmitbuf_queue->queue,
@@ -769,13 +772,13 @@ struct xmit_buf *r8712_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 void r8712_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 {
 	unsigned long irqL;
-	struct  __queue *pfree_xmitbuf_queue = &pxmitpriv->free_xmitbuf_queue;
+	struct __queue *pfree_xmitbuf_queue = &pxmitpriv->free_xmitbuf_queue;
 
 	if (!pxmitbuf)
 		return;
 	spin_lock_irqsave(&pfree_xmitbuf_queue->lock, irqL);
 	list_del_init(&pxmitbuf->list);
-	list_add_tail(&(pxmitbuf->list), &pfree_xmitbuf_queue->queue);
+	list_add_tail(&pxmitbuf->list, &pfree_xmitbuf_queue->queue);
 	pxmitpriv->free_xmitbuf_cnt++;
 	spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
 }
@@ -800,7 +803,7 @@ struct xmit_frame *r8712_alloc_xmitframe(struct xmit_priv *pxmitpriv)
 	 */
 	unsigned long irqL;
 	struct xmit_frame *pxframe;
-	struct  __queue *pfree_xmit_queue = &pxmitpriv->free_xmit_queue;
+	struct __queue *pfree_xmit_queue = &pxmitpriv->free_xmit_queue;
 
 	spin_lock_irqsave(&pfree_xmit_queue->lock, irqL);
 	pxframe = list_first_entry_or_null(&pfree_xmit_queue->queue,
@@ -821,7 +824,7 @@ void r8712_free_xmitframe(struct xmit_priv *pxmitpriv,
 			  struct xmit_frame *pxmitframe)
 {
 	unsigned long irqL;
-	struct  __queue *pfree_xmit_queue = &pxmitpriv->free_xmit_queue;
+	struct __queue *pfree_xmit_queue = &pxmitpriv->free_xmit_queue;
 	struct _adapter *padapter = pxmitpriv->adapter;
 
 	if (!pxmitframe)
@@ -838,7 +841,7 @@ void r8712_free_xmitframe(struct xmit_priv *pxmitpriv,
 }
 
 void r8712_free_xmitframe_ex(struct xmit_priv *pxmitpriv,
-		      struct xmit_frame *pxmitframe)
+			     struct xmit_frame *pxmitframe)
 {
 	if (!pxmitframe)
 		return;
@@ -847,13 +850,13 @@ void r8712_free_xmitframe_ex(struct xmit_priv *pxmitpriv,
 }
 
 void r8712_free_xmitframe_queue(struct xmit_priv *pxmitpriv,
-				struct  __queue *pframequeue)
+				struct __queue *pframequeue)
 {
 	unsigned long irqL;
 	struct list_head *plist, *phead;
-	struct	xmit_frame	*pxmitframe;
+	struct xmit_frame *pxmitframe;
 
-	spin_lock_irqsave(&(pframequeue->lock), irqL);
+	spin_lock_irqsave(&pframequeue->lock, irqL);
 	phead = &pframequeue->queue;
 	plist = phead->next;
 	while (!end_of_queue_search(phead, plist)) {
@@ -861,39 +864,39 @@ void r8712_free_xmitframe_queue(struct xmit_priv *pxmitpriv,
 		plist = plist->next;
 		r8712_free_xmitframe(pxmitpriv, pxmitframe);
 	}
-	spin_unlock_irqrestore(&(pframequeue->lock), irqL);
+	spin_unlock_irqrestore(&pframequeue->lock, irqL);
 }
 
 static inline struct tx_servq *get_sta_pending(struct _adapter *padapter,
-					       struct  __queue **ppstapending,
+					       struct __queue **ppstapending,
 					       struct sta_info *psta, sint up)
 {
 	struct tx_servq *ptxservq;
-	struct hw_xmit *phwxmits =  padapter->xmitpriv.hwxmits;
+	struct hw_xmit *phwxmits = padapter->xmitpriv.hwxmits;
 
 	switch (up) {
 	case 1:
 	case 2:
-		ptxservq = &(psta->sta_xmitpriv.bk_q);
+		ptxservq = &psta->sta_xmitpriv.bk_q;
 		*ppstapending = &padapter->xmitpriv.bk_pending;
 		(phwxmits + 3)->accnt++;
 		break;
 	case 4:
 	case 5:
-		ptxservq = &(psta->sta_xmitpriv.vi_q);
+		ptxservq = &psta->sta_xmitpriv.vi_q;
 		*ppstapending = &padapter->xmitpriv.vi_pending;
 		(phwxmits + 1)->accnt++;
 		break;
 	case 6:
 	case 7:
-		ptxservq = &(psta->sta_xmitpriv.vo_q);
+		ptxservq = &psta->sta_xmitpriv.vo_q;
 		*ppstapending = &padapter->xmitpriv.vo_pending;
 		(phwxmits + 0)->accnt++;
 		break;
 	case 0:
 	case 3:
 	default:
-		ptxservq = &(psta->sta_xmitpriv.be_q);
+		ptxservq = &psta->sta_xmitpriv.be_q;
 		*ppstapending = &padapter->xmitpriv.be_pending;
 		(phwxmits + 2)->accnt++;
 		break;
@@ -909,9 +912,9 @@ int r8712_xmit_classifier(struct _adapter *padapter,
 			  struct xmit_frame *pxmitframe)
 {
 	unsigned long irqL0;
-	struct  __queue *pstapending;
-	struct sta_info	*psta;
-	struct tx_servq	*ptxservq;
+	struct __queue *pstapending;
+	struct sta_info *psta;
+	struct tx_servq *ptxservq;
 	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -925,15 +928,15 @@ int r8712_xmit_classifier(struct _adapter *padapter,
 		} else {
 			if (check_fwstate(pmlmepriv, WIFI_MP_STATE))
 				psta = r8712_get_stainfo(pstapriv,
-				       get_bssid(pmlmepriv));
+							 get_bssid(pmlmepriv));
 			else
 				psta = r8712_get_stainfo(pstapriv, pattrib->ra);
 		}
 	}
 	if (!psta)
 		return -EINVAL;
-	ptxservq = get_sta_pending(padapter, &pstapending,
-		   psta, pattrib->priority);
+	ptxservq = get_sta_pending(padapter, &pstapending, psta,
+				   pattrib->priority);
 	spin_lock_irqsave(&pstapending->lock, irqL0);
 	if (list_empty(&ptxservq->tx_pending))
 		list_add_tail(&ptxservq->tx_pending, &pstapending->queue);
@@ -950,39 +953,39 @@ static void alloc_hwxmits(struct _adapter *padapter)
 
 	pxmitpriv->hwxmit_entry = HWXMIT_ENTRY;
 	pxmitpriv->hwxmits = kmalloc_array(pxmitpriv->hwxmit_entry,
-				sizeof(struct hw_xmit), GFP_ATOMIC);
+					   sizeof(struct hw_xmit), GFP_ATOMIC);
 	if (!pxmitpriv->hwxmits)
 		return;
 	hwxmits = pxmitpriv->hwxmits;
 	if (pxmitpriv->hwxmit_entry == 5) {
 		pxmitpriv->bmc_txqueue.head = 0;
-		hwxmits[0] .phwtxqueue = &pxmitpriv->bmc_txqueue;
-		hwxmits[0] .sta_queue = &pxmitpriv->bm_pending;
+		hwxmits[0].phwtxqueue = &pxmitpriv->bmc_txqueue;
+		hwxmits[0].sta_queue = &pxmitpriv->bm_pending;
 		pxmitpriv->vo_txqueue.head = 0;
-		hwxmits[1] .phwtxqueue = &pxmitpriv->vo_txqueue;
-		hwxmits[1] .sta_queue = &pxmitpriv->vo_pending;
+		hwxmits[1].phwtxqueue = &pxmitpriv->vo_txqueue;
+		hwxmits[1].sta_queue = &pxmitpriv->vo_pending;
 		pxmitpriv->vi_txqueue.head = 0;
-		hwxmits[2] .phwtxqueue = &pxmitpriv->vi_txqueue;
-		hwxmits[2] .sta_queue = &pxmitpriv->vi_pending;
+		hwxmits[2].phwtxqueue = &pxmitpriv->vi_txqueue;
+		hwxmits[2].sta_queue = &pxmitpriv->vi_pending;
 		pxmitpriv->bk_txqueue.head = 0;
-		hwxmits[3] .phwtxqueue = &pxmitpriv->bk_txqueue;
-		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
+		hwxmits[3].phwtxqueue = &pxmitpriv->bk_txqueue;
+		hwxmits[3].sta_queue = &pxmitpriv->bk_pending;
 		pxmitpriv->be_txqueue.head = 0;
-		hwxmits[4] .phwtxqueue = &pxmitpriv->be_txqueue;
-		hwxmits[4] .sta_queue = &pxmitpriv->be_pending;
+		hwxmits[4].phwtxqueue = &pxmitpriv->be_txqueue;
+		hwxmits[4].sta_queue = &pxmitpriv->be_pending;
 	} else if (pxmitpriv->hwxmit_entry == 4) {
 		pxmitpriv->vo_txqueue.head = 0;
-		hwxmits[0] .phwtxqueue = &pxmitpriv->vo_txqueue;
-		hwxmits[0] .sta_queue = &pxmitpriv->vo_pending;
+		hwxmits[0].phwtxqueue = &pxmitpriv->vo_txqueue;
+		hwxmits[0].sta_queue = &pxmitpriv->vo_pending;
 		pxmitpriv->vi_txqueue.head = 0;
-		hwxmits[1] .phwtxqueue = &pxmitpriv->vi_txqueue;
-		hwxmits[1] .sta_queue = &pxmitpriv->vi_pending;
+		hwxmits[1].phwtxqueue = &pxmitpriv->vi_txqueue;
+		hwxmits[1].sta_queue = &pxmitpriv->vi_pending;
 		pxmitpriv->be_txqueue.head = 0;
-		hwxmits[2] .phwtxqueue = &pxmitpriv->be_txqueue;
-		hwxmits[2] .sta_queue = &pxmitpriv->be_pending;
+		hwxmits[2].phwtxqueue = &pxmitpriv->be_txqueue;
+		hwxmits[2].sta_queue = &pxmitpriv->be_pending;
 		pxmitpriv->bk_txqueue.head = 0;
-		hwxmits[3] .phwtxqueue = &pxmitpriv->bk_txqueue;
-		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
+		hwxmits[3].phwtxqueue = &pxmitpriv->bk_txqueue;
+		hwxmits[3].sta_queue = &pxmitpriv->bk_pending;
 	}
 }
 
@@ -1006,7 +1009,7 @@ static void init_hwxmits(struct hw_xmit *phwxmit, sint entry)
 }
 
 void xmitframe_xmitbuf_attach(struct xmit_frame *pxmitframe,
-			struct xmit_buf *pxmitbuf)
+			      struct xmit_buf *pxmitbuf)
 {
 	/* pxmitbuf attach to pxmitframe */
 	pxmitframe->pxmitbuf = pxmitbuf;
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
index 784172c385e3..75b29a76af7e 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -19,118 +19,116 @@
 #include "xmit_osdep.h"
 
 #ifdef CONFIG_R8712_TX_AGGR
-#define MAX_XMITBUF_SZ  (16384)
+#define MAX_XMITBUF_SZ (16384)
 #else
-#define MAX_XMITBUF_SZ  (2048)
+#define MAX_XMITBUF_SZ (2048)
 #endif
 
-#define NR_XMITBUFF     (4)
+#define NR_XMITBUFF (4)
 
 #ifdef CONFIG_R8712_TX_AGGR
-#define AGGR_NR_HIGH_BOUND      (4) /*(8) */
-#define AGGR_NR_LOW_BOUND       (2)
+#define AGGR_NR_HIGH_BOUND (4) /*(8) */
+#define AGGR_NR_LOW_BOUND (2)
 #endif
 
 #define XMITBUF_ALIGN_SZ 512
-#define TX_GUARD_BAND		5
-#define MAX_NUMBLKS		(1)
+#define TX_GUARD_BAND 5
+#define MAX_NUMBLKS (1)
 
 /* Fixed the Big Endian bug when using the software driver encryption.*/
-#define WEP_IV(pattrib_iv, txpn, keyidx)\
-do { \
-	pattrib_iv[0] = txpn._byte_.TSC0;\
-	pattrib_iv[1] = txpn._byte_.TSC1;\
-	pattrib_iv[2] = txpn._byte_.TSC2;\
-	pattrib_iv[3] = ((keyidx & 0x3) << 6);\
-	txpn.val = (txpn.val == 0xffffff) ? 0 : (txpn.val + 1);\
-} while (0)
+#define WEP_IV(pattrib_iv, txpn, keyidx)                                \
+	do {                                                            \
+		pattrib_iv[0] = txpn._byte_.TSC0;                       \
+		pattrib_iv[1] = txpn._byte_.TSC1;                       \
+		pattrib_iv[2] = txpn._byte_.TSC2;                       \
+		pattrib_iv[3] = ((keyidx & 0x3) << 6);                  \
+		txpn.val = (txpn.val == 0xffffff) ? 0 : (txpn.val + 1); \
+	} while (0)
 
 /* Fixed the Big Endian bug when doing the Tx.
  * The Linksys WRH54G will check this.
  */
-#define TKIP_IV(pattrib_iv, txpn, keyidx)\
-do { \
-	pattrib_iv[0] = txpn._byte_.TSC1;\
-	pattrib_iv[1] = (txpn._byte_.TSC1 | 0x20) & 0x7f;\
-	pattrib_iv[2] = txpn._byte_.TSC0;\
-	pattrib_iv[3] = BIT(5) | ((keyidx & 0x3) << 6);\
-	pattrib_iv[4] = txpn._byte_.TSC2;\
-	pattrib_iv[5] = txpn._byte_.TSC3;\
-	pattrib_iv[6] = txpn._byte_.TSC4;\
-	pattrib_iv[7] = txpn._byte_.TSC5;\
-	txpn.val = txpn.val == 0xffffffffffffULL ? 0 : \
-	(txpn.val + 1);\
-} while (0)
+#define TKIP_IV(pattrib_iv, txpn, keyidx)                                      \
+	do {                                                                   \
+		pattrib_iv[0] = txpn._byte_.TSC1;                              \
+		pattrib_iv[1] = (txpn._byte_.TSC1 | 0x20) & 0x7f;              \
+		pattrib_iv[2] = txpn._byte_.TSC0;                              \
+		pattrib_iv[3] = BIT(5) | ((keyidx & 0x3) << 6);                \
+		pattrib_iv[4] = txpn._byte_.TSC2;                              \
+		pattrib_iv[5] = txpn._byte_.TSC3;                              \
+		pattrib_iv[6] = txpn._byte_.TSC4;                              \
+		pattrib_iv[7] = txpn._byte_.TSC5;                              \
+		txpn.val = txpn.val == 0xffffffffffffULL ? 0 : (txpn.val + 1); \
+	} while (0)
 
-#define AES_IV(pattrib_iv, txpn, keyidx)\
-do { \
-	pattrib_iv[0] = txpn._byte_.TSC0;\
-	pattrib_iv[1] = txpn._byte_.TSC1;\
-	pattrib_iv[2] = 0;\
-	pattrib_iv[3] = BIT(5) | ((keyidx & 0x3) << 6);\
-	pattrib_iv[4] = txpn._byte_.TSC2;\
-	pattrib_iv[5] = txpn._byte_.TSC3;\
-	pattrib_iv[6] = txpn._byte_.TSC4;\
-	pattrib_iv[7] = txpn._byte_.TSC5;\
-	txpn.val = txpn.val == 0xffffffffffffULL ? 0 : \
-	(txpn.val + 1);\
-} while (0)
+#define AES_IV(pattrib_iv, txpn, keyidx)                                       \
+	do {                                                                   \
+		pattrib_iv[0] = txpn._byte_.TSC0;                              \
+		pattrib_iv[1] = txpn._byte_.TSC1;                              \
+		pattrib_iv[2] = 0;                                             \
+		pattrib_iv[3] = BIT(5) | ((keyidx & 0x3) << 6);                \
+		pattrib_iv[4] = txpn._byte_.TSC2;                              \
+		pattrib_iv[5] = txpn._byte_.TSC3;                              \
+		pattrib_iv[6] = txpn._byte_.TSC4;                              \
+		pattrib_iv[7] = txpn._byte_.TSC5;                              \
+		txpn.val = txpn.val == 0xffffffffffffULL ? 0 : (txpn.val + 1); \
+	} while (0)
 
 struct hw_xmit {
 	spinlock_t xmit_lock;
 	struct list_head pending;
-	struct  __queue *sta_queue;
+	struct __queue *sta_queue;
 	struct hw_txqueue *phwtxqueue;
-	sint	txcmdcnt;
-	int	accnt;
+	sint txcmdcnt;
+	int accnt;
 };
 
 struct pkt_attrib {
-	u8	type;
-	u8	subtype;
-	u8	bswenc;
-	u8	dhcp_pkt;
+	u8 type;
+	u8 subtype;
+	u8 bswenc;
+	u8 dhcp_pkt;
 
-	u16	seqnum;
-	u16	ether_type;
-	u16	pktlen;		/* the original 802.3 pkt raw_data len
+	u16 seqnum;
+	u16 ether_type;
+	u16 pktlen; /* the original 802.3 pkt raw_data len
 				 * (not include ether_hdr data)
 				 */
-	u16	last_txcmdsz;
+	u16 last_txcmdsz;
 
-	u8	pkt_hdrlen;	/*the original 802.3 pkt header len*/
-	u8	hdrlen;		/*the WLAN Header Len*/
-	u8	nr_frags;
-	u8	ack_policy;
-	u8	mac_id;
-	u8	vcs_mode;	/*virtual carrier sense method*/
-	u8	pctrl;/*per packet txdesc control enable*/
-	u8	qsel;
+	u8 pkt_hdrlen; /*the original 802.3 pkt header len*/
+	u8 hdrlen; /*the WLAN Header Len*/
+	u8 nr_frags;
+	u8 ack_policy;
+	u8 mac_id;
+	u8 vcs_mode; /*virtual carrier sense method*/
+	u8 pctrl; /*per packet txdesc control enable*/
+	u8 qsel;
 
-	u8	priority;
-	u8	encrypt;	/* when 0 indicate no encrypt. when non-zero,
+	u8 priority;
+	u8 encrypt; /* when 0 indicate no encrypt. when non-zero,
 				 * indicate the encrypt algorithm
 				 */
-	u8	iv_len;
-	u8	icv_len;
+	u8 iv_len;
+	u8 icv_len;
 	unsigned char iv[8];
 	unsigned char icv[8];
-	u8	dst[ETH_ALEN] __aligned(2);	/* for ether_addr_copy */
-	u8	src[ETH_ALEN];
-	u8	ta[ETH_ALEN];
-	u8	ra[ETH_ALEN];
+	u8 dst[ETH_ALEN] __aligned(2); /* for ether_addr_copy */
+	u8 src[ETH_ALEN];
+	u8 ta[ETH_ALEN];
+	u8 ra[ETH_ALEN];
 	struct sta_info *psta;
 };
 
-#define WLANHDR_OFFSET	64
-#define DATA_FRAMETAG		0x01
-#define L2_FRAMETAG		0x02
-#define MGNT_FRAMETAG		0x03
-#define AMSDU_FRAMETAG	0x04
-#define EII_FRAMETAG		0x05
-#define IEEE8023_FRAMETAG  0x06
-#define MP_FRAMETAG		0x07
-#define TXAGG_FRAMETAG	0x08
+#define WLANHDR_OFFSET 64
+#define DATA_FRAMETAG 0x01
+#define L2_FRAMETAG 0x02
+#define MGNT_FRAMETAG 0x03
+#define AMSDU_FRAMETAG 0x04
+#define EII_FRAMETAG 0x05
+#define IEEE8023_FRAMETAG 0x06
+#define MP_FRAMETAG 0x07
+#define TXAGG_FRAMETAG 0x08
 
 struct xmit_buf {
 	struct list_head list;
@@ -159,71 +157,71 @@ struct xmit_frame {
 
 struct tx_servq {
 	struct list_head tx_pending;
-	struct  __queue	sta_pending;
+	struct __queue sta_pending;
 	int qcnt;
 };
 
 struct sta_xmit_priv {
 	spinlock_t lock;
-	sint	option;
-	sint	apsd_setting;	/* When bit mask is on, the associated edca
+	sint option;
+	sint apsd_setting; /* When bit mask is on, the associated edca
 				 * queue supports APSD.
 				 */
-	struct tx_servq	be_q;	/* priority == 0,3 */
-	struct tx_servq	bk_q;	/* priority == 1,2*/
-	struct tx_servq	vi_q;	/*priority == 4,5*/
-	struct tx_servq	vo_q;	/*priority == 6,7*/
-	struct list_head  legacy_dz;
+	struct tx_servq be_q; /* priority == 0,3 */
+	struct tx_servq bk_q; /* priority == 1,2*/
+	struct tx_servq vi_q; /*priority == 4,5*/
+	struct tx_servq vo_q; /*priority == 6,7*/
+	struct list_head legacy_dz;
 	struct list_head apsd;
 	u16 txseq_tid[16];
-	uint	sta_tx_bytes;
-	u64	sta_tx_pkts;
-	uint	sta_tx_fail;
+	uint sta_tx_bytes;
+	u64 sta_tx_pkts;
+	uint sta_tx_fail;
 };
 
-struct	hw_txqueue {
-	sint	head;
-	sint	tail;
-	sint	free_sz;	/* in units of 64 bytes */
-	sint	free_cmdsz;
-	sint	txsz[8];
-	uint	ff_hwaddr;
-	uint	cmd_hwaddr;
-	sint	ac_tag;
+struct hw_txqueue {
+	sint head;
+	sint tail;
+	sint free_sz; /* in units of 64 bytes */
+	sint free_cmdsz;
+	sint txsz[8];
+	uint ff_hwaddr;
+	uint cmd_hwaddr;
+	sint ac_tag;
 };
 
-struct	xmit_priv {
+struct xmit_priv {
 	spinlock_t lock;
-	struct  __queue	be_pending;
-	struct  __queue	bk_pending;
-	struct  __queue	vi_pending;
-	struct  __queue	vo_pending;
-	struct  __queue	bm_pending;
-	struct  __queue	legacy_dz_queue;
-	struct  __queue	apsd_queue;
+	struct __queue be_pending;
+	struct __queue bk_pending;
+	struct __queue vi_pending;
+	struct __queue vo_pending;
+	struct __queue bm_pending;
+	struct __queue legacy_dz_queue;
+	struct __queue apsd_queue;
 	u8 *pallocated_frame_buf;
 	u8 *pxmit_frame_buf;
 	uint free_xmitframe_cnt;
 	uint mapping_addr;
 	uint pkt_sz;
-	struct  __queue	free_xmit_queue;
-	struct	hw_txqueue	be_txqueue;
-	struct	hw_txqueue	bk_txqueue;
-	struct	hw_txqueue	vi_txqueue;
-	struct	hw_txqueue	vo_txqueue;
-	struct	hw_txqueue	bmc_txqueue;
-	uint	frag_len;
-	struct _adapter	*adapter;
-	u8   vcs_setting;
-	u8	vcs;
-	u8	vcs_type;
-	u16  rts_thresh;
-	uint	tx_bytes;
-	u64	tx_pkts;
-	uint	tx_drop;
+	struct __queue free_xmit_queue;
+	struct hw_txqueue be_txqueue;
+	struct hw_txqueue bk_txqueue;
+	struct hw_txqueue vi_txqueue;
+	struct hw_txqueue vo_txqueue;
+	struct hw_txqueue bmc_txqueue;
+	uint frag_len;
+	struct _adapter *adapter;
+	u8 vcs_setting;
+	u8 vcs;
+	u8 vcs_type;
+	u16 rts_thresh;
+	uint tx_bytes;
+	u64 tx_pkts;
+	uint tx_drop;
 	struct hw_xmit *hwxmits;
-	u8	hwxmit_entry;
-	u8	txirp_cnt;
+	u8 hwxmit_entry;
+	u8 txirp_cnt;
 	struct tasklet_struct xmit_tasklet;
 	struct work_struct xmit_pipe4_reset_wi;
 	struct work_struct xmit_pipe6_reset_wi;
@@ -233,30 +231,29 @@ struct	xmit_priv {
 	int bkq_cnt;
 	int viq_cnt;
 	int voq_cnt;
-	struct  __queue	free_amsdu_xmit_queue;
+	struct __queue free_amsdu_xmit_queue;
 	u8 *pallocated_amsdu_frame_buf;
 	u8 *pxmit_amsdu_frame_buf;
 	uint free_amsdu_xmitframe_cnt;
-	struct  __queue free_txagg_xmit_queue;
+	struct __queue free_txagg_xmit_queue;
 	u8 *pallocated_txagg_frame_buf;
 	u8 *pxmit_txagg_frame_buf;
 	uint free_txagg_xmitframe_cnt;
 	int cmdseq;
-	struct  __queue free_xmitbuf_queue;
-	struct  __queue pending_xmitbuf_queue;
+	struct __queue free_xmitbuf_queue;
+	struct __queue pending_xmitbuf_queue;
 	u8 *pxmitbuf;
 	uint free_xmitbuf_cnt;
 };
 
-void r8712_free_xmitbuf(struct xmit_priv *pxmitpriv,
-			struct xmit_buf *pxmitbuf);
+void r8712_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf);
 struct xmit_buf *r8712_alloc_xmitbuf(struct xmit_priv *pxmitpriv);
 void r8712_update_protection(struct _adapter *padapter, u8 *ie, uint ie_len);
 struct xmit_frame *r8712_alloc_xmitframe(struct xmit_priv *pxmitpriv);
 void r8712_free_xmitframe(struct xmit_priv *pxmitpriv,
 			  struct xmit_frame *pxmitframe);
 void r8712_free_xmitframe_queue(struct xmit_priv *pxmitpriv,
-				struct  __queue *pframequeue);
+				struct __queue *pframequeue);
 int r8712_xmit_classifier(struct _adapter *padapter,
 			  struct xmit_frame *pxmitframe);
 sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
@@ -275,7 +272,8 @@ void r8712_free_xmitframe_ex(struct xmit_priv *pxmitpriv,
 int r8712_pre_xmit(struct _adapter *padapter, struct xmit_frame *pxmitframe);
 int r8712_xmit_enqueue(struct _adapter *padapter,
 		       struct xmit_frame *pxmitframe);
-void r8712_xmit_direct(struct _adapter *padapter, struct xmit_frame *pxmitframe);
+void r8712_xmit_direct(struct _adapter *padapter,
+		       struct xmit_frame *pxmitframe);
 void r8712_xmit_bh(struct tasklet_struct *t);
 
 void xmitframe_xmitbuf_attach(struct xmit_frame *pxmitframe,
@@ -283,5 +281,4 @@ void xmitframe_xmitbuf_attach(struct xmit_frame *pxmitframe,
 
 #include "rtl8712_xmit.h"
 
-#endif	/*_RTL871X_XMIT_H_*/
-
+#endif /*_RTL871X_XMIT_H_*/
diff --git a/drivers/staging/rtl8712/sta_info.h b/drivers/staging/rtl8712/sta_info.h
index 6286c622475e..4d6121327e16 100644
--- a/drivers/staging/rtl8712/sta_info.h
+++ b/drivers/staging/rtl8712/sta_info.h
@@ -26,19 +26,19 @@
  */
 struct wlan_acl_node {
 	struct list_head list;
-	u8       addr[ETH_ALEN];
-	u8       mode;
+	u8 addr[ETH_ALEN];
+	u8 mode;
 };
 
 struct wlan_acl_pool {
 	struct wlan_acl_node aclnode[NUM_ACL];
 };
 
-struct	stainfo_stats {
-	uint	rx_pkts;
-	uint	rx_bytes;
-	u64	tx_pkts;
-	uint	tx_bytes;
+struct stainfo_stats {
+	uint rx_pkts;
+	uint rx_bytes;
+	u64 tx_pkts;
+	uint tx_bytes;
 };
 
 struct sta_info {
@@ -49,24 +49,24 @@ struct sta_info {
 	struct sta_recv_priv sta_recvpriv;
 	uint state;
 	uint aid;
-	uint	mac_id;
-	uint	qos_option;
-	u8	hwaddr[ETH_ALEN];
-	uint	ieee8021x_blocked;	/*0: allowed, 1:blocked */
-	uint	XPrivacy; /*aes, tkip...*/
-	union Keytype	tkiptxmickey;
-	union Keytype	tkiprxmickey;
-	union Keytype	x_UncstKey;
-	union pn48		txpn;	/* PN48 used for Unicast xmit.*/
-	union pn48		rxpn;	/* PN48 used for Unicast recv.*/
-	u8	bssrateset[16];
-	uint	bssratelen;
-	s32  rssi;
-	s32	signal_quality;
+	uint mac_id;
+	uint qos_option;
+	u8 hwaddr[ETH_ALEN];
+	uint ieee8021x_blocked; /*0: allowed, 1:blocked */
+	uint XPrivacy; /*aes, tkip...*/
+	union Keytype tkiptxmickey;
+	union Keytype tkiprxmickey;
+	union Keytype x_UncstKey;
+	union pn48 txpn; /* PN48 used for Unicast xmit.*/
+	union pn48 rxpn; /* PN48 used for Unicast recv.*/
+	u8 bssrateset[16];
+	uint bssratelen;
+	s32 rssi;
+	s32 signal_quality;
 	struct stainfo_stats sta_stats;
 	/*for A-MPDU Rx reordering buffer control */
 	struct recv_reorder_ctrl recvreorder_ctrl[16];
-	struct ht_priv	htpriv;
+	struct ht_priv htpriv;
 	/* Notes:
 	 * STA_Mode:
 	 * curr_network(mlme_priv/security_priv/qos/ht)
@@ -85,19 +85,19 @@ struct sta_info {
 	unsigned int tx_ra_bitmap;
 };
 
-struct	sta_priv {
+struct sta_priv {
 	u8 *pallocated_stainfo_buf;
 	u8 *pstainfo_buf;
-	struct  __queue	free_sta_queue;
+	struct __queue free_sta_queue;
 	spinlock_t sta_hash_lock;
 	struct list_head sta_hash[NUM_STA];
 	int asoc_sta_count;
-	struct  __queue sleep_q;
-	struct  __queue wakeup_q;
+	struct __queue sleep_q;
+	struct __queue wakeup_q;
 	struct _adapter *padapter;
 	struct list_head asoc_list;
 	struct list_head auth_list;
-	unsigned int auth_to;  /* sec, time to expire in authenticating. */
+	unsigned int auth_to; /* sec, time to expire in authenticating. */
 	unsigned int assoc_to; /* sec, time to expire before associating. */
 	unsigned int expire_to; /* sec , time to expire after associated. */
 };
@@ -113,14 +113,13 @@ static inline u32 wifi_mac_hash(u8 *mac)
 	x = (x << 2) ^ mac[4];
 	x = (x << 2) ^ mac[5];
 	x ^= x >> 8;
-	x  = x & (NUM_STA - 1);
+	x = x & (NUM_STA - 1);
 	return x;
 }
 
 int _r8712_init_sta_priv(struct sta_priv *pstapriv);
 void _r8712_free_sta_priv(struct sta_priv *pstapriv);
-struct sta_info *r8712_alloc_stainfo(struct sta_priv *pstapriv,
-				     u8 *hwaddr);
+struct sta_info *r8712_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr);
 void r8712_free_stainfo(struct _adapter *padapter, struct sta_info *psta);
 void r8712_free_all_stainfo(struct _adapter *padapter);
 struct sta_info *r8712_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr);
@@ -129,4 +128,3 @@ struct sta_info *r8712_get_bcmc_stainfo(struct _adapter *padapter);
 u8 r8712_access_ctrl(struct wlan_acl_pool *pacl_list, u8 *mac_addr);
 
 #endif /* _STA_INFO_H_ */
-
diff --git a/drivers/staging/rtl8712/usb_halinit.c b/drivers/staging/rtl8712/usb_halinit.c
index 313c569748e9..16c0c8e805fb 100644
--- a/drivers/staging/rtl8712/usb_halinit.c
+++ b/drivers/staging/rtl8712/usb_halinit.c
@@ -91,11 +91,12 @@ u8 r8712_usb_hal_bus_init(struct _adapter *adapter)
 		val8 = 0x37;
 		r8712_write8(adapter, CR + 1, val8);
 		/* reduce EndPoint & init it */
-		r8712_write8(adapter, 0x102500ab, r8712_read8(adapter,
-			     0x102500ab) | BIT(6) | BIT(7));
+		r8712_write8(adapter, 0x102500ab,
+			     r8712_read8(adapter, 0x102500ab) | BIT(6) |
+				     BIT(7));
 		/* consideration of power consumption - init */
-		r8712_write8(adapter, 0x10250008, r8712_read8(adapter,
-			     0x10250008) & 0xfffffffb);
+		r8712_write8(adapter, 0x10250008,
+			     r8712_read8(adapter, 0x10250008) & 0xfffffffb);
 	} else if (registrypriv->chip_version == RTL8712_1stCUT) {
 		/* Initialization for power on sequence, */
 		r8712_write8(adapter, SPS0_CTRL + 1, 0x53);
@@ -104,8 +105,8 @@ u8 r8712_usb_hal_bus_init(struct _adapter *adapter)
 		 * Block's Mbias
 		 */
 		val8 = r8712_read8(adapter, AFE_MISC);
-		r8712_write8(adapter, AFE_MISC, (val8 | AFE_MISC_BGEN |
-			     AFE_MISC_MBEN));
+		r8712_write8(adapter, AFE_MISC,
+			     (val8 | AFE_MISC_BGEN | AFE_MISC_MBEN));
 		/* Enable LDOA15 block */
 		val8 = r8712_read8(adapter, LDOA15_CTRL);
 		r8712_write8(adapter, LDOA15_CTRL, (val8 | LDA15_EN));
@@ -191,8 +192,9 @@ u8 r8712_usb_hal_bus_init(struct _adapter *adapter)
 		val8 = r8712_read8(adapter, AFE_MISC);
 		/*Bandgap*/
 		r8712_write8(adapter, AFE_MISC, (val8 | AFE_MISC_BGEN));
-		r8712_write8(adapter, AFE_MISC, (val8 | AFE_MISC_BGEN |
-			     AFE_MISC_MBEN | AFE_MISC_I32_EN));
+		r8712_write8(adapter, AFE_MISC,
+			     (val8 | AFE_MISC_BGEN | AFE_MISC_MBEN |
+			      AFE_MISC_I32_EN));
 		/* Enable PLL Power (LDOA15V) */
 		val8 = r8712_read8(adapter, LDOA15_CTRL);
 		r8712_write8(adapter, LDOA15_CTRL, (val8 | LDA15_EN));
@@ -265,7 +267,7 @@ u8 r8712_usb_hal_bus_init(struct _adapter *adapter)
 			if ((val8 & _TXDMA_INIT_VALUE) == _TXDMA_INIT_VALUE)
 				break;
 			udelay(5); /* PlatformStallExecution(5); */
-		} while (PollingCnt--);	/* Delay 1ms */
+		} while (PollingCnt--); /* Delay 1ms */
 
 		if (PollingCnt <= 0) {
 			val8 = r8712_read8(adapter, CR);
@@ -285,7 +287,7 @@ unsigned int r8712_usb_inirp_init(struct _adapter *adapter)
 	u8 i;
 	struct recv_buf *recvbuf;
 	struct intf_hdl *intfhdl = &adapter->pio_queue->intf;
-	struct recv_priv *recvpriv = &(adapter->recvpriv);
+	struct recv_priv *recvpriv = &adapter->recvpriv;
 
 	recvpriv->ff_hwaddr = RTL8712_DMA_RX0FF; /* mapping rx fifo address */
 	/* issue Rx irp to receive data */
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index df05213f922f..c8c8b6e80a35 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -36,150 +36,158 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 static void r871xu_dev_remove(struct usb_interface *pusb_intf);
 
 static const struct usb_device_id rtl871x_usb_id_tbl[] = {
-/* RTL8188SU */
+	/* RTL8188SU */
 	/* Realtek */
-	{USB_DEVICE(0x0BDA, 0x8171)},
-	{USB_DEVICE(0x0bda, 0x8173)},
-	{USB_DEVICE(0x0bda, 0x8712)},
-	{USB_DEVICE(0x0bda, 0x8713)},
-	{USB_DEVICE(0x0bda, 0xC512)},
+	{ USB_DEVICE(0x0BDA, 0x8171) },
+	{ USB_DEVICE(0x0bda, 0x8173) },
+	{ USB_DEVICE(0x0bda, 0x8712) },
+	{ USB_DEVICE(0x0bda, 0x8713) },
+	{ USB_DEVICE(0x0bda, 0xC512) },
 	/* Abocom */
-	{USB_DEVICE(0x07B8, 0x8188)},
+	{ USB_DEVICE(0x07B8, 0x8188) },
 	/* ASUS */
-	{USB_DEVICE(0x0B05, 0x1786)},
-	{USB_DEVICE(0x0B05, 0x1791)}, /* 11n mode disable */
+	{ USB_DEVICE(0x0B05, 0x1786) },
+	{ USB_DEVICE(0x0B05, 0x1791) }, /* 11n mode disable */
 	/* Belkin */
-	{USB_DEVICE(0x050D, 0x945A)},
+	{ USB_DEVICE(0x050D, 0x945A) },
 	/* ISY IWL - Belkin clone */
-	{USB_DEVICE(0x050D, 0x11F1)},
+	{ USB_DEVICE(0x050D, 0x11F1) },
 	/* Corega */
-	{USB_DEVICE(0x07AA, 0x0047)},
+	{ USB_DEVICE(0x07AA, 0x0047) },
 	/* D-Link */
-	{USB_DEVICE(0x2001, 0x3306)},
-	{USB_DEVICE(0x07D1, 0x3306)}, /* 11n mode disable */
+	{ USB_DEVICE(0x2001, 0x3306) },
+	{ USB_DEVICE(0x07D1, 0x3306) }, /* 11n mode disable */
 	/* Edimax */
-	{USB_DEVICE(0x7392, 0x7611)},
+	{ USB_DEVICE(0x7392, 0x7611) },
 	/* EnGenius */
-	{USB_DEVICE(0x1740, 0x9603)},
+	{ USB_DEVICE(0x1740, 0x9603) },
 	/* Hawking */
-	{USB_DEVICE(0x0E66, 0x0016)},
+	{ USB_DEVICE(0x0E66, 0x0016) },
 	/* Hercules */
-	{USB_DEVICE(0x06F8, 0xE034)},
-	{USB_DEVICE(0x06F8, 0xE032)},
+	{ USB_DEVICE(0x06F8, 0xE034) },
+	{ USB_DEVICE(0x06F8, 0xE032) },
 	/* Logitec */
-	{USB_DEVICE(0x0789, 0x0167)},
+	{ USB_DEVICE(0x0789, 0x0167) },
 	/* PCI */
-	{USB_DEVICE(0x2019, 0xAB28)},
-	{USB_DEVICE(0x2019, 0xED16)},
+	{ USB_DEVICE(0x2019, 0xAB28) },
+	{ USB_DEVICE(0x2019, 0xED16) },
 	/* Sitecom */
-	{USB_DEVICE(0x0DF6, 0x0057)},
-	{USB_DEVICE(0x0DF6, 0x0045)},
-	{USB_DEVICE(0x0DF6, 0x0059)}, /* 11n mode disable */
-	{USB_DEVICE(0x0DF6, 0x004B)},
-	{USB_DEVICE(0x0DF6, 0x005B)},
-	{USB_DEVICE(0x0DF6, 0x005D)},
-	{USB_DEVICE(0x0DF6, 0x0063)},
+	{ USB_DEVICE(0x0DF6, 0x0057) },
+	{ USB_DEVICE(0x0DF6, 0x0045) },
+	{ USB_DEVICE(0x0DF6, 0x0059) }, /* 11n mode disable */
+	{ USB_DEVICE(0x0DF6, 0x004B) },
+	{ USB_DEVICE(0x0DF6, 0x005B) },
+	{ USB_DEVICE(0x0DF6, 0x005D) },
+	{ USB_DEVICE(0x0DF6, 0x0063) },
 	/* Sweex */
-	{USB_DEVICE(0x177F, 0x0154)},
+	{ USB_DEVICE(0x177F, 0x0154) },
 	/* Thinkware */
-	{USB_DEVICE(0x0BDA, 0x5077)},
+	{ USB_DEVICE(0x0BDA, 0x5077) },
 	/* Toshiba */
-	{USB_DEVICE(0x1690, 0x0752)},
+	{ USB_DEVICE(0x1690, 0x0752) },
 	/* - */
-	{USB_DEVICE(0x20F4, 0x646B)},
-	{USB_DEVICE(0x083A, 0xC512)},
-	{USB_DEVICE(0x25D4, 0x4CA1)},
-	{USB_DEVICE(0x25D4, 0x4CAB)},
+	{ USB_DEVICE(0x20F4, 0x646B) },
+	{ USB_DEVICE(0x083A, 0xC512) },
+	{ USB_DEVICE(0x25D4, 0x4CA1) },
+	{ USB_DEVICE(0x25D4, 0x4CAB) },
 
-/* RTL8191SU */
+	/* RTL8191SU */
 	/* Realtek */
-	{USB_DEVICE(0x0BDA, 0x8172)},
-	{USB_DEVICE(0x0BDA, 0x8192)},
+	{ USB_DEVICE(0x0BDA, 0x8172) },
+	{ USB_DEVICE(0x0BDA, 0x8192) },
 	/* Amigo */
-	{USB_DEVICE(0x0EB0, 0x9061)},
+	{ USB_DEVICE(0x0EB0, 0x9061) },
 	/* ASUS/EKB */
-	{USB_DEVICE(0x13D3, 0x3323)},
-	{USB_DEVICE(0x13D3, 0x3311)}, /* 11n mode disable */
-	{USB_DEVICE(0x13D3, 0x3342)},
+	{ USB_DEVICE(0x13D3, 0x3323) },
+	{ USB_DEVICE(0x13D3, 0x3311) }, /* 11n mode disable */
+	{ USB_DEVICE(0x13D3, 0x3342) },
 	/* ASUS/EKBLenovo */
-	{USB_DEVICE(0x13D3, 0x3333)},
-	{USB_DEVICE(0x13D3, 0x3334)},
-	{USB_DEVICE(0x13D3, 0x3335)}, /* 11n mode disable */
-	{USB_DEVICE(0x13D3, 0x3336)}, /* 11n mode disable */
+	{ USB_DEVICE(0x13D3, 0x3333) },
+	{ USB_DEVICE(0x13D3, 0x3334) },
+	{ USB_DEVICE(0x13D3, 0x3335) }, /* 11n mode disable */
+	{ USB_DEVICE(0x13D3, 0x3336) }, /* 11n mode disable */
 	/* ASUS/Media BOX */
-	{USB_DEVICE(0x13D3, 0x3309)},
+	{ USB_DEVICE(0x13D3, 0x3309) },
 	/* Belkin */
-	{USB_DEVICE(0x050D, 0x815F)},
+	{ USB_DEVICE(0x050D, 0x815F) },
 	/* D-Link */
-	{USB_DEVICE(0x07D1, 0x3302)},
-	{USB_DEVICE(0x07D1, 0x3300)},
-	{USB_DEVICE(0x07D1, 0x3303)},
+	{ USB_DEVICE(0x07D1, 0x3302) },
+	{ USB_DEVICE(0x07D1, 0x3300) },
+	{ USB_DEVICE(0x07D1, 0x3303) },
 	/* Edimax */
-	{USB_DEVICE(0x7392, 0x7612)},
+	{ USB_DEVICE(0x7392, 0x7612) },
 	/* EnGenius */
-	{USB_DEVICE(0x1740, 0x9605)},
+	{ USB_DEVICE(0x1740, 0x9605) },
 	/* Guillemot */
-	{USB_DEVICE(0x06F8, 0xE031)},
+	{ USB_DEVICE(0x06F8, 0xE031) },
 	/* Hawking */
-	{USB_DEVICE(0x0E66, 0x0015)},
+	{ USB_DEVICE(0x0E66, 0x0015) },
 	/* Mediao */
-	{USB_DEVICE(0x13D3, 0x3306)},
+	{ USB_DEVICE(0x13D3, 0x3306) },
 	/* PCI */
-	{USB_DEVICE(0x2019, 0xED18)},
-	{USB_DEVICE(0x2019, 0x4901)},
+	{ USB_DEVICE(0x2019, 0xED18) },
+	{ USB_DEVICE(0x2019, 0x4901) },
 	/* Sitecom */
-	{USB_DEVICE(0x0DF6, 0x0058)},
-	{USB_DEVICE(0x0DF6, 0x0049)},
-	{USB_DEVICE(0x0DF6, 0x004C)},
-	{USB_DEVICE(0x0DF6, 0x006C)},
-	{USB_DEVICE(0x0DF6, 0x0064)},
+	{ USB_DEVICE(0x0DF6, 0x0058) },
+	{ USB_DEVICE(0x0DF6, 0x0049) },
+	{ USB_DEVICE(0x0DF6, 0x004C) },
+	{ USB_DEVICE(0x0DF6, 0x006C) },
+	{ USB_DEVICE(0x0DF6, 0x0064) },
 	/* Skyworth */
-	{USB_DEVICE(0x14b2, 0x3300)},
-	{USB_DEVICE(0x14b2, 0x3301)},
-	{USB_DEVICE(0x14B2, 0x3302)},
+	{ USB_DEVICE(0x14b2, 0x3300) },
+	{ USB_DEVICE(0x14b2, 0x3301) },
+	{ USB_DEVICE(0x14B2, 0x3302) },
 	/* - */
-	{USB_DEVICE(0x04F2, 0xAFF2)},
-	{USB_DEVICE(0x04F2, 0xAFF5)},
-	{USB_DEVICE(0x04F2, 0xAFF6)},
-	{USB_DEVICE(0x13D3, 0x3339)},
-	{USB_DEVICE(0x13D3, 0x3340)}, /* 11n mode disable */
-	{USB_DEVICE(0x13D3, 0x3341)}, /* 11n mode disable */
-	{USB_DEVICE(0x13D3, 0x3310)},
-	{USB_DEVICE(0x13D3, 0x3325)},
-
-/* RTL8192SU */
+	{ USB_DEVICE(0x04F2, 0xAFF2) },
+	{ USB_DEVICE(0x04F2, 0xAFF5) },
+	{ USB_DEVICE(0x04F2, 0xAFF6) },
+	{ USB_DEVICE(0x13D3, 0x3339) },
+	{ USB_DEVICE(0x13D3, 0x3340) }, /* 11n mode disable */
+	{ USB_DEVICE(0x13D3, 0x3341) }, /* 11n mode disable */
+	{ USB_DEVICE(0x13D3, 0x3310) },
+	{ USB_DEVICE(0x13D3, 0x3325) },
+
+	/* RTL8192SU */
 	/* Realtek */
-	{USB_DEVICE(0x0BDA, 0x8174)},
+	{ USB_DEVICE(0x0BDA, 0x8174) },
 	/* Belkin */
-	{USB_DEVICE(0x050D, 0x845A)},
+	{ USB_DEVICE(0x050D, 0x845A) },
 	/* Corega */
-	{USB_DEVICE(0x07AA, 0x0051)},
+	{ USB_DEVICE(0x07AA, 0x0051) },
 	/* Edimax */
-	{USB_DEVICE(0x7392, 0x7622)},
+	{ USB_DEVICE(0x7392, 0x7622) },
 	/* NEC */
-	{USB_DEVICE(0x0409, 0x02B6)},
+	{ USB_DEVICE(0x0409, 0x02B6) },
 	{}
 };
 
 MODULE_DEVICE_TABLE(usb, rtl871x_usb_id_tbl);
 
 static struct specific_device_id specific_device_id_tbl[] = {
-	{.idVendor = 0x0b05, .idProduct = 0x1791,
-		 .flags = SPEC_DEV_ID_DISABLE_HT},
-	{.idVendor = 0x0df6, .idProduct = 0x0059,
-		 .flags = SPEC_DEV_ID_DISABLE_HT},
-	{.idVendor = 0x13d3, .idProduct = 0x3306,
-		 .flags = SPEC_DEV_ID_DISABLE_HT},
-	{.idVendor = 0x13D3, .idProduct = 0x3311,
-		 .flags = SPEC_DEV_ID_DISABLE_HT},
-	{.idVendor = 0x13d3, .idProduct = 0x3335,
-		 .flags = SPEC_DEV_ID_DISABLE_HT},
-	{.idVendor = 0x13d3, .idProduct = 0x3336,
-		 .flags = SPEC_DEV_ID_DISABLE_HT},
-	{.idVendor = 0x13d3, .idProduct = 0x3340,
-		 .flags = SPEC_DEV_ID_DISABLE_HT},
-	{.idVendor = 0x13d3, .idProduct = 0x3341,
-		 .flags = SPEC_DEV_ID_DISABLE_HT},
+	{ .idVendor = 0x0b05,
+	  .idProduct = 0x1791,
+	  .flags = SPEC_DEV_ID_DISABLE_HT },
+	{ .idVendor = 0x0df6,
+	  .idProduct = 0x0059,
+	  .flags = SPEC_DEV_ID_DISABLE_HT },
+	{ .idVendor = 0x13d3,
+	  .idProduct = 0x3306,
+	  .flags = SPEC_DEV_ID_DISABLE_HT },
+	{ .idVendor = 0x13D3,
+	  .idProduct = 0x3311,
+	  .flags = SPEC_DEV_ID_DISABLE_HT },
+	{ .idVendor = 0x13d3,
+	  .idProduct = 0x3335,
+	  .flags = SPEC_DEV_ID_DISABLE_HT },
+	{ .idVendor = 0x13d3,
+	  .idProduct = 0x3336,
+	  .flags = SPEC_DEV_ID_DISABLE_HT },
+	{ .idVendor = 0x13d3,
+	  .idProduct = 0x3340,
+	  .flags = SPEC_DEV_ID_DISABLE_HT },
+	{ .idVendor = 0x13d3,
+	  .idProduct = 0x3341,
+	  .flags = SPEC_DEV_ID_DISABLE_HT },
 	{}
 };
 
@@ -215,7 +223,7 @@ static int r871x_resume(struct usb_interface *pusb_intf)
 	struct net_device *pnetdev = usb_get_intfdata(pusb_intf);
 	struct _adapter *padapter = netdev_priv(pnetdev);
 
-	netdev_info(pnetdev,  "Resuming...\n");
+	netdev_info(pnetdev, "Resuming...\n");
 	netif_device_attach(pnetdev);
 	if (pnetdev->netdev_ops->ndo_open)
 		pnetdev->netdev_ops->ndo_open(pnetdev);
@@ -238,9 +246,9 @@ static struct drv_priv drvpriv = {
 
 static uint r8712_usb_dvobj_init(struct _adapter *padapter)
 {
-	uint	status = _SUCCESS;
-	struct	usb_host_interface		*phost_iface;
-	struct	usb_interface_descriptor	*piface_desc;
+	uint status = _SUCCESS;
+	struct usb_host_interface *phost_iface;
+	struct usb_interface_descriptor *piface_desc;
 	struct dvobj_priv *pdvobjpriv = &padapter->dvobjpriv;
 	struct usb_device *pusbd = pdvobjpriv->pusbdev;
 
@@ -251,11 +259,13 @@ static uint r8712_usb_dvobj_init(struct _adapter *padapter)
 	pdvobjpriv->nr_endpoint = piface_desc->bNumEndpoints;
 	if (pusbd->speed == USB_SPEED_HIGH) {
 		pdvobjpriv->ishighspeed = true;
-		dev_info(&pusbd->dev, "r8712u: USB_SPEED_HIGH with %d endpoints\n",
+		dev_info(&pusbd->dev,
+			 "r8712u: USB_SPEED_HIGH with %d endpoints\n",
 			 pdvobjpriv->nr_endpoint);
 	} else {
 		pdvobjpriv->ishighspeed = false;
-		dev_info(&pusbd->dev, "r8712u: USB_SPEED_LOW with %d endpoints\n",
+		dev_info(&pusbd->dev,
+			 "r8712u: USB_SPEED_LOW with %d endpoints\n",
 			 pdvobjpriv->nr_endpoint);
 	}
 	if ((r8712_alloc_io_queue(padapter)) == _FAIL)
@@ -320,7 +330,7 @@ static void disable_ht_for_spec_devid(const struct usb_device_id *pdid,
 		pid = specific_device_id_tbl[i].idProduct;
 		flags = specific_device_id_tbl[i].flags;
 
-		if ((pdid->idVendor == vid) && (pdid->idProduct == pid) &&
+		if (pdid->idVendor == vid && pdid->idProduct == pid &&
 		    (flags & SPEC_DEV_ID_DISABLE_HT)) {
 			padapter->registrypriv.ht_enable = 0;
 			padapter->registrypriv.cbw40_enable = 0;
@@ -393,7 +403,7 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 		u8 tmpU1b, AutoloadFail, eeprom_CustomerID;
 		u8 *pdata = padapter->eeprompriv.efuse_eeprom_data;
 
-		tmpU1b = r8712_read8(padapter, EE_9346CR);/*CR9346*/
+		tmpU1b = r8712_read8(padapter, EE_9346CR); /*CR9346*/
 
 		/* To check system boot selection.*/
 		dev_info(&udev->dev, "r8712u: Boot from %s: Autoload %s\n",
@@ -416,13 +426,13 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 			 * Recognize IC version by Reg0x4 BIT15.
 			 */
 			tmpU1b = (u8)((r8712_read32(padapter, PMC_FSM) >> 15) &
-						    0x1F);
+				      0x1F);
 			if (tmpU1b == 0x3)
 				padapter->registrypriv.chip_version =
-				     RTL8712_3rdCUT;
+					RTL8712_3rdCUT;
 			else
 				padapter->registrypriv.chip_version =
-				     (tmpU1b >> 1) + 1;
+					(tmpU1b >> 1) + 1;
 			switch (padapter->registrypriv.chip_version) {
 			case RTL8712_1stCUT:
 			case RTL8712_2ndCUT:
@@ -430,13 +440,13 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 				break;
 			default:
 				padapter->registrypriv.chip_version =
-				     RTL8712_2ndCUT;
+					RTL8712_2ndCUT;
 				break;
 			}
 
 			for (i = 0, offset = 0; i < 128; i += 8, offset++)
 				r8712_efuse_pg_packet_read(padapter, offset,
-						     &pdata[i]);
+							   &pdata[i]);
 
 			if (!r8712_initmac || !mac_pton(r8712_initmac, mac)) {
 				/* Use the mac address stored in the Efuse
@@ -448,53 +458,52 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 			switch (eeprom_CustomerID) {
 			case EEPROM_CID_ALPHA:
 				padapter->eeprompriv.CustomerID =
-						 RT_CID_819x_ALPHA;
+					RT_CID_819x_ALPHA;
 				break;
 			case EEPROM_CID_CAMEO:
 				padapter->eeprompriv.CustomerID =
-						 RT_CID_819x_CAMEO;
+					RT_CID_819x_CAMEO;
 				break;
 			case EEPROM_CID_SITECOM:
 				padapter->eeprompriv.CustomerID =
-						 RT_CID_819x_Sitecom;
+					RT_CID_819x_Sitecom;
 				break;
 			case EEPROM_CID_COREGA:
-				padapter->eeprompriv.CustomerID =
-						 RT_CID_COREGA;
+				padapter->eeprompriv.CustomerID = RT_CID_COREGA;
 				break;
 			case EEPROM_CID_Senao:
 				padapter->eeprompriv.CustomerID =
-						 RT_CID_819x_Senao;
+					RT_CID_819x_Senao;
 				break;
 			case EEPROM_CID_EDIMAX_BELKIN:
 				padapter->eeprompriv.CustomerID =
-						 RT_CID_819x_Edimax_Belkin;
+					RT_CID_819x_Edimax_Belkin;
 				break;
 			case EEPROM_CID_SERCOMM_BELKIN:
 				padapter->eeprompriv.CustomerID =
-						 RT_CID_819x_Sercomm_Belkin;
+					RT_CID_819x_Sercomm_Belkin;
 				break;
 			case EEPROM_CID_WNC_COREGA:
 				padapter->eeprompriv.CustomerID =
-						 RT_CID_819x_WNC_COREGA;
+					RT_CID_819x_WNC_COREGA;
 				break;
 			case EEPROM_CID_WHQL:
 				break;
 			case EEPROM_CID_NetCore:
 				padapter->eeprompriv.CustomerID =
-						 RT_CID_819x_Netcore;
+					RT_CID_819x_Netcore;
 				break;
 			case EEPROM_CID_CAMEO1:
 				padapter->eeprompriv.CustomerID =
-						 RT_CID_819x_CAMEO1;
+					RT_CID_819x_CAMEO1;
 				break;
 			case EEPROM_CID_CLEVO:
 				padapter->eeprompriv.CustomerID =
-						 RT_CID_819x_CLEVO;
+					RT_CID_819x_CLEVO;
 				break;
 			default:
 				padapter->eeprompriv.CustomerID =
-						 RT_CID_DEFAULT;
+					RT_CID_DEFAULT;
 				break;
 			}
 			dev_info(&udev->dev, "r8712u: CustomerID = 0x%.4x\n",
@@ -536,13 +545,11 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 		} else {
 			AutoloadFail = false;
 		}
-		if ((!AutoloadFail) ||
-		    ((mac[0] == 0xff) && (mac[1] == 0xff) &&
-		     (mac[2] == 0xff) && (mac[3] == 0xff) &&
-		     (mac[4] == 0xff) && (mac[5] == 0xff)) ||
-		    ((mac[0] == 0x00) && (mac[1] == 0x00) &&
-		     (mac[2] == 0x00) && (mac[3] == 0x00) &&
-		     (mac[4] == 0x00) && (mac[5] == 0x00))) {
+		if (!AutoloadFail ||
+		    (mac[0] == 0xff && mac[1] == 0xff && mac[2] == 0xff &&
+		     mac[3] == 0xff && mac[4] == 0xff && mac[5] == 0xff) ||
+		    (mac[0] == 0x00 && mac[1] == 0x00 && mac[2] == 0x00 &&
+		     mac[3] == 0x00 && mac[4] == 0x00 && mac[5] == 0x00)) {
 			mac[0] = 0x00;
 			mac[1] = 0xe0;
 			mac[2] = 0x4c;
@@ -556,10 +563,10 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 			 */
 			mac[0] &= 0xFE;
 			dev_info(&udev->dev,
-				"r8712u: MAC Address from user = %pM\n", mac);
+				 "r8712u: MAC Address from user = %pM\n", mac);
 		} else {
 			dev_info(&udev->dev,
-				"r8712u: MAC Address from efuse = %pM\n", mac);
+				 "r8712u: MAC Address from efuse = %pM\n", mac);
 		}
 		eth_hw_addr_set(pnetdev, mac);
 	}
diff --git a/drivers/staging/rtl8712/usb_ops.h b/drivers/staging/rtl8712/usb_ops.h
index 7a6b619b73fa..ea2db0d7f8a4 100644
--- a/drivers/staging/rtl8712/usb_ops.h
+++ b/drivers/staging/rtl8712/usb_ops.h
@@ -18,12 +18,11 @@
 #include "drv_types.h"
 #include "osdep_intf.h"
 
-void r8712_usb_write_mem(struct intf_hdl *pintfhdl, u32 addr,
-			 u32 cnt, u8 *wmem);
-u32 r8712_usb_write_port(struct intf_hdl *pintfhdl, u32 addr,
-			 u32 cnt, u8 *wmem);
-u32 r8712_usb_read_port(struct intf_hdl *pintfhdl, u32 addr,
-			u32 cnt, u8 *rmem);
+void r8712_usb_write_mem(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
+			 u8 *wmem);
+u32 r8712_usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
+			 u8 *wmem);
+u32 r8712_usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem);
 void r8712_usb_set_intf_option(u32 *poption);
 void r8712_usb_set_intf_funs(struct intf_hdl *pintf_hdl);
 uint r8712_usb_init_intf_priv(struct intf_priv *pintfpriv);
@@ -35,4 +34,3 @@ int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
 			    u16 index, void *pdata, u16 len, u8 requesttype);
 
 #endif
-
diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rtl8712/usb_ops_linux.c
index 4a34824830e3..bfbb6a66fc3d 100644
--- a/drivers/staging/rtl8712/usb_ops_linux.c
+++ b/drivers/staging/rtl8712/usb_ops_linux.c
@@ -23,8 +23,8 @@
 #include "osdep_intf.h"
 #include "usb_ops.h"
 
-#define	RTL871X_VENQT_READ	0xc0
-#define	RTL871X_VENQT_WRITE	0x40
+#define RTL871X_VENQT_READ 0xc0
+#define RTL871X_VENQT_WRITE 0x40
 
 uint r8712_usb_init_intf_priv(struct intf_priv *pintfpriv)
 {
@@ -65,7 +65,7 @@ static unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
 		case RTL8712_DMA_BCNQ:
 			pipe = usb_sndbulkpipe(pusbd, 0x0a);
 			break;
-		case RTL8712_DMA_BMCQ:	/* HI Queue */
+		case RTL8712_DMA_BMCQ: /* HI Queue */
 			pipe = usb_sndbulkpipe(pusbd, 0x0b);
 			break;
 		case RTL8712_DMA_MGTQ:
@@ -134,7 +134,7 @@ static unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
 static void usb_write_mem_complete(struct urb *purb)
 {
 	struct io_queue *pio_q = (struct io_queue *)purb->context;
-	struct intf_hdl *pintf = &(pio_q->intf);
+	struct intf_hdl *pintf = &pio_q->intf;
 	struct intf_priv *pintfpriv = pintf->pintfpriv;
 	struct _adapter *padapter = (struct _adapter *)pintf->adapter;
 
@@ -157,16 +157,15 @@ void r8712_usb_write_mem(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
 	struct usb_device *pusbd = pdvobj->pusbdev;
 	struct urb *piorw_urb = pintfpriv->piorw_urb;
 
-	if ((padapter->driver_stopped) || (padapter->surprise_removed) ||
-	    (padapter->pwrctrlpriv.pnp_bstop_trx))
+	if (padapter->driver_stopped || padapter->surprise_removed ||
+	    padapter->pwrctrlpriv.pnp_bstop_trx)
 		return;
 	/* translate DMA FIFO addr to pipehandle */
 	pipe = ffaddr2pipehdl(pdvobj, addr);
 	if (pipe == 0)
 		return;
-	usb_fill_bulk_urb(piorw_urb, pusbd, pipe,
-			  wmem, cnt, usb_write_mem_complete,
-			  pio_queue);
+	usb_fill_bulk_urb(piorw_urb, pusbd, pipe, wmem, cnt,
+			  usb_write_mem_complete, pio_queue);
 	usb_submit_urb(piorw_urb, GFP_ATOMIC);
 	wait_for_completion_interruptible(&pintfpriv->io_retevt_comp);
 }
@@ -175,17 +174,17 @@ static void r8712_usb_read_port_complete(struct urb *purb)
 {
 	uint isevt;
 	__le32 *pbuf;
-	struct recv_buf	*precvbuf = (struct recv_buf *)purb->context;
+	struct recv_buf *precvbuf = (struct recv_buf *)purb->context;
 	struct _adapter *padapter = (struct _adapter *)precvbuf->adapter;
 	struct recv_priv *precvpriv = &padapter->recvpriv;
 
 	if (padapter->surprise_removed || padapter->driver_stopped)
 		return;
 	if (purb->status == 0) { /* SUCCESS */
-		if ((purb->actual_length > (MAX_RECVBUF_SZ)) ||
-		    (purb->actual_length < RXDESC_SIZE)) {
+		if (purb->actual_length > (MAX_RECVBUF_SZ) ||
+		    purb->actual_length < RXDESC_SIZE) {
 			r8712_read_port(padapter, precvpriv->ff_hwaddr, 0,
-				  (unsigned char *)precvbuf);
+					(unsigned char *)precvbuf);
 		} else {
 			_pkt *pskb = precvbuf->pskb;
 
@@ -224,7 +223,8 @@ static void r8712_usb_read_port_complete(struct urb *purb)
 					(unsigned char *)precvbuf);
 			break;
 		case -EINPROGRESS:
-			netdev_err(padapter->pnetdev, "ERROR: URB IS IN PROGRESS!\n");
+			netdev_err(padapter->pnetdev,
+				   "ERROR: URB IS IN PROGRESS!\n");
 			break;
 		default:
 			break;
@@ -240,7 +240,7 @@ u32 r8712_usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem)
 	int alignment = 0;
 	u32 ret = _SUCCESS;
 	struct urb *purb = NULL;
-	struct recv_buf	*precvbuf = (struct recv_buf *)rmem;
+	struct recv_buf *precvbuf = (struct recv_buf *)rmem;
 	struct intf_priv *pintfpriv = pintfhdl->pintfpriv;
 	struct dvobj_priv *pdvobj = (struct dvobj_priv *)pintfpriv->intf_dev;
 	struct _adapter *adapter = pdvobj->padapter;
@@ -255,14 +255,13 @@ u32 r8712_usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem)
 	precvbuf->pskb = skb_dequeue(&precvpriv->free_recv_skb_queue);
 
 	if (!precvbuf->pskb) {
-		precvbuf->pskb = netdev_alloc_skb(adapter->pnetdev,
-				 MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
+		precvbuf->pskb = netdev_alloc_skb(
+			adapter->pnetdev, MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
 		if (!precvbuf->pskb)
 			return _FAIL;
 		tmpaddr = (addr_t)precvbuf->pskb->data;
 		alignment = tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
-		skb_reserve(precvbuf->pskb,
-			    (RECVBUFF_ALIGN_SZ - alignment));
+		skb_reserve(precvbuf->pskb, (RECVBUFF_ALIGN_SZ - alignment));
 		precvbuf->phead = precvbuf->pskb->head;
 		precvbuf->pdata = precvbuf->pskb->data;
 		precvbuf->ptail = skb_tail_pointer(precvbuf->pskb);
@@ -278,10 +277,8 @@ u32 r8712_usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *rmem)
 	purb = precvbuf->purb;
 	/* translate DMA FIFO addr to pipehandle */
 	pipe = ffaddr2pipehdl(pdvobj, addr);
-	usb_fill_bulk_urb(purb, pusbd, pipe,
-			  precvbuf->pbuf, MAX_RECVBUF_SZ,
-			  r8712_usb_read_port_complete,
-			  precvbuf);
+	usb_fill_bulk_urb(purb, pusbd, pipe, precvbuf->pbuf, MAX_RECVBUF_SZ,
+			  r8712_usb_read_port_complete, precvbuf);
 	err = usb_submit_urb(purb, GFP_ATOMIC);
 	if ((err) && (err != (-EPERM)))
 		ret = _FAIL;
@@ -304,13 +301,13 @@ void r8712_usb_read_port_cancel(struct _adapter *padapter)
 void r8712_xmit_bh(struct tasklet_struct *t)
 {
 	int ret = false;
-	struct _adapter *padapter = from_tasklet(padapter, t,
-						 xmitpriv.xmit_tasklet);
+	struct _adapter *padapter =
+		from_tasklet(padapter, t, xmitpriv.xmit_tasklet);
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
-	if (padapter->driver_stopped ||
-	    padapter->surprise_removed) {
-		netdev_err(padapter->pnetdev, "xmit_bh => driver_stopped or surprise_removed\n");
+	if (padapter->driver_stopped || padapter->surprise_removed) {
+		netdev_err(padapter->pnetdev,
+			   "xmit_bh => driver_stopped or surprise_removed\n");
 		return;
 	}
 	ret = r8712_xmitframe_complete(padapter, pxmitpriv, NULL);
@@ -360,8 +357,8 @@ static void usb_write_port_complete(struct urb *purb)
 	case 0:
 		break;
 	default:
-		netdev_warn(padapter->pnetdev,
-				"r8712u: pipe error: (%d)\n", purb->status);
+		netdev_warn(padapter->pnetdev, "r8712u: pipe error: (%d)\n",
+			    purb->status);
 		break;
 	}
 	/* not to consider tx fragment */
@@ -384,14 +381,14 @@ u32 r8712_usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
 	struct usb_device *pusbd = pdvobj->pusbdev;
 	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 
-	if ((padapter->driver_stopped) || (padapter->surprise_removed) ||
-	    (padapter->pwrctrlpriv.pnp_bstop_trx))
+	if (padapter->driver_stopped || padapter->surprise_removed ||
+	    padapter->pwrctrlpriv.pnp_bstop_trx)
 		return _FAIL;
 	for (i = 0; i < 8; i++) {
 		if (!pxmitframe->bpending[i]) {
 			spin_lock_irqsave(&pxmitpriv->lock, irqL);
 			pxmitpriv->txirp_cnt++;
-			pxmitframe->bpending[i]  = true;
+			pxmitframe->bpending[i] = true;
 			switch (pattrib->priority) {
 			case 1:
 			case 2:
@@ -428,14 +425,13 @@ u32 r8712_usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
 	/* translate DMA FIFO addr to pipehandle */
 	pipe = ffaddr2pipehdl(pdvobj, addr);
 	if (pxmitpriv->free_xmitbuf_cnt % NR_XMITBUFF == 0)
-		purb->transfer_flags  &=  (~URB_NO_INTERRUPT);
+		purb->transfer_flags &= (~URB_NO_INTERRUPT);
 	else
-		purb->transfer_flags  |=  URB_NO_INTERRUPT;
+		purb->transfer_flags |= URB_NO_INTERRUPT;
 	if (bwritezero)
 		cnt += 8;
-	usb_fill_bulk_urb(purb, pusbd, pipe,
-			  pxmitframe->mem_addr,
-			  cnt, usb_write_port_complete,
+	usb_fill_bulk_urb(purb, pusbd, pipe, pxmitframe->mem_addr, cnt,
+			  usb_write_port_complete,
 			  pxmitframe); /* context is xmit_frame */
 	status = usb_submit_urb(purb, GFP_ATOMIC);
 	if (!status)
@@ -448,8 +444,8 @@ u32 r8712_usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8 *wmem)
 void r8712_usb_write_port_cancel(struct _adapter *padapter)
 {
 	int i, j;
-	struct xmit_buf	*pxmitbuf = (struct xmit_buf *)
-				     padapter->xmitpriv.pxmitbuf;
+	struct xmit_buf *pxmitbuf =
+		(struct xmit_buf *)padapter->xmitpriv.pxmitbuf;
 
 	for (i = 0; i < NR_XMITBUFF; i++) {
 		for (j = 0; j < 8; j++) {
@@ -461,13 +457,13 @@ void r8712_usb_write_port_cancel(struct _adapter *padapter)
 }
 
 int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
-		      u16 index, void *pdata, u16 len, u8 requesttype)
+			    u16 index, void *pdata, u16 len, u8 requesttype)
 {
 	unsigned int pipe;
 	int status;
 	u8 reqtype;
-	struct dvobj_priv *pdvobjpriv = (struct dvobj_priv *)
-					 pintfpriv->intf_dev;
+	struct dvobj_priv *pdvobjpriv =
+		(struct dvobj_priv *)pintfpriv->intf_dev;
 	struct usb_device *udev = pdvobjpriv->pusbdev;
 	/* For mstar platform, mstar suggests the address for USB IO
 	 * should be 16 bytes alignment. Trying to fix it here.
@@ -480,10 +476,10 @@ int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16 value,
 	pIo_buf = palloc_buf + 16 - ((addr_t)(palloc_buf) & 0x0f);
 	if (requesttype == 0x01) {
 		pipe = usb_rcvctrlpipe(udev, 0); /* read_in */
-		reqtype =  RTL871X_VENQT_READ;
+		reqtype = RTL871X_VENQT_READ;
 	} else {
 		pipe = usb_sndctrlpipe(udev, 0); /* write_out */
-		reqtype =  RTL871X_VENQT_WRITE;
+		reqtype = RTL871X_VENQT_WRITE;
 		memcpy(pIo_buf, pdata, len);
 	}
 	status = usb_control_msg(udev, pipe, request, reqtype, value, index,
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 498e6dec7e67..3966f7218833 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -17,161 +17,148 @@
 #include <linux/compiler.h>
 #include <linux/ieee80211.h>
 
-#define WLAN_HDR_A3_LEN		24
-#define WLAN_HDR_A3_QOS_LEN	26
+#define WLAN_HDR_A3_LEN 24
+#define WLAN_HDR_A3_QOS_LEN 26
 
 enum WIFI_FRAME_TYPE {
-	WIFI_QOS_DATA_TYPE	= (BIT(7) | BIT(3)),	/*!< QoS Data */
+	WIFI_QOS_DATA_TYPE = (BIT(7) | BIT(3)), /*!< QoS Data */
 };
 
-#define SetToDs(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_TODS); \
-})
+#define SetToDs(pbuf) \
+	({ *(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_TODS); })
 
-#define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_TODS)) != 0)
+#define GetToDs(pbuf) \
+	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_TODS)) != 0)
 
-#define ClearToDs(pbuf)	({ \
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_TODS)); \
-})
+#define ClearToDs(pbuf) \
+	({ *(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_TODS)); })
 
-#define SetFrDs(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_FROMDS); \
-})
+#define SetFrDs(pbuf) \
+	({ *(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_FROMDS); })
 
-#define GetFrDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_FROMDS)) != 0)
+#define GetFrDs(pbuf) \
+	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_FROMDS)) != 0)
 
-#define ClearFrDs(pbuf)	({ \
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_FROMDS)); \
-})
+#define ClearFrDs(pbuf) \
+	({ *(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_FROMDS)); })
 
 static inline unsigned char get_tofr_ds(unsigned char *pframe)
 {
 	return ((GetToDs(pframe) << 1) | GetFrDs(pframe));
 }
 
-#define SetMFrag(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_MOREFRAGS); \
-})
+#define SetMFrag(pbuf) \
+	({ *(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_MOREFRAGS); })
 
-#define GetMFrag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_MOREFRAGS)) != 0)
+#define GetMFrag(pbuf) \
+	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_MOREFRAGS)) != 0)
 
-#define ClearMFrag(pbuf) ({ \
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_MOREFRAGS)); \
-})
+#define ClearMFrag(pbuf) \
+	({ *(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_MOREFRAGS)); })
 
-#define SetRetry(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_RETRY); \
-})
+#define SetRetry(pbuf) \
+	({ *(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_RETRY); })
 
-#define GetRetry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_RETRY)) != 0)
+#define GetRetry(pbuf) \
+	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_RETRY)) != 0)
 
-#define ClearRetry(pbuf) ({ \
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_RETRY)); \
-})
+#define ClearRetry(pbuf) \
+	({ *(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_RETRY)); })
 
-#define SetPwrMgt(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_PM); \
-})
+#define SetPwrMgt(pbuf) \
+	({ *(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_PM); })
 
-#define GetPwrMgt(pbuf)	(((*(__le16 *)(pbuf)) & \
-			cpu_to_le16(IEEE80211_FCTL_PM)) != 0)
+#define GetPwrMgt(pbuf) \
+	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_PM)) != 0)
 
-#define ClearPwrMgt(pbuf) ({ \
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_PM)); \
-})
+#define ClearPwrMgt(pbuf) \
+	({ *(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_PM)); })
 
-#define SetMData(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_MOREDATA); \
-})
+#define SetMData(pbuf) \
+	({ *(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_MOREDATA); })
 
-#define GetMData(pbuf)	(((*(__le16 *)(pbuf)) & \
-			cpu_to_le16(IEEE80211_FCTL_MOREDATA)) != 0)
+#define GetMData(pbuf) \
+	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_MOREDATA)) != 0)
 
-#define ClearMData(pbuf) ({ \
-	*(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_MOREDATA)); \
-})
+#define ClearMData(pbuf) \
+	({ *(__le16 *)(pbuf) &= (~cpu_to_le16(IEEE80211_FCTL_MOREDATA)); })
 
-#define SetPrivacy(pbuf) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_PROTECTED); \
-})
+#define SetPrivacy(pbuf) \
+	({ *(__le16 *)(pbuf) |= cpu_to_le16(IEEE80211_FCTL_PROTECTED); })
 
-#define GetPrivacy(pbuf)	(((*(__le16 *)(pbuf)) & \
-				cpu_to_le16(IEEE80211_FCTL_PROTECTED)) != 0)
+#define GetPrivacy(pbuf) \
+	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_PROTECTED)) != 0)
 
-#define GetOrder(pbuf)	(((*(__le16 *)(pbuf)) & \
-			cpu_to_le16(IEEE80211_FCTL_ORDER)) != 0)
+#define GetOrder(pbuf) \
+	(((*(__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_ORDER)) != 0)
 
-#define GetFrameType(pbuf)	(le16_to_cpu(*(__le16 *)(pbuf)) & \
-				(BIT(3) | BIT(2)))
+#define GetFrameType(pbuf) (le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(3) | BIT(2)))
 
-#define SetFrameType(pbuf, type)	\
-	do {	\
-		*(__le16 *)(pbuf) &= cpu_to_le16(~(BIT(3) | \
-		BIT(2))); \
-		*(__le16 *)(pbuf) |= cpu_to_le16(type); \
+#define SetFrameType(pbuf, type)                                      \
+	do {                                                          \
+		*(__le16 *)(pbuf) &= cpu_to_le16(~(BIT(3) | BIT(2))); \
+		*(__le16 *)(pbuf) |= cpu_to_le16(type);               \
 	} while (0)
 
-#define GetFrameSubType(pbuf)	(le16_to_cpu(*(__le16 *)(pbuf)) & \
-				(BIT(7) | BIT(6) | BIT(5) | BIT(4) | BIT(3) | \
-				BIT(2)))
+#define GetFrameSubType(pbuf)             \
+	(le16_to_cpu(*(__le16 *)(pbuf)) & \
+	 (BIT(7) | BIT(6) | BIT(5) | BIT(4) | BIT(3) | BIT(2)))
 
-#define SetFrameSubType(pbuf, type) \
-	do {    \
-		*(__le16 *)(pbuf) &= cpu_to_le16(~(BIT(7) | BIT(6) | \
-		BIT(5) | BIT(4) | BIT(3) | BIT(2))); \
-		*(__le16 *)(pbuf) |= cpu_to_le16(type); \
+#define SetFrameSubType(pbuf, type)                                            \
+	do {                                                                   \
+		*(__le16 *)(pbuf) &= cpu_to_le16(~(BIT(7) | BIT(6) | BIT(5) |  \
+						   BIT(4) | BIT(3) | BIT(2))); \
+		*(__le16 *)(pbuf) |= cpu_to_le16(type);                        \
 	} while (0)
 
-#define GetSequence(pbuf)	(le16_to_cpu(*(__le16 *)\
-				((addr_t)(pbuf) + 22)) >> 4)
+#define GetSequence(pbuf) (le16_to_cpu(*(__le16 *)((addr_t)(pbuf) + 22)) >> 4)
 
-#define GetFragNum(pbuf)	(le16_to_cpu(*(__le16 *)((addr_t)\
-				(pbuf) + 22)) & 0x0f)
+#define GetFragNum(pbuf) (le16_to_cpu(*(__le16 *)((addr_t)(pbuf) + 22)) & 0x0f)
 
-#define SetSeqNum(pbuf, num) ({ \
-	*(__le16 *)((addr_t)(pbuf) + 22) = \
-	cpu_to_le16((le16_to_cpu(*(__le16 *)((addr_t)(pbuf) + 22)) & \
-	0x000f) | (0xfff0 & (num << 4))); \
-})
+#define SetSeqNum(pbuf, num)                                             \
+	({                                                               \
+		*(__le16 *)((addr_t)(pbuf) + 22) = cpu_to_le16(          \
+			(le16_to_cpu(*(__le16 *)((addr_t)(pbuf) + 22)) & \
+			 0x000f) |                                       \
+			(0xfff0 & (num << 4)));                          \
+	})
 
-#define SetPriority(pbuf, tid) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16(tid & 0xf); \
-})
+#define SetPriority(pbuf, tid) \
+	({ *(__le16 *)(pbuf) |= cpu_to_le16(tid & 0xf); })
 
-#define GetPriority(pbuf)	((le16_to_cpu(*(__le16 *)(pbuf))) & 0xf)
+#define GetPriority(pbuf) ((le16_to_cpu(*(__le16 *)(pbuf))) & 0xf)
 
-#define SetAckpolicy(pbuf, ack) ({ \
-	*(__le16 *)(pbuf) |= cpu_to_le16((ack & 3) << 5); \
-})
+#define SetAckpolicy(pbuf, ack) \
+	({ *(__le16 *)(pbuf) |= cpu_to_le16((ack & 3) << 5); })
 
 #define GetAckpolicy(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 5) & 0x3)
 
 #define GetAMsdu(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 7) & 0x1)
 
-#define GetAddr1Ptr(pbuf)	((unsigned char *)((addr_t)(pbuf) + 4))
+#define GetAddr1Ptr(pbuf) ((unsigned char *)((addr_t)(pbuf) + 4))
 
-#define GetAddr2Ptr(pbuf)	((unsigned char *)((addr_t)(pbuf) + 10))
+#define GetAddr2Ptr(pbuf) ((unsigned char *)((addr_t)(pbuf) + 10))
 
-#define GetAddr3Ptr(pbuf)	((unsigned char *)((addr_t)(pbuf) + 16))
+#define GetAddr3Ptr(pbuf) ((unsigned char *)((addr_t)(pbuf) + 16))
 
-#define GetAddr4Ptr(pbuf)	((unsigned char *)((addr_t)(pbuf) + 24))
+#define GetAddr4Ptr(pbuf) ((unsigned char *)((addr_t)(pbuf) + 24))
 
 static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 {
-	unsigned char	*sa;
-	unsigned int	to_fr_ds = (GetToDs(pframe) << 1) | GetFrDs(pframe);
+	unsigned char *sa;
+	unsigned int to_fr_ds = (GetToDs(pframe) << 1) | GetFrDs(pframe);
 
 	switch (to_fr_ds) {
-	case 0x00:	/* ToDs=0, FromDs=0 */
+	case 0x00: /* ToDs=0, FromDs=0 */
 		sa = GetAddr3Ptr(pframe);
 		break;
-	case 0x01:	/* ToDs=0, FromDs=1 */
+	case 0x01: /* ToDs=0, FromDs=1 */
 		sa = GetAddr2Ptr(pframe);
 		break;
-	case 0x02:	/* ToDs=1, FromDs=0 */
+	case 0x02: /* ToDs=1, FromDs=0 */
 		sa = GetAddr1Ptr(pframe);
 		break;
-	default:	/* ToDs=1, FromDs=1 */
+	default: /* ToDs=1, FromDs=1 */
 		sa = NULL;
 		break;
 	}
@@ -182,15 +169,14 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
  *			Below is the fixed elements...
  * ---------------------------------------------------------------------------
  */
-#define _BEACON_ITERVAL_		2
-#define _CAPABILITY_			2
-#define _TIMESTAMP_				8
+#define _BEACON_ITERVAL_ 2
+#define _CAPABILITY_ 2
+#define _TIMESTAMP_ 8
 
 /*-----------------------------------------------------------------------------
  *			Below is the definition for WMM
  *------------------------------------------------------------------------------
  */
-#define _WMM_IE_Length_				7  /* for WMM STA */
+#define _WMM_IE_Length_ 7 /* for WMM STA */
 
 #endif /* _WIFI_H_ */
-
diff --git a/drivers/staging/rtl8712/wlan_bssdef.h b/drivers/staging/rtl8712/wlan_bssdef.h
index ec3749813728..7a92faa635bf 100644
--- a/drivers/staging/rtl8712/wlan_bssdef.h
+++ b/drivers/staging/rtl8712/wlan_bssdef.h
@@ -14,15 +14,15 @@
 #ifndef __WLAN_BSSDEF_H__
 #define __WLAN_BSSDEF_H__
 
-#define MAX_IE_SZ	768
+#define MAX_IE_SZ 768
 
-#define NDIS_802_11_LENGTH_SSID         32
-#define NDIS_802_11_LENGTH_RATES        8
-#define NDIS_802_11_LENGTH_RATES_EX     16
+#define NDIS_802_11_LENGTH_SSID 32
+#define NDIS_802_11_LENGTH_RATES 8
+#define NDIS_802_11_LENGTH_RATES_EX 16
 
 struct ndis_802_11_ssid {
 	u32 SsidLength;
-	u8  Ssid[32];
+	u8 Ssid[32];
 };
 
 enum NDIS_802_11_NETWORK_TYPE {
@@ -34,10 +34,10 @@ enum NDIS_802_11_NETWORK_TYPE {
 };
 
 struct NDIS_802_11_CONFIGURATION_FH {
-	u32 Length;             /* Length of structure */
-	u32 HopPattern;         /* As defined by 802.11, MSB set */
-	u32 HopSet;             /* to one if non-802.11 */
-	u32 DwellTime;          /* units are Kusec */
+	u32 Length; /* Length of structure */
+	u32 HopPattern; /* As defined by 802.11, MSB set */
+	u32 HopSet; /* to one if non-802.11 */
+	u32 DwellTime; /* units are Kusec */
 };
 
 /*
@@ -45,10 +45,10 @@ struct NDIS_802_11_CONFIGURATION_FH {
  * ODI Handler will convert the channel number to freq. number.
  */
 struct NDIS_802_11_CONFIGURATION {
-	u32 Length;             /* Length of structure */
-	u32 BeaconPeriod;       /* units are Kusec */
-	u32 ATIMWindow;         /* units are Kusec */
-	u32 DSConfig;           /* Frequency, units are kHz */
+	u32 Length; /* Length of structure */
+	u32 BeaconPeriod; /* units are Kusec */
+	u32 ATIMWindow; /* units are Kusec */
+	u32 DSConfig; /* Frequency, units are kHz */
 	struct NDIS_802_11_CONFIGURATION_FH FHConfig;
 };
 
@@ -61,21 +61,21 @@ enum NDIS_802_11_NETWORK_INFRASTRUCTURE {
 };
 
 struct NDIS_802_11_FIXED_IEs {
-	u8  Timestamp[8];
+	u8 Timestamp[8];
 	u16 BeaconInterval;
 	u16 Capabilities;
 };
 
 struct wlan_bssid_ex {
 	u32 Length;
-	unsigned char  MacAddress[6];
-	u8  Reserved[2];
-	struct ndis_802_11_ssid  Ssid;
+	unsigned char MacAddress[6];
+	u8 Reserved[2];
+	struct ndis_802_11_ssid Ssid;
 	__le32 Privacy;
 	s32 Rssi;
-	enum NDIS_802_11_NETWORK_TYPE  NetworkTypeInUse;
-	struct NDIS_802_11_CONFIGURATION  Configuration;
-	enum NDIS_802_11_NETWORK_INFRASTRUCTURE  InfrastructureMode;
+	enum NDIS_802_11_NETWORK_TYPE NetworkTypeInUse;
+	struct NDIS_802_11_CONFIGURATION Configuration;
+	enum NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode;
 	u8 rates[NDIS_802_11_LENGTH_RATES_EX];
 	/* number of content bytes in EIs, which varies */
 	u32 IELength;
@@ -90,7 +90,7 @@ enum NDIS_802_11_AUTHENTICATION_MODE {
 	Ndis802_11AuthModeWPA,
 	Ndis802_11AuthModeWPAPSK,
 	Ndis802_11AuthModeWPANone,
-	Ndis802_11AuthModeMax      /* Not a real mode, defined as upper bound */
+	Ndis802_11AuthModeMax /* Not a real mode, defined as upper bound */
 };
 
 enum {
@@ -108,13 +108,13 @@ enum {
 	Ndis802_11Encryption3KeyAbsent
 };
 
-#define NDIS_802_11_AI_REQFI_CAPABILITIES      1
-#define NDIS_802_11_AI_REQFI_LISTENINTERVAL    2
-#define NDIS_802_11_AI_REQFI_CURRENTAPADDRESS  4
+#define NDIS_802_11_AI_REQFI_CAPABILITIES 1
+#define NDIS_802_11_AI_REQFI_LISTENINTERVAL 2
+#define NDIS_802_11_AI_REQFI_CURRENTAPADDRESS 4
 
-#define NDIS_802_11_AI_RESFI_CAPABILITIES      1
-#define NDIS_802_11_AI_RESFI_STATUSCODE        2
-#define NDIS_802_11_AI_RESFI_ASSOCIATIONID     4
+#define NDIS_802_11_AI_RESFI_CAPABILITIES 1
+#define NDIS_802_11_AI_RESFI_STATUSCODE 2
+#define NDIS_802_11_AI_RESFI_ASSOCIATIONID 4
 
 struct NDIS_802_11_AI_REQFI {
 	u16 Capabilities;
@@ -142,66 +142,58 @@ struct NDIS_802_11_ASSOCIATION_INFORMATION {
 
 /* Key mapping keys require a BSSID*/
 struct NDIS_802_11_KEY {
-	u32 Length;			/* Length of this structure */
+	u32 Length; /* Length of this structure */
 	u32 KeyIndex;
-	u32 KeyLength;			/* length of key in bytes */
+	u32 KeyLength; /* length of key in bytes */
 	unsigned char BSSID[6];
 	unsigned long long KeyRSC;
-	u8  KeyMaterial[32];		/* variable length */
+	u8 KeyMaterial[32]; /* variable length */
 };
 
 struct NDIS_802_11_REMOVE_KEY {
-	u32 Length;			/* Length of this structure */
+	u32 Length; /* Length of this structure */
 	u32 KeyIndex;
 	unsigned char BSSID[6];
 };
 
 struct NDIS_802_11_WEP {
-	u32 Length;		  /* Length of this structure */
-	u32 KeyIndex;		  /* 0 is the per-client key,
+	u32 Length; /* Length of this structure */
+	u32 KeyIndex; /* 0 is the per-client key,
 				   * 1-N are the global keys
 				   */
-	u32 KeyLength;		  /* length of key in bytes */
-	u8  KeyMaterial[16];      /* variable length depending on above field */
+	u32 KeyLength; /* length of key in bytes */
+	u8 KeyMaterial[16]; /* variable length depending on above field */
 };
 
 /* mask for authentication/integrity fields */
-#define NDIS_802_11_AUTH_REQUEST_AUTH_FIELDS        0x0f
-#define NDIS_802_11_AUTH_REQUEST_REAUTH			0x01
-#define NDIS_802_11_AUTH_REQUEST_KEYUPDATE		0x02
-#define NDIS_802_11_AUTH_REQUEST_PAIRWISE_ERROR		0x06
-#define NDIS_802_11_AUTH_REQUEST_GROUP_ERROR		0x0E
+#define NDIS_802_11_AUTH_REQUEST_AUTH_FIELDS 0x0f
+#define NDIS_802_11_AUTH_REQUEST_REAUTH 0x01
+#define NDIS_802_11_AUTH_REQUEST_KEYUPDATE 0x02
+#define NDIS_802_11_AUTH_REQUEST_PAIRWISE_ERROR 0x06
+#define NDIS_802_11_AUTH_REQUEST_GROUP_ERROR 0x0E
 
 /* MIC check time, 60 seconds. */
-#define MIC_CHECK_TIME	60000000
+#define MIC_CHECK_TIME 60000000
 
 #ifndef Ndis802_11APMode
 #define Ndis802_11APMode (Ndis802_11InfrastructureMax + 1)
 #endif
 
-struct	wlan_network {
+struct wlan_network {
 	struct list_head list;
-	int	network_type;	/*refer to ieee80211.h for WIRELESS_11A/B/G */
-	int	fixed;		/* set to fixed when not to be removed asi
+	int network_type; /*refer to ieee80211.h for WIRELESS_11A/B/G */
+	int fixed; /* set to fixed when not to be removed asi
 				 * site-surveying
 				 */
-	unsigned int	last_scanned; /*timestamp for the network */
-	int	aid;		/*will only be valid when a BSS is joined. */
-	int	join_res;
+	unsigned int last_scanned; /*timestamp for the network */
+	int aid; /*will only be valid when a BSS is joined. */
+	int join_res;
 	struct wlan_bssid_ex network; /*must be the last item */
 };
 
-enum VRTL_CARRIER_SENSE {
-	DISABLE_VCS,
-	ENABLE_VCS,
-	AUTO_VCS
-};
+enum VRTL_CARRIER_SENSE { DISABLE_VCS, ENABLE_VCS, AUTO_VCS };
 
-enum VCS_TYPE {
-	NONE_VCS,
-	RTS_CTS,
-	CTS_TO_SELF
-};
+enum VCS_TYPE { NONE_VCS, RTS_CTS, CTS_TO_SELF };
 
 #define PWR_CAM 0
 #define PWR_MINPS 1
@@ -209,15 +201,9 @@ enum VCS_TYPE {
 #define PWR_UAPSD 3
 #define PWR_VOIP 4
 
-enum UAPSD_MAX_SP {
-	NO_LIMIT,
-	TWO_MSDU,
-	FOUR_MSDU,
-	SIX_MSDU
-};
+enum UAPSD_MAX_SP { NO_LIMIT, TWO_MSDU, FOUR_MSDU, SIX_MSDU };
 
 #define NUM_PRE_AUTH_KEY 16
 #define NUM_PMKID_CACHE NUM_PRE_AUTH_KEY
 
 #endif /* #ifndef WLAN_BSSDEF_H_ */
-
diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index ceb6b590b310..9d6254238293 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -31,8 +31,8 @@
 
 static uint remainder_len(struct pkt_file *pfile)
 {
-	return (uint)(pfile->buf_len - ((addr_t)(pfile->cur_addr) -
-	       (addr_t)(pfile->buf_start)));
+	return (uint)(pfile->buf_len -
+		      ((addr_t)(pfile->cur_addr) - (addr_t)(pfile->buf_start)));
 }
 
 void _r8712_open_pktfile(_pkt *pktptr, struct pkt_file *pfile)
@@ -50,8 +50,8 @@ uint _r8712_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
 	len = remainder_len(pfile);
 	len = (rlen > len) ? len : rlen;
 	if (rmem)
-		skb_copy_bits(pfile->pkt, pfile->buf_len - pfile->pkt_len,
-			      rmem, len);
+		skb_copy_bits(pfile->pkt, pfile->buf_len - pfile->pkt_len, rmem,
+			      len);
 	pfile->cur_addr += len;
 	pfile->pkt_len -= len;
 	return len;
@@ -92,9 +92,9 @@ void r8712_set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib)
 
 void r8712_SetFilter(struct work_struct *work)
 {
-	struct _adapter *adapter = container_of(work, struct _adapter,
-						wk_filter_rx_ff0);
-	u8  oldvalue = 0x00, newvalue = 0x00;
+	struct _adapter *adapter =
+		container_of(work, struct _adapter, wk_filter_rx_ff0);
+	u8 oldvalue = 0x00, newvalue = 0x00;
 
 	oldvalue = r8712_read8(adapter, 0x117);
 	newvalue = oldvalue & 0xfe;
@@ -118,7 +118,8 @@ int r8712_xmit_resource_alloc(struct _adapter *padapter,
 				/* handle allocation errors part way through loop */
 				usb_free_urb(pxmitbuf->pxmit_urb[k]);
 			}
-			netdev_err(padapter->pnetdev, "pxmitbuf->pxmit_urb[i] == NULL\n");
+			netdev_err(padapter->pnetdev,
+				   "pxmitbuf->pxmit_urb[i] == NULL\n");
 			return -ENOMEM;
 		}
 		kmemleak_not_leak(pxmitbuf->pxmit_urb[i]);
@@ -146,11 +147,11 @@ void r8712_xmit_complete(struct _adapter *padapter, struct xmit_frame *pxframe)
 	pxframe->pkt = NULL;
 }
 
-netdev_tx_t r8712_xmit_entry(_pkt *pkt, struct  net_device *netdev)
+netdev_tx_t r8712_xmit_entry(_pkt *pkt, struct net_device *netdev)
 {
 	struct xmit_frame *xmitframe = NULL;
 	struct _adapter *adapter = netdev_priv(netdev);
-	struct xmit_priv *xmitpriv = &(adapter->xmitpriv);
+	struct xmit_priv *xmitpriv = &adapter->xmitpriv;
 
 	if (!r8712_if_up(adapter))
 		goto _xmit_entry_drop;
diff --git a/drivers/staging/rtl8712/xmit_osdep.h b/drivers/staging/rtl8712/xmit_osdep.h
index 1ad42658c883..f4639f210b6d 100644
--- a/drivers/staging/rtl8712/xmit_osdep.h
+++ b/drivers/staging/rtl8712/xmit_osdep.h
@@ -18,15 +18,15 @@
 #include "drv_types.h"
 
 struct pkt_file {
-	_pkt	*pkt;
-	u32	pkt_len;	 /*the remainder length of the open_file*/
-	_buffer	*cur_buffer;
-	u8	*buf_start;
-	u8	*cur_addr;
-	u32	buf_len;
+	_pkt *pkt;
+	u32 pkt_len; /*the remainder length of the open_file*/
+	_buffer *cur_buffer;
+	u8 *buf_start;
+	u8 *cur_addr;
+	u32 buf_len;
 };
 
-#define NR_XMITFRAME	256
+#define NR_XMITFRAME 256
 
 struct xmit_priv;
 struct pkt_attrib;
@@ -34,19 +34,17 @@ struct sta_xmit_priv;
 struct xmit_frame;
 struct xmit_buf;
 
-netdev_tx_t r8712_xmit_entry(_pkt *pkt, struct  net_device *pnetdev);
+netdev_tx_t r8712_xmit_entry(_pkt *pkt, struct net_device *pnetdev);
 void r8712_SetFilter(struct work_struct *work);
 int r8712_xmit_resource_alloc(struct _adapter *padapter,
 			      struct xmit_buf *pxmitbuf);
 void r8712_xmit_resource_free(struct _adapter *padapter,
 			      struct xmit_buf *pxmitbuf);
 
-void r8712_set_qos(struct pkt_file *ppktfile,
-		   struct pkt_attrib *pattrib);
+void r8712_set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib);
 void _r8712_open_pktfile(_pkt *pktptr, struct pkt_file *pfile);
 uint _r8712_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen);
 sint r8712_endofpktfile(struct pkt_file *pfile);
-void r8712_xmit_complete(struct _adapter *padapter,
-			 struct xmit_frame *pxframe);
+void r8712_xmit_complete(struct _adapter *padapter, struct xmit_frame *pxframe);
 
 #endif
-- 
Xingquan Liu


