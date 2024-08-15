Return-Path: <linux-kernel+bounces-287356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37909526E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025B11C215E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B2318D62B;
	Thu, 15 Aug 2024 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="OQIY11jm"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C2F186A;
	Thu, 15 Aug 2024 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681577; cv=none; b=DIGf2xqURDX80FHNui3lmzL6xc0hFYqc7qs1mVLBH7wwO+jjBxaQemJiPMzeTD4hX+WTNRVPV+5mEntgNnzcOd7ExdwA9bnsMtaOZ5sZR/sQ1q6bLFr2v6OnEq6K8OPi4WfgYLwM+BfRabZx2Q/NJkLA6XL7LqGlntgWFQp+t2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681577; c=relaxed/simple;
	bh=8I8CiWVpxDRh+TBvxuD+POU/JuLcF2IqLifgtMYIBbs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZMun7HFFdQ72hAApBP8GyiASrE/HgOFgy72FmR3n41As5nvjzZO3rDcr6j1A8EJgxEvBwcUiiGP5XspGTKToYJzxIKyx+z2nFoPk5viu7lR1dTCbotxv79P9m5QCsjk31qYL/dK6PJLbKZz7JiV1OmP4m8he7Bxtr7oaUF4lSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=OQIY11jm; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1723681565;
	bh=9cfgPGg8I/etk0AZvDqHhwew340zEVZFZ6XKpAktces=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OQIY11jmCPRLT/TWEltTb9t6HLF3ctwQcmBdheBQlWI2J9SjagZz7uPrZ5JqRJh3m
	 XXgST3yi8Ou3SXC3KYAO8TXtppF6f/T72hJAvc8nOq+E3tDK382r7Ezkj8SUr4b+iE
	 noHjCRQ2befrKLciBO0l1ja52a4FjmJVO0Zkzvz+HfyOrdc2S/Sv0OwPJZctNpH/5y
	 WWdJbJRzvR1vXr8nRxBEUyudoB8aInkND9mSTMWPYHLngQasqOprrCyovr+w2txVZH
	 XXh88hcTbsoKrS82qNUbf9pV5o5is2pKjVkocIzl3bcCElcOpsRW+BboKKHmUvh2VW
	 UpID4/pt/LWRA==
Received: from [192.168.68.112] (ppp118-210-65-51.adl-adc-lon-bras32.tpg.internode.on.net [118.210.65.51])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 47F2B64C85;
	Thu, 15 Aug 2024 08:26:03 +0800 (AWST)
Message-ID: <7e1dc98e0f69a095a8f7725b742df3c8d8436a67.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for AST2700
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Date: Thu, 15 Aug 2024 09:56:02 +0930
In-Reply-To: <OS8PR06MB7541BB03AEE90B090AB990B3F2872@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
	 <20240808075937.2756733-2-ryan_chen@aspeedtech.com>
	 <2f27285e-6aa5-4e42-b361-224d8d164113@kernel.org>
	 <OS8PR06MB75416FAD2A1A16E7BE2D255DF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <10809e91-31be-4110-86c1-1e1ccb05b664@kernel.org>
	 <OS8PR06MB7541F4F740FDB17F50EBCACBF2BA2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <20240813191454.GA1570645-robh@kernel.org>
	 <OS8PR06MB7541BB03AEE90B090AB990B3F2872@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-14 at 06:35 +0000, Ryan Chen wrote:
> > Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for
> > AST2700
> >=20
> > On Fri, Aug 09, 2024 at 06:10:22AM +0000, Ryan Chen wrote:
> > > > Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support for
> > > > AST2700
> > > >=20
> > > > On 09/08/2024 07:55, Ryan Chen wrote:
> > > > > > Subject: Re: [PATCH 1/4] dt-bindings: mfd: aspeed: support
> > > > > > for
> > > > > > AST2700
> > > > > >=20
> > > > > > On 08/08/2024 09:59, Ryan Chen wrote:
> > > > > > > Add compatible support for AST2700 clk, reset, pinctrl,
> > > > > > > silicon-id and example for AST2700 scu.
> > > > > > >=20
> > > > > > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > > > > > > ---
> > > > > > > =C2=A0.../bindings/mfd/aspeed,ast2x00-scu.yaml      | 31
> > > > > > +++++++++++++++++--
> > > > > > > =C2=A01 file changed, 29 insertions(+), 2 deletions(-)
> > > > > > >=20
> > > > > > > diff --git
> > > > > > > a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-
> > > > > > > scu.yaml
> > > > > > > b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-
> > > > > > > scu.yaml
> > > > > > > index 86ee69c0f45b..c0965f08ae8c 100644
> > > > > > > ---
> > > > > > > a/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-
> > > > > > > scu.yaml
> > > > > > > +++
> > > > > > > b/Documentation/devicetree/bindings/mfd/aspeed,ast2x00-
> > > > > > > scu.y
> > > > > > > +++ aml
> > > > > > > @@ -21,6 +21,8 @@ properties:
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0- aspeed,ast2400-scu
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0- aspeed,ast2500-scu
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0- aspeed,ast2600-scu
> > > > > > > +          - aspeed,ast2700-scu0
> > > > > > > +          - aspeed,ast2700-scu1
> > > > > >=20
> > > > > > What are the differences between these two?
> > > > >=20
> > > > > The next [PATCH 4/4] is scu driver that include ast2700-scu0
> > > > > and
> > > > > ast2700-scu1 CLK_OF_DECLARE_DRIVER(ast2700_soc0,
> > > > > "aspeed,ast2700-scu0", ast2700_soc0_clk_init);
> > > > > CLK_OF_DECLARE_DRIVER(ast2700_soc1, "aspeed,ast2700-scu1",
> > > > > ast2700_soc1_clk_init);
> > > >=20
> > > > What are hardware differences? Entirely different devices?
> > >=20
> > > AST2700 have two soc die connected each other.
> > > Each soc die have it own scu, so the naming is ast2700-scu0 for
> > > soc0,
> > another is ast2700-scu1 for soc1.
> >=20
> > Didn't I see in another patch one die is cpu and one is io? Use
> > those in the
> > compatible rather than 0 and 1 if so.
> >=20
> Sorry, I want to align with our datasheet description.=20
> It will but scu0 and scu1 register setting.=20

Can we document that relationship in the binding? Rob's suggestion
seems more descriptive.

Andrew

