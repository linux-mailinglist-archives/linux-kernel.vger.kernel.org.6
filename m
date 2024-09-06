Return-Path: <linux-kernel+bounces-319515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B314896FDC5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3271F22064
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A882715A876;
	Fri,  6 Sep 2024 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abcd050/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3461586C8;
	Fri,  6 Sep 2024 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725660163; cv=none; b=T3/UgRLCP/i4LGTF+UxRDjGi6YYs5HJPUERqkQcS2s2vI8b6NmOngC6VOI/kmbHGbn5k8xMN9DFOPK9gu0sqF+zOO2jGOwKL/jMW+QknhZ4N98oeTDQfuQ89VGj3Wfr38cZzZvKHwW8RXPMbAI3dDsahcrwd7r0tKpiPs2HKz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725660163; c=relaxed/simple;
	bh=YTl5QZ9y0Zvq40MaW8h6EWZ0cXmGsDV90veaoywOHV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQvOTBILaUZIC+dFTMZdJEChiziFYIxVAMQJ0oG7GPVdGrffqiov9zHBl+8ghd9qY8HyA79oQVNF4kGtyR4k6j6k8vIAg8lgAc65oDLes64Ybr+bRRqFzFER216zS4srsFBZBmDej66ExQAtXXBdr9nCkUYyCNMwUvK7DRg46fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abcd050/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC81C4CEC4;
	Fri,  6 Sep 2024 22:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725660162;
	bh=YTl5QZ9y0Zvq40MaW8h6EWZ0cXmGsDV90veaoywOHV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abcd050/Os6wbiyVH7ZcZ+p8mdL+ZRq4TUnjHGxVY2ALdGUSucNQz5cZiPVzKIANm
	 i2L2xEPfHbvPEWKejN6RWEuaAruzuxp6ghLx7K9k6pIaB9xwtSPMzZaqL1VH6Cdmd1
	 /BZJiTa0XYk2/jXjZVNI6xI1Y8HhPvBOHoPE/k9CcfOhvCIzWguLerhDADcXqAxE/u
	 z4622LEQAxhbc/ncjbt7hdTRRXCVHu/HFlshQMeJDn8j3O0+gCt0oSTCPoDvSx1Obp
	 e8SLg3+KX9/xjbXaSoN9lXw6ImrkScjbpyX+WCqk2nq8RJ76sZ4kTW2IVHOk8o8iYS
	 ItX5smY1IzX+g==
Date: Fri, 6 Sep 2024 17:02:41 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5] dt-bindings: Fix various typos
Message-ID: <172566015521.2278562.15089620078479163976.robh@kernel.org>
References: <20240905151943.2792056-1-eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905151943.2792056-1-eleanor15x@gmail.com>


On Thu, 05 Sep 2024 23:19:43 +0800, Yu-Chun Lin wrote:
> Corrected several typos in Documentation/devicetree/bindings files.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> ---
> v4->v5
> Fixed one typo in commit messages.
> 
> v3->v4
> I squashed all previous version commits.
> 
> v2->v3
> Corrected "interlaved" to "interleaved"
> 
> v1->v2
> Fixed more typos in dt-bindings files
> 
> I've dropped reviewed tags in v1 due to significant
> changes in v2. So it would be helpful if Laurent Pinchart
> and Kuan-Wei Chiu could review with the version.
> 
> v4
> Link: https://lore.kernel.org/lkml/20240904160118.2773055-1-eleanor15x@gmail.com/
> 
> v3
> Link: https://lore.kernel.org/lkml/20240904125812.2761993-1-eleanor15x@gmail.com/
> 
> v2
> Link: https://lore.kernel.org/lkml/20240903164242.2188895-1-eleanor15x@gmail.com/
> 
> v1
> Link: https://lore.kernel.org/lkml/20240901133046.962263-1-eleanor15x@gmail.com/
> 
>  .../devicetree/bindings/arm/arm,coresight-dummy-source.yaml   | 2 +-
>  Documentation/devicetree/bindings/cpu/idle-states.yaml        | 2 +-
>  Documentation/devicetree/bindings/display/lvds.yaml           | 2 +-
>  Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt     | 2 +-
>  Documentation/devicetree/bindings/iio/accel/lis302.txt        | 2 +-
>  .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml  | 2 +-
>  Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml    | 2 +-
>  .../devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt    | 2 +-
>  .../devicetree/bindings/media/i2c/thine,thp7312.yaml          | 2 +-
>  .../devicetree/bindings/media/samsung,exynos4210-fimc.yaml    | 2 +-
>  Documentation/devicetree/bindings/mfd/rohm,bd96801-pmic.yaml  | 2 +-
>  Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml    | 2 +-
>  Documentation/devicetree/bindings/mfd/twl6040.txt             | 2 +-
>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml | 2 +-
>  Documentation/devicetree/bindings/phy/apm-xgene-phy.txt       | 2 +-
>  .../devicetree/bindings/phy/mediatek,mt7988-xfi-tphy.yaml     | 2 +-
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml      | 2 +-
>  .../devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml     | 2 +-
>  .../devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml         | 4 ++--
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml     | 2 +-
>  .../devicetree/bindings/serial/nvidia,tegra20-hsuart.yaml     | 2 +-
>  Documentation/devicetree/bindings/sound/everest,es8326.yaml   | 2 +-
>  Documentation/devicetree/bindings/sound/st,sta350.txt         | 2 +-
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml     | 2 +-
>  24 files changed, 25 insertions(+), 25 deletions(-)
> 

Applied, thanks!


