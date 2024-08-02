Return-Path: <linux-kernel+bounces-272572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7382A945E28
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEA7B2196F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84111E3CCB;
	Fri,  2 Aug 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEzH+/uW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109AA1E4A6;
	Fri,  2 Aug 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603417; cv=none; b=VhskhJO3q7Ivalbw5bZuy5PuWC7P/3MS85iI58Jo5rIaNBhSPVVxpWB6y2MkEDP8k7s0Fw688ab7EBanOGJeEWW+5c/59xRS7he468w71Q/krS7DEeEszp7saL3zxXKRret/QeenssTFE+1k/doysqfoySzuGJYHjTIo903SBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603417; c=relaxed/simple;
	bh=M0lDOXR/qXGdJ5JKDr6ogb12uVJ1ckxggSZBKXTNYn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja1zl60AipPXltsc1LrrC1Pjh3JxMrCRLIjgxhwDC0ca1GUJB49iLIU9wOiZgKb1NLk50uRtaAKB61rrIlzu5OYbYrojJqioqvA157ZECG+o1geAMalm0pnYo1JG8nCU0hgnhjdKQpSOVgBMsUjkPm0ZPyk7AdsK40fQ38JiyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEzH+/uW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216D7C32782;
	Fri,  2 Aug 2024 12:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722603416;
	bh=M0lDOXR/qXGdJ5JKDr6ogb12uVJ1ckxggSZBKXTNYn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qEzH+/uW3e+gDTRU0B6d+HeSW71nt2DXBmaGjAwFyDys8hvKiVdJMWjWS379a1Rkq
	 fHVqI0a0Yul7zwLHDjDHXPfV9xciG4j3fgDZEqRYF1tJ01r1K2O18MYyE0zrLaiNBa
	 LZvrwmPwh1iIGWqNdCJHozrI/guXl+bhC8ndASQtWjnXWVAZ3H/PdYyq3VaLNYYq0F
	 YaHwbCcd0WZz2EIj+dLmRy4mH9QWMY7vT/kmFwOxH9OadOGXsFQW7LEPOeuHxURyd2
	 Be3mKUAB0KcjCIeSDdxK+T5Kpf5V3Lvss8HN5mEEH4S0Zzd+i0qhgJJe42M+Jgx1Yh
	 A2F72HCV2ci9A==
Date: Fri, 2 Aug 2024 13:56:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Andrei Simion <andrei.simion@microchip.com>
Cc: lgirdwood@gmail.com, claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, robh@kernel.org, alexandre.belloni@bootlin.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Mihai Sain <mihai.sain@microchip.com>
Subject: Re: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Message-ID: <98f91a56-946c-4a40-b908-45f4c6c6d66e@sirena.org.uk>
References: <20240802084433.20958-1-andrei.simion@microchip.com>
 <20240802084433.20958-2-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qKDH2rbcwU01NrOg"
Content-Disposition: inline
In-Reply-To: <20240802084433.20958-2-andrei.simion@microchip.com>
X-Cookie: -- I have seen the FUN --


--qKDH2rbcwU01NrOg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 11:44:28AM +0300, Andrei Simion wrote:
> Based on the datasheet [1] (Block Diagram) PVIN[1-4] and LVIN
> represent the input voltage supply for each BUCKs respective LDOs.
> Update the driver to align with the datasheet [1].
>=20
> [1]: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP16502-High-Perfo=
rmance-PMIC-for-SAMA5DX-SAM9X6-MPUs-Data-Sheet-DS20006275A.pdf

I'd expect to see a matching update to the bindings.

--qKDH2rbcwU01NrOg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmas15IACgkQJNaLcl1U
h9DTGAf/VtmV60x/9OXgWkRuYYfFSBsCa1fhax7Pn81GcuwQviSE0WsjcpJAdhGg
GQTfTXZbVo8iRVPfnW10ZSfPx8K+iy2Fy0hSbknnGDs9LhcRVVPBe5BsOKsoim6I
PzrXTcIs1cL6djRDKTWo8jymoInmTYA1b7oFuUfXpHMP85dGokNTZP+QUOD5nl3F
Ux190NJPkJ4GrX1vIqN7Re48blZBKE5zcIB2rDuAMgkfWyI1qTB8zh1nSMkfiTHZ
cmzv7cKevrkHd522OOeN9rH/oT7Hn+nrVZ3kiEBte33BQrhPUWRi4bPMwcj8sv5v
kwGXnmJha5ECXYaaY8BpRZySor5Blg==
=pJFd
-----END PGP SIGNATURE-----

--qKDH2rbcwU01NrOg--

