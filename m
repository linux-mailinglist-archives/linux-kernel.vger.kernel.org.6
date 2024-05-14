Return-Path: <linux-kernel+bounces-178556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE08C4FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4D62830D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D628012EBEF;
	Tue, 14 May 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="chr2+39c"
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88173433BE
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.41.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715682349; cv=none; b=bwkYzfTXch7muX9SWqBKbBXUSWfRQB1POfpPLnlCRGCU9Dbv3cOFJsvtttFIzCQbmfYuQTinKyGR7sIATpdy9s08duM1vV5rSed7M0O9FRE7O6fyZ47buZWGG7KrYsaW5+EpEkff22ELga8CtApiD1kE2TgAMYLU53lEnHm45Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715682349; c=relaxed/simple;
	bh=JDcLhSCJdrn8ZStEd9rRtRGA5OR51AVhThaD9Deeyrk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qB/s5N6ixwIvPdtozAHcMx3epUpXv/brK9p5u1E7htX/9hqSlcQagtpY1vdT7kmo22NaXFqZG6M3QBxsgESzQ1ysIPLcwnv9xi82Ohq2XpOKSIc1IZ+ZuZ5PRSAh5ND9jx+WHJ+f3gM1HPD1U47zuMIIxpSCovedauY5suHWLYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=chr2+39c; arc=none smtp.client-ip=185.70.41.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1715682328; x=1715941528;
	bh=R1qRONO5MU7vQIWaRDZy5P0Ke0gMSK5+59BZXhIZp+I=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=chr2+39crLvbp2O7tVV0J3qAPmkfjIviNI7jX4u0FNE5G8nw8guIXLjSNA2+H+NKk
	 eH3fef4sP0PbeQxf+bo3rEI4fgmzXQcn2qk/oqlVhlMmEvYOsW0oEoI3uPxBed+PY+
	 ysASk3HK68o7xzCLspiQS2GbMMjBMfAOZ+S/mdarw1CN64aWkOU6ziDfeBEfdASyUW
	 xV1sh3uLecsdafYeT6cx9IlAGgIakLmSSSZwI0wwobCfggEZcyjAhK8SW9jtjcRZRA
	 D4xAsDoKGxeM4jDwSYqDnupE9LtnM5IZpAVVLziuDJtLIOrw/750K33Snq72KGh9N5
	 C2Pb8cICjoQSw==
Date: Tue, 14 May 2024 10:25:24 +0000
To: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
From: "SoloSaravanan@proton.me" <SoloSaravanan@proton.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Bluetooth: btusb: Add device 13d3:3606 as MT7921 device
Message-ID: <sp2Jnio8wbTlQGoA5ti6LOAwDtdur_uZqdZYbXJL8wXHF0h_GVTL8Fr_b9oqmYVl2y7jeT-CgNt5Neg-RWjyKs4LXfKsg_uN_YO0_NFOxmQ=@proton.me>
Feedback-ID: 84438951:user:proton
X-Pm-Message-ID: 430f707f918da3149934227d4b45508d9013ac00
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From 6c5cec6d7a84c140958786bcb082d94f1b147ece Mon Sep 17 00:00:00 2001
From: SoloSaravanan <SoloSaravanan@proton.me>
Date: Tue, 14 May 2024 15:01:29 +0530
Subject: [PATCH] Bluetooth: btusb: Add device 13d3:3606 as MT7921 device

Add VendorID 13d3 & ProdID 3606 for MediaTek MT7921 USB Bluetooth chip.

T: Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D09 Cnt=3D03 Dev#=3D 4 Spd=3D480 MxCh=
=3D 0=20
D: Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D 1=20
P: Vendor=3D13d3 ProdID=3D3606 Rev=3D 1.00
S: Manufacturer=3DMediaTek Inc.
S: Product=3DWireless_Device
S: SerialNumber=3D000000000
C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
A: FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01=20
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb=20
E: Ad=3D81(I) Atr=3D03(Int.) MxPS=3D 16 Ivl=3D125us
E: Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E: Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 0 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 0 Ivl=3D1ms
I: If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 9 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 9 Ivl=3D1ms
I: If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 17 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 17 Ivl=3D1ms
I: If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 25 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 25 Ivl=3D1ms
I: If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 33 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 33 Ivl=3D1ms
I: If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 49 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 49 Ivl=3D1ms
I: If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
btusb
E: Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D 63 Ivl=3D1ms
E: Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D 63 Ivl=3D1ms
I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E: Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 64 Ivl=3D125us
E: Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 64 Ivl=3D125us
I: If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=3D=
(none)
E: Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
E: Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us

Signed-off-by: SoloSaravanan <SoloSaravanan@proton.me>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index effa54629..65e4b7fc6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -615,6 +615,9 @@ static const struct usb_device_id quirks_table[] =3D {
 =09{ USB_DEVICE(0x0e8d, 0x0608), .driver_info =3D BTUSB_MEDIATEK |
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH |
 =09=09=09=09=09=09     BTUSB_VALID_LE_STATES },
+=09{ USB_DEVICE(0x13d3, 0x3606), .driver_info =3D BTUSB_MEDIATEK |
+=09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH |
+=09=09=09=09=09=09     BTUSB_VALID_LE_STATES },
=20
 =09/* MediaTek MT7922A Bluetooth devices */
 =09{ USB_DEVICE(0x0489, 0xe0d8), .driver_info =3D BTUSB_MEDIATEK |
--=20
2.45.0



