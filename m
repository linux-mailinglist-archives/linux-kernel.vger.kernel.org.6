Return-Path: <linux-kernel+bounces-218086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5152590B922
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E5128BDC8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D02198841;
	Mon, 17 Jun 2024 18:09:13 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B434E194A41
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647753; cv=none; b=pCrjd2h0HXVG8vpYBrmvUWVw3w2bmZ10zbT3C89wQju54aYS3xkilemesYL4vv28iFF5P9zZaTlqQV4oX1TcK8Z+fEcIQTAWF3tYdNSq5cypfgxupYlANVzQnEoCdG7+ofb7Ulzl0lmVLChe11rKjgxGMl4uqeIjT1Wl0xstfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647753; c=relaxed/simple;
	bh=f6scgY6PPn3i0YktPs71dAhdw8Fm0jCjCRTPKF5daSM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UgzJvO+XIvEHLyz3AuY2Tc8uowwdYqkwgP0wu3qqVDGyS4A0CyS+9RKO6itibJueKP6yFTRYEJB3yJf9nfDJU47fr2fYdipVRiW9jDTZl9TgSZ420VSqt9tJ0iYSD4sBbxaZLpq7ebFRGnA4F/2JbgOnfAkfC/AWLdTgMDMnvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5F02A61966C1;
	Mon, 17 Jun 2024 20:09:07 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id xtigWcKdybrJ; Mon, 17 Jun 2024 20:09:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E73B361966CE;
	Mon, 17 Jun 2024 20:09:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tipReWDeoSdk; Mon, 17 Jun 2024 20:09:06 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id C3B9A61966C1;
	Mon, 17 Jun 2024 20:09:06 +0200 (CEST)
Date: Mon, 17 Jun 2024 20:09:06 +0200 (CEST)
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
Message-ID: <303502000.252057.1718647746641.JavaMail.zimbra@nod.at>
In-Reply-To: <48D8B89B-0402-4D8B-B045-86104C0C797F@mac.com>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com> <14779870-BA54-4ABF-8ABF-FF1D23D172A7@mac.com> <1641029267.251608.1718640023954.JavaMail.zimbra@nod.at> <65E62DA3-EF16-44BD-8E51-E751BD2C496F@mac.com> <1802911356.251780.1718643160760.JavaMail.zimbra@nod.at> <E3E2C13C-1E52-46F2-BE2D-D2592C3369DB@mac.com> <F2DCFCE7-68FA-4C09-AE5B-09F2233575F1@mac.com> <48D8B89B-0402-4D8B-B045-86104C0C797F@mac.com>
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
Thread-Index: Cdy4KBaQSTQSx5jOia8rup/ThWcV7A==

----- Urspr=C3=BCngliche Mail -----
> Von: "Gagan Sidhu" <broly@mac.com>
> https://github.com/torvalds/linux/blob/master/drivers/mtd/ubi/gluebi.c#L2=
97
>=20
> it seems the GLUEBI is setting the mtd to MTD_UBIVOLUME
>=20
> https://github.com/torvalds/linux/blob/master/drivers/mtd/ubi/block.c
>=20
> where this doesn=E2=80=99t even have the text =E2=80=9Cmtd=E2=80=9D anywh=
ere.
>=20
> but the boot partition is always the ubiblock device.
>=20
> so is gluebi taking the same volume and adding the MTD_UBIVOLUME label or
> something?

Yes, GLUEBI emulates a MTD on top of an UBI volume.
It sets the MTD device type to MTD_UBIVOLUME.

>>=20
>> [    5.462504] auto-attach mtd7
>> [    5.462525] ubi0: default fastmap pool size: 15
>> [    5.477309] ubi0: default fastmap WL pool size: 7
>> [    5.486683] ubi0: attaching mtd7
>> [    5.811240] UBI: EOF marker found, PEBs from 273 will be erased
>> [    5.811299] ubi0: scanning is finished
>> [    5.874546] gluebi (pid 1): gluebi_resized: got update notification f=
or
>> unknown UBI device 0 volume 1
>> [    5.892927] ubi0: volume 1 ("rootfs_data") re-sized from 9 to 28 LEBs
>> [    5.906683] ubi0: attached mtd7 (name "ubi", size 40 MiB)
>> [    5.917446] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 126976 =
bytes
>> [    5.931132] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size =
2048
>> [    5.944654] ubi0: VID header offset: 2048 (aligned 2048), data offset=
: 4096
>> [    5.958513] ubi0: good PEBs: 320, bad PEBs: 0, corrupted PEBs: 0
>> [    5.970472] ubi0: user volume: 2, internal volumes: 1, max. volumes c=
ount:
>> 128
>> [    5.984859] ubi0: max/mean erase counter: 1/0, WL threshold: 4096, im=
age
>> sequence number: 1613475955
>> [    6.003045] ubi0: available PEBs: 0, total reserved PEBs: 320, PEBs r=
eserved
>> for bad PEB handling: 15
>> [    6.021426] rootfs: parsing partitions cmdlinepart
>> [    6.021444] ubi0: background thread "ubi_bgt0d" started, PID 97
>> [    6.043694] rootfs: got parser (null)
>> [    6.051426] mtd: device 12 (rootfs) set to be root filesystem

AFAICT, this log line is not part of the mainline kernel.

>> [    6.062891] rootfs_data: parsing partitions cmdlinepart
>> [    6.073669] rootfs_data: got parser (null)
>> [    6.211240] block ubiblock0_0: created from ubi0:0(rootfs)
>> [    6.259545] rtc-pcf8563 0-0051: hctosys: unable to read the hardware =
clock
>> [    6.282125] VFS: Cannot open root device "(null)" or unknown-block(31=
,12):
>> error -6
>> [    6.297406] Please append a correct "root=3D" boot option; here are t=
he
>> available partitions:
>> [    6.314054] 1f00             512 mtdblock0
>> [    6.314060]  (driver?)
>> [    6.327077] 1f01             256 mtdblock1
>> [    6.327081]  (driver?)
>> [    6.340101] 1f02             256 mtdblock2
>> [    6.340105]  (driver?)
>> [    6.353124] 1f03             256 mtdblock3
>> [    6.353129]  (driver?)
>> [    6.366153] 1f04           45056 mtdblock4
>> [    6.366158]  (driver?)
>> [    6.379175] 1f05           40572 mtdblock5
>> [    6.379179]  (driver?)
>> [    6.392217] 1f06            4096 mtdblock6
>> [    6.392222]  (driver?)
>> [    6.405240] 1f07           40960 mtdblock7
>> [    6.405244]  (driver?)
>> [    6.418272] 1f08           32768 mtdblock8
>> [    6.418277]  (driver?)
>> [    6.431296] 1f09           40960 mtdblock9
>> [    6.431300]  (driver?)
>> [    6.444324] 1f0a            6144 mtdblock10
>> [    6.444328]  (driver?)
>> [    6.457518] 1f0b            4608 mtdblock11
>> [    6.457523]  (driver?)
>> [    6.470720] fe00           33604 ubiblock0_0
>> [    6.470724]  (driver?)
>> [    6.484090] Kernel panic - not syncing: VFS: Unable to mount root fs =
on
>> unknown-block(31,12)

(31, 12) would be mtdblock12.
How does your kernel know that mtdblock12 shall be the rootfs?

I have a hard time understanding your current setup.

Thanks,
//richard

