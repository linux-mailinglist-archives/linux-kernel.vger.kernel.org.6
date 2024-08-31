Return-Path: <linux-kernel+bounces-309733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF558966FDA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EA91C21B88
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E916D4FF;
	Sat, 31 Aug 2024 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwdKosgV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9C1339A4;
	Sat, 31 Aug 2024 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725086771; cv=none; b=YdJQKUrl+VKbyO2lDZPbnND6Crh2drbAEGX1wUfwAQQ30NdmxecLf2YeHs0cmVHODTUCWqvR5VKGdC3TRVP3asbY9RZTaOyWge/pHD39WW4OdgInJx2MJ51P98S6ME0OFD8s2eZkhcJJhIS9EAWIFTVzgH6XFCh4DBZL8kTdie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725086771; c=relaxed/simple;
	bh=l2jou5gDuVOK2MJ6YWN4pUYK/5rodsX1qUxEIqwkgiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8UqRL7jpsYY9NugYqQ1am80AkV4yQdMFaB71OYBJ8E3gllZNM1uyRkRyJBz6cmWfWacRgnn2EeNXy9BGIuw70n6xSLfjOG5hdDeNDGbDp02FdXadZvkSSdTn8f5KV8n8wE7Tr/6HwCWRLk8wIkoRheMZaohmRccXKXDARmThXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwdKosgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F53C4CEC0;
	Sat, 31 Aug 2024 06:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725086770;
	bh=l2jou5gDuVOK2MJ6YWN4pUYK/5rodsX1qUxEIqwkgiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwdKosgVc5yv7KtGwauq12ALxXr3Mk2ZWhPvJ98iuwLnf4SESz8OLZx5A6LyerWMV
	 LlTL0vtjbZLHtvvSgbYjXfUEStZDsrid2Uf4cuawv6pi51NFb3iA5ZMohJSRhseAmu
	 2eyUofNjs/2i4aOgHmwx1Fv8UOkRsf9tVQsFNtF27BFEJpbbQx/kKQaqEjwrubsp8h
	 NjCGGZGC2xP5PtX1pEkcZwzVumvkaqX9LfHS+4Z+UTaZDHnBS0m9lrN6EHiTRSdrxj
	 l6tNy9vTr1r5lL7X/TTjormqGiqzjG6wifGrfv0hC4+YNp4SR8BeOnEgDKzANV5YN4
	 C+ORcN3ZkiuCQ==
Date: Sat, 31 Aug 2024 08:46:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, marcin.juszkiewicz@linaro.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: realtek,rt5616: document mclk
 clock
Message-ID: <dpzc22opbwxxygc23jrgouxoowzganqq6f3iyq5nexuggcfd6u@rozvo3eyvwwq>
References: <20240830203819.1972536-1-heiko@sntech.de>
 <20240830203819.1972536-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830203819.1972536-2-heiko@sntech.de>

On Fri, Aug 30, 2024 at 10:38:17PM +0200, Heiko Stuebner wrote:
> Both devicetrees and driver implementation already use the specified mclk
> in the field, so at least document the clock too, similarly to other
> Realtek codec.
> 
> This has the nice additional effect of getting rid of dtbscheck warning.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../devicetree/bindings/sound/realtek,rt5616.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


