Return-Path: <linux-kernel+bounces-406082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10219C5B84
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF89B30233
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB3E1FF029;
	Tue, 12 Nov 2024 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC7CQaQg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716121FC7FC;
	Tue, 12 Nov 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422633; cv=none; b=qFkHaOaHWMEUvBuTPitWkoCL61Tm/pknbkfxq6xU6cISpUl2aku5tB0tnEIAqTm3Dx3PCyADUigklrjH+hloCAdzHXhesiZJAUFmvBOrstOADeRBeGp99jU9cZiMf2Dl3Ao1ts+T7tXWBrz49m/cwioayLvoV1ZGzQUHm9wc3do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422633; c=relaxed/simple;
	bh=kw9PSI7QedEulYVI11SbsxMgAcTXzcxHyTmZr0prhlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vb6gfLF/JIDNpDRPl03jZbSNGhPla2jx1S5qr/AhPgTn/dmOQorQ+hp1YnLteEohS46DXospQbD70TfLHstTyY6romJ8zlwuRJz1Uy42ohtYbD9sfD/b2XuJnanzc/MmV0Aix6KZeYqW0BdGEo1WBQZryKUEoiomQp0byrArCpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC7CQaQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8E8C4CECD;
	Tue, 12 Nov 2024 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422632;
	bh=kw9PSI7QedEulYVI11SbsxMgAcTXzcxHyTmZr0prhlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DC7CQaQgDa/xmq6/Dp004RKRisUHFKn+DWD0nrQoaF2vMnNE92V4Kuc6JNbgC3ikw
	 7QaXm+DX/lMjZ80+rCopcbcH63J9vlOaWPHcWUUwfNaVmM/Cr1VYSrVT1XaaqPl7N9
	 RIhzN6nRgs6jGiTfzJEnTUES/Ig9UE19L5Tb/JrYX7p6B1pG8O4eEOd4IhTj8qluyk
	 2UBmQcMLDSnnslUYriREzN8Xdv0E/iAnYFx+LhM7jhcSQfKy9Y+74ByqczV+OaW973
	 3xRGXKiJ32ViTI/yknpFnME5wgEETVzXieOwc+HyA0Rk2Mto1V6YDVpcBGNmMZe3Q4
	 3IXrBkyhwva+w==
Date: Tue, 12 Nov 2024 14:43:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] Documentation/CoC: spell out enforcement for
 unacceptable behaviors
Message-ID: <ZzNppQIQm6O6lnfW@finisterre.sirena.org.uk>
References: <20241108161853.12325-1-skhan@linuxfoundation.org>
 <ZzJkAJEjKidV8Fiz@phenom.ffwll.local>
 <ba3d5492-e774-452f-9fe0-e68b743c6b0d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oEgx+arnr/c9/sI3"
Content-Disposition: inline
In-Reply-To: <ba3d5492-e774-452f-9fe0-e68b743c6b0d@linuxfoundation.org>
X-Cookie: Editing is a rewording activity.


--oEgx+arnr/c9/sI3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 02:50:45PM -0700, Shuah Khan wrote:
> On 11/11/24 13:07, Simona Vetter wrote:

> > Personal take, but I think a forced public apology as the primary or at
> > least initial coc enforcement approach is one of the worst.

=2E..

> This document isn't intended to be a complete summary of all actions the
> CoC takes in response to reports. There is a lot of back and forth with
> the individuals to bring about change before the CoC asks for an apology.

I guess it would be good to explicitly call out (possibly in an
incremental change on top of this one) that the specific enforcement
steps here are examples, and are mainly for cases where a more
mediation/education based approach fails or extreme cases where they're
inappropriate?  Neither the existing document nor the current change
make that explicit (at least to my reading), it's clear from for example
the reports that are sent that the existing practice is to try to use
those approaches first but I'm not sure that people would realise that
=66rom this document alone.

--oEgx+arnr/c9/sI3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmczaaUACgkQJNaLcl1U
h9BMOQf/TKO41Kx6ClF6btlwqUwS6HBy07xNmbEeSwkwwc9CzqCOcpVMRQQUYnWC
gFfzcPDfom0WWMuaL9nQ7A6+XXtCY/+1XRdaZSsYL81Hfz8d4KSSwHG61QogC0zO
SNr4eLv9QcwiZO/9qOGAxe5dZvyYKLo20uC6FBP124WDYfTrBEzp9A2sdLR9VWxn
cUxhiYhU9u6maX5UPiZFGlMN1Bco5LGg1ozWyuq+/LCYIFqhMKrsCq9JEoXcgDz2
NiYuNU/z6m3uGBY3DnKGILQ4SOEwVcEP0LIBEo7+FBWAlmGMLr0DoztAehQ81ANk
WljNMC8ltIc08UlAayo1m6SsafUM5w==
=CSNu
-----END PGP SIGNATURE-----

--oEgx+arnr/c9/sI3--

