Return-Path: <linux-kernel+bounces-330125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD59979A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B0EB228EA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 03:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45A1171BB;
	Mon, 16 Sep 2024 03:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XIB5v7pq"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B727E56A;
	Mon, 16 Sep 2024 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726455928; cv=none; b=FVp2n3RCplbA+Xw343B2KdbjC8x6B+MVqkWwQ9u/yDetUoks94rjSW+V6YG2c2aWquwaC18YzOulLS3C9fHergzExSNKCK9RdehEiZDsIMOpDYNa35isWsrKkNR6HoRekgzEyUd8JFniuKwRHJWgJwVNuHzLLK2v2B5Yy6GOy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726455928; c=relaxed/simple;
	bh=Ln4bhTrVwrUU3HJnJ9Zh2Syx4XQpfs2RNIcfmF888w0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vk1uhbGQQsnvCxl+u0EhTKfSPTa3KAJUINuoqzJqFzp+L+VwvHc7kD73hhn2EnNBXhCoBJ0W7rptdrIqzaeknFA2G/nNF9vjc8SYp81UYmxvnZcqQ9tU+0xcMxGea4ASgVrWnj1im/6HKFU0MBVZN5vR/BB4Zr88askKm39yTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XIB5v7pq; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726455924;
	bh=b4aPzdKJ99+8nbf9/pwFtWuXuCfyXaWcetBCqR9CkIg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XIB5v7pqm0HLKI8xDjUR88PYDtxQHFhQ2cI+x8sfAHyoEs+wmShl9smp93Fg8SMa3
	 dH5/LtmaCPJBZEav8qJdbXp5mYFKTHdN7kpD4e8glJ9rgqEX5+s8J2FtBDbvkfA0EL
	 ygaOavTjBoPJ9TfgYPOHtjvjJyE9P64rQsasm3cx8JmZpZfP/mlqKMCSHTff3P0zc9
	 u3VmWd6eq10HQnT03Loh0fWaAy9KCHsXP8eGCVzlZn1SNNWDiLizAnOOWdKjix3kF1
	 Ofr0lXHp6iwIPweLJBZwLiKW3CaGFy9erBWUMMqnJPlfh5uLMctamH3FlkWtygMuQL
	 oQf42QZSua8aA==
Received: from [192.168.68.112] (ppp118-210-161-36.adl-adc-lon-bras34.tpg.internode.on.net [118.210.161.36])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0399B65027;
	Mon, 16 Sep 2024 11:05:22 +0800 (AWST)
Message-ID: <a18eff1095e1ddffa8eb44fb4a76a0b458213a62.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506
 for CPLD IOE
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>, 
	"patrick@stwcx.xyz"
	 <patrick@stwcx.xyz>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Mon, 16 Sep 2024 12:35:22 +0930
In-Reply-To: <TYZPR04MB5853062387962EB4CA08A366D6652@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240910054751.2943217-3-Delphine_CC_Chiu@wiwynn.com>
	 <ccef1d90b9a7eb343e99afa2c6cd6ea7407b0541.camel@codeconstruct.com.au>
	 <TYZPR04MB5853B6611AF9AA5C3E5AE778D6652@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <TYZPR04MB5853062387962EB4CA08A366D6652@TYZPR04MB5853.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-13 at 03:26 +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
>=20
> > -----Original Message-----
> > From: Delphine_CC_Chiu/WYHQ/Wiwynn
> > Sent: Friday, September 13, 2024 10:08 AM
> > To: Andrew Jeffery <andrew@codeconstruct.com.au>;
> > Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> > patrick@stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> > <joel@jms.id.au>
> > Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
> > Subject: RE: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca95=
06
> > for CPLD IOE
> >=20
> >=20
> >=20
> > > -----Original Message-----
> > > From: Andrew Jeffery <andrew@codeconstruct.com.au>
> > > Sent: Thursday, September 12, 2024 10:11 AM
> > > To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> > > patrick@stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanle=
y
> > > <joel@jms.id.au>
> > > Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> > > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio
> > > pca9506 for CPLD IOE
> > >=20
> > >  [External Sender]
> > >=20
> > >  [External Sender]
> > >=20
> > > On Tue, 2024-09-10 at 13:47 +0800, Delphine CC Chiu wrote:
> > > > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > > >=20
> > > > We use CPLD to emulate gpio pca9506 I/O expander on each server
> > > > boards.
> > > > Therefore, add pca9506 to probe driver for the CPLD I/O expander.
> > >=20
> > > I think it might be best if you add your own compatible to the list i=
n
> > > the gpio-pca95xx binding just in case there are some behavioural
> > > quirks of your CPLD implementation? Not sure if this should be
> > > "facebook,pca9506" or "wywinn,pca9506", but assuming facebook, from
> > > there you can specify
> > >=20
> > >     compatible =3D "facebook,pca9506", "nxp,pca9506";
> > >=20
> > > This allows you to add the quirks to the driver as required in the
> > > future through the more-specific compatible.
> > >=20
> > > Andrew
> >=20
> > Hi Andrew,
> >=20
> > Thanks for the review.
> > I'll add the "facebook,pca9506" in gpio-pca95xx binding in next version=
 of
> > patches.
>=20
> Hi Andrew,
>=20
> I tried to add "facebook,pca9506" in the compatible list of gpio-pca95xx =
binding
> and add compatible =3D "facebook,pca9506", "nxp,pca9506" but got followin=
g failed
> messages:
>     gpio@21: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['facebook,pca9506', 'nxp,pca9506'] is too long
>         'diodes,pi4ioe5v6534q' was expected
>         'nxp,pcal6534' was expected
>         from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.=
yaml#
> Would like to ask do you have any suggestions? Thanks.

Mmm, maybe it's best if we leave the compatible as just 'nxp,pca9506'
for now, but if you do discover quirks then we can consider this again.

Andrew

