Return-Path: <linux-kernel+bounces-423575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B759DA9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47C616685D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0B71FF612;
	Wed, 27 Nov 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRLk2Hg5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C758B1FF600;
	Wed, 27 Nov 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717601; cv=none; b=aITQoaPPHAVDB8RJN+9SDRinxzK18ldegg4R+0LYKP3vrS/A4lCtRWlHAPMHcTR2Z5oDHo2B0FmyEYDQ34GAipz61dwQgt5gh3Cl9QyNrOC46deK2fZSxGOD04hYe4mI3/2G7zipW7qo78xdKUBLY15HyoG96sN7MAQFNt5AMdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717601; c=relaxed/simple;
	bh=kqNvddmDWtm7j0n7cbl9AqMJ+Ww39KyF2qb8khHv7zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7BXptidCHzyZ/EPZU+uDDebVG9NlKF3bm8RHihqWikD1EE4ZprjRKr3VxlUWT6K8RZTRzcb5mwiw1UfDlBIKt/lWirM/zZRCd51I2P/M0o0eJbUKk5fGHezjNJ96UQEQaUzk2PSjSG2QFNj17Rl5fp+ndet1AV8vDGlNpuOdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRLk2Hg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364EFC4CECC;
	Wed, 27 Nov 2024 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732717601;
	bh=kqNvddmDWtm7j0n7cbl9AqMJ+Ww39KyF2qb8khHv7zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRLk2Hg5BpC0e6D0gRHZqBuTAPOfn5yC7hHhwuYPB0lNR1lkzn8BPdkRXQND30GiD
	 kA+REhHwzGNrRa7v6pgsRV7dxWg1QEmPT9Lj6HT+FKmcEh8/pqn4Le5Ac9EjITV+4E
	 8XyIMonYyRKGN14kythItJj9u66rhGmFmk49A5cEd1EosxgZ57DFaIj8gnAn/6kmY2
	 dWXcG6zLfbtnzOae30JpagghRoLjg5408etK/cP3/pKPBXR7tptbhgsybi8sjS37dl
	 A/IP8OjkpLkuL42MfLMib0ANQxoqkaXpKO3LJLvalJ84GkKfj4ftkURwyezrbi31T6
	 VoU36du1t828Q==
Date: Wed, 27 Nov 2024 08:26:39 -0600
From: Rob Herring <robh@kernel.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: mediatek,xsphy: add property to
 set disconnect threshold
Message-ID: <20241127142639.GA3451514-robh@kernel.org>
References: <20241126025859.29923-1-chunfeng.yun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126025859.29923-1-chunfeng.yun@mediatek.com>

On Tue, Nov 26, 2024 at 10:58:58AM +0800, Chunfeng Yun wrote:
> Add a property to tune usb2 phy's disconnect threshold.
> And add a compatible for mt8196.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> index a9e3139fd421..2e012d5e1da1 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
> @@ -49,6 +49,7 @@ properties:
>        - enum:
>            - mediatek,mt3611-xsphy
>            - mediatek,mt3612-xsphy
> +          - mediatek,mt8196-xsphy
>        - const: mediatek,xsphy
>  
>    reg:
> @@ -129,6 +130,13 @@ patternProperties:
>          minimum: 1
>          maximum: 7
>  
> +      mediatek,discth:

That's not understandable. Spell it out: mediatek,disconnect-thres

> +        description:
> +          The selection of disconnect threshold (U2 phy)
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 1
> +        maximum: 15
> +
>        mediatek,efuse-intr:
>          description:
>            The selection of Internal Resistor (U2/U3 phy)
> -- 
> 2.46.0
> 

