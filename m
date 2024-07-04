Return-Path: <linux-kernel+bounces-240995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E520927577
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D279FB21694
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0608F1AD3F7;
	Thu,  4 Jul 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rmU1cJKQ"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B7416F0D5;
	Thu,  4 Jul 2024 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093754; cv=none; b=TLzNLy4uGQagpRFioIb1fVp8phkKccvHF7z/1P18T2LiRZiSEei4kd8K4zDk4GSPQyQL/jir76xmaxR3BJgkGxkWITpUdNJ+DPBIMma4zwXLHaU45ReDtaSXncNIeIcykpKhdr7VSYWmo9smWjedt7dwDEMKzUh+QMui/iMKNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093754; c=relaxed/simple;
	bh=+ZO4E8s2E70xagRUNoHmxIKLlEHfBkwR8G9jUKMb5R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwiICrCxK0hUssfzr3b1LwxThdnHRkm6DTiqee+wGToGL5+udpShZXoBK+1apzZ6XQigSnnYEAIkc3PoL1W6C2WD54J9XwoVSEA9Tcuga79UNe4WPbTNl9jUaeCo2yYeKfFw88HkXO1BuvsSUl8A/H73j8sZUkrO+MaRrQ+DDWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rmU1cJKQ; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720093749; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/8KlDc1Q1lXOp6OasZ6L+XmlH+f8Rq5x2AV+s1uBmwE=;
	b=rmU1cJKQ9dKI6r3Bo9/h9FB3aBjHLFngWe2Ky8XBDTK2l2xYdQ4O55DtYtbmDFhGaTOxbS9M/ZthtRE8K9s8M6y6umU6wjpvDFwqzrLDHVAkvm6rbQmBkhhiwhg38YxIYpSiZK0usnnLa3pqg7z68CT6MEOJ+9+WU4EZerfe2lc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W9qn9fg_1720093748;
Received: from 30.97.56.65(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9qn9fg_1720093748)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 19:49:08 +0800
Message-ID: <648b121e-149c-417a-afd5-848348923721@linux.alibaba.com>
Date: Thu, 4 Jul 2024 19:49:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: timer: sprd-timer: convert to YAML
To: Stanislav Jakubek <stano.jakubek@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang7@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <ZoU95lBgoyF/8Md3@standask-GA-A55M-S2HP>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZoU95lBgoyF/8Md3@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/3 20:02, Stanislav Jakubek wrote:
> Convert the Spreadtrum SC9860 timer bindings to DT schema.
> 
> Changes during conversion:
>    - rename file to match compatible
>    - add sprd,sc9860-suspend-timer which was previously undocumented
>    - minor grammar fix in description
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   .../bindings/timer/sprd,sc9860-timer.yaml     | 68 +++++++++++++++++++
>   .../bindings/timer/spreadtrum,sprd-timer.txt  | 20 ------
>   2 files changed, 68 insertions(+), 20 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/timer/sprd,sc9860-timer.yaml
>   delete mode 100644 Documentation/devicetree/bindings/timer/spreadtrum,sprd-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/sprd,sc9860-timer.yaml b/Documentation/devicetree/bindings/timer/sprd,sc9860-timer.yaml
> new file mode 100644
> index 000000000000..62c6da8bab5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/sprd,sc9860-timer.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/sprd,sc9860-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Spreadtrum SC9860 timer
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +description:
> +  The Spreadtrum SC9860 platform provides 3 general-purpose timers.
> +  These timers can support 32bit or 64bit counter, as well as supporting
> +  period mode or one-shot mode, and they can be a wakeup source
> +  during deep sleep.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,sc9860-timer
> +      - sprd,sc9860-suspend-timer
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sprd,sc9860-timer
> +    then:
> +      required:
> +        - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      timer@40050000 {
> +        compatible = "sprd,sc9860-timer";
> +        reg = <0 0x40050000 0 0x20>;
> +        interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&ext_32k>;
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/timer/spreadtrum,sprd-timer.txt b/Documentation/devicetree/bindings/timer/spreadtrum,sprd-timer.txt
> deleted file mode 100644
> index 6d97e7d0f6e8..000000000000
> --- a/Documentation/devicetree/bindings/timer/spreadtrum,sprd-timer.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -Spreadtrum timers
> -
> -The Spreadtrum SC9860 platform provides 3 general-purpose timers.
> -These timers can support 32bit or 64bit counter, as well as supporting
> -period mode or one-shot mode, and they are can be wakeup source
> -during deep sleep.
> -
> -Required properties:
> -- compatible: should be "sprd,sc9860-timer" for SC9860 platform.
> -- reg: The register address of the timer device.
> -- interrupts: Should contain the interrupt for the timer device.
> -- clocks: The phandle to the source clock (usually a 32.768 KHz fixed clock).
> -
> -Example:
> -	timer@40050000 {
> -		compatible = "sprd,sc9860-timer";
> -		reg = <0 0x40050000 0 0x20>;
> -		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&ext_32k>;
> -	};

