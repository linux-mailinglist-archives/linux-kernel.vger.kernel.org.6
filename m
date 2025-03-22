Return-Path: <linux-kernel+bounces-572581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B455AA6CBCE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 19:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169C93B2DE2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AAA1A0B15;
	Sat, 22 Mar 2025 18:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="BlTEPn2Q"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1B13C695
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742668268; cv=pass; b=Ti53/VAgLnKa7j/7u0SX9or8QqKb3aOdDFegyQTXowVz1jAO/iTznm77vf0Gyg0HB9/NrSU4zd1ut+PB9i4/TRkazvyWabzE9NGWdEbRU3TQZxhfJOZ45Zp6BbB5FKYwZyPLQ4J8ywdHPL0DldUgw4HygHYyPIc/KZDiZSY9Rr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742668268; c=relaxed/simple;
	bh=P19WB1RsvtsR2BRs70uIR1rI+OkfiekUANJDZU46X70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na7kh+DrTD67alTU8ZoOdqdXX65Z8sqBagCFnGy/lu12lBmRCryp409ddHDposD+nQWyERVHZCOt7g6v25RJMCtFEGmMglCd2g/Ff7aJcOSQQVX70ZjXqWtzq0+1hvPJp/mfUOtYSe4CQTeLUWC6O/5dJroG8il38nXokKwAEKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=BlTEPn2Q; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742668224; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JzTCSNHHLPywezjRAd1z0IvAt6354yVhCUSvK6SMMua83Q2ibwz/AcyaQNETiy47Zf0Z989t9hO3u5d5DaGjupRiEWzEfmu8u5qa04knfaq8QGCY1nm28LmP0QSpQjMMRTzN3lkoFUAii6W/popLm1G19v3LF0yvKyPaXcN/Gf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742668224; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7QIHF3NjHt3xn4pZK4qJww9kq+qlDqM7MmGL3/fOx8M=; 
	b=VRDPM/3DQZGeLqXtaJ5RTLrBUxZ5LQhKEycR0nP5bKxHPkxIAyRO1EwtuSGzXJhzsnw8L5/6PoaOejZ3am0YCAd0W7R7At5qlmULsKWhaptE3s7Q0b9SutQmmKWLqF2oAPmymm8DKMEb7LD8gL0F2yWT0hwLg/unifu9bKh+UwU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742668224;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=7QIHF3NjHt3xn4pZK4qJww9kq+qlDqM7MmGL3/fOx8M=;
	b=BlTEPn2Q2kfEk9Jw+oEZMH5XEjKGoZBlRkTUy9MftNTykd1tQomiKTHqu6V+0srQ
	xYnnI3feVQ7sh3r0VyvjGsnYmpvuThjcilDzdEX/CrmX1MbpmvDKLGgvZvIZebLTNhx
	mNrpdsPgk5XKxiECWAofPTlKdMarv9ZEbLT01N+U=
Received: by mx.zohomail.com with SMTPS id 1742668222927774.9008803686191;
	Sat, 22 Mar 2025 11:30:22 -0700 (PDT)
Date: Sat, 22 Mar 2025 18:30:13 +0000
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, kernel@collabora.com, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com, angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 1/6] drm/panfrost: Set IOMMU_CACHE flag
Message-ID: <7qixyvz7ll7sk53vqys74kncf6advxcuctfymmve7msygekygg@vwxzowjwm5bz>
References: <20250317145245.910566-1-ariel.dalessandro@collabora.com>
 <20250317145245.910566-2-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317145245.910566-2-ariel.dalessandro@collabora.com>

On 17.03.2025 11:52, Ariel D'Alessandro wrote:
> Panfrost does not support uncached mappings, so flag them properly. Also
> flag the pages that are mapped as response to a page fault as cached.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index b91019cd5acb1..9e6f198ef5c1b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -327,7 +327,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
>  	struct drm_gem_object *obj = &shmem->base;
>  	struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
>  	struct sg_table *sgt;
> -	int prot = IOMMU_READ | IOMMU_WRITE;
> +	int prot = IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE;
>
>  	if (WARN_ON(mapping->active))
>  		return 0;
> @@ -528,7 +528,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>  		goto err_map;
>
>  	mmu_map_sg(pfdev, bomapping->mmu, addr,
> -		   IOMMU_WRITE | IOMMU_READ | IOMMU_NOEXEC, sgt);
> +		   IOMMU_WRITE | IOMMU_READ | IOMMU_CACHE | IOMMU_NOEXEC, sgt);
>
>  	bomapping->active = true;
>  	bo->heap_rss_size += SZ_2M;
> --
> 2.47.2


Adrian Larumbe

