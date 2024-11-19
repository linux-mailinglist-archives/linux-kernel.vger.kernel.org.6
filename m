Return-Path: <linux-kernel+bounces-414333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB039D2664
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6458A2836AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904CC1CCB5E;
	Tue, 19 Nov 2024 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=turris.com header.i=@turris.com header.b="RExPBm/R"
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3771CCB2C;
	Tue, 19 Nov 2024 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.31.204.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021597; cv=none; b=rWt6sgA8LzxO6ULfdODCjHhTXDz79TjUn2utd0/4iHiuDrsntyEprKjTXzJsryaGzq7RjGVhCdBBZHPEk6kqQ4qo2FRkwlh+mQfHczvEuSK0R8i9w6VFJhGwW8TmLnAy15nxGfXeYiz5/M9AIpzyMhNNWxZl4VE5JiDECXXYeYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021597; c=relaxed/simple;
	bh=JtWIzyY/2ym9dryXGJVbXWARmJW5m80KEY9YH8YDy4A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rEsDByjtjB9KaejNupKypbbC0bTWPsokSIxs7bX25jMsYrk0DQAEOL31bfbZBKapyk6cIG9bCtwZYqXDvCzSQX8IyUlJrFcWFMoHejAgyNJ3tNVraE5cFsl9HqHD+xQWKAumo7irulg7OMyLMReFbBGqdFpbq57IE9MQtOncBIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=turris.com; spf=pass smtp.mailfrom=turris.com; dkim=pass (1024-bit key) header.d=turris.com header.i=@turris.com header.b=RExPBm/R; arc=none smtp.client-ip=217.31.204.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=turris.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=turris.com
Received: from localhost (unknown [IPv6:2001:1488:fffe:6:1e96:d231:26b0:9350])
	by mail.nic.cz (Postfix) with ESMTPSA id 4AFEA1C12EA;
	Tue, 19 Nov 2024 14:00:19 +0100 (CET)
Authentication-Results: mail.nic.cz;
	auth=pass smtp.auth=michal.hrusecky@nic.cz smtp.mailfrom=michal.hrusecky@turris.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=turris.com;
	s=default; t=1732021219;
	bh=JtWIzyY/2ym9dryXGJVbXWARmJW5m80KEY9YH8YDy4A=;
	h=Date:From:To:Cc:Subject:From:Reply-To:Subject:To:Cc;
	b=RExPBm/R+/c+FYSRhBVHrHg7HFgQcd+dIWAeflNaflwSNpYCrHDAGsMnp3Bo/ejzH
	 YLmjvNmSQ9+jomw3+dlcKI26AC8L6/53sJOxzpOiW0T9H2tqgC7o3bZx5QkpZXEHV6
	 qIDWP9eUwLiSgOYUnfzAZ8qB4qzcgYW7/v+R2TiM=
Date: Tue, 19 Nov 2024 14:00:18 +0100
From: Michal Hrusecky <michal.hrusecky@turris.com>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: option: add MeiG Smart SLM770A
Message-ID: <6uel66cvf2cn2jenpoc43usee3pwnmtaerqnpfl7tnoa6s5mff@5xxrpbabupah>
X-Operating-System: Linux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action;
	module=multimap;
	Matched map: WHITELISTED_IP
X-Rspamd-Server: mail
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 4AFEA1C12EA
X-Spamd-Result: default: False [-0.10 / 16.00];
	MIME_GOOD(-0.10)[text/plain];
	WHITELISTED_IP(0.00)[2001:1488:fffe:6:1e96:d231:26b0:9350];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[]

Update the USB serial option driver to support MeiG Smart SLM770A.

ID 2dee:4d57 Marvell Mobile Composite Device Bus

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2dee ProdID=4d57 Rev= 1.00
S:  Manufacturer=Marvell
S:  Product=Mobile Composite Device Bus
C:* #Ifs= 6 Cfg#= 1 Atr=c0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=03
I:* If#= 0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=88(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=4096ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0e(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Tested successfully connecting to the Internet via rndis interface after
dialing via AT commands on If#=3 or If#=4.
Not sure of the purpose of the other serial interfaces.

Signed-off-by: Michal Hrusecky <michal.hrusecky@turris.com>
---
 drivers/usb/serial/option.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 4f18f189f309..31b3d007750c 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -624,6 +624,8 @@ static void option_instat_callback(struct urb *urb);
 #define MEIGSMART_PRODUCT_SRM825L		0x4d22
 /* MeiG Smart SLM320 based on UNISOC UIS8910 */
 #define MEIGSMART_PRODUCT_SLM320		0x4d41
+/* MeiG Smart SLM770A based on ASR1803 */
+#define MEIGSMART_PRODUCT_SLM770A		0x4d57
 
 /* Device flags */
 
@@ -2376,6 +2378,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM770A, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },
-- 
2.47.0


