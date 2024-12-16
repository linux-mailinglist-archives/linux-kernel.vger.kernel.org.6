Return-Path: <linux-kernel+bounces-447149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FA29F2DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA081888508
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2F4202C5D;
	Mon, 16 Dec 2024 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsWn6z+k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42086202C3A;
	Mon, 16 Dec 2024 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344052; cv=none; b=V3CwHlYOhL3hEmv2uxTFkBWnbf7CXqJzpgZdUS7fBnBLE8dXKa/ZBrNJ9OLgTahw+LM+85pp8rtHpG2E9d0lAxzhvYZ5cvNjiHzBr2MjyTksXguCaXreyWuI9HNqi5zw/w0fesEINuHPXO7Mo5Jo8FYQ91uqnAVXy7E46s7DI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344052; c=relaxed/simple;
	bh=neQjXpprVKKr7+IF1BUgJEHAPq3M8lzz9xydrcqWFo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soWcDBKtinYsH8dvMOTr3dOkUqctoCgXoj4T3SYawXxRl1mluMrkrpsdipeJlWsLuU1Iz86umZPUjxYmGITEmPxk3zbvTNI2s2AyC5IlOOXO27dAvVOHhMqIKN400CkGHjGkKofLbPE9ipjI/4KaT16AZvvT18YnbPRYLy4ip0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsWn6z+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BD8C4CED0;
	Mon, 16 Dec 2024 10:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734344051;
	bh=neQjXpprVKKr7+IF1BUgJEHAPq3M8lzz9xydrcqWFo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsWn6z+kYzVCL1d/ttsn3cAwhLsTJnrZKePws0DMQfCcdZfxqUGa1c+War27UfG/b
	 EccRMYa4nAOQhmutyTjfkJaoZ5nCS2WY34x6FY3kLKB+/XRi5L9KGJyx1M8RkFQ9ge
	 TIzi1EebQwjW7soX8CPxHJjUTYHCzpEWB5YVzsN3r0Gbaqj7NQMPUHIaTPxuWVo1H8
	 WpS5l+LFSQAOVxngrZiOu5Nz4rxePRs3grq767Af1lYipAbKKa3vFgRwNwEaWT+G2I
	 276CiLDsXZy728PqRvP18pQKkVyFP9Iq7ipiHqsspb0DyYjkJkdqTDLX7mEWvA4ejH
	 cUUX07hmt4mUQ==
Date: Mon, 16 Dec 2024 11:14:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Charan Pedumuru <charan.pedumuru@microchip.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: atmel,at91sam9260: Convert to json
 schema
Message-ID: <dxgqkdo6ulmqfa5vyerwta3vubuy32gzzu2cxfwwtespydfc4b@5wjrno3lgjsp>
References: <20241211-matrix-v1-1-5ef0104a3af4@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211-matrix-v1-1-5ef0104a3af4@microchip.com>

On Wed, Dec 11, 2024 at 04:59:22PM +0530, Charan Pedumuru wrote:
> Convert old text based binding to json schema.
> Changes during conversion:
> Add a fallback for all compatibles as the IP core is compatible
> with `syscon`.

I don't understand. The syscon was already there. You added different
fallback, so provide explanation why do you think they are compatible.

> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@microchip.com>
> ---
>  .../bindings/mfd/atmel,at91sam9260-matrix.yaml     | 54 ++++++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-matrix.txt       | 26 -----------
>  2 files changed, 54 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,at91sam9260-matrix.yaml b/Documentation/devicetree/bindings/mfd/atmel,at91sam9260-matrix.yaml
> new file mode 100644
> index 000000000000..0e827882823f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,at91sam9260-matrix.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/atmel,at91sam9260-matrix.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip AT91 Bus Matrix
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +
> +description:
> +  The Bus Matrix (MATRIX) implements a multi-layer AHB, based on the
> +  AHB-Lite protocol, that enables parallel access paths between multiple
> +  masters and slaves in a system, thus increasing the overall bandwidth.
> +
> +properties:
> +  compatible:
> +    anyOf:

oneOf
See other bindings for preferred syntax. There is never anyOf.

> +      - items:
> +          - enum:
> +              - atmel,at91sam9260-matrix
> +              - atmel,at91sam9261-matrix
> +              - atmel,at91sam9263-matrix
> +              - atmel,at91sam9rl-matrix
> +              - atmel,at91sam9g45-matrix
> +              - atmel,at91sam9n12-matrix
> +              - atmel,at91sam9x5-matrix
> +              - atmel,sama5d3-matrix
> +          - const: syscon
> +      - items:
> +          - const: microchip,sam9x60-matrix
> +          - const: atmel,at91sam9x5-matrix
> +          - const: syscon
> +      - items:
> +          - const: microchip,sam9x7-matrix

So that's just enum with previous group.


> +          - const: atmel,at91sam9x5-matrix
> +          - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    matrix@ffffec00 {

syscon@
or system-controller@


Best regards,
Krzysztof


