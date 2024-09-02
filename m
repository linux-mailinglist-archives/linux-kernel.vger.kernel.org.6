Return-Path: <linux-kernel+bounces-310732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDB968081
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB541F267FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C531714D3;
	Mon,  2 Sep 2024 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7XvFTtR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06FF14E2D8;
	Mon,  2 Sep 2024 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261863; cv=none; b=J8wl32DRk7EBSEhy+qnxQgsB/Xj6DY51cxgYMzlWNtRT4dTUAqmfpw+HqBllHc7CrtKnMNQxb7bmKtb7I10axbDY7/xihRVEj6b+Ajjlb4qJXxEeCn1cb5v93qNod5UtpS5YgoTEmQ5uxyFM9YOgJL3ZWT84oAk5B/cqel+td+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261863; c=relaxed/simple;
	bh=sHbjmc9Gu1U3gs/GS9a+Qsw2XS7d86eiEQazzHkcxII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6bqRaZ6LVS4IrZECkmIbswkmlA5F91qwRGQjdc30ugp8PmTA9Xsqaus+x6JWgkNBGkOHzcP/l13lHTYne0MkszRs+2LOSBgJoKl46KE0706NUcLC18SSCHZncrheJXv3FWxQYN/r+RZbIclPnyw4tCh6Fahwex4WML41qa/J10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7XvFTtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81CEC4CEC2;
	Mon,  2 Sep 2024 07:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261862;
	bh=sHbjmc9Gu1U3gs/GS9a+Qsw2XS7d86eiEQazzHkcxII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7XvFTtRPJuzV3fawSjm6Y+ab/HbzFAPtwFFRCY3Kgd8i+yzQrVaidTLEdPCDT1du
	 T8rvR6o/icCmD7x1cG6PrI/LIZzEAnN+WSgWA6uQqyy02v5hWHs58Yac1/V1knOqe3
	 lOICa/oa5oM4LstpdWUCE0QAuZq3Pp4myRSaz9q4ygbfuIb1KY/80XLXfoJchkIcCD
	 PonbicRth6Pnk1+sjbAc6jXdfJVAojnEaA/BY+JsvH6ZdSeCQm3lHkgjz21vWpeGQc
	 GRcQinTFKMS6IkyZMIsQtbfnYujKccCM79nQJr4+dNbD4m24CthONTGOM/G2ah8/9H
	 cp/oHrP1G6mlQ==
Date: Mon, 2 Sep 2024 09:24:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aryabhatta Dey <aryabhattadey35@gmail.com>
Cc: andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] dt-bindings: arm: marvell: convert armada-375.txt to
 yaml
Message-ID: <j6sunewrzzeu7yuo7c7vcvjvlku737tgwtemyo3tfjdfsaowtu@cf6dbrp5prpi>
References: <pncbkuiub6sr3gn2okzdfxiknwypi3gcdw3av3eynniacvrcew@nwfye2jkvgmv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pncbkuiub6sr3gn2okzdfxiknwypi3gcdw3av3eynniacvrcew@nwfye2jkvgmv>

On Mon, Sep 02, 2024 at 07:53:43AM +0530, Aryabhatta Dey wrote:
> Convert dt-binding armada-375 from txt to yaml format.
> 
> Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>

> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-375.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-375.yaml
> new file mode 100644
> index 000000000000..d56d3d6d40d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-375.yaml
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/marvell/armada-375.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Armada 375 Platforms
> +
> +maintainers:
> +  - Aryabhatta Dey <aryabhattadey35@gmail.com>

No, I don't think you maintain the platforms. Do you have the hardware?
Which one?

> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +
> +      - description:
> +          Marvell Armada 375
> +        items:
> +          - const: marvell,armada375

That's not a correct list. SoC cannot be used alone.

Armada needs proper fixes, not just doing conversion to satisfy
conversion.

Best regards,
Krzysztof


