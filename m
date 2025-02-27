Return-Path: <linux-kernel+bounces-536212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB483A47CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B653AFE64
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD671991CD;
	Thu, 27 Feb 2025 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pChr+Dlg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5yfdr6jI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C0B270020
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657937; cv=none; b=YJFxB9NfjHR3YUZlwMeObXgtzzL1YArWCaAkjfVpQ3GjfM873Z7F/b76aFmaw/q7C5V4okpBlyih5KyZoi3BYQbJ/d74CnjPPGqw2kT8SsC6Ek/DBDiZW1d+yjcll86Hi9Domu81bUPcx3P5VvlQUk5IMTpdDfejrjuzai4aO24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657937; c=relaxed/simple;
	bh=isq8NhtrT/oNmIpFnM35LYijqZ8N6e7JhUmGqcnl9Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciGL78n3bRuq6f+RrN5wU0kEVzhTvWnXSW/gy0dQLddQ6nSchT9UpMmpOe0ZJKRmTqfydEQq2lcuMedgUi4VMDhN17GeEZkUvAam8/H0XVI4t+G0eU7m7iJo3Ksa9S253b4PtPCtiFYyxL7rkUVUcolZork13dSkdT8dgLu+YVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pChr+Dlg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5yfdr6jI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 13:05:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740657934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgpeASaw3foJsIkn7/JOj3RC9lzZoTbMn9rZNSif0zU=;
	b=pChr+DlgAb76BJa81EjYlLMMdyZCRXaBTw7hOWGGc8O4fJgwndNT6jKrTI5A3abMRvaspU
	xN293YQHK5bpERucSTKTuV16tUh+Ajn3roDZTmtdNrPl0YsuICGQnw3DEvjb8hDK43g3zD
	BrUi0HobaXmlqX1/978VRJ8xpNQYqkeUUMMT6PonsgbcEhI943kjT7cL1qz+tycSqTazw3
	DmmsQmaqYszjXBXoZHzMtDDyR65/Sc+MG6YaMc5Zr9ZlAOKCEuazel/0WLs1C7Hpw4Vrsx
	eDQ660is/b58laNJL6siozoaIFsT3szkZXlMp/oyibtl4IFVvcdLePkHhanH2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740657934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VgpeASaw3foJsIkn7/JOj3RC9lzZoTbMn9rZNSif0zU=;
	b=5yfdr6jI/Pd+03S//vazmRT6JL/Odq5LRfHjxJSy2DpUkWInboEXPPd5IRYc7OVVGHGQ+F
	0b7vuFFx3tKQ7sDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/17] zram: sleepable entry locking
Message-ID: <20250227120532.OsZr4v2A@linutronix.de>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-2-senozhatsky@chromium.org>
 <20250224081956.knanS8L_@linutronix.de>
 <i2kgeeehfwzwo22vazakcq4at2m223nebb2xfrqfvsgawpmqya@zjhqhjshvhi3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <i2kgeeehfwzwo22vazakcq4at2m223nebb2xfrqfvsgawpmqya@zjhqhjshvhi3>

On 2025-02-25 13:51:31 [+0900], Sergey Senozhatsky wrote:
> > > +static void zram_slot_lock_init(struct zram *zram, u32 index)
> > >  {
> > > -	return spin_trylock(&zram->table[index].lock);
> > > +	lockdep_init_map(slot_dep_map(zram, index),
> > > +			 "zram->table[index].lock",
> > > +			 zram_lock_class(zram), 0);
> > > +}
> > Why do need zram_lock_class and slot_dep_map? As far as I can tell, you
> > init both in the same place and you acquire both in the same place.
> > Therefore it looks like you tell lockdep that you acquire two locks
> > while it would be enough to do it with one.
> 
> Sorry, I'm not that familiar with lockdep, can you elaborate?
> I don't think we can pass NULL as lock-class to lockdep_init_map(),
> this should trigger `if (DEBUG_LOCKS_WARN_ON(!key))` as far as I
> can tell.  I guess it's something else that you are suggesting?

ach. Got it. What about

| static void zram_slot_lock_init(struct zram *zram, u32 index)
| {
| 	static struct lock_class_key __key;
| 
| 	lockdep_init_map(slot_dep_map(zram, index),
| 			 "zram->table[index].lock",
| 			 &__key, 0);
| }

So every lock coming from zram belongs to the same class. Otherwise each
lock coming from zram_slot_lock_init() would belong to a different class
and for lockdep it would look like they are different locks. But they
are used always in the same way.

> > >  static void zram_slot_lock(struct zram *zram, u32 index)
> > >  {
> > > -	spin_lock(&zram->table[index].lock);
> > > +	unsigned long *lock = &zram->table[index].flags;
> > > +
> > > +	mutex_acquire(slot_dep_map(zram, index), 0, 0, _RET_IP_);
> > > +	wait_on_bit_lock(lock, ZRAM_ENTRY_LOCK, TASK_UNINTERRUPTIBLE);
> > > +	lock_acquired(slot_dep_map(zram, index), _RET_IP_);
> > 
> > This looks odd. The first mutex_acquire() can be invoked twice by two
> > threads, right? The first thread gets both (mutex_acquire() and
> > lock_acquired()) while, the second gets mutex_acquire() and blocks on
> > wait_on_bit_lock()).
> 
> Hmm why is this a problem?  ... and I'm pretty sure it was you who
> suggested to put mutex_acquire() before wait_on_bit_lock() [1] ;)

Sure. I was confused that you issue it twice. I didn't noticed the d in
lock_acquired(). So you have one for lockdep and one for lockstat. That
is okay ;)

Sebastian

