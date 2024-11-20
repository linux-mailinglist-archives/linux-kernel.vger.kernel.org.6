Return-Path: <linux-kernel+bounces-415705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E019D3A06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162BC28061E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA49E1A706F;
	Wed, 20 Nov 2024 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EHLA8DMg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEAD19F41D;
	Wed, 20 Nov 2024 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103751; cv=none; b=emz72XEUd/wCQNNZSaufwKf7KTmcpvXmqVQ1HYS9ZeAP43NbTK9VRVaAosyznEulstq+gjlXxA0Lrd1npMnXKYOiB37885DnlqFYik4TVa8Plu/Ajy6b3Klc2FBz2UR6mlSusW4cEW89tX089BOVJMJa3lFuoR5UQflzNL3MGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103751; c=relaxed/simple;
	bh=LKKBBEfzE2cUMCjgNuOL1nYgkM/Aqi5ZPzy8Ibang1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2YpJjBuFFpH0uN5wkM3m6MyvD01JjWYxJbWGS2GilU/MPLPp50PdaAkoDPul0K+V12oqQeVrHcAMdf9lNGYPgNl43qXcVOj4/C+h7XqTRNUg7xfmhxZwlhN/EauRC9EkT6H3YmPJ4Sm0iaTMm2Z7l+G+DTNPyUyd6fHjN6L844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EHLA8DMg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732103747;
	bh=LKKBBEfzE2cUMCjgNuOL1nYgkM/Aqi5ZPzy8Ibang1w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EHLA8DMg8yHXcCZHC1W/0qb5Gd5PgwuGQP4kztP6cAfyrDec5pQMq+e2rzxDFWWYK
	 BRy+2eZD0AHqu85dHUvMXdJD9IYjU8E+oFwH6QVZK3ubl5b7xWEW6oAOTJ0WYErzMT
	 USm50NxflDXbHnaQDvl7HVtt/0ncOBoJ66dTs0NJdXFaTzyPaiyvcZPn0jN5fD8IOm
	 5n2tS4TAXd4lHOz6UehGpFmtJoNjc4YORuFaSqxPAGez5dtIAnJeW/X5Gc/+6IwQYH
	 OL5568NmacG/oAEmZYgRn+U0Fn8V59UDqwkUhRTdJ2kh/+Vd/zRu5x8Iyh38gcYnbq
	 8Z7BG3v3lJjhQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DFE3D17E3632;
	Wed, 20 Nov 2024 12:55:46 +0100 (CET)
Message-ID: <e1aa2b69-5c40-44a5-b0b5-2a262bcc72f3@collabora.com>
Date: Wed, 20 Nov 2024 12:55:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: mediatek: Add mt8188 SMI reset
 control binding
To: Friday Yang <friday.yang@mediatek.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20241120063305.8135-1-friday.yang@mediatek.com>
 <20241120063305.8135-2-friday.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241120063305.8135-2-friday.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/11/24 07:32, Friday Yang ha scritto:
> From: "Friday Yang" <friday.yang@mediatek.com>
> 
> To support SMI clamp and reset operation in genpd callback, add
> SMI LARB reset controller in the bindings. Add index in
> mt8188-resets.h to query the reset signal in the SMI reset
> control driver.
> 
> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
> ---
>   .../bindings/reset/mediatek,smi-reset.yaml    | 53 +++++++++++++++++++
>   include/dt-bindings/reset/mt8188-resets.h     | 11 ++++
>   2 files changed, 64 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml b/Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml
> new file mode 100644
> index 000000000000..77a6197a9846
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/mediatek,smi-reset.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2024 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/mediatek,smi-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek SMI Reset Controller
> +
> +maintainers:
> +  - Friday Yang <friday.yang@mediatek.com>
> +
> +description: |
> +  This reset controller node is used to perform reset management
> +  of SMI larbs on MediaTek platform. It is used to implement various
> +  reset functions required when SMI larbs apply clamp operation.
> +
> +  For list of all valid reset indices see
> +    <dt-bindings/reset/mt8188-resets.h> for MT8188.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8188-smi-reset
> +
> +  "#reset-cells":
> +    const: 1
> +    description:
> +      The cell should be the device ID. SMI reset controller driver could
> +      query the reset signal of each SMI larb by device ID.
> +
> +  mediatek,larb-rst:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle of each subsys clock controller. SMI larbs are located in
> +      these subsys. SMI needs to parse the node of each subsys clock
> +      controller to get the register address, and then apply the reset
> +      operation.
> +
> +required:
> +  - compatible
> +  - "#reset-cells"
> +  - mediatek,larb-rst
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    reset-controller {
> +        compatible = "mediatek,mt8188-smi-reset";
> +        #reset-cells = <1>;
> +        mediatek,larb-rst = <&imgsys1_dip_top>;

I don't understand why would you be unable to add the SMI resets to the already
currently supported reset code in the clock-controller driver itself, like done
with literally all of the other clock controllers.

Please clarify.

Regards,
Angelo


