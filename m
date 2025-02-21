Return-Path: <linux-kernel+bounces-525357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C01EA3EEF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E6B420FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF4201016;
	Fri, 21 Feb 2025 08:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZKkPBZw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD16E1E990A;
	Fri, 21 Feb 2025 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127564; cv=none; b=F2XH1xv+LZgm0PEvO7mmItLICbtOZcREOGUBSUlHyi0BQ+TLa4NVgtapkOCTt6JmgM4Yrb43nd2mqIRPduH9tnqAK9ScOr5xUUvPX6eSVbpVZDPbbros8nyzAMfL97/d2++JCMkLaNp4Z6IPUvFJcMwee/2F0fz+pZse8pa7a8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127564; c=relaxed/simple;
	bh=XpEhHbp+h0bF2bdUl5GcpbzEs979Jm89KTGh2m+OmVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfL0T2N8pLNOnco2rtJ3s77hW67jPW1G+8bx0Hb8iKUew7h/ZFeMGtWbh1/78Sy4LOHTcwM5K91N184nJLnVigei5X/Qnp05/s+GvzrTvk9fc103mQFYb8BQQfIHP9kqfIIo1uEb94nABO25aNUU5zEGdxRxu0WVo0cUBz4aBVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZKkPBZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F1FC4CED6;
	Fri, 21 Feb 2025 08:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740127564;
	bh=XpEhHbp+h0bF2bdUl5GcpbzEs979Jm89KTGh2m+OmVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZKkPBZw8KFhau1TXSUdu2FfjiAWmTX/WjL6U65psI6YeWcdoi0qN4xBxzIik6GQ1
	 39G7GRTQe4qISeqG7wRRh6gZE83zSuALeevuvcT7gCwHq5cTbilu6frZfvIeMmRMtD
	 F7mmaUnStgMaPct7U9uqZeuk0/UQJQoYZMVv+VJ0u6c4MRw1MQQ+A8cXRSurVF2oGz
	 Iu0YwvOncRBopUa3kXL0inRTMghbeGXWxhVkABA9bNkwN+PVOyUzldRERcTwbC0RxW
	 7sbkb7BmvHXkJT+Dz37q/lO+wqfnJSNQv+18fl7qt2BKpyOhwhPv2wtN44OiXrrRXQ
	 xpaeKhRu2GqSA==
Date: Fri, 21 Feb 2025 09:46:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wilson Ding <dingwei@marvell.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, salee@marvell.com, gakula@marvell.com
Subject: Re: [PATCH v2 1/4] dt-bindings: reset: Add Armada8K reset controller
Message-ID: <20250221-icy-flounder-of-potency-ee1a05@krzk-bin>
References: <20250220232527.882888-1-dingwei@marvell.com>
 <20250220232527.882888-2-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220232527.882888-2-dingwei@marvell.com>

On Thu, Feb 20, 2025 at 03:25:24PM -0800, Wilson Ding wrote:
> Add device-tree binding documentation for the Armada8K reset driver.
> 
> Signed-off-by: Wilson Ding <dingwei@marvell.com>
> ---
>  .../reset/marvell,armada8k-reset.yaml         | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml b/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
> new file mode 100644
> index 000000000000..b9f7f3c24d3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Wilson Ding <dingwei@marvell.com>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/marvell,armada8k-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Armada8K reset controller
> +
> +maintainers:
> +  - Wilson Ding <dingwei@marvell.com>
> +
> +description: The reset controller node must be a sub-node of the system
> +  controller node on Armada7K/8K or CN913x SoCs.
> +
> +properties:
> +  compatible:
> +    const: marvell,armada8k-reset
> +
> +  offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Offset in the register map for the gpio registers (in bytes)

That's neither correct nor needed. Your device knows ofsset based on the
compatible.

Best regards,
Krzysztof


