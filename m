Return-Path: <linux-kernel+bounces-513369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BA7A349B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD4D3A7C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBE921D3FC;
	Thu, 13 Feb 2025 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4UajAWy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C73211A36;
	Thu, 13 Feb 2025 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463337; cv=none; b=cfcN9Q4J7+QkaRbks30U4bGZTw5nQhr/J7evTo0oRvQ3/3URKBy5TGDJrWmtdorTYVuRgWEL8HbgOWEp+NNsJIHY6xOaCInCqpaFbmxRaWH54ELvv1ML1YT7CbSXdOnijedYI8iZwSVNpfHa3TP9VYypEiKsuGOlXLiu46mi55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463337; c=relaxed/simple;
	bh=HbYnqyNNOZ3X0ssMhWFk2VYAZhe/38v3IVglUdJr+dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoQnsoDB+P0BSEBDtUveM22gib36qnfQB0ynNLqIXF/HdWk+/BKFMiKJhsWCKAZ3Zw4HC/2I+Jww1S28irA/9wg+cYJMPeBW2nr7VDdMVUucCKVJslwTHytES316bVzVVuLn53HBEyYD9B57VZcFJEcn+seEwYoGRa4rK15fgE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4UajAWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65272C4CED1;
	Thu, 13 Feb 2025 16:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739463336;
	bh=HbYnqyNNOZ3X0ssMhWFk2VYAZhe/38v3IVglUdJr+dM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4UajAWyXVeEGHPfIH0T6x8Iucjj7jf4PwLRNWLc/TMhtGkd2+Lr94n4ORbzAsxXD
	 imjfZzVdjTgWySoRZMNukQYcz1GgEkqAFhzooORTUlQhtZ6JUiajCkTeJ0/CDLptW/
	 9mFwyMGXa028MgrHuzSkelTDBcf6yrU64RrcsEaW/qn+4HdwK4dSismi35oT6uklv9
	 TBoIyJnCnHeS18V9om5MgRnFBx99HJOAF3KVZTSacwBGMvhziAKxRDz7wQWbhKn1/X
	 y+vjNhbChzsq/y13ZhRb2eCbedSqq4HBd3ebc+nGLbwVItKX5dyfOOT2DFMVDolXeK
	 jfzfhPWKxMo7w==
Date: Thu, 13 Feb 2025 21:45:33 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev, bard.liao@intel.com
Subject: Re: [PATCH 2/2] Revert "soundwire: intel_auxdevice: start the bus at
 default frequency"
Message-ID: <Z64apTrlAbvUDQLx@vaman>
References: <20250205074232.87537-1-yung-chuan.liao@linux.intel.com>
 <20250205074232.87537-3-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250205074232.87537-3-yung-chuan.liao@linux.intel.com>

On 05-02-25, 15:42, Bard Liao wrote:
> Now, we can support more than 1 soundwire bus clock frequency.
> 
> This reverts commit c326356188f1dc2d7a2c55b30dac6a8b76087bc6.

Pls use full patch title and not just the sha

> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> ---
>  drivers/soundwire/intel_auxdevice.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
> 
> diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
> index b34b897400fc..5ea6399e6c9b 100644
> --- a/drivers/soundwire/intel_auxdevice.c
> +++ b/drivers/soundwire/intel_auxdevice.c
> @@ -243,30 +243,9 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
>  
>  static int intel_prop_read(struct sdw_bus *bus)
>  {
> -	struct sdw_master_prop *prop;
> -
>  	/* Initialize with default handler to read all DisCo properties */
>  	sdw_master_read_prop(bus);
>  
> -	/*
> -	 * Only one bus frequency is supported so far, filter
> -	 * frequencies reported in the DSDT
> -	 */
> -	prop = &bus->prop;
> -	if (prop->clk_freq && prop->num_clk_freq > 1) {
> -		unsigned int default_bus_frequency;
> -
> -		default_bus_frequency =
> -			prop->default_frame_rate *
> -			prop->default_row *
> -			prop->default_col /
> -			SDW_DOUBLE_RATE_FACTOR;
> -
> -		prop->num_clk_freq = 1;
> -		prop->clk_freq[0] = default_bus_frequency;
> -		prop->max_clk_freq = default_bus_frequency;
> -	}
> -
>  	/* read Intel-specific properties */
>  	sdw_master_read_intel_prop(bus);
>  
> -- 
> 2.43.0

-- 
~Vinod

