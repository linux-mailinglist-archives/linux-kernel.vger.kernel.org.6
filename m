Return-Path: <linux-kernel+bounces-295344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D70519599E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165A31C223D0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC2B20ABE7;
	Wed, 21 Aug 2024 10:32:40 +0000 (UTC)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D21D049C;
	Wed, 21 Aug 2024 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724236360; cv=none; b=rTd24A20USxVFjhP3TeGKhjKv2FAQMVkeVaKcX1U+ccSCMOrmJ5jeCRzLTlQ08EewpC+BnAm30K4oyvkuyJWvqzs4fTd/h/xkzezX6oz0HdJrqrTlwHNoWMIZUcS8ueoz22e1qZ/NgYjbAfMo2pykygyRsr2iholpRzlpnnnBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724236360; c=relaxed/simple;
	bh=Dg3jC7tA9gxO0HGa5Z3i+nq6/IXPfIuZF2yd3yGW+PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=RE4KMX8RqxUz05SyIdHqy1UqRe4tfa2MqQ7b02wV7Dj39sNbvHTkE0OuQELPKWMqWcLJkWJoxF+YM8UO/w2K7LSNOiJxFpXPTbVH+WLT2MbOg+gpt58x3orhLZcZDNri7aOkS/WTNadS5B2uCPcq6FJU4yvZk7pTkdiWqJZU4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 21 Aug 2024 19:31:29 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 3B673200848A;
	Wed, 21 Aug 2024 19:31:29 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Wed, 21 Aug 2024 19:31:29 +0900
Received: from [10.212.247.18] (unknown [10.212.247.18])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 8C2B5AB187;
	Wed, 21 Aug 2024 19:31:28 +0900 (JST)
Message-ID: <9fcb9c03-080d-4798-8173-a24c7d05b420@socionext.com>
Date: Wed, 21 Aug 2024 19:31:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: reset: socionext,uniphier-glue-reset: add
 top-level constraints
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240818172819.121697-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20240818172819.121697-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 2024/08/19 2:28, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names and reset-names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/reset/socionext,uniphier-glue-reset.yaml     | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.ya
> ml
> b/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.ya
> ml
> index fa253c518d79..babc563ae61e 100644
> ---
> a/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.ya
> ml
> +++
> b/Documentation/devicetree/bindings/reset/socionext,uniphier-glue-reset.ya
> ml
> @@ -38,13 +38,17 @@ properties:
>       minItems: 1
>       maxItems: 2
>   
> -  clock-names: true
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
>   
>     resets:
>       minItems: 1
>       maxItems: 2
>   
> -  reset-names: true
> +  reset-names:
> +    minItems: 1
> +    maxItems: 2
>   
>   allOf:
>     - if:

Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

I'd appreciate if it could be applied in devicetree or reset.

Thank you,

---
Best Regards
Kunihiko Hayashi

