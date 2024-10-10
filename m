Return-Path: <linux-kernel+bounces-360201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395799995D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B177E2864DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A0C1CFEC4;
	Thu, 10 Oct 2024 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RA5Riigd"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1536C1A704B;
	Thu, 10 Oct 2024 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728603931; cv=none; b=L066iih3/22uamXuZoEeNVIxEXdcExHIB5hadwsZeEON+0SgemMIHq6hFR32hSF31o+eDtfTzHBlgCXWBK/SbhLZxn9UiPIwtSpL5gARIuSWinLxGo76RbzG9mbRqf6QHvZBrG1sOoBLmldJnReatZZ/rU0gf7btgCJcsXWsgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728603931; c=relaxed/simple;
	bh=ho7nao2xPmktpHD7OEEo6s+MRd6lCw5Pr/HD1XtrfOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PzaSFhZONSCTZkwnqCBV55EjerMQbQEoNsWjWQAmpcwLj0r560GAl2ToeqQj1Wcb2tMnUnV2gHClEH2MAKHdWVZPFqf99Z3eY7UKIJiv94YOwMvFgeBr41tGV7O6OHX+aIpzo4COSlWMnKD2XUkZySwmc7r2Fo4lKXlTG04dNug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RA5Riigd; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1728603921;
	bh=ToZcgnbZ8v7eof9auRtT/Slo3MhgKvn3XM1vCWslblw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RA5RiigdYBT2fodE39/oNGDHLsvyZWKvCLJz1582UnsnOFdxjAqDBlD2vIC3TI+Y9
	 /2NaRgOm750UW87yok5DYxQvdFZf33b8HFY7iN3b6eTwHsswafzhsNxgvweCqycTsn
	 HUm1PR7+yzpdZGBkwmT64/zRP/MG//rzdIlJDb5/HbQAIUG8JRUtGzjU9AHdTGSeHG
	 JPSUrxm5Nudq3mWnYMlBaiMKwbeofFbQnvXMmv45SbfdcNtR8wX73LUjxPxCyFcY7x
	 6qoj11WE3H9fCGwKMZxtrwDR5G0RWcSUKDv03vqm2N2exy7TezBoYt1nxCd1QBJZWk
	 hvWIK40rsJEWQ==
Received: from [192.168.68.112] (ppp118-210-188-189.adl-adc-lon-bras34.tpg.internode.on.net [118.210.188.189])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5D0BC64998;
	Fri, 11 Oct 2024 07:45:19 +0800 (AWST)
Message-ID: <4d596ac9a2215be8510369c948e0b9680ee2fce3.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley
 <conor.dooley@microchip.com>,  Joel Stanley <joel@jms.id.au>, Conor Dooley
 <conor+dt@kernel.org>, linux-aspeed@lists.ozlabs.org
Date: Fri, 11 Oct 2024 10:15:17 +1030
In-Reply-To: <172857036038.1533242.5775916298170949713.robh@kernel.org>
References: <20241010112337.3840703-1-naresh.solanki@9elements.com>
	 <172857036038.1533242.5775916298170949713.robh@kernel.org>
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

On Thu, 2024-10-10 at 09:30 -0500, Rob Herring (Arm) wrote:
> On Thu, 10 Oct 2024 16:53:31 +0530, Naresh Solanki wrote:
> > Document the new compatibles used on IBM SBP1.
> >=20
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > Changes in V4:
> > - Retain Acked-by from v2.
> > - Fix alphabetic order
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
>=20
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
> New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ibm-sbp1.dtb'=
 for 20241010112337.3840703-1-naresh.solanki@9elements.com:
>=20

...

> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mux@77: interrupts: Fal=
se schema does not allow [[44, 4]]
> 	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu2@=
58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cp=
u2@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu1@=
58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cp=
u1@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu3@=
58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cp=
u3@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu0@=
58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cp=
u0@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#

These still must be addressed as mentioned on v3 (with more specific
comments regarding the infineon,ir38263 on v4). Please look through the
binding documents for the affected nodes and make sure the nodes in
your DTS conform to their definitions. You can check your work with
`make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ibm-sbp1.dtb` prior to sending.

It may help to base your series on top of [1] to reduce the volume of
output from CHECK_DTBS=3Dy.

Andrew

[1]: https://github.com/amboar/linux/tree/for/bmc/aspeed/dt


