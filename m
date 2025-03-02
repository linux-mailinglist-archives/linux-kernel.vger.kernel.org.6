Return-Path: <linux-kernel+bounces-540762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF92A4B49A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45C03AF9AF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0BC1EC01D;
	Sun,  2 Mar 2025 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TjUD8dAl"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF6EEB3;
	Sun,  2 Mar 2025 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740945629; cv=none; b=qKTYp8YFwEX3Vtw/7tPRb65fI+PrXCLbr6hVZlYc1ZJH/7OxVDdUfIMD64UN1hfX+1yc2OG6Nxw26yI+gZJLMURhXuIeKyO2OuWYdDwrSrPAMwneF4upWJRuqt8pcebrtOfc+FpiYSW68gCzS9Bv5FEYAaKDd2sLILVda8Fx+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740945629; c=relaxed/simple;
	bh=rQJAsaw63xqBWE1U1BqvEkVbAuOOdMfZwM5g9uuw/j0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ID9OTXEpnsgxYecImZgjl6GfMPUUsO+xhwo6Z9JhBjHIOafdAXv2SwHThNB31TzMhFzOIVRW6X2z7nqrIdM2XtILnU5Zzy7wVS7wN7HJeWVMP2uFxnkfL2WsbN/LTO3XttWauRRM79phrIX3oXFeQfTHKKP8gobztslhJAo3UQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TjUD8dAl; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740945612; x=1741550412; i=markus.elfring@web.de;
	bh=j8978AGK4OcGB6MWNg+Th/WIqtnKJPRM1f6P4S0eQJs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TjUD8dAlKI/EZfWuj+uvbI73b1JtsALaP3ZYRqmru9UTTWBr+4TCOiMEL8zuhJfe
	 NfALfXKiirp0eXUKs5A8fQIX2cRD+2IC+txPOaouKhPSw171e8T4rxJsb5MWA532H
	 BsD147SAfJJjCbKvj+RUjSVxdUndGceZtnNvcW2PzldwLHoyfYFtXUgKu5V7DuBzB
	 81ESLxKcAXlsCem7uhyeWHULJ4cuNMebH1cN3K3ymQnoi1/UmSIIFf9ZMFg8QgPDM
	 3kbd4YuSHLeOQDgeG6fVJr3rTSrGPxfBGSLs9P7igoFCyvdb9chG43azfAozkqtDc
	 vv7cqnYevrm1GvBMYA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MG996-1u34Zb3Xqu-00Cw1n; Sun, 02
 Mar 2025 21:00:11 +0100
Message-ID: <774e0b8b-5013-422f-a9aa-4f8c4d5ed17d@web.de>
Date: Sun, 2 Mar 2025 21:00:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] usb: dwc2: gadget: Move a variable assignment behind
 condition checks in dwc2_hsotg_handle_outdone()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-usb@vger.kernel.org,
 Ben Dooks <ben@simtec.co.uk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Minas Harutyunyan <hminas@synopsys.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <10e10996-d53d-0733-6d90-a04f251812ba@web.de>
Content-Language: en-GB
In-Reply-To: <10e10996-d53d-0733-6d90-a04f251812ba@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PVLaUZ7MZzsJHTPMWeyqNci21CUz7+lc4RwBkiERpobTfFK1Rp2
 P7q0rPRSFIFxRRAE/B1dn71jJyPUl3pmTUeZ1JUxLJ4g1BbF34zy+AFH3qkNJJQh+72NzFA
 70cU8Lu0ZLMlRdaoJFml01vhhybjPjaF5DlRpTf/Cl6lRjxc66saooBaehARDoB/0ENtgEv
 Yue5V4rt4gCDEnpwC+eDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KQb1UWhkZEM=;JEJ25Nhe7DhuYtqdRJ36Pf/j15d
 Xb0TZMJsYDSVfImiNprrxurJpbxhQLJnsmUDX/cpGlj9gldTtGtlmYUlcIn3KllgryObmxlXs
 va5NZYdeV8sMBRSkOuVv3bD8SqTnHlOSfxlDSHYdwqDGUr8zehynZsdzh5blOWAAq5tL7g6LR
 9lVlXGPKoD5d/0GZV5kSGrFiMS+gyg6zld9bG5D++A9riWmeERKrTuc0bPiDUtG00Iz1hXH1a
 +KRAVasJr6M2tLTrGrRd3kheLUE2BcU+C88FRslmLxW4sFfoabw6oROUstnmlnihrJnxZRjo7
 axm93qw0svEdodUcbUPDaunxmh0z3440bBDaLn/EKJM7e7qf7gI8JlsYVR2nNsBuulEUwScIO
 p7R2E0EbFIhvG7nbDa8vKxIhWKAEr/39Z2ldTO5jDTLiHINygRrE+91B++pbPuAAUi3OEJ3Vr
 Hhk8QYX0pGtw1QFS8Wy+ZnV9nW3yUf4wsqehiamOZSIHaz3qLPiKbRDJdSelHMLcn5F83zTr6
 FNSBn3xkMJ6KfBTwHS+7/6qGjAqb9I7NQcUcGKJq05KWqak3LU3RU2ZHhsyvT3xA5bMNsDZiQ
 T+nKQyufJBwjohWlpj8Mlb0jSZWRcO6GH9ncn/l4rGnccyB19RcUYW6r//tyergv2nPe57z7I
 +/2FJMqxSLoKq6i6Qe2Dk5aO6gyDTFUtoAsKsKSJ3lDqrxXPE/GrHdQ6yRAxk9EHi2NcanZHQ
 6jhiTy0J1s1uRSIP8uAsRSROoLPEEclWe6jXGBCdzcGzvpeJ64jHN2ZdSEoGR9k+GzNHdgwjm
 iJzGVPfl3eQdyVpH2km/dpbukEGtmSEqhW4SkxKUB3Sb9iGdP6S4S6FwLo5tvKbu79IY5h7yD
 Jcnv426lHQbUGWlyVpl+qMwCliY5d9CZuoDGXow7xg1We9glooCDjsE/F42hvVY5DLLSleEfe
 AoQ2xQ60JCAujba9uOIYTXrBWvN8asxYAr3nGYAjCUHr/77qXdKyl5Ql7n76tPHPAq4ZH57gD
 LdXUbEgTAyd1HCFd8WjXmG/A0tcbuV+ctqNnERdvVkhlO6KUIcJTTK6RyHGUvTK9dNDv6b1UW
 DAFdfEi00RR8k+t9ySFqRbTZjQkT+HuRFchErn7yQDXbD5qgvpwMu6dK3n4Vi18CW65qKIAxn
 t2FwVfCn3Cp21QaSp4safsgTQ0agGNDE9NFKgvARHpCDOeVmAZk95GNF3Ls4GOaIi3o6DyR+S
 33mRSQYxJrnmZ6dEYKU9mbVY84AjM+U01nRJyswnwX7Yp3Zvyl3VfDHmb0fFfmAbTWoN8T3lG
 VPMgIyrZegV8cZiGvXQ4IrHpuCFovZXIcu0tcqZB28C2xi7cdIOymd8Lm9asg0azJouG6lm+W
 WBD6ywmpmSfcx2k9XXB18vK4Ck4A02J8c3N1HXLjXYgGYy/g1QpsTbb+Chxo7WJ46vYjQD/SO
 tpY/L4z1h83QJakWYogNdeALisvI=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 19 Apr 2023 20:06:25 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cdwc2_hsotg_handle_outdone=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Creq=E2=80=9D behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: 5b7d70c6dbf2 ("USB: Gadget driver for Samsung HS/OtG block")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/usb/dwc2/gadget.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 8b15742d9e8a..cab04816dd6c 100644
=2D-- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -2389,7 +2389,7 @@ static void dwc2_hsotg_handle_outdone(struct dwc2_hs=
otg *hsotg, int epnum)
 	u32 epsize =3D dwc2_readl(hsotg, DOEPTSIZ(epnum));
 	struct dwc2_hsotg_ep *hs_ep =3D hsotg->eps_out[epnum];
 	struct dwc2_hsotg_req *hs_req =3D hs_ep->req;
-	struct usb_request *req =3D &hs_req->req;
+	struct usb_request *req;
 	unsigned int size_left =3D DXEPTSIZ_XFERSIZE_GET(epsize);
 	int result =3D 0;

@@ -2408,6 +2408,8 @@ static void dwc2_hsotg_handle_outdone(struct dwc2_hs=
otg *hsotg, int epnum)
 	if (using_desc_dma(hsotg))
 		size_left =3D dwc2_gadget_get_xfersize_ddma(hs_ep);

+	req =3D &hs_req->req;
+
 	if (using_dma(hsotg)) {
 		unsigned int size_done;

=2D-
2.40.0


