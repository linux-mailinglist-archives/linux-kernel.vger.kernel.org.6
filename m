Return-Path: <linux-kernel+bounces-528436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C686CA417B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E523A7C66
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA121D3DC;
	Mon, 24 Feb 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J4B+WGPC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726E21CC58;
	Mon, 24 Feb 2025 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386540; cv=none; b=sh+xONG3lHGf94mq+aUsQ/TYKDKMWB8jRKX6LX5jnmOisftsTPYL98qvW7ZrOGGjIn9PlitTgcqE+BRyDKjDSeIYOaKDz6HVa64NYStungJFafyT7PoSBdk7p2/W0im9tfEMS/NJ48mZDAU6i/3dt3z46bKwjD8WJqcBb/Xz/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386540; c=relaxed/simple;
	bh=3Lek6TLf0P2FIe8qAZT50sd7A3uWkKD88BxY0OxQPtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ueh9CZo3vT+x938uBAiVvQlnKMJlZpAbBFac14+H0eFcV2YX0GDJpraeYY55rYNfPm1MnE9wByhGGI065RUgiQvmVU0VHpaIAPFYEBWp4d5k5JxdjisK2+dYDv214zbMoH/lD8VFcH/nc33jiHrSh/TxZyMfvCGaHM4bfY/RF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J4B+WGPC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740386536;
	bh=3Lek6TLf0P2FIe8qAZT50sd7A3uWkKD88BxY0OxQPtQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J4B+WGPCbRy2WGKH0oHfBvaqgEujJsCEwL61B/feAe2lwwgrDCPZ813iFJJ45MZoB
	 93THpR5SfgsaRFqn66krQHxwlqlEf2MW4cyMNHFtRT2zYX5oXYleBalqD9e+/376mr
	 WFuejUTx32hljZlPV97IAZU/qCSKRv0ZGZbCLHdgKAEUW2KoDH5w8t7BQBp/LePYQn
	 fetUXi0yu9bUI0f9EpXjJrJ8Kg0w/FGri5+3Y0Bt7uJLhNv2crPdx0UbSV+lwNA3ie
	 4ZivNG52QEBc8C8/NRLNZjBzbEia8a2JpWfiENCOpS5YKGTWSRXIXkVe3LsDPDbmdd
	 SUBf3G/aeTnwg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9E85317E0215;
	Mon, 24 Feb 2025 09:42:15 +0100 (CET)
Message-ID: <e5627a69-c9e3-4966-89ce-5d8dd72df31a@collabora.com>
Date: Mon, 24 Feb 2025 09:42:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: mediatek: Add SMI LARBs reset
 for MT8188
To: Friday Yang <friday.yang@mediatek.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Garmin Chang <garmin.chang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250221075058.14180-1-friday.yang@mediatek.com>
 <20250221075058.14180-2-friday.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250221075058.14180-2-friday.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/02/25 08:50, Friday Yang ha scritto:
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
> This patch add '#reset-cells' for the clock controller located in image,
> camera and IPE subsystems.
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../bindings/clock/mediatek,mt8188-clock.yaml | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml
> index 860570320545..2985c8c717d7 100644
> --- a/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml
> @@ -57,6 +57,27 @@ required:
>     - reg
>     - '#clock-cells'
> 
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8188-camsys-rawa
> +              - mediatek,mt8188-camsys-rawb
> +              - mediatek,mt8188-camsys-yuva
> +              - mediatek,mt8188-camsys-yuvb
> +              - mediatek,mt8188-imgsys-wpe1
> +              - mediatek,mt8188-imgsys-wpe2
> +              - mediatek,mt8188-imgsys-wpe3
> +              - mediatek,mt8188-imgsys1-dip-nr
> +              - mediatek,mt8188-imgsys1-dip-top
> +              - mediatek,mt8188-ipesys
> +
> +    then:
> +      required:
> +        - '#reset-cells'
> +
>   additionalProperties: false
> 
>   examples:
> --
> 2.46.0
> 


-- 
AngeloGioacchino Del Regno
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

