Return-Path: <linux-kernel+bounces-236652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2D891E564
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5687D282A48
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264F316DC21;
	Mon,  1 Jul 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JT/7HuBB"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D8B14D2AC;
	Mon,  1 Jul 2024 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851468; cv=none; b=kXDUotvwWLYc0BZGC9CXWhbu939XC9s9YCPaMXmwiydeJdwQ3nOCyav8t+Xulg2BnoNp+armnN9ADqzA+sa8g0oaseMRh3alrUuP++W+nCFJrSmDOqMncXBjzbPO4uk9SRrNv0qBr2EkIhbPTHJ/kLADrDUZbzjJjoFddveZfYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851468; c=relaxed/simple;
	bh=9pyJvPtweb1UHSGE+8KU62A6fqLPa5bzsQ1lE0/LcU0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Oe+p993rJwVqp6DES6psMLXPU0By+Ozu7y4NzBH+g/1Lmy6DbYSJa39a32kM8f9O132Cvci6WrtbHozhd5qmlSunlfbi26kR+Fk4nBBPzUhZcz8ouxGDLEFr7v02Tnq4YQmncby86pgcflIn4XB5ZbOvztLhSP85phYGSm6aKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JT/7HuBB; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A44F320005;
	Mon,  1 Jul 2024 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719851464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pyJvPtweb1UHSGE+8KU62A6fqLPa5bzsQ1lE0/LcU0=;
	b=JT/7HuBBhBruZABWwdrYHaof3kr2CIBvYXpPf4wr1GJpwr2XbNjvzVtkA6rQqclFs+npbl
	gc2aOIoAkc955HAVqHq3PVlT0wg1C2ifdZGqjfHAoitjZMFJz10P2mBcg7RvWo1mCAFNyO
	8LvIvXHKMX0eJjHO2LpjkYtucxYBT0QLwjkAHVcgqVtB2zV4/MXLF592ysxzQny76lp2/F
	T8GSDcl8cpKS+LT0L2xvE/P3Jyvqea0MhnNDDHh8cr5rDudb+el41fKz91s2JZ0FmValVS
	pVYZJxGsaxTBTKy/qU3eXje4bitHxfHGONcwuL4T2EaDCarZ6QM9kTUJMLPS3g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 18:31:03 +0200
Message-Id: <D2ECGMYXJWZ9.GNRJ1NAG4MF8@bootlin.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 1/4] Revert "dt-bindings: clock: mobileye,eyeq5-clk: add
 bindings"
Cc: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
X-Mailer: aerc 0.17.0
References: <20240628-mbly-clk-v1-0-edb1e29ea4c1@bootlin.com>
 <20240628-mbly-clk-v1-1-edb1e29ea4c1@bootlin.com>
 <2846186f-a0e1-4cd3-85bf-f029053bf98c@kernel.org>
In-Reply-To: <2846186f-a0e1-4cd3-85bf-f029053bf98c@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Krzysztof,

On Mon Jul 1, 2024 at 11:14 AM CEST, Krzysztof Kozlowski wrote:
> On 28/06/2024 18:10, Th=C3=A9o Lebrun wrote:
> > Switch from one sub-node per functionality in the system-controller to =
a
> > single node representing the entire OLB instance. This is the
> > recommended approach for controllers handling many different
> > functionalities; it is a single controller and should be represented by
> > a single devicetree node.
> >=20
> > The clock bindings is removed and all properties will be described by:
> > soc/mobileye/mobileye,eyeq5-olb.yaml
> >=20
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
> This is v1, so where did this happen?

This is a split of the previous Mobileye EyeQ5 system-controller series.

I started my cover letter [4] by mentioning it. I should most probably
have kept incrementing on the previous version number, sorry about
that.

Relevant extract from this series' cover letter:

On Fri Jun 28, 2024 at 6:10 PM CEST, Th=C3=A9o Lebrun wrote:
> This is a new iteration on the Mobileye system-controller series [0].
> It has been split into separate series to facilitate merging.
[...]
> Related series are targeted at reset [1], pinctrl [2] and MIPS [3].
[...]
> [0]: https://lore.kernel.org/lkml/20240620-mbly-olb-v3-0-5f29f8ca289c@boo=
tlin.com/
> [1]: https://lore.kernel.org/lkml/20240628-mbly-reset-v1-0-2a8294fd4392@b=
ootlin.com/
> [2]: https://lore.kernel.org/lkml/20240628-mbly-pinctrl-v1-0-c878192d6b0a=
@bootlin.com/
> [3]: https://lore.kernel.org/lkml/20240628-mbly-mips-v1-0-f53f5e4c422b@bo=
otlin.com/

Regards,

[4]: https://lore.kernel.org/lkml/20240628-mbly-clk-v1-0-edb1e29ea4c1@bootl=
in.com/

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


