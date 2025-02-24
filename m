Return-Path: <linux-kernel+bounces-528389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A8A4172F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D651895F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0411C84D0;
	Mon, 24 Feb 2025 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BllI6CKN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hxL6KaR9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C018C337
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385201; cv=none; b=cNgu31zVcS4zdu0esWYzqJAplAQ4NQbQ350MdRW31Od+BEOQJhY0S2gR8WiTbotqNyIBZOfO1OkEwxxSPDDD4yRHjoH5LJqpkNRK0p0LcVQjIwx9XOJX15+k/lnxjcueoCzXlECRu28XUyMplyUvXvqxpRj8giuBVYDd1+TO03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385201; c=relaxed/simple;
	bh=aPBmcWzxRZ793+P17lZYUhIEtRt1ahNijA11PsDEAbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KW/Vq8SHGChRo2cTqUy+5Pi4NUpG+X7q/Y+KPw3CwCIt4H/xMKDfIDnfhQj+gGJ3jBewAMQ/ylpOAtupENicj3AoQ7aI16mLCpZWtAxmdE2+dF0tT2xDg4OC3iDRatp3SVNxofUKsv6rszIrOjOc5kxCBbMFBTjQ1ECAi+tEBJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BllI6CKN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hxL6KaR9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Feb 2025 09:19:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740385197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9b6JI1PAYyIfk1s7vLaQh6uto3DYX7c5B+kYCp5fkFk=;
	b=BllI6CKNnuo6xYkmJqFOsIkmEJBxivlt8tjDn5uFY+6g134dkoSaguOBHNnAxowunfWhBE
	aXFnPZc0evUNstXD3Fd5T45Rgoqk24MOzlRTjiOfLawj1tguU9U0ltbNOZXOoJJyleAjn4
	Su/yTOFoJRLTfho8iLKwOVuKJv+aQRTdzuTPu5nSAbpt/FivLo4sRR8uTxRk4H1AwpbR+W
	W2ip5t0b7EVmxIaky9mPDZUtHesrTKGbeRkrA+JfNSpb9+XtRuc2uFqyLjcI8aub3eJ/SR
	XrEgWVMWHsCnA3g40ikMm8uAUt4zmyVuauBnQMbyZfYuaps/RJ3sG3kNXjuarQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740385197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9b6JI1PAYyIfk1s7vLaQh6uto3DYX7c5B+kYCp5fkFk=;
	b=hxL6KaR9KJV4d90jn/TKI1wfgV8r0ZUB+HQv6e1PgA5wrDKroIBz05Ju6ojvT3XNPY6Xag
	GbzWlV2BumnsSQAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/17] zram: sleepable entry locking
Message-ID: <20250224081956.knanS8L_@linutronix.de>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-2-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250221222958.2225035-2-senozhatsky@chromium.org>

On 2025-02-22 07:25:32 [+0900], Sergey Senozhatsky wrote:
=E2=80=A6
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 9f5020b077c5..37c5651305c2 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -58,19 +58,62 @@ static void zram_free_page(struct zram *zram, size_t =
index);
>  static int zram_read_from_zspool(struct zram *zram, struct page *page,
>  				 u32 index);
> =20
> -static int zram_slot_trylock(struct zram *zram, u32 index)
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +#define slot_dep_map(zram, index) (&(zram)->table[(index)].dep_map)
> +#define zram_lock_class(zram) (&(zram)->lock_class)
> +#else
> +#define slot_dep_map(zram, index) NULL
> +#define zram_lock_class(zram) NULL
> +#endif

That CONFIG_DEBUG_LOCK_ALLOC here is not needed because dep_map as well
as lock_class goes away in !CONFIG_DEBUG_LOCK_ALLOC case.

> +static void zram_slot_lock_init(struct zram *zram, u32 index)
>  {
> -	return spin_trylock(&zram->table[index].lock);
> +	lockdep_init_map(slot_dep_map(zram, index),
> +			 "zram->table[index].lock",
> +			 zram_lock_class(zram), 0);
> +}
Why do need zram_lock_class and slot_dep_map? As far as I can tell, you
init both in the same place and you acquire both in the same place.
Therefore it looks like you tell lockdep that you acquire two locks
while it would be enough to do it with one.

> +/*
> + * entry locking rules:
> + *
> + * 1) Lock is exclusive
> + *
> + * 2) lock() function can sleep waiting for the lock
> + *
> + * 3) Lock owner can sleep
> + *
> + * 4) Use TRY lock variant when in atomic context
> + *    - must check return value and handle locking failers
> + */
> +static __must_check bool zram_slot_trylock(struct zram *zram, u32 index)
> +{
> +	unsigned long *lock =3D &zram->table[index].flags;
> +
> +	if (!test_and_set_bit_lock(ZRAM_ENTRY_LOCK, lock)) {
> +		mutex_acquire(slot_dep_map(zram, index), 0, 1, _RET_IP_);
> +		lock_acquired(slot_dep_map(zram, index), _RET_IP_);
> +		return true;
> +	}
> +
> +	lock_contended(slot_dep_map(zram, index), _RET_IP_);
> +	return false;
>  }
> =20
>  static void zram_slot_lock(struct zram *zram, u32 index)
>  {
> -	spin_lock(&zram->table[index].lock);
> +	unsigned long *lock =3D &zram->table[index].flags;
> +
> +	mutex_acquire(slot_dep_map(zram, index), 0, 0, _RET_IP_);
> +	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
> +	lock_acquired(slot_dep_map(zram, index), _RET_IP_);

This looks odd. The first mutex_acquire() can be invoked twice by two
threads, right? The first thread gets both (mutex_acquire() and
lock_acquired()) while, the second gets mutex_acquire() and blocks on
wait_on_bit_lock()).

>  }
> =20
>  static void zram_slot_unlock(struct zram *zram, u32 index)
>  {
> -	spin_unlock(&zram->table[index].lock);
> +	unsigned long *lock =3D &zram->table[index].flags;
> +
> +	mutex_release(slot_dep_map(zram, index), _RET_IP_);
> +	clear_and_wake_up_bit(ZRAM_ENTRY_LOCK, lock);
>  }
> =20
>  static inline bool init_done(struct zram *zram)
=E2=80=A6
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index db78d7c01b9a..794c9234e627 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -58,13 +58,18 @@ enum zram_pageflags {
>  	__NR_ZRAM_PAGEFLAGS,
>  };
> =20
> -/*-- Data structures */
> -
> -/* Allocated for each disk page */
> +/*
> + * Allocated for each disk page.  We use bit-lock (ZRAM_ENTRY_LOCK bit
> + * of flags) to save memory.  There can be plenty of entries and standard
> + * locking primitives (e.g. mutex) will significantly increase sizeof()
> + * of each entry and hence of the meta table.
> + */
>  struct zram_table_entry {
>  	unsigned long handle;
> -	unsigned int flags;
> -	spinlock_t lock;
> +	unsigned long flags;
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lockdep_map dep_map;
> +#endif
>  #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
>  	ktime_t ac_time;
>  #endif
> @@ -137,5 +142,8 @@ struct zram {
>  	struct dentry *debugfs_dir;
>  #endif
>  	atomic_t pp_in_progress;
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lock_class_key lock_class;
> +#endif
As mentioned earlier, no need for CONFIG_DEBUG_LOCK_ALLOC.

>  };
>  #endif
> --=20
> 2.48.1.601.g30ceb7b040-goog
>=20

