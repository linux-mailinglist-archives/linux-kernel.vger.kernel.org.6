Return-Path: <linux-kernel+bounces-264477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217E093E3E3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 09:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A211F21802
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 07:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB1DAD51;
	Sun, 28 Jul 2024 07:13:21 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F08C07
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722150801; cv=none; b=Wpc04D6epxWFQqUg3g/oK2Kaoo+aawpwj9CJhuGS9/hzJsuqJbgfFgBVpeA4EIgfTVtY0k4yzMb94TB3840t6TtxZnc8PlFzQZnM9ws/XX5rex3skZrCoXSR7xq9PtyKiCz4S817d+PVEGBYdZZnlzKaIfgTDVrfucbsWYmL2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722150801; c=relaxed/simple;
	bh=7oum0ZDrEN3qwiUq8AXhZ20yryiL9I0AYm7niNRppK8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CYeRxf+mCll0fQHgy/io+bb63WYXHIy0dLSSjM2y+jZt7Zn2lDNkUtUZZr7dDPoeMuzDHiivByTs0c+phZgUYjuY3bnSFAHDM5AqQmKUW09u1aIJ4iF3wYphc7Y8EdL1PHvWMJDIAVGk/zwOGR6B5D8iTOU3QqZyURjVeha1DIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 57F3464A3D0A;
	Sun, 28 Jul 2024 09:13:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zBbUua_PVi0O; Sun, 28 Jul 2024 09:13:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E064564A3D19;
	Sun, 28 Jul 2024 09:13:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lMyUS_RjfNGb; Sun, 28 Jul 2024 09:13:09 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id C633664A3D0A;
	Sun, 28 Jul 2024 09:13:09 +0200 (CEST)
Date: Sun, 28 Jul 2024 09:13:09 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2116767413.129257.1722150789677.JavaMail.zimbra@nod.at>
In-Reply-To: <CAHk-=wjK1ZLk8TjejsRfDUH2Jp4=FPfD_GQU9z-m=bm75+jBMw@mail.gmail.com>
References: <896050924.123729.1722027514568.JavaMail.zimbra@nod.at> <CAHk-=wjK1ZLk8TjejsRfDUH2Jp4=FPfD_GQU9z-m=bm75+jBMw@mail.gmail.com>
Subject: Re: [GIT PULL] UBI and UBIFS updates for v6.11-rc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: UBI and UBIFS updates for v6.11-rc1
Thread-Index: 399OxDQ8G3+rh6/2Fi4Vrri1xYbQxg==

Linus,

----- Urspr=C3=BCngliche Mail -----
> Von: "torvalds" <torvalds@linux-foundation.org>
> Does nobody actually check the build output?
>=20
>  WARNING: modpost: drivers/mtd/ubi/ubi: section mismatch in
> reference: ubi_init+0x170 (section: .init.text) -> ubiblock_exit
> (section: .exit.text)
>=20
> and yes, this may be harmless on x86 (and several other
> architectures), because the exit.text is dropped at runtime because
> dropping it at link time will cause problems for altinstructions.
>=20
> BUT.
>=20
> The warning is very real, because on *other* architectures, the
> EXIT_TEXT sections may never be linked in at all, because something
> that is built-in never gets unloaded, so it never has a module exit.
>=20
> So __exit literally exists so that the code can be thrown away when not u=
sed.
>=20
> And now you're calling it from a non-exit place.
>=20
> End result: the warning exists for a reason, and it looks like commit
> 72f3d3daddd7 ("mtd: ubi: Restore missing cleanup on ubi_init() failure
> path") is just broken.
>=20
> I could try to fix this up in the merge, but honestly, the fact that
> apparently nobody bothered to even look at the new warning means that
> I just consider this whole pull completely buggered.
>=20
> I refuse to pull garbage that our build system very clearly warns about.

The issue was detected and fixed two weeks ago:
https://lore.kernel.org/linux-mtd/20240713073519.25325-1-richard@nod.at/

But I forgot to include my very own patch.
So, the failure is totally on my side, I'm sorry for that.

Do you allow me sending an updated pull requested?

Thanks,
//richard

