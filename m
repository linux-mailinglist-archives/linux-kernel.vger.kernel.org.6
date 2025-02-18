Return-Path: <linux-kernel+bounces-519909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E063FA3A370
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751651887DFA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B3C26FA4B;
	Tue, 18 Feb 2025 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMdQ1jgl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336EE23FC68;
	Tue, 18 Feb 2025 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898060; cv=none; b=T77dJGywbCF3wgpsrlnq0KRgweS5R5dALZS4O2kW0AnkqJewUCeOxfGPi1i3X5doGU3dpn+9Q1FDxqzhFUqcwSYeR5G/O7OL39s6Uu/tRZMlgPrNWr5RhSSyiXVIFEzGt9awO0CTPflqco/T4qPpYi1KczH7berUc3FXSznqVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898060; c=relaxed/simple;
	bh=wxVWlXKd4zOjpRPoDQOUTBz16/v4noEajLoaLCp3H3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrKMGZD4iryJ/aX5Ils/0aX88Rj2NpBkrdw360F2V6lylo2GaO+n89T0ZLwWh3lVm3jGhU74AjClzsr6jmGIrzO2BfB+8dzv7NPmvmew76car9zrnCvtExYnPHP2unQ+Nxfm5aZoSLVKyIpGw8UE4JnR+ccf/Fd1rYg4iw5TojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMdQ1jgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0877C4CEE4;
	Tue, 18 Feb 2025 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739898059;
	bh=wxVWlXKd4zOjpRPoDQOUTBz16/v4noEajLoaLCp3H3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMdQ1jglKvPsgXNlQIywqNhdxIcZB6r1xwgdtlGlNXvWeYmhE8GGQJ8pW5C3oeOwD
	 M0JqZl4PU72vbjh8mr4pqQswaGDikgrfMTCBuFHoGEuohVQYbvcNxDqjkO34YL0J4p
	 B3O5lWK2JuyxGt1yUcSjEw/CrVBrAvcU7Jl+xu3INQ+OHQ1e/8zmIf1h71PGFIrTjn
	 EJv/TCZcDhic9mqBdCPA6lQ7m81f3flZ0nJ2c01guEIhk0ITbX4C7RC0v6b5Pct3W4
	 5Dk2oF4EvI9YgDzK6VbVjeuYICPjWCiCv0cwQNvTrF76PAVfhVsIsyHlckB3c6xVnf
	 pWRcjjEFDtcOg==
Date: Tue, 18 Feb 2025 17:00:54 +0000
From: Conor Dooley <conor@kernel.org>
To: Xukai Wang <kingxukai@zohomail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Troy Mitchell <TroyMitchell988@gmail.com>
Subject: Re: [PATCH v4 3/3] riscv: dts: canaan: Add clock initial support for
 K230
Message-ID: <20250218-status-friend-51fb039ab97e@spud>
References: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>
 <20250217-b4-k230-clk-v4-3-5a95a3458691@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wyBkyPjl9mwD8eXq"
Content-Disposition: inline
In-Reply-To: <20250217-b4-k230-clk-v4-3-5a95a3458691@zohomail.com>


--wyBkyPjl9mwD8eXq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 10:45:18PM +0800, Xukai Wang wrote:
> This patch provides basic support for the K230 clock, which does not
> cover all clocks.
>=20
> The clock tree of the K230 SoC consists of OSC24M,
> PLLs and sysclk.
>=20
> Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
> ---
>  arch/riscv/boot/dts/canaan/k230.dtsi | 32 ++++++++++++++++++++++++++++++=
++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/c=
anaan/k230.dtsi
> index 95c1a3d8fb1192e30113d96d3e96329545bc6ae7..e50ba03c2c21597e5f7d04a65=
2db08f84101cbfb 100644
> --- a/arch/riscv/boot/dts/canaan/k230.dtsi
> +++ b/arch/riscv/boot/dts/canaan/k230.dtsi
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
>   */
> =20
> +#include <dt-bindings/clock/canaan,k230-clk.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> =20
>  /dts-v1/;
> @@ -65,6 +66,13 @@ apb_clk: apb-clk-clock {
>  		#clock-cells =3D <0>;
>  	};
> =20
> +	osc24m: clock-24m {
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <24000000>;
> +		clock-output-names =3D "osc24m";
> +		#clock-cells =3D <0>;
> +	};
> +
>  	soc {
>  		compatible =3D "simple-bus";
>  		interrupt-parent =3D <&plic>;
> @@ -138,5 +146,29 @@ uart4: serial@91404000 {
>  			reg-shift =3D <2>;
>  			status =3D "disabled";
>  		};
> +
> +		sysclk: clock-controller@91102000 {
> +			compatible =3D "canaan,k230-clk";
> +			reg =3D <0x0 0x91102000 0x0 0x1000>,
> +			      <0x0 0x91100000 0x0 0x1000>;
> +			clocks =3D <&osc24m>;
> +			clock-output-names =3D "CPU0_ACLK", "CPU0_PLIC", "CPU0_NOC_DDRCP4",
> +					     "CPU0_PCLK", "PMU_PCLK", "HS_HCLK_HIGH_SRC",
> +					     "HS_HCLK_HIGH_GATE", "HS_HCLK_SRC",
> +					     "HS_SD0_HS_AHB_GAT", "HS_SD1_HS_AHB_GAT",
> +					     "HS_SSI1_HS_AHB_GA", "HS_SSI2_HS_AHB_GA",
> +					     "HS_USB0_HS_AHB_GA", "HS_USB1_HS_AHB_GA",
> +					     "HS_SSI0_AXI", "HS_SSI1", "HS_SSI2",
> +					     "HS_QSPI_AXI_SRC", "HS_SSI1_ACLK_GATE",
> +					     "HS_SSI2_ACLK_GATE", "HS_SD_CARD_SRC",
> +					     "HS_SD0_CARD_TX", "HS_SD1_CARD_TX",
> +					     "HS_SD_AXI_SRC", "HS_SD0_AXI_GATE",
> +					     "HS_SD1_AXI_GATE", "HS_SD0_BASE_GATE",
> +					     "HS_SD1_BASE_GATE", "HS_OSPI_SRC",
> +					     "HS_USB_REF_51M", "HS_SD_TIMER_SRC",
> +					     "HS_SD0_TIMER_GATE", "HS_SD1_TIMER_GATE",
> +					     "HS_USB0_REFERENCE", "HS_USB1_REFERENCE";
> +			#clock-cells =3D <1>;
> +		};

Apologies for not commenting on it until now, but this patch seems like
there's some hunks missing from it. I'd expect you to remove the dummy
"apb-clk-clock" from the dts and replace it with a real one sourced from
the newly added clock controller.

--wyBkyPjl9mwD8eXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7S8xgAKCRB4tDGHoIJi
0hatAQCRO0T+IiRpcIn+PLRCtbTAxqFwW6t9fOFOpsJFJCLLowEAl60fTsjXKtv6
qz34I22c5i04TjOJS443k9ADwTGz2wA=
=6K8s
-----END PGP SIGNATURE-----

--wyBkyPjl9mwD8eXq--

