Return-Path: <linux-kernel+bounces-526023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB52FA3F8E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD1719E1899
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17B1212B1B;
	Fri, 21 Feb 2025 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="igFUWHSG"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2521147D;
	Fri, 21 Feb 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151735; cv=pass; b=k3q/ropHf1fnlbrhzL0woU+bJDgm6lJEsBa/ZTj8bdtBmGCZ/O4qzU1Z3H9SZQa1aJoOMBCGTkbyi2HEjhkwboJa/CrCaQ2Z3yH1YFqyRi7NlgYUYfLRGyooTddjhrhaS1wNbPGO9Z65ODEZntpe3qFm/APmMFl4TnZ6Rxetn8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151735; c=relaxed/simple;
	bh=btfqHh6gmsSIJcjU3GbXMDgWDvFVm8dzoDhioK/7wOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4QBT6Fez0Ij+2XJm7XK09HN+L7fhiBSkly32QFooBhjOk1tWAIy2Kilwps5hj8XVsDCwesqGTMOEPIwDTVXZCzjRPC6AcJ9KmE2qWLUahSlHDkkzPTzHWjUkRbHTGJkg/EOoT1iFBs7pPrt9PDmFhsiwyNoUn/792GJg66SwkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=igFUWHSG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740151705; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ETIPuLM6VzvUWWHUMIH7mvkbk+G00Mc52iuUtqTsQjo/FcOhLTllrie0OVJeiq2TCNXOlZ7QK5CL05uY7fR8JWfFGdONNSR0iNN4DP/8evV5WKXEzsB0rUt3fzYmU6Zmzb9DHzBuhxM+eCa4KDkfURwvYJuJCDt6Km9JvRbuJOg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740151705; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=btfqHh6gmsSIJcjU3GbXMDgWDvFVm8dzoDhioK/7wOI=; 
	b=lYkTsng4RjSYwfRMWG+t3ZfcbH+Zof52remAbATqeErSTKXSnGeuFA2yttTRt04KTxVvr8aQy1nWTWMWORryLgEPF1f14pAnOohgEup3ql3HpU1KplokTZgo692ZCIu4GoYtIbOHQZ+IGTFYFvwovSCVk4psPr5zEIJvHOeMAWw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740151705;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=btfqHh6gmsSIJcjU3GbXMDgWDvFVm8dzoDhioK/7wOI=;
	b=igFUWHSGKkX9Vaftwno4xBOvaOCkuK2X1S/vdVFYFUgj+mxT8BCmZfUxBAvNo3iF
	RTeKXOQqsnztJzj+NOQHtkiQ5V8qAMoMZx8xoD7RTjkFLRVllFzhJ9tmx5O6l6pSjV8
	q3ERmLpe1ldSN0fXXPWFhAPd/RmRzL7j5xJem4kY=
Received: by mx.zohomail.com with SMTPS id 1740151703226401.9144883348604;
	Fri, 21 Feb 2025 07:28:23 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 1DF301826F6; Fri, 21 Feb 2025 16:28:18 +0100 (CET)
Date: Fri, 21 Feb 2025 16:28:18 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH V2 2/2] rust: Add basic bindings for clk APIs
Message-ID: <aoprvojsnmkbzmmpgx5wxjqtamnr3jyhyqfcqnwhxulp34gn32@aau57u4cotpe>
References: <cover.1740118863.git.viresh.kumar@linaro.org>
 <a0a1ba4e27c3a0d9e38c677611eb88027e463287.1740118863.git.viresh.kumar@linaro.org>
 <Z7iGHiQcqa-_AXli@pollux>
 <4AD8A8F3-EA7E-4FBE-9F0D-58CF7BB09ED5@collabora.com>
 <Z7iSHR0F2QpiNpMZ@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k3zauxydw4h5jdhh"
Content-Disposition: inline
In-Reply-To: <Z7iSHR0F2QpiNpMZ@pollux>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/240.10.19
X-ZohoMailClient: External


--k3zauxydw4h5jdhh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2 2/2] rust: Add basic bindings for clk APIs
MIME-Version: 1.0

Hi,

On Fri, Feb 21, 2025 at 03:47:57PM +0100, Danilo Krummrich wrote:
> On Fri, Feb 21, 2025 at 11:29:21AM -0300, Daniel Almeida wrote:
> > > On 21 Feb 2025, at 10:56, Danilo Krummrich <dakr@kernel.org> wrote:
> > > On Fri, Feb 21, 2025 at 12:03:39PM +0530, Viresh Kumar wrote:
> > >> +/// A simple implementation of `struct clk` from the C code.
> > >> +#[repr(transparent)]
> > >> +pub struct Clk(*mut bindings::clk);
> > >=20
> > > I remember that Stephen explained that NULL is valid value for struct=
 clk. As a
> > > consequence, all functions implemented for `Clk` have to consider thi=
s.
> >=20
> > I am a bit confused here. If NULL is valid, then why should we have to =
specifically
> > consider that in the functions? No functions so far explicitly derefere=
nces that value,
> > they only pass it to the clk framework.
>=20
> This was badly phrased, the current implementation does not need to consi=
der it
> indeed. What I meant is that we have to consider it potentially. Especial=
ly,
> when adding new functionality later on. For instance, when accessing fiel=
ds of
> struct clk directly.=20

Just a drive-by comment - the current implementation will never have
a NULL clock anyways. That is only returned by the clk_get functions
with the _optional() suffix. You are right now only using clk_get(),
which will instead returns ERR_PTR(-ENOENT).

> Maybe this only becomes relevant once we write a clk driver itself
> in Rust, but still.

For a clock provider implementation you will mainly use 'struct
clk_hw', which is different from 'struct clk'.

Greetings,

-- Sebastian

--k3zauxydw4h5jdhh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAme4m4cACgkQ2O7X88g7
+prYUQ//f59hToVXMAIGJ333jfHjvWUJFxssHgqDUIQPMSlxxpg9H6v8PiiZeIQf
wFMPxKupdjH8J97e5hZy0U4NLVwDvj/RzyBPObVtV1f1/1RF2l4dp/gLqj25Hx3u
zl2ZZhIFQRcfpbawE2FE10Dlk0Yswehiw5wB8HAbdHusjCzSFCZRkt51mEorFpPd
7IwV/f+lpUgXueohG8JWVoQk2SsW0BOlsvZ3CMv6BuTtFfNDDUubEwja6ZzxV8ZW
bRdUfEWnQuEd5ukSn39azfQ8obRwEJsmwuennHY0IR699PJIpPNqhCq5p7G6ldSy
VsirllZ9OX4H2hR0PExn28VX6E6cln3vWlmh3Cw7zIwfaa6FvGL8hY75HkH+IEOq
bOolzIJAcgTsqb9IFAbsCbPEl4OII87eBf6pABL8DSKnhFzu9KfNYvSKGhCiAiqe
rHCsX2kElQud5R186pkoDKPNdfQEPuMFUa6eDt465hHP+fKbZ6Oso8PaRxZ8mGCw
PeCwR5uKVhr7UQCPosrKRRJEZWBiP7lf3wE7TIPEYKl3sZyl8PW5mRUUt+mrIXs9
AasBjvmHLzVm/TrAYop8vUx8Gcz9GiKKkGNVTTZ3ATvQoeyIyGa3rbxB5wRuynGt
opY/3Sm3EjAObQTfAnMH5/A9CYnGSpwZtYdY01QxD0hPzZb2uNU=
=khOL
-----END PGP SIGNATURE-----

--k3zauxydw4h5jdhh--

