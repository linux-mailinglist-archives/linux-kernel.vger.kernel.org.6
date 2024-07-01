Return-Path: <linux-kernel+bounces-236889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 174BC91E844
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22571F22FDF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D9E16F292;
	Mon,  1 Jul 2024 19:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="HKpIjyGI"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A7B16F26E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860854; cv=none; b=GH4UQW7pLgA18vE280GCY11FsSXA7WqsuOcc02Kr2LQpip7bJhsAOh8OSSvjFjifHpVldXKE7o/OfACAX5PfLi11Ms0pNPSeda+jD4hZ83IaKOPCsFcXsohuMyZCp1CSrersGZwoBWNcGqyZHa/XD3OqKwPmNCX+Q7nqR/5Vfd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860854; c=relaxed/simple;
	bh=xmlYaGtDgSkTbA31Y2Pvzy/T3RJ9BLZYj4jPKljp+DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnKdVEfrJQu8tQhs4YvElXNjIW3ariWAMet73S05T0ky9oJ3hLLgki6T5ovHIBEQXXwBuHujlrlA/Ii2MDfHWxJUv0nadtpxmF4Wb3yluZcWBOZLv/K5qTO/6BOdOkaRlWyLGEspTjmjNm5Du621i1te1I2oej5N2iB+2RdKYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=fjasle.eu; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=HKpIjyGI; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fjasle.eu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fjasle.eu;
	s=ds202307; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=erzXANcVH/iJFBLitZKvCHMt5qT6nPFZO1pp6T27mSk=; b=HKpIjyGIGXamvARNotPHWlZB4C
	BwzQp5p0nLo6CJRq9cFZTLWl8TSRttUduaWUHZfOaVdHT3n26Ac6yXaFzhaffBktT6tNl30qfHcpz
	tJir4+YKhoEYYhuFJEA7zWzUDYaTmxiY0RWjWbJXRSezGv+Q5vbvYOQh6K6xrW7fNa3psMNw9BVxd
	ItOsqK4Nk81Qoqldl9kLOeMr+QDtiz7m/E7yrl6x5/vTtziej4m+pED35Onr2kFYFRWPXfF9zdK66
	7MrKcAMqsG7FolKN2Cje4lWA1+wcS0CCTiRvJj5GY56eenr0SXCTsnLj7JRBb4huNgTKWP6XoMS+E
	OiNY8SlQ==;
Received: from [2001:9e8:9ec:e201:3235:adff:fed0:37e6] (port=33622 helo=lindesnes.fjasle.eu)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <nicolas@fjasle.eu>)
	id 1sOMMq-008Eh4-84;
	Mon, 01 Jul 2024 21:07:13 +0200
Date: Mon, 1 Jul 2024 21:07:06 +0200
From: Nicolas Schier <nicolas@fjasle.eu>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>, kernel@pengutronix.de,
	it+linux-kconfig@molgen.mpg.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/build_OID_registry: Avoid non-destructive
 substitution for Perl < 5.13.2 compat
Message-ID: <20240701-remarkable-panda-of-revolution-6ea11e@lindesnes>
References: <20240701155802.75152-1-pmenzel@molgen.mpg.de>
 <rroqnszmdjpue4q5celbqbo43hij7lqlzpdtm7odmkfwb6vc2b@qp6lgyzlxwt6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wOSw35D7FS0TvsT5"
Content-Disposition: inline
In-Reply-To: <rroqnszmdjpue4q5celbqbo43hij7lqlzpdtm7odmkfwb6vc2b@qp6lgyzlxwt6>


--wOSw35D7FS0TvsT5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2024 at 08:01:46PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Paul,
>=20
> On Mon, Jul 01, 2024 at 05:58:01PM +0200, Paul Menzel wrote:
> > On a system with Perl 5.12.1, commit 5ef6dc08cfde
> > ("lib/build_OID_registry: don't mention the full path of the script in
> > output") causes the build to fail with the error below.
> >=20
> >      Bareword found where operator expected at ./lib/build_OID_registry=
 line 41, near "s#^\Q$abs_srctree/\E##r"
> >      syntax error at ./lib/build_OID_registry line 41, near "s#^\Q$abs_=
srctree/\E##r"
> >      Execution of ./lib/build_OID_registry aborted due to compilation e=
rrors.
> >      make[3]: *** [lib/Makefile:352: lib/oid_registry_data.c] Error 255
> >=20
> > Ahmad Fatoum analyzed that non-destructive substitution is only support=
ed since
> > Perl 5.13.2. Instead of dropping `r` and having the side effect of modi=
fying
> > `$0`, introduce a dedicated variable to support older Perl versions.
> >=20
> > Fixes: 5ef6dc08cfde ("lib/build_OID_registry: don't mention the full pa=
th of
> > the script in output")
>=20
> No real objection from my side. But if this is an issue for you, I
> recommend to upgrade your build system. Looking at Debian releases
> (because they are known for their up-to-date software) and their
> included versions of Perl, we have:
>=20
> 	release  | releaseno | Perl version | release date
> 	---------+-----------+--------------+-------------------
> 	squeeze  |     6     |    5.10.1    | February 6th, 2011
> 	wheezy   |     7     |    5.14.2    | May 4th, 2013
> 	jessie   |     8     |    5.20.2    | April 26th, 2015
> 	stretch  |     9     |    5.24.1    | June 17th, 2017
> 	buster   |    10     |    5.28.1    | July 6th, 2019
> 	bullseye |    11     |    5.32.1    | August 14th, 2021
> 	bookworm |    12     |    5.36.0    | June 10th, 2023
>=20
> So wheezy is new enough, and that's 11 years old.
> Perl 5.13.2 was released June 22, 2010---that's 14 years ago.
>=20
> I don't know about your build environment, but I wonder if a system that
> old can really build a recent kernel (if the patch under discussion is
> applied).

I think, extending support by 6 weeks from Perl 5.13.2 (2010-06-22) to
Perl 5.12.1 (2010-05-16) [1] sounds a bit strange.  I'd like to remember
that Masahiro recommended to just remove the script name from the
generated comment [2].

Would you mind satifying my curiosity: what distribution are you using?

Kind regards,
Nicolas


[1]: https://dev.perl.org/perl5/news/
[2]: https://lore.kernel.org/linux-kbuild/CAK7LNASa-KedA_CTww6unckAGkJCQTct=
dbk0d-MUsN7wQpM=3DkQ@mail.gmail.com/

--wOSw35D7FS0TvsT5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmaC/lcACgkQB1IKcBYm
EmmLbhAAr0yFQUZwNfCue7u8ukvS4M2wl1gU1Sb18OMwIb/7edHRb8MnmBuDeEn+
kLsopNoWXe8ydzByptrL4SA/uTinrtgg0xX219UvIQa3ddE1I3Jfh/4pCrZV7Li0
7F+Y6GW5WmcLBtTOyAu/a1z04NDtB1T2iPE0/2CCXZgXev+iv4lMGZkY5yoHu2Is
aBM9/guxbKqVTH4X8bnOSAwZNo2eeA4++h3sJ8C1YfAXBKsiiTCnmCorNc/EHWos
KzS3zNBtTWj5q6UIoeIljr+tP+wxGtBsZQIiYJcGtkLFNXnQxCv4shU+rRHwFDzN
hNMDrwFw2MjhSlCkVGkz8Xegx8/vpHgSW86nElh3QKhTsuSIhZLVcJniCy6cTZs/
qE3OOSzpJDebpMhwIKNNQiFNP7Kr7TCJ8dyMHpTWdzGTieXYukcc6r8J4p8szdct
rpNIliHvHCNurcNwX0S3CPLcklte7DKUhRbT8cCkuov08oCa8SIB4FSqzPlyNqL8
TMgJY4Ys4r7TOeoByjanAUKNDp04VPCPCCulmXeCJnfbb7kvLDmGvBSGcXSSo1e4
bmVBLHI4I5vwX6jcHOB56Knj5cyWEn25hvSQWUFIUCbw9XfEeke/o9vuzKOg+r43
P/O5eoyOcamcQxewOQt9ntrxd7BOUkdtOEOEYSRHamlYY1tMGwY=
=8ssI
-----END PGP SIGNATURE-----

--wOSw35D7FS0TvsT5--

