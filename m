Return-Path: <linux-kernel+bounces-213956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F310E907D01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7121F23DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153D7EEE7;
	Thu, 13 Jun 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxPKWcuz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A76F073;
	Thu, 13 Jun 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718308591; cv=none; b=HQW8s8GthebJ+NDkaZhwd3PRSCaO7sBWeZuKzRn3vl/XEIpvzyKpmN3XzPzkoO6lpZEpdThopRt4lIAMRr4VNZIzdcrC8KYzcXMu6fP2sW/MwGPs7Uf+mjxt2yOnF1Ivj1ABXHnLOJ7Pkvk+YhFhPLjunxfR7dnHQgaZZcYCkbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718308591; c=relaxed/simple;
	bh=2CIXLJ7qsPS8dd8m3DCzcakUf78MBjuyDU5bR//RUC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfASEtfvUaHz3E2/RQhFi3DZ4uVFOsq33p7SH79QqzBtt4cbR2zYE5FoT5rMGUNWMEhWdpjh173hipO/ZIne3khrq1/QVJq8iWByRPC5ujwlHntk5mVPrmuA+ZSGUCQhCMRTNbI5Fza9jYfdjuAZQIXuRgmKg9Wve8+iMqjlIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxPKWcuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B51AC2BBFC;
	Thu, 13 Jun 2024 19:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718308590;
	bh=2CIXLJ7qsPS8dd8m3DCzcakUf78MBjuyDU5bR//RUC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CxPKWcuzwRPjJYc2rwTtmY2L71hz8x9jYNOMTX0r/OhGv2iRbMohECPUsF3o/U7Yz
	 BTF0PlBqx9mWImPoss+TwiIvob2I0pryGGxO4faeAu6bqGMlpuFVTPJd/+gMVjgDY5
	 eQFzm/PZ8WjoREBuhg4XfjWkByJDBxa2wzAH/KYz8yQ883jm8d1gz4Zv6pvlzPKxL7
	 Zmq3Cmas/uaWJYIXl0jr6Dd4aHoBpJOPtgytUU9/4dTCiHn866Rcj1UtPoPwZrL7RN
	 JebrM8S8tw/dn8wBfSsaskVwFj4iZveY/GVYLzSvn6DtPhnThQkamaPgdbgUw1M8NK
	 IRz32tDc//pGQ==
Date: Thu, 13 Jun 2024 13:56:29 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Johan Jonker <jbx6244@yandex.com>,
	Shresth Prasad <shresthprasad7@gmail.com>, vkoul@kernel.org,
	kishon@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heiko@sntech.de, sebastian.reichel@collabora.com,
	s.hauer@pengutronix.de, cristian.ciocaltea@collabora.com,
	andy.yan@rock-chips.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v3] dt-bindings: phy: rockchip-emmc-phy: Convert to
 dtschema
Message-ID: <20240613195629.GA2359753-robh@kernel.org>
References: <20240613085812.4020-2-shresthprasad7@gmail.com>
 <cc66cca1-33db-4f30-afcf-d256a959896b@yandex.com>
 <9ce15b81-a8bd-4833-b15e-3e6f240dcf03@kernel.org>
 <495e50aa-6819-457d-8503-00440abc97e3@yandex.com>
 <58e85008-a268-4555-bafb-f948ade16a63@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e85008-a268-4555-bafb-f948ade16a63@kernel.org>

On Thu, Jun 13, 2024 at 02:52:46PM +0200, Krzysztof Kozlowski wrote:
> On 13/06/2024 12:33, Johan Jonker wrote:
> > 
> > 
> > On 6/13/24 12:12, Krzysztof Kozlowski wrote:
> >> On 13/06/2024 11:44, Johan Jonker wrote:
> >>>> ---
> >>>
> >>> Add ack request from phy maintainer here.
> >>
> > 
> >> Why? What do you mean for that? Why phy maintainer needs to ack patches
> >> he is going to take?
> > 
> > See my text below:
> > From my past converting phy documents experience asking was needed to smooths things up ...
> > Let me know if things have improved.
> > 
> > grf.yaml can be busy at times. Let Heiko take care of the merge order.
> > Ask for an ack from the phy maintainers in your commit message below a "---"
> > 
> >>
> >>>
> >>>> Changes in v3:
> >>>>     - fix `reg` in example being too long
> >>>>
> >>>> Tested against `rockchip/rk3399-firefly.dtb`, `rockchip/rk3399-orangepi.dtb`
> >>>> and `rockchip/rk3399-pinebook-pro.dtb`.
> >>>>
> >>>>  .../bindings/phy/rockchip,emmc-phy.yaml       | 79 +++++++++++++++++++
> >>>>  .../bindings/phy/rockchip-emmc-phy.txt        | 43 ----------
> >>>>  .../devicetree/bindings/soc/rockchip/grf.yaml |  2 +-
> >>>>  3 files changed, 80 insertions(+), 44 deletions(-)
> >>>>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
> >>>>  delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..85d74b343991
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/phy/rockchip,emmc-phy.yaml
> >>>> @@ -0,0 +1,79 @@
> >>>
> >>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>>
> >>> You are converting an existing document, so GPL 2 only.
> >>
> > 
> >> Which copyrightable part was copied? This comment is not correct in
> >> general, because conversions are dual-licensed (there are exceptions,
> >> but that's the generic rule).
> > 
> > Was told to do so in the past by the maintainers(Rob??) for text 
> > documents conversions.(Can't find exactly were in lore, must be in one my first conversion patches)
> > If someone was submitting as GPL2 long time ago then the derived/converted work still hold the same license.
> > Let me know if the consensus has changed.
> 
> Consensus did not change but I am no sure if you got it right. It was
> about copied copyrightable text. Which part was copied here?

It is derived from the text binding, so strictly speaking that's derived 
work. Are descriptions (because that's really all we take) enough to be 
copyrightable? That's another question...

I don't know so I err on the side of keep GPL-2.0-only *only*.

Will anyone ever care? Not likely.

Rob

