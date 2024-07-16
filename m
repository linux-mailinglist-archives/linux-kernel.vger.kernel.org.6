Return-Path: <linux-kernel+bounces-254071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A61B1932E35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9CFB24781
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6544719E7D8;
	Tue, 16 Jul 2024 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckFqTloY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EFD47A5D;
	Tue, 16 Jul 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146512; cv=none; b=YKjAHjql38DDXWzFzctSuqyX4nzKG9mgt9HAodF1fm2S8JvGkLQxIbPfZfz6SX9jVqUNweP2bgE12ElTWoYDgu/b+BDy2QgNCNs/b4VJOh0jjnYu5DXU9arBHKKxp86xM8qcOQj/MDOEjgkIBY7PzcB4kKvUy/3Rh0LbeN5aCI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146512; c=relaxed/simple;
	bh=xVoIA/hZZjTnIxgzUKxyW47Uq6kbP2T9RxSH+7zEYBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlO0pnUPKoW6T/BIdkwYbvLWCciRyBhXuqDcH0PNmxSBkuc5DP7Tg1+9DCs9atn7ubg1E2AQimrh6WLdy+ZMrKOOT5Tfcx7Cw7GrZDOQN3PTA4aUh3iIm+GqQ57PQaPahCWrMKcyhWkYgeMMkA5YF55gKGXCUn0VT7IRB35aLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckFqTloY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34458C4AF0B;
	Tue, 16 Jul 2024 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721146512;
	bh=xVoIA/hZZjTnIxgzUKxyW47Uq6kbP2T9RxSH+7zEYBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckFqTloYfGO1uNi6YwoI7DX5QDWICLBrJxwQvmADy57TS35mJLdghheKG9ePvkEUJ
	 d5x1TEykHudu9Y7zDowaJ8dWLcfVwbpnWwhv5PlKIYi6ySY83Pr53p1lnzV/xhi9Ip
	 ubnkrUFQ52M5P87HxS04vOXS6utjCV/QefOrL0YErsNP64PfT7QEkT+CkEp0Y8BpXQ
	 vNY+aVsSJTGktS0EFweKb4F2yU/ecQb2nsgjNcSEX++4ddLTdiNK4LFysvXj0oN/r3
	 Kh+CwiAdez88VcdmFNLib8xow+6z2bjVHwIVFf5YLdyFC7TGLVn4PW9LRV3fZP5Ubx
	 yxI5KLbAyje6g==
Date: Tue, 16 Jul 2024 17:15:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clocks: add binding for
 voltage-controlled-oscillators
Message-ID: <20240716-deceiving-saucy-851fb2303c1f@spud>
References: <20240715110251.261844-1-heiko@sntech.de>
 <20240715110251.261844-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G8ATB5gbIqKT+Pmv"
Content-Disposition: inline
In-Reply-To: <20240715110251.261844-2-heiko@sntech.de>


--G8ATB5gbIqKT+Pmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 01:02:49PM +0200, Heiko Stuebner wrote:
> In contrast to fixed clocks that are described as ungateable, boards
> sometimes use additional oscillators for things like PCIe reference
> clocks, that need actual supplies to get enabled and enable-gpios to be
> toggled for them to work.
>=20
> This adds a binding for such oscillators that are not configurable
> themself, but need to handle supplies for them to work.
>=20
> In schematics they often can be seen as
>=20
>          ----------------
> Enable - | 100MHz,3.3V, | - VDD
>          |    3225      |
>    GND - |              | - OUT
>          ----------------
>=20
> or similar. The enable pin might be separate but can also just be tied
> to the vdd supply, hence it is optional in the binding.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../bindings/clock/voltage-oscillator.yaml    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/voltage-oscil=
lator.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/voltage-oscillator.y=
aml b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> new file mode 100644
> index 0000000000000..8bff6b0fd582e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/voltage-oscillator.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/voltage-oscillator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Voltage controlled oscillator

Voltage controlled oscillator? Really? That sounds far too similar to a
VCO to me, and the input voltage here (according to the description at
least) does not affect the frequency of oscillation.

Why the dedicated binding, rather than adding a supply and enable-gpio
to the existing "fixed-clock" binding? I suspect that a large portion of
"fixed-clock"s actually require a supply that is (effectively)
always-on.

Cheers,
Conor.

> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    const: voltage-oscillator
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-frequency: true
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description:
> +      Contains a single GPIO specifier for the GPIO that enables and dis=
ables
> +      the oscillator.
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: handle of the regulator that provides the supply voltage
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clock-frequency
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    voltage-oscillator {
> +      compatible =3D "voltage-oscillator";
> +      #clock-cells =3D <0>;
> +      clock-frequency =3D <1000000000>;
> +      vdd-supply =3D <&reg_vdd>;
> +    };
> +...
> --=20
> 2.39.2
>=20

--G8ATB5gbIqKT+Pmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpacjAAKCRB4tDGHoIJi
0qETAQDGaH3SBfzHPXQYUAVTiBQ/XIU3y1OlFEVoD2vuaqVeKAD/e904hzaE9/Z3
xKoAg5ft4w3HfNOSbYMic53og10LmAI=
=h/cC
-----END PGP SIGNATURE-----

--G8ATB5gbIqKT+Pmv--

