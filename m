Return-Path: <linux-kernel+bounces-396485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1344F9BCDC7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A62B21F94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903081D63CC;
	Tue,  5 Nov 2024 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="DxfqiuGx"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5951D5CD7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813338; cv=none; b=fFOyo0cKb6VY86oNtzd/RdcfOG3l3QVjCMYPAsXsG4XcrCbI2Cy1zqRUWVeAEyx9i1ggUiy+Ocr2q9+fFhWCwg5Jp4vE8Jse9BKEpqJPzxcvvFrbA+oCrd583BRfrf4/IYU8E1CO0sHRWrB/KV/4L2E2wb1ZW4ya4+fOFghfUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813338; c=relaxed/simple;
	bh=/6NZ/YPpLOa7bVd1UPSOcD6HJU9lZYHNIq4RAarRCfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcDLDBudiYjH0sW7MnESRctXhDfsQjfykF8wWr1g7IDuwleRdv6O1da3OBelHZo5amtmMZd6AL/mUZiOrkrQCX6DNAWdorOs9huPcveZQuXlLUHCN96UixT8iAQ2OxkUEtxzWKvqiCRb5EUQbDEIAs5ZK2jwhz/woFKYVXOUqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=DxfqiuGx; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=c438xD/qQj67su2OtTZhRTv8sKeFnPi4gC4GZr1xFaQ=; b=DxfqiuGxamKx477C
	q9OjkmdPLhO9um44chkVabj1ydCESmqGUHfDdbxSVaxylTYuGXVAnixaP9pKPpJNy9n/t5eSR1bwo
	4JFHV7MrCgU03qJtd+Kd7QZJd4GEvtERrnRKI30Hlf9I3yUvCngxUFEA0qlOVPSMBWcsu5ooITGGG
	UmgD6ZFhWXqYHJa0NDhmdSQpueKTXEWXMZLF7QEA76CPoyd+adyx/zMqFY954i9V45n5YRL+Xzfdb
	HRPbQZiGVSLNn8cEO/VlNNeeiPQe7GPXtefPjcDCyJTAhLOMS2W8XMTPl8035/ift+E0LlqSkCIbU
	ARj6Ba9BZXTiFUsznQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1t8Jbo-00FY0t-1U;
	Tue, 05 Nov 2024 13:28:36 +0000
Date: Tue, 5 Nov 2024 13:28:36 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: cdns-mhdp8546: Remove unused functions
Message-ID: <ZyodhNcImI7LxXl_@gallifrey>
References: <20241005232017.305217-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241005232017.305217-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:28:24 up 181 days, 42 min,  1 user,  load average: 0.07, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> cdns_mhdp_hdcp_set_lc() and cdns_mhdp_hdcp_set_public_key_param()
> were added by commit
> 6a3608eae6d3 ("drm: bridge: cdns-mhdp8546: Enable HDCP")
> but never used.
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping.

Dave

> ---
>  .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   | 28 -------------------
>  .../drm/bridge/cadence/cdns-mhdp8546-hdcp.h   |  3 --
>  2 files changed, 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
> index 31832ba4017f..42248f179b69 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
> @@ -500,34 +500,6 @@ static void cdns_mhdp_hdcp_prop_work(struct work_struct *work)
>  	drm_modeset_unlock(&dev->mode_config.connection_mutex);
>  }
>  
> -int cdns_mhdp_hdcp_set_lc(struct cdns_mhdp_device *mhdp, u8 *val)
> -{
> -	int ret;
> -
> -	mutex_lock(&mhdp->mbox_mutex);
> -	ret = cdns_mhdp_secure_mailbox_send(mhdp, MB_MODULE_ID_HDCP_GENERAL,
> -					    HDCP_GENERAL_SET_LC_128,
> -					    16, val);
> -	mutex_unlock(&mhdp->mbox_mutex);
> -
> -	return ret;
> -}
> -
> -int
> -cdns_mhdp_hdcp_set_public_key_param(struct cdns_mhdp_device *mhdp,
> -				    struct cdns_hdcp_tx_public_key_param *val)
> -{
> -	int ret;
> -
> -	mutex_lock(&mhdp->mbox_mutex);
> -	ret = cdns_mhdp_secure_mailbox_send(mhdp, MB_MODULE_ID_HDCP_TX,
> -					    HDCP2X_TX_SET_PUBLIC_KEY_PARAMS,
> -					    sizeof(*val), (u8 *)val);
> -	mutex_unlock(&mhdp->mbox_mutex);
> -
> -	return ret;
> -}
> -
>  int cdns_mhdp_hdcp_enable(struct cdns_mhdp_device *mhdp, u8 content_type)
>  {
>  	int ret;
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h
> index 334c0b8b0d4f..3b6ec9c3a8d8 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h
> @@ -82,9 +82,6 @@ struct cdns_hdcp_tx_public_key_param {
>  	u8 E[DLP_E];
>  };
>  
> -int cdns_mhdp_hdcp_set_public_key_param(struct cdns_mhdp_device *mhdp,
> -					struct cdns_hdcp_tx_public_key_param *val);
> -int cdns_mhdp_hdcp_set_lc(struct cdns_mhdp_device *mhdp, u8 *val);
>  int cdns_mhdp_hdcp_enable(struct cdns_mhdp_device *mhdp, u8 content_type);
>  int cdns_mhdp_hdcp_disable(struct cdns_mhdp_device *mhdp);
>  void cdns_mhdp_hdcp_init(struct cdns_mhdp_device *mhdp);
> -- 
> 2.46.2
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

