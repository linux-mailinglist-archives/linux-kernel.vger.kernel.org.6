Return-Path: <linux-kernel+bounces-278850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AEA94B5A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FAD1C209BB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E745777103;
	Thu,  8 Aug 2024 03:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="l2Ksm/2O"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1894765C;
	Thu,  8 Aug 2024 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723089182; cv=none; b=LJBWWr33GVA1rlRBExU+qiJFrneE1y6JKN62Tnw2Kvso+niJw+4oniUkFh9bhVqtdV3KPaUOWTaD6WszL/oRBv5s4YEAxuur6mhrN5QtuTKwEvfTUaFM1JjCFuPOU3h9VnZYxP7CBad3pzHeB4BqD7GYxzD5cWuq2xYb8D53m3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723089182; c=relaxed/simple;
	bh=mKvKk5DFxoR7aBQUWNoQvmNXEnb2wpuLR8U0rARmRNo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RR8fuMsz3HWMKlE0AYp/FKclwsAmeRLJJixUOd5kqfu8sogXAYDunQvxCHG/sAOClxVALSPpuEky7xObajuIjlqPDsnbTSu3+vY9jj1CTv1OgUC2HVYKPWnZMfMtqP4QAmJgWTOUUA2RVNrhYLSrSB5271aDPLwVJAXyHcNPMjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=l2Ksm/2O; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1723089176;
	bh=PosnylbE4Y7ewXvd+zX7wq2nvzxbsSbmn+ew7CfQ/SM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l2Ksm/2O4zEyMfZ/Bqws1Ow6EYrwShNr+Mci1PzlplSz5cAZXnwPOZCOW7ge7ROFT
	 Yn54QhVOOfirUObYnPi1ClLRGBiDVpV38wh9AKXoqmNGhL+erEGZV8xi5IxRJUbYQz
	 tOFP1OLk5rLj3uTV09U2fGE59CuTH0L82y1ox88+74/r0/RXhGVCbZ/R9Mdfk5D9wD
	 87XtbUIeP0LaGDqHbOG6qXD1R2c8KS3+hzxwU2HiCf4Y99t02xd9wv8IHVJKPsngFn
	 SSL6McwgNZyoinMaYd/7mELVOzIPxWWFggu38V43zMr0laoex2QLyJKyRxZXYsuN48
	 /Q9RHkFq+zVwg==
Received: from [192.168.68.112] (203-57-213-111.dyn.iinet.net.au [203.57.213.111])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EA77A654E9;
	Thu,  8 Aug 2024 11:52:53 +0800 (AWST)
Message-ID: <211294ed76c23c55518015f4beedeb6efa63d540.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] dt-bindings: misc: aspeed,ast2400-cvic: Convert to
 DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Joel Stanley
 <joel@jms.id.au>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Date: Thu, 08 Aug 2024 13:22:53 +0930
In-Reply-To: <4d26bde0bda7cb1d44958d967c4b0c2da5b2abc4.camel@codeconstruct.com.au>
References: 
	<20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
	 <20240802-dt-warnings-irq-aspeed-dt-schema-v1-2-8cd4266d2094@codeconstruct.com.au>
	 <ec19fe07-84bd-4c32-a886-e6126af52f4c@kernel.org>
	 <4d26bde0bda7cb1d44958d967c4b0c2da5b2abc4.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 11:36 +0930, Andrew Jeffery wrote:
> On Tue, 2024-08-06 at 08:12 +0200, Krzysztof Kozlowski wrote:
> > On 02/08/2024 07:36, Andrew Jeffery wrote:
> > > Address warnings such as:
> > >=20
> >=20
> >=20
> > > +description:
> > > +  The Aspeed AST2400 and AST2500 SoCs have a controller that provide=
s interrupts
> > > +  to the ColdFire coprocessor. It's not a normal interrupt controlle=
r and it
> > > +  would be rather inconvenient to create an interrupt tree for it, a=
s it
> > > +  somewhat shares some of the same sources as the main ARM interrupt=
 controller
> > > +  but with different numbers.
> > > +
> > > +  The AST2500 also supports a software generated interrupt.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - aspeed,ast2400-cvic
> > > +          - aspeed,ast2500-cvic
> > > +      - const: aspeed,cvic
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  valid-sources:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    description:
> > > +      One cell, bitmap of support sources for the implementation.
> >=20
> > maxItems: 1
> > (and drop "One cell" - no need to repeat constraints in free form text)
>=20
> Ack to both.
>=20
> >=20
> > BTW, for both bindings, I do not see any user in the kernel. Why is thi=
s
> > property needed in the DTS?
>=20
> Good question. This is a hangover from when benh was involved in the
> Aspeed kernel port.
>=20
> Given it's specified in the prose binding and the devicetrees contain
> the property I'll leaving it in for now, but I think it's something we
> could consider removing down the track.
>=20
> >=20
> > > +
> > > +  copro-sw-interrupts:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >=20
> > uint32? I do not see anywhere usage as an array. The in-kernel driver
> > explicitly reads just uint32.
>=20
> You're right, and in the context of the hardware an array doesn't make
> sense here. I'll switch it to a uint32.
>=20

Actually, on further inspection, the description says the property
should contain a list of interrupt _numbers_ (the hardware exposes 32
software drive-able interrupt bits). Given aspeed-g5.dtsi only lists
the single value '1' the intent feels somewhat murky. When I wrote the
reply above I had in my head that it was a bitmask like valid-sources
but the description suggests that's not true. I'm not sure the
described behaviour was chosen to be different to valid-sources,
however, for the co-processor, index 1 is an interrupt from the main
ARM core. Perhaps it felt less tedious just to write the index and not
the mask.

I'm going to backtrack on my reply above leave this as uint32-array
with `maxItems: 32` to meet the intent of the description. If there are
problems down the track we can consider the driver to have a bug with
respect to the binding (I don't think there's much risk there though).

Andrew

