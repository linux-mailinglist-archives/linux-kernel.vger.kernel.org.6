Return-Path: <linux-kernel+bounces-423736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4769DAC06
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1552C282CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040C8200BB7;
	Wed, 27 Nov 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo0dS/iE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104C1428E3;
	Wed, 27 Nov 2024 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726063; cv=none; b=FZd30QxD34yjgdEd4W2qvQUyHUH9QMLaqly2q+oxoY/9WyYpVRAn+NpEKWG59OO5Dox6Xhmk5bUL7YUjDchdKG9bhTgWjUnzgogrjEs0Kx8cenUUQYKFKlOPAEFT+Gos16pdWZNEa17uLA/ahdw0VfYU9BTOFYYCaU2V6ucFqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726063; c=relaxed/simple;
	bh=mtfe2NOqbCfz3psjWYNHrEDGlK5BP7RRwd1d/jmG0i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ppcyd6aRZSZGMBwbs2en5gomss4GdPmxRQpqVqduuQxJHoUYqDqV9TSecZf2oVlpA2ACeL+bDbTw/5xFEREqEc8LijaRLxZthLQkY9KflEgMetlMizUWBT3AwHfgqJFYEezxukyblRdO6qMciqvYnlGvhbO8se7IoI49GmhUPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo0dS/iE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BE1C4CECC;
	Wed, 27 Nov 2024 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732726061;
	bh=mtfe2NOqbCfz3psjWYNHrEDGlK5BP7RRwd1d/jmG0i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jo0dS/iE43Xopq61VTauW2oll8xOcEy4XbKNEIFKp0Ns08bD8aFAC/CmNodV9zHC4
	 pqxYJXfPzR+0oS/duUzo1y4EX34bcP7wFr0/qX7q1f2H6XXrQRRKAmXolZJobiUc0Q
	 RKMxKPzOoY1rgXdYKKHSEgHAs0Ee3kfktmr1UdZZ02X9V9w3R2Dl9/9JzoQZ8GXKa2
	 q5p9yMvashONZg8Q6Kt36cjZhwmTbOYHsKuOdgs3ElMdInmOAkypl8Rq5aZybgr1NQ
	 jT36ze5dALgUteYGLkG0BfwrIwia5AQ0u14fke701toKPWUqqIfhwUj1kSS77UZfXy
	 /DGyFocdDFRXQ==
Date: Wed, 27 Nov 2024 16:47:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Frieder Schrempf <frieder@fris.de>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>, Robin Gong <yibin.gong@nxp.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Joy Zou <joy.zou@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 01/11] Revert "regulator: pca9450: Add sd-vsel GPIO"
Message-ID: <26ddcc86-7583-4402-b6b3-7c4cbe63ed94@sirena.org.uk>
References: <20241127164337.613915-1-frieder@fris.de>
 <20241127164337.613915-2-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3CfSZ6vXPVxUCjFn"
Content-Disposition: inline
In-Reply-To: <20241127164337.613915-2-frieder@fris.de>
X-Cookie: Every path has its puddle.


--3CfSZ6vXPVxUCjFn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 05:42:17PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> This reverts commit 27866e3e8a7e93494f8374f48061aa73ee46ceb2.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--3CfSZ6vXPVxUCjFn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdHTScACgkQJNaLcl1U
h9C+fAf/fKV4GhE/U5x7gXRxMU7czUWQW1GbYGA8bZbpLHcgcVDGVEEUJiRKslTw
hWxbJLpvXt/X0j7Rwque58R1TXNfOBGS9dPReC19VaAL26/rxDLnGHpBGVMefIaD
B1v4QwukgYJXksR6Cr9hyVqBo1pFk37ehoOy/IYuxkJOcjFFeHLx1LHD2fVonrMP
yye3VusjeAQqPIEf5c+g/PLRrpsnHrO76FeE18z7AxFqrmzuxbW0JWJsE88xnYQO
COgKxP+jGKxhd6CvCdTpIRt9LnTh6AU2sWtZHQmgtbRy/7vPJ0BSJ+F4g3pbCrza
zBLTQvZPwdsRRgOFHQUMm6SICETdZQ==
=D4p/
-----END PGP SIGNATURE-----

--3CfSZ6vXPVxUCjFn--

