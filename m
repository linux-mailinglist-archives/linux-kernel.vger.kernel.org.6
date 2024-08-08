Return-Path: <linux-kernel+bounces-278782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8622F94B4CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD64B2232A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34DDBA2E;
	Thu,  8 Aug 2024 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hbNSVSS8"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F38F6E;
	Thu,  8 Aug 2024 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723082538; cv=none; b=U/8pGTAAL9rlg7vzmrtWjkSf3x+9r18XGOLn+Kd96SFAYAb2PVpjdaweOim2AvTUV6dB7oH1g5NI4mXzHbIMCtwnSdXH+wnNt6rOLXJX9tNkS4bhuNqfStVd8aooqxIoZBGwTu2RAsO4swVx8JiC07NOiERb6ickMtAYrsYQ5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723082538; c=relaxed/simple;
	bh=Nu5WgkpUo7byHQ6juT2SsED31AyTDd20my9mSyBHT+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ruZr/kwdc95IjFiSIAa2k7PI82kN0HyDPzJzrImya/Jpm0JNMAalbPgmo8sXc1tdLpRFg5Dq0enOzMHf5jGg37GIttkVDABjVjekkOaWq0dFPI52MO88iqioLcpsBrgXrYW8e8KMqtSiJDpEUTIO2CFYSarGKyiFmisBg+PPay8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hbNSVSS8; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1723082527;
	bh=xeBzGU5DTBwHDca/OreT1bQLesgiFRjH3NSbGQuJpLs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hbNSVSS8FuAodoVkZ0Ir/7WxJyNLX++H51FwksLk0g2vg35TWCVxko2msf1QFIE9G
	 VVKVkTt1P+rlM5gSWQP33zTNY2wAxqHrqHobycDEKBTQq42NPHVEmcNzLD2IXJu5M9
	 mwlJskVx3MisbQexHG4i9Lf/2WMPMtelC+INwEG3w81LgGZxJmXP/VJQxjlscmowxD
	 FFKyLTXRjooNTBBg3udS7FIZY2n6bkQrOYCgO4yjgvZu5+tsVlWcNxNjnhUbRhL/Bo
	 /ok4e7iWt5adUfNSZGoFnXOADNXDAkTmCqfM04ZyZmcquee6JOzQmAvrdWTMc7lK7w
	 8WUuvlc1c6qKQ==
Received: from [192.168.68.112] (203-57-213-111.dyn.iinet.net.au [203.57.213.111])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 09C95656AB;
	Thu,  8 Aug 2024 10:02:04 +0800 (AWST)
Message-ID: <18a932d777d1b3b86af15e80af82b50d2189872f.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller:
 aspeed,ast2400-vic: Convert to DT schema
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Joel Stanley
 <joel@jms.id.au>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Date: Thu, 08 Aug 2024 11:32:04 +0930
In-Reply-To: <c51fb027-f8bd-4b10-b9c0-dbbe8e8cf4c1@kernel.org>
References: 
	<20240802-dt-warnings-irq-aspeed-dt-schema-v1-0-8cd4266d2094@codeconstruct.com.au>
	 <20240802-dt-warnings-irq-aspeed-dt-schema-v1-1-8cd4266d2094@codeconstruct.com.au>
	 <c51fb027-f8bd-4b10-b9c0-dbbe8e8cf4c1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-06 at 08:07 +0200, Krzysztof Kozlowski wrote:
> On 02/08/2024 07:36, Andrew Jeffery wrote:
> > Squash warnings such as:
> >=20
> >     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/in=
terrupt-controller@1e6c0080: failed to match any schema with compatible: ['=
aspeed,ast2400-vic']
> >=20
> > The YAML DT schema defines an optional property, valid-sources, which
> > was not previously described in the prose binding. It is added to
> > document existing practice in the Aspeed devicetrees. Unfortunately
> > the property seems to predate the requirement that vendor-specific
> > properties be prefixed.
> >=20
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>=20
>=20
> > +
> > +description:
> > +  The AST2400 and AST2500 SoC families include a legacy register layou=
t before
> > +  a redesigned layout, but the bindings do not prescribe the use of on=
e or the
> > +  other.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2400-vic
> > +      - aspeed,ast2500-vic
> > +
> > +  interrupt-controller: true
> > +
> > +  "#interrupt-cells":
> > +    const: 1
> > +    description:
> > +      Specifies the number of cells needed to encode an interrupt sour=
ce. It
> > +      must be 1 as the VIC has no configuration options for interrupt =
sources.
> > +      The single cell defines the interrupt number.
> > +
> > +  valid-sources:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description:
> > +      One cell, bitmap of support sources for the implementation.
>=20
> maxItems: 2

Ack.

> What does "one cell" mean? uint32? DTS has two items.

Hah, I think that was a process error :) Two is correct here. I'll
rework the description.

>=20
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
>=20
> Is this correct? DTS does not have parent interrupt controller for this
> device.

I'll removed it, it's not necessary.

>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupt-controller
> > +  - "#interrupt-cells"
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    interrupt-controller@1e6c0080 {
> > +         compatible =3D "aspeed,ast2400-vic";
> > +         reg =3D <0x1e6c0080 0x80>;
> > +         interrupt-controller;
> > +         #interrupt-cells =3D <1>;
>=20
> Make the example complete - add valid-sources interupts.
>=20

Ack.

Thanks for the review.

Andrew

