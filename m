Return-Path: <linux-kernel+bounces-571932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B329DA6C46B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3AD1B60C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C4A230BDA;
	Fri, 21 Mar 2025 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ10bVPP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE822FF5F;
	Fri, 21 Mar 2025 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589753; cv=none; b=QsYqnL1gKYhu9fEq5/Z70SgW1mDYFLlHlWWScRp0cvmVdg3LNaIKzLh+6vCCnogNS4jzjmug6J5tjb9d4uGbL8Ogc14ons6Onxvr5JlU8v2+gNd8iNc7lMrgGQHbqMIkcvz4aC3gR+kQHHU+funm6URCs0xCVomZlFAc3Y3re5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589753; c=relaxed/simple;
	bh=XsHupZXq9mP47xdssh7YIG1V2VG9jPjIpAnsYfLZZeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHzYgw6fK8VlwDhE11jdFM0vivsPdbIVECEgPr0EYsMdJznHU4mbrP5JLLS9K/SJkXTVZTe8MKaUB2+dUU5idqDxzTZmsWhscxVI0qLzMQhwwJnyCo9mvyevFagzd0GCnPZ+AJ8k1/k0bg0DIDkQ4M6Qbta4gV7mkc3c+yql6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ10bVPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F691C4CEE3;
	Fri, 21 Mar 2025 20:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742589751;
	bh=XsHupZXq9mP47xdssh7YIG1V2VG9jPjIpAnsYfLZZeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZ10bVPP4aa+uN6spoypuceQTO8SP4QPWeccXxsIlYlhuZoJ1zdJeO97DazL3pHq8
	 J/LoW3kqmiWfiAWymzcYpWcOyWFQSwDTe8Me1eYvjjv5XWRF2RLmn1BoZCYHf3QeAV
	 pnh1JHINei16ioRte+fZdGRzVe+r4sNwPkQeR0l16Lw6ng+PXHGpmtXP0D+ts9smCJ
	 JIpBRM7izWWBv3mb3ONwX8kKI22pDB+mv0VBX7cmyAj2KurPgMo78wqp/n2NvOl4s0
	 Zp8AOrnTmQPpYCB3Dqa7hWUTC2picFAyqVgMfJYx7kxhniuJxg5l+dbRqR2WHZIyUk
	 gLNVmPUkxAbHA==
Date: Fri, 21 Mar 2025 15:42:30 -0500
From: Rob Herring <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
	mturquette@baylibre.com, sboyd@kernel.org, dlan@gentoo.org,
	heylenay@4d2.org, guodong@riscstar.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/7] dt-bindings: soc: spacemit: define
 spacemit,k1-ccu resets
Message-ID: <20250321204230.GA3902727-robh@kernel.org>
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321151831.623575-2-elder@riscstar.com>

On Fri, Mar 21, 2025 at 10:18:24AM -0500, Alex Elder wrote:
> There are additional SpacemiT syscon CCUs whose registers control both
> clocks and resets:  RCPU, RCPU2, and APBC2. Unlike those defined
> previously, these will initially support only resets.  They do not
> incorporate power domain functionality.
> 
> Define the index values for resets associated with all SpacemiT K1
> syscon nodes, including those with clocks already defined, as well as
> the new ones (without clocks).
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../soc/spacemit/spacemit,k1-syscon.yaml      |  13 +-
>  include/dt-bindings/clock/spacemit,k1-ccu.h   | 134 ++++++++++++++++++
>  2 files changed, 143 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> index 07a6728e6f864..333c28e075b6c 100644
> --- a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> +++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> @@ -19,6 +19,9 @@ properties:
>        - spacemit,k1-syscon-apbc
>        - spacemit,k1-syscon-apmu
>        - spacemit,k1-syscon-mpmu
> +      - spacemit,k1-syscon-rcpu
> +      - spacemit,k1-syscon-rcpu2
> +      - spacemit,k1-syscon-apbc2
>  
>    reg:
>      maxItems: 1
> @@ -57,13 +60,15 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: spacemit,k1-syscon-apbc
> +            enum:
> +              - spacemit,k1-syscon-apmu
> +              - spacemit,k1-syscon-mpmu
>      then:
> -      properties:
> -        "#power-domain-cells": false
> -    else:
>        required:
>          - "#power-domain-cells"
> +    else:
> +      properties:
> +        "#power-domain-cells": false
>  
>  additionalProperties: false
>  
> diff --git a/include/dt-bindings/clock/spacemit,k1-ccu.h b/include/dt-bindings/clock/spacemit,k1-ccu.h
> index 4a0c7163257e3..a1e1b1fe714ce 100644
> --- a/include/dt-bindings/clock/spacemit,k1-ccu.h
> +++ b/include/dt-bindings/clock/spacemit,k1-ccu.h
> @@ -78,6 +78,9 @@
>  #define CLK_APB			31
>  #define CLK_WDT_BUS		32
>  
> +/*	MPMU resets	*/
> +#define RST_WDT			0
> +
>  /*	APBC clocks	*/
>  #define CLK_UART0		0
>  #define CLK_UART2		1
> @@ -109,6 +112,7 @@
>  #define CLK_PWM17		27
>  #define CLK_PWM18		28
>  #define CLK_PWM19		29
> +

Stray change?

Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

