Return-Path: <linux-kernel+bounces-223901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F5A911A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D655B282BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1A812D1EA;
	Fri, 21 Jun 2024 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="YX0jP+1E"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4809C12D74F;
	Fri, 21 Jun 2024 05:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947143; cv=pass; b=fDlvRa72nVdIUg1SjohcptFY7umZJUoT1//eE3DohNuVUZlzEKAjV0eqlSuTpkeq/gyewD/mo4O/+69HtgyMozW3vvRjGESxI9EF+M8wmWJOpbd8hcrJM6VTxonM1R3/th+oyc87+0v2IfbuWxFyV9IDrc1eEzie3bIGro2tnd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947143; c=relaxed/simple;
	bh=x7lQvMt4ex5lL65NuvtYppd4hlL7l7zTLlB6KxolOZs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZhiX0VFkmY3woEBrPdR8JfPF0ec/iXz8sirw9dM3KESoyQIC5eQB951qfyaZNgYK3dMiXRaEjg9jnoPHSb7cKo88pIc4AZXVfQReKgQr1yylG/tO7ZJJKiJRDqdJHGrEtgUA1dHsaUGulpj5PCh0QaGCIxJXHcFexox/uUxxu+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=YX0jP+1E; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1718947110; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c6AgMWpCL8iULRscSMXdhBHx4hgxfgjJ24VxE/Q2HPq5GATNxkF77w8vNl9xQ8fjmpiKk+3/+DXwWBPWPr0HHt76+EyMMU1UnladPKhxzW51Eir0rbpVHGhOSfOkyv9l9Fty4PiyMny1BQF/3n2C+wMox78sHcp7ZORKqJL3gLU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1718947110; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x7lQvMt4ex5lL65NuvtYppd4hlL7l7zTLlB6KxolOZs=; 
	b=VbFUh/AKg1umViHEU2X0BQ89gHYyVRnoBkzOdkD/rtyxikPGWjjBLooLxQW1XzgUUmS78De5N1vIv/vAsopBEbwev0G6sbWZzzAo7IRhVX3JM3d6C0FrU9d+8cnfY2LJroVg4EBfwwyky7PhHYn1L/pf3mrNGdU58j7/q2J9yJI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1718947110;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=x7lQvMt4ex5lL65NuvtYppd4hlL7l7zTLlB6KxolOZs=;
	b=YX0jP+1E/1s43ENznX+gHHToSYxwi54xOe+Y205R53HC6oOpDmKLnNh7OAWIUsDx
	gycX4A0SGnKXFnMPkdu3tIlHge9mOU/KraRveogR5qYYGeCxWjb6VGCVFoN4viVoTX9
	SM6MhSsb2PKDiLEmsMvXGp2zYfi1r1ZLBvvMzdtaokcixEHY2fB0a5oOT9E3/5HwfGv
	ioSgTWxlkgfkjOvYaZkd8tG9R6etYtBIcx9tS16ibCjmc/cOEjDJCOj5g24GVOae8ui
	hwI2mDQ+A1mJFXy3ef0QZMMvtlN6PMyOghMoYksgCXm+jL0j6RRxdTQwkmamdoVQjdW
	lGtGT22VIg==
Received: by mx.zohomail.com with SMTPS id 1718947108447520.378193907363;
	Thu, 20 Jun 2024 22:18:28 -0700 (PDT)
Message-ID: <8fac6e0f11ab5f5fc28be6e73f196b38e99f8c39.camel@icenowy.me>
Subject: Re: [External] Re: [PATCH] RISC-V: Provide the frequency of mtime
 via hwprobe
From: Icenowy Zheng <uwu@icenowy.me>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Jessica Clarke <jrtc27@jrtc27.com>, Jonathan Corbet <corbet@lwn.net>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, Evan Green
 <evan@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>,
 costa.shul@redhat.com, Andy Chiu <andy.chiu@sifive.com>,
 samitolvanen@google.com, linux-doc@vger.kernel.org,  linux-riscv
 <linux-riscv@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>
Date: Fri, 21 Jun 2024 13:18:22 +0800
In-Reply-To: <CAEEQ3w=HZptMOgXp2Rtuz-VtzPabN=h5N3=3wS4AMk3Lo7E7FQ@mail.gmail.com>
References: <20240618114653.12485-1-cuiyunhui@bytedance.com>
	 <2BA519C8-D258-4D98-AD49-AC7D30D8B0D2@jrtc27.com>
	 <3c20c9f15cd7a9fb1f2e88560c1b089ac8032898.camel@icenowy.me>
	 <CAEEQ3w=HZptMOgXp2Rtuz-VtzPabN=h5N3=3wS4AMk3Lo7E7FQ@mail.gmail.com>
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

=E5=9C=A8 2024-06-21=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 11:01 +0800=EF=BC=
=8Cyunhui cui=E5=86=99=E9=81=93=EF=BC=9A
> Hi Icenowy,
>=20
> On Wed, Jun 19, 2024 at 7:51=E2=80=AFAM Icenowy Zheng <uwu@icenowy.me> wr=
ote:
> >=20
> > =E5=9C=A8 2024-06-18=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 18:11 +0100=EF=
=BC=8CJessica Clarke=E5=86=99=E9=81=93=EF=BC=9A
> > > On 18 Jun 2024, at 12:46, Yunhui Cui <cuiyunhui@bytedance.com>
> > > wrote:
> > > >=20
> > > > From: Palmer Dabbelt <palmer@rivosinc.com>
> > > >=20
> > > > A handful of user-visible behavior is based on the frequency of
> > > > the
> > > > machine-mode time.
> > > >=20
> > > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > >=20
> > > I would suggest referring to the user-mode CSR instead, i.e.
> > > =E2=80=9Ctime=E2=80=9D
> > > rather than =E2=80=9Cmtime=E2=80=9D throughout in names and descripti=
ons, since
> > > that=E2=80=99s
> > > the thing that user-mode software is actually reading from.
> >=20
> > Agree. MTIME isn't even a thing defined in RISC-V ISA -- it's part
> > of
> > the ACLINT timer spec, but before ACLINT gets widely accepted, it's
> > just some SiFive thing that got copied by many other vendors (and
> > vendors such as T-Head even provides CLINT w/o MTIME register (well
> > because these T-Head cores have reference source code available,
> > this
> > is because of their CPU design uses an external counter fed as TIME
> > register)).
>=20
> Okay, Thanks for your suggestions,=C2=A0 I think this modification is mor=
e
> appropriate:
>=20
> RISC-V: Provide the frequency of time counter via hwprobe

Sure, or you could just say time CSR, which is a defined CSR in the
user ISA document, and allow to be read from userspace.

>=20
> A handful of user-visible behavior is based on the frequency of the
> time counter.
>=20
> What do you think ?
>=20
> >=20
> > >=20
> > > Jess
> > >=20
> > >=20
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >=20
>=20
> Thanks,
> Yunhui


