Return-Path: <linux-kernel+bounces-325835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADBD975ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414981F23E67
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DE93BB48;
	Thu, 12 Sep 2024 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="UWlhUR4k"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1D282FB;
	Thu, 12 Sep 2024 02:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726107412; cv=none; b=TLn9tL4wRWqugoG/IMgz4fg6q5OfjikKGNuFyW5SP4kiQy3e7axQBDdIWA4PE9xCbXoqtznbPlBTEFRGT4P0FFAjnpM2muyZ76VBVygnSro+OOj+K1Et27PmOj8yXtzYXCx7G1IjGQ1/jGk5HsMPkBdXDWJx4PTT8JV1vYeka/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726107412; c=relaxed/simple;
	bh=Tzzk1cA2o5tp+xiwq/YyxOWAaHtfPyCRWaj2LVEUd1M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b1EfV9fCcfAlzQxuyV5IXjuv2DMjxz3JOyM3fdjCHHHeAA7dYnhsOiFZW1x35pKlThNpQv/v7sC8XyYvZJQD/bpxehTDSDUi86eItghuTcJRVmTylcGBCZdVmOmtvwzzkDwt2eHUyiBxtelsigev0QgMfieCNxyKqM2PMCA1ESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=UWlhUR4k; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726107408;
	bh=dTGWD0Gn+Yi/RRB39Ic05wD/vXoyL7B1/d6vhk5Cy3w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UWlhUR4kacrXMMr2rVhZkPbmfXUDEaLDt0sgF7YKt8aeR2BiebejEq1g8TC3GlEra
	 ++wdggIEtNkwpIA8zpgXUkgVvoRvb/cyH2vZW4AIbJ59zHAc6f0YNklc3mrrFWJgX4
	 db/kntu0OAts7HlM38nLtFf6bK0PVSUTVgFlxNDn6JR7Y4N7WThLSkgtWIY7PZ84t/
	 j0r3mapTb7LZKT687nj6I4IMmFVq8vZkBti+N21/ZTzNu9oA2NeZE2LL4wweTC4WKB
	 X6+JZaKtG4NGP/kTJFh7b6QM/039wx3cfHwonfP8k0b/NMSaP6eAkVuFPozY7QMxrr
	 Nc7RxDnBUH6LQ==
Received: from [192.168.68.112] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 13AB9650D6;
	Thu, 12 Sep 2024 10:16:48 +0800 (AWST)
Message-ID: <215e32abc38011a5e265d91340292234ca157ec8.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Revise quad mode to
 dual mode
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 11:46:47 +0930
In-Reply-To: <20240910051350.2580971-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240910051350.2580971-1-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-10 at 13:13 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
>=20
> Revise quad mode to dual mode to avoid WP pin influnece the SPI.
>=20
> Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 98477792aa00..3073ade6d77c 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -105,15 +105,17 @@ flash@0 {
>  		status =3D "okay";
>  		m25p,fast-read;
>  		label =3D "bmc";
> -		spi-rx-bus-width =3D <4>;
> +		spi-tx-bus-width =3D <2>;
> +		spi-rx-bus-width =3D <2>;
>  		spi-max-frequency =3D <50000000>;
> -#include "openbmc-flash-layout-64.dtsi"
> +#include "openbmc-flash-layout-128.dtsi"

This is a bit more drastic than changing the bus mode.

Can you please split that out to a separate change with some
justification in the commit message? For instance, was the chip changed
too? Or were you using the 64M layout or a 128M chip the whole time?

Andrew

