Return-Path: <linux-kernel+bounces-218891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B58590C771
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D52B254DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA9C153830;
	Tue, 18 Jun 2024 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gd6eVSbi"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8744D15279F;
	Tue, 18 Jun 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700786; cv=none; b=WYus77uRyQz8ynnUh6Gnm2QhqYEilRzhOf5aGm5CzfdhaXk69fWovyFMbj+sZ5MqDMeuNiB4G7QpJqWmRxOzMY8An7vUx7rlhwEWyBIkfkOkfjWAo3d3XhYXc7sZQXiHBoMCd9oWMIRWE94LhF9eYbKzwHCiOp8kn+2OtcRPZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700786; c=relaxed/simple;
	bh=ugWg3zjfh3e2dxp2M0AGCRPN/dZumEW4hY3gkBEjGSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rc74kyGt+lTB/gNCMFZQEdWo96x6aSfOJ+RzO5VLQzjlL+GHoqRTxQ57a5S50IAVVOcez/anFnfA5QWRjJVM9wLS5GyY3qHzYMMzE8W9mjF2f02UMYNHHwcmsMw59DtfD7t/IwxKGLiXvZeFVPmUHfE+wgT++THfbfw5hl3tRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gd6eVSbi; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718700780; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8h36Uq++xhD7IT+I08ZGGTxTdCNv1ie5zH+mwZ5tfzU=;
	b=gd6eVSbifkmFKp1xnnZQ3I8AJmIyyZK0S4CldnxVhM285OROnsp6hco341IbV105Bj/o8kMXBH45ubI9h2QvGx0SwEoTh73g/qMldqd+Tm+ITLJWibAiOG0XHpthK5vMBaALJCu/HmvNwKo+CMHShRJv+NG2hp+0X6tjirt8PUY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0W8jcBVV_1718700777;
Received: from 30.97.56.62(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8jcBVV_1718700777)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 16:52:58 +0800
Message-ID: <fead8c04-4a10-451d-aa1b-b96ff3736e7e@linux.alibaba.com>
Date: Tue, 18 Jun 2024 16:52:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: soc: sprd: sc9863a-glbregs: Document
 SC9863A syscon
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>,
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars Povlsen
 <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org>
 <20240616-dt-bindings-mfd-syscon-split-v2-2-571b5850174a@linaro.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240616-dt-bindings-mfd-syscon-split-v2-2-571b5850174a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/16 21:19, Krzysztof Kozlowski wrote:
> Document sprd,sc9863a-glbregs compatible already used in DTS and other
> bindings example.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   .../bindings/soc/sprd/sprd,sc9863a-glbregs.yaml    | 55 ++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/sprd/sprd,sc9863a-glbregs.yaml b/Documentation/devicetree/bindings/soc/sprd/sprd,sc9863a-glbregs.yaml
> new file mode 100644
> index 000000000000..49add564e5e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/sprd/sprd,sc9863a-glbregs.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/sprd/sprd,sc9863a-glbregs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SC9863A Syscon
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sprd,sc9863a-glbregs
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +patternProperties:
> +  "@[0-9a-f]+$":
> +    $ref: /schemas/clock/sprd,sc9863a-clk.yaml
> +    description: Clock controllers
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@20e00000 {
> +      compatible = "sprd,sc9863a-glbregs", "syscon", "simple-mfd";
> +      reg = <0x20e00000 0x4000>;
> +      ranges = <0 0x20e00000 0x4000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      apahb_gate: apahb-gate@0 {
> +        compatible = "sprd,sc9863a-apahb-gate";
> +        reg = <0x0 0x1020>;
> +        #clock-cells = <1>;
> +      };
> +    };
> +
> +...
> 

