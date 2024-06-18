Return-Path: <linux-kernel+bounces-220360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7EF90E033
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E9C1F22E38
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308C0181CE9;
	Tue, 18 Jun 2024 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="YLQxXRMl"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B511CA9;
	Tue, 18 Jun 2024 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754718; cv=pass; b=F8yE4KyRetZlW8hTtLghLvcz7HMWtokui8e1s+LKFl86w9eIHC0GETzW9SkXNH1+WqUsRo3WL4ljKbvqv0HDgM0fuO2UEDneTOMFLzaYnxZB7OlrPXsejBbgt15MGIAposLFkPEsaD3fgG2bfazAoYpk9jMm2TNt2qs5mcP1b6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754718; c=relaxed/simple;
	bh=RfFl+97EXHWl4m+G7vuwvFRzulFXQEXrJmZAgGUBbHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UOXChtoP3SfniAML5Wg/dft7xh/y8wSxOqeIDCT+2cwz1XT3W65k/VA7S3G9GHLcElCAnvod2chBxxYbAnh4tcaoBkmZwXzoqxWh/0+Rf60/vpmGEIxIWB3e1Ai4DYVLeDIF3zA2aJdU+VXIiOKRzsUA+ZpZ5RQcrRLEFsv1dVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=YLQxXRMl; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1718754682; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=APEcdjFAtRIbhxF/xsgrQoVwfrmx5OOtET1Cn9LfEDyPa0qsMZEvf3xZvYrCbEoGlf++llpjN3GtR7d+u2Iff/eXRj1ss83JiZYXS09tlrfkKVFXYlfdSLqFNXcnSML52vvY6tsJ+vw65Q6J7vv573s9WK2RiVpVETPaXxM/lug=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1718754682; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RfFl+97EXHWl4m+G7vuwvFRzulFXQEXrJmZAgGUBbHU=; 
	b=bylbvPZC6WOwYQ8YKBZq0lww14/9rcmPR2Nt0cimM71nHYhQXiTRE5dgzqwn/IkeF9JAK4YH7gYIdPlZ0hypTL5d+xavwWAkZIch8CwTrXeEvmbn2ji/MslE1u7vXyEHxGbvDbM09pEfMispqC3YvZLx/ILYoYHlehlWXulWZ8M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1718754682;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=RfFl+97EXHWl4m+G7vuwvFRzulFXQEXrJmZAgGUBbHU=;
	b=YLQxXRMlT8Z+fs6JVbqrT6vz8sPZlQyZAA58vIxmHVlJixEnc6ycfN/RbJkDl2z8
	7ZVO7FBV5mHbOIF6tDW3T1cnW8WcBSBacyoK6B2BaVaF8I270KHk+BbZHJRaoZQ2Ezz
	eUpHXKjsH4xtHWjJgcFvp1tnPbOz9bMYyVVoCt4/n6XnNi1psU3wqDbwli7bmQKigcD
	u4TJZkwWRGYpsSDaAgXkOasiPLAaVyqRaxqp0vDARzN9p0tp1Zd4LHnhZ4nzBv4B9e9
	8iKi6spRIaZfDBIkUd5k3f9ldj+e8WkAzljC92ZgLlGBCKkx2QoOCyg5Nwn1ddwclaB
	Fwbe/eKUDQ==
Received: by mx.zohomail.com with SMTPS id 1718754680063854.9774986659605;
	Tue, 18 Jun 2024 16:51:20 -0700 (PDT)
Message-ID: <3c20c9f15cd7a9fb1f2e88560c1b089ac8032898.camel@icenowy.me>
Subject: Re: [PATCH] RISC-V: Provide the frequency of mtime via hwprobe
From: Icenowy Zheng <uwu@icenowy.me>
To: Jessica Clarke <jrtc27@jrtc27.com>, Yunhui Cui <cuiyunhui@bytedance.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?=
 <cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>, Conor Dooley
 <conor.dooley@microchip.com>, costa.shul@redhat.com, Andy Chiu
 <andy.chiu@sifive.com>, samitolvanen@google.com, linux-doc@vger.kernel.org,
  linux-riscv <linux-riscv@lists.infradead.org>, LKML
 <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>
Date: Wed, 19 Jun 2024 07:51:14 +0800
In-Reply-To: <2BA519C8-D258-4D98-AD49-AC7D30D8B0D2@jrtc27.com>
References: <20240618114653.12485-1-cuiyunhui@bytedance.com>
	 <2BA519C8-D258-4D98-AD49-AC7D30D8B0D2@jrtc27.com>
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

=E5=9C=A8 2024-06-18=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 18:11 +0100=EF=BC=
=8CJessica Clarke=E5=86=99=E9=81=93=EF=BC=9A
> On 18 Jun 2024, at 12:46, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> >=20
> > From: Palmer Dabbelt <palmer@rivosinc.com>
> >=20
> > A handful of user-visible behavior is based on the frequency of the
> > machine-mode time.
> >=20
> > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>=20
> I would suggest referring to the user-mode CSR instead, i.e. =E2=80=9Ctim=
e=E2=80=9D
> rather than =E2=80=9Cmtime=E2=80=9D throughout in names and descriptions,=
 since
> that=E2=80=99s
> the thing that user-mode software is actually reading from.

Agree. MTIME isn't even a thing defined in RISC-V ISA -- it's part of
the ACLINT timer spec, but before ACLINT gets widely accepted, it's
just some SiFive thing that got copied by many other vendors (and
vendors such as T-Head even provides CLINT w/o MTIME register (well
because these T-Head cores have reference source code available, this
is because of their CPU design uses an external counter fed as TIME
register)).

>=20
> Jess
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


