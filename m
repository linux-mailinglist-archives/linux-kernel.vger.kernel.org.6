Return-Path: <linux-kernel+bounces-260395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B2793A859
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D623283AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFC2143897;
	Tue, 23 Jul 2024 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA0UpMbY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5A13D898;
	Tue, 23 Jul 2024 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721767938; cv=none; b=PwOC4uMSpQGOiaLbqQUyQjvfnwFpLuUkyp5KrPjnc3MrSgAzmo4dhZYx+HM5tQoZOqrndAyr/qJ91fYs/TKydHJfxYBcBMpTinpRikal1eSxr8qEmE4BLC5Kl43W9wH/R4gRvOplryXEBSff8cVKlC78YPvrkd1ghCkYgMnJudA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721767938; c=relaxed/simple;
	bh=SuPGKOJN4rkII5Kk/XP+P0wY376fawj1oqR/0F+y9Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYl4c4Pg7ohYkTkBu0Cc1NDZFLxwY4cemS/JYc2nxN4ktfzocmZIPkXp3Dfhj5wdVF3XUWQSQmCI9A7z4Va5VXQS1Fp4LpiisgFXz+ObZsD2onYRS633KQlwYS6bLUyV8AYs3wy4u7c9qgZflBvuZ/6pC1bmCtcwR9Nb4CnTp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA0UpMbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E95C4AF0A;
	Tue, 23 Jul 2024 20:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721767938;
	bh=SuPGKOJN4rkII5Kk/XP+P0wY376fawj1oqR/0F+y9Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mA0UpMbYFFt46VT/9nHHd8SVUbKWvb4dXPdQqDAKARRXWccI8u3sqLH7Vy397R2m3
	 Mg2M1c87YlfGm4sk9V6KneBbmSevFXrxG0TgfQzemJfH0GwbBGEn+vcnQA6YeERZz5
	 bhk2ywI/w/khTTVQYPeGp2FYlwMRv2c6+AbDukdSz9Rd0F56v72oXdXR7odowPQ9bT
	 RzqvT9aklZHEtMk0LUEFOySkoXBZjmn6oQBKGY+bXkEG8PXH2ZxXhcuQQ8FWleQkxl
	 LOf3V+XLCImsrEdhRPotzd/QtvLrXzL/z4ro4r/TTJxx95SyH13g6jxAv+X0TDEs4d
	 KZl4RLG+a2JLQ==
Date: Tue, 23 Jul 2024 15:52:16 -0500
From: Rob Herring <robh@kernel.org>
To: ysionneau@kalrayinc.com
Cc: linux-kernel@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Borne <jborne@kalrayinc.com>,
	Julian Vetter <jvetter@kalrayinc.com>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 09/37] dt-bindings: Add binding for
 kalray,kv3-1-timer
Message-ID: <20240723205216.GA1086273-robh@kernel.org>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-10-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722094226.21602-10-ysionneau@kalrayinc.com>

On Mon, Jul 22, 2024 at 11:41:20AM +0200, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add binding for Kalray kv3-1 core timer.
> 
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> 
> V2 -> V3: New patch
> ---
>  .../bindings/timer/kalray,kv3-1-timer.yaml    | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/kalray,kv3-1-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/kalray,kv3-1-timer.yaml b/Documentation/devicetree/bindings/timer/kalray,kv3-1-timer.yaml
> new file mode 100644
> index 0000000000000..1932f28a05a18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/kalray,kv3-1-timer.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/kalray,kv3-1-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kalray kv3-1 core timer
> +
> +maintainers:
> +  - Jonathan Borne <jborne@kalrayinc.com>
> +  - Julian Vetter <jvetter@kalrayinc.com>
> +  - Yann Sionneau <ysionneau@kalrayinc.com>
> +
> +description: |

Don't need '|' if no formatting.

> +  Timer tightly coupled to the kv3-1 processor core. It is configured via core SFR.
> +  It triggers an interrupt directly on core-intc.
> +
> +properties:
> +  compatible:
> +    const: kalray,kv3-1-timer
> +
> +  interrupts-extended:
> +    maxItems: 16

I assume this is 1 interrupt per core, but I shouldn't have to assume 
that.

Only 16 cores supported?

> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - interrupts-extended
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    core_timer {
> +        compatible = "kalray,kv3-1-timer";
> +        clocks = <&core_clk>;
> +        interrupts-extended = <&core_intc0 0>,
> +                              <&core_intc1 0>,
> +                              <&core_intc2 0>,
> +                              <&core_intc3 0>,
> +                              <&core_intc4 0>,
> +                              <&core_intc5 0>,
> +                              <&core_intc6 0>,
> +                              <&core_intc7 0>,
> +                              <&core_intc8 0>,
> +                              <&core_intc9 0>,
> +                              <&core_intc10 0>,
> +                              <&core_intc11 0>,
> +                              <&core_intc12 0>,
> +                              <&core_intc13 0>,
> +                              <&core_intc14 0>,
> +                              <&core_intc15 0>;
> +    };
> +
> -- 
> 2.45.2
> 
> 
> 
> 
> 

