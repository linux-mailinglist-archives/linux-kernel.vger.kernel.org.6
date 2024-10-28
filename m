Return-Path: <linux-kernel+bounces-385234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979C39B3464
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4058B1F226AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B450A1DE2C6;
	Mon, 28 Oct 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONd+qB50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1151DD864
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127951; cv=none; b=O77TMLG5xEHZArKV0xf4dCoYyo24HDuSf6do78/Vbe2gJ0lqRfAqQWp4SuqqLL48nuZM7F5Gz3xKHpBKpTC2eMJILACRhBJYklLSNDqu6DkNmzDRowdsiBwdTfI8RZIA6k6l7y+AZqGDmppRNJ6aXfcnGHyf5GBVZtYWxIeMMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127951; c=relaxed/simple;
	bh=w2P/8ycnCHlajaF4QMUagcR3Ej160nBhPte8pHBd84Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsuKuhd1K2dGDqP8ycKWpCm8foYRzgY+RkDaA5Z4X/0wWRSdkcszNCs40OB8KCYtd/S+uFYD3qXPTjA9I/f3M2rQXhX6SzXKPHC47q3Xsdqf5ReiqnMSlvOyuB7knF+waGn1B51FVCm73ULZl7cNHOPTRCyxXTe/Os1Dil84MgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONd+qB50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91570C4CEC3;
	Mon, 28 Oct 2024 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730127950;
	bh=w2P/8ycnCHlajaF4QMUagcR3Ej160nBhPte8pHBd84Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ONd+qB50vr1ew8g7rsXxyOjMM73ZIr2c1hX9o/Q+V4txnGtYdUnAeBE68uQUhojXy
	 pFUDehwU9m3iVAKEVdzcjPZq0VHMnL8HRQvmCSQjNesEE+zcpMVi7R5MmOdtBPNZTW
	 XWK/NxV3zaE69oyVa6q1mIjXDhrBuXxE22uSYDWeFUz722z9n1PQrUAyzNrliSuDd9
	 8GSO+s1e0dF1eqziJosvJiWsqUImCVZpDREoW2Ro5KZ3whi+YTWWlmNu/0YHkho42e
	 wJoQy0GLo1EQML2KKytz8YwjBEWUaVclSQS5sS04gF7AILCqyt0bHnDGvP04piW/+p
	 7glfqqAgUwhxg==
Date: Mon, 28 Oct 2024 15:05:45 +0000
From: Will Deacon <will@kernel.org>
To: huanglei814 <huanglei814@163.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, huanglei <huanglei@kylinos.cn>
Subject: Re: [PATCH] arm64/Kconfig: introduce GENERIC_ISA_DMA
Message-ID: <20241028150544.GA2445@willie-the-truck>
References: <20241025011641.4858-1-huanglei814@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025011641.4858-1-huanglei814@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Oct 25, 2024 at 09:16:41AM +0800, huanglei814 wrote:
> From: huanglei <huanglei@kylinos.cn>
> 
> Enable GENERIC_ISA_DMA feature on arm64 platform,
> thus, request_dma and free_dma interface can be export.
> and driver modules can use the this interfaces on arm64
> platform.
> 
> Currently, many pcie parallel port drivers still use these
> interfaces when ported to arm64 platform.

Why has it taken so long for anybody to notice?

> Signed-off-by: huanglei <huanglei@kylinos.cn>
> ---
>  arch/arm64/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fd9df6dcc593..986eb251f68f 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -367,6 +367,9 @@ config GENERIC_CSUM
>  config GENERIC_CALIBRATE_DELAY
>  	def_bool y
>  
> +config GENERIC_ISA_DMA
> +	def_bool y
> +

Does this actually do anything without MAX_DMA_CHANNELS defined?

Will

