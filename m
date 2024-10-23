Return-Path: <linux-kernel+bounces-377926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D969AC8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A16EB233D2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4611AA782;
	Wed, 23 Oct 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CB+90bj4"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B46155C8A;
	Wed, 23 Oct 2024 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681717; cv=none; b=ZePAR5ucfzF2mC3gI3GBwmZk3vaWLPazOWLyml0NiHhQBEWYawy7IfATitq0tBOX1nuZHKV1gprzHSCWPwOx9zlZlk7BH2tBKSz2WzKUrKZ8xtA9UIEX3NtFm+8rlf3+K3GS+PmpkkKPkUIrPL1QczrIkDIdGV/bpm5uEPzlxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681717; c=relaxed/simple;
	bh=pN//8a7g7bfdLfHq2cM5u6R7d+imZbvdCC0AID8/L0A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=ZXyWIDIPQswr5NI+BCSWhsyPkIqpMgq+RHMWRbTNXnQmgbnjY+bBfvXLsLNtOmbAJfoZeglG5jC4Dhv82UTNaj63rRpnFUlsy1Q5e4pxqYqiKObJSfHHVBkDuc7ajreS/8XVo6B10QVf7u5c8D8OFdH/IF/VxfgSAl1TEm8wRRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CB+90bj4; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0394CFF802;
	Wed, 23 Oct 2024 11:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729681712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBBoAWO+fKiBWsXjvA4VsvZItAxe5Mtw02VtL/FZTo0=;
	b=CB+90bj4jTYJv8HVq5ir4FyEzkJzE0SGwq3u47pvdrB0+HEgUgon7ZvFFyRo8uJRZChsxH
	FoGnmTE6ihrZF2XRLEiNozTG4flZBD7+Zsh0MZGe0qj7t85FdMQPe73Ddd1xmA2wUcUqyV
	DuWn/AJtOfPuliF5mCS5M6T5PD94rLewvQqFZ6lufOpli78CErT4kwAw19AoBO8MfBhsXy
	G+sL0u9jmTOm+qd8jUDw5Q9Q8CH5fz1SuDXc/+67FFG/ypQIw3k5Z9I+hRwLM6aatcaChJ
	8gCXtr1QACag1AeVqXA+cTIs6UEo3DOXvnbnjTDbPvaIm14eEBmk7ohDaAAlNw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Oct 2024 13:08:31 +0200
Message-Id: <D534ZSNLN6G0.3HSREQ803OFIQ@bootlin.com>
Cc: <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Stephen Boyd" <sboyd@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Michael Turquette"
 <mturquette@baylibre.com>, "Rob Herring" <robh@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 4/4] clk: eyeq: add driver
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com>
 <20241007-mbly-clk-v5-4-e9d8994269cb@bootlin.com>
 <b3f8bf0e933064a49d1a5e3527646200.sboyd@kernel.org>
In-Reply-To: <b3f8bf0e933064a49d1a5e3527646200.sboyd@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Stephen,

On Thu Oct 17, 2024 at 8:48 PM CEST, Stephen Boyd wrote:
> Quoting Th=C3=A9o Lebrun (2024-10-07 06:49:19)
> > +/* Required early for GIC timer (pll-cpu) and UARTs (pll-per). */
> > +static const struct eqc_pll eqc_eyeq5_early_plls[] =3D {
> > +       { .index =3D EQ5C_PLL_CPU, .name =3D "pll-cpu",  .reg64 =3D 0x0=
2C },
> > +       { .index =3D EQ5C_PLL_PER, .name =3D "pll-per",  .reg64 =3D 0x0=
5C },
> > +};
> > +
> > +static const struct eqc_early_match_data eqc_eyeq5_early_match_data __=
initconst =3D {
> > +       .early_pll_count        =3D ARRAY_SIZE(eqc_eyeq5_early_plls),
> > +       .early_plls             =3D eqc_eyeq5_early_plls,
> > +       .nb_late_clks =3D eqc_eyeq5_match_data.pll_count + eqc_eyeq5_ma=
tch_data.div_count,
> > +};
> > +
> > +/* Required early for GIC timer. */
> > +static const struct eqc_pll eqc_eyeq6h_central_early_plls[] =3D {
> > +       { .index =3D 0, .name =3D "pll-cpu", .reg64 =3D 0x02C },
> > +};
> > +
> > +static const struct eqc_early_match_data eqc_eyeq6h_central_early_matc=
h_data __initconst =3D {
> > +       .early_pll_count        =3D ARRAY_SIZE(eqc_eyeq6h_central_early=
_plls),
> > +       .early_plls             =3D eqc_eyeq6h_central_early_plls,
> > +       .nb_late_clks =3D 0,
> > +};
> > +
> > +/* Required early for UART. */
>
> I still don't get this. UART isn't an early device. It's only the
> interrupt controller and the timer that matter. Does MIPS do something
> special for UARTs?

Our hardware has a PL011. That is AMBA stuff; they get probed before
platform devices by of_platform_bus_create(). "pll-per" on EyeQ5 must
be available at that time.

In concrete terms, if we don't register pll-per on EyeQ5 at
of_clk_init(), we stare at void because the serial fails probing.
I haven't digged into why EPROBE_DEFER doesn't do its job. Anyway we
don't want our serial to stall for some time during our boot process.

Thanks for the extensive review! New revision is in your inbox.

Thanks,
Th=C3=A9o

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


