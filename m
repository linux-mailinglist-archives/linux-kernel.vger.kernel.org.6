Return-Path: <linux-kernel+bounces-200935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AD68FB6C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55E51F249FC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4D7143C70;
	Tue,  4 Jun 2024 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DDEPN55+"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F0ABE4A;
	Tue,  4 Jun 2024 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514157; cv=none; b=dm3UcprMa+Xjr6CUsn5sF8BqYKMaqO451ELUHRym0p0152jaHy8ph9FuFViaI7A2UDj/EsjXBtTr6BxH++sGWUfXgeak/ye3TXNypTq0u7jFSEjfwYJcm9FtoDA1e/30qsm3nXlBdt69NWL0tZsXqqY2tDr0km4Lk27CtFOdp64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514157; c=relaxed/simple;
	bh=qYbGIfmyW9zgaQj0Mjiwwwvs2RxSuGP4Gkaw6xq7zok=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=M6QTxIzwvMyiJYTa0dnS+pBtku+/Il5mV3y7VmHr48wjF6/qu7E+nJP9dr9t+4TWV/v7v5ks5sc7xPDi6Ny7FaTGHDgbf9ocZ1Yh6h2nEkAS//kjycU4nHUE1BPCdICgiOnqBzBBFTfR0vmcd/C3SPUDQRJwxd9EaQzzrMuSY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DDEPN55+; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717514139; x=1718118939; i=markus.elfring@web.de;
	bh=IZM81H3ToOd0nFYz+ETE9GqM/ElioJLDbHOzj6vrDdc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DDEPN55+LLeSvhW42oQd7v++QohEwbLsqRsGIjysRMgB07ROpQg095B6OSgf6Lyy
	 h7LkgH4rc4cy13ocLb/4KmoTVO3qDJwSJDsUqYqLo1kqS4TxSM/4ev79IAJmQeoo1
	 nfJervAltRKB9O/zNCjprB+Ex2nXuWhmI9k8tXp0ilKDrpemtkAqwDZ7WbSDMNFTB
	 y6S1C+VT+Mvwx86B8VWIufxFQaa04MZ5jBr5VzDXaEBrdFGxzh2G+e5vyzMTryy3d
	 EOh/fBcYu87Yq/3xfl17UVblAkVYCZCkd38V7yHMCvYYgYeT4y0UzMcWTCzAVaqe3
	 SQliltvFtP11nKMEYg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MN6Fj-1rvbSQ2F4X-00V9Wq; Tue, 04
 Jun 2024 17:15:39 +0200
Message-ID: <0fc79fe9-da49-4cbe-a7ff-6443ad93f120@web.de>
Date: Tue, 4 Jun 2024 17:15:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Robin van der Gracht <robin@protonic.nl>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] auxdisplay: ht16k33: Drop device node reference after
 registration failure in ht16k33_led_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4Lsg5L4n7WeLu0+owQVBLTAx9hJoe3FKwtwJMJko7SkcACI7w/N
 UnnlaL5VjNtXJmfKa9xhJAR893ZZ+jLRqLUVt7w/HDbJ5nPxlfBqdt1vz0vFjt7h9GBzHiF
 DuIvwEbwUM4TcsrxGIobgl/n+8jiKaBWHvESeKgJT7xXfVa3ivOi1mLAg3/8ThkqG7IL1iA
 BcdytZBCCf375SA0gyWCw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TLohPM8XQAE=;YculmRcoXr5MdlBnPySciJuvA09
 kz4AIvEvSYJ+FzGfJ0VPTlDhqByuXBAq1142MlGTaH6q5cO/Z0HXipqy1JMaelzRKua6+2i50
 AABEJZTzrNaStTM5NROSc4lcs+wwDTWC313hKpb06WtAnZri6b0bZNGhgv6LSZ5hDYOp95jaG
 b7lvBZKlHVX9bfjRwq+1gyxOXQjaLjeo5yoHpNDYM07QeDr8kiptwS0rZh52TXY+PuH4J1NoJ
 0baqwHGvMjvhnuMYKw+G3Tq9LkcgElaMtnySj/9aYXO5L3Fmtt9HxZwGRmk0WnI/mLLPYwM71
 uo7RoPSVYJqzaFGMtJXq/LXBJibR67QoWg8g837fND2mhMp4LgGd+ZFl8Uf63Z1gh/msm7MWs
 uH5YXR6SgTJ6nCfFWId25Nh6UuSPO7zlarbPwTB1TMLXwGJZfKSP8rzBNMJvexgQq5Gn7jTzO
 tQWtQzltj3kMJhW73nzx9G/+vWL6y1ZJLX/QL5/ZbGdCiV1Vg37GJ2nLj272TA9Pp0/VCnlnx
 X15dPFYaAqLfjn7U+4EoORSI8bWMcXiPOu+I2BuVUyv8I0g53/Pqlf4sjg5SavSOZkbv/wVX7
 JBrNPxKWHbUg22ugwy8ewVQijBfTgfpUYwKdjgphZViFNZ2ge+fxThMmhlT3WIApuGz1olAsB
 +x29jVrXYRB6iQpCnLc/UAKs6kUt7qxVn/aow2wjZlXqQnqt0XERi1PdLtKgFwkhUVgNjQUZv
 I7e6zkf5uVPKpmUup0VXgpvp2Hedwc3FdvcSCMC1300xC8UWjCD7rH7HPxtIvCrz7x0rcQttP
 Br+TRMnNJVfmLg8ndvi9K30tnuoJJhEKlNia8piZuBtwg=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 4 Jun 2024 17:02:15 +0200

A failed call of the function =E2=80=9Cdevm_led_classdev_register_ext=E2=
=80=9D
can be reported.
Add a call of the function =E2=80=9Cfwnode_handle_put=E2=80=9D for this er=
ror case.

Fixes: c223d9c636ed ("auxdisplay: ht16k33: Add LED support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/auxdisplay/ht16k33.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index ce987944662c..ef86537c9d83 100644
=2D-- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -483,8 +483,10 @@ static int ht16k33_led_probe(struct device *dev, stru=
ct led_classdev *led,
 	led->max_brightness =3D MAX_BRIGHTNESS;

 	err =3D devm_led_classdev_register_ext(dev, led, &init_data);
-	if (err)
+	if (err) {
 		dev_err(dev, "Failed to register LED\n");
+		fwnode_handle_put(init_data.fwnode);
+	}

 	return err;
 }
=2D-
2.45.1


