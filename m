Return-Path: <linux-kernel+bounces-320903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8B39711CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC98E287409
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2801B1417;
	Mon,  9 Sep 2024 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eqPzbUj1"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9DB1AE859;
	Mon,  9 Sep 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870189; cv=none; b=TbtHs9UVsJSt5RES9qwGWUwf+g/kDZTTKDGvj0+86DfSMvluwawW8uA3ThfNn7PrnCZQ8ppJGFANmSTpod/XrDkFxjTZWlEyc8SEwSemld2qwJKlXPk+icJwJMMpy74e1uxEnVpMjYpy7sxEaxpaId6Xp4FPAn+da92R2/0blzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870189; c=relaxed/simple;
	bh=RWYOkSCv3h0126EVIboGoeRZMQwR/AQWmiXSAK7DxjA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYMezOE77caqTKVsz+Q9SvmIxMONBT25NvM7/FxuLManFGAWTh8nppNrpazKhBhJ8Zcuyp4QAEBn/zoALmi3Fb9lx40N/QzFOTG6QKc7RP8xuErbV6MYP/Yqzlp07Y5WVutBDA+hSKTvp+T+tv+H8cgnXYhu+xlRt77/1jGeyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eqPzbUj1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725870187; x=1757406187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RWYOkSCv3h0126EVIboGoeRZMQwR/AQWmiXSAK7DxjA=;
  b=eqPzbUj1W8a5NYON/jFEIcZOoCzXO/jdxY2591LwvPS+8kLxMEMjFC5D
   9gh/DifXNkMqhG6EtEiFN3zZ8pJ7LANpcNciJfrf8Uab8zPlsvmCLW7YC
   u6gxnT9RJ9PvctoHx9JgTmjWsNFy57N+17VI/2eT4H/Y9oIUNwjxnmxt/
   XTi+lLCCyvSKTqD+EH+iyQ6q9YMdIOqdfbnVE+4GkG3IuI8JDQn23cJDB
   i26oa/iFUV3J+HM7P2hErxFEOZePeJ3AEeoU6qo32kpakTIZSUdwacLyD
   GLQD2OcdvcGZcMYtMDrqb0h/H2wEoAqEZn9eSlDVna/dd6G19GY8asmE0
   w==;
X-CSE-ConnectionGUID: PZVtMCSfSX6DUnxmZ/IX3Q==
X-CSE-MsgGUID: BlHxOriiSRydW/a4O6+9oA==
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="32139047"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 01:23:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 01:22:44 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Sep 2024 01:22:42 -0700
Date: Mon, 9 Sep 2024 08:22:41 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, <linux-phy@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 8/9] dt-bindings: phy: sparx5: document lan969x in sparx5
 dt-bindings
Message-ID: <20240909082241.hvw3a7yig3pujrsk@DEN-DL-M70577>
References: <20240906-sparx5-lan969x-serdes-driver-v1-0-8d630614c58a@microchip.com>
 <20240906-sparx5-lan969x-serdes-driver-v1-8-8d630614c58a@microchip.com>
 <c0aa5342-a2af-4ac4-bc33-b6dbfff77f63@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c0aa5342-a2af-4ac4-bc33-b6dbfff77f63@kernel.org>

Hi Krzysztof,

Thanks your comments.

> On 06/09/2024 14:52, Daniel Machon wrote:
> > Document lan969x in the existing Sparx5 dt-bindings.
> >
> 
> Say something useful, not copy of subject.
> 
> > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> 
> A nit, subject: drop second/last, redundant "dt-bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Duly noted.

> 
> 
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > ---
> >  .../bindings/phy/microchip,sparx5-serdes.yaml          | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
> > index bdbdb3bbddbe..1e07a311e8a5 100644
> > --- a/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
> > +++ b/Documentation/devicetree/bindings/phy/microchip,sparx5-serdes.yaml
> > @@ -8,6 +8,7 @@ title: Microchip Sparx5 Serdes controller
> >
> >  maintainers:
> >    - Steen Hegelund <steen.hegelund@microchip.com>
> > +  - Daniel Machon <daniel.machon@microchip.com>
> >
> >  description: |
> >    The Sparx5 SERDES interfaces share the same basic functionality, but
> > @@ -62,12 +63,17 @@ description: |
> >    * 10.3125 Gbps (10GBASE-R/10GBASE-KR/USXGMII)
> >    * 25.78125 Gbps (25GBASE-KR/25GBASE-CR/25GBASE-SR/25GBASE-LR/25GBASE-ER)
> >
> > +  lan969x has ten SERDES10G interfaces that share the same features, operating
> > +  modes and data rates as the equivalent Sparx5 SERDES10G interfaces.
> > +
> >  properties:
> >    $nodename:
> >      pattern: "^serdes@[0-9a-f]+$"
> >
> >    compatible:
> > -    const: microchip,sparx5-serdes
> > +    enum:
> > +      - microchip,sparx5-serdes
> > +      - microchip,lan969x-serdes
> 
> It seems there is no lan969x SoC/chip. Are you sure you are using
> correct naming, matching what kernel is using? Maybe you just sent
> whatever you had in downstream (hint: that's never a good idea).

You are right. There is no upstream support for lan969x SoC yet. The
upstreaming of the lan969x SoC has just begun, and this series is part
of that upstreaming effort. The lan969x switch driver (not submitted
yet) will depend on this SERDES driver, however, their functionality is
really independent of each other. That is why I am also upstreaming the
SERDES- and switch driver series independent of each other.

If these series needs to somehow be connected, by link or whatever, then
fine.  If there is some preferred way to do this, then please let me
know or point me in some direction. Thanks.

> 
> >
> >    reg:
> >      minItems: 1
> > @@ -90,11 +96,19 @@ additionalProperties: false
> >
> >  examples:
> >    - |
> > -    serdes: serdes@10808000 {
> > +    serdes@10808000 {
> >        compatible = "microchip,sparx5-serdes";
> >        #phy-cells = <1>;
> >        clocks = <&sys_clk>;
> >        reg = <0x10808000 0x5d0000>;
> >      };
> >
> > +  - |
> > +    serdes@e3410000 {
> > +      compatible = "microchip,lan969x-serdes";
> > +      #phy-cells = <1>;
> > +      clocks = <&fabric_clk>;
> 
> No differences so no need for new example. Also please follow DTS coding
> style in case of any DTS code.
> 

Ack.

> Best regards,
> Krzysztof
> 

/Daniel

