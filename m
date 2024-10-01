Return-Path: <linux-kernel+bounces-346345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C2298C365
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2C228105D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992DF1CB335;
	Tue,  1 Oct 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf6LXErk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2E1C4624;
	Tue,  1 Oct 2024 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800161; cv=none; b=Rzh9IaelcxI7QJwUJ9qr6ru5qJ2/AUelqFrV/+vo6op+35g3R9MioyjrwdkG30EMXITVmoqxsEVQ+5cSwDOd7HessX+2+217tQoPgX9nlbOPdKrue2fmCTeJ4kkU1xvq24OINYJF9jzCDzOkXP4wP1pov5uJAEi8anP0CXaE3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800161; c=relaxed/simple;
	bh=5tYXHsjGIVa+k+2eFlpHz83kyJieT6QL7Z3nXg+GnDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6wo0rLwRWhtRq4l9NBCXxXNNIJsboIOJOH5ERVzj4Os0WR3lbFMAzcB+0hQR3iTzTM5IhJQ21dW/rs2VvoQKEIP2RVkqKkrNQat/AQkOrqvJT7NiQ9yNqLBwvhzzegSSMOOIgf4zIVXFoHyUeLhkKRopraA3BsJvhgivYfw56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf6LXErk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E4DC4CED4;
	Tue,  1 Oct 2024 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727800160;
	bh=5tYXHsjGIVa+k+2eFlpHz83kyJieT6QL7Z3nXg+GnDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wf6LXErkQQu4lvZxDPV3INszO0R/kQfjeAKbwwYrC7cGpPERW8bu7AgArW/9FQauq
	 lv13dtEsVXGCMzu+nDRA0JT6i680cQD+Arn31g/LVM9HWpz28a+Vyc2pPpDg0D6c+W
	 f9XZBc9/fWCWb6dsfiWaAFDtbRgL73q5U2978Qy5Jh/Sj5oNnDoN+qHo91+m0eVfpy
	 v+opNIqYunW6C5OpsJgahdd3nJs4/dF/vNZIvMCyTZf0O3Zi+0+eoSPeKaMI3feOIL
	 AyIfTM+NgWTuidJBb7DImKqU5AszSabZIvRohgXqp+rAqEs+TIUFdyVHzSPlv5uIkK
	 HaQsQgn/qXUkw==
Date: Tue, 1 Oct 2024 17:29:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: clock: Add rockchip,rk3528-cru
Message-ID: <20241001-name-stooge-7a939f71a08e@spud>
References: <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-5-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LpLEFlOKzmxoZNpJ"
Content-Disposition: inline
In-Reply-To: <20241001042401.31903-5-ziyao@disroot.org>


--LpLEFlOKzmxoZNpJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 04:23:57AM +0000, Yao Zi wrote:
> Document Rockchip RK3528 clock and reset unit.
>=20
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  .../bindings/clock/rockchip,rk3528-cru.yaml   | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk35=
28-cru.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.=
yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
> new file mode 100644
> index 000000000000..ae51dfde5bb9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rk3528-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RK3528 Clock and Reset Controller
> +
> +maintainers:
> +  - Yao Zi <ziyao@disroot.org>
> +
> +description: |
> +  The RK3528 clock controller generates the clock and also implements a =
reset
> +  controller for SoC peripherals. For example, it provides SCLK_UART0 and
> +  PCLK_UART0 as well as SRST_P_UART0 and SRST_S_UART0 for the first UART
> +  module.
> +  Each clock is assigned an identifier, consumer nodes can use it to spe=
cify
> +  the clock. All available clock and reset IDs are defined in dt-binding
> +  headers.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3528-cru

nit: This can probably be a const, rather than an enum.

> +
> +  reg:
> +    maxItems: 1
> +
> +  assigned-clocks: true
> +
> +  assigned-clock-rates: true
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: xin24m
> +      - const: phy_50m_out

Why is this input clock named "out"? clocks should be named after how
they're used in the IP in question, not the name of the source of that
clock in the SoC.
Without descriptions provided in the clocks property, it is hard to
understand what this second clock is for.

> +
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg

Why would the input clocks be optional?

> +  - "#clock-cells"
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cru: clock-controller@ff4a0000 {

nit: the cru label is not used and can be dropped.

Cheers,
Conor.

> +        compatible =3D "rockchip,rk3528-cru";
> +        reg =3D <0xff4a0000 0x30000>;
> +        #clock-cells =3D <1>;
> +        #reset-cells =3D <1>;
> +    };
> --=20
> 2.46.0
>=20

--LpLEFlOKzmxoZNpJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvwjWwAKCRB4tDGHoIJi
0twHAQDGDkJmBUzJ7TXWGcm3XpVcqeWB6JH7/q2SJ0qwswk1vgD/U/mkhch0PiJd
rYjWApKo7QL6xeuBxqg5jLddq1kyRQY=
=zEFx
-----END PGP SIGNATURE-----

--LpLEFlOKzmxoZNpJ--

