Return-Path: <linux-kernel+bounces-217972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C9390B711
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F4A1C231DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29B8166305;
	Mon, 17 Jun 2024 16:52:46 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2051369A8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643166; cv=none; b=mXxSKTpHUwyrWaXQuIdlLbs0Yasu32F32IKicezy2B9YgnOpOneBJ5MppOeZji4yda9TgeVy5V++56OeGvY13rJdUaPehbJ6S3jiJoG0fMc8FBm0XKKgGie9i0qIJyliPhG1/IZWJy/XDZgNn2cOisFrlDnXseGH/ZTipNIvQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643166; c=relaxed/simple;
	bh=CcAJqzNSlaf+l+Rz+hZwCU+gUQtZqN2sKhsZylP4k2c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=WiBXhiE54jO65OtUUHPtojU5X0yp+jCjHohqAURBdfTpmlrUkTbOzVdp1e/17MeHYS5/Ucjplj9JXw2UCfRnamh/a2aTtuNM0e/DAYR/uTedIGF9Ehez+JTgANijg9Elpc4Xbrav5wpo/7mr1BXTT1aVL61tJP2tm7EyolslzI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 619E26195FC1;
	Mon, 17 Jun 2024 18:52:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rVZusyb9lOqr; Mon, 17 Jun 2024 18:52:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0EE376195FC6;
	Mon, 17 Jun 2024 18:52:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Srg5VmlXEUGF; Mon, 17 Jun 2024 18:52:40 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id DF1846195FC1;
	Mon, 17 Jun 2024 18:52:40 +0200 (CEST)
Date: Mon, 17 Jun 2024 18:52:40 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Gagan Sidhu <broly@mac.com>
Cc: ZhaoLong Wang <wangzhaolong1@huawei.com>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	dpervushin <dpervushin@embeddedalley.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	yangerkun <yangerkun@huawei.com>, yi zhang <yi.zhang@huawei.com>
Message-ID: <1802911356.251780.1718643160760.JavaMail.zimbra@nod.at>
In-Reply-To: <65E62DA3-EF16-44BD-8E51-E751BD2C496F@mac.com>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com> <561660214.251562.1718638970757.JavaMail.zimbra@nod.at> <14779870-BA54-4ABF-8ABF-FF1D23D172A7@mac.com> <1641029267.251608.1718640023954.JavaMail.zimbra@nod.at> <65E62DA3-EF16-44BD-8E51-E751BD2C496F@mac.com>
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: gluebi: Fix NULL pointer dereference caused by ftl notifier
Thread-Index: CeaQ9NY8GO3IkkuxNvz0If8vASUkgg==

----- Urspr=C3=BCngliche Mail -----
> Von: "Gagan Sidhu" <broly@mac.com>
> i don=E2=80=99t think my articulation is correct if you interpreted it as=
 that.
>=20
> as i understand it, gluebi simply makes it handy when you have a filesyst=
em
> packed within a ubi file, and it will take that file and mount itas a blo=
ck
> device.

There is no such thing as an UBI file. UBI hosts volumes.
You can install into these volumes whatever you want.
Also a file system such as UBIFS, but this seems not to be the case here.

> so i would say it=E2=80=99s not MTD->UBI->GLUEBI->MTD->MTDBLOCK
>=20
> it=E2=80=99d say it=E2=80=99s more MTD->GLUEBI->MTDBLOCK

No. GLUBI emulates a MTD on top of an UBI volume.
So every read/write operation of the filesystem will first to through:

1. block layer
2. MTDBLOCK (and mtd)
3. GLUBI
4. UBI
5. MTD (this time the real one)

Is this really a setup OpenWRT is using?
I'm not saying it's impossible, but far from ideal.
We have UBIBlock for reasons.

Anyway, since the kernel has to be user space friendly and
users seems to use such "odd" stackings I consider reverting this patch.
ZhaoLong Wang, what do you think?

Thanks,
//richard

