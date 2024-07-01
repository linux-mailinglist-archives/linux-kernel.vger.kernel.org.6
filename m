Return-Path: <linux-kernel+bounces-236508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F2D91E332
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7A51C217C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A516C860;
	Mon,  1 Jul 2024 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrqXYAsl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829EB15A865;
	Mon,  1 Jul 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846222; cv=none; b=gwB2QtzktBbhpatWGgKGwrG//pe6FjE/AFWJ5SVLVqKseHaw8P8yVq7M0+us11wnArU0k9YTl0iQjuf1eHufTmEHFbnSt+SsAmOwMyFLtOjRctONIGIzxnwMUYjlxRWSLdUSW5NjXdkbD9CpnUixqfdLyAO3JpGUh+4S7dR2gaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846222; c=relaxed/simple;
	bh=U/EJ8D/Tfr6OznzJRJUQtg9hf0KFmSbGxB7rMS1TF5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjNowoFH0YGLJwAUuJrxZctAxb18muaHg1QuH5X2BXFEUArJ4b+Xwxr4QJP8v9LLPf/UItaxwwi5EDArcIS+X9nGqT87uWTc7ETthTGpRDRvaKS0oQhzA9fATNwMDtvtAg/NDhl8kfDdSdBdvpPWdwSKqXZHHSVQmx2Eyr/T28A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrqXYAsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82747C116B1;
	Mon,  1 Jul 2024 15:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719846222;
	bh=U/EJ8D/Tfr6OznzJRJUQtg9hf0KFmSbGxB7rMS1TF5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GrqXYAslaCu2jiWxD12Vy0N0SS2Uwx67L5z927STQmY3ibxz+qkf8/XzfdjCdzh9M
	 W0ONax2L4+PXgPPunra9AK/ieVr54F8I+AfQg7VtbEPvolFbABu1Iz1/mhYJEkqEVD
	 ZbhSIJRS0LHwakM7ZYbbl7hv5rgliOtv14waBSRQsjf8yb+WxssKNZVKActCcZ0NS4
	 2PE5Ppm/fXD+JyJoTnPA7vQZhJE81839aPqArsuctjloddfCGtdYB47fR9+8z++i9j
	 aRlbwTWqUBYROXHyXlXoIRe+1KdiCfBXVs/iTvpEeh3ul9vRk8FSUVIz3DrCzrOQRq
	 QzxcURxkippNQ==
Date: Mon, 1 Jul 2024 16:03:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: linus.walleij@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com,
	joel@jms.id.au, venture@google.com, yuenn@google.com,
	benjaminfair@google.com, openbmc@lists.ozlabs.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pinctrl: npcm8xx: add missing pin group
 and mux function
Message-ID: <20240701-unreal-fester-477720e68dae@spud>
References: <20240630090104.565779-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2UZrTae3B0K5RTNy"
Content-Disposition: inline
In-Reply-To: <20240630090104.565779-1-tmaimon77@gmail.com>


--2UZrTae3B0K5RTNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2024 at 12:01:04PM +0300, Tomer Maimon wrote:
> Add the following missing pin group and mux function:
> smb6b, smb6c, smb6d, smb7b, smb7c, smb7d, bu4, bu4b, bu5, bu5b, bu6,
> gpo187.
>=20
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--2UZrTae3B0K5RTNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoLFSQAKCRB4tDGHoIJi
0kWlAQDrib++ORF3992J5J2D4JW60q9UtcZJrVsV7tMdu3oHcAEAys1Wd9QhBgAV
bXzA+/Vev8OlNVlUYuwH7Fb6xGNl4wc=
=6aKU
-----END PGP SIGNATURE-----

--2UZrTae3B0K5RTNy--

