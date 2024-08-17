Return-Path: <linux-kernel+bounces-290822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA0D955929
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 19:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB14A28209E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A834D1553AF;
	Sat, 17 Aug 2024 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmCD45sR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF31CA6B;
	Sat, 17 Aug 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723915274; cv=none; b=DsHQyddYF2la6NducRwDTGOcLpVAFkWy6Ki6+ijS7yeBWcYtILaqE+/gYWhEqPsSD+7Ot90GyLV3e/ich9btTxVQUzf6zmrwxlf4q919QfhokRdrwRW3WLIgF3nKCvOn0aPZY8JIgKZ57EWGNOgFfOBlN8FG8A7GObJVljechg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723915274; c=relaxed/simple;
	bh=GOljD1N1kdvmwm21M1D56fcwJy2fEHSevDh33fIx3YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toD3WuTLmiBX6ZoisEVAfnFfYVQNmsPe3F5Yrgyf+1JxrPAxOHESRSJdKtHiPDdQdwdKhDqMUrTyAD7L/QZJdgdpuz7eAzDZWQRHWs9R+gGmX+9pOiuhyizK2AvnLz1yICJSfpL33KJi8Ex0DaNKVwmpiiGrzD3/+A6jYuJFY9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmCD45sR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F94C116B1;
	Sat, 17 Aug 2024 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723915273;
	bh=GOljD1N1kdvmwm21M1D56fcwJy2fEHSevDh33fIx3YY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmCD45sRu6JpDCEXmnqLgYg/d0xct3jS2P/DuGdW2gKfoxLDEcp5CyPaddIyCkupT
	 HyTM8daehLdOFgTrzl7wQb7+1qmls/0C68Xgzgz3p7J4RFMTLPgH0AZ9bB2u93CliI
	 IOnFVYzwlNqas72OvkdvfdetCcurZ4ugkeno8vc7Vf95wjWiM5xhMvUXxmmM57rk4C
	 OSg/vSswSLo6Npu76y9j8oV6B3GtKei9hdQjv+/SfL8jzfQeN/URqCH6bOmUF3v5Qe
	 KhPbg2LOcgkWh0HASHgBQLSM6CN8U9IBvj4RRORwcgRQiAb+VNSa3FvVpEbzHwulcP
	 Mhu1pt6Vo9UOw==
Date: Sat, 17 Aug 2024 22:51:08 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	tiwai@suse.de, broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 2/3] soundwire: intel: increase maximum number of links
Message-ID: <ZsDcBG87rGoinUL+@vaman>
References: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
 <20240816023331.6565-3-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816023331.6565-3-yung-chuan.liao@linux.intel.com>

On 16-08-24, 10:33, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Intel platforms have enabled 4 links since the beginning, newer
> platforms now have 5 links. Update the definition accordingly.
> 
> This patch will have no effect on older platforms where the number of
> links was hard-coded. A follow-up patch will add a dynamic check that
> the ACPI-reported information is aligned with hardware capabilities on
> newer platforms.

Should this not be the third patch, the dynamic check in 3rd should come
before otherwise your older platforms might break?


Other than order lgtm:

Acked-by: Vinod Koul <vkoul@kernel.org>


> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  include/linux/soundwire/sdw_intel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
> index 87d82ea9a13a..edbe1d4af8f8 100644
> --- a/include/linux/soundwire/sdw_intel.h
> +++ b/include/linux/soundwire/sdw_intel.h
> @@ -450,6 +450,6 @@ extern const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops;
>  /*
>   * Max number of links supported in hardware
>   */
> -#define SDW_INTEL_MAX_LINKS                4
> +#define SDW_INTEL_MAX_LINKS                5
>  
>  #endif
> -- 
> 2.43.0

