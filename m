Return-Path: <linux-kernel+bounces-528432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF541A417A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938171895447
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B0521D3C9;
	Mon, 24 Feb 2025 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RonHsc+v"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8A721B9C6;
	Mon, 24 Feb 2025 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386481; cv=none; b=i1Kh6cOcrZxL5qFH3YIENfoNkoP4FyAGJsxiZahOmv/4VNtDgkv3VhbpUAPzxbGWT3Jd9D56H4+66tJ/dgE12VeA4Mx2gwpzSeqB3HHWNeiQfh/pvYyBwitbr4gR19xLCj0V8HVhQ/uVHMAiQ0Y9e7nTfnkY9OHr5p6NP44Rh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386481; c=relaxed/simple;
	bh=EdJUC5zOTOXDdYWtkRM86xCvIG5hDEGJH5u0fmEoafo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhOly2eNscu5DsOjNYq6U3BxpLwnWgA4GTbkTYLZRUYt4LAMUl8DkZoc7tvz0aMPCK9KnFwJNuZLke+LCNL7Lp0MkS8iBpdsiyl8LL+vD6Yb38TVDwfoxOAihRYFoS2YLDDrn1QiAG9SYeU607dNy/nbeHirIULYOJ/hqymXEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RonHsc+v; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740386476;
	bh=EdJUC5zOTOXDdYWtkRM86xCvIG5hDEGJH5u0fmEoafo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RonHsc+vPguKsSnsAz+OhTph7Uz1BaPG7Q3UHU/HpraCDUZroyENnc+zvZRDjb0sj
	 50Pp4de3hK8/XXoKoLtcEhxMEv6bgPOFSK7I9c6hAYPPcqHvQoF9CexEOnUpTMkjR4
	 Sz3XKTj8i8Qwx4sFi6u/BCBcggB6rzNkLHrI1PAS78ZUCtC/O7+jPQFLosLCvClrYt
	 PsBvM7hrpckK5vJ1zN1bS6aSgmDoyR2993kSunHu2TOffYoD/gLqFf4Yp0eamZ5mFZ
	 SSdoTyFERY53VVaK2+LAzrx8nBAZ4BfsnIIL8a3za3+vD/k/dNRuKSr3SwQ2Hnzhl3
	 Zp1uzKv4lKiTw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 361DD17E0DD1;
	Mon, 24 Feb 2025 09:41:16 +0100 (CET)
Message-ID: <0dcb2efd-6bbb-4701-960a-74930eb457e4@collabora.com>
Date: Mon, 24 Feb 2025 09:41:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
To: Friday Yang <friday.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250221074846.14105-1-friday.yang@mediatek.com>
 <20250221074846.14105-2-friday.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250221074846.14105-2-friday.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/02/25 08:48, Friday Yang ha scritto:
> From: "Friday Yang" <friday.yang@mediatek.com>
> 
> On the MediaTek platform, some SMI LARBs are directly connected to
> the SMI Common, while others are connected to the SMI Sub-Common,
> which in turn is connected to the SMI Common. The hardware block
> diagram can be described as follows.
> 
>               SMI-Common(Smart Multimedia Interface Common)
>                   |
>           +----------------+------------------+
>           |                |                  |
>           |                |                  |
>           |                |                  |
>           |                |                  |
>           |                |                  |
>         larb0       SMI-Sub-Common0     SMI-Sub-Common1
>                     |      |     |      |             |
>                    larb1  larb2 larb3  larb7       larb9
> 
> For previous discussion on the direction of the code modifications,
> please refer to:
> https://lore.kernel.org/all/CAFGrd9qZhObQXvm2_abqaX83xMLqxjQETB2=
> wXpobDWU1CnvkA@mail.gmail.com/
> https://lore.kernel.org/all/CAPDyKFpokXV2gJDgowbixTvOH_5VL3B5H8ey
> hP+KJ5Fasm2rFg@mail.gmail.com/
> 
> On the MediaTek MT8188 SoC platform, we encountered power-off failures
> and SMI bus hang issues during camera stress tests. The issue arises
> because bus glitches are sometimes produced when MTCMOS powers on or
> off. While this is fairly normal, the software must handle these
> glitches to avoid mistaking them for transaction signals. What's
> more, this issue emerged only after the initial upstreaming of this
> binding. Without these patches, the SMI becomes unstable during camera
> stress tests.
> 
> The software solutions can be summarized as follows:
> 
> 1. Use CLAMP to disable the SMI sub-common port after turning off the
>     LARB CG and before turning off the LARB MTCMOS.
> 2. Use CLAMP to disable/enable the SMI sub-common port.
> 3. Implement an AXI reset for SMI LARBs.
> 
> This patch primarily add two changes:
> 1. Add compatible for SMI sub-common on MT8188 SoC.
> 2. Add 'resets' and 'reset-names' properties for SMI LARBs to
>     support SMI reset operations.
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
> ---
>   .../mediatek,smi-common.yaml                  |  2 ++
>   .../memory-controllers/mediatek,smi-larb.yaml | 20 +++++++++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index 2f36ac23604c..4392d349878c 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -39,6 +39,7 @@ properties:
>             - mediatek,mt8186-smi-common
>             - mediatek,mt8188-smi-common-vdo
>             - mediatek,mt8188-smi-common-vpp
> +          - mediatek,mt8188-smi-sub-common
>             - mediatek,mt8192-smi-common
>             - mediatek,mt8195-smi-common-vdo
>             - mediatek,mt8195-smi-common-vpp
> @@ -107,6 +108,7 @@ allOf:
>           compatible:
>             contains:
>               enum:
> +              - mediatek,mt8188-smi-sub-common
>                 - mediatek,mt8195-smi-sub-common
>       then:
>         required:
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> index 2381660b324c..2e86bb3455f9 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> @@ -69,6 +69,12 @@ properties:
>       description: the hardware id of this larb. It's only required when this
>         hardware id is not consecutive from its M4U point of view.
> 
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: larb
> +
>   required:
>     - compatible
>     - reg
> @@ -125,6 +131,20 @@ allOf:
>         required:
>           - mediatek,larb-id
> 
> +  - if:  # only for image, camera and ipe subsys
> +      properties:
> +        compatible:
> +          const: mediatek,mt8188-smi-larb
> +        mediatek,larb-id:
> +          oneOf:

Are you really sure that you need 'oneOf' here? :-)

Regards,
Angelo

> +            - enum:
> +                [ 9, 10, 11, 12, 13, 16, 17, 18, 19, 20 ]
> +
> +    then:
> +      required:
> +        - resets
> +        - reset-names
> +
>   additionalProperties: false
> 
>   examples:
> --
> 2.46.0
> 




