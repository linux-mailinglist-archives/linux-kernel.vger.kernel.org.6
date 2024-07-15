Return-Path: <linux-kernel+bounces-252805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C23593184B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63551F21C91
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FBC1C6B4;
	Mon, 15 Jul 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVe+PWq1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196791C687;
	Mon, 15 Jul 2024 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060005; cv=none; b=F5yqkq7jMW+EXMVmDSUdsGR8ipA9O9vmIDWiE4lScxGK9ayk0zi+LUVmRD2z+LZMhy/B80mW+h4IEm86hrzCokv/I3iRGWs3BUTvOemRcmjy40/9rFLI+grDd49U2cPkjt510QlMM1JeoMEjOT0vo4kyMDCkKoOplkq0MARrMl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060005; c=relaxed/simple;
	bh=dvBwbe6MPDMfh5k2bT4Qej0uPTJ6wp7QSXUAmI42I0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsRJAJ/Lj8P1fRZmYUqZjv9BS0JJ3Ac8Y8fQpZ9IM0LYu9xa6VB2IjDCnv00JfrBPtV6qfGDJZ2BD1MmyvHCPwbDMHs4u+58RwELpWAO2iWK19WOjMaL0CSwdH6vfJQgHNf4qk969nyTAkYTEwM84SM4T+Lg1hqkij5IDXytIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVe+PWq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C188C32782;
	Mon, 15 Jul 2024 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721060004;
	bh=dvBwbe6MPDMfh5k2bT4Qej0uPTJ6wp7QSXUAmI42I0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVe+PWq1Kci1ereIuw3C41BQcjO20zKmJiiWg0e7V8bKmSs3gs5rX/tLjaNiiVB9v
	 OzF7d2Kry7BnebXfPwPg+J1RGr88zE/XqJPPkQSy1uXKy7I51ZFPrRxCsL8MkFIITt
	 lFzLZHeswYY3TvPUXvULIkh0VixoSjWuznH2nfFf4wBK2KFvPEu8OHpv+j0rGQ3n4C
	 Nrz372qZzP23knwGGPWXu7Tct/hT4uDMiSk424TThdQfuFd0XHNt/twNAYEPjvca0S
	 NuyT2Cmn6YhOCqN/6rtkEWvi7MLBjiYI07YmWG03fifLP45NsbdZPFaiRSMN9Be7Ht
	 g8rFYrW0thk4Q==
Date: Mon, 15 Jul 2024 17:13:20 +0100
From: Conor Dooley <conor@kernel.org>
To: zelong dong <zelong.dong@amlogic.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	kelvin.zhang@amlogic.com
Subject: Re: [PATCH v2 1/3] dt-bindings: reset: Add compatible for Amlogic
 A4/A5 Reset Controller
Message-ID: <20240715-crucial-disarm-8907b896dddc@spud>
References: <20240715051217.5286-1-zelong.dong@amlogic.com>
 <20240715051217.5286-2-zelong.dong@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W6+4hMDlu8VoAtzt"
Content-Disposition: inline
In-Reply-To: <20240715051217.5286-2-zelong.dong@amlogic.com>


--W6+4hMDlu8VoAtzt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 01:12:15PM +0800, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
>=20
> Add new compatible for Amlogic A4/A5 Reset Controller
>=20
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--W6+4hMDlu8VoAtzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpVKnwAKCRB4tDGHoIJi
0q9jAPsEXScXXZVCt1gtEui9+60JKkeZKU7UR7A5D6k4BBB6LQD/dGcKkYIYmwCq
ZAP/73A1jA3CD5a4CXj4knZapruK7wA=
=Uoh7
-----END PGP SIGNATURE-----

--W6+4hMDlu8VoAtzt--

