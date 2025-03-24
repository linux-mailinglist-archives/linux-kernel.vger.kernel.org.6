Return-Path: <linux-kernel+bounces-574460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DCBA6E575
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B718A7A90B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2B71E7C27;
	Mon, 24 Mar 2025 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="gqWnkaWI"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8091E5B74
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851094; cv=none; b=KPTFB1NftwnYO4NXcfUQ4qvEW5c+vQPGnOIIb5wzt5albQCW172KfJTkKcp+1aFcsKm0t2WDTXm4UjZbi63N/1ZuyXn+OcaD0XnDOwRwMK6m8UVHwNvN22BQso4R27fsnl6PsydxBJFRV9BTQ1AV8b8laj41M42zd2f5undZGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851094; c=relaxed/simple;
	bh=8TaE4U50cKnetEE5qxz8et9q1kplSCeKNx9UK6JRhnk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3XGs/pqy7xK5f7BipfSxzdG8UTZoiaAc/hnCbFfU7dspR8/N2nLFHuclIcZF84kWD6GERx7L8zo/E6B5Ec+cpl+YyU5zm0Afl4EeLycPc4iV2zwR4I2t5IYENbBYv2lSRZLnuVjfcSATf2xwuSRc8rtJPy+wuvV+HQzU4ERYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=gqWnkaWI; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1742851091; x=1743110291;
	bh=8TaE4U50cKnetEE5qxz8et9q1kplSCeKNx9UK6JRhnk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=gqWnkaWINhc6yRB5BWG9DYOF6JBZrcoDghNGk56Gju/QKP5yXrkavchSNHM42cOFX
	 I8sV4cnfXqRQESM+5m0lGEzUEtUlcsr9mnjXn1ull+nrKqcotXjS+zhh88V+l+xSJB
	 ix5qONyIrmsYtEBBYqlypw+3L1OKBiCE2CUM79Qr9me5j5AcTJ/M7fASqBosnobLjH
	 uYfrVbo0IvVaRFQeyG9bSe7yrmi4V9dJQsfSjQkFhpKksKwds/sS6yWwwcCHuvSvOj
	 kMvhx73BU8AlyDbf6aB7fihDLLNxvCulcYtpQrFt2bkHOu3s/F2DOlBHcK2Zvjrw81
	 FZ3PEKn0sCkZw==
Date: Mon, 24 Mar 2025 21:18:05 +0000
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 2/6] USB: serial: ftdi_sio: Add missing blank line after declarations
Message-ID: <20250324211619.166988-3-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20250324211619.166988-1-dominik.karol.piatkowski@protonmail.com>
References: <20250324211619.166988-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 2cc22b6904aadb9a9bfc88129c82814e67c89874
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add missing blank lines after declarations to align with code style.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---

v2: Split the patch into smaller patches

 drivers/usb/serial/ftdi_sio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b02dbe4ec1e4..f52bab3a3bfd 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1143,6 +1143,7 @@ static unsigned short int ftdi_232am_baud_base_to_div=
isor(int baud, int base)
 =09unsigned short int divisor;
 =09/* divisor shifted 3 bits to the left */
 =09int divisor3 =3D DIV_ROUND_CLOSEST(base, 2 * baud);
+
 =09if ((divisor3 & 0x7) =3D=3D 7)
 =09=09divisor3++; /* round x.7/8 up to x+1 */
 =09divisor =3D divisor3 >> 3;
@@ -1169,6 +1170,7 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, =
int base)
 =09u32 divisor;
 =09/* divisor shifted 3 bits to the left */
 =09int divisor3 =3D DIV_ROUND_CLOSEST(base, 2 * baud);
+
 =09divisor =3D divisor3 >> 3;
 =09divisor |=3D (u32)divfrac[divisor3 & 0x7] << 14;
 =09/* Deal with special cases for highest baud rates. */
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
--=20
2.34.1



