Return-Path: <linux-kernel+bounces-225685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C029133BB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 14:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4101B283269
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 12:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86974156227;
	Sat, 22 Jun 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibFVfroq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618E155741;
	Sat, 22 Jun 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058096; cv=none; b=RcObrXd3LuVeenPr5TIAE5ByXXbrksSMu7OL5OnZKYI5QHTLWD+PEH/yYLSAGf8kerHY0G0u6Quw/lJDiOGuZc3odInlDpMhtuOK9+GWen6eNCxQrY92veyoWS7gMZx50A6kSUbibBlMzboIuV7sAI4tzWnRmF3ZkslPbVJHkq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058096; c=relaxed/simple;
	bh=P5rl5XL//kPYoCDJGhwLXcIJSGKKj9bYJFvBdl/QjCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgBQGEUs3DJzSaq6dQl9a65MEp2J4CSE9Q6aw15BPxKj8RMTFcLF5zzQWOVI9mpnXXT/Yh/6wVmDIWYMouXL+RAlFojDleN/TttpXzThU4fbYG4azu8xq3nU7WFkpZnF077FyJwD9G9l7EuV+svX/1uQ6iFYO2hp5qM3me40zis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibFVfroq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1641AC4AF0E;
	Sat, 22 Jun 2024 12:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719058096;
	bh=P5rl5XL//kPYoCDJGhwLXcIJSGKKj9bYJFvBdl/QjCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ibFVfroqoB8D6H0Lo5nDAIaTtI3NC6LugLPmnQ8l1l4Ftf8zT8d91wsY98A+CAUpy
	 76Scgo82vEiM+HPdwUiQcM8avNN8NMUXpaEPwbCujVB18CNQ/XKHO/8CjL+/bMNYWx
	 S6kttX4ge3KL0O+dUAd9v14i3tqLWQHAsaC8DzgZsr+VfP6ZaOk9fcbJr4M5BK6VrB
	 52xcCWMsJyRe9cAJwIu1PiH1kEr5VDHGx/yKeqb4iOgHMk7VBHlE+Yg/MS0L20GcYJ
	 mbne6Xno8KbHvaF7qjrclHluFnfUVEJT8mOi+v1tk7LxkEANp1wHeBpdF0nW/15LwD
	 HZFhBT4O9TmFg==
Date: Sat, 22 Jun 2024 13:08:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 1/1] riscv: dts: starfive: add PCIe dts configuration
 for JH7110
Message-ID: <20240622-festivity-salon-bbad348a12c8@spud>
References: <20240621082231.92896-1-minda.chen@starfivetech.com>
 <20240621082231.92896-2-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9MzUggWp64cOatqb"
Content-Disposition: inline
In-Reply-To: <20240621082231.92896-2-minda.chen@starfivetech.com>


--9MzUggWp64cOatqb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 04:22:31PM +0800, Minda Chen wrote:
> Add PCIe dts configuraion for JH7110 SoC platform.

I think the commit message should mention that the star64 doesn't have a
pci port exposed. If nothing else crops up, I'll edit it myself if
that's okay?

Thanks,
Conor.

>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../boot/dts/starfive/jh7110-common.dtsi      | 62 +++++++++++++
>  .../boot/dts/starfive/jh7110-milkv-mars.dts   |  7 ++
>  .../jh7110-starfive-visionfive-2.dtsi         |  8 ++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 86 +++++++++++++++++++
>  4 files changed, 163 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv=
/boot/dts/starfive/jh7110-common.dtsi
> index 8ff6ea64f048..f91abc660ae8 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -294,6 +294,20 @@
>  	status =3D "okay";
>  };
> =20
> +&pcie0 {
> +	perst-gpios =3D <&sysgpio 26 GPIO_ACTIVE_LOW>;
> +	phys =3D <&pciephy0>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie0_pins>;
> +};
> +
> +&pcie1 {
> +	perst-gpios =3D <&sysgpio 28 GPIO_ACTIVE_LOW>;
> +	phys =3D <&pciephy1>;
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pcie1_pins>;
> +};
> +
>  &pwmdac {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pwmdac_pins>;
> @@ -476,6 +490,54 @@
>  		};
>  	};
> =20
> +	pcie0_pins: pcie0-0 {
> +		clkreq-pins {
> +			pinmux =3D <GPIOMUX(27, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_NONE)>;
> +			bias-pull-down;
> +			drive-strength =3D <2>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate =3D <0>;
> +		};
> +
> +		wake-pins {
> +			pinmux =3D <GPIOMUX(32, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_NONE)>;
> +			bias-pull-up;
> +			drive-strength =3D <2>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate =3D <0>;
> +		};
> +	};
> +
> +	pcie1_pins: pcie1-0 {
> +		clkreq-pins {
> +			pinmux =3D <GPIOMUX(29, GPOUT_LOW,
> +					      GPOEN_DISABLE,
> +					      GPI_NONE)>;
> +			bias-pull-down;
> +			drive-strength =3D <2>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate =3D <0>;
> +		};
> +
> +		wake-pins {
> +			pinmux =3D <GPIOMUX(21, GPOUT_LOW,
> +				      GPOEN_DISABLE,
> +					      GPI_NONE)>;
> +			bias-pull-up;
> +			drive-strength =3D <2>;
> +			input-enable;
> +			input-schmitt-disable;
> +			slew-rate =3D <0>;
> +		};
> +	};
> +
>  	pwmdac_pins: pwmdac-0 {
>  		pwmdac-pins {
>  			pinmux =3D <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/ri=
scv/boot/dts/starfive/jh7110-milkv-mars.dts
> index fa0eac78e0ba..5cb9e99e1dac 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> @@ -17,6 +17,13 @@
>  	assigned-clock-parents =3D <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
>  };
> =20
> +&pcie0 {
> +	status =3D "okay";
> +};
> +
> +&pcie1 {
> +	status =3D "okay";
> +};
> =20
>  &phy0 {
>  	motorcomm,tx-clk-adj-enabled;
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 9d70f21c86fc..18f38fc790a4 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -32,3 +32,11 @@
>  &mmc0 {
>  	non-removable;
>  };
> +
> +&pcie0 {
> +	status =3D "okay";
> +};
> +
> +&pcie1 {
> +	status =3D "okay";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/d=
ts/starfive/jh7110.dtsi
> index 18047195c600..5ac70759e0ab 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -1214,5 +1214,91 @@
>  			#reset-cells =3D <1>;
>  			power-domains =3D <&pwrc JH7110_PD_VOUT>;
>  		};
> +
> +		pcie0: pcie@940000000 {
> +			compatible =3D "starfive,jh7110-pcie";
> +			reg =3D <0x9 0x40000000 0x0 0x1000000>,
> +			      <0x0 0x2b000000 0x0 0x100000>;
> +			reg-names =3D "cfg", "apb";
> +			linux,pci-domain =3D <0>;
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			#interrupt-cells =3D <1>;
> +			ranges =3D <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000=
>,
> +				 <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
> +			interrupts =3D <56>;
> +			interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> +			interrupt-map =3D <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
> +					<0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
> +					<0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
> +					<0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
> +			msi-controller;
> +			device_type =3D "pci";
> +			starfive,stg-syscon =3D <&stg_syscon>;
> +			bus-range =3D <0x0 0xff>;
> +			clocks =3D <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
> +				 <&stgcrg JH7110_STGCLK_PCIE0_TL>,
> +				 <&stgcrg JH7110_STGCLK_PCIE0_AXI_MST0>,
> +				 <&stgcrg JH7110_STGCLK_PCIE0_APB>;
> +			clock-names =3D "noc", "tl", "axi_mst0", "apb";
> +			resets =3D <&stgcrg JH7110_STGRST_PCIE0_AXI_MST0>,
> +				 <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV0>,
> +				 <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV>,
> +				 <&stgcrg JH7110_STGRST_PCIE0_BRG>,
> +				 <&stgcrg JH7110_STGRST_PCIE0_CORE>,
> +				 <&stgcrg JH7110_STGRST_PCIE0_APB>;
> +			reset-names =3D "mst0", "slv0", "slv", "brg",
> +				      "core", "apb";
> +			status =3D "disabled";
> +
> +			pcie_intc0: interrupt-controller {
> +				#address-cells =3D <0>;
> +				#interrupt-cells =3D <1>;
> +				interrupt-controller;
> +			};
> +		};
> +
> +		pcie1: pcie@9c0000000 {
> +			compatible =3D "starfive,jh7110-pcie";
> +			reg =3D <0x9 0xc0000000 0x0 0x1000000>,
> +			      <0x0 0x2c000000 0x0 0x100000>;
> +			reg-names =3D "cfg", "apb";
> +			linux,pci-domain =3D <1>;
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			#interrupt-cells =3D <1>;
> +			ranges =3D <0x82000000  0x0 0x38000000  0x0 0x38000000 0x0 0x08000000=
>,
> +				 <0xc3000000  0x9 0x80000000  0x9 0x80000000 0x0 0x40000000>;
> +			interrupts =3D <57>;
> +			interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> +			interrupt-map =3D <0x0 0x0 0x0 0x1 &pcie_intc1 0x1>,
> +					<0x0 0x0 0x0 0x2 &pcie_intc1 0x2>,
> +					<0x0 0x0 0x0 0x3 &pcie_intc1 0x3>,
> +					<0x0 0x0 0x0 0x4 &pcie_intc1 0x4>;
> +			msi-controller;
> +			device_type =3D "pci";
> +			starfive,stg-syscon =3D <&stg_syscon>;
> +			bus-range =3D <0x0 0xff>;
> +			clocks =3D <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
> +				 <&stgcrg JH7110_STGCLK_PCIE1_TL>,
> +				 <&stgcrg JH7110_STGCLK_PCIE1_AXI_MST0>,
> +				 <&stgcrg JH7110_STGCLK_PCIE1_APB>;
> +			clock-names =3D "noc", "tl", "axi_mst0", "apb";
> +			resets =3D <&stgcrg JH7110_STGRST_PCIE1_AXI_MST0>,
> +				 <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV0>,
> +				 <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV>,
> +				 <&stgcrg JH7110_STGRST_PCIE1_BRG>,
> +				 <&stgcrg JH7110_STGRST_PCIE1_CORE>,
> +				 <&stgcrg JH7110_STGRST_PCIE1_APB>;
> +			reset-names =3D "mst0", "slv0", "slv", "brg",
> +				      "core", "apb";
> +			status =3D "disabled";
> +
> +			pcie_intc1: interrupt-controller {
> +				#address-cells =3D <0>;
> +				#interrupt-cells =3D <1>;
> +				interrupt-controller;
> +			};
> +		};
>  	};
>  };
> --=20
> 2.17.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--9MzUggWp64cOatqb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZna+qwAKCRB4tDGHoIJi
0oidAP9mkLa2XKoOd6q13Ys5GhzVvznTCLxoSUGlfDWAVZWYLwEAifgAdRavHbVl
GlceghM7sKepZHxV7C4OLuI+XypsFwc=
=NabL
-----END PGP SIGNATURE-----

--9MzUggWp64cOatqb--

