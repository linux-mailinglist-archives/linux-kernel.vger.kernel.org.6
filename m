Return-Path: <linux-kernel+bounces-242424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2349287DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DFC81C20BDB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A714D420;
	Fri,  5 Jul 2024 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecVUe7Yp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855D14D2B7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178572; cv=none; b=GMDsqBVDQPPv8lJnM90ML32GABXa9o3zgvlF8+7S4XxFHRANor4W0+tgZ64jp8iYcfMtfj/OVd8Y8cezqFcx/F4hrsOsMLQ9WyFTWp3b5tUfHuXc2y/jItP91oGwSBYKUAQ78a6/kUqQVTtu0nKGS1/y26u8h/ahBjphGFfChOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178572; c=relaxed/simple;
	bh=siK+WsCjThxX6kLGlGGiBzMWmzhtoeOhi7+J8wO+rGs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snwvwkHzT1hp6GThBIm2LV1NzRYsX6Jn9WtZxwwMiUHyMTU1MPQaiKHFn8Fg5giYflw/n5ejnEZGYingVAgHNV/Ew8aYNHyi5ZfFptxihm0ERpqkNbcRnBmDiaVzHtlhoQkx8e3kkvHvzz8P5SttxicoXIRrqR04xxt3aua2AOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecVUe7Yp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E889C116B1;
	Fri,  5 Jul 2024 11:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178572;
	bh=siK+WsCjThxX6kLGlGGiBzMWmzhtoeOhi7+J8wO+rGs=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=ecVUe7Yp7UtIWz9GdybcEDTuWIsa4Bw+a7zTS8hbXtc9l2dMNp9R6ESAd2wpEjPwH
	 MwsJbzR/poncv+Rr3YR2xwfGelntFRn8ElxQvERL9EUZYtbmdlrtg276Edc5P0L2h2
	 w0KEKdBkMu0V4uXqF21CCvOFou+YHXFYXkN0+rDlj5sVrfZhtgN/1NCYweIvqW8jUX
	 ecIJsDdSl4aa6o1XujTyCR7xI/0y3aPlqcD0bm2cvupGXys9fu46JbS07XKcgfgyOq
	 /1QOweWTo2tW8S8ztMiGiYM5u9yrndMNMGfpqVN32tkiRCXGMhRId9TASaSHeJZwR6
	 w+8q3P+BK6VVw==
Date: Fri, 5 Jul 2024 13:22:50 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: drm/sti: mark it as Odd Fixes
Message-ID: <20240705-hysterical-beluga-of-courtesy-38b2e2@houat>
References: <20240705100356.16760-1-krzysztof.kozlowski@linaro.org>
 <ZofW1v4uEFo9GscF@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k64hyfzn7hehngnk"
Content-Disposition: inline
In-Reply-To: <ZofW1v4uEFo9GscF@phenom.ffwll.local>


--k64hyfzn7hehngnk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 01:19:50PM GMT, Daniel Vetter wrote:
> On Fri, Jul 05, 2024 at 12:03:56PM +0200, Krzysztof Kozlowski wrote:
> > Patches to STI DRM are not being picked up, so even though there is
> > maintainer activity, it seems that these drivers are not being actively
> > looked at.  Reflect this in maintainer status.
>=20
> Note that since the driver is in drm-misc, other committers can also pick
> up patches and push them. Both Neil and Dimtry have commit rights and
> should be able to pick up your patches for you, if they get stuck.

I've applied the patches.

I don't think we should merge this one though, a one-off mishap can happen.

Maxime

--k64hyfzn7hehngnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZofXiQAKCRDj7w1vZxhR
xQLuAP9k3VJ0gKKhQnYshAlYjTRPapTxwDF9YfxKdGayE/K/lAEAi3f7LPtKIV2c
rLdP+w56xj5Bet58rY0MQVcl1rO9/Ao=
=3+4M
-----END PGP SIGNATURE-----

--k64hyfzn7hehngnk--

