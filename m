Return-Path: <linux-kernel+bounces-536363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E9A47EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62926188C9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5585B22FAD3;
	Thu, 27 Feb 2025 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SnADxcBo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vYuxsd95"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4810D22F166
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661979; cv=none; b=KkNek7ll0ZrKXSla6yUnvbc0lf/4MXQwZtdRxVDQUthiQWFHkxk5udcFrbpEMh/aypojQo7Bbf6022mqdGdbEc1vi29MeZNmfDbtFhpOK1PRo9MnBQ2AanHCscEKuyjjmFuL1rt373C1D7w3suWD/t+84UBO+7fHWgqAWfHwNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661979; c=relaxed/simple;
	bh=br1ItqgpK4oPHlFfaRnp+bGo7K3fiD2/XoGsUMPrGQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWka9J+Ye0hodaHCAGnm4vHe8yd5IeDa/+sRaS+p+Hw8yuHEbfoZWKNDYuJjWfTMhQyxIGT9k5ooOxTB6mej7Dlae//F6kMMJWxdxUn/AJsIMbVrc8DQ+OKY2x02Zz0/0sdvNb/Ib/RgyPYUu3Wr9k9uIIDNzW3VUgahRvd+sUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SnADxcBo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vYuxsd95; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 14:12:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740661975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GrwCuKq+8QLlP1QccEafaU7GaW8/gXG12VivyEbamaY=;
	b=SnADxcBofw29tg4lHY4kuVt5aKk7dEZGDapbgJiCMLLqM4UPO51zUfOJhI18iIhcuQn4gm
	hUN340MV/4DEXB/SVypzPBrAhY1DaPn56bAM6XgZHCQYL4rTkeCIgXKVxyEeTocN3U1NxZ
	c1kgyo1WRjMXqZGDmwfUc9K5o2YzQ03nkZBe0CUis5bk7EX3TtQ3E//nYiPpJK0hp4uehL
	y7qncMKtdB1jTedOghjX3fvZtN1DjP3NSu5QK0NravTbfVJFMxd9RJKV4hTA6nESKaIHZ4
	JbRnwF5V5zH7aE75OphFKOecdmzBZ+lv6NKJjTaVb9aRnVaTptDBkTacHGuVRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740661975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GrwCuKq+8QLlP1QccEafaU7GaW8/gXG12VivyEbamaY=;
	b=vYuxsd95U5iuGkcDh2fQfQXprz7bIBPG7t9XgL1dsmHTM0u8wQod9hw7kkDtUS+zvk94Oj
	LBphlteTpSmO0WAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/17] zram: sleepable entry locking
Message-ID: <20250227131253.T_S_Icyt@linutronix.de>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-2-senozhatsky@chromium.org>
 <20250224081956.knanS8L_@linutronix.de>
 <i2kgeeehfwzwo22vazakcq4at2m223nebb2xfrqfvsgawpmqya@zjhqhjshvhi3>
 <20250227120532.OsZr4v2A@linutronix.de>
 <irpjhnu7utkhf4dds5ghklsbdug6nf32ulsp52ibvym6t3wqfg@pqu7w6uvgbvw>
 <mwpl64zfj4zlv5bwysfzryjpnh6lg5tridhya3t7ly2ax2vt7x@jhmdmh7gwrmn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mwpl64zfj4zlv5bwysfzryjpnh6lg5tridhya3t7ly2ax2vt7x@jhmdmh7gwrmn>

On 2025-02-27 22:04:16 [+0900], Sergey Senozhatsky wrote:
> On (25/02/27 21:42), Sergey Senozhatsky wrote:
> > > ach. Got it. What about
> > > 
> > > | static void zram_slot_lock_init(struct zram *zram, u32 index)
> > > | {
> > > | 	static struct lock_class_key __key;
> > > | 
> > > | 	lockdep_init_map(slot_dep_map(zram, index),
> > > | 			 "zram->table[index].lock",
> > > | 			 &__key, 0);
> > > | }
> > > 
> > > So every lock coming from zram belongs to the same class. Otherwise each
> > > lock coming from zram_slot_lock_init() would belong to a different class
> > > and for lockdep it would look like they are different locks. But they
> > > are used always in the same way.
> > 
> > I see.  I thought that they key was "shared" between zram meta table
> > entries because the key is per-zram device, which sort of made sense
> > (we can have different zram devices in a system - one swap, a bunch
> > mounted with various file-systems on them).

Yes. So usually you do spin_lock_init() and this creates a key at _this_
very position. So every lock initialized at this position shares the
same class/ the same pattern.

> So the lock class is registered dynamically for each zram device
> 
> zram_add()
> 	lockdep_register_key(&zram->lock_class);
> 
> and then we use that zram->lock_class to init zram->table entries.
> 
> We unregister the lock_class during each zram device destruction
> 
> zram_remove()
> 	lockdep_unregister_key(&zram->lock_class);
> 
> Does this still put zram->table entries into different lock classes?

You shouldn't need to register and unregister the lock_class. What you
do should match for instance j_trans_commit_map in fs/jbd2/journal.c or
__key in include/linux/rhashtable.h & lib/rhashtable.c.

At least based on my understanding so far.

Sebastian

