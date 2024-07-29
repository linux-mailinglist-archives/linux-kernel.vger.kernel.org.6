Return-Path: <linux-kernel+bounces-264952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C5293EA87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23842816E8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B17E4315B;
	Mon, 29 Jul 2024 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mFPDK6Yr"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532A3D978;
	Mon, 29 Jul 2024 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722215856; cv=none; b=dsZzhn+G94kk3SZmOaVxLbaZ/K3/mKijxbrM9C9gl1dHH0naPAUvAsqs8JkBoJFoqqLtTytkM6ZdHxJSFarzWCTqoYl478vKIztnLishtFsSugNiplHbvA4oOJCLlEHBCYloTv3QQgJLfCv5pHB8jUycA/RzxDGbBy4h+ODxAPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722215856; c=relaxed/simple;
	bh=eTbtsv2iQDDLS8TIblrPeEiyMCqxozNUsxIY48jO6yQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J/2mxxdKaxxqHNeiEHAwX6fr+9pKCaYliFkN2BNcrvuvFumqnpk0L6SmMD3OjHkedrytKPFsKS3vs+xRwuh10dmRBRIRG0SvUUpNyzlYu+YRDC3sQrSbEZrlYbLM46HDBe7TuarrRfR5b9g1rYOXVxRxLXgvQJnY5rQeK7mVUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mFPDK6Yr; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722215846;
	bh=aUrFfDFmD5KIKv3jz80Iad9Jg4vDE1/Msd0Yw2YSF08=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mFPDK6Yr3iMsM0daTCQB8XQTk9qCQvyZR6AUj9dJY87DABrlHpKW3jkEjgbsVwGTZ
	 oX1O7B9MytNzlcbpajL6HML9l3B4+30QdpUj91c0kme73XiOyAbEypQ9XAk1YLVA05
	 7jZ5z90JJVrjnYpq8zE2eMQxgFGtrHDlJMBlGQLcZRO+jk/ZtoLQWOuVFYfu9yud2X
	 dMifVSMrTnSvP6YtmuQmLMxLKuFnGHfjcCgwI7g48wTi5qihGwr9lU9xyQLYy4CIAf
	 T8FpqEjCCHuRASJKzcyqKAbxi9NARvYe1RKpIIYf8m5ZPXqw7a7/VGdkH7D8/uDYL/
	 Gb3IoAuCTVBUw==
Received: from [192.168.68.112] (unknown [118.211.93.69])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E99A466B02;
	Mon, 29 Jul 2024 09:17:23 +0800 (AWST)
Message-ID: <6d73dcf20c726ad59e2aa16e507af17b3af59c42.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Patrick Williams
 <patrick@stwcx.xyz>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,  Cosmo Chou
 <cosmo.chou@quantatw.com>, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, Conor Dooley <conor+dt@kernel.org>, Potin
 Lai <potin.lai@quantatw.com>, Joel Stanley <joel@jms.id.au>, Conor Dooley
 <conor.dooley@microchip.com>
Date: Mon, 29 Jul 2024 10:47:22 +0930
In-Reply-To: <172199921421.1507234.14901757413141840919.robh@kernel.org>
References: <20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com>
	 <172199921421.1507234.14901757413141840919.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Potin,

On Fri, 2024-07-26 at 08:09 -0500, Rob Herring (Arm) wrote:
> On Fri, 26 Jul 2024 18:26:48 +0800, Potin Lai wrote:
> > Add Linux device tree entry related to Meta(Facebook) Catalina specific
> > devices connected to BMC(AST2600) SoC.
>=20
...
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
>   pip3 install dtschema --upgrade
>=20
>=20
> New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-cata=
lina.dtb' for 20240726-potin-catalina-dts-v5-0-8f02305af527@gmail.com:
>=20
>=20
...
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus@1=
e78a000/i2c@100/i2c-mux@70/i2c@2/pwm@21: failed to match any schema with co=
mpatible: ['maxim,max31790']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus@1=
e78a000/i2c@100/i2c-mux@70/i2c@2/pwm@27: failed to match any schema with co=
mpatible: ['maxim,max31790']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus@1=
e78a000/i2c@100/i2c-mux@70/i2c@3/vrm@60: failed to match any schema with co=
mpatible: ['isil,raa228004']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus@1=
e78a000/i2c@100/i2c-mux@70/i2c@3/vrm@61: failed to match any schema with co=
mpatible: ['isil,raa228004']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus@1=
e78a000/i2c@100/i2c-mux@70/i2c@3/vrm@62: failed to match any schema with co=
mpatible: ['isil,raa228004']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus@1=
e78a000/i2c@400/ipmb@10: failed to match any schema with compatible: ['ipmb=
-dev']
...

The snipped errors are mostly from the DTSI, but these errors above are
specific to your DTS. Can you please address them?

Andrew

