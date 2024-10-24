Return-Path: <linux-kernel+bounces-380574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F949AF2C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F991C21538
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E4C200B98;
	Thu, 24 Oct 2024 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="ceTKug6d"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B47522B64F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799068; cv=none; b=dSyFnKaTRM3G9mW2NcC4/dKkEM85Dz1BRXw0A+56jiikOXS2yjXXNyAwsbx7lpG05NI02+9KsF2qscbI7Xg75v2RfsKaK6GCsRvsUjnGdNbpIttUY3mWkbE6R9Ac0h/RpaqdAbeE38C/diR8KOlY2S6VhgssPg7Ie1cyyH9KG2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799068; c=relaxed/simple;
	bh=VUQWf3pC46B/DXnCYQq5d9d29YC8YH1TZ/ZWvlcC3zU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=s80UUWUl6vIuTVOdrHg9iYzurRr9UE4rBsBegoUdd4r2yR/FTSkWbJBLaX1zlRbJ0BzzvM7UMpwepAp2Bwkfweb0657ebHw8rxy2JLFBWaxaIhnpLjrfLENealRocUAfeey2wrNwUJzV6Q+7gM0ft4TjlANBuVH8bp8vQ6GJx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=ceTKug6d; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1729799062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Awe1yZiNFTWnol4nXap/SaOCQtrIwMpVgUZw0mNCD0=;
	b=ceTKug6dblgf7Evzi98Z7Iclfmvnk7A4ArqG+aCTLaBlyCgjofof4ZKtMZcU6/Z3yyGrnx
	HnIGr1nLEezYAukwrt0hG0zoitSmEOSb8yIY3abGFiLFg1+0UFifuESAfVqIy3sQJkfqXU
	qfIwwSytuhlcdeJiZ9m36lC1W2UDbwv45e5W0rfwUK1VVUuFpWsm/9B8igOE53EwnLXS9F
	kY4rS/QoAb+OoV56QvM5KMRUtbXHd5c5hBw/FBQ2Sis+s8IuqTl3hCo0nAsYEboNLHuN0S
	tvu/eAyFRMWJOC6zm9agB4XPEA2q0dV7u+4z6tqgTXDzsS+WUMGFxeatXkFSxA==
Content-Type: multipart/signed;
 boundary=492557a9de3d46cf38d751eae68085ace23cee607d5b7fd40dc9291919cc;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Thu, 24 Oct 2024 21:44:13 +0200
Message-Id: <D54AL6MM062P.3HR3L0TZ9ERII@cknow.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Arnd Bergmann"
 <arnd@arndb.de>, "Armin Wolf" <W_Armin@gmx.de>, "Guenter Roeck"
 <linux@roeck-us.net>, "Vinod Koul" <vkoul@kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: Error "ee1004 3-0050: probe with driver ee1004 failed with
 error -5" since 6.11
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <D4G7XD1WU5GY.D22KFST6MHIT@cknow.org>
 <2024092616-showing-fragrance-f70a@gregkh>
 <D4H312REVAZ3.3JWUT4NMWDA7C@cknow.org>
 <sr6p4lwnlznee73t4jof537dcwdl6m6vxriwk3pk4dnlxyaih4@6wv52esrfpyq>
 <D4HPXGCB5GGE.1KQFZR61CHMVF@cknow.org>
 <znkp6x44lnrvn4c7xnb43kiwfmyp3ovsnzi37xgaw3eyvgcm6z@pfxbrniec7jf>
In-Reply-To: <znkp6x44lnrvn4c7xnb43kiwfmyp3ovsnzi37xgaw3eyvgcm6z@pfxbrniec7jf>
X-Migadu-Flow: FLOW_OUT

--492557a9de3d46cf38d751eae68085ace23cee607d5b7fd40dc9291919cc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Uwe,

On Mon Oct 7, 2024 at 4:38 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> On Sat, Sep 28, 2024 at 08:54:12AM +0200, Diederik de Haas wrote:
> > On Fri Sep 27, 2024 at 11:59 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> > > [ extensive description on what to do when git bisect results
> > >   in a merge commit as 'first bad commit' ]
> >=20
> > This is awesome, thank you very much :)
>
> Were you able to understand that, or did you just bookmark it for the
> next time? If you still have questions, don't hesitate to ask.

Thanks for the offer :)
 =20
> > I haven't made up my mind yet whether I'll apply it to this specific
> > issue. It doesn't cause any actual problems (AFAICT) and most
> > importantly, it seems to be fixed in 6.12(-rc1) already.
> > And the 6.11 kernel is only a 'temporary' one which I don't care (much)
> > about, while it is fixed in the kernel I do care about (6.12).
>
> It might be beneficial to find the commit between 6.11 and 6.12-rc1
> that's fixing the issue. That would allow to backport the fix to 6.11.x.

Today I finally had time to try it out ... to find I can no longer
reproduce it. At least not reliably. I've seen the error message once
with 6.11-rc1 today, but not since. When I now boot 6.11-rc1, I do not
see it and I've rebooted several times.

I did upgrade the BIOS to a new (beta) version since my previous
attempts, which may play a factor? But that seems like a minor change.
So it could be that my previous bisect operation wasn't reliable either.

The issue wasn't a big deal to begin with but mostly interesting to
enhance my git bisect skills. But now that I can't reliably reproduce
the issue, that makes even that moot.

So I'm hereby stopping my attempts to bisect this issue.

Cheers,
  Diederik

--492557a9de3d46cf38d751eae68085ace23cee607d5b7fd40dc9291919cc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZxqjjwAKCRDXblvOeH7b
bkA0AP43wufHOY2OmF7hLNrziCHKpuZ2QsLBbeFeO31rLe1bAAD+LhcK76qNPMU0
h+rsidMH1x5+gwufvfpdu+0nWX5Y9gU=
=u2xj
-----END PGP SIGNATURE-----

--492557a9de3d46cf38d751eae68085ace23cee607d5b7fd40dc9291919cc--

