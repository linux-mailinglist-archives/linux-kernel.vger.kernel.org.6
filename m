Return-Path: <linux-kernel+bounces-262832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4593CD7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD16282C71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1938D2EAE5;
	Fri, 26 Jul 2024 05:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="WjWE0aae"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36E21105;
	Fri, 26 Jul 2024 05:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721970709; cv=none; b=YQDmy08aCT/yksNphfZ1wRh2kZLhLxmx5rdZPBNJQcOdROqrZBJbMsfDkdL2BEQ44JU3luQHha+bZPyPtj4vgBtqX7jb5KshjX1Zo02uK2zoT8P5lJhgaWCmigwETElB6umWQGrfDh/6Zbz9bIQ0Ia0YUsbLVbn0l34wulFMrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721970709; c=relaxed/simple;
	bh=VnlhOyMN7isNGybuNMjGph4Vr/DQpZpPEPOirnRHIkg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QUOVVFpDCus+iv+hX14BKaXdBzM7ZYr/pUwdlCKDoYct+cbE1OIBfzkxPNifna7vgeKTkJkkSpBX20g2U/xDZo9raDh0lB3uA6upNSgo4JAjg7xDUEX07EWquADEYRVPh3IJFo83/4ioIgcwn/Qwz78qMxpEnZJpjQ67Aes5jZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WjWE0aae; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1721970695;
	bh=FaRE+rqSSpb9U9tDQq/GY9jw2umkKNfuVwS9bYRdjDE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WjWE0aaePaceRdxPOoDlcIjIZpCI1Wo8ErprzxC3E5a4mzUh/1ABNYBR+N3vkS1U2
	 eUsFe9em1nFnrSQg9B4CjSc5rUwmZ7oFrZ5u3a2xMZ35Kft558CQf3VtoPRz2MRVxk
	 oQLAYkNPo7BcgDkxilBT1BbvLKTO4R9jDUFBajiscZCWE331zIGiDfFA+c3g9mdRFG
	 JC4WNQwbLVTxKu7BNW4kiTEHPI8toDED5yQStxqT88L9sPj9GomCThqQHmQjina/ym
	 FNHrXPWaTMiDLBIjzG8e3bgxpjqimmMq606Hf2nSbrmxnGQlZVFdGGTJLUWGESg039
	 rklSRPUxsQ5aQ==
Received: from [192.168.68.112] (unknown [118.211.93.69])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 748D866AB4;
	Fri, 26 Jul 2024 13:11:32 +0800 (AWST)
Message-ID: <64131f6cd5ca03bb9cb52b6caa6a4416b825241b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Patrick Williams
 <patrick@stwcx.xyz>,  Cosmo Chou <cosmo.chou@quantatw.com>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor.dooley@microchip.com>, Joel
 Stanley <joel@jms.id.au>, Potin Lai <potin.lai@quantatw.com>, 
 devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Date: Fri, 26 Jul 2024 14:41:30 +0930
In-Reply-To: <172194566710.4001436.1410948302471443496.robh@kernel.org>
References: <20240725-potin-catalina-dts-v4-0-aa6f235a2e78@gmail.com>
	 <172194566710.4001436.1410948302471443496.robh@kernel.org>
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

On Thu, 2024-07-25 at 17:20 -0500, Rob Herring (Arm) wrote:
> On Thu, 25 Jul 2024 00:48:16 +0800, Potin Lai wrote:
> > Add Linux device tree entry related to Meta(Facebook) Catalina specific
> > devices connected to BMC(AST2600) SoC.
> >=20
> > Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> > ---
> > Changes in v4:
> > - change back io_expanderX due to parser error, build passed in v4 vers=
ion.
> > - Link to v3: https://lore.kernel.org/r/20240725-potin-catalina-dts-v3-=
0-3a5b5d9e6dbc@gmail.com
> >=20
> > Changes in v3:
> > - rename tmp75 nodes to temperature-sensor
> > - rename tmp421 nodes to temperature-sensor
> > - rename ina230 nodes to power-sensor
> > - rename io_expanderX nodes to io-expanderX
> > - Link to v2: https://lore.kernel.org/r/20240724-potin-catalina-dts-v2-=
0-ba8d475c4073@gmail.com
> >=20
> > Changes in v2:
> > - drop commented code in dts
> > - rename i2c-mux channel nodes as i2c1muxXchY
> > - rename gpio expander as io_expanderX
> > - use "stdout-path" instead of "bootargs"
> > - Link to v1: https://lore.kernel.org/all/20240722145857.2131100-1-poti=
n.lai.pt@gmail.com/
> >=20
> > ---
> > Potin Lai (2):
> >       dt-bindings: arm: aspeed: add Meta Catalina board
> >       ARM: dts: aspeed: catalina: add Meta Catalina BMC
> >=20
> >  .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
> >  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
> >  .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 1020 ++++++++++++=
++++++++
> >  3 files changed, 1022 insertions(+)
> > ---
> > base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> > change-id: 20240724-potin-catalina-dts-fda1ea3297b1
> >=20
> > Best regards,
> > --
> > Potin Lai <potin.lai.pt@gmail.com>
> >=20
> >=20
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
> New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-cata=
lina.dtb' for 20240725-potin-catalina-dts-v4-0-aa6f235a2e78@gmail.com:
>=20
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /: spi1-gpio: =
{'compatible': ['spi-gpio'], '#address-cells': 1, '#size-cells': 0, 'gpio-s=
ck': [44, 203, 0], 'gpio-mosi': [44, 204, 0], 'gpio-miso': [44, 205, 0], 'n=
um-chipselects': 1, 'cs-gpios': [[44, 200, 1]], 'tpm@0': {'compatible': ['i=
nfineon,slb9670', 'tcg,tpm_tis-spi'], 'spi-max-frequency': 33000000, 'reg':=
 [[0]]}} is not of type 'array'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: timer: 'clocks=
' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml=
#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /sdram@1e6e000=
0: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac'=
, 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: bus@1e600000: =
compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
> 	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.y=
aml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac@1e66000=
0: $nodename:0: 'ftgmac@1e660000' does not match '^ethernet(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac@1e68000=
0: $nodename:0: 'ftgmac@1e680000' does not match '^ethernet(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac@1e67000=
0: $nodename:0: 'ftgmac@1e670000' does not match '^ethernet(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac@1e69000=
0: $nodename:0: 'ftgmac@1e690000' does not match '^ethernet(@.*)?$'
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac@1e69000=
0: Unevaluated properties are not allowed ('#address-cells', '#size-cells',=
 'ncsi-ctrl,start-redo-probe', 'ncsi-package' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yam=
l#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ftgmac@1e69000=
0: 'ncsi-ctrl,start-redo-probe' does not match any of the regexes: '^#.*', =
'^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpmc|hdm=
i|i2c-gpio),.*', '^(keypad|m25p|max8952|max8997|max8998|mpmc),.*', '^(pinct=
rl-single|#pinctrl-single|PowerPC),.*', '^(pl022|pxa-mmc|rcar_sound|rotary-=
encoder|s5m8767|sdhci),.*', '^(simple-audio-card|st-plgpio|st-spics|ts),.*'=
, '^100ask,.*', '^70mai,.*', '^8dev,.*', '^GEFanuc,.*', '^IBM,.*', '^ORCL,.=
*', '^SUNW,.*', '^[a-zA-Z0-9#_][a-zA-Z0-9+\-._@]{0,63}$', '^[a-zA-Z0-9+\-._=
]*@[0-9a-zA-Z,]*$', '^abb,.*', '^abilis,.*', '^abracon,.*', '^abt,.*', '^ac=
bel,.*', '^acelink,.*', '^acer,.*', '^acme,.*', '^actions,.*', '^active-sem=
i,.*', '^ad,.*', '^adafruit,.*', '^adapteva,.*', '^adaptrum,.*', '^adh,.*',=
 '^adi,.*', '^adieng,.*', '^admatec,.*', '^advantech,.*', '^aeroflexgaisler=
,.*', '^aesop,.*', '^airoha,.*', '^al,.*', '^alcatel,.*', '^aldec,.*', '^al=
fa-network,.*', '^allegro
>  ,.*', '^alliedvision,.*', '^allo,.*', '^allwinner,.*', '^alphascale,.*',=
 '^alps,.*', '^alt,.*', '^altr,.*', '^amarula,.*', '^amazon,.*', '^amcc,.*'=
, '^amd,.*', '^amediatech,.*', '^amlogic,.*', '^ampere,.*', '^amphenol,.*',=
 '^ampire,.*', '^ams,.*', '^amstaos,.*', '^analogix,.*', '^anbernic,.*', '^=
andestech,.*', '^anvo,.*', '^aosong,.*', '^apm,.*', '^apple,.*', '^aptina,.=
*', '^arasan,.*', '^archermind,.*', '^arcom,.*', '^arctic,.*', '^arcx,.*', =
'^aries,.*', '^arm,.*', '^armadeus,.*', '^armsom,.*', '^arrow,.*', '^artesy=
n,.*', '^asahi-kasei,.*', '^asc,.*', '^asix,.*', '^aspeed,.*', '^asrock,.*'=
, '^asteralabs,.*', '^asus,.*', '^atheros,.*', '^atlas,.*', '^atmel,.*', '^=
auo,.*', '^auvidea,.*', '^avago,.*', '^avia,.*', '^avic,.*', '^avnet,.*', '=
^awinic,.*', '^axentia,.*', '^axis,.*', '^azoteq,.*', '^azw,.*', '^baikal,.=
*', '^bananapi,.*', '^beacon,.*', '^beagle,.*', '^belling,.*', '^bhf,.*', '=
^bigtreetech,.*', '^bitmain,.*', '^blutek,.*', '^boe,.*', '^bosch,.*', '^bo=
undary,.*', '^brcm,.*', '
>  ^broadmobi,.*', '^bsh,.*', '^bticino,.*', '^buffalo,.*', '^bur,.*', '^by=
tedance,.*', '^calamp,.*', '^calao,.*', '^calaosystems,.*', '^calxeda,.*', =
'^cameo,.*', '^canaan,.*', '^caninos,.*', '^capella,.*', '^cascoda,.*', '^c=
atalyst,.*', '^cavium,.*', '^cct,.*', '^cdns,.*', '^cdtech,.*', '^cellwise,=
.*', '^ceva,.*', '^chargebyte,.*', '^checkpoint,.*', '^chefree,.*', '^chipi=
dea,.*', '^chipone,.*', '^chipspark,.*', '^chongzhou,.*', '^chrontel,.*', '=
^chrp,.*', '^chunghwa,.*', '^chuwi,.*', '^ciaa,.*', '^cirrus,.*', '^cisco,.=
*', '^clockwork,.*', '^cloos,.*', '^cloudengines,.*', '^cnm,.*', '^cnxt,.*'=
, '^colorfly,.*', '^compulab,.*', '^congatec,.*', '^coolpi,.*', '^coreriver=
,.*', '^corpro,.*', '^cortina,.*', '^cosmic,.*', '^crane,.*', '^creative,.*=
', '^crystalfontz,.*', '^csky,.*', '^csq,.*', '^ctera,.*', '^ctu,.*', '^cub=
ietech,.*', '^cudy,.*', '^cui,.*', '^cypress,.*', '^cyx,.*', '^cznic,.*', '=
^dallas,.*', '^dataimage,.*', '^davicom,.*', '^dell,.*', '^delta,.*', '^den=
sitron,.*', '^denx,.*', '
>  ^devantech,.*', '^dfi,.*', '^dh,.*', '^difrnce,.*', '^digi,.*', '^digile=
nt,.*', '^dimonoff,.*', '^diodes,.*', '^dioo,.*', '^dlc,.*', '^dlg,.*', '^d=
link,.*', '^dmo,.*', '^domintech,.*', '^dongwoon,.*', '^dptechnics,.*', '^d=
ragino,.*', '^dream,.*', '^ds,.*', '^dserve,.*', '^dynaimage,.*', '^ea,.*',=
 '^ebang,.*', '^ebbg,.*', '^ebs-systart,.*', '^ebv,.*', '^eckelmann,.*', '^=
edgeble,.*', '^edimax,.*', '^edt,.*', '^ees,.*', '^eeti,.*', '^einfochips,.=
*', '^eink,.*', '^elan,.*', '^element14,.*', '^elgin,.*', '^elida,.*', '^el=
imo,.*', '^elpida,.*', '^embedfire,.*', '^embest,.*', '^emcraft,.*', '^emli=
d,.*', '^emmicro,.*', '^empire-electronix,.*', '^emtrion,.*', '^enclustra,.=
*', '^endless,.*', '^ene,.*', '^energymicro,.*', '^engicam,.*', '^engleder,=
.*', '^epcos,.*', '^epfl,.*', '^epson,.*', '^esp,.*', '^est,.*', '^ettus,.*=
', '^eukrea,.*', '^everest,.*', '^everspin,.*', '^evervision,.*', '^exar,.*=
', '^excito,.*', '^exegin,.*', '^ezchip,.*', '^facebook,.*', '^fairchild,.*=
', '^fairphone,.*', '^far
>  aday,.*', '^fascontek,.*', '^fastrax,.*', '^fcs,.*', '^feixin,.*', '^fei=
yang,.*', '^fii,.*', '^firefly,.*', '^focaltech,.*', '^forlinx,.*', '^freeb=
ox,.*', '^freecom,.*', '^frida,.*', '^friendlyarm,.*', '^fsl,.*', '^fujitsu=
,.*', '^fxtec,.*', '^galaxycore,.*', '^gameforce,.*', '^gardena,.*', '^gate=
way,.*', '^gateworks,.*', '^gcw,.*', '^ge,.*', '^geekbuying,.*', '^gef,.*',=
 '^gemei,.*', '^gemtek,.*', '^genesys,.*', '^geniatech,.*', '^giantec,.*', =
'^giantplus,.*', '^glinet,.*', '^globalscale,.*', '^globaltop,.*', '^gmt,.*=
', '^goldelico,.*', '^goodix,.*', '^google,.*', '^goramo,.*', '^gplus,.*', =
'^grinn,.*', '^grmn,.*', '^gumstix,.*', '^gw,.*', '^hannstar,.*', '^haochua=
ngyi,.*', '^haoyu,.*', '^hardkernel,.*', '^hechuang,.*', '^hideep,.*', '^hi=
max,.*', '^hirschmann,.*', '^hisi,.*', '^hisilicon,.*', '^hit,.*', '^hitex,=
.*', '^holt,.*', '^holtek,.*', '^honestar,.*', '^honeywell,.*', '^hoperf,.*=
', '^hoperun,.*', '^hp,.*', '^hpe,.*', '^hsg,.*', '^htc,.*', '^huawei,.*', =
'^hugsun,.*', '^hwacom,.*
>  ', '^hxt,.*', '^hycon,.*', '^hydis,.*', '^hynitron,.*', '^hynix,.*', '^h=
yundai,.*', '^i2se,.*', '^ibm,.*', '^icplus,.*', '^idt,.*', '^iei,.*', '^if=
i,.*', '^ilitek,.*', '^imagis,.*', '^img,.*', '^imi,.*', '^inanbo,.*', '^in=
circuit,.*', '^indiedroid,.*', '^inet-tek,.*', '^infineon,.*', '^inforce,.*=
', '^ingenic,.*', '^ingrasys,.*', '^injoinic,.*', '^innocomm,.*', '^innolux=
,.*', '^inside-secure,.*', '^insignal,.*', '^inspur,.*', '^intel,.*', '^int=
ercontrol,.*', '^invensense,.*', '^inventec,.*', '^inversepath,.*', '^iom,.=
*', '^irondevice,.*', '^isee,.*', '^isil,.*', '^issi,.*', '^ite,.*', '^itea=
d,.*', '^itian,.*', '^ivo,.*', '^iwave,.*', '^jadard,.*', '^jasonic,.*', '^=
jdi,.*', '^jedec,.*', '^jesurun,.*', '^jethome,.*', '^jianda,.*', '^jide,.*=
', '^joz,.*', '^kam,.*', '^karo,.*', '^keithkoep,.*', '^keymile,.*', '^khad=
as,.*', '^kiebackpeter,.*', '^kinetic,.*', '^kingdisplay,.*', '^kingnovel,.=
*', '^kionix,.*', '^kobo,.*', '^kobol,.*', '^koe,.*', '^kontron,.*', '^kosa=
gi,.*', '^kvg,.*', '^kyo,
>  .*', '^lacie,.*', '^laird,.*', '^lamobo,.*', '^lantiq,.*', '^lattice,.*'=
, '^lctech,.*', '^leadtek,.*', '^leez,.*', '^lego,.*', '^lemaker,.*', '^len=
ovo,.*', '^lg,.*', '^lgphilips,.*', '^libretech,.*', '^licheepi,.*', '^lina=
ro,.*', '^lincolntech,.*', '^lineartechnology,.*', '^linksprite,.*', '^link=
sys,.*', '^linutronix,.*', '^linux,.*', '^linx,.*', '^liteon,.*', '^litex,.=
*', '^lltc,.*', '^logicpd,.*', '^logictechno,.*', '^longcheer,.*', '^lontiu=
m,.*', '^loongmasses,.*', '^loongson,.*', '^lsi,.*', '^lunzn,.*', '^luxul,.=
*', '^lwn,.*', '^lxa,.*', '^m5stack,.*', '^macnica,.*', '^mantix,.*', '^map=
leboard,.*', '^marantec,.*', '^marvell,.*', '^maxbotix,.*', '^maxim,.*', '^=
maxlinear,.*', '^mbvl,.*', '^mcube,.*', '^meas,.*', '^mecer,.*', '^mediatek=
,.*', '^megachips,.*', '^mele,.*', '^melexis,.*', '^melfas,.*', '^mellanox,=
.*', '^memsensing,.*', '^memsic,.*', '^menlo,.*', '^mentor,.*', '^meraki,.*=
', '^merrii,.*', '^methode,.*', '^micrel,.*', '^microchip,.*', '^microcryst=
al,.*', '^micron,.*', '^m
>  icrosoft,.*', '^microsys,.*', '^microtips,.*', '^mikroe,.*', '^mikrotik,=
.*', '^milkv,.*', '^miniand,.*', '^minix,.*', '^mips,.*', '^miramems,.*', '=
^mitsubishi,.*', '^mitsumi,.*', '^mixel,.*', '^miyoo,.*', '^mntre,.*', '^mo=
bileye,.*', '^modtronix,.*', '^moortec,.*', '^mosaixtech,.*', '^motorcomm,.=
*', '^motorola,.*', '^moxa,.*', '^mpl,.*', '^mps,.*', '^mqmaker,.*', '^mrvl=
,.*', '^mscc,.*', '^msi,.*', '^mstar,.*', '^mti,.*', '^multi-inno,.*', '^mu=
ndoreader,.*', '^murata,.*', '^mxic,.*', '^mxicy,.*', '^myir,.*', '^nationa=
l,.*', '^neardi,.*', '^nec,.*', '^neonode,.*', '^netgear,.*', '^netlogic,.*=
', '^netron-dy,.*', '^netronix,.*', '^netxeon,.*', '^neweast,.*', '^newhave=
n,.*', '^newvision,.*', '^nexbox,.*', '^nextthing,.*', '^ni,.*', '^nintendo=
,.*', '^nlt,.*', '^nokia,.*', '^nordic,.*', '^novatek,.*', '^novtech,.*', '=
^numonyx,.*', '^nutsboard,.*', '^nuvoton,.*', '^nvd,.*', '^nvidia,.*', '^nx=
p,.*', '^oceanic,.*', '^ocs,.*', '^oct,.*', '^okaya,.*', '^oki,.*', '^olime=
x,.*', '^olpc,.*', '^onep
>  lus,.*', '^onie,.*', '^onion,.*', '^onnn,.*', '^ontat,.*', '^opalkelly,.=
*', '^openailab,.*', '^opencores,.*', '^openembed,.*', '^openpandora,.*', '=
^openrisc,.*', '^openwrt,.*', '^option,.*', '^oranth,.*', '^orisetech,.*', =
'^ortustech,.*', '^osddisplays,.*', '^osmc,.*', '^ouya,.*', '^overkiz,.*', =
'^ovti,.*', '^oxsemi,.*', '^ozzmaker,.*', '^panasonic,.*', '^parade,.*', '^=
parallax,.*', '^pda,.*', '^pericom,.*', '^pervasive,.*', '^phicomm,.*', '^p=
hytec,.*', '^picochip,.*', '^pine64,.*', '^pineriver,.*', '^pixcir,.*', '^p=
lantower,.*', '^plathome,.*', '^plda,.*', '^plx,.*', '^ply,.*', '^pni,.*', =
'^pocketbook,.*', '^polaroid,.*', '^polyhex,.*', '^portwell,.*', '^poslab,.=
*', '^pov,.*', '^powertip,.*', '^powervr,.*', '^powkiddy,.*', '^primeview,.=
*', '^primux,.*', '^probox2,.*', '^prt,.*', '^pulsedlight,.*', '^purism,.*'=
, '^qca,.*', '^qcom,.*', '^qemu,.*', '^qi,.*', '^qiaodian,.*', '^qihua,.*',=
 '^qishenglong,.*', '^qnap,.*', '^quanta,.*', '^radxa,.*', '^raidsonic,.*',=
 '^ralink,.*', '^ramtron,
>  .*', '^raspberrypi,.*', '^raydium,.*', '^rda,.*', '^realtek,.*', '^remar=
kable,.*', '^renesas,.*', '^rervision,.*', '^revotics,.*', '^rex,.*', '^ric=
htek,.*', '^ricoh,.*', '^rikomagic,.*', '^riot,.*', '^riscv,.*', '^rockchip=
,.*', '^rocktech,.*', '^rohm,.*', '^ronbo,.*', '^roofull,.*', '^roseapplepi=
,.*', '^rve,.*', '^saef,.*', '^samsung,.*', '^samtec,.*', '^sancloud,.*', '=
^sandisk,.*', '^satoz,.*', '^sbs,.*', '^schindler,.*', '^schneider,.*', '^s=
ciosense,.*', '^seagate,.*', '^seeed,.*', '^seirobotics,.*', '^semtech,.*',=
 '^senseair,.*', '^sensirion,.*', '^sensortek,.*', '^sercomm,.*', '^sff,.*'=
, '^sgd,.*', '^sgmicro,.*', '^sgx,.*', '^sharp,.*', '^shift,.*', '^shimafuj=
i,.*', '^shineworld,.*', '^shiratech,.*', '^si-en,.*', '^si-linux,.*', '^si=
emens,.*', '^sifive,.*', '^sigma,.*', '^sii,.*', '^sil,.*', '^silabs,.*', '=
^silan,.*', '^silead,.*', '^silergy,.*', '^silex-insight,.*', '^siliconfile=
,.*', '^siliconmitus,.*', '^silvaco,.*', '^simtek,.*', '^sinlinx,.*', '^sin=
ovoip,.*', '^sinowealth,.
>  *', '^sipeed,.*', '^sirf,.*', '^sis,.*', '^sitronix,.*', '^skov,.*', '^s=
kyworks,.*', '^smartlabs,.*', '^smartrg,.*', '^smi,.*', '^smsc,.*', '^snps,=
.*', '^sochip,.*', '^socionext,.*', '^solidrun,.*', '^solomon,.*', '^sony,.=
*', '^sophgo,.*', '^sourceparts,.*', '^spansion,.*', '^sparkfun,.*', '^spin=
alhdl,.*', '^sprd,.*', '^square,.*', '^ssi,.*', '^sst,.*', '^sstar,.*', '^s=
t,.*', '^st-ericsson,.*', '^starfive,.*', '^starry,.*', '^startek,.*', '^st=
arterkit,.*', '^ste,.*', '^stericsson,.*', '^storlink,.*', '^storm,.*', '^s=
toropack,.*', '^summit,.*', '^sunchip,.*', '^sundance,.*', '^sunplus,.*', '=
^supermicro,.*', '^swir,.*', '^syna,.*', '^synology,.*', '^synopsys,.*', '^=
tbs,.*', '^tbs-biometrics,.*', '^tcg,.*', '^tcl,.*', '^tcs,.*', '^tdo,.*', =
'^team-source-display,.*', '^technexion,.*', '^technologic,.*', '^techstar,=
.*', '^techwell,.*', '^teejet,.*', '^teltonika,.*', '^tempo,.*', '^terasic,=
.*', '^tesla,.*', '^tfc,.*', '^thead,.*', '^thine,.*', '^thingyjp,.*', '^th=
undercomm,.*', '^thwc,.*'
>  , '^ti,.*', '^tianma,.*', '^tlm,.*', '^tmt,.*', '^topeet,.*', '^topic,.*=
', '^toppoly,.*', '^topwise,.*', '^toradex,.*', '^toshiba,.*', '^toumaz,.*'=
, '^tpk,.*', '^tplink,.*', '^tpo,.*', '^tq,.*', '^transpeed,.*', '^traverse=
,.*', '^tronfy,.*', '^tronsmart,.*', '^truly,.*', '^tsd,.*', '^turing,.*', =
'^tyan,.*', '^u-blox,.*', '^u-boot,.*', '^ubnt,.*', '^ucrobotics,.*', '^udo=
o,.*', '^ufispace,.*', '^ugoos,.*', '^uni-t,.*', '^uniwest,.*', '^upisemi,.=
*', '^urt,.*', '^usi,.*', '^usr,.*', '^utoo,.*', '^v3,.*', '^vaisala,.*', '=
^vamrs,.*', '^variscite,.*', '^vdl,.*', '^vertexcom,.*', '^via,.*', '^viala=
b,.*', '^vicor,.*', '^videostrong,.*', '^virtio,.*', '^virtual,.*', '^visha=
y,.*', '^visionox,.*', '^vitesse,.*', '^vivante,.*', '^vivax,.*', '^vocore,=
.*', '^voipac,.*', '^voltafield,.*', '^vot,.*', '^vscom,.*', '^vxt,.*', '^w=
acom,.*', '^wanchanglong,.*', '^wand,.*', '^waveshare,.*', '^wd,.*', '^we,.=
*', '^welltech,.*', '^wetek,.*', '^wexler,.*', '^whwave,.*', '^wi2wi,.*', '=
^widora,.*', '^wiligear,.
>  *', '^willsemi,.*', '^winbond,.*', '^wingtech,.*', '^winlink,.*', '^wins=
tar,.*', '^wirelesstag,.*', '^wits,.*', '^wlf,.*', '^wm,.*', '^wobo,.*', '^=
wolfvision,.*', '^x-powers,.*', '^xen,.*', '^xes,.*', '^xiaomi,.*', '^xilly=
bus,.*', '^xingbangda,.*', '^xinpeng,.*', '^xiphera,.*', '^xlnx,.*', '^xnan=
o,.*', '^xunlong,.*', '^xylon,.*', '^yadro,.*', '^yamaha,.*', '^yes-optoele=
ctronics,.*', '^yic,.*', '^yiming,.*', '^ylm,.*', '^yna,.*', '^yones-toptec=
h,.*', '^ys,.*', '^ysoft,.*', '^zarlink,.*', '^zealz,.*', '^zeitec,.*', '^z=
idoo,.*', '^zii,.*', '^zinitix,.*', '^zkmagic,.*', '^zte,.*', '^zyxel,.*', =
'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/vendor-prefixes.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: syscon@1e6e200=
0: 'smp-memram@180' does not match any of the regexes: '^interrupt-controll=
er@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^sili=
con-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.ya=
ml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/sysco=
n@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['as=
peed,ast2600-smpmem']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/sysco=
n@1e6e2000/interrupt-controller@560: failed to match any schema with compat=
ible: ['aspeed,ast2600-scu-ic0']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/sysco=
n@1e6e2000/interrupt-controller@570: failed to match any schema with compat=
ible: ['aspeed,ast2600-scu-ic1']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/displ=
ay@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-g=
fx', 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/xdma@=
1e6e7000: failed to match any schema with compatible: ['aspeed,ast2600-xdma=
']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: adc@1e6e9000: =
'interrupts', 'vref' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-ad=
c.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: adc@1e6e9100: =
'interrupts', 'vref' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-ad=
c.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: crypto@1e6fa00=
0: 'aspeed,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acr=
y.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/video=
@1e700000: failed to match any schema with compatible: ['aspeed,ast2600-vid=
eo-engine']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: gpio@1e780000:=
 'pinctrl-0' is a dependency of 'pinctrl-names'
> 	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.=
yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/timer=
@1e782000: failed to match any schema with compatible: ['aspeed,ast2600-tim=
er']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: lpc@1e789000: =
lpc-snoop@80: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: lpc@1e789000: =
reg-io-width: 4 is not of type 'object'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: kcs@24: 'clock=
s' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: kcs@28: 'clock=
s' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: kcs@2c: 'clock=
s' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: kcs@114: 'cloc=
ks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/lpc@1=
e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast260=
0-lhc']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/lpc@1=
e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast26=
00-ibt-bmc']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: sdc@1e740000: =
sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: sdc@1e740000: =
sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/sdc@1=
e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspee=
d,ast2600-sdhci', 'sdhci']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/sdc@1=
e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspee=
d,ast2600-sdhci', 'sdhci']
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
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: i2c@400: Uneva=
luated properties are not allowed ('aspeed,hw-timeout-ms' was unexpected)
> 	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus@1=
e78a000/i2c@400/ipmb@10: failed to match any schema with compatible: ['ipmb=
-dev']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ssif-bmc@10: '=
arm-sbmr,skip-bootprogress-response' does not match any of the regexes: 'pi=
nctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/ssif-bmc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: ssif-bmc@10: '=
arm-sbmr,skip-bootprogress-response' does not match any of the regexes: '^#=
.*', '^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpm=
c|hdmi|i2c-gpio),.*', '^(keypad|m25p|max8952|max8997|max8998|mpmc),.*', '^(=
pinctrl-single|#pinctrl-single|PowerPC),.*', '^(pl022|pxa-mmc|rcar_sound|ro=
tary-encoder|s5m8767|sdhci),.*', '^(simple-audio-card|st-plgpio|st-spics|ts=
),.*', '^100ask,.*', '^70mai,.*', '^8dev,.*', '^GEFanuc,.*', '^IBM,.*', '^O=
RCL,.*', '^SUNW,.*', '^[a-zA-Z0-9#_][a-zA-Z0-9+\-._@]{0,63}$', '^[a-zA-Z0-9=
+\-._]*@[0-9a-zA-Z,]*$', '^abb,.*', '^abilis,.*', '^abracon,.*', '^abt,.*',=
 '^acbel,.*', '^acelink,.*', '^acer,.*', '^acme,.*', '^actions,.*', '^activ=
e-semi,.*', '^ad,.*', '^adafruit,.*', '^adapteva,.*', '^adaptrum,.*', '^adh=
,.*', '^adi,.*', '^adieng,.*', '^admatec,.*', '^advantech,.*', '^aeroflexga=
isler,.*', '^aesop,.*', '^airoha,.*', '^al,.*', '^alcatel,.*', '^aldec,.*',=
 '^alfa-network,.*', '^al
>  legro,.*', '^alliedvision,.*', '^allo,.*', '^allwinner,.*', '^alphascale=
,.*', '^alps,.*', '^alt,.*', '^altr,.*', '^amarula,.*', '^amazon,.*', '^amc=
c,.*', '^amd,.*', '^amediatech,.*', '^amlogic,.*', '^ampere,.*', '^amphenol=
,.*', '^ampire,.*', '^ams,.*', '^amstaos,.*', '^analogix,.*', '^anbernic,.*=
', '^andestech,.*', '^anvo,.*', '^aosong,.*', '^apm,.*', '^apple,.*', '^apt=
ina,.*', '^arasan,.*', '^archermind,.*', '^arcom,.*', '^arctic,.*', '^arcx,=
.*', '^aries,.*', '^arm,.*', '^armadeus,.*', '^armsom,.*', '^arrow,.*', '^a=
rtesyn,.*', '^asahi-kasei,.*', '^asc,.*', '^asix,.*', '^aspeed,.*', '^asroc=
k,.*', '^asteralabs,.*', '^asus,.*', '^atheros,.*', '^atlas,.*', '^atmel,.*=
', '^auo,.*', '^auvidea,.*', '^avago,.*', '^avia,.*', '^avic,.*', '^avnet,.=
*', '^awinic,.*', '^axentia,.*', '^axis,.*', '^azoteq,.*', '^azw,.*', '^bai=
kal,.*', '^bananapi,.*', '^beacon,.*', '^beagle,.*', '^belling,.*', '^bhf,.=
*', '^bigtreetech,.*', '^bitmain,.*', '^blutek,.*', '^boe,.*', '^bosch,.*',=
 '^boundary,.*', '^brcm,.
>  *', '^broadmobi,.*', '^bsh,.*', '^bticino,.*', '^buffalo,.*', '^bur,.*',=
 '^bytedance,.*', '^calamp,.*', '^calao,.*', '^calaosystems,.*', '^calxeda,=
.*', '^cameo,.*', '^canaan,.*', '^caninos,.*', '^capella,.*', '^cascoda,.*'=
, '^catalyst,.*', '^cavium,.*', '^cct,.*', '^cdns,.*', '^cdtech,.*', '^cell=
wise,.*', '^ceva,.*', '^chargebyte,.*', '^checkpoint,.*', '^chefree,.*', '^=
chipidea,.*', '^chipone,.*', '^chipspark,.*', '^chongzhou,.*', '^chrontel,.=
*', '^chrp,.*', '^chunghwa,.*', '^chuwi,.*', '^ciaa,.*', '^cirrus,.*', '^ci=
sco,.*', '^clockwork,.*', '^cloos,.*', '^cloudengines,.*', '^cnm,.*', '^cnx=
t,.*', '^colorfly,.*', '^compulab,.*', '^congatec,.*', '^coolpi,.*', '^core=
river,.*', '^corpro,.*', '^cortina,.*', '^cosmic,.*', '^crane,.*', '^creati=
ve,.*', '^crystalfontz,.*', '^csky,.*', '^csq,.*', '^ctera,.*', '^ctu,.*', =
'^cubietech,.*', '^cudy,.*', '^cui,.*', '^cypress,.*', '^cyx,.*', '^cznic,.=
*', '^dallas,.*', '^dataimage,.*', '^davicom,.*', '^dell,.*', '^delta,.*', =
'^densitron,.*', '^denx,.
>  *', '^devantech,.*', '^dfi,.*', '^dh,.*', '^difrnce,.*', '^digi,.*', '^d=
igilent,.*', '^dimonoff,.*', '^diodes,.*', '^dioo,.*', '^dlc,.*', '^dlg,.*'=
, '^dlink,.*', '^dmo,.*', '^domintech,.*', '^dongwoon,.*', '^dptechnics,.*'=
, '^dragino,.*', '^dream,.*', '^ds,.*', '^dserve,.*', '^dynaimage,.*', '^ea=
,.*', '^ebang,.*', '^ebbg,.*', '^ebs-systart,.*', '^ebv,.*', '^eckelmann,.*=
', '^edgeble,.*', '^edimax,.*', '^edt,.*', '^ees,.*', '^eeti,.*', '^einfoch=
ips,.*', '^eink,.*', '^elan,.*', '^element14,.*', '^elgin,.*', '^elida,.*',=
 '^elimo,.*', '^elpida,.*', '^embedfire,.*', '^embest,.*', '^emcraft,.*', '=
^emlid,.*', '^emmicro,.*', '^empire-electronix,.*', '^emtrion,.*', '^enclus=
tra,.*', '^endless,.*', '^ene,.*', '^energymicro,.*', '^engicam,.*', '^engl=
eder,.*', '^epcos,.*', '^epfl,.*', '^epson,.*', '^esp,.*', '^est,.*', '^ett=
us,.*', '^eukrea,.*', '^everest,.*', '^everspin,.*', '^evervision,.*', '^ex=
ar,.*', '^excito,.*', '^exegin,.*', '^ezchip,.*', '^facebook,.*', '^fairchi=
ld,.*', '^fairphone,.*',=20
>  '^faraday,.*', '^fascontek,.*', '^fastrax,.*', '^fcs,.*', '^feixin,.*', =
'^feiyang,.*', '^fii,.*', '^firefly,.*', '^focaltech,.*', '^forlinx,.*', '^=
freebox,.*', '^freecom,.*', '^frida,.*', '^friendlyarm,.*', '^fsl,.*', '^fu=
jitsu,.*', '^fxtec,.*', '^galaxycore,.*', '^gameforce,.*', '^gardena,.*', '=
^gateway,.*', '^gateworks,.*', '^gcw,.*', '^ge,.*', '^geekbuying,.*', '^gef=
,.*', '^gemei,.*', '^gemtek,.*', '^genesys,.*', '^geniatech,.*', '^giantec,=
.*', '^giantplus,.*', '^glinet,.*', '^globalscale,.*', '^globaltop,.*', '^g=
mt,.*', '^goldelico,.*', '^goodix,.*', '^google,.*', '^goramo,.*', '^gplus,=
.*', '^grinn,.*', '^grmn,.*', '^gumstix,.*', '^gw,.*', '^hannstar,.*', '^ha=
ochuangyi,.*', '^haoyu,.*', '^hardkernel,.*', '^hechuang,.*', '^hideep,.*',=
 '^himax,.*', '^hirschmann,.*', '^hisi,.*', '^hisilicon,.*', '^hit,.*', '^h=
itex,.*', '^holt,.*', '^holtek,.*', '^honestar,.*', '^honeywell,.*', '^hope=
rf,.*', '^hoperun,.*', '^hp,.*', '^hpe,.*', '^hsg,.*', '^htc,.*', '^huawei,=
.*', '^hugsun,.*', '^hwac
>  om,.*', '^hxt,.*', '^hycon,.*', '^hydis,.*', '^hynitron,.*', '^hynix,.*'=
, '^hyundai,.*', '^i2se,.*', '^ibm,.*', '^icplus,.*', '^idt,.*', '^iei,.*',=
 '^ifi,.*', '^ilitek,.*', '^imagis,.*', '^img,.*', '^imi,.*', '^inanbo,.*',=
 '^incircuit,.*', '^indiedroid,.*', '^inet-tek,.*', '^infineon,.*', '^infor=
ce,.*', '^ingenic,.*', '^ingrasys,.*', '^injoinic,.*', '^innocomm,.*', '^in=
nolux,.*', '^inside-secure,.*', '^insignal,.*', '^inspur,.*', '^intel,.*', =
'^intercontrol,.*', '^invensense,.*', '^inventec,.*', '^inversepath,.*', '^=
iom,.*', '^irondevice,.*', '^isee,.*', '^isil,.*', '^issi,.*', '^ite,.*', '=
^itead,.*', '^itian,.*', '^ivo,.*', '^iwave,.*', '^jadard,.*', '^jasonic,.*=
', '^jdi,.*', '^jedec,.*', '^jesurun,.*', '^jethome,.*', '^jianda,.*', '^ji=
de,.*', '^joz,.*', '^kam,.*', '^karo,.*', '^keithkoep,.*', '^keymile,.*', '=
^khadas,.*', '^kiebackpeter,.*', '^kinetic,.*', '^kingdisplay,.*', '^kingno=
vel,.*', '^kionix,.*', '^kobo,.*', '^kobol,.*', '^koe,.*', '^kontron,.*', '=
^kosagi,.*', '^kvg,.*', '
>  ^kyo,.*', '^lacie,.*', '^laird,.*', '^lamobo,.*', '^lantiq,.*', '^lattic=
e,.*', '^lctech,.*', '^leadtek,.*', '^leez,.*', '^lego,.*', '^lemaker,.*', =
'^lenovo,.*', '^lg,.*', '^lgphilips,.*', '^libretech,.*', '^licheepi,.*', '=
^linaro,.*', '^lincolntech,.*', '^lineartechnology,.*', '^linksprite,.*', '=
^linksys,.*', '^linutronix,.*', '^linux,.*', '^linx,.*', '^liteon,.*', '^li=
tex,.*', '^lltc,.*', '^logicpd,.*', '^logictechno,.*', '^longcheer,.*', '^l=
ontium,.*', '^loongmasses,.*', '^loongson,.*', '^lsi,.*', '^lunzn,.*', '^lu=
xul,.*', '^lwn,.*', '^lxa,.*', '^m5stack,.*', '^macnica,.*', '^mantix,.*', =
'^mapleboard,.*', '^marantec,.*', '^marvell,.*', '^maxbotix,.*', '^maxim,.*=
', '^maxlinear,.*', '^mbvl,.*', '^mcube,.*', '^meas,.*', '^mecer,.*', '^med=
iatek,.*', '^megachips,.*', '^mele,.*', '^melexis,.*', '^melfas,.*', '^mell=
anox,.*', '^memsensing,.*', '^memsic,.*', '^menlo,.*', '^mentor,.*', '^mera=
ki,.*', '^merrii,.*', '^methode,.*', '^micrel,.*', '^microchip,.*', '^micro=
crystal,.*', '^micron,.*'
>  , '^microsoft,.*', '^microsys,.*', '^microtips,.*', '^mikroe,.*', '^mikr=
otik,.*', '^milkv,.*', '^miniand,.*', '^minix,.*', '^mips,.*', '^miramems,.=
*', '^mitsubishi,.*', '^mitsumi,.*', '^mixel,.*', '^miyoo,.*', '^mntre,.*',=
 '^mobileye,.*', '^modtronix,.*', '^moortec,.*', '^mosaixtech,.*', '^motorc=
omm,.*', '^motorola,.*', '^moxa,.*', '^mpl,.*', '^mps,.*', '^mqmaker,.*', '=
^mrvl,.*', '^mscc,.*', '^msi,.*', '^mstar,.*', '^mti,.*', '^multi-inno,.*',=
 '^mundoreader,.*', '^murata,.*', '^mxic,.*', '^mxicy,.*', '^myir,.*', '^na=
tional,.*', '^neardi,.*', '^nec,.*', '^neonode,.*', '^netgear,.*', '^netlog=
ic,.*', '^netron-dy,.*', '^netronix,.*', '^netxeon,.*', '^neweast,.*', '^ne=
whaven,.*', '^newvision,.*', '^nexbox,.*', '^nextthing,.*', '^ni,.*', '^nin=
tendo,.*', '^nlt,.*', '^nokia,.*', '^nordic,.*', '^novatek,.*', '^novtech,.=
*', '^numonyx,.*', '^nutsboard,.*', '^nuvoton,.*', '^nvd,.*', '^nvidia,.*',=
 '^nxp,.*', '^oceanic,.*', '^ocs,.*', '^oct,.*', '^okaya,.*', '^oki,.*', '^=
olimex,.*', '^olpc,.*', '
>  ^oneplus,.*', '^onie,.*', '^onion,.*', '^onnn,.*', '^ontat,.*', '^opalke=
lly,.*', '^openailab,.*', '^opencores,.*', '^openembed,.*', '^openpandora,.=
*', '^openrisc,.*', '^openwrt,.*', '^option,.*', '^oranth,.*', '^orisetech,=
.*', '^ortustech,.*', '^osddisplays,.*', '^osmc,.*', '^ouya,.*', '^overkiz,=
.*', '^ovti,.*', '^oxsemi,.*', '^ozzmaker,.*', '^panasonic,.*', '^parade,.*=
', '^parallax,.*', '^pda,.*', '^pericom,.*', '^pervasive,.*', '^phicomm,.*'=
, '^phytec,.*', '^picochip,.*', '^pine64,.*', '^pineriver,.*', '^pixcir,.*'=
, '^plantower,.*', '^plathome,.*', '^plda,.*', '^plx,.*', '^ply,.*', '^pni,=
.*', '^pocketbook,.*', '^polaroid,.*', '^polyhex,.*', '^portwell,.*', '^pos=
lab,.*', '^pov,.*', '^powertip,.*', '^powervr,.*', '^powkiddy,.*', '^primev=
iew,.*', '^primux,.*', '^probox2,.*', '^prt,.*', '^pulsedlight,.*', '^puris=
m,.*', '^qca,.*', '^qcom,.*', '^qemu,.*', '^qi,.*', '^qiaodian,.*', '^qihua=
,.*', '^qishenglong,.*', '^qnap,.*', '^quanta,.*', '^radxa,.*', '^raidsonic=
,.*', '^ralink,.*', '^ram
>  tron,.*', '^raspberrypi,.*', '^raydium,.*', '^rda,.*', '^realtek,.*', '^=
remarkable,.*', '^renesas,.*', '^rervision,.*', '^revotics,.*', '^rex,.*', =
'^richtek,.*', '^ricoh,.*', '^rikomagic,.*', '^riot,.*', '^riscv,.*', '^roc=
kchip,.*', '^rocktech,.*', '^rohm,.*', '^ronbo,.*', '^roofull,.*', '^roseap=
plepi,.*', '^rve,.*', '^saef,.*', '^samsung,.*', '^samtec,.*', '^sancloud,.=
*', '^sandisk,.*', '^satoz,.*', '^sbs,.*', '^schindler,.*', '^schneider,.*'=
, '^sciosense,.*', '^seagate,.*', '^seeed,.*', '^seirobotics,.*', '^semtech=
,.*', '^senseair,.*', '^sensirion,.*', '^sensortek,.*', '^sercomm,.*', '^sf=
f,.*', '^sgd,.*', '^sgmicro,.*', '^sgx,.*', '^sharp,.*', '^shift,.*', '^shi=
mafuji,.*', '^shineworld,.*', '^shiratech,.*', '^si-en,.*', '^si-linux,.*',=
 '^siemens,.*', '^sifive,.*', '^sigma,.*', '^sii,.*', '^sil,.*', '^silabs,.=
*', '^silan,.*', '^silead,.*', '^silergy,.*', '^silex-insight,.*', '^silico=
nfile,.*', '^siliconmitus,.*', '^silvaco,.*', '^simtek,.*', '^sinlinx,.*', =
'^sinovoip,.*', '^sinowea
>  lth,.*', '^sipeed,.*', '^sirf,.*', '^sis,.*', '^sitronix,.*', '^skov,.*'=
, '^skyworks,.*', '^smartlabs,.*', '^smartrg,.*', '^smi,.*', '^smsc,.*', '^=
snps,.*', '^sochip,.*', '^socionext,.*', '^solidrun,.*', '^solomon,.*', '^s=
ony,.*', '^sophgo,.*', '^sourceparts,.*', '^spansion,.*', '^sparkfun,.*', '=
^spinalhdl,.*', '^sprd,.*', '^square,.*', '^ssi,.*', '^sst,.*', '^sstar,.*'=
, '^st,.*', '^st-ericsson,.*', '^starfive,.*', '^starry,.*', '^startek,.*',=
 '^starterkit,.*', '^ste,.*', '^stericsson,.*', '^storlink,.*', '^storm,.*'=
, '^storopack,.*', '^summit,.*', '^sunchip,.*', '^sundance,.*', '^sunplus,.=
*', '^supermicro,.*', '^swir,.*', '^syna,.*', '^synology,.*', '^synopsys,.*=
', '^tbs,.*', '^tbs-biometrics,.*', '^tcg,.*', '^tcl,.*', '^tcs,.*', '^tdo,=
.*', '^team-source-display,.*', '^technexion,.*', '^technologic,.*', '^tech=
star,.*', '^techwell,.*', '^teejet,.*', '^teltonika,.*', '^tempo,.*', '^ter=
asic,.*', '^tesla,.*', '^tfc,.*', '^thead,.*', '^thine,.*', '^thingyjp,.*',=
 '^thundercomm,.*', '^thw
>  c,.*', '^ti,.*', '^tianma,.*', '^tlm,.*', '^tmt,.*', '^topeet,.*', '^top=
ic,.*', '^toppoly,.*', '^topwise,.*', '^toradex,.*', '^toshiba,.*', '^touma=
z,.*', '^tpk,.*', '^tplink,.*', '^tpo,.*', '^tq,.*', '^transpeed,.*', '^tra=
verse,.*', '^tronfy,.*', '^tronsmart,.*', '^truly,.*', '^tsd,.*', '^turing,=
.*', '^tyan,.*', '^u-blox,.*', '^u-boot,.*', '^ubnt,.*', '^ucrobotics,.*', =
'^udoo,.*', '^ufispace,.*', '^ugoos,.*', '^uni-t,.*', '^uniwest,.*', '^upis=
emi,.*', '^urt,.*', '^usi,.*', '^usr,.*', '^utoo,.*', '^v3,.*', '^vaisala,.=
*', '^vamrs,.*', '^variscite,.*', '^vdl,.*', '^vertexcom,.*', '^via,.*', '^=
vialab,.*', '^vicor,.*', '^videostrong,.*', '^virtio,.*', '^virtual,.*', '^=
vishay,.*', '^visionox,.*', '^vitesse,.*', '^vivante,.*', '^vivax,.*', '^vo=
core,.*', '^voipac,.*', '^voltafield,.*', '^vot,.*', '^vscom,.*', '^vxt,.*'=
, '^wacom,.*', '^wanchanglong,.*', '^wand,.*', '^waveshare,.*', '^wd,.*', '=
^we,.*', '^welltech,.*', '^wetek,.*', '^wexler,.*', '^whwave,.*', '^wi2wi,.=
*', '^widora,.*', '^wilig
>  ear,.*', '^willsemi,.*', '^winbond,.*', '^wingtech,.*', '^winlink,.*', '=
^winstar,.*', '^wirelesstag,.*', '^wits,.*', '^wlf,.*', '^wm,.*', '^wobo,.*=
', '^wolfvision,.*', '^x-powers,.*', '^xen,.*', '^xes,.*', '^xiaomi,.*', '^=
xillybus,.*', '^xingbangda,.*', '^xinpeng,.*', '^xiphera,.*', '^xlnx,.*', '=
^xnano,.*', '^xunlong,.*', '^xylon,.*', '^yadro,.*', '^yamaha,.*', '^yes-op=
toelectronics,.*', '^yic,.*', '^yiming,.*', '^ylm,.*', '^yna,.*', '^yones-t=
optech,.*', '^ys,.*', '^ysoft,.*', '^zarlink,.*', '^zealz,.*', '^zeitec,.*'=
, '^zidoo,.*', '^zii,.*', '^zinitix,.*', '^zkmagic,.*', '^zte,.*', '^zyxel,=
.*', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/vendor-prefixes.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: fsi@1e79b000: =
compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
> 	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-ma=
ster.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/fsi@1=
e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-m=
aster', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: fsi@1e79b100: =
compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
> 	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-ma=
ster.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/fsi@1=
e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-m=
aster', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/dma-c=
ontroller@1e79e000: failed to match any schema with compatible: ['aspeed,as=
t2600-udma']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: spi1-gpio: $no=
dename:0: 'spi1-gpio' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
> 	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: spi1-gpio: gpi=
o-sck: False schema does not allow [44, 203, 0]
> 	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: spi1-gpio: gpi=
o-miso: False schema does not allow [44, 205, 0]
> 	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: spi1-gpio: gpi=
o-mosi: False schema does not allow [44, 204, 0]
> 	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: spi1-gpio: 'sc=
k-gpios' is a required property
> 	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: spi1-gpio: Une=
valuated properties are not allowed ('#address-cells', '#size-cells', 'gpio=
-miso', 'gpio-mosi', 'gpio-sck', 'tpm@0' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/spi/spi-gpio.yaml#

Can you please clean these up as best you can?

Andrew

