Return-Path: <linux-kernel+bounces-410272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 549D89CD722
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA965B238AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3AE185B5B;
	Fri, 15 Nov 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZaGRlatA"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6137D645
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652652; cv=none; b=QFgI0DDHdEiY5nlZgIM1SRazmvY2TAVJVw9Bm+WZmY9712FGiXGcufeP12CE7Sxu0NHheq9xV1m+MO3zWcpMHujYbWDxL3G0JbOD2bqdTK2vFisvQt5TAWhSPvrFcoiEZ021xvPjj1XXjJB4K3E0DZIQDR+k7qlYRjWuZDKRMiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652652; c=relaxed/simple;
	bh=jbYvouWT7kw1SBmx61GlPjCN2YblUgykiYxSQ+LSbM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEws0V9wugNItJqyKF75evXxbc2oiNpFYvXO3b5HYcD2mdkON7Fhxl567wB+bEoMqA5odppAv1dKLRxeuWGdk/7jhpJxJYKCl43XyGc11la5/parbpuQuBpcavs1kPXPta19VWspYxCpxIm+tONh1gyUs3ikEDrSruPIfcjBPQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZaGRlatA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=zM9fKz5MJ1t7OEbVMi3Fdh2y0NYfPlc0oZSSZJHBOts=; b=ZaGRlatADh59XBHPFmWuexX7+e
	seQ6WV1KYP3Y9JobuYrq/Z3ko62uRfqxpsWXnSdLneti12ZKJsfH+eJ3/Yn7uFzb20ySgcT4c76aZ
	tWo0gKlee3JqHoLi4TLsTkmUxXKlDh6O934KCWhHl2XJeTgbFQXewT0sL6E8SH6BSZNV0zUw7f7yY
	0kYoJw4D+p8AlRB5flUeb1/LHn3HaeCJ6N4O/LPwOagoYE512tpU9FSbI9EruTPLMfPgimpZ7+grX
	Qz6tYjaEppNNHFl9fYpfUCiEsDjy3T8zsTdS9Hn53gTrsBHNU2KkADnXLUMFeWzOgg9VZiO0dY07k
	KMHjFAzQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBpxG-00000000yjp-0ceI;
	Fri, 15 Nov 2024 06:37:17 +0000
Message-ID: <ea59021e-2c52-435c-8de4-34e00edb40c7@infradead.org>
Date: Thu, 14 Nov 2024 22:37:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] jffs2: Use str_yes_no() helper function
To: Thorsten Blum <thorsten.blum@linux.dev>,
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241112183113.173127-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241112183113.173127-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/24 10:31 AM, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_yes_no() helper function.
> 
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  fs/jffs2/nodemgmt.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

