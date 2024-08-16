Return-Path: <linux-kernel+bounces-289051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F007C954195
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32619287C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77E98002A;
	Fri, 16 Aug 2024 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="njbwOQDa"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9D3F9D5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788944; cv=pass; b=pF4YrwDTuIzHM5B5G6v7pqLm8HyQQ1vfMNQTPh/uC/ZKnKfqPuWWadS3aeR+WrIX3uydRR4pjhZ6O6LVLINO1dkQXci7m/99jrDmmbqy6aww/aqv7ZS+8ONb7zPHs/ZYtc4lZis0W1TON+layc7glXe6ZZp6L56h88Zq11zSrak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788944; c=relaxed/simple;
	bh=KmfzcANG1jJYcmlBv8tTgZiMUSg7kBDe4kW7Q+be5pQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLtf1q/Fq6OrKAvNzCx2gsrF4UykiF5sHAkLoNJibb9hKcqWQg92ise+6hlBHmqK49KOT9PH79syMw3Zqh+aQKIwMmsN4Jz4Jk7Rs7Y2ZPMY9cVfsDFamFEXKrtYI5MNyo+kekDzw1eO58Y353oMaqGBusU2B0pp5iT8Yqq5jO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=njbwOQDa; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1723788933; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NffyhWjs0v579e98Jq4Vbg1JHIF1GgQaeBr43KRcITG1jIbfVyP6hKQ0Mbz65dXEa5AHon2fyUHB6tO3ZbtSYHmc0jjT2SNPN9AkPd2TJm5bSTvTQG2bbZSCS+MK+mIOSvL02ieaMLUVRQFjrcaaQ8I7ZNVNHPnGafMG59xrHMQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723788933; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KmfzcANG1jJYcmlBv8tTgZiMUSg7kBDe4kW7Q+be5pQ=; 
	b=TdlhgD3kIEGG1YlYzCL8nxGcEuPM7gR5QD93gMJpf80oiba+8oJh5bfkvsD/2X4IL0U3ftjyMD9jt68H50sxNeC25hqVHIRkgcFAArMksXT/Q/UhJ0DK3ZpYmfQV5maRz7fRmFnrlneRbKXuQ5ztqUXjyWCN+pMsZPWzIv8C2ms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723788933;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=KmfzcANG1jJYcmlBv8tTgZiMUSg7kBDe4kW7Q+be5pQ=;
	b=njbwOQDaP5uNdwchtKxgRAv93Vgq6F6nVHPEmNa/e7//lR8hhorizQeITg7Q0rjI
	5y1KAJNo2G4+WTBJRXcLUe6TvHYXqPuUhN/NB1cCAYsTAT9ICEJVVgNGC/XbbFawSVM
	Xq5sD0ofJfsB9R1t9v1e9TsPCY1piYm9GWHcoGf+6vMLxiOreBLcALlNZmOiSHbHU6V
	9XJpjngWoBPJq3V8hk0A8+eHu7DleWVU4OQCnj3YY2ns2ufrCHfnGOyIytVpBtjRb+v
	5WvycTuJ6cNT5ZF6tLhEk9Px7b9EpqYv6Vb0W9gxmbSihq8IPRJeI979Z2ieFcX4Qy/
	e6RxXaA9gQ==
Received: by mx.zohomail.com with SMTPS id 1723788931430682.4435507538188;
	Thu, 15 Aug 2024 23:15:31 -0700 (PDT)
Message-ID: <0ab5fcb4ace2e009556b6a597a55b143a00a6093.camel@icenowy.me>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
From: Icenowy Zheng <uwu@icenowy.me>
To: Palmer Dabbelt <palmer@dabbelt.com>, tglx@linutronix.de
Cc: Renner Berthing <emil.renner.berthing@canonical.com>, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	apatel@ventanamicro.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	samuel.holland@sifive.com, aou@eecs.berkeley.edu, daniel.lezcano@linaro.org
Date: Fri, 16 Aug 2024 14:15:25 +0800
In-Reply-To: <mhng-5403a4a9-4cdf-447f-9c7e-ea655a2f86fc@palmer-ri-x1c9>
References: <mhng-5403a4a9-4cdf-447f-9c7e-ea655a2f86fc@palmer-ri-x1c9>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2024-08-15=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 10:51 -0700=EF=BC=
=8CPalmer Dabbelt=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, 14 Aug 2024 10:30:48 PDT (-0700), tglx@linutronix.de=C2=A0wrote:
> > On Wed, Aug 14 2024 at 16:56, Emil Renner Berthing wrote:
> > > As described in the thread below[1] I haven't been able to boot
> > > my
> > > boards based on the Allwinner D1 SoC since 6.9 where you
> > > converted the
> > > SiFive PLIC driver to a platform driver.
> > >=20
> > > This is clearly a regression and there haven't really been much
> > > progress
> > > on fixing the issue since then, so here is the revert that fixes
> > > it.
> > >=20
> > > If no other fix is found before 6.11 I suggest we apply this.
> >=20
> > So this mess has been ignored for two month now?
> >=20
> > > From the pastebin in the initial report:
> >=20
> > [=C2=A0=C2=A0=C2=A0 0.000000] irq: no irq domain found for
> > interrupt-controller@10000000 !
> > [=C2=A0=C2=A0=C2=A0 0.000000] Failed to map interrupt for /soc/timer@20=
50000
> > [=C2=A0=C2=A0=C2=A0 0.000000] Failed to initialize '/soc/timer@2050000'=
: -22
> >=20
> > This comes back with -EINVAL. So the timer cannot find an
> > interrupt,
> > which makes it pretty obvious why the system stops to boot, unless
> > there
> > is some other timer available.
> >=20
> > This is obviously related to the SUN4I_TIMER because that message
> > went
> > away when it was disabled according to the next pastebin.
> >=20
> > Obviously that can't work because the SUN4I timer driver is using
> > timer_of_init() which cannot handle deferred probing.
> >=20
> > Daniel: There was a partial fix for the sun4i driver, which you
> > said you
> > applied:
> >=20
> > =C2=A0
> > https://lore.kernel.org/all/20240312192519.1602493-1-samuel.holland@sif=
ive.com
> >=20
> > But that thing never materialized in a pull request.
> >=20
> > And of course everyone involved ignored the problem since March
> > 13th
> > 2024, i.e. almost half a year.
> >=20
> > Seriously?
> >=20
> > Can you RISCV folks get your act together and ensure to fix things
> > you
> > broke on the way? Especially when Emil reported this nobody pointed
> > him
> > to this patch and nobody noticed that it's still not merged?
> >=20
> > It took me less than 15 minutes to find that patch and the
> > correlation,
> > but this is absolutely not my job.
>=20
> Sorry, I guess I'd just sort of been ignoring the platform-specific
> side=20
> of things because it's so frustrating to deal with, but that's led to
> a=20
> bunch of breakages so it's obviously the wrong thing to do.
>=20
> > I'm seriously grumpy about that. This is not how it works. If you
> > break
> > stuff, then you take care to fix it before you shove more changes
> > into
> > the tree and waste my time.
> >=20
> > I'm very much inclined to take the reverts right now, send them to
> > Linus
> > for -rc5 tagged with cc: stable and ignore/nak any irqchip related
> > riscv
> > patches until the next merge window is over.
>=20
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> if you want to take the revert.
>=20
> IIUC the patch above doesn't actually fix it, that's what led to just
> sending the reverts -- at least reverts are better than breaking
> users.=C2=A0=20
> I'll post over there too...
>=20
> And it's no big deal if we're in the doghouse for a bit.=C2=A0 Regression=
s
> should get fixed faster than this, so we deserve it.
>=20
> Probably also another sign we're way too focused on getting new
> features=20
> merged, as that's coming at the expense of making existing platforms=20
> work.=C2=A0 IMO we've been way too focused on getting support for specs
> that=20
> don't even have implementations, and not enough on building real
> working=20
> systems.

Well I think all existing platforms are more or less weird (in
specification-compatibility, stability, etc). (Maybe FU540 isn't so
weird, but it has too few peripherals to be really useful, and it's
discontinued; FU740 has some stability issues.)

>=20
> > Emil, can you give that sun4i fix a test ride please?
> >=20
> > Thanks,
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tglx
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


