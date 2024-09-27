Return-Path: <linux-kernel+bounces-341298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F3987DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C461C22BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCBE17623C;
	Fri, 27 Sep 2024 05:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="I6Lrnbrc"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9773A1482E2;
	Fri, 27 Sep 2024 05:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727415813; cv=none; b=WnPA2bnALBjJoQY6AHvPDTe7X2Fuv5v7q8SEIX3lZ7vC7SrQH/sWBMZsgUcc0dRRe6pd88EeiaISrGI1JkmIxNASKEzVoIR5lg6XWy6pHSqzPwP+7S0dyzor98AsGefpExKYRGEYiSi68NQNIW0/Sx0y4TPSdBJ0skguT1yk+zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727415813; c=relaxed/simple;
	bh=y2TPeaNbw7HpiFnNmvm1sk+J3wDA1q+p2gmsimeVm0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Avf0IiIGnWTReqAvPiXgKtBY+KSGw8J+76jR3+oqUcipbxycMWqYOnBLNKoTBrDLVAAcM6YuQuh/zfgKTTQWod77wECA/x11RnrZmZWzw87E4dRyCR+9ShGAF+OMLlS7Q6b1wYfZjaqRG5ip9GjZmuBEkc+TsfZKL+8nusMktTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=I6Lrnbrc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727415809;
	bh=hmM9nard7C236jMcmPNo75yk3HSeZ0dMHaCt6a0p4X4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I6LrnbrcjS+t9cKS5+t1QWpHB3ZXrTfGOVlCEgIdfLk6TaC0UZAKI2xk1rP6Z+73i
	 JxTyr/pUssnJRw4c0sBqQOQ9xV9S2jn50Qw5A0XaME0quauF1Hz+xboRulGZlEGQ2i
	 bv16X3GZF1ftMpVT+XqjLazEvmZW89kll1D3jqyoVq42KXecBi9rjCG5XZfoALQvV/
	 B0/Y6CV4Q9A+0xjOrAbZPbwFKFSjU9Ql/G+9dv72pEOS8gU5lymdPLwnJenbn3IEx3
	 AIQRMK48KR4HjPCKCQdkbG5vP9VnzrTSNAP3H/PE5QfnObT3jQ4DKnmFcRMacrW2l6
	 FdCAxfwYFlLxg==
Received: from [192.168.68.112] (ppp118-210-187-73.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.73])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D890965029;
	Fri, 27 Sep 2024 13:43:28 +0800 (AWST)
Message-ID: <0e9483a19f916982ba6996b81c2f1254da3801f3.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 2/5] ARM: dts: aspeed: yosemite4: remove led gpio
 pca9552 on fan boards
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 27 Sep 2024 15:13:26 +0930
In-Reply-To: <20240926032821.4171466-3-Delphine_CC_Chiu@wiwynn.com>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240926032821.4171466-3-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-26 at 11:28 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> Remove led gpio contorller: pca9552 on fan boards since there is
> no binding document for pca9552 currently.

That's not true, there is, just it's not converted to dt-schema:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/devicetree/bindings/leds/leds-pca955x.txt?h=3Dv6.11

So the nodes can stay, though they probably generate warnings. The
right way to fix this is to convert the binding document.

Andrew

>=20
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ------------------
>  1 file changed, 18 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 04f6378c2b5f..430c28bdd314 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -525,15 +525,6 @@ eeprom@52 {
>  				compatible =3D "atmel,24c128";
>  				reg =3D <0x52>;
>  			};
> -
> -			gpio@61 {
> -				compatible =3D "nxp,pca9552";
> -				reg =3D <0x61>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				gpio-controller;
> -				#gpio-cells =3D <2>;
> -			};
>  		};
> =20
>  		imux31: i2c@1 {
> @@ -577,15 +568,6 @@ eeprom@52 {
>  				compatible =3D "atmel,24c128";
>  				reg =3D <0x52>;
>  			};
> -
> -			gpio@61 {
> -				compatible =3D "nxp,pca9552";
> -				reg =3D <0x61>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				gpio-controller;
> -				#gpio-cells =3D <2>;
> -			};
>  		};
>  	};
>  };


