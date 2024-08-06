Return-Path: <linux-kernel+bounces-276913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE219499FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7633DB23AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3170172BDC;
	Tue,  6 Aug 2024 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="ZYH/46hv"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290B16EB63;
	Tue,  6 Aug 2024 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979278; cv=pass; b=mmmxSYCJQl3gSavigvPfx/UQ+HmM1XZiQuq4lciajgFSUGolLNcGOXOCAkJXu4gTLhygMADLwOPZoA7n/9Fx53kohLvAB5d4shkY/4GxuZB/K0L1aNY3mQfTjAy/rGWkEmdQYwtD0DIlxdpLkZYegIQW8QoqeKaIlA03l7/zuoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979278; c=relaxed/simple;
	bh=xvqb6qADmaVvF5wkQPJISye6IS2zi+WI4YOKJs6jReI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b88nh4NtKprscsNc0JLi9TyNSdxPMyfYI15ZJZkUahRccRYX0+sObm++TpVRcVB7NRyjoGDShrMBDHVAhXAoJsl30loYbkKMhcPM0qMQTmDIkfVigNtdM8udsG+ibtCOrcKM9Tx1SGJ5X1Ry/3tPuGB5LhSOQGcKSBqSXK2ZypM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=ZYH/46hv; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722979252; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BMf2ZRFvtqi/sR13Gc59m+dMM+UrIaQjfzvHt/w/TtAtrfbrDjwxqIZdy43GRVczq3kSoc4u3i7kVIFcEGMvqDs3ykaK4njgc8RgXWxRRJ3QMHSnPjSbpHFOvu9UMXh8HFCg+p/B5n9gtX+qJUtdFTAAiZc2OW5ohWPOLu+G7Qg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722979252; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ohjTRCVxkhKXSgrx3m+MPEhGY7a9HSyHDy3Be9j0/h4=; 
	b=as4PYSvJHpawzeoKIOiKghAb3Q10+Hueo6mC49qrGYx9oCiWrUGCmp5QWkAvSbS7CsNdVvnDQFAkPTeuSf43fv3Ls2OVwuxNUGG+o5BEABohi9rihiYPEnq4zpnX73Uc3ZhQ7cKBWxlzLmuPPMvqzvytx5J0PfvfMwBlLyyfkJc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722979252;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=ohjTRCVxkhKXSgrx3m+MPEhGY7a9HSyHDy3Be9j0/h4=;
	b=ZYH/46hvnZV51VVqorVH3LiC7WuZwmTxVLc/nGongNTjLICSXR084ljtqdkNA+bq
	JV1L4kc+ynO8+JgRqvok3f9lbrk32ZFQ4+EsZudEfgGCpDuGTmgVfY9f/9emGgLv4DN
	coIyZRUQ0FrEFP7wTKsdYulpLLLTxQe/EO7Y8SCM=
Received: by mx.zohomail.com with SMTPS id 17229792513511020.8164380601129;
	Tue, 6 Aug 2024 14:20:51 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: add rk3576 cru bindings
Date: Tue, 06 Aug 2024 17:22:03 -0400
Message-ID: <1975336.PYKUYFuaPT@trenzalore>
In-Reply-To: <87503c5b-95dc-463b-8363-3e1fab03f8f2@kernel.org>
References:
 <20240802214053.433493-1-detlev.casanova@collabora.com>
 <20240802214053.433493-2-detlev.casanova@collabora.com>
 <87503c5b-95dc-463b-8363-3e1fab03f8f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi Krzysztof,

On Sunday, 4 August 2024 05:52:53 EDT Krzysztof Kozlowski wrote:
> On 02/08/2024 23:35, Detlev Casanova wrote:
> > Document the device tree bindings of the rockchip rk3576 SoC
> > clock and reset unit.
> > 
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> 
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bi
> ndings/submitting-patches.rst#L18
> > ---
> > 
> >  .../bindings/clock/rockchip,rk3576-cru.yaml   | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644
> >  Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml> 
> > diff --git
> > a/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> > b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml new
> > file mode 100644
> > index 0000000000000..929eb6183bf18
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
> > @@ -0,0 +1,73 @@
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
> > +
> > +description: |
> > +  The RK3576 clock controller generates the clock and also implements a
> > reset +  controller for SoC peripherals. For example it provides
> > SCLK_UART2 and +  PCLK_UART2, as well as SRST_P_UART2 and SRST_S_UART2
> > for the second UART +  module.
> > +  Each clock is assigned an identifier and client nodes can use this
> > identifier +  to specify the clock which they consume. All available
> > clock and reset IDs +  are defined as preprocessor macros in dt-binding
> > headers.
> 
> Drop paragraph, it is obvious. You could provide here the name of the
> header...
> 
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - rockchip,rk3576-cru
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
> > +    minItems: 2
> 
> You can drop minitems
> 
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    items:
> > +      - const: xin24m
> > +      - const: xin32k
> > +
> > +  assigned-clocks: true
> > +
> > +  assigned-clock-rates: true
> > +
> > +  assigned-clock-parents: true
> 
> Drop  all these three

Why dro pthese if I need them in the device tree ? Should I remove them from 
there as well ? It seems to be working without it.

> > +
> > +  rockchip,grf:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: >
> > +      phandle to the syscon managing the "general register files". It is
> > used +      for GRF muxes, if missing any muxes present in the GRF will
> > not be +      available.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#clock-cells"
> > +  - "#reset-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    cru: clock-controller@27200000 {
> 
> Drop unused label
> 
> > +      compatible = "rockchip,rk3576-cru";
> > +      reg = <0xfd7c0000 0x5c000>;
> > +      #clock-cells = <1>;
> > +      #reset-cells = <1>;
> 
> Make the example complete.
> 
> > +    };
> 

Detlev.





