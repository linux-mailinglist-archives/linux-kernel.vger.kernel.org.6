Return-Path: <linux-kernel+bounces-343296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0A9989944
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5981F218A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33CB1F957;
	Mon, 30 Sep 2024 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="T0R8omgC"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2412904;
	Mon, 30 Sep 2024 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727663803; cv=none; b=mVtQ0Ca4jyjB6U0g6gcUmH0mNum7z+NyzwRwl6FD7BfowexR/cZ7u7dL1a/LCOiITHjyZy3qSKZZnYlUNWnUPgFpybn+OYkOQNTxR0kbrCZUIGQZUsLClNumhWcx5kCOhlY5uO2v9zzDCMtdD1E23uAJsk5zRhYz3BMEI7q8EcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727663803; c=relaxed/simple;
	bh=hEHgXjiUW3RbX6sCTRaIwuFsgk4/FwzgI00+DpIiFF0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KmswOwIkGsDBY4sa1PbVTApxy5oE/OAIdoXVapmTtZlet0aQ3oVLW0JBEuG/LLRZaunY0t5UuaKUisbpMHtDke2Us2cATw6EMe66+gwSkL/2L6eyIhoVBnz8NuB3yh5yqxcN2/RAY2XbiyK95smsdz6j0eDR2fb/Tkst6Zx3ADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=T0R8omgC; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727663798;
	bh=6poyunsspmaVm43bgUWJe5BKtQ8nrMQqrGb7DxulcwM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T0R8omgCdo6X05+Z5/ziiLtzO6hzYL4anPHmGoTtQqB+KNRbkoEFBN3mORtaiBezr
	 2xcFE+5WY2gHiK4/IwZGXokX0+7WfXHBW8kjNwzE0lEPYl5TvHre02z922JDlUxtH5
	 Y9qicWUqrLHIO7UlQqOQar1bFGeI6LmjIsF1fVp7XfcunirvMMafAZi9tpnX6ARGZ2
	 8By4rwiAPzHbLS50JMtvSuWrWJOB4mWooFJ7G4GTD/zzwCSSkAhF42k3JsI1aR7JGw
	 YTzjcS8mCmokTPdDca1AXMVIkfl4lBzXV/tSERWWrOtESdxL4ZFWDhQZYtdygGJ6+x
	 t2PNFmDzSdssQ==
Received: from [192.168.105.88] (unknown [120.20.51.218])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 56B7365013;
	Mon, 30 Sep 2024 10:36:35 +0800 (AWST)
Message-ID: <ef0e0be6cbdcf410ca7854884f32da0e3cf6b295.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD
 IOE on Spider Board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>, Patrick
	Williams <patrick@stwcx.xyz>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ricky
 CX Wu <ricky.cx.wu.wiwynn@gmail.com>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Mon, 30 Sep 2024 12:06:34 +0930
In-Reply-To: <TYZPR04MB5853A70A99CEDE8EB64A317DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
	 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
	 <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <Zvdq7o6NFXRVCJqX@heinlein.vulture-banana.ts.net>
	 <16c89a7b9b85d21f1f23aa0d67742c6bde94a295.camel@codeconstruct.com.au>
	 <TYZPR04MB5853A70A99CEDE8EB64A317DD6762@TYZPR04MB5853.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 01:47 +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
>=20
> > -----Original Message-----
> > From: Andrew Jeffery <andrew@codeconstruct.com.au>
> > Sent: Monday, September 30, 2024 7:44 AM
> > To: Patrick Williams <patrick@stwcx.xyz>; Delphine_CC_Chiu/WYHQ/Wiwynn
> > <Delphine_CC_Chiu@wiwynn.com>
> > Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.=
org>;
> > Conor Dooley <conor+dt@kernel.org>; Joel Stanley <joel@jms.id.au>; Rick=
y CX
> > Wu <ricky.cx.wu.wiwynn@gmail.com>; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CP=
LD
> > IOE on Spider Board
> >=20
> >  [External Sender]
> >=20
> >  [External Sender]
> >=20
> > Hi Ricky, Patrick,
> >=20
> > On Fri, 2024-09-27 at 22:33 -0400, Patrick Williams wrote:
> > > On Fri, Sep 27, 2024 at 09:24:11AM +0000,
> > Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
> > >=20
> > > > Would like to ask should I base on the openbmc/linux repo to create
> > > > the remaining patches that have context dependencies and add the
> > > > lore link of the those patches that I've sent in the cover letter?
> > >=20
> > > I believe you're trying to get the patches applied onto the upstream
> > > tree, so no you should not base on the openbmc/linux repo.  That repo
> > > is a 6.6 branch.  You need to base the commits on torvalds/linux.
> > >=20
> >=20
> > In my previous email[1] I requested:
> >=20
> > > Please assess the remaining yosemite4 devicetree patches (those you
> > > haven't received a thank-you email for) and send an appropriately
> > > constructed series so they can all be applied together, based on the
> > > tree here:
> > >=20
> > > https://urldefense.com/v3/__https://github.com/amboar/linux/tree/for/=
b
> > >=20
> > mc/dt__;!!J63qqgXj!N56Dq0KcUR0NerePsoY0JUBCDvFG_F3KyRF0D4qNdu_Ozc
> > SGVPC
> > > SBOJk6u28AWPfgDRWsLE1B__-_ZNVKYv-zhc_6PY$
> >=20
> > So I'm not sure why there's confusion and speculation as to which tree =
should
> > be used :( Note that the for/bmc/dt branch above is currently based on
> > v6.12-rc1.
> >=20
> > [1]:
> > https://urldefense.com/v3/__https://lore.kernel.org/all/fbdc9efe87a1bed=
9fea7
> > d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au/__;!!J63qqgXj!N56Dq0
> > KcUR0NerePsoY0JUBCDvFG_F3KyRF0D4qNdu_OzcSGVPCSBOJk6u28AWPfgDRW
> > sLE1B__-_ZNVKYv-uNCc7qE$
> >=20
> > Anyway, I asked that because I have already applied one of the
> > Yosemite4 patches there, and developing the remaining patches against a=
ny
> > other tree will again cause conflicts (due to the lack of that patch).
> >=20
> > More broadly though, Patrick is right: If you're sending your patches u=
pstream,
> > it is required that you develop and test your patches against an approp=
riate
> > upstream tree. Usually this is the most recent -rc1 tag, unless there a=
re reasons
> > otherwise (such as conflicts). The OpenBMC kernel fork is not an approp=
riate
> > tree on which to base work you intend to send upstream.
> >=20
> > Thanks,
> >=20
> > Andrew
>=20
> Hi Andrew,
>=20
> Sorry for my misunderstanding.

No worries, hopefully we can get it sorted out. I realise the sentiment
of my responses below is quite direct, but I'm trying to cut through
the confusion. Please bear with me.

> So I should combine the remaining yosemite4 device tree patches as a sing=
le serial
>=20

Specifically, any patches that have dependencies on each other. In this
case, patches that share diff context need to be in a single series so
they don't generate conflicts when I try to apply them.

>  based on torvalds/linux
>=20

No. In _this specific instance_, please base the series on

https://github.com/amboar/linux/tree/for/bmc/dt

If you look, you will find this is itself already based on v6.12-rc1,
and contains ASPEED devicetree patches both yourself and others have
sent that are intended to appear in v6.13.

I need you to do this because I've _already_ applied one yosemite4
patch there which is generating conflicts with your other yosemite4
patches.

_However_, in almost all other cases, you should base your series on
the latest -rc1.

>  and test on openbmc/linux
>=20

No. If you're sending the patches upstream you must test them as
applied to the relevant upstream tree. In _this_ case, it's the
for/bmc/dt branch I've linked above.

>  then send the serial patches to torvalds/linux.

You send them to the lists as you have done here, yes.

> And you will help to fix the conflicts
>=20

No. I'm asking you to fix the conflicts that your patches are
generating. I don't want to be in the business of resolving other
people's conflicts and risking incorrect results. The conflict
resolutions should be tested to the usual expectations.

>  when you apply the serial patches to openbmc/linux.

I'm doing two separate-but-related roles:

1. Upstream patch collector for BMC-related devicetrees
2. OpenBMC kernel janitor

The first role is how I'm interacting with you in this thread. At the
moment I'm helping Joel out: recently he's been taking the patches I've
collected in the for/bmc/dt branch I linked above and has sent a PR to
Arnd for integration into torvalds/linux via the SoC tree.

However, in the process of collecting your patches in role 1 I also
happen to switch to role 2, where I backport your upstream patches to
OpenBMC's v6.6-based (LTS) tree _if_ applying the patch/series directly
to that tree does not cause conflicts. If there are conflicts, then I
expect you to also send a backport patch that accounts for the
conflicts to _only_ the openbmc list (and not the upstream lists and
maintainers also on Cc here).

So in neither case should you expect me to be resolving conflicts for
you. The resolution still needs testing as noted above, and I'm rarely
in a position to do that myself.

I hope that helps.

Andrew

