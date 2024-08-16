Return-Path: <linux-kernel+bounces-289046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B810C954190
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2531F231F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B489681749;
	Fri, 16 Aug 2024 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="aI6pOSuC"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D232E859
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788821; cv=pass; b=ifkS3kVb9bdujzlVaeeguVpBA9+YcVdqauIxyOk9VqYuNzB0+hUf8UgiBDH66DSnyGMfwy3zPGZm9WyHKq1nM1ox/H697JGIZRcnJA8E4sta24C897pQ2GEIr3kjTcWpKTSc0DUvfHLYuJWzCGeJhLe2/hwSN4Ym6Q7X4ArTwxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788821; c=relaxed/simple;
	bh=Gfl8VFVe9SudC5dNo0Vko5rZXrIMnvULISri7qS66o8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y1INc/u4YaDUmkDf9GD1awfOxJnuSRt0cGo5EyTF4wawKGahSyfv/B9iYlaOWc8IsnR/UPPW+Cflq1qJ3eoRT//vnfwLLX3zZOA5UPR+6c8ZgVuFZYBzqBsnktWDaTTsNO4/NITtE4zMK5XYRQAmXfhMVc8VO/vG8eVJnyX1h6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=aI6pOSuC; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1723788809; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EhKosFnfNWWM8xgQzE3NmnFOUNmJHw7TnXxuJFPaFm2my/E4YgthNXpjXBisMr7gKSivMgUXwX/1mo4dobiqSb3ZTbjAs4yITbaF2aSOK86+tyL8kcARGDtrkshtG2HkODC2Fe1r97UlmRv7oMoSwBVkFSF8m9gaKrXtqRUSf04=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723788809; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Gfl8VFVe9SudC5dNo0Vko5rZXrIMnvULISri7qS66o8=; 
	b=aqZpQ0e3cm5TpA/aUbE2tRIM2+oqT5SlKq5BnN7SPtG2PEccZXpS1Arg3iCgGchVYCS+OUZAQgzmJh9sE8Pt8TXeSr4iftOhQKaXOakg0cniMfpmtK0MaYG/hBs03kda1bUOy6td8+lCp98ZJ3sW+apj5EZGii3347WGP7k88hg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723788809;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=Gfl8VFVe9SudC5dNo0Vko5rZXrIMnvULISri7qS66o8=;
	b=aI6pOSuCWBtu/LBWu2OT1dlgznfBhDnqSkEUanWs1xX1BaPhQyowmB79D2SdbOJE
	vyRzP8HSpBStRLrp/4DFfxf67BvoWvjKRM89v1237gMou8J8rZb1R4UkbErbX8SqS/F
	NmV5U4gm9buqAKLBbRQ/ViDirUzgxdArmLtKSiUcaQ/J6zGYxT43EGy0gaIITSeERc8
	6GyGdHpj6cew40U3yG1LD+cIkTTKE4pqM/cSVfXoCyDWiCuPMMX8i5I6+DkAjvMq1Ah
	S3+XAEFgtsCtQrO4VHapBfVD2zz+tmcUng/WLfFhNz6/ipJuoaxm7JTzrSzjXnLCs8I
	+SQM2JEN2w==
Received: by mx.zohomail.com with SMTPS id 1723788808212420.4473854459512;
	Thu, 15 Aug 2024 23:13:28 -0700 (PDT)
Message-ID: <74d255be524594806b6f9a2cd8bb6d2ab4915340.camel@icenowy.me>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
From: Icenowy Zheng <uwu@icenowy.me>
To: Palmer Dabbelt <palmer@dabbelt.com>, samuel.holland@sifive.com
Cc: Renner Berthing <emil.renner.berthing@canonical.com>, 
	apatel@ventanamicro.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	aou@eecs.berkeley.edu, daniel.lezcano@linaro.org
Date: Fri, 16 Aug 2024 14:13:22 +0800
In-Reply-To: <mhng-91e79885-7652-42a4-aad0-f4713e7ac70d@palmer-ri-x1c9>
References: <mhng-91e79885-7652-42a4-aad0-f4713e7ac70d@palmer-ri-x1c9>
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
> On Thu, 15 Aug 2024 08:59:37 PDT (-0700),
> samuel.holland@sifive.com=C2=A0wrote:
> > Hi Emil,
> >=20
> > On 2024-08-15 10:07 AM, Emil Renner Berthing wrote:
> > > Samuel Holland wrote:
> > > > On 2024-08-15 9:16 AM, Anup Patel wrote:
> > > > > On Thu, Aug 15, 2024 at 7:41=E2=80=AFPM Thomas Gleixner
> > > > > <tglx@linutronix.de> wrote:
> > > > > >=20
> > > > > > On Thu, Aug 15 2024 at 08:32, Samuel Holland wrote:
> > > > > > > On 2024-08-15 8:16 AM, Thomas Gleixner wrote:
> > > > > > > > Yes. So the riscv timer is not working on this thing or
> > > > > > > > it stops
> > > > > > > > somehow.
> > > > > > >=20
> > > > > > > That's correct. With the (firmware) devicetree that Emil
> > > > > > > is using, the OpenSBI
> > > > > > > firmware does not have a timer device, so it does not
> > > > > > > expose the (optional[1])
> > > > > > > SBI time extension, and sbi_set_timer() does nothing.
> > > > > >=20
> > > > > > Sigh. Does RISCV really have to repeat all mistakes which
> > > > > > have been made
> > > > > > by x86, ARM and others before? It's known for decades that
> > > > > > the kernel
> > > > > > relies on a working timer...
>=20
> It's even worse than that: RISC-V doesn't even mandate any working=20
> _instructions_, much less anything in the platform/firmware.
>=20
> > > > > My apologies for the delay in finding a fix for this issue.
> > > > >=20
> > > > > Almost all RISC-V platforms (except this one) have SBI Timer
> > > > > always
> > > > > available and Linux uses a better timer or Sstc extension
> > > > > whenever
> > > > > it is available.
> > > >=20
> > > > So this is the immediate solution: add the CLINT to the
> > > > firmware devicetree so
> > > > that the SBI time extension works, and Linux will boot without
> > > > any code changes,
> > > > albeit with a higher-overhead clockevent device.
> > >=20
> > > But this will mean that you can't update your kernel to v6.9 or
> > > newer without
> > > reflashing OpenSBI and u-boot. That's still a regression right?
>=20
> Ya, I'd call that a regression.=C2=A0 Updating the firmware on these
> things=20
> isn't generally something we can rely on users to do, we've worked=20
> around other firmware bugs where we can to avoid forced updates.
>=20
> > I suppose that depends on if you think the SBI time extension is
> > (or should have
> > been) mandatory for platforms without Sstc. If the SBI time
> > extension is
> > mandatory, then this is a firmware bug, and not really Linux's
> > responsibility to
> > work around.
> >=20
> > If the SBI time extension is not mandatory, then Linux needs to be
> > able to
> > handle platforms where the S-mode visible timer is attached to an
> > external
> > interrupt controller (PLIC or APLIC), so the irqchip driver needs
> > to be loaded
> > before time_init() (timer_probe()). So in that case, the bug is a
> > Linux
> > regression, and we would need to revert the platform driver
> > conversion.
>=20
> It doesn't really matter what the specs say (aka intended to say in=20
> RISC-V land): if there's a regression then we have to deal with it.=C2=A0=
=20
> It's not like whatever's written in the specs actually matters,
> vendors=20
> can just do whatever they want, so wer'e just stuck making the known=20
> implementations work.
>=20
> So I think if the revert is the best fix then we should revert it.
>=20
> That said: If the CLINT works, could we just add a probing quirk to
> make=20

CLINT works, but will will never work in S mode by its design -- the
register used is all M-mode-only.

So it this kind of probing quirk is being added, the target will be
OpenSBI instead of Linux, and the problem of updating firmware still
exists.

> it appear on these systems even when it's not in the DT?=C2=A0 I'm
> thinking=20
> something like adding a compatibly string to the CLINT driver for the
> SOC (or core or whatever, just something that's already there).=C2=A0 We'=
d
> probably need a bit of special-case probing code, but shouldn't be so
> bad.=C2=A0 We've got some other compatibility-oriented DT quirks floating=
=20
> around.
>=20
> > Regards,
> > Samuel
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


