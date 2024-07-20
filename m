Return-Path: <linux-kernel+bounces-258052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F409382C5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 22:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C1C1C216C9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 20:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EA614900B;
	Sat, 20 Jul 2024 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cSLgwC4g"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B74914884F;
	Sat, 20 Jul 2024 20:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721505666; cv=none; b=SzupY9qOldBuog6bdV5Ur63OYxR5rBa/eedJ/QHpP8FVTShcDo5BjcShVdkK20uaeTFvIDofuvybVQoXAX2NmcxSk/quIempgvjyBvBjgIkGjtHiX+hNP3N/Hty92MYTAV9Shs9Bp2Q9tk3thtuHF2V+yKaTG4yK+Wog7qcsmXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721505666; c=relaxed/simple;
	bh=sFZEn+q5HsOAqJ+tlX3m4UQ/xNniXeOzc8CG0pK6edE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtPdbBmUM+8kURHpaP0jQJgT1HzOa4jBWUiA/XdaHWxhaVfChLDbnq8F+YPgXDExByLD6eFDOCKqxmC6lXVBGM2IUmKPQMzZSYblcQfYXWObqKGtR0fg+4LJ6cPadwqbiQ8JIUha1rI0nXk5ZSnEujdyw6WdpPRE+aMNdAJrpLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=cSLgwC4g; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721505662; x=1721764862;
	bh=YmbnTSVayuh9xCsUezkE054ocy3nyuaaKWSdB0kEoFs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cSLgwC4gi+se0y0KCM3doAGXdpLJm29ewhKn7tK5tF13FZ+lS6iZHV5s2UHeFAZqs
	 DfY3lYfKwdv9EBDObG+fhkXqnKbnyud1DGjoCHndxXssZs4F7YZfjysa3j2VH47nCF
	 rpSE86hm36nOTYbntG2O3/EQ7+kmjORq7d8TJFEX9Fa1kgY0w/Yquh7MkmJXsk1R+1
	 CYyNobRn2Dof6+Q4NUbkGPm55oMxCnepHjTqj94BNQ2LgmuMIsYCsNGBzWL1QSuElT
	 VSK0NUllbF+r1FOYd5rG/1jNE4mXWGeyjLGt+E33mGJ27veDL+D1Gsm9D8/m9PnDDI
	 33gO+aJWHxZyg==
Date: Sat, 20 Jul 2024 20:00:45 +0000
To: Rob Herring <robh@kernel.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/7] dt-bindings: clock: xilinx: add description of user monitor interrupt
Message-ID: <D2UMTF78IDUQ.IWXPEKIF0MAU@protonmail.com>
In-Reply-To: <20240720143708.GA239850-robh@kernel.org>
References: <20240720120048.36758-1-hpausten@protonmail.com> <20240720120048.36758-5-hpausten@protonmail.com> <20240720143708.GA239850-robh@kernel.org>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: aef34513ce9d61c0df9f689adb1cde03b2dc7ae1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Jul 20, 2024 at 3:37 PM BST, Rob Herring wrote:
> On Sat, Jul 20, 2024 at 12:01:48PM +0000, Harry Austen wrote:
> > This Xilinx clocking wizard IP core outputs this interrupt signal to
> > indicate when one of the four optional user clock inputs is either
> > stopped, overruns, underruns or glitches.
> >
> > This functionality was only added from version 6.0 onwards, so restrict
> > it to particular compatible strings.
> >
> > Signed-off-by: Harry Austen <hpausten@protonmail.com>
> > ---
> >  .../bindings/clock/xlnx,clocking-wizard.yaml  | 22 ++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wiza=
rd.yaml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> > index 9d5324dc1027a..4609bb56b06b5 100644
> > --- a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> > +++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> > @@ -62,17 +62,37 @@ required:
> >    - xlnx,speed-grade
> >    - xlnx,nr-outputs
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - xlnx,clocking-wizard-v6.0
> > +            - xlnx,versal-clk-wizard
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          items:
> > +            - description: user clock monitor interrupt
> > +
> > +        interrupt-names:
> > +          items:
> > +            - const: monitor
>
> Properties need to be defined at the top-level (outside the if/then
> schema), then restricted here.

Makes sense. Will do in v2.

Thanks for the review!

>
> > +
> >  additionalProperties: false
> >
> >  examples:
> >    - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> >      clock-controller@b0000000  {
> > -        compatible =3D "xlnx,clocking-wizard";
> > +        compatible =3D "xlnx,clocking-wizard-v6.0";
> >          reg =3D <0xb0000000 0x10000>;
> >          #clock-cells =3D <1>;
> >          xlnx,speed-grade =3D <1>;
> >          xlnx,nr-outputs =3D <6>;
> >          clock-names =3D "clk_in1", "s_axi_aclk";
> >          clocks =3D <&clkc 15>, <&clkc 15>;
> > +        interrupts-extended =3D <&intc 52 IRQ_TYPE_EDGE_RISING>;
> > +        interrupt-names =3D "monitor";
> >      };
> >  ...
> > --
> > 2.45.2
> >
> >


