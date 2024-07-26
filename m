Return-Path: <linux-kernel+bounces-262876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D5E93CE2D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028D51F23A51
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BE017335B;
	Fri, 26 Jul 2024 06:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CR1IKsu/"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBCB200C7;
	Fri, 26 Jul 2024 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721975513; cv=none; b=QMYsmKMeLKMlHCnw4w2z1GLGuJGKKfR08rpCKkQc0BP3w/mU0vHMBvyaZN+kfwkAgXp79qV9bxaWZfIGuqJaYUNcjweh5pAqzettcLEBkZFqH2I6I6WbSirLPAk7JcstoRkJ68E6qTvSA8MeU5vdzkTOcow8FhCHJJJkUU+RvqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721975513; c=relaxed/simple;
	bh=axhGOFdqqCBo8dDjNu2JRchxwLfhoR4uqBdBIO9ONGc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGQxL2y+xFm2/PoyKddcPetfxkcjqaEVGcKlOwbRp9G26CVF8Hjbs+apWmRwLGOX7PxgmkI7cudzxo+NepTHuxsgFaAif8Ztzt5RMTLzOmFvcaY9V/B+5ZBH37dLVLyj/gl/lhi/bdnH0gtOmqYpKyh1QNbBfI2G+ge+m3qyS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CR1IKsu/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1721975509;
	bh=earu/kNf/I1qFPh3Js71T6jdXWVx5Bck8YzltMtP5UQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CR1IKsu/ut3uUULW5zuaSarGS+UgcnV92ORPh6x6DWp1BClT/PPjryA4ljhPTzNnD
	 3Ni50/x1IUBJdQ2hpUCKd1AxkkcG4+oJeXyoROIP38xLiNTDjcbRv96q1Fw7UVc/uN
	 XbSAk6eFTxE7wjCXZmiyNmOklqV88O9/n3KINrIHs977o4I8rqpg9UgAFSsbRsRvze
	 YxDqK83kqInkLxJY67qmL4mz4pTyjwOvv42o2GiLV4LsNarOYsatV5jUtHyeJam92P
	 01RJkbzQJo5a0cUNEkgQFqLWXSFk0RMj78XsaQUeTKbl9iHrHhHjIm52gAFpS1Nenh
	 RKraWFtQXJyiA==
Received: from [192.168.68.112] (unknown [118.211.93.69])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7F9EB66AB4;
	Fri, 26 Jul 2024 14:31:48 +0800 (AWST)
Message-ID: <369ecaebb51307cee2c2f2c3a9c56fff3b235db8.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] ARM: dts: aspeed: Add IEISystems NF5280M7 BMC machine
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: George Liu <liuxiwei1013@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, openbmc@lists.ozlabs.org, 
 robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 joel@jms.id.au,  krzysztof.kozlowski+dt@linaro.org,
 linux-aspeed@lists.ozlabs.org,  conor+dt@kernel.org
Date: Fri, 26 Jul 2024 16:01:46 +0930
In-Reply-To: <172044909462.3146303.7635761790191924717.robh@kernel.org>
References: <20240708062316.208383-1-liuxiwei@ieisystem.com>
	 <172044909462.3146303.7635761790191924717.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi George,

On Mon, 2024-07-08 at 08:34 -0600, Rob Herring (Arm) wrote:
> On Mon, 08 Jul 2024 14:23:16 +0800, George Liu wrote:
> > The IEISystems NF5280M7 is an x86 platform server with an
> > AST2600-based BMC.
> > This dts file provides a basic configuration for its OpenBMC
> > development.
> >=20
> > Signed-off-by: George Liu <liuxiwei@ieisystem.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile             |   1 +
> >  .../aspeed/aspeed-bmc-ieisystems-nf5280m7.dts | 697 ++++++++++++++++++
> >  2 files changed, 698 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf52=
80m7.dts
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
> New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ieisystems-nf=
5280m7.dtb' for 20240708062316.208383-1-liuxiwei@ieisystem.com:
>=20
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts:169.3-16: War=
ning (reg_format): /ahb/apb/peci-controller@1e78b000/peci-client@30:reg: pr=
operty has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cells =
=3D=3D 1)
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts:174.3-16: War=
ning (reg_format): /ahb/apb/peci-controller@1e78b000/peci-client@31:reg: pr=
operty has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cells =
=3D=3D 1)
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: Warning (pci=
_device_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: Warning (pci=
_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: Warning (i2c=
_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: Warning (spi=
_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts:167.17-170.4:=
 Warning (avoid_default_addr_size): /ahb/apb/peci-controller@1e78b000/peci-=
client@30: Relying on default #address-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts:167.17-170.4:=
 Warning (avoid_default_addr_size): /ahb/apb/peci-controller@1e78b000/peci-=
client@30: Relying on default #size-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts:172.17-175.4:=
 Warning (avoid_default_addr_size): /ahb/apb/peci-controller@1e78b000/peci-=
client@31: Relying on default #address-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dts:172.17-175.4:=
 Warning (avoid_default_addr_size): /ahb/apb/peci-controller@1e78b000/peci-=
client@31: Relying on default #size-cells value
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /: compatibl=
e: 'oneOf' conditional failed, one must be fixed:
> 	'ieisystems,nf5280m7-bmc' is not one of ['delta,ahe50dc-bmc', 'facebook,=
galaxy100-bmc', 'facebook,wedge100-bmc', 'facebook,wedge40-bmc', 'microsoft=
,olympus-bmc', 'quanta,q71l-bmc', 'tyan,palmetto-bmc', 'yadro,vesnin-bmc']
> 	'ieisystems,nf5280m7-bmc' is not one of ['amd,daytonax-bmc', 'amd,ethano=
lx-bmc', 'ampere,mtjade-bmc', 'aspeed,ast2500-evb', 'asrock,e3c246d4i-bmc',=
 'asrock,e3c256d4i-bmc', 'asrock,romed8hm3-bmc', 'asrock,spc621d8hm3-bmc', =
'asrock,x570d4u-bmc', 'bytedance,g220a-bmc', 'facebook,cmm-bmc', 'facebook,=
minipack-bmc', 'facebook,tiogapass-bmc', 'facebook,yamp-bmc', 'facebook,yos=
emitev2-bmc', 'facebook,wedge400-bmc', 'hxt,stardragon4800-rep2-bmc', 'ibm,=
mihawk-bmc', 'ibm,mowgli-bmc', 'ibm,romulus-bmc', 'ibm,swift-bmc', 'ibm,wit=
herspoon-bmc', 'ingrasys,zaius-bmc', 'inspur,fp5280g2-bmc', 'inspur,nf5280m=
6-bmc', 'inspur,on5263m5-bmc', 'intel,s2600wf-bmc', 'inventec,lanyang-bmc',=
 'lenovo,hr630-bmc', 'lenovo,hr855xg2-bmc', 'portwell,neptune-bmc', 'qcom,c=
entriq2400-rep-bmc', 'supermicro,x11spi-bmc', 'tyan,s7106-bmc', 'tyan,s8036=
-bmc', 'yadro,nicole-bmc', 'yadro,vegman-n110-bmc', 'yadro,vegman-rx20-bmc'=
, 'yadro,vegman-sx20-bmc']
> 	'ieisystems,nf5280m7-bmc' is not one of ['ampere,mtmitchell-bmc', 'aspee=
d,ast2600-evb', 'aspeed,ast2600-evb-a1', 'asus,x4tf-bmc', 'facebook,bletchl=
ey-bmc', 'facebook,cloudripper-bmc', 'facebook,elbert-bmc', 'facebook,fuji-=
bmc', 'facebook,greatlakes-bmc', 'facebook,harma-bmc', 'facebook,minerva-cm=
c', 'facebook,yosemite4-bmc', 'ibm,blueridge-bmc', 'ibm,everest-bmc', 'ibm,=
fuji-bmc', 'ibm,rainier-bmc', 'ibm,system1-bmc', 'ibm,tacoma-bmc', 'invente=
c,starscream-bmc', 'inventec,transformer-bmc', 'jabil,rbp-bmc', 'qcom,dc-sc=
m-v1-bmc', 'quanta,s6q-bmc', 'ufispace,ncplite-bmc']
> 	'aspeed,ast2400' was expected
> 	'aspeed,ast2500' was expected
> 	from schema $id: http://devicetree.org/schemas/arm/aspeed/aspeed.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /: failed to=
 match any schema with compatible: ['ieisystems,nf5280m7-bmc', 'aspeed,ast2=
600']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: timer: 'cloc=
ks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml=
#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /sdram@1e6e0=
000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-eda=
c', 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: bus@1e600000=
: compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
> 	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.y=
aml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: ftgmac@1e660=
000: $nodename:0: 'ftgmac@1e660000' does not match '^ethernet(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: ftgmac@1e680=
000: $nodename:0: 'ftgmac@1e680000' does not match '^ethernet(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: ftgmac@1e670=
000: $nodename:0: 'ftgmac@1e670000' does not match '^ethernet(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: ftgmac@1e670=
000: Unevaluated properties are not allowed ('#address-cells', '#size-cells=
' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: ftgmac@1e690=
000: $nodename:0: 'ftgmac@1e690000' does not match '^ethernet(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: ftgmac@1e690=
000: Unevaluated properties are not allowed ('#address-cells', '#size-cells=
' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: syscon@1e6e2=
000: 'smp-memram@180' does not match any of the regexes: '^interrupt-contro=
ller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^si=
licon-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.ya=
ml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/sys=
con@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['=
aspeed,ast2600-smpmem']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/sys=
con@1e6e2000/interrupt-controller@560: failed to match any schema with comp=
atible: ['aspeed,ast2600-scu-ic0']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/sys=
con@1e6e2000/interrupt-controller@570: failed to match any schema with comp=
atible: ['aspeed,ast2600-scu-ic1']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/dis=
play@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600=
-gfx', 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/xdm=
a@1e6e7000: failed to match any schema with compatible: ['aspeed,ast2600-xd=
ma']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: adc@1e6e9000=
: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-ad=
c.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: adc@1e6e9100=
: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-ad=
c.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: crypto@1e6fa=
000: 'aspeed,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acr=
y.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/vid=
eo@1e700000: failed to match any schema with compatible: ['aspeed,ast2600-v=
ideo-engine']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/tim=
er@1e782000: failed to match any schema with compatible: ['aspeed,ast2600-t=
imer']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: peci-control=
ler@1e78b000: 'gpios', 'peci-client@30', 'peci-client@31' do not match any =
of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/peci/peci-aspeed.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/pec=
i-controller@1e78b000/peci-client@30: failed to match any schema with compa=
tible: ['intel,peci-client']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/pec=
i-controller@1e78b000/peci-client@31: failed to match any schema with compa=
tible: ['intel,peci-client']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: lpc@1e789000=
: lpc-snoop@80: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+=
'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: lpc@1e789000=
: reg-io-width: [[4]] is not of type 'object'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: kcs@24: 'clo=
cks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: kcs@28: 'clo=
cks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: kcs@2c: 'clo=
cks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: kcs@114: 'cl=
ocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/lpc=
@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2=
600-lhc']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/lpc=
@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast=
2600-ibt-bmc']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: sdc@1e740000=
: sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: sdc@1e740000=
: sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/sdc=
@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['asp=
eed,ast2600-sdhci', 'sdhci']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/sdc=
@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['asp=
eed,ast2600-sdhci', 'sdhci']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/bus=
@1e78a000/i2c@180/i2c-mux@70/i2c@2/temperature-sensor@4c: failed to match a=
ny schema with compatible: ['microchip,emc1413']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/bus=
@1e78a000/i2c@280/ipmb0@10: failed to match any schema with compatible: ['i=
pmb-dev']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: i2c-switch@7=
0: $nodename:0: 'i2c-switch@70' does not match '^(i2c-?)?mux'
> 	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: i2c-switch@7=
0: Unevaluated properties are not allowed ('#address-cells', '#size-cells',=
 'i2c@0', 'i2c@1', 'i2c@2', 'i2c@3', 'i2c@4', 'i2c@5', 'i2c@6', 'i2c@7' wer=
e unexpected)
> 	from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: i2c@400: Une=
valuated properties are not allowed ('#retries' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: pca9555@21: =
'#address-cells', '#size-cells' do not match any of the regexes: '^(hog-[0-=
9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: pca9555@22: =
'#address-cells', '#size-cells' do not match any of the regexes: '^(hog-[0-=
9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/fsi=
@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi=
-master', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/fsi=
@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi=
-master', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/fsi=
@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi=
-master', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/fsi=
@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi=
-master', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: /ahb/apb/dma=
-controller@1e79e000: failed to match any schema with compatible: ['aspeed,=
ast2600-udma']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: gpio-keys: '=
cpld' does not match any of the regexes: '^(button|event|key|switch|(button=
|event|key|switch)-[a-z0-9-]+|[a-z0-9-]+-(button|event|key|switch))$', 'pin=
ctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/input/gpio-keys.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ieisystems-nf5280m7.dtb: leds: 'fan-f=
ault', 'heartbeat', 'memory-fault', 'psu-fault', 'system-fault', 'system-ho=
t' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+=
'
> 	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#

Can you please try to address these issues where reasonable? For
instance, you need to at least resolve the error "'ieisystems,nf5280m7-
bmc' is not one of ...". Please also take a close look at the other
issues; I don't expect you to fix problems caused by the DTSIs, but
your DTS shouldn't add any of its own.

Andrew

