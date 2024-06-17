Return-Path: <linux-kernel+bounces-216857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1A290A78B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99A3D1C23FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C363419006B;
	Mon, 17 Jun 2024 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="OveYK393"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C6818FC99;
	Mon, 17 Jun 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718610093; cv=none; b=Qwi4Xc+u2L+te1otZgVcFZWh9QoMjUs7qcom12ktfoigUXiIs2HqUSXxCKl4g6xpZC3cS1uFASyOqMViMcByEZIiX1J8D5DXB9ZA2+gqm7VFpS7HCN0MM50IzrlVcBEXfRfh1lYF0rV+jQarm3kZtic/QBwYy/nWPQr9nRPpB3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718610093; c=relaxed/simple;
	bh=gjozgmj5PXuXIp5WIMI+3tl/AexBgymhhdMPg4hky8k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7fYubK2nsrudu/UTxOrDpE67XB0f3ilLU9fUDfYB43ld+FoUItSwul6MBsrNwheVbtDAxZC/OfHjXQN7F+9hXNGB0Tbp+i3oAxRl7vMaj6W3RktVZPc0/TeUf7AU9ICUbnDc2WRNckqGjSft82yiaKqDQy8GEljKKQCpAw8D3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=OveYK393; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-79-194.adl-adc-lon-bras32.tpg.internode.on.net [118.210.79.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E152D2014F;
	Mon, 17 Jun 2024 15:41:27 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1718610088;
	bh=x9+zAFyMZm/7B6EtHFsboC7Irgy20gXAvPeF+y2R7t8=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=OveYK393V8uvj6JEsiSZT7QZl4vPieX0Ju+ZLvf5kbShLas6hXj4+QG7Dxwmt/92Y
	 H5iBzJlEahDYzQN2ilXXMdTYKofCyR997WswNQyaLjNrChXHXfefaytfdtnQaoRnyc
	 ZoQoOxgtLM70vjfv7lojCmbd2OTXZcUYLv9hZpYQUKR0bbvGHX2zvYP9Ooy+qO2t/k
	 a4UkFuKUSKcLo7ZQhZgEficn/6k/jIf6SbHT5EBCz+6aTkJ+ZWsCp9+nKjxfJTtiX8
	 JRWNJNYjUtF6FXOsJcPdpb3ni+CxTlsrInu/ubsTR/5GGups2Xrtk8EyFJvo26/+kx
	 RZ17kajnCs9aQ==
Message-ID: <643e0e9bbab98d442add8e6ef0c39c923942e9d0.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 7/7] ARM: dts: aspeed: Harma: remove pca9546
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Jun 2024 17:11:27 +0930
In-Reply-To: <20240613152425.1582059-8-peteryin.openbmc@gmail.com>
References: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
	 <20240613152425.1582059-8-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Peter,

On Thu, 2024-06-13 at 23:24 +0800, Peter Yin wrote:
> remove pca9546 and add Aegis fru device

Is there some relationship between these two things? Can you elaborate?

You also add a couple of GPIO expanders that aren't mentioned here?

Andrew

>=20
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 56 +++++++++----------
>  1 file changed, 25 insertions(+), 31 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arc=
h/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> index d892e646fced..4ff9e0104bbe 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> @@ -20,10 +20,6 @@ aliases {
>  		i2c21 =3D &imux21;
>  		i2c22 =3D &imux22;
>  		i2c23 =3D &imux23;
> -		i2c24 =3D &imux24;
> -		i2c25 =3D &imux25;
> -		i2c26 =3D &imux26;
> -		i2c27 =3D &imux27;
>  		i2c28 =3D &imux28;
>  		i2c29 =3D &imux29;
>  		i2c30 =3D &imux30;
> @@ -391,33 +387,6 @@ gpio@31 {
>  		"","","","";
>  	};
> =20
> -	i2c-mux@71 {
> -		compatible =3D "nxp,pca9546";
> -		reg =3D <0x71>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -
> -		imux24: i2c@0 {
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			reg =3D <0>;
> -		};
> -		imux25: i2c@1 {
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			reg =3D <1>;
> -		};
> -		imux26: i2c@2 {
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			reg =3D <2>;
> -		};
> -		imux27: i2c@3 {
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -			reg =3D <3>;
> -		};
> -	};
>  	// PTTV FRU
>  	eeprom@52 {
>  		compatible =3D "atmel,24c64";
> @@ -427,6 +396,31 @@ eeprom@52 {
> =20
>  &i2c11 {
>  	status =3D "okay";
> +
> +	gpio@30 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x30>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +	};
> +	gpio@31 {
> +		compatible =3D "nxp,pca9555";
> +		reg =3D <0x31>;
> +		gpio-controller;
> +		#gpio-cells =3D <2>;
> +
> +		gpio-line-names =3D
> +		"","","","",
> +		"","","presence-cmm","",
> +		"","","","",
> +		"","","","";
> +	};
> +
> +	// Aegis FRU
> +	eeprom@52 {
> +		compatible =3D "atmel,24c64";
> +		reg =3D <0x52>;
> +	};
>  };
> =20
>  &i2c12 {


