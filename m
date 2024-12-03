Return-Path: <linux-kernel+bounces-429817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C79E266F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19F0167503
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0E11F8905;
	Tue,  3 Dec 2024 16:08:22 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE191E766E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242101; cv=none; b=QJmarGY/4N5JAiiMfQaJ7BIwTwcUxgqvZq32wlDhxlZ8T/zqL9jaiW+LmX2nHw1U1UJalpjycyXv/SpxBR39O6loc56xkji3A/h9rVglzf157tHiQt81z0b8jH38lGfBIjHf7l0iuoj36lYCuzN7JTU3Evu99CY1btZbnZ4SByc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242101; c=relaxed/simple;
	bh=+5WWu28U4ODpLRUk0K8QI2zA34vkoGCz8P6nQ4WQZZE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=eeorfS5FGyp37dksTC4PIzoXlzjktRbKSrq3wAeyYI9/9+IzC8JVCgUZ4yg+/Y71mPMM+XdEZ1gpWIIAReNbVCNRfrcxBhxzv6Tq8sFRDhEYCZKLsJ94fOYyRcF3RDDJMulnbWdyr+q1oTGMmme+q68+Y8WgC9nRDpQU5W8BLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E1AB22F25C3;
	Tue,  3 Dec 2024 17:08:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id A2Hg5nRiddH4; Tue,  3 Dec 2024 17:08:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 13FA82F25C4;
	Tue,  3 Dec 2024 17:08:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XblzBPG62Bmk; Tue,  3 Dec 2024 17:08:14 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E5B9B2F25C3;
	Tue,  3 Dec 2024 17:08:14 +0100 (CET)
Date: Tue, 3 Dec 2024 17:08:14 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pintu Agarwal <pintu.ping@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <342000380.28770675.1733242094522.JavaMail.zimbra@nod.at>
In-Reply-To: <87ldww4zrx.fsf@bootlin.com>
References: <CAOuPNLhxBBihr38p_XMQEgkiLFc+DPxkQf4oewF8U1+ihaFn-Q@mail.gmail.com> <CAOuPNLhhWzoBQH85zEd95LbONtrknq+b7tfcze50VPa9bEnXzw@mail.gmail.com> <87ldww4zrx.fsf@bootlin.com>
Subject: Re: Block based OTA update needs mtdblock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF133 (Linux)/8.8.12_GA_3809)
Thread-Topic: Block based OTA update needs mtdblock
Thread-Index: KPeQUzpe+8lfpBQ6hKGV/yDwHulGvw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> An: "Pintu Agarwal" <pintu.ping@gmail.com>
> CC: "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, =
"linux-mtd" <linux-mtd@lists.infradead.org>,
> "chengzhihao1" <chengzhihao1@huawei.com>, "linux-kernel" <linux-kernel@vg=
er.kernel.org>
> Gesendet: Dienstag, 3. Dezember 2024 15:17:06
> Betreff: Re: Block based OTA update needs mtdblock

> Hello,
>=20
> On 20/11/2024 at 12:52:57 +0530, Pintu Agarwal <pintu.ping@gmail.com> wro=
te:
>=20
>> Hi,
>>
>> On Mon, 4 Nov 2024 at 21:31, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>>>
>>> Hi All,
>>>
>>> For one of our automotive products we have the following configuration:
>>> QC chipset, arm64, Kernel-5.15, NAND Flash 1GB, A/B system, UBI
>>> volumes (squashfs, ubifs), DM-verity for rootfs (squashfs), simple
>>> busybox platform.
>>>
>>> For OTA updates we have a strong dependency with MTD_BLOCK.
>>>
>>> Till now, we were using ubiblock for mounting squashfs volumes and
>>> completely got rid of mtd_block by configuring it as a loadable
>>> module.
>>> But, we also need to support OTA updates (Full, Incremental) on A/B
>>> volumes using the same Android OTA framework.
>>> https://source.android.com/docs/core/ota/nonab/block
>>>
>>> OTA update will be applied to the B (inactive) partition.
>>> OTA updates prefer block based update over file based especially for
>>> dm-verity enabled devices.
>>>
>>> Now, the problem is, on MTD we only have 2 options for block based
>>> updates; ubi_block or mtd_block.
>>> We cannot use ubiblock for OTA updates as it is read only.
>>> For full update volume, we can use "ubiupdatevol" interface to
>>> completely replace the volume content, but for partial or incremental
>>> update we need to update only specific blocks and not entire
>>> partitions.
>>> Thus, we have to use the MTD_BLOCK (/dev/mtdblock) interface to
>>> support block based OTA updates on UBI volumes.
>>> Thus, during ota updates (only) we need to install the mtdblock
>>> module, perform the update and then uninstall the module.
>>>
>>> That means, we cannot completely get rid of MTD_BLOCK from our product
>>> especially for OTA use cases.
>>>
>>> Is this the only way, or do we have any other option to support OTA
>>> updates over UBI volumes ?
>>>
>> Restarting this thread again...
>> Any further comment on this ?
>>
>> Did anybody used block based OTA update NAND A/B system without using
>> mtd_block ?
>=20
> Not on my side, it is actually a good question. Richard, any ideas?

What about using ubiupdatevol?

Thanks,
//richard

