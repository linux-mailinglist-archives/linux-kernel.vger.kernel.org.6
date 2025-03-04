Return-Path: <linux-kernel+bounces-545222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF20A4EA72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5EA19C236A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22B7284B3A;
	Tue,  4 Mar 2025 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XOx6Yb7+"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C3298CC1;
	Tue,  4 Mar 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109938; cv=none; b=VEke9novfsu5CjWmI0IT3JvgJFWuD/HJKJxpsZ5Jr4zcUWde9oVvVb2BkjTaAgAnda4BQcqu62BKd3BSaMUUnlwVzTR3d8F0UOEKb1cdf+qODM2yVwBfTOFe8CTil7jx/nism2UPgfD0WYf3jrajPd9IZQIITfnz5yG3p7s9c5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109938; c=relaxed/simple;
	bh=JcIEw6KHcvbGFWY/0MJdcq8fBRZHDsPWigmoQd9FeNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tW8w+Y27hwnqzFBjwgFnmPYPhF4MK/nlTbkZK97xtqb2DYBqHjrnrsIaQilrTDV69H0oIB/lLg5w6joJ1iUEAKnRUok1hmT/UOBIN/xG64VkVW55eaO3cnax0y1M3tqywELR34YijFN7COYaiMUZUQP9EhFaUM33bG4FoZwNeO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XOx6Yb7+; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741109922; x=1741714722; i=markus.elfring@web.de;
	bh=Hd9f8ED3HYtNlKnYfy25W10wkR5BfmeLn5PDLRGCvhI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XOx6Yb7+IjmoN5q4fcTKsJB+3gujW96dnAJ5aO8w/VuhhfToF6Yyj3OAjexSOV1z
	 /1Y56MEQqGhbvmO6qGspVIHmG/N+bKTKCu6/uSunZGZSosyU18KCKt8nRNM8rjmBd
	 NEr6FAOCB/ZUHA/StjNB8ZJbsHKGWDmvuJkzeSec/Binljzwqg9DBeEOV/UYygfQ7
	 G/hYlJM4ALSxq+FZxR4IMvGYYgWHRTZTDjXisYlL+Mmx29JxLjJ3EWR22GlWe2124
	 ekn5/GeOG8nIyLyzjJTzJfBXFbaZhdkiUA4RF0EKl27yyjd82g6ixf6y2mckMuzMU
	 IYvzksEVziE/kjlPCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3oz4-1t7h213Slc-00tCqt; Tue, 04
 Mar 2025 18:38:41 +0100
Message-ID: <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
Date: Tue, 4 Mar 2025 18:38:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] mei: Improve exception handling in mei_cl_irq_read_msg()
To: kernel-janitors@vger.kernel.org,
 Alexander Usyskin <alexander.usyskin@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tomas Winkler <tomas.winkler@intel.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
 <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J8W2iKNW1YOzbAMnhs59UwrQGwR1Hh6yGO7inTnU14zkOAupzCK
 d9+IIn2FAt4eO1oHC3z0rvCCtO76XilZNUr1lBfotSduoQwvEqx38iZzNgjRdkkhSCCTMxv
 /iCGdqvvWQaq/fp7ERjtHjiJxLxvtaIvmJyGO2Dw3iOMpzV5Vfi+jtTOFfzzhzJYbb1d6gs
 B8iVPlkbih15zmTVSCN3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9YBNIMP3MJY=;n42+oDqLo6wQnlInoPCWZ53JWo5
 vPe0g1v1iPVJVBX3lQZCBBo4GdaNfkkvbyNuW7p4HKVKEHhtsg5uUwbyt/Q34o1KYLvAOM1H9
 Qs0XMuEYA2IOs92Ki8qAi6MaYVo1RZpyoZ2MGNLZex+fFPatCaCne8GEdEkwFyUkhZa84lozW
 kDCIIZdyunnQcONNQKEbIHQEU/t68T0at36ufZKM2TLG6tvw1hNm7VdLpIt3w870yB+A6fucR
 0Ql4a3Tc9QBOK4C2poBvuJtWV4zdOm6atgfQWV4Srn8tVubzf6hbgJiMWFbJdqUqw2tBmUsSI
 0xq9uM21sbD0ZBsThh2rXqZAd9BJKHzwIO+7T8LTeOyjwu1xyy1BN4iQrLijIg/aHC4t3HhIy
 loT5cQSrxTLpBWGlZ5fXBMZvfzbLHRGpgosv/2OZb6bJGDtFJwYGzTV3tYsG6vDiHS8q43OBz
 e61SWjNma9oWJB5hjLvDJprWHuGUdet2S2I+jYZ/g8iWCE6xOBONbbY9J5AUgRzYawIsvn1Sa
 9NmuoW2bDkCQknfp0wXVtGG4tSnJVTbzJ47sZQulpNs3EeHhfHd8kJpUEx7P2M7UcxlmOSraE
 q0BXphasgMPkrQRtb1wAc/qMDCmLGo8NnUYccIpiopb3WeICO/4Uwqd1nzXtiMYMpkgI4zJrR
 uTgLP9R79sZE1oGNu4S3GsLEQIwIkNeqjz9kWInZnoM+jIP51lMVuZUy3HVDIEWHIBRhDIs2C
 gUJWovKziPfY0zBttTcEErKPN0SIbOYie0VHIZCXU0dNPUM2Usrmf33Dfmb3Ys3qTr5f2sIvK
 Fnu47GsMyn66L2jA8uK49OVNXBE4q+KjHzwApPyGKIG0bK5grn4YZa0SdHqKXC0Rkg+a2/XQo
 dLR29QShm9g6wc4GLFsoNB6glL3+gAHei6RtWjPdFKvwJpsCETPQthDHCKSwurzXeTE9d2gfV
 skCtC0LLA3tBC20bDzN09FXfqSBVkmbZ+Ki/YOuXfW1QqyE8jtK6aZLNw0oIG+YDUsld6/9AN
 kZNr1K8giDfPH/GlcY/+Kabdcf1zn+Xw03gkAPD2vY2NVZJwxTr/WlnHBPKZxssl9oWdzHDrr
 nTXFMV1MygKQ3eB/9OqixtP/5d8YH6NUZKuSqfpIIWq+Eu40HJs1rGKnO7jXY4DmCIlJrJTGu
 RsaLoLPZjLTrnerPNNta0NOhF9KoAJYMHiPho2N114oTn5YAvrTPYt4A8dAjBckWlxHZmjT1e
 JjfSvH4Ni69m+i7AXJncxOF+E52bJi2fsJa00f1ra/wxoFa1dKAtCbb8P5F4YfxZH3F8EF3mK
 NlgGXkoILh07ipFN7p/A4ClS90MbeTm9JEzDryOuAIbO3fdDcacov46zCiD9Vbcpxg5z9PBSh
 vjpxyzEAimIMFbZmHkBmSOj+HR2dbusYfCkLyIyELEzt2eKUWZRcBB+6OxV0QDGGa2Bzq9lJm
 zM8e/nA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 4 Mar 2025 18:11:05 +0100

The label =E2=80=9Cdiscard=E2=80=9D was used to jump to another pointer ch=
eck despite of
the detail in the implementation of the function =E2=80=9Cmei_cl_irq_read_=
msg=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer.

* Thus use an additional label instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

V2:
* The summary phrase was adjusted a bit.

* The Fixes tags were omitted.

* The change suggestion was rebased on source files of
  the software =E2=80=9CLinux next-20250228=E2=80=9D.


 drivers/misc/mei/interrupt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index b09b79fedaba..af5f01eefea4 100644
=2D-- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -136,7 +136,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 				cb->ext_hdr =3D kzalloc(sizeof(*gsc_f2h), GFP_KERNEL);
 				if (!cb->ext_hdr) {
 					cb->status =3D -ENOMEM;
-					goto discard;
+					goto move_tail;
 				}
 				break;
 			case MEI_EXT_HDR_NONE:
@@ -153,7 +153,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 		if (!vtag_hdr && !gsc_f2h) {
 			cl_dbg(dev, cl, "no vtag or gsc found in extended header.\n");
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}
 	}

@@ -163,7 +163,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 			cl_err(dev, cl, "mismatched tag: %d !=3D %d\n",
 			       cb->vtag, vtag_hdr->vtag);
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}
 		cb->vtag =3D vtag_hdr->vtag;
 	}
@@ -174,18 +174,18 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 		if (!dev->hbm_f_gsc_supported) {
 			cl_err(dev, cl, "gsc extended header is not supported\n");
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}

 		if (length) {
 			cl_err(dev, cl, "no data allowed in cb with gsc\n");
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}
 		if (ext_hdr_len > sizeof(*gsc_f2h)) {
 			cl_err(dev, cl, "gsc extended header is too big %u\n", ext_hdr_len);
 			cb->status =3D -EPROTO;
-			goto discard;
+			goto move_tail;
 		}
 		memcpy(cb->ext_hdr, gsc_f2h, ext_hdr_len);
 	}
@@ -193,7 +193,7 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 	if (!mei_cl_is_connected(cl)) {
 		cl_dbg(dev, cl, "not connected\n");
 		cb->status =3D -ENODEV;
-		goto discard;
+		goto move_tail;
 	}

 	if (mei_hdr->dma_ring)
@@ -205,14 +205,14 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
 		cl_err(dev, cl, "message is too big len %d idx %zu\n",
 		       length, cb->buf_idx);
 		cb->status =3D -EMSGSIZE;
-		goto discard;
+		goto move_tail;
 	}

 	if (cb->buf.size < buf_sz) {
 		cl_dbg(dev, cl, "message overflow. size %zu len %d idx %zu\n",
 			cb->buf.size, length, cb->buf_idx);
 		cb->status =3D -EMSGSIZE;
-		goto discard;
+		goto move_tail;
 	}

 	if (mei_hdr->dma_ring) {
@@ -235,9 +235,9 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,

 	return 0;

+move_tail:
+	list_move_tail(&cb->list, cmpl_list);
 discard:
-	if (cb)
-		list_move_tail(&cb->list, cmpl_list);
 	mei_irq_discard_msg(dev, mei_hdr, length);
 	return 0;
 }
=2D-
2.48.1


