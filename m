Return-Path: <linux-kernel+bounces-278785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC6694B4D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5DBB2232D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EECD530;
	Thu,  8 Aug 2024 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LHsZlJgo"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603B78F6E;
	Thu,  8 Aug 2024 02:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723082793; cv=none; b=U16i7jXrEzeRf7kRf7lfuTGtw/j1/wlAYcspPUCfuw7qGeXwotLP9HjmegdmdH4FKIh8Juw20m9Y10Kec3jL9jLAxKCvxD05t2315Cvg2vyi+S+zWTyX+2yjYen5abzU+GFLtS1JlRv1qAfvVd6+Wz90WWn7iFlrUMEA9uNbj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723082793; c=relaxed/simple;
	bh=JBdg6JXfCp38NgqsLBqTczGG/krMK0JxDUiKEO/2sH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h4J0qHIMU0YDDREY0tExCcG3TzMR5Xpww5fsk86DgrP5e4/wJVtXoV9gUbekhNYS/LBkYNLcg03UbXmtTyh613rxIYQf6XeXDL2C7/0MXGRTlZnszXooPmk2qIzFCyjQNGmFll+s1AZhhDDYmPi/wJ0RCUrIdbHPYDbPpOkIIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LHsZlJgo; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1723082789;
	bh=OnyU4K9Xs3OQ6gjOrSz6jTsZs25qhB/EPzhnB51St3U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LHsZlJgoxe2y22kAI9EN4j+HNry8kSr3WF2Od0kH5bmtymF7vLHaKSmj2xnzH6zc7
	 Vc3iX6jMT1QztIpxXfMFEJRVam4nLKamu1TDi/cmZMlfSptW9gtXRWBynGfLzvVDoV
	 98WI63bq6l72+k4JF6/Bk3+km79IHArILkFHmDvqp5mjMJma2EHn70Qf53yvkzLJCX
	 7AelvkqsrM7a4bdr5sAnpEMxGK3dp1QWQmgIADUKvrpK2ugsrnJhE1BqVPMhLpPJJJ
	 9ebml7Gr1q17RVD+8xpsyiSeySQmOBaP+JNv0gJMAZN5EiUcqr1V4Io4mQySZompv8
	 744nsHhAWMy8w==
Received: from [192.168.68.112] (203-57-213-111.dyn.iinet.net.au [203.57.213.111])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8C20B66F97;
	Thu,  8 Aug 2024 10:06:28 +0800 (AWST)
Message-ID: <4d26bde0bda7cb1d44958d967c4b0c2da5b2abc4.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] dt-bindings: misc: aspeed,ast2400-cvic: Convert to
 DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Joel Stanley
 <joel@jms.id.au>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Date: Thu, 08 Aug 2024 11:36:28 +0930
In-Reply-To: <ec19fe07-84bd-4c32-a886-e6126af52f4c@kernel.org>
References: 
	<20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
	 <20240802-dt-warnings-irq-aspeed-dt-schema-v1-2-8cd4266d2094@codeconstruct.com.au>
	 <ec19fe07-84bd-4c32-a886-e6126af52f4c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-06 at 08:12 +0200, Krzysztof Kozlowski wrote:
> On 02/08/2024 07:36, Andrew Jeffery wrote:
> > Address warnings such as:
> >=20
>=20
>=20
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
>=20
> maxItems: 1
> (and drop "One cell" - no need to repeat constraints in free form text)

Ack to both.

>=20
> BTW, for both bindings, I do not see any user in the kernel. Why is this
> property needed in the DTS?

Good question. This is a hangover from when benh was involved in the
Aspeed kernel port.

Given it's specified in the prose binding and the devicetrees contain
the property I'll leaving it in for now, but I think it's something we
could consider removing down the track.

>=20
> > +
> > +  copro-sw-interrupts:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
>=20
> uint32? I do not see anywhere usage as an array. The in-kernel driver
> explicitly reads just uint32.

You're right, and in the context of the hardware an array doesn't make
sense here. I'll switch it to a uint32.

Thanks for the review.

Andrew

