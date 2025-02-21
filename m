Return-Path: <linux-kernel+bounces-526809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BC1A40396
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D02119E0411
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6A4212B2B;
	Fri, 21 Feb 2025 23:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoyY0X+y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0018DB0B;
	Fri, 21 Feb 2025 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181243; cv=none; b=qSAjBatQUkaTNMm4V6sMk0TzDxtRxbtXP7GPTpe3duwH+bS3bKsYYxKOF/pirHUbhQHoQH4sEmosmE74GpNo+hPe27RokHWOEmHbKeRgEee3cgn6axt4o61wQg4wUvJFUI+uwbuGiJsRFWw9+k8wRpiAO3WfkVKW7oW6xUPAVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181243; c=relaxed/simple;
	bh=OMCDVsQbn+5F1Lg61OuxMEK9sGVYuBuiegxwEU46gMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfCjWUemzCsWwGWvtSG7Lj1j2iNJ8aHaPIyTx/H0izcPxcvJvBxL/74O8xNulHY88o2jRm4jKMsMSyr9h1DRGo1uerJaIOl39iePFI20/Um61Gcu6OEuwnt+vhVuVPgQSuTKcHlO+7kI9Tm9iKI5jfnts6nHzDLPBHbcpPYBlFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoyY0X+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC6FC4CED6;
	Fri, 21 Feb 2025 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740181243;
	bh=OMCDVsQbn+5F1Lg61OuxMEK9sGVYuBuiegxwEU46gMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VoyY0X+yQSKVMby/G/x1/JrL2hCHNW6yv8JGE75JrTxe+fq9Unhw/+Vtj5yJcsRRs
	 pIgCcW1fyPhIWTyJTL5EkRhTkGlejWIiS/M9/Pm+JCpGw8w9kf08avnMFjFLAIG6/6
	 ziY0DWe9TR5E+ptGSkJe535KTcbsM8fRz68GVN5H9zX16ZRH7Ydiz8jVlxq1fXfRlt
	 GPZKYyYqVC1q/QWSdZOomG/Wr/bY3sS7RxivYIqJ0piVyyqATaDHKX+LQztzLh2l56
	 TtDX+njNQbwvSDUG3ZSoSV6TiKen1HYWKZ+qoubdcXNux+xgx8VtUtWwGgxBjcJUg5
	 62RjqvADws+Lw==
Date: Fri, 21 Feb 2025 17:40:41 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Wilson Ding <dingwei@marvell.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de, salee@marvell.com,
	gakula@marvell.com
Subject: Re: [PATCH v2 1/4] dt-bindings: reset: Add Armada8K reset controller
Message-ID: <20250221234041.GA387671-robh@kernel.org>
References: <20250220232527.882888-1-dingwei@marvell.com>
 <20250220232527.882888-2-dingwei@marvell.com>
 <20250221-icy-flounder-of-potency-ee1a05@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-icy-flounder-of-potency-ee1a05@krzk-bin>

On Fri, Feb 21, 2025 at 09:46:01AM +0100, Krzysztof Kozlowski wrote:
> On Thu, Feb 20, 2025 at 03:25:24PM -0800, Wilson Ding wrote:
> > Add device-tree binding documentation for the Armada8K reset driver.
> > 
> > Signed-off-by: Wilson Ding <dingwei@marvell.com>
> > ---
> >  .../reset/marvell,armada8k-reset.yaml         | 45 +++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml b/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
> > new file mode 100644
> > index 000000000000..b9f7f3c24d3c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
> > @@ -0,0 +1,45 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2025 Wilson Ding <dingwei@marvell.com>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/reset/marvell,armada8k-reset.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell Armada8K reset controller
> > +
> > +maintainers:
> > +  - Wilson Ding <dingwei@marvell.com>
> > +
> > +description: The reset controller node must be a sub-node of the system
> > +  controller node on Armada7K/8K or CN913x SoCs.
> > +
> > +properties:
> > +  compatible:
> > +    const: marvell,armada8k-reset
> > +
> > +  offset:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Offset in the register map for the gpio registers (in bytes)
> 
> That's neither correct nor needed. Your device knows ofsset based on the
> compatible.

Or use 'reg'.

But really, just add #reset-cells to the parent node. There's no need 
for a child node here. The parent needs a specific compatible though.

Rob

