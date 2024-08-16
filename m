Return-Path: <linux-kernel+bounces-289042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AF0954188
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655BC1F24DA3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1155E85283;
	Fri, 16 Aug 2024 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="CJICe07b"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AB781741
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788632; cv=pass; b=s+0vX7UHbc4aiAJprDTqZWNz1LeMuwh1hV/BjPJVSlyMUaKv3GosWmhJ67D5Nuxjph/+3BpSXGcsDUhrl3uGpDeN9uStzvJb8qIb1xaF2uUJVUTbG85mNuXOUWcjIJc8Japa5THo5zgQkt/BiDFGSCUF79XmKYfFPrD6UAlkmqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788632; c=relaxed/simple;
	bh=hcSGRbUU39H4+aPq6230lrePyX9/aHkH59blGuwBUeE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bjreFXFohohpU+WMcog93VMdLf0EWSmdj739YwessgBwgX7nX3sVFLS5gz68/u2BrFxRHVxepkWawOah2cVenaqw1YMeeeF5xhXvOXd5hQnmsslkJnbYdLsziex/CDtj8s+XLcWA7Kq8dmvu2sYskgfXW5S3+PIh8fnBB9e6bIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=CJICe07b; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1723788606; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P3pWPXD8rUFdVwHpPsItVKycREgekzseH2ccvogBTJ0Z9cHBknTqEBPbpPDpdVq15uRp/sfKEXnE0Svo52x+Q/82Er5FxXuI1EwGNWNeUsyvQMNgBLA0Xe5uHZTOAwy42ORJrRXNNyfYnJA+ctQlNa4Z8YVrDivrMIiNZTtJxZs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723788606; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hcSGRbUU39H4+aPq6230lrePyX9/aHkH59blGuwBUeE=; 
	b=VsPZy/BqHpdUoXcS5azY7IrVRbWYjFNB5odQH0CsT5ly3Wm4zVGeSAIslAtS7n2jSENfmlwJuG5rRJh9o2TBBShZbp4JY4B5+Mec/weoodFFg9AHo8rdlrMfUbITyrKGyaqFjih4Ys5FN6Nq+13C06ZStR4QZ7APQUXqtWWJnPM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723788606;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=hcSGRbUU39H4+aPq6230lrePyX9/aHkH59blGuwBUeE=;
	b=CJICe07bvpnF7gUM6cxv7f3TmmyPJ6b7op/BUo+rdbDKdOLpfJ+xPj3/Dv1OgUfq
	WYLKpgY5fiH9opkHbZCP4GkUcT0KbAYUtAif0tF75vcTapAA4zF3AKWFtO9/rrVxCzN
	IwU2UbECnOixNyuGF4LMbMbCyQAqLgfVIFkrvqgkplxB25YZV6w4xbjdr0A3ANrE5w2
	lhrrdoRtq786+MiIp9/lefT5x4u4jhHooV4mGpRnYN6cF5UDaJdweJPDHgMQBxJJsSr
	oJH/zV6hezMuUN6a7c3mOESGC1/ykz4fahfvhSE0md02ucvR5sVFgBens5Gt3pOP88v
	vF5JJ3+zFA==
Received: by mx.zohomail.com with SMTPS id 1723788604231899.4893413463349;
	Thu, 15 Aug 2024 23:10:04 -0700 (PDT)
Message-ID: <ce7d2ebb2a82935c68bd41d6379f8f20591c2539.camel@icenowy.me>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
From: Icenowy Zheng <uwu@icenowy.me>
To: Anup Patel <apatel@ventanamicro.com>, Samuel Holland
	 <samuel.holland@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Fri, 16 Aug 2024 14:09:58 +0800
In-Reply-To: <CAK9=C2VHfPnYx8gMjodJNLu9+yR4KvuPXeQZiyZcbu1Mvze-0Q@mail.gmail.com>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
	 <87jzgjnh9z.ffs@tglx>
	 <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
	 <87ttfmm2ns.ffs@tglx>
	 <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
	 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
	 <87plqalyd4.ffs@tglx> <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com>
	 <CAK9=C2VHfPnYx8gMjodJNLu9+yR4KvuPXeQZiyZcbu1Mvze-0Q@mail.gmail.com>
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

=E5=9C=A8 2024-08-15=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 20:00 +0530=EF=BC=
=8CAnup Patel=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Aug 15, 2024 at 7:02=E2=80=AFPM Samuel Holland
> <samuel.holland@sifive.com> wrote:
> >=20
> > Hi Thomas, Emil,
> >=20
> > On 2024-08-15 8:16 AM, Thomas Gleixner wrote:
> > > On Thu, Aug 15 2024 at 05:14, Emil Renner Berthing wrote:
> > > > Emil Renner Berthing wrote:
> > > > > 6.11-rc3 + these reverts:=C2=A0
> > > > > https://us01.z.antigena.com/l/Er4kZWDmvL5-bLzHHJoZv0k71iwW2jCD5qN=
piz0x0XdYY6oORF_nXh7U7jw6oubhi~32HI4i71jUW9v8~NvSvPeUWrdYx3WJBr2GPDUjOu6LYP=
COBfR2dVQuMWvlNj4tDjXFp3QEQAmeawZflD4JrIJjtSYIbKfe6v-tgH7SEuHMeSSriU633Lv
> > > > > 6.11-rc3 + Samuel's patch:
> > > > > https://us01.z.antigena.com/l/EULtAYky6ZvgqZ49KGS-WBsYTg~Ht1NoQtE=
YmUVb56ymS9jDagqYHLK90WDjnVt69GfB4IX5NSRQXmSfkNsTzB8lJmFvDihHQmGrsCv9FzlorD=
9yGfXDlQ6rG6vmn5BNDwlipmssGaOGfh9yko8n9ArWR4TLhEf~f9ODqme~NXXwA9DLLc9p
> > > >=20
> > > > I think this confirms what Charlie found here:
> > > > https://lore.kernel.org/linux-riscv/ZoydV7vad5JWIcZb@ghost/
> > >=20
> > > Yes. So the riscv timer is not working on this thing or it stops
> > > somehow.
> >=20
> > That's correct. With the (firmware) devicetree that Emil is using,
> > the OpenSBI
> > firmware does not have a timer device, so it does not expose the
> > (optional[1])
> > SBI time extension, and sbi_set_timer() does nothing.
>=20
> OpenSBI uses platform specific M-mode timer (mtime and mtimecmp) to
> provide SBI time extension to Linux.
>=20
> The RISC-V privileged specification (v1.10 or higher) requires
> platform to
> provide a M-mode timer (mtime and mtimecmp).

The T-Head cores' design is weird, and because of its source code is
available (as OpenC906), we can investigate it further in the RTL
level:

- From software perspective, it has no mtime mmap'ed register, but it
has mtimecmp, which compares with time CSR (a CSR R/O in all priv
levels).
- From SoC integration perspective, the value of the time CSR is
sourced from an external input, pad_cpu_sys_cnt[63:0] [1].

BTW I already added support for this kind of non-standard CLINT to
OpenSBI [2], however I don't think the current firmware DT of D1
utilizes it; and this is also a quite new SBI version I think.

[1]
https://github.com/XUANTIE-RV/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/c=
pu/rtl/openC906.v#L84
[2]
https://github.com/riscv-software-src/opensbi/commit/b848d8763a737de44b64bf=
c036c8f51200226440

>=20
> This platform not having any M-mode timer is yet another RISC-V spec
> violation by this platform.
>=20
> Regards,
> Anup
>=20
> >=20
> > I wrote a patch (not submitted) to skip registering
> > riscv_clock_event when the
> > SBI time extension is unavailable, but this doesn't fully solve the
> > issue
> > either, because then we have no clockevent at all when
> > check_unaligned_access_all_cpus() is called.
> >=20
> > How early in the boot process are we "required" to have a
> > functional clockevent?
> > Do we need to refactor check_unaligned_access_all_cpus() so it
> > works on systems
> > where the only clockevent is provided by a platform device?
> >=20
> > Regards,
> > Samuel
> >=20
> > [1]
> > https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/intro.ad=
oc
> >=20
> > > Can you apply the debug patch below and check whether you see the
> > > 'J: ....' output at all and if so whether it stops at some point.
> > >=20
> > > Thanks,
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tglx
> > >=20
> > > ---
> > > --- a/kernel/time/timer.c
> > > +++ b/kernel/time/timer.c
> > > @@ -2459,6 +2459,9 @@ static void run_local_timers(void)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct timer_base *base =3D
> > > this_cpu_ptr(&timer_bases[BASE_LOCAL]);
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!(jiffies & 0xFF))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pr_info("J: %lx\n", jiffies);
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hrtimer_run_queues();
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < NR_BASES; i++, b=
ase++) {
> > >=20
> > >=20
> > >=20
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >=20
> >=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


