Return-Path: <linux-kernel+bounces-574464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A61DA6E5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59463B90A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717D81EEA34;
	Mon, 24 Mar 2025 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="dUzln99c"
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514D21EDA1E;
	Mon, 24 Mar 2025 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851119; cv=none; b=WaIDaW4qZX1TqSsSYFttoYYDw199/Ep+KHWf4RKj9iWkZ/eJGix7vSYF42xhyv+7PgIKYxEE0VoYuDATf0koxDTljEuOJRrNhUdDRpFd19HqTNW4JnijgEKzV5lYU6sDB5zeY4DDEf+IQhpG5DntXPFTHAEfIgJQfbEllE/dQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851119; c=relaxed/simple;
	bh=GNu+kahqRURr3jBKGFOwVS7xGN4jr0+9cKSPvRimRUQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzLRWobammrOpzXv2X3Z+ElPtSq0fv/Rrv3Tpc6Ilvr37L5HHQfEncWEPRhkCGKG7m26ZheiaynOGh6tIA8zaHTQ9ecRZV11m7V5UIwz05g+S4jM4Ha6VzAZy2xMftxavwrO37gsZ+lg/5FTC39Kx8ADWdGRulcTsnPuJaDTmQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=dUzln99c; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1742851115; x=1743110315;
	bh=u5mBsTab4mA8udrpnBydbaZhEo5uyqSSg9IwaotnLuw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=dUzln99cYsduJc1JPJFs2t9R6DdFA0hQLoznShP70y3KJlwftbbP7EIzpByVkJwn6
	 Q5XY3uTwo3UI/FORzd95Ox/MOM7R2TPGlYl0Szr+9ntJzQEgIplO3t1/9mRsGSKnrn
	 o1a+eiVtR2UCk7RNsUguNK9W16/NOlDFR1hcce4wVRqAWNN4Qre/GCqYDwqQswqsa7
	 1U9TN5z/XY38U7yDUoVj+z6orukqQ/kDgxzCcIrDZBOtDXyw0Y6jIUgKQtMwBfXvfg
	 +wBQgnWcpQ5b/JzDnb2GN4iuqkUhQ9tuGAKa1LKWu+3vgnZ1tNdGrArlC4NxL4PC2H
	 IwoNaedSUlnbg==
Date: Mon, 24 Mar 2025 21:18:28 +0000
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 6/6] USB: serial: ftdi_sio: Remove space before tabs
Message-ID: <20250324211619.166988-7-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20250324211619.166988-1-dominik.karol.piatkowski@protonmail.com>
References: <20250324211619.166988-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 267b8bb410963ff7234fc5380080453abd6773c9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Remove superfluous space before tabs in defines to align with code
style.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---

v2: Split the patch into smaller patches

 drivers/usb/serial/ftdi_sio_ids.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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



