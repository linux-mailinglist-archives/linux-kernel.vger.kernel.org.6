Return-Path: <linux-kernel+bounces-526389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364DFA3FE13
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F814273AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9DC2512DA;
	Fri, 21 Feb 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="ZYstkXJ6"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4492512C5;
	Fri, 21 Feb 2025 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160920; cv=none; b=pyTbH2HLhAkNG1GMh4nFKk401LvVw1q3VWJ+jHtEwve2RYSydcqEkgatG2k3WjuurFjYTa3F4vnwuAcDlpHr3X3BIcVYsYUYncHR9rpDxGHRNyZK8rlcHgBWrItSTa7kEBH0QHu7jk1nQpKFdNwSSvI4GbtemOv1aGDKdPhgxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160920; c=relaxed/simple;
	bh=rexFOKZk7nV6hdLxR64ZAg5o1zfqmBgtgEH2CKQdy6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwZatPO6lEX2QDKG/FjEufCtlSM6P6thi3pbp+Lm3/61+c6g5BDKPDVzGtHLvBEWxmc4yuS6lpVUeP6E6FOL7JN6ouYpgMQXzJcYBzIf03DrojceiLkPW/tfJK1amtxHq0ZMG4/dF4OnIDL6sM5OU5bva0zBxeYy4YA2jp6fXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=ZYstkXJ6; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0FC811C01BF; Fri, 21 Feb 2025 18:53:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1740160390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZKV0gdI6JcsxJVNqTtpVRNnu7/xZJaruDWLEcjiObA=;
	b=ZYstkXJ60/3bY4uI9WHjiibaJshEoH0958bThx829OxFt/vJ5o8lFoHtKp2mnD40JAU/1a
	FSLVK/ha8kjefeNarzg2ZWgGXNrynU0cZKCaVqJerydxgFcz9jMvEtwplUhbFrssSY0Gbo
	1mxBFY8hT6dxRRvIjVOYb67qNEgCxXM=
Date: Fri, 21 Feb 2025 18:53:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: trace: decode_msr.py: make it compatible with
 python 3
Message-ID: <Z7i9hY7347X4P6bq@duo.ucw.cz>
References: <88bb0d47100feaa3cda215e68bf6500dc67da7b3.1739257245.git.mchehab+huawei@kernel.org>
 <87frkh6bd9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ptuCB/fv5QLZeqa"
Content-Disposition: inline
In-Reply-To: <87frkh6bd9.fsf@trenco.lwn.net>


--4ptuCB/fv5QLZeqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2025-02-13 09:46:42, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > This script uses print <foo> instead of print(foo), which is
> > incompatible with Python 3.
> >
> > Fix it.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/trace/postprocess/decode_msr.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/trace/postprocess/decode_msr.py b/Documentat=
ion/trace/postprocess/decode_msr.py
> > index aa9cc7abd5c2..f5609b16f589 100644
> > --- a/Documentation/trace/postprocess/decode_msr.py
> > +++ b/Documentation/trace/postprocess/decode_msr.py
> > @@ -32,6 +32,6 @@ for j in sys.stdin:
> >  					break
> >  		if r:
> >  			j =3D j.replace(" " + m.group(2), " " + r + "(" + m.group(2) + ")")
> > -	print j,
> > +	print(j)
>=20
> This does make me wonder when this script was last used ... it hasn't
> seen a real change since it was added in 2015.  Oh well, it should at
> least work with current Python ... applied, thanks.

This conversion is wrong, AFACIT. Old code one avoids adding \n, new
adds it.

BR,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--4ptuCB/fv5QLZeqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ7i9hQAKCRAw5/Bqldv6
8q9lAJ44P27RM3T3jX92Mz8pxyJXBA96wwCdGMfVDh9huWOAG+GG3YVXAhP6Vbc=
=5k+I
-----END PGP SIGNATURE-----

--4ptuCB/fv5QLZeqa--

