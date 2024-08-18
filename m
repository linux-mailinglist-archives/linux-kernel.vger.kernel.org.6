Return-Path: <linux-kernel+bounces-290974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD3955BC7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 09:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4401F21D2A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 07:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1A614F70;
	Sun, 18 Aug 2024 07:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC+DIrVB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF20168B8;
	Sun, 18 Aug 2024 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723965669; cv=none; b=V/TwDWr82mM1pUB1guveHDu+9fOJj5eDek/14cnUxmda7Jrr5VA7VS7T+yu9TzeuHC9Xakad2Z+EZQwvvKY1Oe3Aq0W4AaB7wT/m4k+UV1VLPUgYvpNE1fe5kGjt4O6+q5WCKamKgZaLfTKhN1vBmg0TAMN4lRSiQ1hGRb/Rafc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723965669; c=relaxed/simple;
	bh=/aQE6Sq2qj3Wk5um5XXkRiBCBop3yqCgawTn24SWihI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEv8zC6BWpqaliKL9V9jtvc/V5EzYYalSEB88ZCgQnPUzoQDKK9h+OMvTJXfUomzD0+N5jPqJae6L+znW4reGVdvDkTq4ij5VtPa1eW2E3DJWySbA8z8ntYS9/n29mk/8Fdm3Z518b37Bvsf4nHj4Q/P8GjjriVDSgsj66lbKpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC+DIrVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8A4C32786;
	Sun, 18 Aug 2024 07:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723965669;
	bh=/aQE6Sq2qj3Wk5um5XXkRiBCBop3yqCgawTn24SWihI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kC+DIrVBw9bvs8go3EjlybI3++bvOwlzHJksVabozST7mjLbh1t8DFM6dszslOmlg
	 nY4YlxlHdycLgB1NNakN8Nruss/QmBgbHB2s3z0YyA7TEXLWypPnmanZ1HFQHgPpds
	 UnsFBMsBlBi7nCu64+tTw+wTOtpBVVV7FRxFJ1C5btFU4q95u5fLKAlvAMyz+DYW9R
	 78QQJr8hypmlXWpkNOMx7uIaDzfKx+L+ZScEnhE9lhzr3edgNgvw5+6+tffXX5BiV8
	 YawZX7vVCS/XEWzzLsYxS2lzpKBjU1b+XF4ViQxvh8qJrW8qELo4bWFx+M1QMPx+Og
	 w2okhyWf9RCSw==
Date: Sun, 18 Aug 2024 12:51:05 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH] soundwire: add lane field in sdw_port_runtime
Message-ID: <ZsGg4c7Nc0jiyGgK@vaman>
References: <20240806060930.10433-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806060930.10433-1-yung-chuan.liao@linux.intel.com>

On 06-08-24, 14:09, Bard Liao wrote:
> Currently, lane_ctrl is always 0. Add a lane field in sdw_port_runtime
> to indicate the data lane of the data port.
> They are 0 by default.

Use of the lane? also missing setting of lane variable, dont see in this
patch so we are passing garbage? It might work as structure is kzalloced
but I dont think we should be implicit, programming makes sense


> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/amd_manager.c                  | 2 +-
>  drivers/soundwire/bus.h                          | 2 ++
>  drivers/soundwire/generic_bandwidth_allocation.c | 4 ++--
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index 0d01849c3586..babb580f3124 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -410,7 +410,7 @@ static int amd_sdw_compute_params(struct sdw_bus *bus)
>  			sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
>  					      false, SDW_BLK_GRP_CNT_1, sample_int,
>  					      port_bo, port_bo >> 8, hstart, hstop,
> -					      SDW_BLK_PKG_PER_PORT, 0x0);
> +					      SDW_BLK_PKG_PER_PORT, p_rt->lane);
>  
>  			sdw_fill_port_params(&p_rt->port_params,
>  					     p_rt->num, bps,
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index fda6b24ac2da..ff03b97f1d8b 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -90,6 +90,7 @@ int sdw_find_col_index(int col);
>   * @transport_params: Transport parameters
>   * @port_params: Port parameters
>   * @port_node: List node for Master or Slave port_list
> + * @lane: Which lane is used
>   *
>   * SoundWire spec has no mention of ports for Master interface but the
>   * concept is logically extended.
> @@ -100,6 +101,7 @@ struct sdw_port_runtime {
>  	struct sdw_transport_params transport_params;
>  	struct sdw_port_params port_params;
>  	struct list_head port_node;
> +	unsigned int lane;
>  };
>  
>  /**
> diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
> index b9316207c3ab..abf9b85daa52 100644
> --- a/drivers/soundwire/generic_bandwidth_allocation.c
> +++ b/drivers/soundwire/generic_bandwidth_allocation.c
> @@ -56,7 +56,7 @@ void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
>  					      sample_int, port_bo, port_bo >> 8,
>  					      t_data->hstart,
>  					      t_data->hstop,
> -					      SDW_BLK_PKG_PER_PORT, 0x0);
> +					      SDW_BLK_PKG_PER_PORT, p_rt->lane);
>  
>  			sdw_fill_port_params(&p_rt->port_params,
>  					     p_rt->num, bps,
> @@ -109,7 +109,7 @@ static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
>  		sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
>  				      false, SDW_BLK_GRP_CNT_1, sample_int,
>  				      *port_bo, (*port_bo) >> 8, hstart, hstop,
> -				      SDW_BLK_PKG_PER_PORT, 0x0);
> +				      SDW_BLK_PKG_PER_PORT, p_rt->lane);
>  
>  		sdw_fill_port_params(&p_rt->port_params,
>  				     p_rt->num, bps,
> -- 
> 2.43.0

-- 
~Vinod

