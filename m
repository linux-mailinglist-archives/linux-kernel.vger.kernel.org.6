Return-Path: <linux-kernel+bounces-292606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D739571C1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B25E1F22C35
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB56187FFE;
	Mon, 19 Aug 2024 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="OBaASwKU"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4C18787E;
	Mon, 19 Aug 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087611; cv=pass; b=TcPgvy5X9sh0RsvGspCKd1n2aRp68prpYfJZlZp7pSRjZDFCckHdmoIMmHwPY9ZVaW6PYYaJ4nXH3BtCYj0BZaMnRuKvCodgguPEwWnXfm9L5Wy6h+fdGSy7m+jxAm/65U7jIh4YHLV9KHyolQ2ckEOhOAvlqxeOMBCftRTU/3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087611; c=relaxed/simple;
	bh=mKCSq4e0BePGV+Y2++3FyK/GO40bcw+mT1HPflUpYo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLZEkdVHhYC1xnGH6t/TNKaehEjA+UzxZG4zZCCU/V2H8Ne4E6UTCC0VhNcBahRHXDVDBd8J03uWCaUHWo0aY5LggPkRDO0zD/Omauem3NaHXAAxBjhO3JRhmwFdF1m+bGGnD2NuT6aqscTMR6jAWND5A1sy0D+h2BO3TEdphkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=OBaASwKU; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724087584; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T6303kZ0TX6/V1MAkFPqOb3xQCCwN13GsMEhxg3XBLYpjVGHhZAkgmyjx06MSBd8Bhyy/K5ogzLudzoUHbm6ikyRDjOafcpmpRkrm65V3s2W8YZfJaEFWeqC3O4VxCWbdwuB2Mts6GIYrMXteJsdB9T+1iVCkxjPLGLCbm/B/iM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724087584; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M34aoc8Kda1/DJFgE1Z0cakbSM38xy/V0nkXYm4RUQU=; 
	b=lrmNM+yHcvoU16Fc8fOftOVaSPm55EI6/2pqIjjBc9vgbeM2NZMv422mrrlb2d+MUTSi+f3C5oJigg/yIwC6Q59hEBEKg9G5rFZtgDYGJfHmOTnAjRttm/BKtqyn0H8aLapeyiPM+bzLK+8KECs5Kjp0oxXGiOAYBiWboOhYaOY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724087584;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=M34aoc8Kda1/DJFgE1Z0cakbSM38xy/V0nkXYm4RUQU=;
	b=OBaASwKUwFGbM2znuDtMpBCHGBNQszIUA79pZXtLkzM5vuVG9rikno1vH2s+833M
	E5nn5hx+qDDi6ki7Vf2VlWLo5fMg7om2GozKulXKY57SwGgVvquox+ShuBJ59m51Rcw
	YMF+zdULBNHsAf3LR4z3R4Rgbmh4zYxcxwjLqEBU=
Received: by mx.zohomail.com with SMTPS id 1724087583124955.9251244579328;
	Mon, 19 Aug 2024 10:13:03 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: clock, reset: Add support for rk3576
Date: Mon, 19 Aug 2024 13:14:38 -0400
Message-ID: <2071848.usQuhbGJ8B@trenzalore>
In-Reply-To: <20240819-pelvis-monetary-211e2294f2f4@spud>
References:
 <20240814222159.2598-1-detlev.casanova@collabora.com>
 <5018731.31r3eYUQgx@trenzalore> <20240819-pelvis-monetary-211e2294f2f4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Monday, 19 August 2024 12:34:15 EDT Conor Dooley wrote:
> On Mon, Aug 19, 2024 at 10:08:31AM -0400, Detlev Casanova wrote:
> > Hi Conor,
> > 
> > On Thursday, 15 August 2024 11:07:46 EDT Conor Dooley wrote:
> > > On Wed, Aug 14, 2024 at 06:19:22PM -0400, Detlev Casanova wrote:
> > > > Add clock and reset ID defines for rk3576.
> > > > 
> > > > Compared to the downstream bindings written by Elaine, this uses
> > > > continous gapless IDs starting at 0. Thus all numbers are
> > > > different between downstream and upstream, but names are kept
> > > > exactly the same.
> > > > 
> > > > Also add documentation for the rk3576 CRU core.
> > > > 
> > > > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > > > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > > > ---
> > > > 
> > > >  .../bindings/clock/rockchip,rk3576-cru.yaml   |  64 ++
> > > >  .../dt-bindings/clock/rockchip,rk3576-cru.h   | 592
> > > >  ++++++++++++++++++
> > > >  .../dt-bindings/reset/rockchip,rk3576-cru.h   | 564 +++++++++++++++++
> > > >  3 files changed, 1220 insertions(+)
> > > >  create mode 100644
> > > >  Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> > > >  create
> > > >  mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h create
> > > >  mode
> > > >  100644 include/dt-bindings/reset/rockchip,rk3576-cru.h>
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> > > > b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml new
> > > > file mode 100644
> > > > index 0000000000000..d69985e6fa0ce
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> > > > @@ -0,0 +1,64 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/clock/rockchip,rk3576-cru.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Rockchip rk3576 Family Clock and Reset Control Module
> > > > +
> > > > +maintainers:
> > > > +  - Elaine Zhang <zhangqing@rock-chips.com>
> > > > +  - Heiko Stuebner <heiko@sntech.de>
> > > > +  - Detlev Casanova <detlev.casanova@collabora.com>
> > > > +
> > > > +description:
> > > > +  The RK3576 clock controller generates the clock and also implements
> > > > a
> > > > reset +  controller for SoC peripherals. For example it provides
> > > > SCLK_UART2 and +  PCLK_UART2, as well as SRST_P_UART2 and SRST_S_UART2
> > > > for the second UART +  module.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: rockchip,rk3576-cru
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  "#clock-cells":
> > > > +    const: 1
> > > > +
> > > > +  "#reset-cells":
> > > > +    const: 1
> > > > +
> > > > +  clocks:
> > > > +    maxItems: 2
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: xin24m
> > > > +      - const: xin32k
> > > > +
> > > > +  rockchip,grf:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > > +    description: >
> > > > +      phandle to the syscon managing the "general register files". It
> > > > is
> > > > used +      for GRF muxes, if missing any muxes present in the GRF
> > > > will
> > > > not be +      available.
> > > 
> > > Two questions on this property:
> > > - you only support one soc, why is this optional?
> > 
> > It is optional because only used for some specific clocks. The SoC can
> > still be used without this, but some devices might not work (Not tested
> > but USB PHYs might not be working without the GRF)
> > This is also set as optional in similar rockchip CRU bindings (rk3588).
> > 
> > > - why can't you look it up by compatible?
> > 
> > These bindings are specific to one compatible only. It is very similar to
> > rk3588 but it looks like all rockchip CRU driver has its own yaml file, so
> > I followed that trend instead of merging with the rk3588 CRU bindings.
> I don't think you've answered the question I am asking. Why can you not
> look up the syscon by the /syscon/'s compatible in the clock driver, and
> thus remove the property from here?

I don't think that this is possible. That means modifying rockchip/clk.c to 
lookup the syscon instead of using the `rockchip,grf` phandle. As it is used 
by other rockchip clock drivers, that means that we'd need to change the 
syscon's node name for some other SoCs to match what is being looked up.

But the GRF nodes have different compatibles:
- rk3588 uses php_grf (rockchip,rk3588-php-grf)
- rk3576 uses pmu0_grf (rockchip,rk3576-pmu0-grf)

So an optional rockchip,grf phandle sounds a good solution for this 

Regards,
Detlev.




