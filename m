Return-Path: <linux-kernel+bounces-330957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E7D97A67C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28DB28A24F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D346E15958A;
	Mon, 16 Sep 2024 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpq59S3g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349AB1581E0;
	Mon, 16 Sep 2024 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506669; cv=none; b=cb9oMC/6MWGCeoS9IHu4YdxHKoddS3qBkSYxybfYzlMcVtTMRpaxhoJBAR3xCvT3yVVquGAcp1zZIQFJIM49KLKK4T8sAzy/YseyUnqcHFw9/wfWZQLYFJagOhKAVAk8xkfiTtLEDN8AcKbNXc7+Y+LapvBXdzRg3AA4LD+fwME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506669; c=relaxed/simple;
	bh=At1Pr7PthC5cR3eEm4LyYtKE8cs9rEAJIqeU0f1G/fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbV7Toja+gpWBjn4DjXYRv1zhF5kzGUKiptyHarATVe9kFaWOhqJ+yi32SO+9BHlSeGZHXoOjfc9qT+eHVf4bIsuvMJ2TfSYr2tdF3VnCIs9vFNBsUecZamB39GxK5u8ecaxaxsBH6flQZH7QTZfmtPhI0y54EQqME4GYevprSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpq59S3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECC5C4CEC4;
	Mon, 16 Sep 2024 17:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726506669;
	bh=At1Pr7PthC5cR3eEm4LyYtKE8cs9rEAJIqeU0f1G/fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpq59S3gZdEPOMG+cSrM2MZyeEgLgRN00IshBx+pgdBrAHOEdij6WUJlapjW7nfRy
	 S8j3B+V4QSvhZjy4haX6D1fs+l5Q6ZEOQS/o/8/YqDIT0uTUMX4WVzqbH365RyZmhL
	 RIeWbNwmnhXeaQFUzKc0DQs/E5DNljCxJlFgw35aSLuEpV+JvXwZoZF0ElB+3ODHOG
	 L43MbAlf4pLUsccqgxId18XQdg7yawyEEZM4jwhqPjQAZLSAGD3n6DZOIK/IALKzjz
	 2BuPwLHzeyZja8n/AB50Vt93p4imZxtA/kKdoMEjl2iWDVBQ4lR74fvmEnM7PpbtKA
	 T0ag2z9rV9Ujg==
Date: Mon, 16 Sep 2024 12:11:07 -0500
From: Rob Herring <robh@kernel.org>
To: Rohit Agarwal <rohiagar@chromium.org>
Cc: chunkuang.hu@kernel.org, krzk+dt@kernel.org, ck.hu@mediatek.com,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dt-bindings: display: mediatek: dpi: Add power domain
 for MT8195 DP_INTF
Message-ID: <20240916171107.GA605353-robh@kernel.org>
References: <20240911071722.558960-1-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911071722.558960-1-rohiagar@chromium.org>

On Wed, Sep 11, 2024 at 07:17:21AM +0000, Rohit Agarwal wrote:
> Add power domain binding for MT8195 DP_INTF that resolves the following
> error and many more similar ones:
> 
> arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: dp-intf@1c113000:
> power-domains: False schema does not allow [[55, 18]]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409102119.AYvaTjUi-lkp@intel.com/

Fixes?

> Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> index 3a82aec9021c..07acc8a76bfc 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -89,6 +89,7 @@ allOf:
>                  - mediatek,mt6795-dpi
>                  - mediatek,mt8173-dpi
>                  - mediatek,mt8186-dpi
> +                - mediatek,mt8195-dp-intf

mt8183 is also missing. There's a patch[1] to fix it, but it's wrong 
given the recent changes. It would be best to fix both in one 
patch/series as 2 separate patches will have conflicts.

Rob


[1] https://lore.kernel.org/all/20240912144430.3161717-2-treapking@chromium.org/

