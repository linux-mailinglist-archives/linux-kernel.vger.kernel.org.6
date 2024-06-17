Return-Path: <linux-kernel+bounces-218176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5FD90BA23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC30E1C23295
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFF5198E85;
	Mon, 17 Jun 2024 18:53:02 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B21D952E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650381; cv=none; b=eOsLmot8Ufn9ClsmazuVL5uNs9gihBAtmq22ALFGMyNVX3f9j+f5eEx6v7x9YlweaqKde+q2IfkByRNPzfy10PJD7YzomKLi+6QKXuPEpBmn3tfI6y0P9FDKM9XBwKKlhZejtltJEt+H+a1q3it6hGw3rX/Q6RvZzvWdfOmIrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650381; c=relaxed/simple;
	bh=UY0WXIOBDORhqFoocdXv7q/5wTE5OvwFLc7PMpLK1po=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=m7C+3ZGq/OcoDMARR2YrCQ+QcuFqeJuFgdqJeqafHUrVr6t3IsOiG6H50MATaruEMPXVb+ikHIGgmueWXuZl9HaM+Ai4dmvRyudMo8940XDcYA1jLfTgc1U/rI74cFMITptpCphkjKdWmbvKbdDsBtWMqNgWaRTE8WFFm6maCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 729576195FC1;
	Mon, 17 Jun 2024 20:52:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id p5T_CLvWV-4B; Mon, 17 Jun 2024 20:52:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B32216195FC9;
	Mon, 17 Jun 2024 20:52:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IVEfxcUz4X1Q; Mon, 17 Jun 2024 20:52:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8F4166195FC1;
	Mon, 17 Jun 2024 20:52:55 +0200 (CEST)
Date: Mon, 17 Jun 2024 20:52:55 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Gagan Sidhu <broly@mac.com>
Cc: ZhaoLong Wang <wangzhaolong1@huawei.com>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	dpervushin <dpervushin@embeddedalley.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	yangerkun <yangerkun@huawei.com>, yi zhang <yi.zhang@huawei.com>, 
	daniel@makrotopia.org
Message-ID: <136290141.252319.1718650375432.JavaMail.zimbra@nod.at>
In-Reply-To: <3841F21D-CA54-456C-9D9C-F06EEA332A30@mac.com>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com> <E3E2C13C-1E52-46F2-BE2D-D2592C3369DB@mac.com> <F2DCFCE7-68FA-4C09-AE5B-09F2233575F1@mac.com> <48D8B89B-0402-4D8B-B045-86104C0C797F@mac.com> <303502000.252057.1718647746641.JavaMail.zimbra@nod.at> <90A90DA4-8B68-432D-9577-0D3635AF84BB@mac.com> <296007365.252185.1718649153090.JavaMail.zimbra@nod.at> <3841F21D-CA54-456C-9D9C-F06EEA332A30@mac.com>
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
Thread-Index: rDTq+bzWquJWh3BCcONeC8Jg3XzswQ==

[CC'ing Daniel]

----- Urspr=C3=BCngliche Mail -----
> Von: "Gagan Sidhu" <broly@mac.com>
> An: "richard" <richard@nod.at>
> CC: "ZhaoLong Wang" <wangzhaolong1@huawei.com>, "chengzhihao1" <chengzhih=
ao1@huawei.com>, "dpervushin"
> <dpervushin@embeddedalley.com>, "linux-kernel" <linux-kernel@vger.kernel.=
org>, "linux-mtd"
> <linux-mtd@lists.infradead.org>, "Miquel Raynal" <miquel.raynal@bootlin.c=
om>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> "yangerkun" <yangerkun@huawei.com>, "yi zhang" <yi.zhang@huawei.com>
> Gesendet: Montag, 17. Juni 2024 20:46:10
> Betreff: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused =
by ftl notifier

>> On Jun 17, 2024, at 12:32 PM, Richard Weinberger <richard@nod.at> wrote:
>>=20
>> ----- Urspr=C3=BCngliche Mail -----
>>> Von: "Gagan Sidhu" <broly@mac.com>
>>>> AFAICT, this log line is not part of the mainline kernel.
>>>=20
>>> this is mainline. it=E2=80=99s just not 6.x. it=E2=80=99s 4.14.
>>=20
>> I've double checked and disagree.
>> This line comes from:
>> https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/lin=
ux/generic/pending-4.14/480-mtd-set-rootfs-to-be-root-dev.patch;h=3D6cddaf0=
1b75cb58cfb377f568f2c375af87e2f1b;hb=3Dc3bd1321de1e0d814f5cfc4f494f6b2fb1f5=
133b
>=20
> no i know that, that=E2=80=99s the patch i showed you. i meant the rest o=
f it is
> mainline. the patch obviously is not.
>>=20
>> In recent OpenWRT kernels I see:
>> https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/lin=
ux/generic/pending-5.15/493-ubi-set-ROOT_DEV-to-ubiblock-rootfs-if-unset.pa=
tch;h=3D266a6331c2acc0f7c17d9ac72f54659d31b56249;hb=3DHEAD
>>=20
>> Looks like in recent versions the patch in question does *not* cause a
>> regression.
>=20
> that patch is also applied in my version as well, so i don=E2=80=99t see =
how this avoids
> the regression.
>=20
> https://github.com/torvalds/linux/blob/master/drivers/mtd/mtdcore.c#L774
>=20
> mine says "[6.051426] mtd: device 12 (rootfs) set to be root filesystem"
>=20
> which is simply the call from drivers/mtd/mtdcore.c
>=20
> so the rootfs device is set correctly. it=E2=80=99s just not booting from=
 it.
>=20
> the regression comes from having GLUEBI+BLOCK enabled, it seems, are they
> fighting for/operating on the same partition?

I don't know. Let's ask Daniel.

>=20
>>=20
>>>> (31, 12) would be mtdblock12.
>>>> How does your kernel know that mtdblock12 shall be the rootfs?
>>>=20
>>> this is an openwrt approach: https://openwrt.org/docs/techref/filesyste=
ms (under
>>> =E2=80=9Ctechnical details=E2=80=9D, third paragraph)
>>>=20
>>> essentially there=E2=80=99s a feature they add to the kernel (via patch=
) where you can
>>> enable a feature that sets the root device based on the name of the par=
tition.
>>=20
>> So, this is all not mainline. :-/
>=20
> i did say openwrt at the start, and i think that=E2=80=99s pretty close t=
o mainline as
> it gets.
>=20
> sometimes these patches aren=E2=80=99t appropriate to push upstream. this=
 one is not the
> one causing the issue.
>=20
> it seems to me that there is a problem with GLUEBI+BLOCK playing together=
.
>=20
> as far as i can see, the setting of the device is being doing by mtdcore.=
c
>=20
> it=E2=80=99s just not working with gluebi and block are enabled, and i ne=
ed to know
> whether disabling gluebi will allow it to work.
>=20
> in other words, is it possible for gluebi to use the partition created by
> ubi_block, and add the MTD_UBIVOLUME flag?

No. UBIBlock works on top of UBI volumes and creates a block device.

We'll sort this out. :)

Thanks,
//richard

