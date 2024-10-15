Return-Path: <linux-kernel+bounces-364903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D8999DACC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC5EB21F93
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2717D1F94A;
	Tue, 15 Oct 2024 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PiOv2Rv5"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5C4B5C1;
	Tue, 15 Oct 2024 00:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953074; cv=none; b=n+vYIQHC+3IM306Rocu/xF26Do+FtEA5qHtRkxGDV/HdySgKP/kHG48V6Ju6nZFzURLkwt7g7gYDEh0BO/BSA47lGl3YAJxKWI3t4qFsyUaaesRUDKSamYcFy9MyjRa0uBJXqdhK21VTqSCWtsJnGtw4kpk//P7F7zzakPQaN2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953074; c=relaxed/simple;
	bh=aaOkoglpjn8F6wIEeDrouknk6uZHXWOFgzj2wxj00GQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pTsAk/JPAJmaRLhnk3bufn22EEZmRx3T7BQSSsIJ+/FKBXeCCCWzNrOx17JOJ7fQVChHg+Uqab91gVbBOEXrhW/ZKGGoDkKn34Xn8pKwrEmO1E3ipM1MV+2gdsdPcWigQA8kmJfm1A0pvr1wFcVruWBB5Ezm9R41N+8wmJvJH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PiOv2Rv5; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1728953070;
	bh=2nnTU/ADEM4/VUxWefc0PONe2IBy5+5Jla7mbf0EfVs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PiOv2Rv5D4gz2LFQ1h7BrLF79+/3pHIZJ+tJ9BELKEx57hW33NeTxupy4Zch8v+jg
	 jwjE5z2HOStoVOfhe3YWxqNZz8A5gzBfWKlLw2THkfMIK9yGq94HOvEGsPn1JIs5Dl
	 NvymJ7DbZDry2bLNbBhpAnAboweXTFHT2yvSzydX6gqxSv927YB4S/NfosYcGKmhb4
	 o1lBI3qWsHSezjrDopLqLklQflemn37Y2NR7eMxSYhLxZhmoahwt6Ebp7bf+QVmpst
	 hF2S+ArVf6lGiBsjQAahRkhReJjQ6gUrmfJPBnM4UjqszbGa/g0LupdNDFY5A4TIIQ
	 Z+yYLAYSTiL6A==
Received: from [192.168.68.112] (203-173-0-39.dyn.iinet.net.au [203.173.0.39])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 75277649A0;
	Tue, 15 Oct 2024 08:44:29 +0800 (AWST)
Message-ID: <b5919d904c9f06a618a54d49bc895c3081a511e4.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Jefferson BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chanh Nguyen <chanh@os.amperecomputing.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Khanh Pham
 <khpham@amperecomputing.com>, linux-arm-kernel@lists.infradead.org, Thang
 Nguyen <thang@os.amperecomputing.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Phong Vo <phong@os.amperecomputing.com>, Conor Dooley
 <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, OpenBMC Maillist
 <openbmc@lists.ozlabs.org>, Open Source Submission
 <patches@amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>, 
 linux-aspeed@lists.ozlabs.org
Date: Tue, 15 Oct 2024 11:14:28 +1030
In-Reply-To: <172891445289.1127319.4114892374425336022.robh@kernel.org>
References: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
	 <172891445289.1127319.4114892374425336022.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Chanh,

On Mon, 2024-10-14 at 09:05 -0500, Rob Herring (Arm) wrote:
> On Mon, 14 Oct 2024 10:50:31 +0000, Chanh Nguyen wrote:
> > The Mt. Jefferson BMC is an ASPEED AST2600-based BMC for the Mt. Jeffer=
son
> > hardware reference platform with AmpereOne(TM)M processor.
> >=20
> > Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile             |   1 +
> >  .../aspeed/aspeed-bmc-ampere-mtjefferson.dts  | 646 ++++++++++++++++++
> >  2 files changed, 647 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjeffer=
son.dts
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
> New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ampere-mtjeff=
erson.dtb' for 20241014105031.1963079-1-chanh@os.amperecomputing.com:
>=20
> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /: compatible=
: 'oneOf' conditional failed, one must be fixed:
> 	'ampere,mtjefferson-bmc' is not one of ['delta,ahe50dc-bmc', 'facebook,g=
alaxy100-bmc', 'facebook,wedge100-bmc', 'facebook,wedge40-bmc', 'microsoft,=
olympus-bmc', 'quanta,q71l-bmc', 'tyan,palmetto-bmc', 'yadro,vesnin-bmc']
> 	'ampere,mtjefferson-bmc' is not one of ['amd,daytonax-bmc', 'amd,ethanol=
x-bmc', 'ampere,mtjade-bmc', 'aspeed,ast2500-evb', 'asrock,e3c246d4i-bmc', =
'asrock,e3c256d4i-bmc', 'asrock,romed8hm3-bmc', 'asrock,spc621d8hm3-bmc', '=
asrock,x570d4u-bmc', 'bytedance,g220a-bmc', 'facebook,cmm-bmc', 'facebook,m=
inipack-bmc', 'facebook,tiogapass-bmc', 'facebook,yamp-bmc', 'facebook,yose=
mitev2-bmc', 'facebook,wedge400-bmc', 'hxt,stardragon4800-rep2-bmc', 'ibm,m=
ihawk-bmc', 'ibm,mowgli-bmc', 'ibm,romulus-bmc', 'ibm,swift-bmc', 'ibm,with=
erspoon-bmc', 'ingrasys,zaius-bmc', 'inspur,fp5280g2-bmc', 'inspur,nf5280m6=
-bmc', 'inspur,on5263m5-bmc', 'intel,s2600wf-bmc', 'inventec,lanyang-bmc', =
'lenovo,hr630-bmc', 'lenovo,hr855xg2-bmc', 'portwell,neptune-bmc', 'qcom,ce=
ntriq2400-rep-bmc', 'supermicro,x11spi-bmc', 'tyan,s7106-bmc', 'tyan,s8036-=
bmc', 'yadro,nicole-bmc', 'yadro,vegman-n110-bmc', 'yadro,vegman-rx20-bmc',=
 'yadro,vegman-sx20-bmc']
> 	'ampere,mtjefferson-bmc' is not one of ['ampere,mtmitchell-bmc', 'aspeed=
,ast2600-evb', 'aspeed,ast2600-evb-a1', 'asus,x4tf-bmc', 'facebook,bletchle=
y-bmc', 'facebook,catalina-bmc', 'facebook,cloudripper-bmc', 'facebook,elbe=
rt-bmc', 'facebook,fuji-bmc', 'facebook,greatlakes-bmc', 'facebook,harma-bm=
c', 'facebook,minerva-cmc', 'facebook,yosemite4-bmc', 'ibm,blueridge-bmc', =
'ibm,everest-bmc', 'ibm,fuji-bmc', 'ibm,rainier-bmc', 'ibm,system1-bmc', 'i=
bm,tacoma-bmc', 'inventec,starscream-bmc', 'inventec,transformer-bmc', 'jab=
il,rbp-bmc', 'qcom,dc-scm-v1-bmc', 'quanta,s6q-bmc', 'ufispace,ncplite-bmc'=
]
> 	'aspeed,ast2400' was expected
> 	'aspeed,ast2500' was expected
> 	from schema $id: http://devicetree.org/schemas/arm/aspeed/aspeed.yaml#
>=20

This needs to be fixed as pointed out by Krzysztof.

*snip*

> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb/bus@=
1e78a000/i2c@180/i2c-mux@70/i2c@0/psu@58: failed to match any schema with c=
ompatible: ['pmbus']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: /ahb/apb/bus@=
1e78a000/i2c@180/i2c-mux@70/i2c@0/psu@59: failed to match any schema with c=
ompatible: ['pmbus']

These two should also be fixed. The compatible must describe the
physical device, not the communication/application protocol. It may be
necessary to add a binding if there's not one already for the device.

Andrew


