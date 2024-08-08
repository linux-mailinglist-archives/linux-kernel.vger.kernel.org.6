Return-Path: <linux-kernel+bounces-278786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A3C94B4D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B9B281A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B614DDC1;
	Thu,  8 Aug 2024 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="i0k+zehy"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8EC8D1;
	Thu,  8 Aug 2024 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723082827; cv=none; b=abYjFnwpm5osv7ypoqibOQa4EMjifws9t4PIE0ZXUCfRuGUgvwcyHPLbWLxwUgoSPka9VFTAzw0Tb20+Fl1MTHHkAT0wFwIkKr7B6Fd3isoSIAQTuBQoNZb/s8VWm5cXmPpsRVYmwdRKU4Qdo4rWznoOV3kgQA+xq+SvXEB2nrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723082827; c=relaxed/simple;
	bh=4qENcLir85aZK+sKYvK4uPwZfWU5NY/e/5OhxcbJJ5k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHB+5wzdHCtzWp+Y5AVWZ3yZMuS73QX0NiZUwthSMN9iKYH0lhfTIi+GqxQqLfPlNzm+BFZwIifDk/bSdxWXvdlcQbP4Eja8jvGLbngI3/ONsjlayUsgI6aF5XI2suDo3MzGRIVrQSq1tqGUHa6iT09rET7s52xFtYbnInlpnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=i0k+zehy; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1723082823;
	bh=p3ilg2gVZJH5vdrihWiLoWQGJDaURTnTlqTiM9bPkdc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i0k+zehy7EYnSOH1LBCu2ZXr042s86faHL6a18sqyklBYvkjuBdesy4SifkdCWgwV
	 bjxCV0MBOnyrwzfDPzV3ksPZpGwP0Yf6CUZNSUhItL2a9ZhjZZIlmp53T0j7dS1XKV
	 k8hMX4Ps4facy8ufItJMg/Hf9QLOdEM8TFTEl7au2be6rYKRwVtuS74n/40PbBEKgZ
	 vJFoYyKL895DmSlEkbgAx77ti+eoQXA4a4xs7W4cOqvlLoA8jWTE/suLnQIVnFkdi5
	 SEIwEvskTms8O2Z2BhzmCTrxP7gGlPGGQEL6gr0fYbiCVQYsl+KykxZ8nlkEi253nS
	 jVAnv5kBTZdhQ==
Received: from [192.168.68.112] (203-57-213-111.dyn.iinet.net.au [203.57.213.111])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 34CF466F97;
	Thu,  8 Aug 2024 10:07:03 +0800 (AWST)
Message-ID: <35175ad3d24f86439f1cd87c733989d24dec3a5c.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] dt-bindings: misc: aspeed,ast2400-cvic: Convert to
 DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Date: Thu, 08 Aug 2024 11:37:02 +0930
In-Reply-To: <20240806172917.GA1836473-robh@kernel.org>
References: 
	<20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
	 <20240802-dt-warnings-irq-aspeed-dt-schema-v1-2-8cd4266d2094@codeconstruct.com.au>
	 <20240806172917.GA1836473-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-06 at 11:29 -0600, Rob Herring wrote:
> On Fri, Aug 02, 2024 at 03:06:31PM +0930, Andrew Jeffery wrote:
> > Address warnings such as:
> >=20
> >     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: interru=
pt-controller@1e6c0080: 'valid-sources' does not match any of the regexes: =
'pinctrl-[0-9]+'
> >=20
> > and
> >=20
> >     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/co=
pro-interrupt-controller@1e6c2000: failed to match any schema with compatib=
le: ['aspeed,ast2400-cvic', 'aspeed-cvic']
> >=20
> > Note that the conversion to DT schema causes some further warnings to
> > be emitted, because the Aspeed devicetrees are not in great shape. Thes=
e
> > new warnings are resolved in a separate series:
> >=20
> > https://lore.kernel.org/lkml/20240802-dt-warnings-bmc-dts-cleanups-v1-0=
-1cb1378e5fcd@codeconstruct.com.au/
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> >  .../bindings/misc/aspeed,ast2400-cvic.yaml         | 60 ++++++++++++++=
++++++++
> >  .../devicetree/bindings/misc/aspeed,cvic.txt       | 35 -------------
> >  2 files changed, 60 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic=
.yaml b/Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic.yaml
> > new file mode 100644
> > index 000000000000..3c85b4924c05
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/aspeed,ast2400-cvic.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/misc/aspeed,ast2400-cvic.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Aspeed Coprocessor Vectored Interrupt Controller
> > +
> > +maintainers:
> > +  - Andrew Jeffery <andrew@codeconstruct.com.au>
> > +
> > +description:
> > +  The Aspeed AST2400 and AST2500 SoCs have a controller that provides =
interrupts
> > +  to the ColdFire coprocessor. It's not a normal interrupt controller =
and it
> > +  would be rather inconvenient to create an interrupt tree for it, as =
it
> > +  somewhat shares some of the same sources as the main ARM interrupt c=
ontroller
> > +  but with different numbers.
> > +
> > +  The AST2500 also supports a software generated interrupt.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - aspeed,ast2400-cvic
> > +          - aspeed,ast2500-cvic
> > +      - const: aspeed,cvic
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  valid-sources:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description:
> > +      One cell, bitmap of support sources for the implementation.
> > +
> > +  copro-sw-interrupts:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description:
> > +      A list of interrupt numbers that can be used as software interru=
pts from
> > +      the ARM to the coprocessor.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - valid-sources
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
>=20
> Doesn't really look like this schema applies to this binding. Drop the=
=20
> ref.
>=20

Ack.

Thanks for the review.

Andrew
>=20

