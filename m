Return-Path: <linux-kernel+bounces-290975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4223E955BC8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D272F1F2111B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657415E96;
	Sun, 18 Aug 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLp8SjfF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F4A12B8B;
	Sun, 18 Aug 2024 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723965817; cv=none; b=bnuOHBMKfNcSiwRdRQK+l+T/2fvYzlE0xjrnchutcd8/eNjUSelPyxKmxuht5urK/b0LkkvL2zvQsFSWQQ4aj5qVai2MQgs7UGSli4+SggTT9t9OCPIN0o+pd2ed4q5fFvmgRezSNUw7QoRoxdht1bXHySyujwI8j2psAPK1RE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723965817; c=relaxed/simple;
	bh=DHAmu4fXPz6F0RDPNtgs02ef096s4MjYv2NyO32nzLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AD+9du2HX24g/SjwbhsccTDNch0T+mnipnmwDjq7RPLsxVumOFLD2xjTIv+R3nTPYMJ3I31HYqJiyiG2Q7fBEdEXIyULnj2ma95gbYhT6f0V/EtCFgxMa2YFmRRAaHkd/yYdrw9aic3mQNT2iCmCdrxBG+Bznt3NUCC7EvWgn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLp8SjfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51386C32786;
	Sun, 18 Aug 2024 07:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723965816;
	bh=DHAmu4fXPz6F0RDPNtgs02ef096s4MjYv2NyO32nzLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLp8SjfFEK+0/h7cnJLggkev7mXCNK5czCM7bE9auhDeA6FMhRcAXC4yQG3bW24Kk
	 yeDdcfVmrO+iYVxEQvfJ10/trRvZD1X+M7Int33iXzjyhAGamlmYBNeVoEQIAFfgKZ
	 xHCBFRP57e0DHUleVGivgTCf2vX0l753iijsUrjmAOgdK3CmHUF6i8Fyl7t0vjBdeW
	 XHy9t/GxEmExCa8Dv/f3Gsyz5hKb9CRMK+Ov/rXljV44UlD8DKW1jYDyxdPPmjxZ7j
	 gh2HwxCk3ndOV819Q74sMzUIwWwj313xfubv61YsDHCefoG1i+yiPnUdFboiqc190k
	 q84tGhGT4Tfww==
Date: Sun, 18 Aug 2024 12:53:32 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel_auxdevice: add kernel parameter for
 mclk divider
Message-ID: <ZsGhdFm8nYkm5Y5w@vaman>
References: <20240806083840.24094-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806083840.24094-1-yung-chuan.liao@linux.intel.com>

On 06-08-24, 16:38, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Add a kernel parameter to work-around discrepancies between hardware
> and platform firmware, it's not unusual to see e.g. 38.4MHz listed in
> _DSD properties as the SoundWire clock source, but the hardware may be
> based on a 19.2 MHz mclk source.

I think this should be documented in kernel-parameters.txt?

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/intel_auxdevice.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
> index dff49c5ce5b3..e372195b07b3 100644
> --- a/drivers/soundwire/intel_auxdevice.c
> +++ b/drivers/soundwire/intel_auxdevice.c
> @@ -41,6 +41,10 @@ static int md_flags;
>  module_param_named(sdw_md_flags, md_flags, int, 0444);
>  MODULE_PARM_DESC(sdw_md_flags, "SoundWire Intel Master device flags (0x0 all off)");
>  
> +static int mclk_divider;
> +module_param_named(sdw_mclk_divider, mclk_divider, int, 0444);
> +MODULE_PARM_DESC(sdw_mclk_divider, "SoundWire Intel mclk divider");
> +
>  struct wake_capable_part {
>  	const u16 mfg_id;
>  	const u16 part_id;
> @@ -142,8 +146,12 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
>  				 "intel-sdw-ip-clock",
>  				 &prop->mclk_freq);
>  
> -	/* the values reported by BIOS are the 2x clock, not the bus clock */
> -	prop->mclk_freq /= 2;
> +	if (mclk_divider)
> +		/* use kernel parameter for BIOS or board work-arounds */
> +		prop->mclk_freq /= mclk_divider;
> +	else
> +		/* the values reported by BIOS are the 2x clock, not the bus clock */
> +		prop->mclk_freq /= 2;
>  
>  	fwnode_property_read_u32(link,
>  				 "intel-quirk-mask",
> -- 
> 2.43.0

-- 
~Vinod

