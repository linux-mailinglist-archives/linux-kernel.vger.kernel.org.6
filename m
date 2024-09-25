Return-Path: <linux-kernel+bounces-339357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 996519863C5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7611F27C11
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3CB17557;
	Wed, 25 Sep 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Dk//1uWw"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E9DDC5;
	Wed, 25 Sep 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278737; cv=none; b=ulWXk8/PKN+RhvJtc2Vir9QqUWnZWmdSk9NGWCD1M09xMWbVyMXK+fKSyvco38UAzF/t1/ssNhw82Yq8BNrv+DwxE0Pg9CqTXkW2d4unDb9uA4k7rGVtHaesdtMTKQYncKgjhQJqZc1vfkgxq4xA5FMG0rdDyuuoz5TWE7LOMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278737; c=relaxed/simple;
	bh=93cxj6Cr+VPnS1DFo8zzQfPXtg13oFKJuewmGZN28fc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rL97JZ2WMgLGXp9WrWr+KIfKKGPzagau7l4QIUMOwwtOVIkhgwqbNI1Erwq658pBXMjaxe1fms5kpnksUdLD4WUHEMDxkwu/WsOj6/YqYV4RldfSbbpPwGxOIctXB/XKuzRJmqvxL/hxCYDP6Yc81/E55piQ8u0SRaajktzlZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Dk//1uWw; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727278720; x=1727883520; i=markus.elfring@web.de;
	bh=/BF/n008MTXnPCnTy2Tzf/W95fPNGj+i5tDXPuhc4/g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Dk//1uWwJCm+GNNhpNKI12pGiZICAlzBZNRi6Jop3VV16DTGdsYQTnm5OVQkaCCo
	 Gc2UpLhnpGJZMoQzYgCJGB4u+TyTjQOTqz17ffz2iBHsGawYxCuuqZBR+qdieQsX8
	 0WFG/qYIERsnDTvNvVi/rc+csfnVViTBddss3komN2kL4MU/M2DH31dpNvhFjborR
	 erYj1jBA44e1x6JJRN27+ayxnNwEbJBO5JnYKM8PgDkI3GQd9vFhKT4GE6PTvW2zO
	 HRzgTSRaNDQIg4v+/oxQy6HzcSWegH0tyoE3fiDkv/o16ZR9ViADO/Uu0NR4NcRbW
	 0f6SFq7py5E4XGtXaA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOha-1sUCxY0a3Y-00R1uX; Wed, 25
 Sep 2024 17:38:40 +0200
Message-ID: <59fadd5a-6574-4379-98ac-cc4f11b675cc@web.de>
Date: Wed, 25 Sep 2024 17:38:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-usb@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] usb: gadget: eem: Use common error handling code in
 eem_unwrap()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MeUPnH0sS8NaAjzkZtCgjeUspcEHrkiTqOp61I/CfLq64WMzRa2
 4vuTdbQkQyiTzn09j3nXY6XzuEOvcN6uKto3VpYz2rNged6uXX+R+a9q27Vof4cXLKwb9N+
 mKWwlPRYTYH+tp3tCno8xABVG2NI9NMcXYjfZRpRA4d6GD7vgQ+jrttyIG0G4yCAXV85GhV
 juwGmgGqhuURyAfg5mTgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WCT5LJdfDHo=;jH7Uz4t1nuoKWXTB/e6FmWstsa3
 XDsoH1RH8myevKcPIT6aG6V1JNz4hR9p4U3g1rHH+NBrP13mOzz7V+XuvEKDZpxXP8WTIG45Q
 r/IHhSC0MwglRbCSv3H7LCwwpY9zyfrkRPYSHbXE3/bNh1XUjS66/9So/yisTu4ceS800jwYp
 CQtIqcsLwfZkZmwBI8WNNWkCGD1G8gHio9Ami6iVpbUzS4otAWQsZijmvvci1Mk8zHpuvMH8R
 pDuJ/cQb41pm4OddMUd0LbbGF9eHmVDP1EauV8y8XJhbbeccvg3fQyxJhsd9hgdk2VUCJNJhy
 DeMfcVFZtYUK7Gw56zwFwhK8B8vz+0ZrynKhftjSsWDRz5qsSCWXp+Ezd8Hs8zMWpQY0As5A/
 J1ZiHPwEhbm9x7kcJPLrC9yG5iR7gqg4pDV6Pq0/GioVT5vx9K7aH9GPROfcqWW0Vfx86dOzr
 4EcSqGqMsmIm0unG7Ky1idSLMok4zs++WbPMcMI/K0j2Fh+Tp8WmaFtuo8ODEXLz6FWBkVTVf
 W6KdGaqa6Zt+j3SJrUSHvne1A3C5CBVn4V7GtP7Um4Q/EymZKUVmKPhLBYzy32psgdqbfXKwC
 PGTg48GhgglYS5MLdaXHupcDPkmA8qHZ+SrS8Ok4Tl+17WtY0w0sYQS9KkeTXqsFeNq0MeW8o
 bsHP8NX8VRot4x3lmBXholsyW2v78lpQ9vU7CLMv9+MgZdkO87o/qgDXfTlQEtgCP4E3f/Dze
 7duhSwr3+4/F2EoDhQw0qgYsRg9BwYYMfk9HY1ox9Is11mcl0HsiTPtbdCv+Q6LjxdMUsXUL1
 KUI7ibW1pV5YOzwQy53bjkIA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Sep 2024 17:26:40 +0200

Add jump targets so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/usb/gadget/function/f_eem.c | 30 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/gadget/function/f_eem.c b/drivers/usb/gadget/func=
tion/f_eem.c
index 6de81ea17274..b1be23e947dc 100644
=2D-- a/drivers/usb/gadget/function/f_eem.c
+++ b/drivers/usb/gadget/function/f_eem.c
@@ -450,24 +450,17 @@ static int eem_unwrap(struct gether *port,

 				ep =3D port->in_ep;
 				req =3D usb_ep_alloc_request(ep, GFP_ATOMIC);
-				if (!req) {
-					dev_kfree_skb_any(skb2);
-					goto next;
-				}
+				if (!req)
+					goto free_skb;

 				req->buf =3D kmalloc(skb2->len, GFP_KERNEL);
-				if (!req->buf) {
-					usb_ep_free_request(ep, req);
-					dev_kfree_skb_any(skb2);
-					goto next;
-				}
+				if (!req->buf)
+					goto free_request;

 				ctx =3D kmalloc(sizeof(*ctx), GFP_KERNEL);
 				if (!ctx) {
 					kfree(req->buf);
-					usb_ep_free_request(ep, req);
-					dev_kfree_skb_any(skb2);
-					goto next;
+					goto free_request;
 				}
 				ctx->skb =3D skb2;
 				ctx->ep =3D ep;
@@ -536,10 +529,9 @@ static int eem_unwrap(struct gether *port,
 						NET_IP_ALIGN,
 						0,
 						GFP_ATOMIC);
-			if (unlikely(!skb3)) {
-				dev_kfree_skb_any(skb2);
-				goto next;
-			}
+			if (unlikely(!skb3))
+				goto free_skb;
+
 			dev_kfree_skb_any(skb2);
 			skb_queue_tail(list, skb3);
 		}
@@ -550,6 +542,12 @@ static int eem_unwrap(struct gether *port,
 error:
 	dev_kfree_skb_any(skb);
 	return status;
+
+free_request:
+	usb_ep_free_request(ep, req);
+free_skb:
+	dev_kfree_skb_any(skb2);
+	goto next;
 }

 static inline struct f_eem_opts *to_f_eem_opts(struct config_item *item)
=2D-
2.46.1


