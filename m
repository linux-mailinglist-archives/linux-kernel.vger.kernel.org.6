Return-Path: <linux-kernel+bounces-363670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F012E99C574
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DAB1C2222C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B500215D5B8;
	Mon, 14 Oct 2024 09:19:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37C115855D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897569; cv=none; b=jeGtFQtQu6GLJlJ+9nC95E6ryLq5TC6joLRrH/Gufc8aJ0kP2D91yLZstQMyxRvZN1foG1uZB9NggG7k8oA9piP/QUFMtKPSp4a5W2hv6rTcEVdYRkfKfnCrk9FwBjbh6KlqKWj5nXmcLtr6c5WfuHOQtsuCecbSc3mPROySRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897569; c=relaxed/simple;
	bh=KdUNh8cTWZXP0zrc3aBQnLNwg+SEPL6DwK5KqdksqbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hw8XsulnAWMWZgY8xbFkpWw7RXKZPlZZPkkDpX9PqRMQlxd62Eyo5GC/P/LLjUWEgWxNd5UGDef8gKwTvUQCALRcEjc7wJuijTRCh6FK/3KG0fOzfNpAwfKV6E1K4Is/VGgmMCRQ9gDKdmXd69KzWypEeUtNwM1W3SfXJ9hLWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B27901007;
	Mon, 14 Oct 2024 02:19:56 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 375EA3F71E;
	Mon, 14 Oct 2024 02:19:26 -0700 (PDT)
Date: Mon, 14 Oct 2024 10:19:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ba Jing <bajing@cmss.chinamobile.com>
Cc: will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] perf: arm-ccn: remove unused macros
Message-ID: <ZwziGzex9RmVlcNa@J2N7QTR9R3>
References: <20241012091629.2369-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012091629.2369-1-bajing@cmss.chinamobile.com>

On Sat, Oct 12, 2024 at 05:16:29PM +0800, Ba Jing wrote:
> By reading the code, I found these marcos are never
> referenced in the code. Just remove them.
> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>

These are control bit values, so I don't see a strong reason to delete
them unless we're certain we're not going to use them in future.

Anyhow, Robin Murphy wrote this driver, so its up to him. Please Cc him
for any changes to this driver in future.

Mark.

> ---
>  drivers/perf/arm-ccn.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> index 5c66b9278862..ea878b025d32 100644
> --- a/drivers/perf/arm-ccn.c
> +++ b/drivers/perf/arm-ccn.c
> @@ -28,12 +28,7 @@
>  
>  #define CCN_MN_ERRINT_STATUS		0x0008
>  #define CCN_MN_ERRINT_STATUS__INTREQ__DESSERT		0x11
> -#define CCN_MN_ERRINT_STATUS__ALL_ERRORS__ENABLE	0x02
> -#define CCN_MN_ERRINT_STATUS__ALL_ERRORS__DISABLED	0x20
>  #define CCN_MN_ERRINT_STATUS__ALL_ERRORS__DISABLE	0x22
> -#define CCN_MN_ERRINT_STATUS__CORRECTED_ERRORS_ENABLE	0x04
> -#define CCN_MN_ERRINT_STATUS__CORRECTED_ERRORS_DISABLED	0x40
> -#define CCN_MN_ERRINT_STATUS__CORRECTED_ERRORS_DISABLE	0x44
>  #define CCN_MN_ERRINT_STATUS__PMU_EVENTS__ENABLE	0x08
>  #define CCN_MN_ERRINT_STATUS__PMU_EVENTS__DISABLED	0x80
>  #define CCN_MN_ERRINT_STATUS__PMU_EVENTS__DISABLE	0x88
> -- 
> 2.33.0
> 
> 
> 

