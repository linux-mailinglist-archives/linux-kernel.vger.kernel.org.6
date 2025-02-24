Return-Path: <linux-kernel+bounces-528468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985EAA417FC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7111721BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADB724290F;
	Mon, 24 Feb 2025 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ou+OCzDt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/RqsmHqO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88B18A6D7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387588; cv=none; b=oknn0l4AKKYglUK21PuVR/pyMz77osrdZcphaZemnRJBf4lKX3HXcHzR0+yzoyWG3lf0oWNni7pJZr7Tr/khGQGX31y58ihA/G6EXZktplmmW05MN56HqmDMWb/c93R2WKCF8U812jhAdNjs9Lq4IZnnDA/aP5LSQPRJR8Vv7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387588; c=relaxed/simple;
	bh=UDTAD2CKvpJyJvr8CfAf7bz+UdpH2sFSrfCw70E5zSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFq8jYHmBKjvAARy9rOzhaMmBz314/c7/qM8KhC5AxfnPhMLyQDN5muMJd85pFwabWbBeOVTzBywDcwKWE7AVVApq6IvXAPlJdrXP3sL6Tvm6SisM8iPBhslqIkQJgmwAlb3I6tUG/SIrlE8fdSXxTHZx5+cjf0cZIm6n4jugMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ou+OCzDt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/RqsmHqO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Feb 2025 09:59:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740387584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELrdWh+oiwPySUmNrNaw3uaqbpSpzCG+QNVPa7a0NZY=;
	b=Ou+OCzDtQy/UJN3MlgDXH8vRE9gtAa0/4VaNdpcnVt3mMkPqKD+6q5mG9WsHVHGiCE0sR+
	LILy5jG/HP5lkomfk+V3ACESDlTUD2hX2EguIeSdQvlaWMvbqH43+esckOdkvncptcYLHT
	DwZ7GuuUaiylAyUa/DVAcZL+59JwFNROR/QVf90DpRyOc9rr3/MXmwc7syoUJUntHY6CS6
	HkQ0j/6sRJh59gvbWIZHHeqGGK5rMw+U+QClB71GLRQegILWF7aEHopH+3UamXMz936x/o
	Nf4DeRaheJnIpRVgPvTbkRIXdMiQLMp8i6G3dcoyDDM19RMT9tJ4Mu//OUGR3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740387585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ELrdWh+oiwPySUmNrNaw3uaqbpSpzCG+QNVPa7a0NZY=;
	b=/RqsmHqOrnkO2FAsERItdJNt5aGWeTughO42MhQRLWMQv9RlgKCwZJRbF5mcnHKQL2k+CH
	Czrcr+sAieaSLFAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/17] zsmalloc: make zspage lock preemptible
Message-ID: <20250224085943.gChnQpEB@linutronix.de>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-12-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221222958.2225035-12-senozhatsky@chromium.org>

On 2025-02-22 07:25:42 [+0900], Sergey Senozhatsky wrote:
> index 1424ee73cbb5..03710d71d022 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -226,6 +226,9 @@ struct zs_pool {
>  	/* protect zspage migration/compaction */
>  	rwlock_t lock;
>  	atomic_t compaction_in_progress;
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lock_class_key lock_class;
> +#endif
No ifdef

>  };
>  
>  static inline void zpdesc_set_first(struct zpdesc *zpdesc)
> @@ -279,6 +294,93 @@ struct mapping_area {
>  	enum zs_mapmode vm_mm; /* mapping mode */
>  };
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +#define zsl_dep_map(zsl) (&(zsl)->dep_map)
> +#define zspool_lock_class(pool) (&(pool)->lock_class)
> +#else
> +#define zsl_dep_map(zsl) NULL
> +#define zspool_lock_class(pool) NULL
> +#endif
> +
> +static void zspage_lock_init(struct zspage *zspage)
> +{
> +	struct zspage_lock *zsl = &zspage->zsl;
> +
> +	lockdep_init_map(zsl_dep_map(zsl), "zspage->lock",
> +			 zspool_lock_class(zspage->pool), 0);
> +	spin_lock_init(&zsl->lock);
> +	zsl->cnt = ZS_PAGE_UNLOCKED;
> +}
> +
> +/*
> + * The zspage lock can be held from atomic contexts, but it needs to remain
> + * preemptible when held for reading because it remains held outside of those
> + * atomic contexts, otherwise we unnecessarily lose preemptibility.
> + *
> + * To achieve this, the following rules are enforced on readers and writers:
> + *
> + * - Writers are blocked by both writers and readers, while readers are only
> + *   blocked by writers (i.e. normal rwlock semantics).
> + *
> + * - Writers are always atomic (to allow readers to spin waiting for them).
> + *
> + * - Writers always use trylock (as the lock may be held be sleeping readers).
> + *
> + * - Readers may spin on the lock (as they can only wait for atomic writers).
> + *
> + * - Readers may sleep while holding the lock (as writes only use trylock).
> + */
> +static void zspage_read_lock(struct zspage *zspage)
> +{
> +	struct zspage_lock *zsl = &zspage->zsl;
> +
> +	rwsem_acquire_read(zsl_dep_map(zsl), 0, 0, _RET_IP_);
> +
> +	spin_lock(&zsl->lock);
> +	zsl->cnt++;
> +	spin_unlock(&zsl->lock);

How is this working given that a read_lock always increments the
counter? If it is write_locked then a read_lock makes it UNLOCKED.

migrate_read_lock() did block if a writer was pending, this does not or
at least it is not obvious how. 

> +	lock_acquired(zsl_dep_map(zsl), _RET_IP_);
> +}
> +

Sebastian

