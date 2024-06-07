Return-Path: <linux-kernel+bounces-206136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF69004B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D8F1F255A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D15195990;
	Fri,  7 Jun 2024 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVeaaOCX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D01940BC;
	Fri,  7 Jun 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766680; cv=none; b=YsI+CkQ26HsqkMpCyyDc7isQyWtcuQq2kWaGWkk1xrRltAexrdMIJWk5s+tTe6mYJKkHtUSCaADZfarKwVvSMBZdth/f7NXtBxgTSNFytG8owzGIrpRQfAHa+umfIy4vzhfiPZAyaPFVy6+cWRNOXEV7j/aG6aSZSXZnVPrWVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766680; c=relaxed/simple;
	bh=YbJcBpp8yIvnSCN8WRwj6FjNlOfZYKiO9gj5KCjH5aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP7Gz8olirlTuC9915jgbm8MJLUcW+f9+IGJ8WgHVuQvbZBLgwzdMqCfe0DP5JzrhNDWLg0h7wZl/2mbjuUwxINGND4iAwSedJ/M+X1IHYknlPjcjtu2tOfuaVAQ7eoaXJ+hyWtyLKzY++0U7EXnCbU2sig3sju6m9KlBsj9+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVeaaOCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1B5C2BBFC;
	Fri,  7 Jun 2024 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717766680;
	bh=YbJcBpp8yIvnSCN8WRwj6FjNlOfZYKiO9gj5KCjH5aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVeaaOCXf13ZLy9yKDTa52kd3VhZcWNVucNL3xA1dAeaeOr/OI31VaxbnWYIENtbQ
	 dx+TfpA9gpHhCxwTzT6TWluAso+zV/gaQrPnKPHRkuGmUO7rviDP0/y9HWEMc9j+iV
	 hs6uAvxeJ1B7SMrCmRBXc+x8wH2hubAPn7iThKicd7SZXcr8Lx2iPLjbEhCkkk8sBf
	 pN4B6HEaiQP8Buez0Rr1MJvvZGVlxC7LR1HKMR0BcNTBV8GlFtSnt21oPlsEwdpuhA
	 jPP39mPSXGXVOg2rgLlurpzZRXaUT9Fvh0QksywpeX9cAhC0OTCax319xOQn9jPrFy
	 AYHsvRWG4JupQ==
Date: Fri, 7 Jun 2024 14:24:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: ak4554: Convert to dtschema
Message-ID: <ZmMHue2SPMnw4KMO@finisterre.sirena.org.uk>
References: <20240607055725.38057-1-animeshagarwal28@gmail.com>
 <87frtps29l.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZCXtoXWmNaoCrLYcSCO=V=O_+yUVoVJmnPkpysUYxBQNw@mail.gmail.com>
 <7dc8805e-61ab-40e2-94a4-2e0e36449820@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AWj6frfohMcjigId"
Content-Disposition: inline
In-Reply-To: <7dc8805e-61ab-40e2-94a4-2e0e36449820@kernel.org>
X-Cookie: Your love life will be... interesting.


--AWj6frfohMcjigId
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2024 at 11:27:25AM +0200, Krzysztof Kozlowski wrote:
> On 07/06/2024 10:42, Daniel Baluta wrote:

> > So we just remove the device tree binding file, right? And later if
> > there is anyone who will use the
> > codec he can later add the yaml file.

> Remove the binding and the driver.

I tend to prefer to keep drivers unless they're actively getting in the
way, there's no requirement for people to upstream their board DTs
(we're trying to have boards shipping DTs in firmware...).

--AWj6frfohMcjigId
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZjChMACgkQJNaLcl1U
h9BfgAf8CbxWB78uq1p5MVg3yZGtifP5D0O9ppI2jagyFD8hf4BCW6Obej4fSlJx
eIWwnw3020/pLVJkjkl0QDOVuC2tgHOQq3+mHshqjCH5qHotqHxi48+jcU9GUtUd
menckUMGbLYCw7+yDzag5RUUy3ouAzbVsJ32wghOXU1txtT8u16xC/bIGdLcWURL
RZQXNsWRL1nrJ0v3ChzGCDkKrD474NMBYj8Y/Xuy5nUOlFaq8cMMohytawPVb0to
qSCl6Ie+Tv4JGngot1FEbQY6G3GDGC4thC1r+IB/I+e3C4QzUeKRQK79XfEF2Jwg
77LXO/jjso7yJDm8/tFu8mM3LNnOAw==
=cfw1
-----END PGP SIGNATURE-----

--AWj6frfohMcjigId--

