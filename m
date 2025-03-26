Return-Path: <linux-kernel+bounces-576999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3366A71726
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F3417458A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D151E5B86;
	Wed, 26 Mar 2025 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNi6fQYb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7731C701C;
	Wed, 26 Mar 2025 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994752; cv=none; b=USWBfOApG7JEAOXYHLARHRc958IN90d0YWi2kbiaUYmKA++UPFqhypPvXKbf0I4Uw22Iw5gbXFFLrrnKnPOJWpD+hdk5M1iveeL+wcbC8KUuWYrhmHFZ9dcU1448Qx9/SWPDe9trJWongxAntd+lXYRX5T97eFF8NWUDCprfvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994752; c=relaxed/simple;
	bh=HCfzXEsmtAEgS/9JjKgGe5pakNcg/XMKKdGR8ISCZXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyoA/vELafLXmHlkGpToHbwuCciQVmeFDvOr/EXd1K65uzXz28Ag7vr2AHsEQ7LgySpp7XWRw0nUyeW5gNOLpaidYmPq6t/ylRPEYTO1fdsFJ1Ud3EK/CXt86oqiw5oq9YvgaeivA1LkG9yOBv/ZL1AvHW8wEVLdw8a3JbUGEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNi6fQYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43B9C4CEE2;
	Wed, 26 Mar 2025 13:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742994750;
	bh=HCfzXEsmtAEgS/9JjKgGe5pakNcg/XMKKdGR8ISCZXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNi6fQYbJ2INpUGj5Td0RZZyyhMhK6LATG+fi99VgDytpBEjxu8+UEVe3dlxGEIsI
	 Csz2MfjOEnsIv9eaGovhVXazMhqb/jjucX+/Zk73o824Jvhs9yTZxweYB5wrcRfVAy
	 WmnXKemTFJYlfCdETLjA2fD/m/iaa7GXRda2hiTm79bWqR8QP17czHzU+FSipawK5o
	 ZpVDnw1svwgN8NRS61AyTRCfkhpjIpQkKeKTtMLe1DjgMSIbhhQxebonL/0qGHh/Nm
	 85cC8HJTLqWmjGjodhGYiKJCdnVBJgFkdL0ru5bvL5Uw/Tne3P7voGCKq7YmQppeTI
	 58KFaTfJaT2Dw==
Date: Wed, 26 Mar 2025 13:12:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/14] regulator: bd96801: Support ROHM BD96806 PMIC
Message-ID: <7c07c3e2-9586-40a2-97b6-2552c36b8ac4@sirena.org.uk>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
 <734397c8bdb86419fbced3432c7074badaad6657.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BPARvkvKQ2c1mBWe"
Content-Disposition: inline
In-Reply-To: <734397c8bdb86419fbced3432c7074badaad6657.1742802856.git.mazziesaccount@gmail.com>
X-Cookie: To err is humor.


--BPARvkvKQ2c1mBWe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 24, 2025 at 10:57:12AM +0200, Matti Vaittinen wrote:
> The ROHM BD96806 is from the software perspective almost identical to
> the ROHM BD96802. The main difference is different voltage tuning
> ranges.

Reviewed-by: Mark Brown <broonie@kernel.org>

--BPARvkvKQ2c1mBWe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfj/TkACgkQJNaLcl1U
h9BoTQgAgSWrLYyVR17nX9AQefzS+HztJBxcKixoh/hX2jZWTsPI2wR2lMPPQssW
6hlc61JuWNiIVIQ5TeoSBZ2kO8quAf27c8nzE2if7E8c2Guz22C6b8tb4zBuzS6s
bQbaJP3HiFgHdqkAqyw2AHgDqCK+dH2SjF3Nuoelm5BqJ2aAvLCuJBFR3LLpm4XS
gYnoVTZK8c8hpYmDImIBwYmEtN0Zd3Nq93tH0kKgE3B5DGPDcaRmLlAX39Vv7WCs
knR5eWvT+Sxa2JCRESRuU99b/fV9vUKx7QE0utmM/Fx5G+a/32eDjP24Klc91/p9
kAtSK+tXh0urTtGRrKjntVjhSKgO4w==
=LOE9
-----END PGP SIGNATURE-----

--BPARvkvKQ2c1mBWe--

