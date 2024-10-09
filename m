Return-Path: <linux-kernel+bounces-356138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83535995CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC101F25C5F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9E42837B;
	Wed,  9 Oct 2024 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="aaaTxY6c"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775C1F947;
	Wed,  9 Oct 2024 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437241; cv=none; b=Ah9uBFtbt982tSNqWkEPGj0xLgp+a2PytDULVhPIMUvV0UB04940N1PZFbcIuB+hS0sELogDuwYyh6gMvZaC7B0GKNQivm4j2iuwwF7w4u+EWYqS4p0DYANRmosnrVsUUuXf8xT/TtMKIWKONdC20vlIdZFU8NDsfQKA3HeHwvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437241; c=relaxed/simple;
	bh=cKuMDLKNX81P6yJL4MIQeJ1Gln7JePGUYfzaUPWhzQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ovnYdFSp6mrRcXEQSqdHNHK3k9xMRkQWeBLwJG5wtBQz2Zld+FR+9Xyxr4j9mXTdH40FtgyJLrSSgisJ5Fsm05d5bhd0qUSQn8VnFMxFdjMzpMy6SIQ1Ht6UUnYpQcxhhoBJ52GZ0gpcYmg+Ak0bstzuCd/jGiMAKnxI6oTakc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=aaaTxY6c; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1728437230;
	bh=wkuRk6jxUw0jV4GEtxreQLO/W5UhOPn3u8EdvBkuGrQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aaaTxY6cKqWtOy7+Q1CiGUbKTXyFhXrrThL0niVbY11enCVcWRroxKOmb8dzqHlMI
	 SAyAMbN2GqkvEft5kpBjbwQdA+VN8xCvBxeL+TFFCJzJLehP/o1dMbqqnZlU4+Li8T
	 BAo4xL6Jb9TlGDhAjSIWyMVko3TvcVRZ3bGrnmAvPe1uqzRrxvL2FpqXkv6AWg/rdw
	 GM38KdbiLnJuex5b/gtsmDcHTDAtJHRVVUjr6XFSvqoZQDFInECI18K69BXuXjZy9F
	 KARASxpcESwb7KXBqBaodm9wxNsWfYLOVNHqcIK3KKUuU5Gcad1zMQDq0WywsZ3Fhc
	 B4ZFGSqtKrukA==
Received: from [192.168.68.112] (ppp118-210-190-105.adl-adc-lon-bras34.tpg.internode.on.net [118.210.190.105])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1293F6497F;
	Wed,  9 Oct 2024 09:27:08 +0800 (AWST)
Message-ID: <e4dd331944168257bfd2f4239d24317424da7b9c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 2/2] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Naresh Solanki <naresh.solanki@9elements.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Wed, 09 Oct 2024 11:57:07 +1030
In-Reply-To: <20241008111924.1865857-2-naresh.solanki@9elements.com>
References: <20241008111924.1865857-1-naresh.solanki@9elements.com>
	 <20241008111924.1865857-2-naresh.solanki@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Naresh,

On Tue, 2024-10-08 at 16:49 +0530, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> Add a device tree for IBM sbp1 BMC board which is based on AST2600 SOC.
>=20
> sbp1 baseboard has:
> - support for up to four Sapphire Rapids sockets having 16 DIMMS each.
>   - 240 core/480 threads at maximum
> - 32x CPU PCIe slots
> - 2x M.2 PCH PCIe slots
> - Dual 200Gbit/s NIC
> - SPI TPM
>=20
> Added the following:
> - Indication LEDs
> - I2C mux & GPIO controller, pin assignments,
> - Thermister,
> - Voltage regulator
> - EEPROM/VPD
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>=20
> ---
> Changes in V4:
> - Move reset related entried under mdio to phy.
> - Removed reserved gpio range.
> Changes in V3:
> Drop unused regulator entries which are not used by drivers.
> Decouple p12v_a
> Update pincfg for U62120
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>  .../boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts   | 6128 +++++++++++++++++
>  2 files changed, 6129 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
>=20
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed=
/Makefile
> index c4f064e4b073..577cc6754c45 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
>  	aspeed-bmc-ibm-rainier-1s4u.dtb \
>  	aspeed-bmc-ibm-rainier-4u.dtb \
>  	aspeed-bmc-ibm-system1.dtb \
> +	aspeed-bmc-ibm-sbp1.dtb \

Please keep this list sorted alphabetically.

>  	aspeed-bmc-intel-s2600wf.dtb \
>  	aspeed-bmc-inspur-fp5280g2.dtb \
>  	aspeed-bmc-inspur-nf5280m6.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts b/arch/arm/=
boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
> new file mode 100644
> index 000000000000..6036a9ca3840
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
>=20
> +
> +&i2c1 {
> +	status =3D "okay";
> +
> +	bmc_mux_nic: mux@77 {
> +		compatible =3D "maxim,max7357";
> +		reg =3D <0x77>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		reset-gpios =3D <&gpio0 ASPEED_GPIO(R, 3) (GPIO_ACTIVE_LOW | GPIO_OPEN=
_DRAIN)>;
> +		vdd-supply =3D <&p3v3_aux>;
> +
> +		i2c@0 {
> +			reg =3D <0>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			smb_pex_nic: pinctrl@20 {
>=20
...
> +			};
> +		};
> +
> +		i2c@1 {
> +			reg =3D <1>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		i2c@2 {
> +			reg =3D <2>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			ir38263-pvcore-nic2@40 {
> +				compatible =3D "infineon,ir38263";
> +				reg =3D <0x40>;
> +
> +				regulators {
> +					pvcore_nic2: vout {
> +						regulator-name =3D "pvcore_nic2";
> +						regulator-enable-ramp-delay =3D <2000>;
> +						vin-supply =3D <&p12v>;
> +					};
> +				};
> +			};

This doesn't match my understanding of the infineon,ir38263 and
regulator bindings. Certainly `make CHECK_DTBS=3Dy ...` complains about
it.

This is untested, but from my understanding, it should rather be
something like:

   pvcore_nic2: regulator@40 {
       compatible =3D "infineon,ir38263";
       reg =3D <0x40>;
  =20
       regulator-name =3D "pvcore_nic2";
       regulator-enable-ramp-delay =3D <2000>;
       vin-supply =3D <&p12v>;
   };

Note that this is _not_ the same as the maxim,max5978 binding, which
_does_ specify the regulators subnode.

Please fix all infineon,ir38263 nodes in the dts.

...

> +
> +		i2c-protocol;
> +	};
> +};
> +
> +&i2c5 {
> +	status =3D "okay";
> +
> +	i2cmux2: mux@77 {
> +		compatible =3D "maxim,max7357";
> +		reg =3D <0x77>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		reset-gpios =3D <&gpio0 ASPEED_GPIO(Z, 2) (GPIO_ACTIVE_LOW | GPIO_OPEN=
_DRAIN)>;
> +		vdd-supply =3D <&p3v3_aux>;
> +
> +		i2c@1 {
> +			reg =3D <1>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			r38263-p1v05-pch-aux@40 {
> +				compatible =3D "infineon,ir38263";
> +				reg =3D <0x40>;
> +
> +				interrupt-parent =3D <&smb_pex_vr_ctrl>;
> +				interrupts =3D <9 IRQ_TYPE_LEVEL_LOW>;

Aside from the regulators subnode issue, the infineon,ir38263 binding
doensn't specify interrupt properties. Does it need to be updated?

Otherwise, we have the following warning:

   r38263-p1v05-pch-aux@40: Unevaluated properties are not allowed ('interr=
upt-parent', 'interrupts', 'regulators' were unexpected)

> +
> +				regulators {
> +					p1v05_pch_aux: vout {
> +						regulator-name =3D "p1v05_pch_aux";
> +						regulator-enable-ramp-delay =3D <2000>;
> +						vin-supply =3D <&p12v>;
> +					};
> +				};
> +			};
> +		};
> +
> +		i2c@2 {
> +			reg =3D <2>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			ir38060-p1v8-pch-aux@40 {
> +				compatible =3D "infineon,ir38060";
> +				reg =3D <0x40>;
> +
> +				interrupt-parent =3D <&smb_pex_vr_ctrl>;
> +				interrupts =3D <32 IRQ_TYPE_LEVEL_LOW>;

As above.

Andrew

