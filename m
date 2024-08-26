Return-Path: <linux-kernel+bounces-301775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A8495F56F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA6E282347
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29CB192D72;
	Mon, 26 Aug 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htMdAFLs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4CF1741C0;
	Mon, 26 Aug 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687125; cv=none; b=kQ7kgOsvsCojZzCrntRvTccxE20jNIck84PK2l+RtQoR4/XX/fQELW5fTN1cmG4gfWDQ6Mxh+y/cKVDcpVgk+cjnA8rUc2/W28i2278jXfY3zOz5BbC+K0+eJLVHwAwZnBqO5c45dJlXRATdQlNm08Yf9NHgHfjLV+o6IuutQGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687125; c=relaxed/simple;
	bh=CfjXIIFwVytbq3DboLG6ZBWEAA+dSeHjisriqW8r0BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDN0mmpRzXgY0U1GxEJvyBpq2ZbZ0wVaqK6K70iOWIxInba3fTGGiCns2070xK4/S1Y2mvwmK+un18NQ2CsDnvQa+6SV2CSYB5lA7Rlc3kq4ippTKhAm/SewIlk/fUxy8YOQyAgPnoFPTOHHQyGmZkF6RkfMB/hsOiLv1NtjlnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htMdAFLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C43C52FC6;
	Mon, 26 Aug 2024 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687124;
	bh=CfjXIIFwVytbq3DboLG6ZBWEAA+dSeHjisriqW8r0BE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=htMdAFLsy/VWzrv7KZVdB83Fj8TsnzeXUCuS9+1biIW6Kz7P8Dh4rwbfWNSqJJqre
	 Q1MZP6OCv9ymTfXGiisyVBc+61y6NAxzsv6wDxYFf5QOVk3E6F1SdlnZlTgnLyvLUk
	 xGhaNHFVHg41UQPJVCIlCt9x7T8c8vEm6euiuW1Ji+u2wjGKZj5Z1k6YJKd8iilFou
	 5mWQxV/v0ThrpnBGxODG0RJYZn8GV2MSa4PwDuybSumLl0NoB9uxXYUWMGxjeBCins
	 b3mdgVqy03FfugQveIMy1T9NJUxZZFqEhPXLI8ecrU6Pea4SGSpIWZOmz7VUrzxLkd
	 hGAtk1fD1/VbQ==
Message-ID: <39a2971d-8776-4e5f-8d72-ae447ea88362@kernel.org>
Date: Mon, 26 Aug 2024 17:45:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: mediatek,mt6357: Fixup reference to
 pwrap node
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Alexandre Mergnat <amergnat@baylibre.com>, Flora Fu <flora.fu@mediatek.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240826065415.19641-1-macpaul.lin@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240826065415.19641-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/2024 08:54, Macpaul Lin wrote:
> The mt6357 is a subnode of pwrap node. Previously, the documentation
> only included a note in the description of mt6357. This change adds the
> appropriate $ref for pwrap to ensure clarity and correctness.

Heh? The schema described mt6357, not pwrap. Why are you changing it?

> 
>   $ref: /schemas/soc/mediatek/mediatek,pwrap.yaml
> 
> Additionally, the indentation for the pmic section has been adjusted
> to match the corresponding structure.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,mt6357.yaml         | 124 +++++++++---------
>  1 file changed, 65 insertions(+), 59 deletions(-)
> 
> Changes for v1:
>  - This patch has been made based on linux-next/master branch.
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
> index b67fbe0..5f4f540 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6357.yaml
> @@ -22,69 +22,75 @@ description: |
>  
>    It is interfaced to host controller using SPI interface by a proprietary hardware
>    called PMIC wrapper or pwrap. This MFD is a child device of pwrap.
> -  See the following for pwrap node definitions:
> -  Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
>  
>  properties:
> -  compatible:
> -    const: mediatek,mt6357

How does this schema is being selected without compatible?

> -
> -  interrupts:
> -    maxItems: 1
> -
> -  interrupt-controller: true
> -
> -  "#interrupt-cells":
> -    const: 2
> -
> -  mediatek,hp-pull-down:
> -    description:
> -      Earphone driver positive output stage short to
> -      the audio reference ground.
> -    type: boolean
> -
> -  mediatek,micbias0-microvolt:
> -    description: Selects MIC Bias 0 output voltage.
> -    enum: [1700000, 1800000, 1900000, 2000000,
> -           2100000, 2500000, 2600000, 2700000]
> -    default: 1700000
> -
> -  mediatek,micbias1-microvolt:
> -    description: Selects MIC Bias 1 output voltage.
> -    enum: [1700000, 1800000, 1900000, 2000000,
> -           2100000, 2500000, 2600000, 2700000]
> -    default: 1700000
> -
> -  regulators:
> -    type: object
> -    $ref: /schemas/regulator/mediatek,mt6357-regulator.yaml
> -    unevaluatedProperties: false
> -    description:
> -      List of MT6357 BUCKs and LDOs regulators.
> -
> -  rtc:
> +  pwrap:

With the diff it is tricky to say what you are doing, but it feels
wrong. I don't understand the rationale, the problem being fixed here,
and considering unusual diff, this just looks wrong approach.

Bindings do not work like that - you do not reference the parent inside
the child. There is nowhere example for that, so I have no clue how did
you come up with it.

Best regards,
Krzysztof


