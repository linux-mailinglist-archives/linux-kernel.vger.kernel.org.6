Return-Path: <linux-kernel+bounces-192111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5559E8D188C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3DB1F22DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8DF16C878;
	Tue, 28 May 2024 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s8mN3T2R"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5016C857;
	Tue, 28 May 2024 10:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891895; cv=none; b=jYUXPea/HyJ8vBvxU6ewrf1moRqS9lLjh7IuBQd2uwzt06/JBYc7KAaeMzghd1pRJ9uG333Dg6U94fbjsDcQBN6dtcMAR9C1aTC+KtBeVNBwj5K8yHZwhKde8o8GUh9lrcinAdt++dvAQ0wj78r3Q0s/4RkKta7ist1KwbcRV2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891895; c=relaxed/simple;
	bh=3ozJkRbRnqcBMiG82KQYzYUrYBmNg5J09V7+FZcUdyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UM66ZvF6u/813m65cViO72op4PVHgB3rbFLclZRJnLYpZoQs5FvLrujzXKjQuF3dsUJB11dXzaVdLM1kM6e/LXVEm1U2wZBJV3v+I3ZGo7ZWDWVPF79nICKGKPe1fAlBEDpbBlskZWX8koIeNLEoytcGBjH0BD3zchXTOESeI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s8mN3T2R; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716891891;
	bh=3ozJkRbRnqcBMiG82KQYzYUrYBmNg5J09V7+FZcUdyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s8mN3T2RTRaFj0NmkozsR2LG+4RPMKanCLADbo180l85bH6IVkqVCCiswIW65g6Ui
	 rSi7D36NVMhui/P3AyoWRH3maXdhhxQ4y+cDCGswrkBk4dlXEO1jEEKile8xcG9ry/
	 qh8vmsrNhzBusjCZwZPY9zZz7B3EXjr0hWm+vgJcE6k5aGXCIqVle0kvM3wDDLBMlJ
	 lIa4pro8b1wvBw/Y919SkmeM12EsmrRGCvkl8xLVWpcciu7DXj0CobA2khLLQzNB4p
	 700lTsL5iRaQX1dyzbhswDTid3cYyAKMsjTpOw9xZZb91ZR7riyilJ/Vgl6z2Q0eps
	 4fX8t5IxwM4TQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A61BE3782160;
	Tue, 28 May 2024 10:24:50 +0000 (UTC)
Message-ID: <f1d85b54-f0d6-4274-923c-2ad31eab2b19@collabora.com>
Date: Tue, 28 May 2024 12:24:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] dt-bindings: mailbox: Add property for CMDQ secure
 driver
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Jason-ch Chen <jason-ch.chen@mediatek.com>,
 Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
 Shawn Sung <shawn.sung@mediatek.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240525230810.24623-1-jason-jh.lin@mediatek.com>
 <20240525230810.24623-3-jason-jh.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240525230810.24623-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/05/24 01:08, Jason-JH.Lin ha scritto:
> 1. Add mboxes property to define a GCE loopping thread as a secure IRQ
> handler.
> The CMDQ secure driver requests a mbox channel and sends a looping
> command to the GCE thread. The looping command will wait for a secure
> packet done event signal from secure world and then jump back to the
> first instuction. Each time it waits for an event, it notifies the
> CMDQ driver to perform the same action as the IRQ handler.
> 
> 2. Add gce-events property from gce-props.yaml to define a
> secure packet done signal in secure world.
> There are 1024 events IDs for GCE to use to execute instructions in
> the specific event happened. These events could be signaled by HW or SW
> and their value would be different in different SoC because of HW event
> IDs distribution range from 0 to 1023.
> If we set a static event ID: 855 for mt8188, it might be conflict the
> event ID original set in mt8195.
> So we define an event ID that will be set when GCE runs to the end of
> secure cmdq packet in the secure world.
> 
> This can reduce the latency of software communication between normal
> world and secure world. In addition, we can also remove the complex
> logic after the secure packet done in the secure world.
> 

Hello Jason,

Is this looping thread SoC specific, board specific or firmware specific?

Thanks,
Angelo

> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>   .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> index cef9d7601398..6e5e848d61d9 100644
> --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> @@ -49,6 +49,10 @@ properties:
>       items:
>         - const: gce
>   
> +  mboxes:
> +    items:
> +      - description: GCE looping thread as a secure IRQ handler
> +
>   required:
>     - compatible
>     - "#mbox-cells"
> @@ -57,6 +61,8 @@ required:
>     - clocks
>   
>   allOf:
> +  - $ref: /schemas/mailbox/mediatek,gce-props.yaml#
> +
>     - if:
>         not:
>           properties:
> @@ -67,7 +73,7 @@ allOf:
>         required:
>           - clock-names
>   
> -additionalProperties: false
> +unevaluatedProperties: false
>   
>   examples:
>     - |




