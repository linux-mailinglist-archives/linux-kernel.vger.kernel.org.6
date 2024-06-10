Return-Path: <linux-kernel+bounces-208416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852229024EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD2E4B29B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A726F137747;
	Mon, 10 Jun 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dfP6Nvd9"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A796F86126;
	Mon, 10 Jun 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718031580; cv=none; b=FNTOEVW7bSNgN4QgrLTFr6OMbgirOaEBWiwvR3xh4pJbm56PA1fQKYtBYl8u6zh9RL7xuBo3Ssj+Lj5T0rU2+q3KV3jcaI6WMgtXkYgL/MEXQ0lfMhsPXnyhliXSnTHspI6P/ewb0NPv8p4fYjF7Vj1rXd79bgcNdNlC2xQQ5s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718031580; c=relaxed/simple;
	bh=P1CAVjktf7Ln2QB4ZgwW3nDizRL3v9KPQA8epNmv2uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMSljhXPTvNgdqgfEZ+TXUebNMUmvw+7k8Z+uGSVeEPce92ynwKEGlcyhEKQEyZ8hh1f88gRQ2aqt/XjcAFrQwWqGpjMk6zOBX1DzXBRWwosQVdbLkXHYb58cFZI7SEleoXW/CZ7WkpgM704aPrvQTu4oFWYiOloffmBZE6IgrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dfP6Nvd9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=B0xfg+IE2l0Yoxu1WJC1kw9bFphbvDVSpsHf/NczCbI=; b=dfP6Nvd9RF1vC/RxxzXonfjumq
	EfsGlCu2A2oTr8AqYfBYw8ew4AxuiagkLEo/QygWcH1/MfoPeDFjj7CRNwJdGWDokGe8LCoBsve1X
	ECkbXasedJ/4uGO6yGFljjvjq2o7oFlpzyN+42W/r2HxPiQSld2Ra3X6aL6Rm/YIXPjpJuL7dd5UN
	Pli1q+tc5303/hhkoed9FIbO6RhdM+jjpWa6IXAnzB0aylElxISP2785iUcILejCfWaiGo04pqVyc
	XOecPzSwdRop+H6b/m4qxHu6QH7AQrIjvIgYpb74PZmphCIubqGgzJumpXUkxuBLIXxkgTAFGq9Y2
	CL7nH1jA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGgUk-00000005XMC-0pb9;
	Mon, 10 Jun 2024 14:59:38 +0000
Message-ID: <ce08766e-8449-4fbc-9551-850852e53067@infradead.org>
Date: Mon, 10 Jun 2024 07:59:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] scripts/spelling.txt: add more spellings to
 spelling.txt
To: Colin Ian King <colin.i.king@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240610110419.1060732-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240610110419.1060732-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/10/24 4:04 AM, Colin Ian King wrote:
> Some of the more common spelling mistakes and typos that I've found while
> fixing up spelling mistakes in the kernel since December 2023.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  scripts/spelling.txt | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index edec60d39bbf..702a50ae1ad1 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -261,6 +261,7 @@ broadcase||broadcast

> @@ -838,6 +853,7 @@ initalise||initialize
>  initalize||initialize
>  initation||initiation
>  initators||initiators
> +initialiased||initialized

We normally accept British spellings...

All of the others look good to me.
Thanks.


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

