Return-Path: <linux-kernel+bounces-281016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB3094D1EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DCD281605
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2E197A8E;
	Fri,  9 Aug 2024 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icgMDxa4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300B196DB1;
	Fri,  9 Aug 2024 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723212851; cv=none; b=YS564HZPagumzyvNs0lTwFSw47R5VbK+88Ce5YQVqTtzoBI7PN2wXFJNQyazDwVW8X9/qBVl4IHiEVki+65pdHU9htPTlFec8WxB4FDO6+66i6pnwFrpWmrrss2e/rIlbXjgXjeCeU+pjBh2sEj94oxRjX92fTDTHgTadEz8lVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723212851; c=relaxed/simple;
	bh=C6TqZ9tF0k6ewQwXFwg7qoPMCz+on8jFniKwp+OvO3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRULipZZwke2fU8FJ8K4XNiJRTEELR71xufQUSaLMamkiNSxoxDO/v+X+VsV6v2qsWuc6fUQGdR4ma1+wZJAz/CcsDIOULynIOQmqzxNxQSGj4tMpTzfeGHX6zrPfqwbpUJrv8gwuHixjJIxYF5DdI7FYCPGlX0jzMqfrXOjHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icgMDxa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D480CC32782;
	Fri,  9 Aug 2024 14:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723212850;
	bh=C6TqZ9tF0k6ewQwXFwg7qoPMCz+on8jFniKwp+OvO3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icgMDxa4E5o/YvRl6rwceNn0Xp16Fx/TSurbMUFWs2d0wWfdBACVV1OkjcP4Qf6qR
	 J2ntq8KQJxmphI1sp5Y+wP4ZEbdDo0jHX3HgO6jdqr4NsB59xPzQNHlwgL0pK47A9v
	 td/R6EV/E3TBQAmnQJo5dVNbai6FnZDJa6eaycQxdW58+BQCRSiV0Di/GMaiz9kCgi
	 ScfYn2CXVlUkDZAgJ0OA54e0R86ghZu2rb2ZOcu6DGQUyIEf7Ayny/EyA3F0Nu9anF
	 3BVizPpQhNX6WfmUEw1gih7S//calBQ/0VaEj/dWhA3w1vCBMNgxUBNeEoddBvGaqI
	 ml5BY5PiYSVAA==
Date: Fri, 9 Aug 2024 15:14:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 2/3] dt-bindings: clock: Add rk3576 clock definitions
 and documentation
Message-ID: <20240809-smelting-truffle-752b2f7c9e47@spud>
References: <20240809125553.3889-1-detlev.casanova@collabora.com>
 <20240809125553.3889-3-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FJQWZgsBE5dRMV9V"
Content-Disposition: inline
In-Reply-To: <20240809125553.3889-3-detlev.casanova@collabora.com>


--FJQWZgsBE5dRMV9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 08:54:53AM -0400, Detlev Casanova wrote:
> Add clock ID defines for rk3576.
>=20
> Compared to the downstream bindings written by Elaine, this uses
> continous gapless clock IDs starting at 1. Thus all numbers are
> different between downstream and upstream, but names are kept
> exactly the same.
>=20
> Also add documentation for the rk3576 CRU core.
>=20
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  .../bindings/clock/rockchip,rk3576-cru.yaml   |  84 +++
>  .../dt-bindings/clock/rockchip,rk3576-cru.h   | 592 ++++++++++++++++++
>  2 files changed, 676 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk35=
76-cru.yaml
>  create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.=
yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> new file mode 100644
> index 0000000000000..d6fd17320e56a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rk3576-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip rk3576 Family Clock and Reset Control Module
> +
> +maintainers:
> +  - Elaine Zhang <zhangqing@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>

Why not you, the author?

> +
> +description: |

The | here is not needed, you've got no formatting worth preserving.

> +  The RK3576 clock controller generates the clock and also implements a =
reset
> +  controller for SoC peripherals. For example it provides SCLK_UART2 and
> +  PCLK_UART2, as well as SRST_P_UART2 and SRST_S_UART2 for the second UA=
RT
> +  module.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3576-cru

Why an enum rather than const?

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: xin24m
> +      - const: xin32k
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: >
> +      phandle to the syscon managing the "general register files". It is=
 used
> +      for GRF muxes, if missing any muxes present in the GRF will not be
> +      available.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rockchip,rk3576-cru.h>
> +    clock-controller@27200000 {
> +      compatible =3D "rockchip,rk3576-cru";
> +      reg =3D <0xfd7c0000 0x5c000>;
> +      #clock-cells =3D <1>;
> +      #reset-cells =3D <1>;
> +      assigned-clocks =3D
> +        <&cru CLK_AUDIO_FRAC_1_SRC>,
> +        <&cru PLL_GPLL>, <&cru PLL_CPLL>,
> +        <&cru PLL_AUPLL>, <&cru CLK_UART_FRAC_0>,
> +        <&cru CLK_UART_FRAC_1>, <&cru CLK_UART_FRAC_2>,
> +        <&cru CLK_AUDIO_FRAC_0>, <&cru CLK_AUDIO_FRAC_1>,
> +        <&cru CLK_CPLL_DIV2>, <&cru CLK_CPLL_DIV4>,
> +        <&cru CLK_CPLL_DIV10>, <&cru FCLK_DDR_CM0_CORE>,
> +        <&cru ACLK_PHP_ROOT>;
> +      assigned-clock-parents =3D <&cru PLL_AUPLL>;
> +      assigned-clock-rates =3D
> +        <0>,
> +        <1188000000>, <1000000000>,
> +        <786432000>, <18432000>,
> +        <96000000>, <128000000>,
> +        <45158400>, <49152000>,
> +        <500000000>, <250000000>,
> +        <100000000>, <500000000>,
> +        <250000000>;

I don't think these assigned-clock* properties add anything to the
example.

Cheers,
Conor.

--FJQWZgsBE5dRMV9V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrYkLQAKCRB4tDGHoIJi
0r1CAP48lLrCcLu8NRhXLkmdmwsezY1hl2onHiYetdPNZLaZMAEA8BHQEPERi74t
JL/0koiay03nq2BGoMIh6uWzCNQuaAk=
=yjMq
-----END PGP SIGNATURE-----

--FJQWZgsBE5dRMV9V--

