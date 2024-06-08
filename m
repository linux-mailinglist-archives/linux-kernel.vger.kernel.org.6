Return-Path: <linux-kernel+bounces-207187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC832901376
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 22:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958F51C20D57
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 20:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B5E1F932;
	Sat,  8 Jun 2024 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="bzOJDWnL"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C68828
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717879868; cv=none; b=uoh7JSysWuBabyczwsHYBb34RhQRaubkf1p0zHSquf6Fk9/VgDaivsDjVOZQepUDK6pp70xtNt9MfYkIQAL5ZGeOSCrWvnkIEF7ihnxGjpGZhfBVe0O7uuWchNjprc49vfyAsFz9VE2MR+ZF0u765BeELAfQJQubsq1AbBm8HRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717879868; c=relaxed/simple;
	bh=pQewJKnLJpQTeSoqF1MXIOxpAlMlHktxfDFkyCGeDIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtomSr+9ob4hW/ZlAugg1xZ8+u2L158hHGc1h7mRNTq3poylmYeTSczGyTsKCr2hDjm9E1n0Z3LF+0FPzbk6VLuMshBDYc5p0OBD8vCfOXn7yBv79FhShzLgV6xbilx1vLVRxTzCGAbLzKTiQyCyN5hBphWNO8+OASD2/3RABfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=bzOJDWnL; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Mu3pv0TFh4Ia3GnqMfXBNsKCRAD2TE0jYiVYPu31nE4=; b=bzOJDWnL4bt91L9w
	TBzRvx1aUjdVl3sGJBGon2D5/JyYtt0giKFkwrQ0HNbVRVxl3JhKNROgBZcr1kUUOpaJSGsP4s5eb
	KJxXpBGChPX+elhoKt5onzFbs56OtBo3TvGySAuHfJBcLeYP2LPP53S3u/5WGdltEIMXtaXjrWDvZ
	/qvzelEM7SNtHDgkIl2WVqNCAvmuGN3oWQzNhh0cU/oEe8c03nKs65ikmg1GTPokbOpnCQCjIIwUP
	nEPEltk/16OLF9Z3NE1MqBtSwGAvP37d8fFPpRiBRbuEJLrfpg8qQG54P6iff+N/1x6ecMZs0kB8/
	4tTSkihmdhWsPKYNnQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sG31k-0059zL-30;
	Sat, 08 Jun 2024 20:51:04 +0000
Date: Sat, 8 Jun 2024 20:51:04 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: morbidrsa@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mcb: remove unused struct 'mcb_parse_priv'
Message-ID: <ZmTEOLKZUJ_D9L-O@gallifrey>
References: <20240523204921.235746-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240523204921.235746-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:50:55 up 31 days,  8:04,  1 user,  load average: 0.02, 0.01, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'mcb_parse_priv' has been unused since the initial
> commit 3764e82e5150 ("drivers: Introduce MEN Chameleon Bus").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Ping

> ---
>  drivers/mcb/mcb-parse.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
> index 1ae37e693de0..a5f8ab9a0910 100644
> --- a/drivers/mcb/mcb-parse.c
> +++ b/drivers/mcb/mcb-parse.c
> @@ -8,11 +8,6 @@
>  
>  #include "mcb-internal.h"
>  
> -struct mcb_parse_priv {
> -	phys_addr_t mapbase;
> -	void __iomem *base;
> -};
> -
>  #define for_each_chameleon_cell(dtype, p)	\
>  	for ((dtype) = get_next_dtype((p));	\
>  	     (dtype) != CHAMELEON_DTYPE_END;	\
> -- 
> 2.45.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

