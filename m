Return-Path: <linux-kernel+bounces-574039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43FDA6DFDD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3A67A7963
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43D3263C82;
	Mon, 24 Mar 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="pQF1AnL1"
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F8263C7D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834102; cv=none; b=p4nlbqTO15K2SAL/joTi+SbtUXOeBuurcCH9GyPPXnFESkG4T6B0wk+rfo98b5qy+mmJPYyW1CBkN6aK1ZSkpvVqLqbciFXyY45d656CvO9mlU2r6S2WerT4cM7uF2uCs1HPijad48hs+yoxTZ/h0aVxf9E1LLNqrb6vR78JRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834102; c=relaxed/simple;
	bh=2VKwLKmGkpdlcqWpdTlu23oo/O/asD2Au7MWuT1zRfs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bs5U/OElk5ihkbxeT3qi+Lef0S946BC6uzXeR6PBQkThAYdLA210lXt6rK9jCv2Y4s+g+Md2llEcpTBpGG0/4yIO4b7OuF5o1QHZI4BiwW6sncxuN5WC/ceMzLqfAtA20aUpNzAttKXKN2xtqo9rqV4x+wbuPBVpYc2oAxIPhQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=pQF1AnL1; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1742834096; x=1743093296;
	bh=cbW/EsJAuMcQQgCqI6Tdr4zGMRd9Zt3XpLehMUEoLmc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=pQF1AnL11/ENhlaHNLFaqjzEbbHX4vkdwUGrYJQBcI3ATBo++XTo9821F+lp3esZ6
	 p5qSjZJkkPM5V3nEyx5jX/oDTJVu/r43MB3S3G05zYgGtkJKOkFr469k2G6/iHqgMY
	 /tXF4fXOBqzE+fUI1iC0izPebovByI2o6mMam1AOdwi96l/BcdeN3Hepc+hcuLqJb7
	 9gmrgSlDOGPwn8YuOD9o9vFlsh4SLtUY9AA4KbrxK5A/xRHzrsUqlYoM9UnEFh7DXL
	 KgaxLCWZ+Vfp1umvtJDUjKuaCXEqeONspIdtbd3ZzJ5E6O5V2TzBV2J/VrkF2q/e+k
	 BT/6GTq7lNdtw==
Date: Mon, 24 Mar 2025 16:34:50 +0000
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH] USB: serial: ftdi_sio: Code style cleanup
Message-ID: <20250324163358.134541-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 3b940895cc1138ccce87b8db6a9d4ae75e968b3c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fix the following code style issues:
- Space before comma
- Missing blank line after declarations
- Superfluous space before statement
- Spaces used for indentation instead of tabs
- Misaligned block comment
- Space before tabs

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/usb/serial/ftdi_sio.c     | 16 ++++++++++------
 drivers/usb/serial/ftdi_sio.h     |  2 +-
 drivers/usb/serial/ftdi_sio_ids.h |  4 ++--
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 9b34e23b7091..60d24152e385 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -190,7 +190,7 @@ static const struct usb_device_id id_table_combined[] =
=3D {
 =09{ USB_DEVICE(FTDI_VID, FTDI_8U232AM_PID) },
 =09{ USB_DEVICE(FTDI_VID, FTDI_8U232AM_ALT_PID) },
 =09{ USB_DEVICE(FTDI_VID, FTDI_232RL_PID) },
-=09{ USB_DEVICE(FTDI_VID, FTDI_8U2232C_PID) ,
+=09{ USB_DEVICE(FTDI_VID, FTDI_8U2232C_PID),
 =09=09.driver_info =3D (kernel_ulong_t)&ftdi_8u2232c_quirk },
 =09{ USB_DEVICE(FTDI_VID, FTDI_4232H_PID) },
 =09{ USB_DEVICE(FTDI_VID, FTDI_232H_PID) },
@@ -1143,6 +1143,7 @@ static unsigned short int ftdi_232am_baud_base_to_div=
isor(int baud, int base)
 =09unsigned short int divisor;
 =09/* divisor shifted 3 bits to the left */
 =09int divisor3 =3D DIV_ROUND_CLOSEST(base, 2 * baud);
+
 =09if ((divisor3 & 0x7) =3D=3D 7)
 =09=09divisor3++; /* round x.7/8 up to x+1 */
 =09divisor =3D divisor3 >> 3;
@@ -1160,7 +1161,7 @@ static unsigned short int ftdi_232am_baud_base_to_div=
isor(int baud, int base)
=20
 static unsigned short int ftdi_232am_baud_to_divisor(int baud)
 {
-=09 return ftdi_232am_baud_base_to_divisor(baud, 48000000);
+=09return ftdi_232am_baud_base_to_divisor(baud, 48000000);
 }
=20
 static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base)
@@ -1169,6 +1170,7 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, =
int base)
 =09u32 divisor;
 =09/* divisor shifted 3 bits to the left */
 =09int divisor3 =3D DIV_ROUND_CLOSEST(base, 2 * baud);
+
 =09divisor =3D divisor3 >> 3;
 =09divisor |=3D (u32)divfrac[divisor3 & 0x7] << 14;
 =09/* Deal with special cases for highest baud rates. */
@@ -1181,7 +1183,7 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, =
int base)
=20
 static u32 ftdi_232bm_baud_to_divisor(int baud)
 {
-=09 return ftdi_232bm_baud_base_to_divisor(baud, 48000000);
+=09return ftdi_232bm_baud_base_to_divisor(baud, 48000000);
 }
=20
 static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base)
@@ -1211,7 +1213,7 @@ static u32 ftdi_2232h_baud_base_to_divisor(int baud, =
int base)
=20
 static u32 ftdi_2232h_baud_to_divisor(int baud)
 {
-=09 return ftdi_2232h_baud_base_to_divisor(baud, 120000000);
+=09return ftdi_2232h_baud_base_to_divisor(baud, 120000000);
 }
=20
 #define set_mctrl(port, set)=09=09update_mctrl((port), (set), 0)
@@ -1657,6 +1659,7 @@ static ssize_t latency_timer_show(struct device *dev,
 {
 =09struct usb_serial_port *port =3D to_usb_serial_port(dev);
 =09struct ftdi_private *priv =3D usb_get_serial_port_data(port);
+
 =09if (priv->flags & ASYNC_LOW_LATENCY)
 =09=09return sprintf(buf, "1\n");
 =09else
@@ -2194,6 +2197,7 @@ static int ftdi_probe(struct usb_serial *serial, cons=
t struct usb_device_id *id)
=20
 =09if (quirk && quirk->probe) {
 =09=09int ret =3D quirk->probe(serial);
+
 =09=09if (ret !=3D 0)
 =09=09=09return ret;
 =09}
@@ -2621,8 +2625,8 @@ static bool ftdi_tx_empty(struct usb_serial_port *por=
t)
  * WARNING: set_termios calls this with old_termios in kernel space
  */
 static void ftdi_set_termios(struct tty_struct *tty,
-=09=09             struct usb_serial_port *port,
-=09=09             const struct ktermios *old_termios)
+=09=09=09     struct usb_serial_port *port,
+=09=09=09     const struct ktermios *old_termios)
 {
 =09struct usb_device *dev =3D port->serial->dev;
 =09struct device *ddev =3D &port->dev;
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index 55ea61264f91..d671d2194c64 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -95,7 +95,7 @@
  *
  * The Purge RX and TX buffer commands affect nothing except the buffers
  *
-   */
+ */
=20
 /* FTDI_SIO_SET_BAUDRATE */
 #define FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE 0x40
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_si=
o_ids.h
index 52be47d684ea..3d9f6ed97783 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1022,7 +1022,7 @@
  * Kondo Kagaku Co.Ltd.
  * http://www.kondo-robot.com/EN
  */
-#define KONDO_VID =09=090x165c
+#define KONDO_VID=09=090x165c
 #define KONDO_USB_SERIAL_PID=090x0002
=20
 /*
@@ -1446,7 +1446,7 @@
 /*
  * Accesio USB Data Acquisition products (http://www.accesio.com/)
  */
-#define ACCESIO_COM4SM_PID =090xD578
+#define ACCESIO_COM4SM_PID=090xD578
=20
 /* www.sciencescope.co.uk educational dataloggers */
 #define FTDI_SCIENCESCOPE_LOGBOOKML_PID=09=090xFF18
--=20
2.34.1



