Return-Path: <linux-kernel+bounces-180144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143A08C6AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436621C21450
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E95421103;
	Wed, 15 May 2024 16:34:03 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0514F1392;
	Wed, 15 May 2024 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790842; cv=none; b=QCICXFolli57D4HWCrEKxUqPOfC5uNSF6tdvlryzblVHqIqXgqeZgxTF+crJ9ZDAy7MEAeuDb3tl44vkSRgP9/nIzNV1qy5nt2K6V4WkoR4XouDodNxPVlL6F41Cu4RFbMZjdUPMNg0mkLdy4MC5/Xxb7CYR0UnExV10jmeUy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790842; c=relaxed/simple;
	bh=LstZVtS7mTOW34aC+wGMxQNmFlltAtZihtWnahDgL14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b11OlA3Opa0ykECHvka72HJrYz6dfIdcL7JNistCUaiDsS73XhYbGjz9bYFGzEyYBY2bevK7lAnu28+vLvWo+g+2c0AO8qpPyV2oDAHm8R7InPcnaxgPprQ9kFH+le100UF4RdQ+l/tlbJpzWSuTB/930AXwzAfR64SCIxOwUzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b5d.versanet.de ([83.135.91.93] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s7HZD-00078Z-Sj; Wed, 15 May 2024 18:33:23 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Detlev Casanova <detlev.casanova@collabora.com>,
 Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, Chris Morgan <macromorgan@hotmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: display: vop2: Add VP clock resets
Date: Wed, 15 May 2024 18:33:22 +0200
Message-ID: <2182693.irdbgypaU6@diego>
In-Reply-To: <20240515-risk-exes-13db315da6bb@spud>
References:
 <20240514152328.21415-1-detlev.casanova@collabora.com>
 <20240514152328.21415-4-detlev.casanova@collabora.com>
 <20240515-risk-exes-13db315da6bb@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 15. Mai 2024, 18:19:29 CEST schrieb Conor Dooley:
> On Tue, May 14, 2024 at 11:19:47AM -0400, Detlev Casanova wrote:
> > Add the documentation for VOP2 video ports reset clocks.
> > One reset can be set per video port.
> > 
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> 
> Are these resets valid for all VOPs or just the one on 3588?

Not in that form.
I.e. rk3588 has 4 video-ports (0-3), while rk3568 has 3 (0-2).

So the binding should take into account that rk3568 also has the
SRST_VOP0 ... SRST_VOP2.


Also, I guess we might not want to limit ourself to stuff we use?
I.e. the new VOP-design is one block with multiple video-ports

So for rk3568 I see
#define SRST_A_VOP
#define SRST_H_VOP
#define SRST_VOP0
#define SRST_VOP1
#define SRST_VOP2

similarly rk3588 has

#define SRST_H_VOP
#define SRST_A_VOP
#define SRST_D_VOP0
#define SRST_D_VOP1
#define SRST_D_VOP2
#define SRST_D_VOP3

as generalized reset lines.





> 
> > ---
> >  .../display/rockchip/rockchip-vop2.yaml       | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
> > index 2531726af306b..941fd059498d4 100644
> > --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
> > +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
> > @@ -65,6 +65,22 @@ properties:
> >        - const: dclk_vp3
> >        - const: pclk_vop
> >  
> > +  resets:
> > +    minItems: 3
> > +    items:
> > +      - description: Pixel clock reset for video port 0.
> > +      - description: Pixel clock reset for video port 1.
> > +      - description: Pixel clock reset for video port 2.
> > +      - description: Pixel clock reset for video port 3.
> > +
> > +  reset-names:
> > +    minItems: 3
> > +    items:
> > +      - const: dclk_vp0
> > +      - const: dclk_vp1
> > +      - const: dclk_vp2
> > +      - const: dclk_vp3
> > +
> >    rockchip,grf:
> >      $ref: /schemas/types.yaml#/definitions/phandle
> >      description:
> > @@ -128,6 +144,11 @@ allOf:
> >          clock-names:
> >            minItems: 7
> >  
> > +        resets:
> > +          minItems: 4
> > +        reset-names:
> > +          minItems: 4
> > +
> >          ports:
> >            required:
> >              - port@0
> > @@ -183,6 +204,12 @@ examples:
> >                                "dclk_vp0",
> >                                "dclk_vp1",
> >                                "dclk_vp2";
> > +                resets = <&cru SRST_VOP0>,
> > +                         <&cru SRST_VOP1>,
> > +                         <&cru SRST_VOP2>;
> > +                reset-names = "dclk_vp0",
> > +                              "dclk_vp1",
> > +                              "dclk_vp2";
> >                  power-domains = <&power RK3568_PD_VO>;
> >                  iommus = <&vop_mmu>;
> >                  vop_out: ports {
> 





