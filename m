Return-Path: <linux-kernel+bounces-344333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A753C98A86C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94011C20AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E400C192D86;
	Mon, 30 Sep 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="D9nf8rqP"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83519006F;
	Mon, 30 Sep 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709934; cv=none; b=U26Wou7U+1i0lAdI6EaIiLdccvnQf/rG6Bu14BwLJAFvEda/href3HZC7lazELSTatmvqS8XOGlS8MV8ZCeesfQDvaioyOjKCTcjZaZuddUDFSGxtoLIXYrJ86328QcAp7d5km/ZqNFotdO4zYoGgFUGfWKE3O0WPwL64MBRSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709934; c=relaxed/simple;
	bh=QIWA3CtPARE1TVKzVdzvVJBaCMrSEUZOvGpojT4S1r8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QnConwWO3IyCDWl9/k5WP/oIquTeApy3oMyKlLYlYs2kQNtGWvcRUt0Vq/0KdgZ/kEGr60Rhr70fD+61Git20DX6thpAzm4TCdDOfX/D4A3tOMieLHUncPiMtOyiDffqCc9K/iDLQxOu522cs+8ccmlDmm6lNhpjIYDn9gQbmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=D9nf8rqP; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727709911; x=1728314711; i=markus.elfring@web.de;
	bh=AAM+B+gNQ0hlXXtpzDjUjbyQ0PnbzFY6sOmzc8cNHGo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=D9nf8rqPcgntXbzy8uOjP6TXIaeCSTf9Gy7ZkNbTDyx6u5K9lSG+1MR1O0cs4ggV
	 mPnli+oE3aW7EQ7D3sVdBhkOt+Tir/U0OdUAHIwIQTG8DHcGSML0dsdX6Lk0OQ27R
	 JzREDIIHsrKx23iYpyR1fkHBdbqZB/2OnNC7wOx0vQG0Jw3W6I8CmAghqFHLg7fnp
	 Ucs66yyDCvSnKwUSpNLyqVlA78r6vVNSuISU5Xkao3k/PS9yPHpE2tVlFVs/200VD
	 m151gY1Lu4Lh5uISF4Re1RswKTJgt566GANdPmEXFz4mDpkP6WeZQBjKd+XtFky2i
	 48K6q/nxIMCebS6NIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrPT-1sYy1c1Z7T-00NPtJ; Mon, 30
 Sep 2024 17:25:11 +0200
Message-ID: <0d45776f-264f-427c-964e-65be8955aafe@web.de>
Date: Mon, 30 Sep 2024 17:25:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zichen Xie <zichenxie0106@gmail.com>, kernel-janitors@vger.kernel.org,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Stanley Chang <stanley_chang@realtek.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Zijie Zhao <zzjas98@gmail.com>,
 Chenyuan Yang <chenyuan0y@gmail.com>
References: <20240929223813.21164-1-zichenxie0106@gmail.com>
Subject: Re: [PATCH] Fix possible NULL Pointer Dereference in
 'extcon_rtk_type_c_probe'
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240929223813.21164-1-zichenxie0106@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gaog0yNgbY2kks87KME/Is+FbVilFpXPOdTEY41nftoimjHPy7n
 iQQxm5w0yOtA4Tn68f+yv38m/sp/6wv50rTn4M7fZmo4tc+o+tAgYFVWgFJaZE7SwvBPv9+
 isj5zJKzZrD3c5xgQ0Gr/2QFdPOXIaORT2zSmq3Ogx/PBs1N5kIuHYlQTwo4oRTq+LCCwmg
 se+n/wlqi623mJJT2tUKA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uQHQlLC+O08=;KshXiFIAJC1mf5Q1FzKJaFB9yuq
 d3KsgOjjOj+vIXKqNTx/bC/M724qgwxiYp7WaCQixRBmyWFHsj8qPRMUu5RlmzXzcVTUBN/Nn
 TY7LzFqx9yYBGofUfbnYPrF3fPDtiUmf5tUHb1OvcatRR3bJGN7tR/HXGS7YtQTNqns/KALJt
 aR68PN5migZ1ya4eTDilQzaHLcfSlg4gTaW3VKvxgUrkTD1jAc/ht8Ky3Z+TbpEa7yI6f3J0c
 8ruxk+F3Pf/0JpKmKPcGPLFFFkJOAk4W/qR7yv56Oh5/TwMWroJnn/eyMPryUu8Tewy1fTYlH
 7zuAuXzQwVPG7SuTuTA98EzxZkm4ojyIgOGDfvPae23iPxF/kmI615ADUat/m8QYfBMU7215v
 YPhvTprfq6Aq3Hns/3VGN+BzepCongo6QLlVro+R6ebGFvxBUahpBswn0nNj6wTiLjPTkeOZE
 Dv9tuBoU3vCTDmgSCsNggP7ldiTL5Q98+Y/2FKrAsS6KXiMmtpBoTDomhAFPh+XaWsIm48mfU
 +bETe6V885+oYArjd0e/BqWPj+BDLOoFYlUeZkvtJ8u56Kpmbm/pg/vbc2NtPGh8zSXoeY8Vn
 rnVzj96LFDOWg1o9sbys+UlVnycoZCcUdSGkceXuzdDC12kgEVh0poBRbSKz+5KPwD5IBamaV
 nBMpqDv/qnBTlCMz6u+Xn+/qUy2CGPwYMKITCYPaUPFp0HmaIDQvgcKmwfHrzyS5EK+0+4O8l
 6Zm/AoFTy3LyzA9JqzTfdiQM8YTO9XtN0HJiteKgj6HNQgSE3TAWGoD4D0Vc7KcgO/j/JVlyj
 BxARl3e6MOX8rHnuW+egjj5g==

> A 'devm_kzalloc' in 'extcon_rtk_type_c_probe' could possibly return null=
 pointer.
> Add a null check for the returned pointer.

How do you think about a wording variant like the following?

  A devm_kzalloc() call can fail in this function implementation.
  Thus add a null pointer check and corresponding exception handling
  for the data structure member =E2=80=9Ctype_c_cfg=E2=80=9D.


=E2=80=A6
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> Reported-by: Zichen Xie <zichenxie0106@gmail.com>
=E2=80=A6

How good does such a tag combination fit together for the same person?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.11#n525


Can a subject like =E2=80=9C[PATCH] extcon: realtek: Prevent null pointer =
dereference in extcon_rtk_type_c_probe()=E2=80=9D
be more appropriate?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.11#n613


=E2=80=A6
> +++ b/drivers/extcon/extcon-rtk-type-c.c
> @@ -1371,6 +1371,12 @@ static int extcon_rtk_type_c_probe(struct platfor=
m_device *pdev)
>
>  	type_c->type_c_cfg =3D devm_kzalloc(dev, sizeof(*type_c_cfg), GFP_KERN=
EL);
>
> +	if (!type_c->type_c_cfg) {
> +		dev_err(dev, "Failed to allocate memory for type_c_cfg!\n");
> +		ret =3D -ENOMEM;
> +		goto err;
> +	}
> +
>  	memcpy(type_c->type_c_cfg, type_c_cfg, sizeof(*type_c_cfg));
=E2=80=A6


I suggest to omit an extra error message here.


By the way:
Would you become interested to add a jump target for the statement =E2=80=
=9Cret =3D -EINVAL;=E2=80=9D
(in two other if branches)?

Regards,
Markus

