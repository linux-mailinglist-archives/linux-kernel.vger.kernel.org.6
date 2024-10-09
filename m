Return-Path: <linux-kernel+bounces-356764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E7B996651
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E232847D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8667815382F;
	Wed,  9 Oct 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rbJzozZh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F018A6B1;
	Wed,  9 Oct 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468030; cv=none; b=RwTDhjNlX/F5nLgW4xwCmqVJhL4aKGltbHHucAWZi0HiRse90ohIDM2+a8IfKln6XBQowl4T3xkgWuRWqCeeQcF0cDwViy7msMOM5GJR3bEvYJnDkRZFtd55iwb5P29NjVAXKlT8jLgsfUcMtWp7EsF1zvyMG7Sab3d0xfat74E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468030; c=relaxed/simple;
	bh=WG5iVx738wHdbOEaHx6qMNBMcqRb0gSARdqebNRRbOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkTELeiDDUsNtiLqUP8LVU7/CQjt1IaEr4jiSvNokn0Ldqkp7arnHY51j0DxcGVMG3Llz6rtrQC7iI/OujIDXOT0oF3tk6IrjNinQeTAtSuzSOvkmfxwJtjMxJx67gkLjF/RsBGchLWqegLelQbV/1lZYxguPnu8jHgrH7sub6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rbJzozZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA619C4CEC5;
	Wed,  9 Oct 2024 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728468029;
	bh=WG5iVx738wHdbOEaHx6qMNBMcqRb0gSARdqebNRRbOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbJzozZhfcsy25cXRA8zzUfSoAVg7WTnQQ/3pL54nn5n0wXaBV8qCHLXe2iBe5PQr
	 jFUFNZdYkL3J0a9h8BPs0JJu9025iGqo9aJHkUI4iOusZXNO8wJr7inYC7cKvT9T+6
	 fNdMx1GmAgKZR0GkOFJYjdqVdoKiAiqRcihzDau8=
Date: Wed, 9 Oct 2024 12:00:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hridesh MG <hridesh699@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH] staging: vchiq_core: Fix code indent errors
Message-ID: <2024100911-casket-shading-a22f@gregkh>
References: <20241007152214.23240-1-hridesh699@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007152214.23240-1-hridesh699@gmail.com>

On Mon, Oct 07, 2024 at 08:52:12PM +0530, Hridesh MG wrote:
> Replace spaces with tabs to adhere to kernel coding style.
> 
> Reported by checkpatch:
> 
> ERROR: code indent should use tabs where possible
> 
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>
> ---
>  .../vc04_services/interface/vchiq_arm/vchiq_core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 1f94db6e0cd9..3f3ef1ca7154 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -2761,13 +2761,13 @@ vchiq_bulk_xfer_queue_msg_interruptible(struct vchiq_service *service,
>  		state->id, service->localport, dir_char, queue->local_insert,
>  		queue->remote_insert, queue->process);
>  
> -        if (bulk_waiter) {
> -                bulk_waiter->bulk = bulk;
> -                if (wait_for_completion_interruptible(&bulk_waiter->event))
> -                        status = -EAGAIN;
> -                else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
> -                        status = -EINVAL;
> -        }
> +	if (bulk_waiter) {
> +		bulk_waiter->bulk = bulk;
> +		if (wait_for_completion_interruptible(&bulk_waiter->event))
> +			status = -EAGAIN;
> +		else if (bulk_waiter->actual == VCHIQ_BULK_ACTUAL_ABORTED)
> +			status = -EINVAL;
> +	}
>  
>  	return status;
>  
> -- 
> 2.46.1
> 
> 

No longer applies to the tree due to other changes that were submitted
before you, sorry.

greg k-h

