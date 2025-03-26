Return-Path: <linux-kernel+bounces-576797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516B0A714A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBAF171517
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CB11B3925;
	Wed, 26 Mar 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R2w7KzYZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72108C1F;
	Wed, 26 Mar 2025 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984332; cv=none; b=os3KRe78ZpxAX3V/KcoYF3F8SR+7r5X5TCFTV7PYZRzSTf+stiWfPR3FtzWBhRTvvbflAKYXSbJJ/obvl4XSmmAEMG1GSReg4B2Kda7VZNGanmIlhjPIH6ZATuNC9wcNOwv1Yo+stO+oHxrK27Xk6Y86pJRmWI7LzQ+0DhXRCac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984332; c=relaxed/simple;
	bh=q/nFNojlosborYJGt0qwUe6tullznsb4Pf2IVsxtddI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuYHFb/dGH2dn4aiH9pczPlqHGxDEH/x/zuLT9k1A6Ckelh/FOgfQqStJWkVkBPxCgspTMKs093KDzyBi+QKJoXjbbnYwwBvsjOPc5Q3sVTmdW9fjxXh385CQiosh23T7mR6JLx/DALStOj+xGg+3/3MfLaqoHCA8JlFxfbF22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R2w7KzYZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742984329;
	bh=q/nFNojlosborYJGt0qwUe6tullznsb4Pf2IVsxtddI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R2w7KzYZhiCblvBuuvmzKgygHYi2uZCJ+vZIKkxh9za6J8dIz2FAZoiRvvM6OBmdI
	 38FwuPBbPOrgaeJnsVXy81JlZ2l+ypPoTzCouhW+gZ4Ffm+7w2uPubNLS3utlWhZnj
	 mIFuelbr0pR3PcR2LLEX7K+J0oNehKGrLvFaf+J0OeFWNp9zDy/aL6ObaWWZ1rovEK
	 CoToye6Vmdx2cy4GJ8Sn2v+imUq8oJkI4rtiNF7r3qa5L0V6sDns8Xb6VFfM6uQbKw
	 enm6x+qSmGOFhxNqz47IKsgb8Z6Di62ZiIfNKkPyV5gYE2Qrdp4ksrZFMuk18OagZh
	 4L7kHRlPWWP+g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 88E8017E0E8F;
	Wed, 26 Mar 2025 11:18:48 +0100 (CET)
Message-ID: <fb154077-e650-480e-a4d7-0a141b563dfc@collabora.com>
Date: Wed, 26 Mar 2025 11:18:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3,1/2] dt-bindings: memory-controllers: Add MediaTek DRAM
 controller interface
To: Crystal Guo <crystal.guo@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250326063041.7126-1-crystal.guo@mediatek.com>
 <20250326063041.7126-2-crystal.guo@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250326063041.7126-2-crystal.guo@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/03/25 07:30, Crystal Guo ha scritto:
> A MediaTek DRAM controller interface to provide the current DDR
> data rate.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>   .../memory-controllers/mediatek,dramc.yaml    | 44 +++++++++++++++++++
>   1 file changed, 44 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml
> new file mode 100644
> index 000000000000..8bdacfc36cb5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml

The filename should be "mediatek,mt8196-dramc.yaml"


> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2025 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/mediatek,dramc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek DRAM Controller (DRAMC)
> +
> +maintainers:
> +  - Crystal Guo <crystal.guo@mediatek.com>
> +
> +description:
> +  A MediaTek DRAM controller interface to provide the current data rate of DRAM.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8196-dramc

P.S.: bindings maintainers: this driver is expected to get more compatibles soon.

Cheers,
Angelo


> +
> +  reg:
> +    items:
> +      - description: anaphy registers
> +      - description: ddrphy registers
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        memory-controller@10236000 {
> +            compatible = "mediatek,mt8196-dramc";
> +            reg = <0 0x10236000 0 0x2000>,
> +                  <0 0x10238000 0 0x2000>;
> +        };
> +    };



