Return-Path: <linux-kernel+bounces-337188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167BD9846A4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA7B284B82
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9F1A726D;
	Tue, 24 Sep 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYkDkijA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A3481B7;
	Tue, 24 Sep 2024 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727183958; cv=none; b=mX3XziX0XuV04r7tsZQbrrXCYQvvco1dNRq0UyC8JO4ilJM1dbV5QUUM1vRQPIWDmPRcDXBBCwmMTuaLLr3V9vyRydRnYycUxX+DQklIIRH6OCNvwuQXaZpoqdIuOXOIP2WWebOYHOIUvIRYSiaG8DeiT5yvdkjCJ4GusuBAaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727183958; c=relaxed/simple;
	bh=RnBo0J9Olxupu69OMLCYFmLC/A9T2H08JGrElcFUVCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHa/9t129ROaKLKjr5YvzuZM0g0fg7z5bvTKqsZlZAqsmK2mBDYMHqD3Dt4pz8s1xmajOnJkSm1kU51Uh3rQJRbosJGA6ea+jvtsj9fpWZH4ryKqnLLN8TdTcRchFJrHTcMS1DLqXa43e3M2/1TsAUVxoraIokNksky79w+j7Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYkDkijA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1203C4CEC4;
	Tue, 24 Sep 2024 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727183958;
	bh=RnBo0J9Olxupu69OMLCYFmLC/A9T2H08JGrElcFUVCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kYkDkijAhU9EQjaqTjQNWbiOvUYY3KF7YEvIbvwzvlxsza/fVtRwvT+mfyMGNTGls
	 ZReV88yNqEPEMoHhA/TMixCEljg9oUXUg6efY3udkv6LSgVMiJqQoZXLfVuSBfuVEi
	 2HMAvsrITfkyo20waNumNeBuyhMhDqj2hdf0k1L8q+oDwsbd2qyXdhIai4Dtg86I1C
	 +ftPuHyzaoNBeUbEO1FybUFPL9STQURr58/H9MdjJ+L8e8obyVW9iF3ZvS4TENH8En
	 O6HNhz2seIp8y2ZKl5Hjcmh0/nlx5taAQjhPXPp2/kLU4YUTnbYJO0jq2Iwwh0rLFh
	 yiPFg0eEs1ZBw==
Date: Tue, 24 Sep 2024 14:19:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	soc@kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-arm-kernel@lists.infradead.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Will Deacon <will@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH] Documentation/process: maintainer-soc: clarify
 submitting patches
Message-ID: <20240924-powdery-driver-e66ea543d634@spud>
References: <20240924130831.38861-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zfCvDNqwNswvUFbP"
Content-Disposition: inline
In-Reply-To: <20240924130831.38861-1-krzysztof.kozlowski@linaro.org>


--zfCvDNqwNswvUFbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 03:08:31PM +0200, Krzysztof Kozlowski wrote:

>  Most of these submaintainers have their own trees where they stage patch=
es,
>  sending pull requests to the main SoC tree.  These trees are usually, bu=
t not
> -always, listed in MAINTAINERS.  The main SoC maintainers can be reached =
via the
> -alias soc@kernel.org if there is no platform-specific maintainer, or if =
they
> -are unresponsive.
> +always, listed in MAINTAINERS.

I probably had some specific case in mind with that original wording. I
presume it still holds true for some smaller platforms, but I cannot
remember the specific case that prompted it. I'll have to see if I can
figure out which platforms they are (if any) and get the tree added.

Cheers,
Conor.

>  What the SoC tree is not, however, is a location for architecture-specif=
ic code
>  changes.  Each architecture has its own maintainers that are responsible=
 for
>  architectural details, CPU errata and the like.
> =20
> +Submitting Patches for Given SoC
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +All usual platform related patches should be sent via SoC submaintainers
> +(platform-specific maintainers.  This includes also changes to per-platf=
orm or
   ^ this is unclosed.

> +shared defconfigs (scripts/get_maintainer.pl might not provide correct
> +addresses in such case).

--zfCvDNqwNswvUFbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvK8MgAKCRB4tDGHoIJi
0sh0AQDVXJTXuaqi2pJxajpj22bKua48K7IZCGr3djc3a/PL5gD/QrBRd0Agv9Ae
P1sJtZkwkxLEwkjVPpESct8/C07Oewg=
=YREJ
-----END PGP SIGNATURE-----

--zfCvDNqwNswvUFbP--

