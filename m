Return-Path: <linux-kernel+bounces-398336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB799BEFC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 132E31F21964
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035B0200CB7;
	Wed,  6 Nov 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGC5ALmY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A651D63DF;
	Wed,  6 Nov 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901926; cv=none; b=JRcVD4yx3yztrrmc5x7JvY8/n2TMKCbyOgIWDHc4H3sdse1VJGPkmvkvekoVzQ74ee2BV8/6Vc2fIzH8N/dtGHUkqBKNXlVdqdL6ttDrMTeVmyOetHss4etnucymUQSaTl/4qZYu65ZRF5WbUfXRLOS2VrXq0UK5LJSQX1k9AXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901926; c=relaxed/simple;
	bh=j1W9k4oVkIQL68KFIkXY480BVKIr5DP71SiPlfPiec0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tza8rqh9eUPZFcAJYTuJp5GlAzxa9P1wwaY3aK+AYgxmcWB641VLw6ipZbs8WBR8WCdtKWG9DNdP1IMVaBX/It1ivhBAR5ttcLM2J4ZvKltcmkZPTopZotyg2rO+F/+2SEbz2qse54jNORSAMT6wN6y8bN7wxIt55jlllNK84Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGC5ALmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D01C4CECD;
	Wed,  6 Nov 2024 14:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730901926;
	bh=j1W9k4oVkIQL68KFIkXY480BVKIr5DP71SiPlfPiec0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGC5ALmYPQWR5iJ2S0XpFdPr7MjA8d8poSP2BqJbGh/BYlBL54G/wFDKbktAYTLfY
	 r9fIDGuk73SjSSUaXu3ir5NPlwkCnXyzZjLy5enuQm1qK6GemkA+PjQzx4w53VY8A7
	 lxMjqzUS+UQtIi1DwGkbt/b+WsgDcLro+ATkj9tkzCxYpol6WBsd8uUq3b28PkiFLx
	 7OppV9IBsVa3SUGRvk3b0hBMFReSK4o8fLx+9dflAw2UAiFP5oHBuBJFo3oUAuggUS
	 u/4/o760lT0O7ZWQ3r3hL+9SdV7fp0TDF44aWJozT5stfWXU5//2yGwxjzIDxSQehh
	 d3vRdyBCgpxUQ==
Date: Wed, 6 Nov 2024 14:05:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kiseok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/2] ASoC: dt-bindings: irondevice,sma1307: Add
 initial DT
Message-ID: <092cfb04-378f-4997-88e0-35c247b8c445@sirena.org.uk>
References: <20241106005800.7520-1-kiseok.jo@irondevice.com>
 <20241106005800.7520-2-kiseok.jo@irondevice.com>
 <kspk7qajv7r5glbcawmecbup36cv4wi3hjrgyfyyejjectwwt5@u5nx5y5zirsa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x/ijW8mKOHC/k6vi"
Content-Disposition: inline
In-Reply-To: <kspk7qajv7r5glbcawmecbup36cv4wi3hjrgyfyyejjectwwt5@u5nx5y5zirsa>
X-Cookie: Include me out.


--x/ijW8mKOHC/k6vi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2024 at 02:55:21PM +0100, Krzysztof Kozlowski wrote:
> On Wed, Nov 06, 2024 at 09:57:59AM +0900, Kiseok Jo wrote:
> > This adds the schema binding for the Iron Device SMA1307 Amp

> That's a v5. RESEND means you send exactly the same or the same plus
> tags.

No, this is actually a resend - he's resending the v4 that you replied
to just before this one which was sent with mangled subject lines and
missing changelogs.

--x/ijW8mKOHC/k6vi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcrd6AACgkQJNaLcl1U
h9A9EQf+IMZncqsxypZL+DNHZLVibRmnJzwUQ3E0MWBrX1jUxeu1XYC1FYLY8oez
t1TYTsBkYw+dbZt1Ia7M3PkEAo4KxcAY/nFr/wUjWt7RYRpNUEi1Fcp8qNCRumnx
yPpanG1xxPgDx0hJ9/lQo3x781dcEOjy2wZQjyxYiiJdhSNFbXxpxSVoScG9xhXo
1MZisRDS2wUEqORD3E+ejcDr9Sc6fnEr0fshHzfK5dlReGjDAjMw5sTfd7ww73mU
IC63KnNvtjMSJEdLlTSYZRH7L/Hx4cgDE5JYDrAWCgybiba9MxwDPolhGNIw42Eu
1ibvbAhNnALQEVMv61Nyke46/X60uw==
=C9SO
-----END PGP SIGNATURE-----

--x/ijW8mKOHC/k6vi--

