Return-Path: <linux-kernel+bounces-247173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3CC92CC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA1B284C31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5A984A3E;
	Wed, 10 Jul 2024 07:45:30 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9E5CB8;
	Wed, 10 Jul 2024 07:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597530; cv=none; b=qaRhAe9lK3aQqALoXnI8Sva5+YTR1NkJ7F+fGy+8/PDHckVinqa2VvtMWtMZPvloBBAPFYUDegZgYgFHuR5GE5MJ0oobD9LUMtb6LpfEzU9BdpThy+QrADXU/8GwvVi/NiOVKG/7c6/SLxSZtfshODq4nLcGKoMuO4D75Qzu8mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597530; c=relaxed/simple;
	bh=v0u+NBCOCu11L7RWxJzi7dxcjwTBzFQc/JrZPo83fhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dA57DUGvCyu8btS8G8tsvZW170buQxeBbmN8LJyYBZqqrFeMZ3lbWVShUqYwI9GO6Mq+HYsOlM4o1wV7TdgmeIs/GtC5EISzyFH732vAVP7gJEFqaSs49/T1lXul1V1L14JlZsEEyEb5KuTx4ppWCwxVz9MWywMzKergl1jqnp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860d18.versanet.de ([94.134.13.24] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sRS0s-0005KV-SD; Wed, 10 Jul 2024 09:45:18 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: mturquette@baylibre.com, sboyd@kernel.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 quentin.schulz@cherry.de, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject:
 Re: [PATCH 1/6] dt-bindings: clocks: add binding for generic clock-generators
Date: Wed, 10 Jul 2024 09:45:17 +0200
Message-ID: <21244242.0c2gjJ1VT2@diego>
In-Reply-To: <12478313.O9o76ZdvQC@steina-w>
References:
 <20240709123121.1452394-1-heiko@sntech.de>
 <20240709123121.1452394-2-heiko@sntech.de> <12478313.O9o76ZdvQC@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Mittwoch, 10. Juli 2024, 09:02:34 CEST schrieb Alexander Stein:
> Am Dienstag, 9. Juli 2024, 14:31:16 CEST schrieb Heiko Stuebner:
> > In contrast to fixed clocks that are described as ungateable, boards
> > sometimes use additional clock generators for things like PCIe reference
> > clocks, that need actual supplies to get enabled and enable-gpios to be
> > toggled for them to work.
> 
> Fixed clocks are intended to be ungateable? Where does this come from?

"DOC: basic fixed-rate clock that cannot gate"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-fixed-rate.c#n18


> > This adds a binding for such clock generators that are not configurable
> > themself, but need to handle supplies for them to work.
> > 
> > While in a lot of cases the type of the IC used is described in board
> > schematics, in some cases just a generic type description like
> > "100MHz, 3.3V" might also be used. The binding therefore allows both
> > cases. Specifying the type is of course preferred.
> > 
> > The clock-frequency is set in devicetree, because while some clock
> > generators have pins to decide between multipls output rates, those
> > are generally set statically on the board-layout-level.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  .../bindings/clock/clock-generator.yaml       | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/clock-generator.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/clock-generator.yaml b/Documentation/devicetree/bindings/clock/clock-generator.yaml
> > new file mode 100644
> > index 0000000000000..f44e61e414e89
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/clock-generator.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/clock-generator.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Simple clock generators
> > +
> > +maintainers:
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  $nodename:
> > +    anyOf:
> > +      - description:
> > +          Preferred name is 'clock-<freq>' with <freq> being the output
> > +          frequency as defined in the 'clock-frequency' property.
> > +        pattern: "^clock-([0-9]+|[a-z0-9-]+)$"
> > +      - description: Any name allowed
> > +        deprecated: true
> > +
> > +  compatible:
> > +    oneOf:
> > +      - const: clock-generator
> > +      - items:
> > +          - enum:
> > +              - diodes,pi6c557-03b
> > +              - diodes,pi6c557-05b
> > +          - const: clock-generator
> > +
> > +  "#clock-cells":
> > +    const: 0
> > +
> > +  clock-frequency: true
> > +
> > +  clock-output-names:
> > +    maxItems: 1
> > +
> > +  enable-gpios:
> > +    description:
> > +      Contains a single GPIO specifier for the GPIO that enables and disables
> > +      the clock generator.
> > +    maxItems: 1
> > +
> > +  vdd-supply:
> > +    description: handle of the regulator that provides the supply voltage
> 
> So essentially only enable-gpios and vdd-supply is added in comparison to
> fixed-clock. Does it make sense to add that to the fixed-clocks instead?
> Similar to fixed-regulator.

I wasn't that sure which way to go in the first place.
The deciding point was reading that line about the fixed clock not
being gateable, so I opted to not touch the fixed-clock.

But you're definitly right, this _could_ live inside the fixed-clock
as well, if we decide to get rid of the not-gateable thing above.


Heiko





