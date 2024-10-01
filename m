Return-Path: <linux-kernel+bounces-345059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3198B186
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA09A1F228D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B634A28;
	Tue,  1 Oct 2024 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hM2AhVR1"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB8A5F;
	Tue,  1 Oct 2024 00:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727743168; cv=none; b=l19YfSfvB8eYob1DmxnVgISA2vfDqKekVsWoIX997gpUdPUzl8ORo8mP5QM3wKZPCNWQrPVXqP5h5VGcFHGT90RgaYDLk5sIFFf2ugrB0NlD3h0p/u3QvgcOu4T3K+BLGcgIlH9SWhBbLn/MupBYhT760Ww2QUrElJflwIz767Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727743168; c=relaxed/simple;
	bh=GLe4SO+549p8pghcfTgKNxoJa35foPHFhcE3XLyEsB0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QccJAzyVpattfJ1+7upZj9t8gFqCrGGWrEbVa1MfgywZK+ZrTngJxpZtNp8AVDAg05J0MDA/R61ep60Ba9Hbs6e6+f/5uJQZBvUGb8GhHtUFVNjs1H/8T8xSzKZYIkUDD5NRd2Dw0VY9KYtfuc8DfneMMbBIEPCbpCOJCsyyoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hM2AhVR1; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727743164;
	bh=Ob0FYk4MOn2+/LkBSgodtWgm9m037MF4mRKnkQZryEo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hM2AhVR1q7U1Y+LIANn29DADLTYOwonQCe/iarbXLbuf8sv+cS8yUnvPZd9VcBhfq
	 nPEV4ibnLMtmEV0BppBpV84WMRbkbWTJmRKwVLo7ZDqRHKllnKFLdsUwEFnSOToV8Q
	 Rma+nAD9V/N2AAsXLxTDN2JRoRC/X1f8zI0/K4PpF6HP+YmrEGdsuYplfy/ldGfVS8
	 PtJsWJNhET5HwIYQIUrLahSzGlswOxd9DD7hjIF3TB6nm8vCS+bxmqV+kELUHKSm5M
	 /xSYui1c9fGOLNKSWUJzzuhRtdsZp/6uBdux9Nf8+G6XVC/gYXyxjZCmgBM/uv3rZg
	 HNX/o2llk3ctw==
Received: from [192.168.68.112] (ppp118-210-73-17.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.17])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7A7FE650AC;
	Tue,  1 Oct 2024 08:39:23 +0800 (AWST)
Message-ID: <9c0a5a8247622e094b927f2c26550d3ce9af5896.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 4/8] ARM: dts: aspeed: yosemite4: Revise address of
 i2c-mux for two fan boards
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 10:09:22 +0930
In-Reply-To: <20240930070500.3174431-5-Delphine_CC_Chiu@wiwynn.com>
References: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240930070500.3174431-5-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 15:04 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> Change the address of the I2C mux for two fan boards to 0x74
> according to schematic.
>=20
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 80 ++++++++++---------
>  1 file changed, 43 insertions(+), 37 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 26e0fcbed8d2..ecf012c9cbbc 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -32,6 +32,8 @@ aliases {
>  		i2c27 =3D &imux27;
>  		i2c28 =3D &imux28;
>  		i2c29 =3D &imux29;
> +		i2c30 =3D &imux30;
> +		i2c31 =3D &imux31;
>  		i2c34 =3D &imux34;
>  		i2c35 =3D &imux35;
>  	};
> @@ -1062,6 +1064,8 @@ gpio@23 {
>  };
> =20
>  &i2c14 {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
>  	status =3D "okay";
>  	bus-frequency =3D <400000>;
>  	adc@1d {
> @@ -1122,20 +1126,50 @@ eeprom@51 {
>  		reg =3D <0x51>;
>  	};
> =20
> -	i2c-mux@71 {
> -		compatible =3D "nxp,pca9846";
> +	i2c-mux@73 {
> +		compatible =3D "nxp,pca9544";
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
>  		idle-state =3D <0>;
>  		i2c-mux-idle-disconnect;
> -		reg =3D <0x71>;
> +		reg =3D <0x73>;
> =20
>  		i2c@0 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0>;
> =20
> +			adc@35 {
> +				compatible =3D "maxim,max11617";
> +				reg =3D <0x35>;
> +			};
> +		};
> +
> +		i2c@1 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0>;
> +
> +			adc@35 {
> +				compatible =3D "maxim,max11617";
> +				reg =3D <0x35>;
> +			};
> +		};
> +	};
> +
> +	i2c-mux@74 {
> +		compatible =3D "nxp,pca9546";
> +		reg =3D <0x74>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		imux30: i2c@0 {
> +			reg =3D <0>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
>  			adc@1f {
>  				compatible =3D "ti,adc128d818";
>  				reg =3D <0x1f>;
> @@ -1152,6 +1186,8 @@ pwm@20{
>  			gpio@22{
>  				compatible =3D "ti,tca6424";
>  				reg =3D <0x22>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;

This seems unrelated. Such changes should be in their own patch with a
`Fixes:` tag.

>  			};
> =20
>  			pwm@23{
> @@ -1181,10 +1217,10 @@ gpio@61 {
>  			};
>  		};
> =20
> -		i2c@1 {
> +		imux31: i2c@1 {
> +			reg =3D <1>;
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
> -			reg =3D <0>;
> =20
>  			adc@1f {
>  				compatible =3D "ti,adc128d818";
> @@ -1202,6 +1238,8 @@ pwm@20{
>  			gpio@22{
>  				compatible =3D "ti,tca6424";
>  				reg =3D <0x22>;
> +				gpio-controller;
> +				#gpio-cells =3D <2>;

This should go in the same patch as the instance above.

>  			};
> =20
>  			pwm@23{
> @@ -1231,38 +1269,6 @@ gpio@61 {
>  			};
>  		};
>  	};
> -
> -	i2c-mux@73 {
> -		compatible =3D "nxp,pca9544";
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -
> -		idle-state =3D <0>;
> -		i2c-mux-idle-disconnect;
> -		reg =3D <0x73>;
> -
> -		i2c@0 {
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			reg =3D <0>;
> -
> -			adc@35 {
> -				compatible =3D "maxim,max11617";
> -				reg =3D <0x35>;
> -			};
> -		};
> -
> -		i2c@1 {
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			reg =3D <0>;
> -
> -			adc@35 {
> -				compatible =3D "maxim,max11617";
> -				reg =3D <0x35>;
> -			};
> -		};
> -	};
>  };
> =20
>  &i2c15 {


