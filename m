Return-Path: <linux-kernel+bounces-217900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D827A90B5AE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E1921F2159F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00B136E18;
	Mon, 17 Jun 2024 16:00:29 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F6DDC5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640028; cv=none; b=MnUFbBElbRXjUS0fQXDRbm8weJS+md0IPaxLseT8912qZ1+MO6ga6sEHgGittU40+cMLxAcBvDSJG/o+ZZIrPvz8OsgeJSMF2SVpmnN6Ap/1E/EEJWTDlMrC31kJ92RTRD5UPwytS4PYpYgPSasNGv4lYNHyZJ9P75GrNALl9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640028; c=relaxed/simple;
	bh=wclLHlqlNr7EwY24bnx4bSv1OtoPWn8hmuoiv7DVQqE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=X+WwARWoNzdN76iczCvWZ5K6B/4DdCaxfpTpcirNlGW8eBGhcsqbdonKzVRZhxlWU6bVtCWQ61Es5xJgPoDwxLyGIAeMwtIQoXOj54IyO5CzxRbFNmO3InlR6J9OEnQmh/EXKZ0fxx1VLM+IDZ5/VYfReHInHJzyORyILl1GTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 9617961966A6;
	Mon, 17 Jun 2024 18:00:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id djS-ZRq9K2u8; Mon, 17 Jun 2024 18:00:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 40D4B61966CF;
	Mon, 17 Jun 2024 18:00:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IgyOjvHuzgzt; Mon, 17 Jun 2024 18:00:24 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1701261966A6;
	Mon, 17 Jun 2024 18:00:24 +0200 (CEST)
Date: Mon, 17 Jun 2024 18:00:23 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Gagan Sidhu <broly@mac.com>
Cc: ZhaoLong Wang <wangzhaolong1@huawei.com>, 
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>, 
	chengzhihao1 <chengzhihao1@huawei.com>, 
	dpervushin <dpervushin@embeddedalley.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	yangerkun <yangerkun@huawei.com>, yi zhang <yi.zhang@huawei.com>
Message-ID: <1641029267.251608.1718640023954.JavaMail.zimbra@nod.at>
In-Reply-To: <14779870-BA54-4ABF-8ABF-FF1D23D172A7@mac.com>
References: <CFAC276E-E652-40CD-B3D8-563B95E679A8@mac.com> <561660214.251562.1718638970757.JavaMail.zimbra@nod.at> <14779870-BA54-4ABF-8ABF-FF1D23D172A7@mac.com>
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
Thread-Index: GratdiGYJcZL29llyYc0ImwlBGth1Q==

----- Urspr=C3=BCngliche Mail -----
> Von: "Gagan Sidhu" <broly@mac.com>
> yes, i have a squashfs inside a ubi volume, and i create ubi block device=
 from
> it.
>=20
> i do use config_mtd_ubi_block because the filesystem is squashfs.
>=20
> so i think it=E2=80=99s affirmative to both questions. gluebi for the blo=
ck device from
> the ubi.fs file, then config_mtd_ubi_block to mount this read-only filesy=
stem
> as a block device.
>=20
> the end result of both options is a read-only block device that can handl=
e bad
> blocks on nand devices.
>=20
> if i was using an M25P80, i wouldn=E2=80=99t even be using ubi.
>=20
> so CONFIG_MTD_UBI_{GLUEBI,BLOCK} are handy for cases where you need an mt=
d block
> device with a read-only file system where the UBI takes care of the
> idiosyncrasies that make NAND (imo, ofc) inferior to SPI

Isn't MTD -> UBI -> GLUBI -> MTD -> MTDBLOCK performance wise a nightmare?
We have UBIBlock for this use case.

Thanks,
//richard

