Return-Path: <linux-kernel+bounces-449948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA0F9F58A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860F91894702
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AAB1F9F62;
	Tue, 17 Dec 2024 21:16:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446881F471A;
	Tue, 17 Dec 2024 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734470164; cv=none; b=QhC4HN88zUhKumSUIAOyMLUDM4KLdThe2KJ65cqovyEMfGmV6wLCrGJJGZ8WqZ2PLs4LE8T5S5xTO0e8NHpnFjYWG0eLNim136ikQIxWPGgvOdd70wYj0wH1swcAsxsuhf0RD0THgCrMuf8fEUXUXW583oAzU6jRzMAd+/D7JRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734470164; c=relaxed/simple;
	bh=UKaP4RT1362Jn3OfLDudS6vvatZTlO6Za7PX7nGwm7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwfBpHozeRV8rLzj8IK7zwHXcciK/Wo6Ef+q4dizK8ibMpbdGCxzcQtPTj1KhEOgTcTUxJzyRwUgsyJ4wTVvldsY6WiODi0yCUSiCM7TJvIJ4N3AcxgZBmELtTASm531/flzqai3x6YVMJUbCvCzzCTlD2aiNboj3EXCVbRWCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A68DEFEC;
	Tue, 17 Dec 2024 13:16:27 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 621913F7B4;
	Tue, 17 Dec 2024 13:15:57 -0800 (PST)
Date: Tue, 17 Dec 2024 21:15:05 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Roman Beranek <me@crly.cz>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: sunxi: Export PLL_VIDEO_2X and
 PLL_MIPI
Message-ID: <20241217211505.7f9c9e4e@minigeek.lan>
In-Reply-To: <CA+E=qVeQ8uHBCeFtw6_2cY3252-YXc6eWrf5_YdeVgbp5LJo5g@mail.gmail.com>
References: <20241215053639.738890-1-anarsoul@gmail.com>
	<20241215053639.738890-2-anarsoul@gmail.com>
	<qbtp4jvkx3r5azufe4k3vtapqpfs54dyjiu4cy5v5wkkzumrzx@vy3xzkfplbue>
	<CA+E=qVeQ8uHBCeFtw6_2cY3252-YXc6eWrf5_YdeVgbp5LJo5g@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Dec 2024 10:00:45 -0800
Vasily Khoruzhick <anarsoul@gmail.com> wrote:

Hi,

> On Mon, Dec 16, 2024 at 11:33=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >
> > On Sat, Dec 14, 2024 at 09:34:57PM -0800, Vasily Khoruzhick wrote: =20
> > > These will be used to explicitly select TCON0 clock parent in dts
> > >
> > > Fixes: ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in TC=
ON0 mux")
> > > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > > ---
> > >  drivers/clk/sunxi-ng/ccu-sun50i-a64.h      | 2 --
> > >  include/dt-bindings/clock/sun50i-a64-ccu.h | 2 + =20
>=20
> Hi Krzysztof,
>=20
> > You cannot combine these changes. =20
>=20
> The patch basically moves defines out from ccu-sun50i-a64.h to
> sun50i-a64-ccu.h. How do I split the change without introducing
> compilation failure?

You can just have the binding part first, adding the (same) definition
to the binding headers. As long as the #define's are not conflicting,
this is fine.
Then remove the now redundant definitions in the kernel headers, with a
subsequent patch.

Cheers,
Andre


>=20
> > Please run scripts/checkpatch.pl and fix reported warnings. Then please
> > run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
> > Some warnings can be ignored, especially from --strict run, but the code
> > here looks like it needs a fix. Feel free to get in touch if the warning
> > is not clear. =20
>=20
> Yeah, it is not clear what do you want me to do, assuming the previous
> similar change to sun50i-a64-ccu.h did essentially the same, see
> 71b597ef5d46a326fb0d5cbfc1c6ff1d73cdc7f9
>=20
> Regards,
> Vasily
>=20
> > Best regards,
> > Krzysztof
> > =20
>=20


