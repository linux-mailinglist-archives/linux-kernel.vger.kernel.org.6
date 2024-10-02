Return-Path: <linux-kernel+bounces-347185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2362098CF36
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FD6285DC4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A74196D80;
	Wed,  2 Oct 2024 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E83JInBM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557180BEC;
	Wed,  2 Oct 2024 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858966; cv=none; b=CjsHs8bZNGnVpofOSXB9Fj4cL+nvvRhs3AVARnUPJOA5Zkdl+rTZseHtV3QVoGUCMBnW3OL/JajkEyA//yhFYQT4nADlGB5EC6DfxVS//DdOQAASZADAUh+Vi652ytRHQuLuM3MF5rJHRjlXhmgxGPN6zckpUYZONmbMdYqkCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858966; c=relaxed/simple;
	bh=sWtS55ESt/gXMlKhyy2AY5SPV9Ghvj60fO52Wmird08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9onqpZt/rN7LnN/pwSzorMD+pVyv9PlWiEPkWMybGriTh/knMnox+aBJvp6j03AxZs6er5wYtpySD/w2bx1ORA0Aivi37ooTq0J2sh48+CT/e4w4TJJEX0aIRhK6V3tX8bp0776ktxEkeG6RHwTeXG3E4yQhx41fihux7Aceis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E83JInBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB5BC4CEC5;
	Wed,  2 Oct 2024 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727858966;
	bh=sWtS55ESt/gXMlKhyy2AY5SPV9Ghvj60fO52Wmird08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E83JInBMFeg02wHuNmKFMc5RpgM9dMYCLZwB7VhZuY8yTGiUKWw5mOTo/NVa5TVpJ
	 SrgZD07YWUHcL/uHISnML8JGWQfb3F+p4Ru9CKsVqQsI4kouBpDqpqxVHv8so0OOPb
	 2qftyG/7MNdcXtLSNFCv2e60ZQlA2Sa8xqBfVm1irRMrVNAlupr47glDELHhgyJbva
	 FZsheZplGrH865151krbsIwGBO3iCC9xOIjI/jjoP21x99GYx2JFWO1sheCUZTWLlm
	 YpD65fe7RETBMASqtAb2Wmi2YNzq7y5o7iwsYiavMIk+03/IHJmYYY4aKEvd+j6EYX
	 Bl29XUR6SocYA==
Date: Wed, 2 Oct 2024 09:49:21 +0100
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
Message-ID: <20241002-sash-gigantic-f79da2043875@spud>
References: <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-5-ziyao@disroot.org>
 <20241001-name-stooge-7a939f71a08e@spud>
 <Zvxm71YvGbF1s_2w@pineapple>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CYfpvVWBFMQNLcdo"
Content-Disposition: inline
In-Reply-To: <Zvxm71YvGbF1s_2w@pineapple>


--CYfpvVWBFMQNLcdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 09:18:03PM +0000, Yao Zi wrote:
> On Tue, Oct 01, 2024 at 05:29:15PM +0100, Conor Dooley wrote:
> > On Tue, Oct 01, 2024 at 04:23:57AM +0000, Yao Zi wrote:
> > > Document Rockchip RK3528 clock and reset unit.
> > >=20
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > ---
> > >  .../bindings/clock/rockchip,rk3528-cru.yaml   | 63 +++++++++++++++++=
++
> > >  1 file changed, 63 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,=
rk3528-cru.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3528-=
cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
> > > new file mode 100644
> > > index 000000000000..ae51dfde5bb9
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3528-cru.yaml
> > > @@ -0,0 +1,63 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/rockchip,rk3528-cru.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Rockchip RK3528 Clock and Reset Controller
> > > +
> > > +maintainers:
> > > +  - Yao Zi <ziyao@disroot.org>
> > > +
> > > +description: |
> > > +  The RK3528 clock controller generates the clock and also implement=
s a reset
> > > +  controller for SoC peripherals. For example, it provides SCLK_UART=
0 and
> > > +  PCLK_UART0 as well as SRST_P_UART0 and SRST_S_UART0 for the first =
UART
> > > +  module.
> > > +  Each clock is assigned an identifier, consumer nodes can use it to=
 specify
> > > +  the clock. All available clock and reset IDs are defined in dt-bin=
ding
> > > +  headers.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - rockchip,rk3528-cru
> >=20
> > nit: This can probably be a const, rather than an enum.
> >=20
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  assigned-clocks: true
> > > +
> > > +  assigned-clock-rates: true
> > > +
> > > +  clocks:
> > > +    minItems: 2
> > > +    maxItems: 2
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: xin24m
> > > +      - const: phy_50m_out
> >=20
> > Why is this input clock named "out"? clocks should be named after how
> > they're used in the IP in question, not the name of the source of that
> > clock in the SoC.
> > Without descriptions provided in the clocks property, it is hard to
> > understand what this second clock is for.
>=20
> Thanks for explaination, it should something like "clk_gmac0".

So it is actually an input clock to the cru? I'd like to see an items
list in the clocks property please, describing what these clocks are.
Also, "clk" is redundant, since these are all clocks, so drop that from
the name.

>=20
> > > +
> > > +  "#clock-cells":
> > > +    const: 1
> > > +
> > > +  "#reset-cells":
> > > +    const: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> >=20
> > Why would the input clocks be optional?
>=20
> This follows other Rockchip SoCs, which often omit input clocks in
> devicetree and depend on clock names registered in common clock
> framework to work.
>=20
> For completeness, they really shouldn't be optional.

Then please make it required. If the input clocks are required to make
the clock controller function, they should be marked as required.

>=20
> > > +  - "#clock-cells"
> > > +  - "#reset-cells"
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    cru: clock-controller@ff4a0000 {
> >=20
> > nit: the cru label is not used and can be dropped.
>=20
> All comments will be adapted in next revision. Thanks.

Cool.

Thanks,
Conor.

--CYfpvVWBFMQNLcdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZv0JEQAKCRB4tDGHoIJi
0q77AP4svyfgFeIg5M8q6tYMIlV1Get9O8PkiwvRHS3d5WgiaAEAi7sdWhJsOmlg
vIHc87DT12ekfJaqgebKL90ejlTyAgQ=
=E7tQ
-----END PGP SIGNATURE-----

--CYfpvVWBFMQNLcdo--

