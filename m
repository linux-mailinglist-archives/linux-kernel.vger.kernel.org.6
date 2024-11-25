Return-Path: <linux-kernel+bounces-420994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B589D855E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3B828A352
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7031B18872F;
	Mon, 25 Nov 2024 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcaWyP3D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC717A597
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732537341; cv=none; b=OR9k6vkB1YhRpO/JT5uN/uGrKcPygv5oQZd8slag8vlR/EVM/clnxr7HrKZ5o0S1eOEj+sEvdJ98T2lgRwIfon76wtQSPLjL1NmHQLv6qLOW1l/Tcegiihn5vz0g0uCx0w8RVW4zhrlywULdOviheF+brYMgmeEFPf9gt2DVxbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732537341; c=relaxed/simple;
	bh=kiRRuXQaD3XVGGp1eAehR/N/lQF06HOcZqNVhtcB8Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkI/2Q+ncjFKX+fGxpVTIUkxTZlFCIMFdvLlYlQ4i3xf2XLPpgoOZvQhq3fDbNNz6Ug9IfznnxvavG9q07xYkamtUyEJnE5WRnjpQxZma1G46Qo7HSGVjygoLc1wwN3PoS6pJlGe8pCClTC3f++lnZyHGR0TFkpiD0oCUEojSmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcaWyP3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955C2C4CECE;
	Mon, 25 Nov 2024 12:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732537341;
	bh=kiRRuXQaD3XVGGp1eAehR/N/lQF06HOcZqNVhtcB8Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcaWyP3DPpjbbaXo6/wnNro+w/a1+KzhODH75xXItbRRksA7N8AQA4gq5dPgWry4L
	 nmDHxpAYNKy+nCsk6gbQQtJN14wT+J/sooqUOkk4L4LuA+9+jwrwWnX4XjZdkqkyHc
	 3+GySsr2NnqetVkR/hVhtuQcdqaNlzUIVnoETzH7fSFhhVL7zPowRXpCm+uop/Abfo
	 gKr631tMD8kOrDYZSeGSXacO/0lyv+hG9iRgMDumvEj9u1mZsgQCRJkaBwW6MRgBZn
	 WHpqGJpDi4Ea/mvBfAw+pKWi0F0R02TY5aGZl7M4Vl5dc6YrFEfYyi1CRZnjj38Qq3
	 T5aFezkMhemwg==
Date: Mon, 25 Nov 2024 12:22:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Cosmin Tanislav <demonsingur@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: detach regmap from dev on regmap_exit
Message-ID: <3b35bd30-c4ca-459d-985e-d221a5cda2c8@sirena.org.uk>
References: <20241122151631.220609-1-demonsingur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n4F71T5srfKryZF6"
Content-Disposition: inline
In-Reply-To: <20241122151631.220609-1-demonsingur@gmail.com>
X-Cookie: This bag is recyclable.


--n4F71T5srfKryZF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 05:16:30PM +0200, Cosmin Tanislav wrote:

> +int regmap_detach_dev(struct device *dev, struct regmap *map)
> +{
> +	if (!dev)
> +		return 0;
> +
> +	return devres_release(dev, dev_get_regmap_release,
> +			      dev_get_regmap_match, (void *)map->name);
> +}
> +EXPORT_SYMBOL_GPL(regmap_detach_dev);

Why is this exported?

> @@ -1445,6 +1457,7 @@ void regmap_exit(struct regmap *map)
>  {
>  	struct regmap_async *async;
> =20
> +	regmap_detach_dev(map->dev, map);
>  	regcache_exit(map);
> =20
>  	regmap_debugfs_exit(map);

The one caller is in the same file so it can be static.

--n4F71T5srfKryZF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdEa/gACgkQJNaLcl1U
h9Aiogf/W9D37CEyiiq+FUXskxPdaKCmDTxx6JEi7ftS6AI6eX3ovYkDoive9K4A
awphcnIE3EijzMXsQKJXMCsb8alX+7IwMHr5Wz6u15X4BDNb5VvHAdt4PcA5cVR1
ir+bHeMrgFLX62mUJt25gDqoL25Hr6z+ViF8Erxaar5vsiMICoinwz1w5b1Fg8Zr
z8FdMkArog7nXYmp9/u68FEFQUr/hHzbOggHPUyEeG9qA168GllI8NWND6esmiGM
eLIqKY9cu6NJJ8gq/4Ml5GBuUYdfjELcB/NbiUFXf2eyCQS5NQoowXTYYUP/cuFA
J41vBPiCQhic4G/0wCPaYYjHudoBOA==
=m5u9
-----END PGP SIGNATURE-----

--n4F71T5srfKryZF6--

