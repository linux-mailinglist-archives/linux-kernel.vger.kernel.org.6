Return-Path: <linux-kernel+bounces-364902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C596699DAC9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99931C212E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6284B18E2A;
	Tue, 15 Oct 2024 00:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Yr3vlzPP"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91202101F7;
	Tue, 15 Oct 2024 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953059; cv=none; b=ohNZUvBT90N7oB/1F3r9kNL0zvdKLcVJr4TRO4ktRs8Gr4tR/3l9Q5ChH1NSPnn7H14PNKlOdYRgHLCPuxgQr5kaHn2gS4BbrS91Ojwxta2oldXiilK01aSyJOOCGXPoXR0eeuIP05TCv1MFLJh//T+y8SeG2JSpJIQC7+wM6nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953059; c=relaxed/simple;
	bh=f0b049l8F4nitzsKdmhh/lH9EoJTcRarfvGgIKAVv8k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QjEP7aB4Avwd+w0DlZdVe4NECchO4uxJz6FMNGY/yXCYmYEqLPJjHeE+ApnVzyIJJIhxfvew+viZqF+Acx4ZZbfzLugymfJL7fTJvjjhJ38wFun37EzqnGGQ8GRhfr16acJMnjVEcu+Mm5Cd7w0RT3eBCiGUAk4pkQqhP0Po4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Yr3vlzPP; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1728952691;
	bh=6/06bc8oCZtyUeywqMc8qTFgfwd5N7FHrM9Z7htd1G0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yr3vlzPPFYdNfF21gVd7sc9jkCqRu3O12LkVhdfZMDUdr2lIULQqlZ/m3DaEXQeB5
	 A2O9PXWnoZKl5FqwlqPYoHLE+dCBur3+TS5TqFhnhxYOj0dI/o9sJ/ADPgJUBPvZRn
	 w9Od7APzUPV3yJD6HOT7K/3gTCZIE/9uVV71aG1rmtuhaAWwcAi7xxrIAeDGm7Ddec
	 ehVmgt7l/WvAqE3YHyapNPS55d6Q8Lmyi8XHcq3ukIi3kka67W1FZRM4eJ6v5nF18I
	 +s0t9MmKu+DSMsnc0lN0O0zZSYEJlaq/m6p0yGa+AomRGk2VvJToHHa5pkE7Q8aS1M
	 4WVbxmKP0cCiA==
Received: from [192.168.68.112] (203-173-0-39.dyn.iinet.net.au [203.173.0.39])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F16C4649A0;
	Tue, 15 Oct 2024 08:38:08 +0800 (AWST)
Message-ID: <5ca25b137b955dc5e0d9607df104097e3de7b782.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley
 <conor.dooley@microchip.com>,  Joel Stanley <joel@jms.id.au>, Conor Dooley
 <conor+dt@kernel.org>, linux-aspeed@lists.ozlabs.org
Date: Tue, 15 Oct 2024 11:08:08 +1030
In-Reply-To: <CABqG17gmjvBmpp2a7tgVwR+q3tsrbejVmezWaXH__txytr30hQ@mail.gmail.com>
References: <20241010112337.3840703-1-naresh.solanki@9elements.com>
	 <172857036038.1533242.5775916298170949713.robh@kernel.org>
	 <4d596ac9a2215be8510369c948e0b9680ee2fce3.camel@codeconstruct.com.au>
	 <CABqG17gmjvBmpp2a7tgVwR+q3tsrbejVmezWaXH__txytr30hQ@mail.gmail.com>
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

On Fri, 2024-10-11 at 13:38 +0530, Naresh Solanki wrote:
> Hi Andrew,
>=20
>=20
> On Fri, 11 Oct 2024 at 05:15, Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > Hi Naresh,
> >=20
> > On Thu, 2024-10-10 at 09:30 -0500, Rob Herring (Arm) wrote:
> > > On Thu, 10 Oct 2024 16:53:31 +0530, Naresh Solanki wrote:
> > > > Document the new compatibles used on IBM SBP1.
> > > >=20
> > > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > > Changes in V4:
> > > > - Retain Acked-by from v2.
> > > > - Fix alphabetic order
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > >=20
> > >=20
> > > My bot found new DTB warnings on the .dts files added or changed in t=
his
> > > series.
> > >=20
> > > Some warnings may be from an existing SoC .dtsi. Or perhaps the warni=
ngs
> > > are fixed by another series. Ultimately, it is up to the platform
> > > maintainer whether these warnings are acceptable or not. No need to r=
eply
> > > unless the platform maintainer has comments.
> > >=20
> > > If you already ran DT checks and didn't see these error(s), then
> > > make sure dt-schema is up to date:
> > >=20
> > >  pip3 install dtschema --upgrade
> > >=20
> > >=20
> > > New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ibm-sbp1.=
dtb' for 20241010112337.3840703-1-naresh.solanki@9elements.com:
> > >=20
> >=20
> > ...
> >=20
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mux@77: interrupts:=
 False schema does not allow [[44, 4]]
> > >  from schema $id: http://devicetree.org/schemas/i2c/i2c-mux-pca954x.y=
aml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-c=
pu2@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >  from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccf=
a-cpu2@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >  from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-c=
pu1@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >  from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccf=
a-cpu1@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >  from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-c=
pu3@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >  from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccf=
a-cpu3@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >  from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regu=
lators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >  from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regu=
lators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >  from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regu=
lators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >  from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regu=
lators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >  from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-c=
pu0@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >  from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> > > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccf=
a-cpu0@58: 'regulators' does not match any of the regexes: 'pinctrl-[0-9]+'
> > >  from schema $id: http://devicetree.org/schemas/trivial-devices.yaml#
> >=20
> > These still must be addressed as mentioned on v3 (with more specific
> > comments regarding the infineon,ir38263 on v4). Please look through the
> > binding documents for the affected nodes and make sure the nodes in
> > your DTS conform to their definitions. You can check your work with
> > `make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ibm-sbp1.dtb` prior to sending.
>=20
> These are the warnings coming for trivial devices. Even for regulator@5f
>=20
> grep -rsn mp2973 Documentation/
> Documentation/devicetree/bindings/trivial-devices.yaml:286:
> # Monolithic Power Systems Inc. multi-phase controller mp2973
> Documentation/devicetree/bindings/trivial-devices.yaml:287: -
> mps,mp2973
>=20

Right, but if they're generating warnings, then you haven't specified
the nodes in accordance with the bindings. From here one of two things
is the case:

   1. The bindings' specifications are incomplete, and you need to
      introduce patches updating them to match how you need to use the
      hardware
   2. Your devicetree is incorrect, and the unexpected properties need
      to be removed from the listed nodes.

The only third option is "don't use the hardware how you need to" (i.e.
remove the unexpected properties despite needing them, because you
don't want to update the bindings).

Ultimately the tools are telling you something is wrong, and I need the
warnings I've identified addressed before I can apply your patch,
otherwise the hardware is not going to do what you might expect.
> I've rebased it on top of for-next branch in [2]
>=20
> I rebased on top of [1] & the volume of output did reduce for CHECK_DTBS.

Great :)

Andrew

