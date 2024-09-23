Return-Path: <linux-kernel+bounces-336127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0967C97EF7F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340EE1C214C5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21A19F410;
	Mon, 23 Sep 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="OLH/k+Jk"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6551B19E969
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110034; cv=none; b=E0ECT7SVWFPDeCNLLb0GDEZAX78KybvTf9eUTvwYKXmwl/+RX1rki8RWBcPTGqsq2Gsde1FaSHULeNuSIW8gj4lxpQsDJvzfpFIoVko5pb2UO2PDQts/B1P5umSLlBJpqlAJC37AAfcHW881h830nQgwfS7lQ8T1q/D83obRjag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110034; c=relaxed/simple;
	bh=C/WqVMj4DrTy4lgLnjS672bib2conoZWLJv3A7cquOg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=on6U7xgqZDvKOQt+NMzpGAS5jxNxFGf8QS2wtcV2XIAGXWvV6pwKkoMTkm5nGoMQooH1V/RFgx4aLVaPqNIEPCnPKuTWXcE49VoIa21nDSRBdAumtSE+L2Rrzcmn132X409RBPFag1u8UjcAHWgWGE4zObYtU9atKi5EqMuRJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=OLH/k+Jk; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1727110030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUIdOEihVUyd1ilWFDy6GeBjW5ZBlK+M2N/8lsqNaFg=;
	b=OLH/k+JkMD65LcM9ljhdOWgI81PmyWYDWuO4SqZQE3qTMNTvIbIqd0xEOVR++mv9Z/YCkf
	SQtRCpgscxtcGMFK3ozjWV344d6z3xCe5eJcNQJwzLrrjBdv+1anH6y1X0VgZADK/RoZVU
	NJaQoTpTWQDI2mdd754TCNHIKvM2S5adC99FOl43WrsQE+OkzKWUGSKVfdtVNfnXcVHeJr
	EsdkUgTVmfLP/8/gvYg98bthqmxqkQS1dqVtBi8GEh/Fcweaof4MihgD/ev2hpwO5Zrnse
	hJaYh4tNNaOyJa+DvBvIMuZvC8q0EEIwbQheSxnJpYKoCqZmoWcYpV+fzlXbsA==
Content-Type: multipart/signed;
 boundary=d0baebba785571bdc3f21f5e5605455d839280196496138da20ab2852bd8;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Mon, 23 Sep 2024 18:46:57 +0200
Message-Id: <D4DTEKH7A93W.1MGHTQZGU5UCC@cknow.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Diederik de Haas"
 <didi.debian@cknow.org>
Subject: Re: [PATCH] mm/damon: Update DAMON doc URL
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "SeongJae Park" <sj@kernel.org>
References: <20240923100615.14160-1-didi.debian@cknow.org>
 <20240923163226.550729-1-sj@kernel.org>
In-Reply-To: <20240923163226.550729-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

--d0baebba785571bdc3f21f5e5605455d839280196496138da20ab2852bd8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi SeongJae,

On Mon Sep 23, 2024 at 6:32 PM CEST, SeongJae Park wrote:
> On Mon, 23 Sep 2024 12:05:58 +0200 Diederik de Haas <didi.debian@cknow.or=
g> wrote:
>
> > The old URL doesn't really work anymore and as the documentation has
> > been integrated in the main kernel documentation site, change the URL t=
o
> > point to that.
>
> Nice finding!  Thank you for fixing this!
>
> Nonetheless, I'd prefer having 'mm/damon/Kconfig:' as the prefix of the c=
ommit
> subject.

Do you want me to send a v2 for it or will that be fixed when
committing?

> Other than the trivial nit,
>
> Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks :)

Cheers,
  Diederik

> > ---
> >  mm/damon/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> > index fecb8172410c..35b72f88983a 100644
> > --- a/mm/damon/Kconfig
> > +++ b/mm/damon/Kconfig
> > @@ -9,7 +9,7 @@ config DAMON
> >  	  access frequency of each memory region. The information can be usef=
ul
> >  	  for performance-centric DRAM level memory management.
> > =20
> > -	  See https://damonitor.github.io/doc/html/latest-damon/index.html fo=
r
> > +	  See https://www.kernel.org/doc/html/latest/mm/damon/index.html for
> >  	  more information.
> > =20
> >  config DAMON_KUNIT_TEST
> > --=20
> > 2.45.2


--d0baebba785571bdc3f21f5e5605455d839280196496138da20ab2852bd8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZvGbhQAKCRDXblvOeH7b
bgEuAP9mbmpuhXYnoewUSGm6j4/Aq6MUtLwvMFewMTfmHmJ+5AD+N0cfqRmmPGKA
wmqOoiQJAHlViCo+NtMp9Any5X3AEA4=
=lQP8
-----END PGP SIGNATURE-----

--d0baebba785571bdc3f21f5e5605455d839280196496138da20ab2852bd8--

