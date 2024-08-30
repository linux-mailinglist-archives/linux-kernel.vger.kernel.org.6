Return-Path: <linux-kernel+bounces-309527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EAB966C54
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EFB284D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED501C1AC9;
	Fri, 30 Aug 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb/BnSF9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D11C1AB2;
	Fri, 30 Aug 2024 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056848; cv=none; b=PWC/0TZ5WNWFAebfgt8OOyvo6OHs2Rkym/Sl5r003WaqN1xnbxVKyxaGiDpSFWQC8haQiGn8Q6LoSCKmZb+1Lpugyh6UQndhto29T1Kxoi/Xg6PEprHQNd+yDO3wLN4q3iCYr3vWsPw/mQa5pXgSOmWqBOyIg96yRhXUL+ReNak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056848; c=relaxed/simple;
	bh=g/nQQCp6AK3traRxcfLlXkc/ho/0LhHnh3lCJ34af04=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JSiriH7bpRnQQ1qtAQ8y1Kdo6bSZntCpIsrr7sZ6MVdKqEEwdwPNl66pNaVZZ291s7//KmvyePsXiMwSzzEl8aK5g/j/i95WiD0WSqgQnt7zBLxZI/7cnYoDCS8SzdSo1TcEZ6kSzvEGE76zyHWRGbVJNfhzQIgQKCayG0HIbtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb/BnSF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A441BC4CEC2;
	Fri, 30 Aug 2024 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725056847;
	bh=g/nQQCp6AK3traRxcfLlXkc/ho/0LhHnh3lCJ34af04=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Fb/BnSF9lSfpbQEHcj/Q+pu+3IAYKqPCBSFj100U71Nyv6rhTINPSZBAKnFGoBx0p
	 zgUN/masru/l2SrOzYbAsju3xsKj7m/ki627iJi4lWq8s3H0Qa7yzi+vPRansF0gLj
	 yUYorGBTVpttT+OQ/LgogAdex+J5NhKu2hLDfid/yoSF0ICp/qtuf56IjP1pWlYwCa
	 SNpeoItwVpIqTviMurjDxej+AKve0zxf2841oTAiMrrQmJ9UwYNti5s0gIWq+4Ubrf
	 y8GBVG5iicHVRq1tMerypa7inA46EiQDYHnppqQyWdLEC6m+XeTtGJ78Gsnrj0a5XE
	 4cte/s7qGk3jA==
Message-ID: <79cb209c6c5a14ae4d6a015f714c58d4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a87f99e02f3e9c40c8b9638a8a5a9c5b55aca68c.camel@maquefel.me>
References: <20240715-ep93xx-v11-0-4e924efda795@maquefel.me> <20240715-ep93xx-v11-3-4e924efda795@maquefel.me> <020c15c9939c1c4cfac925942a582cee.sboyd@kernel.org> <a87f99e02f3e9c40c8b9638a8a5a9c5b55aca68c.camel@maquefel.me>
Subject: Re: [PATCH v11 03/38] clk: ep93xx: add DT support for Cirrus EP93xx
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Nikita Shubin <nikita.shubin@maquefel.me>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Fri, 30 Aug 2024 15:27:25 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin (2024-08-30 02:23:12)
> Hello Stephen!
>=20
> On Wed, 2024-08-28 at 13:44 -0700, Stephen Boyd wrote:
> > Quoting Nikita Shubin via B4 Relay (2024-07-15 01:38:07)
> > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > index 3e9099504fad..234b0a8b7650 100644
> > > --- a/drivers/clk/Kconfig
> > > +++ b/drivers/clk/Kconfig
> > > @@ -218,6 +218,14 @@ config COMMON_CLK_EN7523
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This driver pr=
ovides the fixed clocks and gates present
> > > on Airoha
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM silicon.
> > > =C2=A0
> > > +config COMMON_CLK_EP93XX
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Clock driver for Cirrus L=
ogic ep93xx SoC"
> >=20
> > tristate?
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ARCH_EP93XX || COMPI=
LE_TEST
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select MFD_SYSCON
> >=20
> > Why is this selecting syscon?
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select REGMAP
> >=20
> > Is this needed either?
>=20
> Indeed REGMAP is selected by COMMON_CLK, MFD_SYSCON not required, but
> it needs AUXILIARY_BUS.

I don't see REGMAP selected by COMMON_CLK. Did I miss something?

>=20
> > > +#define devm_ep93xx_clk_hw_register_fixed_rate_parent_data(dev,
> > > name, parent_data, flags, fixed_rate)=C2=A0 \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __clk_hw_register_fixed_rate((d=
ev), NULL, (name), NULL,
> > > NULL, \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (pare=
nt_data), (flags),
> > > (fixed_rate), 0, 0, true)
> >=20
> > Is this to workaround a missing
> > devm_clk_hw_register_fixed_rate_parent_data() macro?
>=20
> Yes, if it's okay - i'll fire next revision, all other comments are
> acknowledged.
>=20

Can you add the macro so others can use it in another patch?

