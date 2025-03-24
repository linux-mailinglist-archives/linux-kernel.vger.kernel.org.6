Return-Path: <linux-kernel+bounces-574461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A232A6E59C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84520189015A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF23C1F09B4;
	Mon, 24 Mar 2025 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="w9fGzG56"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE9146A6F;
	Mon, 24 Mar 2025 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851100; cv=none; b=QM5g2IcsmK3fLKpEa7v8bY1mZXEaApRbkxL5Yr29r7oEhHMe1H7mpu9CW8iKeGoBZlcjSHWlkexymoS5EqLVgeUNJ9lICYLcfzTlg+VNMdqRuR3IG+Vc2vp3b2PfryBttDg9KYaavuKLh07O66AZaFyuYfSGetJ6wa8iyYr4Dio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851100; c=relaxed/simple;
	bh=tmMoYs9RIJY8JE+MjASDE7DvS+BS0lXX6Gh/vx2/yys=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwkJ4AvywVY33HnW6SDk6kegTwZjAdxSfhiaoEVCBkFLbNBu3SMpXGL/yU7Ypg8Jjs8fuReVt0FDM8Kd6cryI9SVcSlUJbOxU2hh0otaiK+CGDrlbrX9csyyKFxhvueFifdOqueMKfA9WlC5FeakVS3+Zpbvxe14AtNklMulNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=w9fGzG56; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1742851096; x=1743110296;
	bh=tmMoYs9RIJY8JE+MjASDE7DvS+BS0lXX6Gh/vx2/yys=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=w9fGzG569gZXLeUNCZ1+ABmCZOafGA7fXaRxUSkHCnDiv+E7KP+GAi9fa5CBikOmR
	 dKjzEft6nCTWkW8iCMXqcsvNZTSVdSqbqNV3vD4BenoMeBFij4ykHiCidqC7mNvyJT
	 dp/qJ9tqTML8bBSVjCuYSqrk/SZ4PTtNrzOH0lFndLVLZDSjwtimIypGU15HIhoLy1
	 7y8GVM7QrGyCoyVDQAiRPh1qN1Evsz7n3wHqJsVmRoYZXLvb6ZAWF6F241K06e/ero
	 Mjr9w0LVhaflMEBfn3pNTTRlQoJyU9l4LYPW61gg7QR2dqzQiZ4BENXcqz9ek0ecT/
	 tBp3vdhhuBTDw==
Date: Mon, 24 Mar 2025 21:18:10 +0000
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 3/6] USB: serial: ftdi_sio: Remove superfluous space before statements
Message-ID: <20250324211619.166988-4-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20250324211619.166988-1-dominik.karol.piatkowski@protonmail.com>
References: <20250324211619.166988-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: d07a497be88fc4b6374d85bf1ea6557b561e01ef
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Remove superfluous space between indenting tabs and statements to align
with code style.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---

v2: Split the patch into smaller patches

 drivers/usb/serial/ftdi_sio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index f52bab3a3bfd..c2b9b8edcc8e 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1161,7 +1161,7 @@ static unsigned short int ftdi_232am_baud_base_to_div=
isor(int baud, int base)
=20
 static unsigned short int ftdi_232am_baud_to_divisor(int baud)
 {
-=09 return ftdi_232am_baud_base_to_divisor(baud, 48000000);
+=09return ftdi_232am_baud_base_to_divisor(baud, 48000000);
 }
=20
 static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base)
@@ -1183,7 +1183,7 @@ static u32 ftdi_232bm_baud_base_to_divisor(int baud, =
int base)
=20
 static u32 ftdi_232bm_baud_to_divisor(int baud)
 {
-=09 return ftdi_232bm_baud_base_to_divisor(baud, 48000000);
+=09return ftdi_232bm_baud_base_to_divisor(baud, 48000000);
 }
=20
 static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base)
@@ -1213,7 +1213,7 @@ static u32 ftdi_2232h_baud_base_to_divisor(int baud, =
int base)
=20
 static u32 ftdi_2232h_baud_to_divisor(int baud)
 {
-=09 return ftdi_2232h_baud_base_to_divisor(baud, 120000000);
+=09return ftdi_2232h_baud_base_to_divisor(baud, 120000000);
 }
=20
 #define set_mctrl(port, set)=09=09update_mctrl((port), (set), 0)
--=20
2.34.1



