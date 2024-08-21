Return-Path: <linux-kernel+bounces-295172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BA2959821
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE1A1F231EA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B81D67BE;
	Wed, 21 Aug 2024 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uc6YNO8G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C191D1D67B3;
	Wed, 21 Aug 2024 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230562; cv=none; b=IxRaT1jnA33fqWxWSAkoUC9h3e9p4sOWfZQqau9AhadrqsakWqYsj+X1KgLX1xKgl3VV1IbAqEvv7eEGbhVaggPaTXvNPqogCe/5Wyad7Hn4IGVa8U4lr0M2csuor6L2PznKs36j8/UxUf1Tf0CSSzSWurZWF4NlHfQHC+5h/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230562; c=relaxed/simple;
	bh=BKWK/MIr7vovdnFd09Ogcsd1XHNLtj7+YWELK1bYOvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbuUGlXp+j7aw+Bk18h1nZnXDg+Yafc2HXyktlGxDSo4vJwtQIxqyq0tmJ0qLB8wS6DXw5SjUqMXfl1Zx9Ln4OK2UxE6MWysU1kjvBXe8ZMOT0TsRZLVZ9joKj/2hOGVR3z1YQh1yAN5Ln/a+nHvT39IKtVY/b6yWFWimC+C9DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uc6YNO8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB305C32782;
	Wed, 21 Aug 2024 08:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724230561;
	bh=BKWK/MIr7vovdnFd09Ogcsd1XHNLtj7+YWELK1bYOvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Uc6YNO8GsFYtYyRSgRKVPMKezIl7MwSF/x0g5jixCwxcSI0agxtLk2U9Ce2hpT3l1
	 WNsfF90X22S0F6cjgqlkbb6osSnUOtTnn1bLOG/yLSYoOsRaW4PS6Mf6WYyaAzi1sm
	 DR/Ij4Z+kpE/Rq+rZKbw8NXGFUwLOizonbfCo5ctNgxWv0ZAM1Uk3PS3R5bdKrDV+k
	 AVM7WG+4GlTB1OLVXkIk/C4qQ7yiLrLvWOweZROYcb/NBbLPLHgT3OIA6BOzEfKBcc
	 Gk6j2xxSDZ1FGUFva8qHGBIWC4fuob5jFwHrc5JWXmO2mpm1+H5VxSitWJ7w6NMzFl
	 l2b7EY52NBe7A==
Message-ID: <3b31bf46-c5c0-41c9-bb4d-3ba9f64a5d1c@kernel.org>
Date: Wed, 21 Aug 2024 10:55:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: memory: mediatek: Add smi-sub-common
 property for reset
To: "friday.yang" <friday.yang@mediatek.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240821082845.11792-1-friday.yang@mediatek.com>
 <20240821082845.11792-3-friday.yang@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240821082845.11792-3-friday.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2024 10:26, friday.yang wrote:
> On the MediaTek platform, some SMI LARBs are directly linked to SMI
> common. While some SMI LARBs are linked to SMI sub common, then SMI
> sub common is linked to SMI common. Add 'mediatek,smi-sub-comm' and
> 'mediatek,smi-sub-comm-in-portid' properties here. The SMI reset
> driver could query which port of the SMI sub common the current LARB
> is linked to through the two properties. The hardware block diagram
> could be described as below.
> 
>              SMI Common(Smart Multimedia Interface Common)
>                  |
>          +----------------+-------
>          |                |
>          |                |
>          |                |
>          |                |
>          |                |
>        larb0       SMI Sub Common
>                    |      |     |
>                   larb1  larb2 larb3
> 
> Signed-off-by: friday.yang <friday.yang@mediatek.com>
> ---
>  .../mediatek,smi-common.yaml                  |  2 ++
>  .../memory-controllers/mediatek,smi-larb.yaml | 22 +++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index 2f36ac23604c..4392d349878c 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -39,6 +39,7 @@ properties:
>            - mediatek,mt8186-smi-common
>            - mediatek,mt8188-smi-common-vdo
>            - mediatek,mt8188-smi-common-vpp
> +          - mediatek,mt8188-smi-sub-common
>            - mediatek,mt8192-smi-common
>            - mediatek,mt8195-smi-common-vdo
>            - mediatek,mt8195-smi-common-vpp
> @@ -107,6 +108,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - mediatek,mt8188-smi-sub-common
>                - mediatek,mt8195-smi-sub-common
>      then:
>        required:
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> index 2381660b324c..5f162bb360db 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -69,6 +69,16 @@ properties:
>      description: the hardware id of this larb. It's only required when this
>        hardware id is not consecutive from its M4U point of view.
>  
> +  mediatek,smi-sub-comm:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: a phandle of smi_sub_common that the larb is linked to.

Why do you have to smi phandle properties per each node?

> +
> +  mediatek,smi-sub-comm-in-portid:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +    description: which port of smi_sub_common that the larb is linked to.

Merge it into phandle.

> +
>  required:
>    - compatible
>    - reg
> @@ -125,6 +135,18 @@ allOf:
>        required:
>          - mediatek,larb-id
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8188-smi-larb
> +
> +    then:
> +      required:
> +        - mediatek,smi-sub-comm
> +        - mediatek,smi-sub-comm-in-portid
> +

and add it to the example (since you claim it is valid for every device).

Best regards,
Krzysztof


