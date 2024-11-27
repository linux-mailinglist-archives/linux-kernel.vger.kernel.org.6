Return-Path: <linux-kernel+bounces-423838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19019DAD74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81D8281EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776AC1FF7BC;
	Wed, 27 Nov 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2H085Y8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8021F5FD;
	Wed, 27 Nov 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734049; cv=none; b=EJ0PmdW/QsiwsQPmrDQu38pBHPRJRvVbpH33URlTX7Dt0+MdbpTYHN/+/SIXkpkN89AelqegBEl02uprXn1PUZ/gqjtcMEIxGdgr5wA+loQ5ddA3VvF85DWS81vMBTMHDNjJgNckKIPKRHSG9dAdXSwzj+bu89vkgHReEkmxRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734049; c=relaxed/simple;
	bh=stwjnGnk0DMxkcjdPTNVNJUobHrJYgbm5W0wA6Sug34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZbZjU+/omhSlNoxCy07GI5aOJ9unBjJodpToOEfSkqJg1E27qTpO2ccRvFM+pVR1VPd7m7v0sJIJ7NwlBtxrXschPlo8YTgQM2+cnaEojHtFpYCQElZyHQsScV5M2VSuO4aIqMTiSwk7aX8jVNiiLzsRxckiqCoOT/fj5R2tZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2H085Y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E462C4CECC;
	Wed, 27 Nov 2024 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732734049;
	bh=stwjnGnk0DMxkcjdPTNVNJUobHrJYgbm5W0wA6Sug34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2H085Y8eZ+EJL0Vp6lK1S0Cka4gBCSm1WqJDcii41/tx3Q1QrQsIiqmPSEEkmxjD
	 FpXAGRQAhd5AU1Iv4kx2Yb8v3kq0UhZ1rbv4yNNcffAItqvsvP72ObPdm8Z+RXqrBI
	 6A0MrVhd4D2qUW0mpMFlboAFDLuTbpTIUvWLPNr6YMuqhULpq9tN7VSpo7O6EcsthJ
	 fpEOTg/rLu25cQNFnEThAIwfjjYkP59eE9pUmcT593gIpfc/pcZR1SWs7+LD8lEAZv
	 MJ+u4x9eJhpDExiZMq4EGFePOda/jjkJaiWw7SYYfAX+BqdT324irH1ChsfoHIHtUL
	 ByKL6LX76Z/pw==
Date: Wed, 27 Nov 2024 19:00:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Message-ID: <e714ad9f-6a31-44ab-af2c-29f052cec07b@sirena.org.uk>
References: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fBmr5vGOD0aDrNaq"
Content-Disposition: inline
In-Reply-To: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
X-Cookie: Every path has its puddle.


--fBmr5vGOD0aDrNaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2024 at 07:47:46PM +0100, Jerome Brunet wrote:
> Depending on RESET_MESON_AUX result in axg-audio support being turned
> off by default for the users of arm64 defconfig, which is kind of a
> regression for them.

> Cc: Mark Brown <broonie@kernel.org>
> Fixes: 681ed497d676 ("clk: amlogic: axg-audio: fix Kconfig dependency on RESET_MESON_AUX")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Mark Brown <broonie@kernel.org>
Reported-by: Mark Brown <broonie@kernel.org>

(I reported this to Jerome on IRC)

> ---
> Hello Stephen,
> This fixes a problem introduced in this merge window.
> Could you please take it directly ?

It'd be great to get this into -rc1, I've got some of the affected
systems in CI.

--fBmr5vGOD0aDrNaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdHbFsACgkQJNaLcl1U
h9CFhwf9FXbeRLv68awMr86hSLLgSKMAQX6/IB6cA/KrLw0zKPUpVtq4T4rgrF62
dgaTI48w9uz6aP7wXU55jYwZiNQrnCZ5YFlAF3sa0Hp18oMYAeyKC3zwGV6bCaQu
h+o8wXq59ThA/Tn9IKq6Op6WDhk6Cgg8KufIu3yx1y2gO8D0+ltttuHpFnfmPmuU
cmGWvdAEUtk/j/JfA/TzlpF4e0rPx2XpkTWLYGBs5mbqpkr7VkkYlnFTcUbMWdKb
bPFAubHBjKEawqmZn60wqlAbHB8tOJ0OrG+oUEok7MYaPt+hwzG6pE3d1ukSbLFt
CAcEJ9DcfS/toyp9owKXsI4HGdKVZQ==
=8CNX
-----END PGP SIGNATURE-----

--fBmr5vGOD0aDrNaq--

