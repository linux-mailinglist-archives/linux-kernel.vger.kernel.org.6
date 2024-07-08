Return-Path: <linux-kernel+bounces-243953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC21929CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878891F21B6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431741D555;
	Mon,  8 Jul 2024 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WadghP79"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A71D52D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720423034; cv=none; b=YMSzs+Tx3ft+UAaYMVKInJMS46zR4y+vzTQsxYVZwMBJuAltQpVDoEORfBCXuWB4pBhaGewnOYPaSXRsFrDncKDpZ2NohBMLxDKgnLtuQZNLecwipd2hF/Aiqt8t+XSeI4Wm/t6Qhfad8yI5+2PdbT7EH9P7jJcniTe11Tuh5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720423034; c=relaxed/simple;
	bh=vN1qPV7aqV+lGUAD0aSzllM6M3CntoLPoPMO+06F8OI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=GTYIribDQmzWVNp+PMaIMKDh6evYqPjkNhHsjo45cr2c5wB3KcmsHAbgKS1oKcO4JsVmkCbpTWIIrcRHWK6yVao9pxCCRV9GeoiauDHYwIakXwgVEkj6vjiNWFMg3cad1nnijoXqfr76bcJBTl1RcmTvOtslSPNlzvqmz3dJA/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WadghP79; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: zenghui.yu@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720423030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T36XZ8NE/xxyJanvS7KHX10z9vs3L4mHUQHRi7pq3/w=;
	b=WadghP79cOsglEKSb5MnvjchwOCRyosqU8qghV3Cfr90y2v4qkvBKAFnB9MviYBzSGLu1O
	pYyIkptuEw/cJqv0bSkOL247XTq9tCYFXJlysw9xyD4ImNRBFKJ7LVGo8Rw/IPKeynmPY0
	GEgK0tjn7RmI7hs1b9Q4XIWv+MpKHqI=
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: alexs@kernel.org
X-Envelope-To: siyanteng@loongson.cn
X-Envelope-To: corbet@lwn.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 08 Jul 2024 07:17:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: si.yanteng@linux.dev
Message-ID: <8096f15395443a9d6c0bc059baa43db1c743b0ac@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] docs/zh_CN/virt: Update the translation of
 guest-halt-polling.rst
To: "Zenghui Yu" <zenghui.yu@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: alexs@kernel.org, siyanteng@loongson.cn, corbet@lwn.net, "Zenghui Yu"
 <zenghui.yu@linux.dev>
In-Reply-To: <20240707161444.98715-1-zenghui.yu@linux.dev>
References: <20240707161444.98715-1-zenghui.yu@linux.dev>
X-Migadu-Flow: FLOW_OUT

2024=E5=B9=B47=E6=9C=888=E6=97=A5 00:14, "Zenghui Yu" <zenghui.yu@linux.d=
ev> =E5=86=99=E5=88=B0:



>=20
>=20Update to commit 1954d51592b5 ("Documentation: virt: correct location=
 of
>=20
>=20haltpoll module params") to fix the obvious mistake.
>=20
>=20Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>


BTW=EF=BC=8C

Since the maintainers may have set up email filtering rules,=20
let's=20send --to them.


Thanks,
Yanteng
>=20
>=20---
>=20
>=20 Documentation/translations/zh_CN/virt/guest-halt-polling.rst | 2 +-
>=20
>=20 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
>=20diff --git a/Documentation/translations/zh_CN/virt/guest-halt-polling=
.rst b/Documentation/translations/zh_CN/virt/guest-halt-polling.rst
>=20
>=20index b798d1cf0b48..463d1d829062 100644
>=20
>=20--- a/Documentation/translations/zh_CN/virt/guest-halt-polling.rst
>=20
>=20+++ b/Documentation/translations/zh_CN/virt/guest-halt-polling.rst
>=20
>=20@@ -76,7 +76,7 @@ guest_halt_poll_ns=E5=B0=86=E4=BF=9D=E6=8C=81=E9=AB=
=98=E4=BD=8D=EF=BC=89=E3=80=82
>=20
>=20=20
>=20
>  =E9=BB=98=E8=AE=A4=E5=80=BC: Y
>=20
>=20=20
>=20
> -=E6=A8=A1=E5=9D=97=E5=8F=82=E6=95=B0=E5=8F=AF=E4=BB=A5=E4=BB=8EDebugfs=
=E6=96=87=E4=BB=B6=E4=B8=AD=E8=AE=BE=E7=BD=AE=EF=BC=8C=E5=9C=A8::
>=20
>=20+=E6=A8=A1=E5=9D=97=E5=8F=82=E6=95=B0=E5=8F=AF=E4=BB=A5=E4=BB=8Esysfs=
=E6=96=87=E4=BB=B6=E4=B8=AD=E8=AE=BE=E7=BD=AE=EF=BC=8C=E5=9C=A8::
>=20
>=20=20
>=20
>  /sys/module/haltpoll/parameters/
>=20
>=20=20
>=20
> --=20
>=20
> 2.34.1
>

