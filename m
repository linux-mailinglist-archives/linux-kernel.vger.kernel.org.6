Return-Path: <linux-kernel+bounces-314897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74D996BAB6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A481F24923
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501311D0965;
	Wed,  4 Sep 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEMRaWvE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F05B1E0;
	Wed,  4 Sep 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449433; cv=none; b=BbbLzrhhDFW/pQBRRGkd70ijuphVdtTFJmcLXnycjJyK8HAtSK6UzIWkGMxs8TNUUbicl5SXAb54687A4K1xVKk5uA2IUdYINIGOwgu2wv/faHSxyZhSQs6vagtt3vhqe0cylI5bMW+vuxUEW5ER3wjCG0ZdrpK5gpiE4xzsHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449433; c=relaxed/simple;
	bh=5Aj+Yl/rXBgCGweDXox10GeE9CAueq0f0fU8ZeIbr1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPlCxm7XXR5ZWljyxOenPjLCrdAm0LLu9rsj6u6GtBaE5XF0fCFcNGUDezuF6vHcupCKef/2kMbcBTLAlrttmUusLBFnQpPPFcbgEn9IpqNbMXHKVQlTETS3X4wZvOnaoYfOrzoM/op9JP4f9FNPQURz2fIcibnUnME8r7/gjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEMRaWvE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA969C4CEC2;
	Wed,  4 Sep 2024 11:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725449433;
	bh=5Aj+Yl/rXBgCGweDXox10GeE9CAueq0f0fU8ZeIbr1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEMRaWvEgpMx1JiXXMbipWn7gT/SWrsvX834OdcJnZ8wMadYaGYPBTiO9+p8tPEAE
	 qXkj0XD32K/6wc01wlrwIh2u7KjmnK5X4nJdEhwbCvMqqNIq5NhNbXqNTywDF+dSEm
	 IxPHUMKOw1R3NzBl/IRFAAOmd6K9FFQ00KmE5cfejxNKEPBs4a3BoGcl3sLWHNiBvI
	 +B5BqW9MDovr3IV3Y1xzNql+ICypBxyLR3yXNgO5rOG4af0/mHORJvka7wZ/BitjFg
	 Y/+K6zHo6lDgOTrugMvolroZHNSuElel6EUkFgv4Foy3mACDoB6Sabu5+2QNfzvcDE
	 CuTYX0uD/50jA==
Date: Wed, 4 Sep 2024 12:30:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: Advertise b4
Message-ID: <bbe54c4e-dd0c-488c-bffd-f9dddf6b13f8@sirena.org.uk>
References: <20240903-documentation-b4-advert-v1-1-c89d6f5db7b1@kernel.org>
 <20240904044443.309aabb1@foz.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fmW3RxZUn8nqYSox"
Content-Disposition: inline
In-Reply-To: <20240904044443.309aabb1@foz.lan>
X-Cookie: Linux is obsolete


--fmW3RxZUn8nqYSox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2024 at 04:44:51AM +0200, Mauro Carvalho Chehab wrote:
> Mark Brown <broonie@kernel.org> escreveu:

> > +Tooling
> > +-------

> > +Many of the technical aspects of this process can be automated using
> > +b4, documented at <https://b4.docs.kernel.org/en/latest/>. This can
> > +help with things like tracking dependencies, running checkpatch and
> > +with formatting and sending mails.
> > +
> > +

> No need for two blank lines (yeah, there's a mix on this file of using
> one or two blank lines for paragraphs).

I have to say that the double lines between sections do help with
native readability of the document.

> I would also add quick example(s) on how to use it for common workflows.

The b4 documentation is already pretty good and the submitter side is
focused on a single task so it's much easier for people to navigate
than something like git where there's a lot of flexibility, I'm not sure
rewriting an abbreviated version is a great idea.  Someone with a better
idea of what would be useful could always follow up and add that.

--fmW3RxZUn8nqYSox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbYRNQACgkQJNaLcl1U
h9AKXAf/QfT66Emr7d698Cu3+HT2XqcZ6wCEE3BdchyCYPCaEUMbjC5Bb9QosL2U
+/lcM6MnBZ/4j9w0UktlzKiduYVnhwi5pbls8EJAgB65pERpCJ8wLqSG6rI+hkn5
Ge/X3m1VTHZ/i/ChgRGd4LmzmTxfSQHxazCXq0jvw5kmBqeM/Rb8y4P85eek7c+m
XF3A+4dmNxRRaGVlrkBWll4wXqy0S3uSAqTFtTsDqimWcmipZlP3nsBx6T9t6f9o
wWq8Jb6KjTD6Sqwy+QOmYL6kN/kWqsUsOpbajjeHfFtRdzFN9IvYGY4HHKfXelr9
crf5HyEDFWelacDK15Co3G/fbwp3Xg==
=cTQF
-----END PGP SIGNATURE-----

--fmW3RxZUn8nqYSox--

