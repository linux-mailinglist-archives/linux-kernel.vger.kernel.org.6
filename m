Return-Path: <linux-kernel+bounces-208068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE152902037
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB88281078
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99067C6EB;
	Mon, 10 Jun 2024 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ABivI1rz"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70FC1B80F;
	Mon, 10 Jun 2024 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018320; cv=none; b=ebtW2pE7n+LjW9UHI2xggOyicxFr2RCxtAhsXGRZpqokafWWLHyFicVacSpPon47JrtelGgotye9x/04r+tsMvRJWl0EEJ/A8iEY+pNvT9h141GkFsRB27eM6lWwYoMZA8gPQ0bJ9cmT6nbZaHtmooQPVx3TcRhTzhUlxRKAuC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018320; c=relaxed/simple;
	bh=BVJRnE1p9c1EyXh04it2m5C3V1BucUBrRwnwjCNsqJw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTuB/fzimBPRG7zWC64sypfaW043d7AEM7paDsFdR6++1vFyIBfrOwjBmZ3OnI94viG20RQZjpWXlB3UhHfW1umM7yD91GI+aK5fVlYQHyu8Mu/vq5qMZlU7afL3ins9M1ys7Vb0Oa81FM6GWTnKEVVKSaBSQfZYQ2SPPBUQwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ABivI1rz; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 8D299120002;
	Mon, 10 Jun 2024 14:18:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8D299120002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1718018307;
	bh=ArNoe6t1RcA/TLth3lJ1kMJmZwBKoMGM2K5yPZHNVWU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=ABivI1rzJ9cdnIpC+YYQd3GZFR3Ioef5hZwPTqoEzOIki8LLCScYK3ygJfQKMJUAS
	 IUR1yIiHZ5ZOfMJOO5hYGv0qjJeDVgtw30MMHlXHrDUzfQtqejSV4/YVQCBJ8rKHJL
	 v/2h9HqFpe3poHBmMiNNC03aG1G4GMVKN4CPTDr6jiZlgoQEo9QrGg4tekjtdgE7Kg
	 pmSbGVOKhTiplkB3RjsYpNvtp305Fpb3DINfU1ZSP5ugI/z2m3E6Z3sRBRhzO1tt7i
	 vflVmoqiwaBt14APoWIohlbT76cJLf59anFFsGYJtIfKBcCiRNqMf84RHEl6nkl/3v
	 7jDjI21HeMM+g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 10 Jun 2024 14:18:27 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 10 Jun
 2024 14:18:27 +0300
Date: Mon, 10 Jun 2024 14:18:26 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: Jerome Brunet <jbrunet@baylibre.com>
CC: <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
	<kernel@sberdevices.ru>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 6/7] dt-bindings: clock: meson: add A1 CPU clock
 controller bindings
Message-ID: <20240610111826.im3mz64hjfkxrxhr@CAB-WSD-L081021>
References: <20240515185103.20256-1-ddrokosov@salutedevices.com>
 <20240515185103.20256-7-ddrokosov@salutedevices.com>
 <1jtti1p10m.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jtti1p10m.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185831 [Jun 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;devicetree.org:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/10 11:00:00
X-KSMG-LinksScanning: Clean, bases: 2024/06/10 11:00:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/10 07:14:00 #25537945
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Jerome,

Thank you for the review!

On Mon, Jun 10, 2024 at 12:04:09PM +0200, Jerome Brunet wrote:
> On Wed 15 May 2024 at 21:47, Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:
> 
> > Add the documentation and dt bindings for Amlogic A1 CPU clock
> > controller.
> >
> > This controller consists of the general 'cpu_clk' and two main parents:
> > 'cpu fixed clock' and 'syspll'. The 'cpu fixed clock' is an internal
> > fixed clock, while the 'syspll' serves as an external input from the A1
> > PLL clock controller.
> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/clock/amlogic,a1-cpu-clkc.yaml   | 64 +++++++++++++++++++
> >  .../dt-bindings/clock/amlogic,a1-cpu-clkc.h   | 19 ++++++
> >  2 files changed, 83 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
> >  create mode 100644 include/dt-bindings/clock/amlogic,a1-cpu-clkc.h
> >
> > diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
> > new file mode 100644
> > index 000000000000..f4958b315ed4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-cpu-clkc.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/amlogic,a1-cpu-clkc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Amlogic A1 CPU Clock Control Unit
> > +
> > +maintainers:
> > +  - Neil Armstrong <neil.armstrong@linaro.org>
> > +  - Jerome Brunet <jbrunet@baylibre.com>
> > +  - Dmitry Rokosov <ddrokosov@salutedevices.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: amlogic,a1-cpu-clkc
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: input fixed pll div2
> > +      - description: input fixed pll div3
> > +      - description: input sys pll
> > +      - description: input oscillator (usually at 24MHz)
> 
> According to the documentation, fdiv5 is also an input of the CPU clock
> tree.
> 
> That is typically the kind of things we'd prefer to get right from the
> beginning to avoid modifying the bindings later.
> 

Could you please share which documentation you are referencing? I have
the A113L documentation, and there is no mention of the CPU clock IP.
I retrieved below register map from the vendor's custom driver:

===
CPUCTRL_CLK_CTRL0

bits 1:0 - cpu_fsource_sel0
    0 - xtal
    1 - fclk_div2
    2 - fclk_div3

bit 2 - cpu_fsel0
    0 - cpu_fsource_sel0
    1 - cpu_fsource_div0

bit 3 - UNKNONWN

bits 9:4 - cpu_fsource_div0
    Divider value

bit 10 - cpu_fclk
    0 - cpu_fsel0
    1 - cpu_fsel1

bit 11 - cpu_clk
    0 - cpu_fclk
    1 - sys_pll

bits 15:12 - UNKNONWN

bits 17:16 - cpu_fsource_sel1
    0 - xtal
    1 - fclk_div2
    2 - fclk_div3

bit 18 - cpu_fsel1
    0 - cpu_fsource_sel1
    1 - cpu_fsource_div1

bit 19 - UNKNONWN

bits 25:20 - cpu_fsource_div1
    Divider value

bits 31:26 - UNKNONWN
===

As you can see it doesn't have any other inputs except fclk_div2,
fclk_div3, sys_pll and xtal.

> > +
> > +  clock-names:
> > +    items:
> > +      - const: fclk_div2
> > +      - const: fclk_div3
> > +      - const: sys_pll
> > +      - const: xtal
> > +
> > +required:
> > +  - compatible
> > +  - '#clock-cells'
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
> > +    apb {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        clock-controller@fd000000 {
> > +            compatible = "amlogic,a1-cpu-clkc";
> > +            reg = <0 0xfd000080 0 0x8>;
> 
> If reg is <0 0xfd000080 0 0x8> then node name should be clock-controller@fd000080
> 

Okay, I will fix that example in the next version.

[...]

-- 
Thank you,
Dmitry

