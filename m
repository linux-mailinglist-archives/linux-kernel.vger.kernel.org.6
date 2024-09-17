Return-Path: <linux-kernel+bounces-331695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E586097B02A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 14:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB511F24178
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BCB16D9BF;
	Tue, 17 Sep 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TzwY6rVs"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9B2BAEB;
	Tue, 17 Sep 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726576526; cv=none; b=VX7baO8+9kSUqLEKXUONYrLwopt5w96holvk/BNPm9TyD6SN8TIT8eTwufWASIw/vKDyOKVWoQANJL+iCb29/7eU1YTZlBk4Y7fuqYrYTYgNNrWm8Xs3dztgIzWHSHX7VzmJiQkih4wXJlOeFK9RPno3fcwapnYvQzlhGDzkjqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726576526; c=relaxed/simple;
	bh=enTnHquxyJZPMPtmxWrd5Pmmnrbw9m85b7BmxIajlOM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rOTJJAhIkcmRTXQ6mYM6XlotlHbyaLRBExndQlbXOGIlthqfTbzl2VuBESSNJ8Ypvih3hr3v0vAglHnEIuadJlMDxufD02tLus0U1geAr5qEm8I/gTTAtha55QS0H1Ws9vq2SmHG3LjOje3jxZsPbJtPXrveLXYDs5c7iS3Hqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TzwY6rVs; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726576495; x=1727181295; i=markus.elfring@web.de;
	bh=AR+2QbPAYHmh/nYYxodXBMvQhRocE+1jEAfAlV44MUI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TzwY6rVsElAo9g99wh48sBhvrXItzrzO26bekGfAKxxQP5HHwyp3eR7Th7lPXHR0
	 TUzpsENv3Wx518lXyFlQKBrlPyfkeJPe2tnmwHDBDPlgGV7jUJ4bGLzA22suQ4Etj
	 F7U0nRtINSWMPfoqkMTKLsE0BpFUJl4V7jSWc/cLJ1UvhD0KDYZwPFS0rPSfseZkC
	 EnmWFkvYiOA8S648oRQ4VmsNjn6YgSta0Vuq2N2+iSrzAZ42UwIjM7oPBPyjp11yq
	 GVkysc/xgb5NHV2NsWOX0mMi34N4AStcfrykgcRq+od4LeXUyrVwuMgnK1evKYshR
	 yY9s6HrT+szn3duRgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9qgz-1svjx41pkj-00BpVp; Tue, 17
 Sep 2024 14:34:55 +0200
Message-ID: <4a82fe70-b07c-4878-bd31-6ae07b61f522@web.de>
Date: Tue, 17 Sep 2024 14:34:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Michael Turquette <mturquette@baylibre.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Stephen Boyd <sboyd@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] clk: at91: pmc: Use common error handling code in
 pmc_register_ops()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PZWjTGhf79w7fR4r4mZCkzhToXuovw4nJYNcXGTM43TaQallncl
 7PldTylJyEVnrdFvnOsGhrxgYx70UAN0EfVDwccCpkt8AhlmNnDQbmJero/vz0SrUZasyqg
 zD6mMb00eT80nwDLVdYZ5ioTnH+M5vQj0GLbaJQcLKObPzcqNiR5VUJDUCC9YxQYkx/Ezh3
 ghCrMDRpWqAl6i8pOohHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7hq542Msv1M=;uoDC2VziJexpsDnW81Ls1kOivCP
 KYyN3yuQJECp02zXqW2XUhK3o59auhNUEwGCnGDOIeb6+3LOM0B6Diw1L/onEFHcRz0mn9o0r
 1nZF7rM4DKEaB9Mb5wBSzehybSbvqJ9Mj0ALXURL1zUnw0ZT7cW5gd2C1nn784eJAmXnTExVW
 x+ddmAwatzO6OUx7TeySjCqO8cUDCC5Bed/woFe2b/xM+w4r2HcFkdLaP+a6oxk5OEDzRZyje
 6UVNJZBEI8tdMyMjKFELWN+lDhZt3bH5mwDepEEBTEonZAyw6NoK2NLtzcZ1+kMZfhJclBp/Q
 iER9fCTN3beZKWTk0gkst/30Q8h9nxKTljJyvgHuh3P/fuBiGplskUqcPBJSknbQFlt8ZafNn
 hrCJFCX6IlM3Gfbse9/bnhfjZKcNpcBW/bUwHDfmdDJZ+bcsHtJ9E6UNKL+cjkPKKhcq/LYR1
 pHzDPsteD5lnmx/uEwPHL+cYHkJHi2aaEXv20RiKF6TT8lQUl0Y9cCGvsfNtuIVd/RjAa+c6r
 mZIVqpzAEeggqd+lzZVUE3IT/Paz7ShWLY7e0jHV2IMDNBGFLKnK36dfc4QH1MqDMnntCFNPX
 oCk4e+JJa7yx4pYcgwXhviAoHxY/QGW88umN/5sg/HpP4gW475q+iYOxfYh44sSWKMGbGQr02
 7epZd9novJV+nCq/5kJb8mEu1iEXYV2vOqB/8u710wyxk298kef8DtN79MI1k91jaiYyJrcw+
 gXavI6847POddfiRm15Yxy+8fwsBLqKD9xuuKMyNeMI+gUOySG4JpqMJYvJZh8OMK7vbcNSfj
 p3GMHe/yaLG5ERxqsRJt5aiw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 17 Sep 2024 14:28:22 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/at91/pmc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 5aa9c1f1c886..040b70e1ffbc 100644
=2D-- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -162,20 +162,18 @@ static int __init pmc_register_ops(void)
 	if (!np)
 		return -ENODEV;

-	if (!of_device_is_available(np)) {
-		of_node_put(np);
-		return -ENODEV;
-	}
+	if (!of_device_is_available(np))
+		goto put_node;
+
 	of_node_put(np);

 	np =3D of_find_compatible_node(NULL, NULL, "atmel,sama5d2-securam");
 	if (!np)
 		return -ENODEV;

-	if (!of_device_is_available(np)) {
-		of_node_put(np);
-		return -ENODEV;
-	}
+	if (!of_device_is_available(np))
+		goto put_node;
+
 	of_node_put(np);

 	at91_pmc_backup_suspend =3D of_iomap(np, 0);
@@ -187,6 +185,10 @@ static int __init pmc_register_ops(void)
 	register_syscore_ops(&pmc_syscore_ops);

 	return 0;
+
+put_node:
+	of_node_put(np);
+	return -ENODEV;
 }
 /* This has to happen before arch_initcall because of the tcb_clksrc driv=
er */
 postcore_initcall(pmc_register_ops);
=2D-
2.46.0


