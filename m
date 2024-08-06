Return-Path: <linux-kernel+bounces-276481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D96949467
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F1B1C218C5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4841CA9C;
	Tue,  6 Aug 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="QT6omPpk"
Received: from sender3-op-o17.zoho.com (sender3-op-o17.zoho.com [136.143.184.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF9F18D63A;
	Tue,  6 Aug 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957765; cv=pass; b=MfZff/RbFiPF56b+wMk3HpNlcH/k97/TamwW5bUSxL30m6a4Jy12MNv7n+cNAjsFg5tpBo6cNfCKepK3Ei8m3GvTgz8VnZQgclG6uQu4oxmhO6xVEG2i53dcjGbIzyKJlb7Q9JJvNlSCf0SsGgcJc/iQD4WZrPSU+N5n8KrS7j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957765; c=relaxed/simple;
	bh=wn4DQPBiboqzNAW3MD+ufw1E2ANmJQ637kK8TsQ+G4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNYiOWhNxwWhXh7L6lvtCovWC6JpqYeHtraAzdP6tUOzkSGSCJIgdI/yR8bIqmY2+kXsRzi3PzjAIgseV+uPczbmVtyJeI70ry4M0LIWT3xtRitzinHgvPWRWVkgJp0CRAXp8RJIhVKpqbspIxR3+5UXJbI4YAbFZoGQGt4uz14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=QT6omPpk; arc=pass smtp.client-ip=136.143.184.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722957739; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X528A3SDqlxQS6uBuvYp/fY/an5pNhTKOg6VxX8/lV238DXnO7fkA2JqZDYq/Uw0UzFBzRNEcnt7VwJDRwZzQ9VGY34iuHdSPecS3hCDqXEOwXJtOYzv3hT3ci598zg7TNoh8Lj0M7vUB5ImS7xgqEtf6yLSXGvCJ+v35ZIWY9E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722957739; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4E7YYytNxcERJA+P5c4RQhUBo3UBV2EKfxk7gX+2rTM=; 
	b=TKo9JKPjy6afGWCkdn8B7MKOGG4ytVCihNakvPPNXhc3m4mt4gpY2HbqlrH1RsRGTUfcqxpDPDaRiaI84prLM3GoatssHJatedODQXHBfs9dm9fGbQL+s32OvQ1kp5nsRW5wqMKBoPu8yAUl3XOGhJZWaO8OUlBdOo8BLVZkijE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722957739;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=4E7YYytNxcERJA+P5c4RQhUBo3UBV2EKfxk7gX+2rTM=;
	b=QT6omPpk0QHjjuJfgBNeP66BFRUwXPimJeRjTSygjmdjXWvwmN0wUJrfWdFdAoKn
	nzXgIyfDanTB9wv84E2jic3W9dgaLFmwBr5mIO4cfYpYC3tbhB3fECOEYeH/3wO8dJg
	NpNPaiHc85uYtSu9Zeo7kkV4217sSzbwpkQ3/qb8=
Received: by mx.zohomail.com with SMTPS id 1722957736998397.9644636527041;
	Tue, 6 Aug 2024 08:22:16 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v2 2/3] clk: rockchip: Add dt-binding header for rk3576
Date: Tue, 06 Aug 2024 11:23:28 -0400
Message-ID: <2949191.e9J7NaK4W3@trenzalore>
In-Reply-To: <1600ee06-ac19-436f-8229-1bb44b29c683@kernel.org>
References:
 <20240802214053.433493-1-detlev.casanova@collabora.com>
 <20240802214053.433493-3-detlev.casanova@collabora.com>
 <1600ee06-ac19-436f-8229-1bb44b29c683@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Sunday, 4 August 2024 05:53:57 EDT Krzysztof Kozlowski wrote:
> On 02/08/2024 23:35, Detlev Casanova wrote:
> > From: Elaine Zhang <zhangqing@rock-chips.com>
> > 
> > Add the dt-bindings header for the rk3576, that gets shared between
> > the clock controller and the clock references in the dts.
> > 
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > [rebased, separate clocks and resets]
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patche
> s.html#i-for-patch-submitters
> > ---
> > 
> >  .../dt-bindings/clock/rockchip,rk3576-cru.h   | 589 ++++++++++++++++++
> >  .../dt-bindings/reset/rockchip,rk3576-cru.h   | 484 ++++++++++++++
> >  2 files changed, 1073 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
> >  create mode 100644 include/dt-bindings/reset/rockchip,rk3576-cru.h
> 
> These are bindings. Must be squashed with previous patch.

Ok, so you'd rather have a commit for reset definitions (dt-bindings: reset: 
Add rk3576 reset definitions) and another one for clock definitions + 
Documentation (dt-bindings: clock: Add rk3576 clock definitions and 
documentation) ?

> > diff --git a/include/dt-bindings/clock/rockchip,rk3576-cru.h
> > b/include/dt-bindings/clock/rockchip,rk3576-cru.h new file mode 100644
> > index 0000000000000..14b54543d1a11
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/rockchip,rk3576-cru.h
> > @@ -0,0 +1,589 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> 
> Weird license. Why not using recommended one?

Oh right, I suppose "GPL-2.0 OR MIT" is better ? At least that is what I see 
for rk3588. include/dt-bindings/clock/rockchip,rv1126-cru.h uses "GPL-2.0+ OR 
MIT" though.

> > +/*
> > + * Copyright (c) 2023 Rockchip Electronics Co. Ltd.
> > + * Author: Elaine Zhang <zhangqing@rock-chips.com>
> > + */
> > +
> > +#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3576_H
> > +#define _DT_BINDINGS_CLK_ROCKCHIP_RK3576_H
> > +
> > +/* cru-clocks indices */
> > +
> > +/* cru plls */
> > +#define PLL_BPLL			1
> > +#define PLL_LPLL			3
> > +#define PLL_VPLL			4
> > +#define PLL_AUPLL			5
> > +#define PLL_CPLL			6
> > +#define PLL_GPLL			7
> > +#define PLL_PPLL			9
> 
> Nope, indices start from 1 and are incremented continuously.

Why start at 1 ? RK3588 starts at 0 for clocks and resets

Regards,
Detlev.



