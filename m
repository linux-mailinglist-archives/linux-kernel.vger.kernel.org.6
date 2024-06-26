Return-Path: <linux-kernel+bounces-229890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEED29175AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E54A1C21D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664F913ADA;
	Wed, 26 Jun 2024 01:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="h8tBGxgR"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8822D045;
	Wed, 26 Jun 2024 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365444; cv=none; b=kd6llay5tbzo2nuMJc1pIIP56mdQUZpCJsPPw7QR1v5KmFtf1ttNvfaJywG+ZvD4HFi42MnCpeaZUb53rpcvkSJZKy6jPGUCxBjHJnKcW0xKHrxjalyCWV3lTvvvHZ/B/JHzG//XzOoweEf9E+Jt6deagfT57DB5C+eNlj7cJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365444; c=relaxed/simple;
	bh=ExsyB0vwp1t6uljWXtJ/KJ3LWtK9Y9Hgn2nrXwlpp3k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=btXsRwph18QG+gOHQa7DbdI6kfasJcYJlVW1zwGirN/FsccNZIKrz0eRbasIDIL0LRLq+g7F6hRcchrX1CI8JoHQZkjdqFAZy7s2TPf/Va9vgQ64lNymY9zmmLI/YWpVuorq/ZW8bGunDboM7GC2gpneoYQ/F+jaI6u20YxFtEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=h8tBGxgR; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-79-194.adl-adc-lon-bras32.tpg.internode.on.net [118.210.79.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 673A820009;
	Wed, 26 Jun 2024 09:30:36 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1719365438;
	bh=X7FD5oPv28K3sYjsKRmxtB3gZH81Qm9pRxGi9lHMBZI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h8tBGxgRPSDXyEaS+3XN2CMKE6rsFD+erg3JYsLIiR2ICZ5WkHG/t4Ufi4P5BH9/4
	 Wo5AHi/oSm9GHwzc3EvzMh+wjC23WbywSwe3mY1g7ZpBO9dbD+gUpgtE7S41Fr4vG+
	 1x9bKnuITzfo0t0s1OPlwTqDDETsJ5h66HkNHbA77cC9x2amCOhSrkR7Wm2eSXOAT2
	 PdJBMVK35Hmd1qCQs93gcHZGYKc9tOTerrR6/I+2V6bFXdP0CMOF3Hf8Ofu6rAWSMB
	 Wbj7jSPSjeUK/ZNazF8PVCYy0qTh8D8dg1GpK6zo1Wiowmh4rCgeiBd9dsa9sFkEer
	 yHMvBHsH/JLHA==
Message-ID: <4391083991a16c435c5d8849eb5ee2be2f03793c.camel@codeconstruct.com.au>
Subject: Re: [PATCH 02/17] ARM: dts: aspeed: minerva: Add spi-gpio
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Yang Chen <yangchen.openbmc@gmail.com>, joel@jms.id.au,
 patrick@stwcx.xyz,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com
Date: Wed, 26 Jun 2024 11:00:35 +0930
In-Reply-To: <20240625121835.751013-3-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
	 <20240625121835.751013-3-yangchen.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-25 at 20:18 +0800, Yang Chen wrote:
> From: Yang Chen <yang.chen@quantatw.com>
>=20
> Add spi-gpio for TPM device.
>=20
> Signed-off-by: Yang Chen <yang.chen@quantatw.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-minerva.dts    | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/a=
rch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> index e20e31917d6c..7d96a3638448 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> @@ -22,6 +22,8 @@ aliases {
>  		i2c19 =3D &imux19;
>  		i2c20 =3D &imux20;
>  		i2c21 =3D &imux21;
> +
> +		spi1 =3D &spi_gpio;
>  	};
> =20
>  	chosen {
> @@ -49,6 +51,25 @@ led-fan-fault {
>  			default-state =3D "off";
>  		};
>  	};
> +
> +	spi_gpio: spi-gpio {
> +		status =3D "okay";
> +		compatible =3D "spi-gpio";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		gpio-sck =3D <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
> +		gpio-mosi =3D <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
> +		gpio-miso =3D <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
> +		num-chipselects =3D <1>;
> +		cs-gpios =3D <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> +
> +		tpmdev@0 {
> +			compatible =3D "infineon,slb9670", "tcg,tpm_tis-spi";
> +			spi-max-frequency =3D <33000000>;
> +			reg =3D <0>;
> +		};
> +	};

I poked at your series with the following script:

```
$ cat dtb-check
#!/usr/bin/bash

set -euo pipefail

DTB=3D"$1"

rm -f arch/arm/boot/dts/"$DTB"
make CHECK_DTBS=3Dy "$DTB" 2>&1 |
    sed "/should not be valid under {'type': 'object'}/d" > curr.log
diff -u ref.log curr.log
```

I ran this after creating a reference output prior to your series using
the same `make CHECK_DTBS=3Dy` command.

This patch gave the following output (which I expect Rob's bot will
follow up with at some point as well):

```
--- ref.log     2024-06-26 10:48:23.767078834 +0930
+++ curr.log    2024-06-26 10:55:56.857034132 +0930
@@ -1,4 +1,6 @@
   DTC_CHK arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts=
/aspeed/aspeed-bmc-facebook-minerva.dtb: /: spi-gpio: {'status': ['okay'], =
'compatible': ['spi-gpio'], '#address-cells': [[1]], '#size-cells': [[0]], =
'gpio-sck': [[62, 203, 0]], 'gpio-mosi': [[62, 204, 0]], 'gpio-miso': [[62,=
 205, 0]], 'num-chipselects': [[1]], 'cs-gpios': [[62, 200, 1]], 'tpmdev@0'=
: {'compatible': ['infineon,slb9670', 'tcg,tpm_tis-spi'], 'spi-max-frequenc=
y': [[33000000]], 'reg': [[0]]}} is not of type 'array'
+       from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.y=
aml#
 /home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts=
/aspeed/aspeed-bmc-facebook-minerva.dtb: timer: 'clocks' does not match any=
 of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer=
.yaml#
 /home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts=
/aspeed/aspeed-bmc-facebook-minerva.dtb: sdram@1e6e0000: compatible: ['aspe=
ed,ast2600-sdram-edac', 'syscon'] is too long
@@ -38,3 +40,17 @@
        from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-f=
si-master.yaml#
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/apb/fsi@1e7=
9b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-mas=
ter', 'fsi-master']
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/apb/dma-con=
troller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2=
600-udma']
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts=
/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: $nodename:0: 'spi-gpio' =
does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
+       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts=
/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: gpio-sck: False schema d=
oes not allow [[62, 203, 0]]
+       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts=
/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: gpio-miso: False schema =
does not allow [[62, 205, 0]]
+       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts=
/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: gpio-mosi: False schema =
does not allow [[62, 204, 0]]
+       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts=
/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: 'sck-gpios' is a require=
d property
+       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts=
/aspeed/aspeed-bmc-facebook-minerva.dtb: spi-gpio: Unevaluated properties a=
re not allowed ('#address-cells', '#size-cells', 'gpio-miso', 'gpio-mosi', =
'gpio-sck', 'tpmdev@0' were unexpected)
+       from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/dts=
/aspeed/aspeed-bmc-facebook-minerva.dtb: tpmdev@0: $nodename:0: 'tpmdev@0' =
does not match '^tpm(@[0-9a-f]+)?$'
+       from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.=
yaml#
```

Can you please address these and go over the rest of the patches to
shore them up against the current bindings?

Thanks,

Andrew

