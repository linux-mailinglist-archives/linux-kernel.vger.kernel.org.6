Return-Path: <linux-kernel+bounces-267639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A822F9413CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9631F249E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A4F1A0B1D;
	Tue, 30 Jul 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WL4qwUno"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6F19D8A6;
	Tue, 30 Jul 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347993; cv=none; b=q0mUHBCjCMhtnscwM6shBLKEnTo4Re68GNnUBEl4IlM3wdXiFec/Ryb+NMHWGkn9j5VfxF3Te4YIkv1WIIrtzpCSrANiWupcAzrtsO3SZ+dAX4Fdt6NfPtX020W7T9Trn4M7TD+wfllTd7Mq7pKAdwXgk22IaD1nw32S35tSU60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347993; c=relaxed/simple;
	bh=lhdJxGT/7iHPhCzTlI1tTTQlHnBYGpcs0h1rQWNYRjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYijW5hUiElQnYsHyT2Q2VyfAhONrxxq+Zpei5QXI2g1It90o5nHTW5Mx798PjB86gULnchJchHdy+1pW8jwn4YZfaNHoHMSAByPnL8vf2VloBfjcUBq467Od2ubRMXqxleJe2UsuWrvKcqzUvpUd2IOoSb+BHZQVnndWq7zeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WL4qwUno; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=xsQfyQqHKHTVh+qWomrR4QIlWnZRreWhqe+z8SRGvFg=; b=WL4qwUnonbWMe2DvRKhKcSs//7
	fG4uBJP3K7nAaAR49yraO0fJmBl0K3n89W2xOpmvT/4vCI7KV46gcyupNDMQF8y7mA/KR4gTjY/Wy
	fEnaNzyf5wmf53f9Kd1xn8MyvmIjv2Hsm45j5e1pUQLlxmZb/BQBDqWQ6oXA6COlKyA6QPPsKRLNF
	eMH3tKkT3Pi9eCimUu/Yhjsgkel8nRcfEZxAYlUWd6HIU6EUxSJn8z+c73FnnbynrsqYSWflFnr67
	pTtXrh1K/rh+Lz27dKJ+PoY2RVGI+WpmDTmqPgoASRInWfYUWMeWsKpAv/+p+wpZXg4UBRpqIFX3N
	HgMEaNnA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYnOB-0000000FMxE-3rxT;
	Tue, 30 Jul 2024 13:59:43 +0000
Message-ID: <83aa31ab-d0a8-4375-aacc-75bdb8d0c0e0@infradead.org>
Date: Tue, 30 Jul 2024 06:59:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mm: split underutilized THPs
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, david@redhat.com,
 baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
 <20240730125346.1580150-7-usamaarif642@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240730125346.1580150-7-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 5:46 AM, Usama Arif wrote:
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 058485daf186..24eec1c03ad8 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -447,6 +447,12 @@ thp_deferred_split_page
>  	splitting it would free up some memory. Pages on split queue are
>  	going to be split under memory pressure.
>  
> +thp_underutilized_split_page
> +	is incremented when a huge page on the split queue was split
> +	because it was underutilized. A THP is underutilized if the
> +	number of zero pages in the THP are above a certain threshold

	                     in the THP is above

(if the number ... is)

> +	(/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none).
> +

-- 
~Randy

