Return-Path: <linux-kernel+bounces-341299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70912987DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CEDB22A99
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B959B175D32;
	Fri, 27 Sep 2024 05:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RsMFxn+1"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE415B15D;
	Fri, 27 Sep 2024 05:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727415973; cv=none; b=N6Nc1XsJD6CbNOLHVv8L8eOrUFOFqvoBwAUT5DWypW+TeLA0zYuMmy7c1eniPHtsK2ws6yO+MiPQXtZL7aGosWmZv32QDmDKazliXjbovUOEtjhuM1Vv2NWHfNnb2D4+3vvLjPq4k8jIurvdn2VJpNdMgRzaI32DTd8yfwWsj64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727415973; c=relaxed/simple;
	bh=CidmfpHlz1omx96du1dNki0rkd7Dbrawkequf//CKCY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=edNIC7SOtWEo/eTjI1EtQG3tqg5a5m01HBqlveiz32KqvfKfojHplO7mnc3AiQXTkhz/Fs9WwViZOl7voLjlyQVJHrR4RlMbjYTD2/rTAo93RD3aflIY2NJjtu4B70HzLdDZeYKYH3ruiD+3HgDIcKJgFTyKO5m9KKR2747qObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RsMFxn+1; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727415969;
	bh=lR8CM85Fsk5eJ3v/EmZG9zqhCtPYW4GlO6MdtlhMpMA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RsMFxn+1eaz5Dmg6g4v32cjJXYgtYvMCKwIrjOZHe7HXrUGL/pYVBTWkkC0NNL76d
	 SffmDO/0TS1XSFQwTxf971qlXDnC5Z7f+eHXZFpw41p/DJ2VWaLjBo0Otnf9Dl7BSS
	 yUM6UwiRZthYPewTL05yDyhege6GorRtYnxe4Zo0Jihelwndyl/dI/yzg/KAY0a1Ny
	 7yHpM0rIpFr/66CkN26t+/MwU+jc0Rmt8jkhpTPU+gxg8yymdIrwVoULSx5c0loOHi
	 31i0gQhKl9lmVXvQDlNhw+3qZiHLh20UHw/qPoleYzbULpbJOa/+PxATqu1qY1UWYj
	 jG3yKUX/qxFkg==
Received: from [192.168.68.112] (ppp118-210-187-73.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.73])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8919565029;
	Fri, 27 Sep 2024 13:46:08 +0800 (AWST)
Message-ID: <7a97e482c01a32d40fd2a70a839acf239ef28608.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 3/5] ARM: dts: aspeed: yosemite4: Change the address
 of Fan IC on fan boards
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 27 Sep 2024 15:16:06 +0930
In-Reply-To: <20240926032821.4171466-4-Delphine_CC_Chiu@wiwynn.com>
References: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240926032821.4171466-4-Delphine_CC_Chiu@wiwynn.com>
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
> Change the address of Fan IC: Max31790 on fan boards according to
> schematic.
>=20
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 430c28bdd314..a7e51725c595 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -496,10 +496,8 @@ adc@1f {
>  			};
> =20
>  			pwm@20{
> -				compatible =3D "max31790";
> +				compatible =3D "maxim,max31790";

This isn't changing the address, it's fixing the compatible string.
Please make this a separate patch with an appropriate Fixes: tag.

>  				reg =3D <0x20>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;

Maybe put this in the same patch as the compatible fix though, if it's
correct.

>  			};
> =20
>  			gpio@22{
> @@ -509,11 +507,9 @@ gpio@22{
>  				#gpio-cells =3D <2>;
>  			};
> =20
> -			pwm@23{
> -				compatible =3D "max31790";
> -				reg =3D <0x23>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> +			pwm@2f{
> +				compatible =3D "maxim,max31790";
> +				reg =3D <0x2f>;
>  			};
> =20
>  			adc@33 {
> @@ -539,10 +535,8 @@ adc@1f {
>  			};
> =20
>  			pwm@20{
> -				compatible =3D "max31790";
> +				compatible =3D "maxim,max31790";
>  				reg =3D <0x20>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;

As above for this diff hunk too.

Andrew

>  			};
> =20
>  			gpio@22{
> @@ -552,11 +546,9 @@ gpio@22{
>  				#gpio-cells =3D <2>;
>  			};
> =20
> -			pwm@23{
> -				compatible =3D "max31790";
> -				reg =3D <0x23>;
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> +			pwm@2f{
> +				compatible =3D "maxim,max31790";
> +				reg =3D <0x2f>;
>  			};
> =20
>  			adc@33 {


