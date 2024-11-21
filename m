Return-Path: <linux-kernel+bounces-417300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0669D5233
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C08C283249
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5079D1AAE06;
	Thu, 21 Nov 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="B3tAmkmn"
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E096CDAF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732211957; cv=none; b=XzNQ2sOsFvXbIm+wGOs+obF7jSBRdzUVv2l6sC4pZCi8WlweHKVp5hndx1HbPewMK0o1THgn7poRzxj9LwpwSadYqsU6ToyuEr8zng5R70cbLAtXbkeNCVPXUB0KHwoheM/2ZkxkrOvG33yHGIOAorGMRs01aNxdbR7rZdav8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732211957; c=relaxed/simple;
	bh=ClE+5TJLmK6yj9O5XdCVALxnETZTAapG9G+AOIgVqmw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyg084LQzwkKmWIwxWjtOMIUocT4i5BdQXYYy4fsfHPDYCjM628kXZjCc9ndAOM9XTozrPWRNNlld6jD02oRI7JF0Tg/FTj4sfBR0BnAwDrhkzzqzNCqCof40V+JxBH3eRXL8fLGiBu1RnGvy01qvEcP1xuOmDMun2CKMWAgSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=B3tAmkmn; arc=none smtp.client-ip=185.70.40.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1732211947; x=1732471147;
	bh=S2adombCveWtynb5JK0rPvmIBtpUZOSmldP70Ex5d0Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=B3tAmkmn30hNi1bn1F5Sh6/HBzPiinlYacSlPF184+1L2/6ZSYbg5JCVKTwFk4erR
	 8+pkiP6kez1+NripJ8u1bvSdKJW1yb3M3usnwB6Q2odXnk8xNwhOGn5e8aQEOVEPNy
	 zvpcF3W1XGR2qMdBhC4D0sEl2KbvYs6y366J7TLFwR2jopB6allcoBEpMP+qviTCKK
	 /v8lYIm23wVtHABpCTGwJXdDxtZC/jVe3fsc4QsN7fa77kGC9N2grYqJve1XDX8kYy
	 iyxVL9qJaFAEzwN8UvUYK/0IDnKBwHJ1dJ25lJIyc2tZil6PpIKFSImFVfG7IHEluK
	 ulz5fxqyYqxHw==
Date: Thu, 21 Nov 2024 17:59:02 +0000
To: greyxor@protonmail.com
From: Gregoire Stein <greyxor@protonmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [PATCH] Bluetooth: btusb: Add one more ID 0x0489:0xe10a for Qualcomm WCN785x
Message-ID: <20241121175851.137414-1-greyxor@protonmail.com>
In-Reply-To: <20241121163259.180589-1-greyxor@protonmail.com>
References: <20241121163259.180589-1-greyxor@protonmail.com>
Feedback-ID: 1917010:user:proton
X-Pm-Message-ID: d4108b9efbb2f7bde0c3c87748ef9a971eb360db
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add an additional entry with ID (0x0489, 0xe10a) to the usb_device_id
table to support the Qualcomm WCN785x.
The device information from /sys/kernel/debug/usb/devices is provided below=
:

T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D04 Cnt=3D01 Dev#=3D  2 Spd=3D12   Mx=
Ch=3D 0
D:  Ver=3D 1.10 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D0489 ProdID=3De10a Rev=3D 0.01
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 7 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  65 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  65 Ivl=3D1ms

Signed-off-by: Gregoire Stein <greyxor@protonmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..b52552a5c13d 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -377,6 +377,8 @@ static const struct usb_device_id quirks_table[] =3D {
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
 =09{ USB_DEVICE(0x13d3, 0x3623), .driver_info =3D BTUSB_QCA_WCN6855 |
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
+=09{ USB_DEVICE(0x0489, 0xe10a), .driver_info =3D BTUSB_QCA_WCN6855 |
+=09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
=20
 =09/* Broadcom BCM2035 */
 =09{ USB_DEVICE(0x0a5c, 0x2009), .driver_info =3D BTUSB_BCM92035 },
--=20
2.47.0



