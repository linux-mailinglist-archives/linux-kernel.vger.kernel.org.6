Return-Path: <linux-kernel+bounces-182721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F32CC8C8ED3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 792E0B21746
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FFC1FBA;
	Sat, 18 May 2024 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VX6g6cv0"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A70624;
	Sat, 18 May 2024 00:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715991328; cv=none; b=D2JI/fZbJXJ21kn5OA4E+v3M6q/w+PpRn+bS91cEM+mM5qqmgSGhNyOeEknguATwV7205gtuPbHkHaM4B5fjTFy8MOkmvBTiUpoP4m0JDe6EB4v/fV3bUQUAWQ9BSLg/eMVlksDa/J8WlATONyVzYBhAKeXi8wSwdUSiYtzk740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715991328; c=relaxed/simple;
	bh=V07vTx9Pcc4bKqrXhXzLYwwefe5ErfqlqKXqge1UAWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFsOzCI+4AIgTOcygdwDBim8txBHF35R/rrWV3m8Xpcxu7T3DCgrIqc31dEozYm83A/vFLXINr43W0XrwRY+YCsW/FwHEsBG8dYeWRYqwCSsVNDfjZJjw82jMn9tPM+0+MC6DPhMvdpg3c2BYRL17s/odv6zqIDBmkFY/mRyD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VX6g6cv0; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=w9ULlz4UgsU7z8CnXTOJtHaxQ2rpwelEzKXQ6d+PmNo=; b=VX6g6cv0JsUWVWjs
	/Ipbl7SXrMyZzwhlBfaMW+tvqUGhYSL+EgyHUn7S7b8euSmKdUdDCHvk+Jit2R2Yd7SUDIoJQ9UCP
	RtvH8GORRDM8YvoqzjWpvda//TkIpwQFntG5VERb1lJLrPBhEetbhKURObL9EBFDqw4gK4gOlblu5
	ePEaBDdNGa8c08UIrWjWO0yq/0FDVK7gFxPlhUaFCNSAZKpVVyPASqG0x3u6cKFG9hCdEGhlVGGEP
	/34MWK4PQp0N4j8hrooaG1c6RoJ4catLTP9fgW5iOshkWeJvt1Erpvar/a+tInlErLZVFFehZaWLm
	DlPEv31cOLytjluf6Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s87jI-001U94-1v;
	Sat, 18 May 2024 00:15:16 +0000
Date: Sat, 18 May 2024 00:15:16 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: sunxi: sram: Remove unused list 'claimed_sram'
Message-ID: <ZkfzFBpZVaMLH7_f@gallifrey>
References: <20240504204401.198913-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240504204401.198913-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 00:14:40 up 9 days, 11:28,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The list 'claimed_sram' seems unused, as far as I can tell it always
> has been.
> I think the 'list' member of sunxi_sram_data was intended to be
> used when it was on that list.
> Remove them.
> 
> Build tested only.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping

> ---
>  drivers/soc/sunxi/sunxi_sram.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
> index 6eb6cf06278e6..71cc377b5e243 100644
> --- a/drivers/soc/sunxi/sunxi_sram.c
> +++ b/drivers/soc/sunxi/sunxi_sram.c
> @@ -33,7 +33,6 @@ struct sunxi_sram_data {
>  	u8			offset;
>  	u8			width;
>  	struct sunxi_sram_func	*func;
> -	struct list_head	list;
>  };
>  
>  struct sunxi_sram_desc {
> @@ -103,7 +102,6 @@ static const struct of_device_id sunxi_sram_dt_ids[] = {
>  };
>  
>  static struct device *sram_dev;
> -static LIST_HEAD(claimed_sram);
>  static DEFINE_SPINLOCK(sram_lock);
>  static void __iomem *base;
>  
> -- 
> 2.45.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

