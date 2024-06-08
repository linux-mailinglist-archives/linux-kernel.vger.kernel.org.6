Return-Path: <linux-kernel+bounces-207188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4A0901377
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 22:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A14282500
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 20:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD00E1F932;
	Sat,  8 Jun 2024 20:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="eiwBNu/q"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9975B134DE
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717879982; cv=none; b=lBWbKkb7AGlbehYcmrc1lO5JHSCruT6VfgVUait7Rq3dfewDjGBKh5QAREbziHH+4byiWWuPLwgRJzE1QC/IzjOjDLPkx+dIz6aWMnmV7hOGc3OOHEBkMhXuWn8gESFah54+aymfAcuNEXdlE5lx0QVD2Xb9gz9m+ErY/eodXbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717879982; c=relaxed/simple;
	bh=o3A+wp2C903FC2WDwTMbS8Xt+l0kyfAYt5wNH+jWtOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/AcsdDZLlYerkzjBphoQXuk5fqE5xWDtReC4oA3QJt0uCCExMHG7nRoYUmY8ZfKbAqhBsAUxiR4Tv6mPa58F5r6WAopnzOBLd9MAjPucMhq41O4j8HVk/jjQpod82n4ChdjJW+gqO2jdmsGP34DsnmRR7RgNAguOFRTea2d9v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=eiwBNu/q; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=8uTz2hQmdZ42l5KhlmjOcoaAYMysjJIUyCXrGnDGCHM=; b=eiwBNu/qD0CyD0Gf
	ZlFL3SbiCpbUbMjU7ZvKd+EVdlxO5/JXEFBi/fvMzK4R7PlUu7VT2vWhyRVRC3miCUXjn+WFx/P6m
	R9n/+czpTvTeoOZQFOW0Sf0bxCJuKA4kmB1fOkBh2lFo6m5MykBeL/w1gVcAwnvUKwnHluXZNbGR+
	SERv9L3ozAIFRBVkXlrLRHkMrTXy6DB17r0j2jh+tx5ByYEoYSihJgCGYRSwGMZX0b5y0weohzfzz
	Dj2iOE1l46urETARdrm1QTZXVNvDtWYPawOLWBrFVS9k9mS24XFVNIY2B/pd0255oni7BJAa9WDjX
	h/XslAWJl1/+OFshfg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sG33a-005A0Y-1C;
	Sat, 08 Jun 2024 20:52:58 +0000
Date: Sat, 8 Jun 2024 20:52:58 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: jassisinghbrar@gmail.com, rrice@broadcom.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: bcm-pdc: remove unused struct 'pdc_dma_map'
Message-ID: <ZmTEqs2PKZZW_mYT@gallifrey>
References: <20240523203741.201099-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240523203741.201099-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:52:49 up 31 days,  8:06,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'pdf_dma_map' has been unused since the original
> commit a24532f8d17b ("mailbox: Add Broadcom PDC mailbox driver").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping

> ---
>  drivers/mailbox/bcm-pdc-mailbox.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
> index 242e7504a628..a873672a9082 100644
> --- a/drivers/mailbox/bcm-pdc-mailbox.c
> +++ b/drivers/mailbox/bcm-pdc-mailbox.c
> @@ -158,10 +158,6 @@ enum pdc_hw {
>  	PDC_HW		/* PDC/MDE hardware (i.e. Northstar 2, Pegasus) */
>  };
>  
> -struct pdc_dma_map {
> -	void *ctx;          /* opaque context associated with frame */
> -};
> -
>  /* dma descriptor */
>  struct dma64dd {
>  	u32 ctrl1;      /* misc control bits */
> -- 
> 2.45.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

