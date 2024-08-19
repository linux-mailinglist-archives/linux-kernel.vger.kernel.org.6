Return-Path: <linux-kernel+bounces-292223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4338956CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5B31F224A4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5BA16CD10;
	Mon, 19 Aug 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="XoECn+5a"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC261166F21;
	Mon, 19 Aug 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076456; cv=pass; b=alc6YR1Xy91SOVF4Zo6Ht3HRz6TmsuhNvrYP6OgvcmMpZXgE+G95VSGV6gDxLmbE/XB3WIW1sigQJHSsRmxm+ideEL88lu0ycdh0V17I7I0FsQlw0KfrSkbPierNPqtfTqE+IABrGasj3EnI/d58KFdFPN3gKwlFu0l6WhsvsiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076456; c=relaxed/simple;
	bh=gmUPssrIfJo7m2PHNU2wOtBCulFEX6sMYjGfbbajZJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhZzrNpzcUZzBadBZbOow1nYNwjZ/8uSJ8EOzCBN115QbHhAsqoxORcDiDZxmGujnAhMRyUbiyX3IQaEroQr3+U+vgeo/owoKlZ+aJEmTehTFQtbpi5jC+SlDw8ZSVpSB9FsK8LdApMoWuVYd9h/Upg0BO9OH4f9FbPIHHQpRyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=XoECn+5a; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724076419; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KFcBHaTHpEoAOvPDekVVbOVDYrcbpTePmOuzBmIUQMVGE99DllJ134ePJ4eaFXeSpQ7FfmvGBHVj2TiwxkUdoPN2xwkewqIZxdQTJ5WNBSxBlTwD1x9iNNyENagASrY+kX1zphmOQw1CxLq4c54ihi+EzFqh+x4JYcMTeGvhzCU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724076419; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZkV3lCqrhCL/CEHyK/B3/ruXUMXYJqM7j2j33wHPH7Y=; 
	b=OB8YJp7mDp1naTGor1Y9XuwAWslUbAoC5jSC0YopnC9fY+aasCJwfneU6++FOBwYxd/SMffAdL2A7K0OmAhbiTDu9GmzQjFC8yK8Eg6vLkIUzH45fPiLKk1YSGk6qTY1C4uqXyz+9CQy/0qgVwJ906zITTUG/brnUctHylGy6tM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724076419;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=ZkV3lCqrhCL/CEHyK/B3/ruXUMXYJqM7j2j33wHPH7Y=;
	b=XoECn+5ajwSz41GDT1zGVJA0lMOdtpxgBxr36oMfTdnkREm/BbUkzdYHXd4DvIy1
	trOao3WT3jh8czfmuvkE+vpgSZKhJ+rRx5SVave+P5Jn+iaEb7pHsTfN7q9kLFLE5wn
	jYd7koXzjlU5EP8ZN8IpSehrNtugsFCERWO1X3wk=
Received: by mx.zohomail.com with SMTPS id 1724076416454854.9649861700929;
	Mon, 19 Aug 2024 07:06:56 -0700 (PDT)
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
Date: Mon, 19 Aug 2024 10:08:31 -0400
Message-ID: <5018731.31r3eYUQgx@trenzalore>
In-Reply-To: <20240815-tassel-whacking-a460ee2ebd41@spud>
References:
 <20240814222159.2598-1-detlev.casanova@collabora.com>
 <20240814222159.2598-2-detlev.casanova@collabora.com>
 <20240815-tassel-whacking-a460ee2ebd41@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi Conor,

On Thursday, 15 August 2024 11:07:46 EDT Conor Dooley wrote:
> On Wed, Aug 14, 2024 at 06:19:22PM -0400, Detlev Casanova wrote:
> > Add clock and reset ID defines for rk3576.
> > 
> > Compared to the downstream bindings written by Elaine, this uses
> > continous gapless IDs starting at 0. Thus all numbers are
> > different between downstream and upstream, but names are kept
> > exactly the same.
> > 
> > Also add documentation for the rk3576 CRU core.
> > 
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  .../bindings/clock/rockchip,rk3576-cru.yaml   |  64 ++
> >  .../dt-bindings/clock/rockchip,rk3576-cru.h   | 592 ++++++++++++++++++
> >  .../dt-bindings/reset/rockchip,rk3576-cru.h   | 564 +++++++++++++++++
> >  3 files changed, 1220 insertions(+)
> >  create mode 100644
> >  Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml create
> >  mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h create mode
> >  100644 include/dt-bindings/reset/rockchip,rk3576-cru.h> 
> > diff --git
> > a/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> > b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml new
> > file mode 100644
> > index 0000000000000..d69985e6fa0ce
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/rockchip,rk3576-cru.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip rk3576 Family Clock and Reset Control Module
> > +
> > +maintainers:
> > +  - Elaine Zhang <zhangqing@rock-chips.com>
> > +  - Heiko Stuebner <heiko@sntech.de>
> > +  - Detlev Casanova <detlev.casanova@collabora.com>
> > +
> > +description:
> > +  The RK3576 clock controller generates the clock and also implements a
> > reset +  controller for SoC peripherals. For example it provides
> > SCLK_UART2 and +  PCLK_UART2, as well as SRST_P_UART2 and SRST_S_UART2
> > for the second UART +  module.
> > +
> > +properties:
> > +  compatible:
> > +    const: rockchip,rk3576-cru
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  "#reset-cells":
> > +    const: 1
> > +
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    items:
> > +      - const: xin24m
> > +      - const: xin32k
> > +
> > +  rockchip,grf:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: >
> > +      phandle to the syscon managing the "general register files". It is
> > used +      for GRF muxes, if missing any muxes present in the GRF will
> > not be +      available.
> 
> Two questions on this property:
> - you only support one soc, why is this optional?

It is optional because only used for some specific clocks. The SoC can still be 
used without this, but some devices might not work (Not tested but USB PHYs 
might not be working without the GRF)
This is also set as optional in similar rockchip CRU bindings (rk3588).

> - why can't you look it up by compatible?

These bindings are specific to one compatible only. It is very similar to 
rk3588 but it looks like all rockchip CRU driver has its own yaml file, so I 
followed that trend instead of merging with the rk3588 CRU bindings.

Regards,
Detlev.




