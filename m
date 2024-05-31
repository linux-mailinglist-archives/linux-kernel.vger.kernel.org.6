Return-Path: <linux-kernel+bounces-196194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F398D58AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB8A2864E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC9078C65;
	Fri, 31 May 2024 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZsV4HLbj"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7280C1F16B;
	Fri, 31 May 2024 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717123238; cv=none; b=o2WMntQwFqRuXK2YFT8V03A0/Jex3baqBEHpoQJxNEcYnVBXcKLz+wzFP0ct4YaomnnQpuVGMIpj36EkBLFzsGylqh4eFjBiOnKrcOrfpBvInj99H8jH7aO71UCY7Epmzmn8dVHIKekdBXur+ddcDokBefYb2Rhb6yK5271RRTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717123238; c=relaxed/simple;
	bh=bW3j1tAHqoJskcl9nEteT2/AIXwPqPy+9qQ/vXBYs6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YLajmXLuEJB/mzYBvN5LM11iC8sLWzi8lNvlGJyw5pGv3vYX0n5t7IN7isMpMrnWSINs9g3RUiBzruy0X58V3rQ3cdmsoOpy0zWF88Y8wiOPxGyRwAzyVG4yvC8gdXNGVg0aLdoE2uR/7lgRNAeH+Tghy8U1M3Ct9vJFERBjedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZsV4HLbj; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=scfQE
	T7TC4rP+X2eKiDLC21w14Yps502yz+OGN7LpD8=; b=ZsV4HLbj1XUkRF/Ww+f2z
	VPG1S5LejQi7gHvXoYYsiLnzy/BZnWeozqtyPJK1JxZvXDJbmbLTF844Tme2rWE8
	v/bGv7D42O4mbh0JEEMXkx66klmr+2T/7meGgLCnJpzrlOQJk3MBCpoFB4jGGN6+
	DvRgm3OtzgA7U9DWJEBhj8=
Received: from smtp.163.com (unknown [124.89.89.114])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDnz9CPOFlmSUZSGg--.56948S4;
	Fri, 31 May 2024 10:40:15 +0800 (CST)
From: Vanillan Wang <vanillanwang@163.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vanillan Wang <vanillanwang@163.com>
Subject: [PATCH] USB: serial: option: add Rolling RW350-GL variants
Date: Fri, 31 May 2024 10:40:12 +0800
Message-Id: <20240531024012.29805-1-vanillanwang@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnz9CPOFlmSUZSGg--.56948S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr1kXry5GF48KFW7KrW5Awb_yoWrGF4DpF
	4fAF4SqFZ5XF15XFnFkF18ZayrK3Z3Wr17CayUAw4FqFWxAws7tF1UA3yxWr1q9F4Syr4q
	q398G3y8Ga97KFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pReHqwUUUUU=
X-CM-SenderInfo: pydqxz5odq4tlqj6il2tof0z/1tbishDvUmVODbxG9gAAs1

Update the USB serial option driver support for the Rolling
RW350-GL
- VID:PID 33f8:0802, RW350-GL are laptop M.2 cards (with
MBIM interfaces for /Linux/Chrome OS)

Here are the outputs of usb-devices:

usbmode=63: mbim, pipe

T:  Bus=02 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
D:  Ver= 3.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
P:  Vendor=33f8 ProdID=0802 Rev=00.01
S:  Manufacturer=Rolling Wireless S.a.r.l.
S:  Product=USB DATA CARD
C:  #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=896mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms

usbmode=64: mbim, others at (If#= 5 adb)

T:  Bus=02 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  5 Spd=5000 MxCh= 0
D:  Ver= 3.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
P:  Vendor=33f8 ProdID=0802 Rev=00.01
S:  Manufacturer=Rolling Wireless S.a.r.l.
S:  Product=USB DATA CARD
C:  #Ifs=10 Cfg#= 1 Atr=a0 MxPwr=896mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=82(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
E:  Ad=05(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=06(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=07(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=88(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=08(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=09(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=8a(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms

Signed-off-by: Vanillan Wang <vanillanwang@163.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 8a5846d4adf6..039180f32795 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2321,6 +2321,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0115, 0xff),			/* Rolling RW135-GL (laptop MBIM) */
 	  .driver_info = RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0802, 0xff),			/* Rolling RW350-GL (laptop MBIM) */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
-- 
2.34.1


