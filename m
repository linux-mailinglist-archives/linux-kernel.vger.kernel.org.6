Return-Path: <linux-kernel+bounces-309734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A4966FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2341C21746
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F60216D9AE;
	Sat, 31 Aug 2024 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbMTZi2d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47295320B;
	Sat, 31 Aug 2024 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725086841; cv=none; b=VdUa4olUblsF/+pukFfDk33haGKu9dUQpQpxxxYm6AycqwbNj7bNc/BoK/mpKXWkX+OER7chHOQCPqIBzPKzAfOESUC9G6CQkrkc2adU6TA4c4Jg/qgzHLzgjVmd3EaTFDN7C9VSWmbSnNZ0LjRwC+6iBEr63Kv7Dwo+oR4kAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725086841; c=relaxed/simple;
	bh=Et5Cq7kAHvz43U+nAgZLLbiNmcg5TzrrTQ+EIuj+/ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4X8QZ7ybYdTFHFP/ssStHW8rWB4uWsRpOc280uGBp6WctTYjV8EwkKp8q0Tv0OPt5AHCw7N6h958Jn6ScaKx70qjqkXBnZucIQOYBhNZzrCb1MrUmu1H1CozwT/zFPYZ8cYWKJEahIYhE5C5aZzgPreVFd4gibk+x/WeVOBEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbMTZi2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3F6C4CEC0;
	Sat, 31 Aug 2024 06:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725086840;
	bh=Et5Cq7kAHvz43U+nAgZLLbiNmcg5TzrrTQ+EIuj+/ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbMTZi2dZXoc4gUBkH2LIzUu0qMyp6BLn0qXOcYqqX4H37IfqGOeWyMKmTB8m3YId
	 fBjdTnHHtwwMSZwAzKaI1r1qNc9g0s6hBtkZDuKpxMTgXWnm0dXw1Fqm+e/UrrRn5i
	 UIx0ktHwav72cZea1jw9TBktotIkGihtgCDNy1SXFgmqIbdwWGPzGCkm5cS3Ku5D5T
	 Xz3chnqL39/HDKtK5ixCHidzBoZHpHJu3nsPbe0aaIl3xBlmFvl0CHFYc8m+/OX1eX
	 hUDbyvvFq0AtYppc3sMWTq57km64FXzmBQanqDa+SMZOqCk1SkZI+5oI29RCtMBuxA
	 Uja80LencGpbw==
Date: Sat, 31 Aug 2024 08:47:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, marcin.juszkiewicz@linaro.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: realtek,rt5616: Document audio
 graph port
Message-ID: <vpxg63mj43dmqrwxrzfugtsc5xx5wfzvthrjuf5wfjkcdarltl@cnvgi4co6hwj>
References: <20240830203819.1972536-1-heiko@sntech.de>
 <20240830203819.1972536-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830203819.1972536-3-heiko@sntech.de>

On Fri, Aug 30, 2024 at 10:38:18PM +0200, Heiko Stuebner wrote:
> The codec can be used in conjunction with an audio-graph-card to provide
> an endpoint for binding with the other side of the audio link.
> 
> Document the 'port' property that is used for this to prevent
> dtbscheck errors like:
> 
>     rockchip/rk3588-nanopc-t6-lts.dtb: codec@1b: Unevaluated properties are not allowed ('port' was unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/realtek,rt5616.yaml#
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/sound/realtek,rt5616.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


