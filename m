Return-Path: <linux-kernel+bounces-377113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE899ABA08
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8592849C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EE31CEAD4;
	Tue, 22 Oct 2024 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i++2HZF4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7391D1BD028;
	Tue, 22 Oct 2024 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639311; cv=none; b=DOV9QwwaIlK3CVjLcSPhkQjhoYhAac71dekIj/gZq8J7ThyR7IpEOLnhKG5zN6dcEfNp2Vf++zQ0JbfRDF954OsrU7js9USD12D0CTONIXXYsATXiYuHGpcO8Lml6djW3IIy5bJx/exZKKkIP0r6K8U8oVN1xubRtqpRLi9n6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639311; c=relaxed/simple;
	bh=uVlWcSMjnF2k5cjq+ArefikSP871gKuKGyx7WSiWm2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6eVIJER4f2mZdLCuR7sFu962Q0XT6X7peDn6AWomm45ue3bp02LdeyDRZ2phJ7Ke3QHOaIz09eS9mz2Le83Rh6Mwj4xXiPTih2MZ3Cs9YQ7f5fzkZL/pTknJPspk/UBprXqv3iJPRz2jJsbtx8KKJiBgfOgpAYjaJ/yPwBEpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i++2HZF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7857AC4CEC3;
	Tue, 22 Oct 2024 23:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729639311;
	bh=uVlWcSMjnF2k5cjq+ArefikSP871gKuKGyx7WSiWm2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i++2HZF4v7pRb8foI7igQPpTWO4n7dRb4flbrW8gVsTP4dLsZqQawTT0A18Pew/zV
	 a0e6VyEmVk1W81iDvbO8ePBqkT94WlBp97qd3nAfMD9fX0AsxCKdVnyhLLJIdWmREV
	 /ORN1TYHr/5L/Kqo70g8DDBXdDcF6V9QJILWiGqWb7n2F/gsMx7nSAU1/L9Iae9DN9
	 SW5V0MFd0FpGrOojc3TlfTDNKN3eT0/cXZxh7eiKElKOEme8f6aT6ZGkcEPOvlS64O
	 UhFxU9DpGZRk1W+t83Ys66aDAA/xZvkhTU8BmN5uuoqv0zP6+5aEo98TEn0W/WKEgP
	 wKdDtfkUOv9ZQ==
Date: Wed, 23 Oct 2024 00:21:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: srinivas.kandagatla@linaro.org, quic_pkumpatl@quicinc.com,
	a39.skl@gmail.com, quic_mohs@quicinc.com,
	linux-sound@vger.kernel.org, krzysztof.kozlowski@linaro.org,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	dmitry.baryshkov@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] wcd937x codec fixes
Message-ID: <1995b110-ff67-48c3-9a82-c29a6a95a059@sirena.org.uk>
References: <20241022033132.787416-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JqhZjguVmzWDQWKw"
Content-Disposition: inline
In-Reply-To: <20241022033132.787416-1-alexey.klimov@linaro.org>
X-Cookie: Surprise due today.  Also the rent.


--JqhZjguVmzWDQWKw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 04:31:29AM +0100, Alexey Klimov wrote:
> This sent as RFC because of the following:
>=20
> - regarding the LO switch patch. I've got info about that from two persons
> independently hence not sure what tags to put there and who should be
> the author. Please let me know if that needs to be corrected.

The tags are fine there.

Just as a general thing if two changes aren't directly related and don't
overlap at all it's usually better to send them separately to avoid
creating spurious dependencies which can slow down getting things
reviewed and merged.

--JqhZjguVmzWDQWKw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcYM4kACgkQJNaLcl1U
h9DwgQf+OewS7L22G981TNDiLYaZGcYfT3ua6E3unY3V4YYvkB9I3i3lXQXeRLoQ
zRwon+w891QfeSQB0eA3q/OFR8C41pgSXmrlJkr8qTrY8ysmEH7r27gkfGns9h05
3dFb+o3zzOJwGB/w7M3qfOeDF+jZURwsVTwFg5Bwr7cFhWiPTti46seHY8cxVWIm
bcn2rPukpceR6Qemea7l2rp948uJiuEQyDqPqdGkkl7F3C6KKC7/A5XUXPJ99ppc
+lhCyIrk+op3FLHy1Kx4DJFl6qjlqvDMMSWAjpcJbOdD1tWKrP/07l1aXMVZ5yrS
SAcjlPeHDy3RrL5yjOaCslIBDCCaUQ==
=hFMw
-----END PGP SIGNATURE-----

--JqhZjguVmzWDQWKw--

