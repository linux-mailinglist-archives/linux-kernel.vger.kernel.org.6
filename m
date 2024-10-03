Return-Path: <linux-kernel+bounces-349489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F7F98F6E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC631C221D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10F01ABEAD;
	Thu,  3 Oct 2024 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SJ2Pq8Z7"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998141AAE0C;
	Thu,  3 Oct 2024 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982958; cv=none; b=K5WI/6TbDrAazAWt9UNahszixBkPF/dtitzeZRqi7IsL1IhhAjQEAn0TLWpXWy29BB32m4hnuDqG0qUYZIkeRc4Qh9yncr7/dzM60ivMZr/GlKZKcq43zziF5xlSmsc8cDH/In4n33YVNtHA0t3p3K98j+61XtMc4e7Hh/Ut4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982958; c=relaxed/simple;
	bh=AuV7jr56rgKXdA217F8aRGhBLc23+CUe4EUfjlTBVCY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KyddiiXtL6rX1pXu7EHDhZe63hJ7Ek0zGtwkk02yVItj63biYiq144MYQCju81+dby/3eo47hZIajeGM1Q1uDSiJqKNdmcZ5e9nGvotNQR4vGFW5s7lMfuB7Mqd2k59fL/kMHAnzBw5PGz46N4AllCyE16ZpXnszpkaLRGzG2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SJ2Pq8Z7; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727982947; x=1728587747; i=markus.elfring@web.de;
	bh=AaP0qWhGGgqVyRMzRZmYOxh81E6npbjdyrfjXu/1pB8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SJ2Pq8Z76afHD93q40L/p58/ED5FLkoHuS4k3BYHQt2ASJlB+8pP3rDAD+yQDGJP
	 mgmvPnv4yD/hwzhSvDjYRFOJBeWdw0RMsowfiCUA6rB3WtP/hguqQqZmtN1hfVMQC
	 1+rTVi8/e6+5wvyFA/s9IQcGXn+xmGC33aQx2Vny3Ql2O5ejDOJM7QbSelIDv4ZX7
	 YP/vY9HyKc78IbNRWj95jWEsc7FdpH3pSwLnh1tKoZmdxSoffxEPbQOW2WNM+OCsU
	 6wJUirOZ/BR2FJoYwETQkKhTYJ573VCD+HB1C0bh3vJgve7HXDY4IKd1cUYDtjjdi
	 Nt6jbjmGZMkJpA1cMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmhjw-1sCcQ11fOw-00kOTx; Thu, 03
 Oct 2024 21:15:47 +0200
Message-ID: <189b93e2-4e81-438d-9c77-cbe4d9d7a0d9@web.de>
Date: Thu, 3 Oct 2024 21:15:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Johannes Berg <johannes@sipsolutions.net>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] macintosh: Use common error handling code in
 via_pmu_led_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xF2I4rW6AIKfWOc/S3lQWWNGf0PtzYaiK1MvvYtpD8mYytLpCm7
 OMzdbD/ZVw8qOeweyX6aLZ0/oOH1BX9xPTfu9SZVnieWGUGzXfqpyPvsGr8Gz1/sC71P4/J
 eMnn9EFTJ7HB1FXqVjPIXLVgfYVJKO948lmgZpxa8uinsbzNNV1NMe1T932S+gedPxEGWpu
 WkLgPXkiCx9LxlpqECP5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q9w2VK3Frdg=;TCpeb/UB/P4yquJ0czLNBRasXX3
 C6QTxf007WG66fhad2u5iiJUsp81HPEDTAom+/9zHjUpvF/j1UsMynR26V7BLBqPhRd3Iz31Y
 foE5533Ue4O8jqVLK3kbBr1YEUvugNTCkORQ6lSN3LPSv74n9FAETg3NXnnGEri9VkH/CH7Ga
 bEvy36kr70igJbVU4/vRdGmG2c01yr2baQ01r8tpTjywpla5F9xHVPSK+Idclx2uws/MFi8nX
 6RfcK+h8VZQO5hikb32Yhurw+SVNw4j4v0IWYdg+dOJK/DaCOHbywajJlNxByce6pfxdOGNE/
 6Tm4YPVaMf6K6BCsWxDWtn6BsXiGjzhwcQ80ot1lYNlYS+QMD8p+M2izXZX6CIue8JiAsPMww
 2CEmO0teyN6aDzaomwIDqVw7AQZPT2AyRFYoM46WwKAkFzSCOMxdz+5+oQvMB1BS4fUbdIjrv
 gYWJvklyR5tvRYdt/u8LFgVYJUAk3ZA/wog1V5Fy5K5V0spfRIKFgjTpVgs+rx28z/ntfKtOg
 5enN47GIsBEFxqXz2XZr1Dcedr6hZTGznVm8rywJYIoDy84mSRZf4VCIH+V1p4knPAgTTBV4M
 zSwXT9ERquWwwULCjfk0mmVRk14etXLVuIGhrJm/nb76umGK0qSej+fAUUa97/yuUkzbShS86
 oQ6FgkJkSCWcfkcYujCe1ER6NII8f/EDaSt6i0ZeoAq4R/rtgxmShPvKaJQzfeB0vAtElQwWn
 cBoIJHF2vRpRMuCv5xjj3fNgPbYSAVpJWt5iqD4n8wyHCTHtDdCmocE60tFDuYGcRQaGzwcdn
 pYmTwKKTZCFYyFVjTk27pA3A==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 3 Oct 2024 21:06:42 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/macintosh/via-pmu-led.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/macintosh/via-pmu-led.c b/drivers/macintosh/via-pmu-l=
ed.c
index a4fb16d7db3c..fc1af74b6596 100644
=2D-- a/drivers/macintosh/via-pmu-led.c
+++ b/drivers/macintosh/via-pmu-led.c
@@ -92,18 +92,15 @@ static int __init via_pmu_led_init(void)
 	if (dt =3D=3D NULL)
 		return -ENODEV;
 	model =3D of_get_property(dt, "model", NULL);
-	if (model =3D=3D NULL) {
-		of_node_put(dt);
-		return -ENODEV;
-	}
+	if (!model)
+		goto put_node;
+
 	if (strncmp(model, "PowerBook", strlen("PowerBook")) !=3D 0 &&
 	    strncmp(model, "iBook", strlen("iBook")) !=3D 0 &&
 	    strcmp(model, "PowerMac7,2") !=3D 0 &&
-	    strcmp(model, "PowerMac7,3") !=3D 0) {
-		of_node_put(dt);
-		/* ignore */
-		return -ENODEV;
-	}
+	    strcmp(model, "PowerMac7,3") !=3D 0)
+		goto put_node;
+
 	of_node_put(dt);

 	spin_lock_init(&pmu_blink_lock);
@@ -112,6 +109,10 @@ static int __init via_pmu_led_init(void)
 	pmu_blink_req.done =3D pmu_req_done;

 	return led_classdev_register(NULL, &pmu_led);
+
+put_node:
+	of_node_put(dt);
+	return -ENODEV;
 }

 late_initcall(via_pmu_led_init);
=2D-
2.46.1


