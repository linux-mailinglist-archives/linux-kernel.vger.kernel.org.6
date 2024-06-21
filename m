Return-Path: <linux-kernel+bounces-223699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5256D911718
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07EAF282BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7436F15C9;
	Fri, 21 Jun 2024 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="i5txX3rl"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A864F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718928171; cv=none; b=LxNJWONocDjxgxjPRMEiZwl2qoczRhXQ32NVuuzWvj+s0/bVTDatxNrcEgAMdYMZPz0WKOSoEspKucTWWMiE8SUQdZvAnCUh7Kgt9oNvX1f9wRXxNIokZm+GiC7zeHm8iJGtjM2ggBSdDFPuppvYCEBlWbquR9Mw19ZgGaKApGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718928171; c=relaxed/simple;
	bh=O0thi/O9CqDl0z3mgB/8o78Qqtqe60X9WxKn9W+eods=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdQQ+npYfGja5O8DHN+mo6ap/zfRshqYEMylWEhp3aL6dA7BUVb8T61Bv1rAS7lAgg5mp0o9oxUaUep0BFxnbemJtJk8Jde8eINVzE7KW11ABh94V/LVvnpAWH08lEku1mYG3BNpRnP6PDZpnhJGwvONUuGq5vEEBn7AcXCwrmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=i5txX3rl; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=qrNK5A/MTRu4rCBQZVtDvFFjMNsiGmVeH0NujBDe5eo=; b=i5txX3rlYKgf8Jb/
	EmlqE2jNpvrqfjm4mDGe5WqxNGg6wYux9SxJ7ybgV/lZNzzK7roiQRDcTAg6PxQxFmRgAXs3ZRRof
	5SoD+hfulqJkrtd8YKKbnqJK81kPg0FFc6s/jfjJhA6pXkXORY62Ii0hwVk7hZbNelMyPKClnaWeT
	T9hXgRjSNcj6skzCUn5Vohqp7624yNb8h4Y9qoKIuPUB/75d6P7hu18klRIg7tDP79EhGJCl/yI+/
	/RhgZpz26T6Vz2okkCKlJnO60ZipAjufN97ZYQxcXqwodUfqNKivir2axFfpivsmOLbkPFz0u303G
	y3fHA8DRTZmloEC5yA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sKRjl-007Vlp-0S;
	Fri, 21 Jun 2024 00:02:41 +0000
Date: Fri, 21 Jun 2024 00:02:41 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: nipun.gupta@amd.com, nikhil.agarwal@amd.com
Cc: abhijit.gangurde@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdx: remove unused struct 'cdx_mcdi_copy_buffer'
Message-ID: <ZnTDIRpC9xhH4vrO@gallifrey>
References: <20240530233436.224461-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240530233436.224461-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 00:02:29 up 43 days, 11:16,  1 user,  load average: 0.01, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'cdx_mcdi_copy_buffer' has been unused since the original
> commit eb96b740192b ("cdx: add MCDI protocol interface for firmware
> interaction").
> 
> Looking at lkml,  it was used in the V1 posting but was removed
> somewhere before V6.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping.

Dave

> ---
>  drivers/cdx/controller/mcdi.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
> index 1eedc5eeb315..e760f8d347cc 100644
> --- a/drivers/cdx/controller/mcdi.c
> +++ b/drivers/cdx/controller/mcdi.c
> @@ -27,10 +27,6 @@
>  #include "bitfield.h"
>  #include "mcdi.h"
>  
> -struct cdx_mcdi_copy_buffer {
> -	struct cdx_dword buffer[DIV_ROUND_UP(MCDI_CTL_SDU_LEN_MAX, 4)];
> -};
> -
>  static void cdx_mcdi_cancel_cmd(struct cdx_mcdi *cdx, struct cdx_mcdi_cmd *cmd);
>  static void cdx_mcdi_wait_for_cleanup(struct cdx_mcdi *cdx);
>  static int cdx_mcdi_rpc_async_internal(struct cdx_mcdi *cdx,
> -- 
> 2.45.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

