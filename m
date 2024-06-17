Return-Path: <linux-kernel+bounces-218149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A9B90B9C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1365B1C2181F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559FC198E99;
	Mon, 17 Jun 2024 18:32:38 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A419198A35
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649157; cv=none; b=rRapmUF7qgrtxKcDp9xxOlfEwu8iPIW5QAMELVKH65gKBJrDWPCG85DudDch6v/wx+s+5Wpw6ZHgIijDbFhaOqV6L9wPROTWQeeimAGutAlXg1Rm5LfNw5FuuQw0C42aWm9ijxoC5+LJvcTIfIvjTsZ2exODxYz+Ykh3oUEHzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649157; c=relaxed/simple;
	bh=wHRGEXV+5MLUWQFTGrBO2VVMR0FMKeHf7+JTnjbxGzQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PJSCeQQ8VNaQol/3HPtcV8a8LJRDqriJNj6oRlvITKtsF80MFWJxPVt+2v19a6HI9WIGH3Jx4NxFzyx8Dg+GIRubhCLn2PW7QbD3uJ/NvwxvyTH45mhdh9jJseMsA6xPVuWxxuP2qF09H6uMbPTTcZVoH59NwhjQX8QH0thpAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C21D96195FC1;
	Mon, 17 Jun 2024 20:32:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id uj6G_8ViNRWY; Mon, 17 Jun 2024 20:32:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 60BD26195FC9;
	Mon, 17 Jun 2024 20:32:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ua9djD9Zizs6; Mon, 17 Jun 2024 20:32:33 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2ACF76195FC1;
	Mon, 17 Jun 2024 20:32:33 +0200 (CEST)
Date: Mon, 17 Jun 2024 20:32:33 +0200 (CEST)
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
Message-ID: <296007365.252185.1718649153090.JavaMail.zimbra@nod.at>
In-Reply-To: <90A90DA4-8B68-432D-9577-0D3635AF84BB@mac.com>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com> <65E62DA3-EF16-44BD-8E51-E751BD2C496F@mac.com> <1802911356.251780.1718643160760.JavaMail.zimbra@nod.at> <E3E2C13C-1E52-46F2-BE2D-D2592C3369DB@mac.com> <F2DCFCE7-68FA-4C09-AE5B-09F2233575F1@mac.com> <48D8B89B-0402-4D8B-B045-86104C0C797F@mac.com> <303502000.252057.1718647746641.JavaMail.zimbra@nod.at> <90A90DA4-8B68-432D-9577-0D3635AF84BB@mac.com>
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
Thread-Index: HOqizlmOCpgWy2ydOysUW2cuHjp5xg==

----- Urspr=C3=BCngliche Mail -----
> Von: "Gagan Sidhu" <broly@mac.com>
>> AFAICT, this log line is not part of the mainline kernel.
>=20
> this is mainline. it=E2=80=99s just not 6.x. it=E2=80=99s 4.14.

I've double checked and disagree.
This line comes from:
https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/linux/=
generic/pending-4.14/480-mtd-set-rootfs-to-be-root-dev.patch;h=3D6cddaf01b7=
5cb58cfb377f568f2c375af87e2f1b;hb=3Dc3bd1321de1e0d814f5cfc4f494f6b2fb1f5133=
b

In recent OpenWRT kernels I see:
https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dblob;f=3Dtarget/linux/=
generic/pending-5.15/493-ubi-set-ROOT_DEV-to-ubiblock-rootfs-if-unset.patch=
;h=3D266a6331c2acc0f7c17d9ac72f54659d31b56249;hb=3DHEAD

Looks like in recent versions the patch in question does *not* cause a regr=
ession.

>> (31, 12) would be mtdblock12.
>> How does your kernel know that mtdblock12 shall be the rootfs?
>=20
> this is an openwrt approach: https://openwrt.org/docs/techref/filesystems=
 (under
> =E2=80=9Ctechnical details=E2=80=9D, third paragraph)
>=20
> essentially there=E2=80=99s a feature they add to the kernel (via patch) =
where you can
> enable a feature that sets the root device based on the name of the parti=
tion.

So, this is all not mainline. :-/
=20
> in this case as long as the volume within your ubi file contains the name
> =E2=80=9Crootfs=E2=80=9D, openwrt will follow it as it gets unpacked and =
set that as the
> rootdevice for you.

Thanks,
//richard

