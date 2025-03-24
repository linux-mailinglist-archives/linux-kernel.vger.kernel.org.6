Return-Path: <linux-kernel+bounces-574459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD03A6E598
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE971886B77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8613D1EF0B9;
	Mon, 24 Mar 2025 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="W7Ez4bHU"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E61DF971
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851087; cv=none; b=g7jqHAPK3342BFJED4tftc0IPSRT6Tn0TT4IDeqOa0aCJ+9Pgd4kCMDL+U7Bb52DYo/N0ny1AIfzKKa8JcbUK99AMlTOapLED41iEtg1KIRVnvX1XUNCVrxu8dleBNKu+NMKcfmkv12y6CHJXy+Rp9EPOUK1OnYMSFQUQzDrw9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851087; c=relaxed/simple;
	bh=hyU4NSwdZyi1ic0q6erpOYIB7qc2G4+0kHu3Htlz0kk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HaZdnhg1YDN+UBCtZtEuIlIg74De25SUhwBopOmRoT6hEbLqd8Pl5/exfGmOAIM0VCs/bevhi5PLdWq4c/3oGvB1il2nBZi+/DpOKHPA2ARCWDC+cJdh39OxzEALL2+7icotKbLpbwZdDKV1nksH/mJSkl/ljiDLkye7q+GPXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=W7Ez4bHU; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1742851083; x=1743110283;
	bh=hyU4NSwdZyi1ic0q6erpOYIB7qc2G4+0kHu3Htlz0kk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=W7Ez4bHUgW4cCXmHOSrCGHeT7RA5ZNpShpijrwdjhIbjVEtfocE5SoHri02VD27Rq
	 NAmqP0kM7lifKuabGrUKM5llvxAp4gz1unx3t9FYkduLDN8a9bBqi5rXAk6nliLYJD
	 l7fsmXzIys7f9raiC9ZAt4wrJ/oB6N0BLNtJcWq9unvliuV2R4HQVPz30cYhnEKY3q
	 NVV4l/+tHnH2ICmBnVZWGPkS1ipKzAh+KUQl7oHgSNQx3I+qRM2pyOJirtwv1ggCbY
	 cj++iKoHJJNg/Lx0S2YaVAF3sI6toHkwtqYzIiKnjTy7XhCcTzdU4Qp48rXT7pz0Qu
	 0aNHWgDzAvSgw==
Date: Mon, 24 Mar 2025 21:17:58 +0000
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 1/6] USB: serial: ftdi_sio: Remove space before comma
Message-ID: <20250324211619.166988-2-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20250324211619.166988-1-dominik.karol.piatkowski@protonmail.com>
References: <20250324211619.166988-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: e873e2e09d8075b23ce32c0b9a07c8deab478cba
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Remove the space before comma in id_table_combined to align with code
style.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---

v2: Split the patch into smaller patches

 drivers/usb/serial/ftdi_sio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 9b34e23b7091..b02dbe4ec1e4 100644
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
--=20
2.34.1



