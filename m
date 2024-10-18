Return-Path: <linux-kernel+bounces-371958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364199A4296
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A56F1C21733
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF7B202F79;
	Fri, 18 Oct 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="e2V3VSDj"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1531B20264A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265766; cv=pass; b=IHAMCdwSm8bkcNF31Ipxry2a2IrOlaxWixS9clQ9w0u+Kxjc3VbguWzHASv/HTljS9eNKTCVrYieES/YqtUIuRbPXZtHBJCcuX60IKK4FfUmwJkm9rA5u32/MJyuxZYCBsZj3GUNLaPBaDFLOiUL1oKuIro9BLPe48RXEq0xSHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265766; c=relaxed/simple;
	bh=TTjgERT1j7zRCds3Wd71jv3rrWVnzNhHRuptk9kOdl8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S75GvgAHHQie50/y4l0xwvxTAlgSoIWfdDtybbLdzdXg4YOrY/BBA7DVyS7PO8y8AdqhFTCIhr9jafjoNtZ7MhSZZ6k9n+90HtZStwRnCZ9mVeFALGW7nAk7qigZwvb53cKyjzJsqVsFayAmHHukS01FQaUSZOQqSJg2cZbR3Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=e2V3VSDj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729265745; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aQyQBusFZIb/ZEXLjysjnvx7xcIDBH50NCc1SsJEGFaAioommL7NodDrKczj69qoBNd8TNl7LdWu2fC0L3GEmA9qLsefL17TDpky1pYads7aAXvmFNeiIFjYc/QeYPtok/uhQgSKJPMpKIb2TZbMu9cUVLrlj7iq7FCmoxpbAGA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729265745; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vK9cq2ZngeWSVzdJsao8iPFTL4bdq6eIbds0MpoMbKg=; 
	b=oLaTCpSIMW/tdCEoU7N37PGfEBZRsWsIAuJYMYZud6VtiRnYWiGaX4uSZTL2AhbM0/Tqo4AU1vD2vJ4PAhMGfIKjLX/uuflJ7fX3zoD8An2U92JEafBmVTxV9qsZTpYwn65M4sJSqMRP7OQO+G69xC37qJIHJl/tdm9QK5yho5Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729265745;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vK9cq2ZngeWSVzdJsao8iPFTL4bdq6eIbds0MpoMbKg=;
	b=e2V3VSDjtBuWtnNtw91z0m01AQIseK9DsrhlMxh/ax5yRvguCqFRzjAOX3SU5nCP
	72mctSYqOCXUTJttNPp/ofYs/rlsHudFU5nbEz635T6OesdfcrcHOrTYngkNgDmA891
	7X46TKdief8py4ucNy5CM2ZJ4maoQ0hIY2ojBTuQ=
Received: by mx.zohomail.com with SMTPS id 1729265744087820.2806321613441;
	Fri, 18 Oct 2024 08:35:44 -0700 (PDT)
Message-ID: <58eba1ba-c943-4a16-8706-8efde7ee7eb2@collabora.com>
Date: Fri, 18 Oct 2024 20:35:35 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH] mm: Remove unused has_isolate_pageblock
To: Luoxi Li <kaixa@kiloview.com>, linux-mm@kvack.org
References: <20241018092235.2764859-1-kaixa@kiloview.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241018092235.2764859-1-kaixa@kiloview.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/18/24 2:22 PM, Luoxi Li wrote:
> has_isolate_pageblock() has been unused since commit 55612e80e722
> ("mm: page_alloc: close migratetype race between freeing and stealing")
> 
> Remove it.
> 
> Signed-off-by: Luoxi Li <kaixa@kiloview.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  include/linux/page-isolation.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
> index c16db0067090..73dc2c1841ec 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -3,10 +3,6 @@
>  #define __LINUX_PAGEISOLATION_H
>  
>  #ifdef CONFIG_MEMORY_ISOLATION
> -static inline bool has_isolate_pageblock(struct zone *zone)
> -{
> -	return zone->nr_isolate_pageblock;
> -}
>  static inline bool is_migrate_isolate_page(struct page *page)
>  {
>  	return get_pageblock_migratetype(page) == MIGRATE_ISOLATE;
> @@ -16,10 +12,6 @@ static inline bool is_migrate_isolate(int migratetype)
>  	return migratetype == MIGRATE_ISOLATE;
>  }
>  #else
> -static inline bool has_isolate_pageblock(struct zone *zone)
> -{
> -	return false;
> -}
>  static inline bool is_migrate_isolate_page(struct page *page)
>  {
>  	return false;

-- 
BR,
Muhammad Usama Anjum


