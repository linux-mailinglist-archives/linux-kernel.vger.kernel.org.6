Return-Path: <linux-kernel+bounces-259234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC9939301
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE202822EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14AA16EC06;
	Mon, 22 Jul 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pStLs1D6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E8C2FD;
	Mon, 22 Jul 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668444; cv=none; b=uN+PFFa3HweYEsdWoQfPVG6j2S5q7TiXb04B0DkNMp5Z/zRpS1Op1TmT5LOyM9wcxPcaGNbEVsC6bGH4TqoDfkuAlAlAkvqip75mTPfQ88Dezwb7nOq3tExagOyJBry4Sjy/Y2pa6BcFB2Lnn/dUVdQDVcMGfw/W7pHg9ckOrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668444; c=relaxed/simple;
	bh=nqDbSeOEjrZww2bjW5Y5ACpg5VESlrarvu6Mf3utbgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhnAySxiKN3xDfivQyo+db9P3OZ5ZpGnisW1EmDKjeZhQuNgRcQxHe+s/pl8jue2XF+UF/2Ts99vw6lS9bkgZdXoy4tUg+3gR2gIX7ltE5ewVknDIIThrLnsokGWI75kqQX4YG9BH7NHKEvZ9vdI+FywPal4XXYhgNR/dRv8VTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pStLs1D6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1E6C116B1;
	Mon, 22 Jul 2024 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721668442;
	bh=nqDbSeOEjrZww2bjW5Y5ACpg5VESlrarvu6Mf3utbgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pStLs1D6atjirFbXkduIYobr0Ct/Sgjn0QoIpO1lee7/CbPaKgr9SafXtwvsS9rR+
	 grD7yprXFyTh5Pj3ebz5U/dM9p2xvPwKIDWbpv8esG5k9yH0wnfOvqn9Yxx7H7h1ib
	 acowwQN2rN5REX8JwQ0h4fAc9QfmWwSZTiBjA4I9FoGjBTcEv4bmu8GQXguEetAvg9
	 eCujm5Jd7f7HG7WrGi03Bfb3JEElL6IQIG4qZd4tucw5HYeUcn42N7BN/4DrrqMwd4
	 dbxA8RexnKPUsuDvsz2ccQfDgq2FbpN1Y97Ixv7HlgRn3IhbVgDMNS4TvIuR2pNAZ2
	 3jY/05/z+kRIA==
Date: Mon, 22 Jul 2024 18:13:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Harry Austen <hpausten@protonmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/7] dt-bindings: clock: xilinx: describe whether dynamic
 reconfig is enabled
Message-ID: <20240722-removal-grandma-92cfe99b8a88@spud>
References: <20240720120048.36758-1-hpausten@protonmail.com>
 <20240720120048.36758-7-hpausten@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dcnYdkiBJnjYH+Dp"
Content-Disposition: inline
In-Reply-To: <20240720120048.36758-7-hpausten@protonmail.com>


--dcnYdkiBJnjYH+Dp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 20, 2024 at 12:01:58PM +0000, Harry Austen wrote:
> Xilinx clocking wizard IP core's dynamic reconfiguration support is
> optionally enabled at build time. Add a devicetree boolean property to
> describe whether the hardware supports this feature or not.
>=20
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---
>  .../devicetree/bindings/clock/xlnx,clocking-wizard.yaml    | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard=
=2Eyaml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> index 4609bb56b06b5..890aeebf6f375 100644
> --- a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> +++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> @@ -40,6 +40,12 @@ properties:
>        - const: s_axi_aclk
> =20
> =20
> +  xlnx,dynamic-reconfig:
> +    type: boolean

The type here should be "flag" not boolean, boolean can be set to
"false" and what you're likely doing is just checking for the property
being present. "flag" doesn't allow false.

> +    description:
> +      Indicate whether the core has been configured with support for dyn=
amic
> +      runtime reconfguration of the clocking primitive MMCM/PLL.
> +
>    xlnx,speed-grade:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [1, 2, 3]
> @@ -88,6 +94,7 @@ examples:
>          compatible =3D "xlnx,clocking-wizard-v6.0";
>          reg =3D <0xb0000000 0x10000>;
>          #clock-cells =3D <1>;
> +        xlnx,dynamic-reconfig;
>          xlnx,speed-grade =3D <1>;
>          xlnx,nr-outputs =3D <6>;
>          clock-names =3D "clk_in1", "s_axi_aclk";
> --=20
> 2.45.2
>=20
>=20

--dcnYdkiBJnjYH+Dp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp6TVQAKCRB4tDGHoIJi
0hdmAQCqOMXx2CK3Q8yzIIBHMuERHAWGGfcI5gzwiytnYyIP9wEA7lTXK19quiSI
Lk3aVqOddEgJEmbgqX2t6/H6W4duVw4=
=2Kf6
-----END PGP SIGNATURE-----

--dcnYdkiBJnjYH+Dp--

