Return-Path: <linux-kernel+bounces-274152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26B947409
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33156B20F96
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A299413D628;
	Mon,  5 Aug 2024 03:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jKpbVW81"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8662225A2;
	Mon,  5 Aug 2024 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722830357; cv=none; b=pZLHmwJCz4w65tMacdZcKx53vCrOSVCVYHd7wKDzNtwsICL1Qsgwuo4cSlGiOdE2yIhR6Ll5yuRjmEPbLUIvl3dzZbfGiMYk7x2R6R15YG0u8A/cM+QGKkSZcSWnLOWxR1F78qPBT5/6u6e0URhtZsENRQGNEpFUhIpi73ZX7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722830357; c=relaxed/simple;
	bh=wgdaB2bhnoOqyQl6QOkmntchgFIwDpJXI8lOZaejdLU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LkYeGh5PfUS+UrgTAiDDx39a42rFEPyhWx3gdh63dEQq/x8Q2cfGq235uWy2XP18zjUi5Wi46Vk/8WtfiWofhOG5WI0j/Id9LMor2MfVfnZwzVqm3hJO3GCcaPtHh2ebsDlOraW9V48SOM0YIojkyYK8+GjMyi3lLEWPSf2slYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jKpbVW81; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722830352;
	bh=d7cqJ0kpF2PLR8wzbhUuvv4itxL+jcNpSGFs0wo8FIA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jKpbVW81a98xwODMB958yRYYc2dBMtGxp65ewCsq9fmeq0KgtqovpBqP4KfaMKAdv
	 1BwEGbS21AWmCKgGCMSze9Cu4pmaEHm0aVBYZEqKQSd1wfGo/2XQPPgnjK5By74MiK
	 xHD2kKHxDGxvGBxKkxx4+NgWk3DxSK0f50AhuDfjCluwiIsW7djpEL/71lTjLPyLIH
	 nPDZK1o362Jao7aqT515HrPpSsn2hKOcBpMyZ2lnSNPA0fathsmQTC//ZdRlGhC2FU
	 +5uu9Ff81V2w+8CFvEN9MEPldfc8bfgL0WSXBvM1jiWr2dbLjbFF2NEXigC8Xh39Ey
	 Ml5qVM+lUXbNQ==
Received: from [192.168.68.112] (ppp14-2-105-65.adl-apt-pir-bras32.tpg.internode.on.net [14.2.105.65])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BCAD465665;
	Mon,  5 Aug 2024 11:59:10 +0800 (AWST)
Message-ID: <6171be101ee10aa2a11e021caafe877eb428412a.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/6] Update the device tree for Ampere's BMC platform
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>, "Rob Herring (Arm)"
	 <robh@kernel.org>, Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>, OpenBMC
 Maillist <openbmc@lists.ozlabs.org>, Thang Nguyen
 <thang@os.amperecomputing.com>,  linux-kernel@vger.kernel.org, Phong Vo
 <phong@os.amperecomputing.com>, Rob Herring <robh+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Open Source Submission
 <patches@amperecomputing.com>, linux-arm-kernel@lists.infradead.org, Quan
 Nguyen <quan@os.amperecomputing.com>
Date: Mon, 05 Aug 2024 13:29:09 +0930
In-Reply-To: <1c2dca43-444d-44a7-b304-5fbd59b788a8@amperemail.onmicrosoft.com>
References: <20240801091217.1408809-1-chanh@os.amperecomputing.com>
	 <172252600912.120761.16384387883905749466.robh@kernel.org>
	 <1c2dca43-444d-44a7-b304-5fbd59b788a8@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-08-03 at 10:49 +0700, Chanh Nguyen wrote:
>=20
> On 01/08/2024 22:29, Rob Herring (Arm) wrote:
> >=20
> > On Thu, 01 Aug 2024 09:12:10 +0000, Chanh Nguyen wrote:
> > > Updates the device tree to support some features on Ampere's
> > > Mt.Mitchell BMC and Ampere's Mt.Jade BMC.
> > >=20
> > > Chanh Nguyen (6):
> > >    ARM: dts: aspeed: mtjade, mtmitchell: Add OCP temperature sensors
> > >    ARM: dts: aspeed: mtmitchell: Add I2C temperature sensor alias por=
ts
> > >    ARM: dts: aspeed: mtmitchell: Add I2C Riser card alias ports
> > >    ARM: dts: aspeed: mtmitchell: Enable i2c10 and i2c15
> > >    ARM: dts: aspeed: mtmitchell: Add LEDs
> > >    ARM: dts: aspeed: mtmitchell: Add I2C FAN controllers
> > >=20
> > >   .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  16 ++
> > >   .../aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 152 +++++++++++++++=
+++
> > >   2 files changed, 168 insertions(+)
> > >=20
> > > --
> > > 2.43.0
> > >=20
> > >=20
> > >=20
> >=20
> >=20
> > My bot found new DTB warnings on the .dts files added or changed in thi=
s
> > series.
> >=20
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the warning=
s
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to rep=
ly
> > unless the platform maintainer has comments.
> >=20
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> >=20
> >    pip3 install dtschema --upgrade
> >=20
> >=20
> > New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ampere-mtja=
de.dtb aspeed/aspeed-bmc-ampere-mtmitchell.dtb' for 20240801091217.1408809-=
1-chanh@os.amperecomputing.com:
> >=20
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: /ahb/apb/bus=
@1e78a000/i2c@480/fan-controller0@20: failed to match any schema with compa=
tible: ['maxim,max31790']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: /ahb/apb/bus=
@1e78a000/i2c@480/fan-controller1@2f: failed to match any schema with compa=
tible: ['maxim,max31790']
> >=20
> >=20
>=20
> Thank Rob for your review!
>=20
> I am aware of the new warnings you mentioned. For more information, the=
=20
> schema binding of "maxim,max31790" is being progressed by other series=C2=
=A0=20
> https://lore.kernel.org/lkml/20240414042246.8681-2-chanh@os.amperecomputi=
ng.com/=20
>=20

For now can you please remove the `maxim,max31790` nodes from your
devicetree and re-send? As it stands you've been asked to rework what
you proposed in the thread that you linked, and a quick look at the
hwmon trees suggests support for the max31790 hasn't been merged.

You can send a follow-up patch adding the nodes to your devicetree once
the binding has been merged.

Andrew

