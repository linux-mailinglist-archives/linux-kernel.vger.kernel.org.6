Return-Path: <linux-kernel+bounces-436233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A49E82F3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 01:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C03165A39
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 00:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6212E5258;
	Sun,  8 Dec 2024 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qxMy/8+f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x51RJgpr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273D1C01
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733618157; cv=none; b=rxUwLo7iME8PAqE1xSAlZ3hNuF9zSvx0b7oMb9F50p2D6P+/CQqX27KLz7aJ0MvYq5QwVVJHhpF+CFoTQUS3LgJeOTulWYC7EPS1QaMK1+tXuogLPJ/BUe5UA8+2pKGsGSKAeu9jGz7sj+P+apNlSv7Qggq6GUXiZh0GezwVV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733618157; c=relaxed/simple;
	bh=6yomLdtsHzMq9gssNWJztL6vEE0CiJWFLDP9GWuIVAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilJ5axU1aqQzrI2yVwXPjbBayVwYsaIk0GonRkQ99W/hmKVRVhdYcH2ykDBE7YPZrWNt/58ZFrwUSfjFON2K2FGbd1kGFScC3ArLYhSaquqHEvRjuvXz0SNm/61+8dreEdJNiNCKmQCLH/gsT8ym0bxC00Teprr+W7myDVNFOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qxMy/8+f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x51RJgpr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 8 Dec 2024 07:35:23 +0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733618146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQSDHmZlOf90U5CrXTl/6j/p+tmRLqohyZBHy+85kAI=;
	b=qxMy/8+fV0epzUv08Xqt7R9FAmLkCHMdmkSBdYJBEPwvkzTO10RPbSkvNI0cwtzlHgvTDN
	xKg3jYS6zODxcabRdhbnJ3616JCdQ/YHA096g1BXPTVHj7HkcMldlPUCeQlQ9IFX4Lf0GV
	kkbkzaZw6TqkejCXcnuv5TxuoAitGAN9XeDkEkFWaqP8oI2PI4unCqnSXD32hTYIk0zD/C
	24eHY/iy/MARCHM7BHr8OH0EuHUrzw9eQDfMeI0w3mh11CHUB/b90sUzVC2CiUdj5kl+9C
	V8mEoMT/gZq+xMPr8xyjGZG9DVNMlPCLANYTKDUqoQvB+z+NGtx757GTtqkVPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733618146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQSDHmZlOf90U5CrXTl/6j/p+tmRLqohyZBHy+85kAI=;
	b=x51RJgprGTH765aqhrjAhtUv1MZ9IXa0GXdafEIMkY6SwEAKjHkjhWlvm8tFJKfB+xLqEE
	oI+UoIcTO/alzzCw==
From: Nam Cao <namcao@linutronix.de>
To: guoren@kernel.org
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, bjorn@rivosinc.com,
	conor@kernel.org, leobras@redhat.com, peterz@infradead.org,
	parri.andrea@gmail.com, will@kernel.org, longman@redhat.com,
	boqun.feng@gmail.com, arnd@arndb.de, alexghiti@rivosinc.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [RESEND PATCH] riscv: Fixup boot failure when
 CONFIG_DEBUG_RT_MUTEXES=y
Message-ID: <20241208003523.4zAbPMzd@linutronix.de>
References: <20241130153310.3349484-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130153310.3349484-1-guoren@kernel.org>

On Sat, Nov 30, 2024 at 10:33:10AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When CONFIG_DEBUG_RT_MUTEXES=y, mutex_lock->rt_mutex_try_acquire
> would change from rt_mutex_cmpxchg_acquire to
> rt_mutex_slowtrylock():
> 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
> 	ret = __rt_mutex_slowtrylock(lock);
> 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
> 
> Because queued_spin_#ops to ticket_#ops is changed one by one by
> jump_label, raw_spin_lock/unlock would cause a deadlock during the
> changing.
> 
> That means in arch/riscv/kernel/jump_label.c:
> 1.
> arch_jump_label_transform_queue() ->
> mutex_lock(&text_mutex); +-> raw_spin_lock  -> queued_spin_lock
> 			 |-> raw_spin_unlock -> queued_spin_unlock
> patch_insn_write -> change the raw_spin_lock to ticket_lock
> mutex_unlock(&text_mutex);
> ...
> 
> 2. /* Dirty the lock value */
> arch_jump_label_transform_queue() ->
> mutex_lock(&text_mutex); +-> raw_spin_lock -> *ticket_lock*
>                          |-> raw_spin_unlock -> *queued_spin_unlock*
> 			  /* BUG: ticket_lock with queued_spin_unlock */
> patch_insn_write  ->  change the raw_spin_unlock to ticket_unlock
> mutex_unlock(&text_mutex);
> ...
> 
> 3. /* Dead lock */
> arch_jump_label_transform_queue() ->
> mutex_lock(&text_mutex); +-> raw_spin_lock -> ticket_lock /* deadlock! */
>                          |-> raw_spin_unlock -> ticket_unlock
> patch_insn_write -> change other raw_spin_#op -> ticket_#op
> mutex_unlock(&text_mutex);
> 
> So, the solution is to disable mutex usage of
> arch_jump_label_transform_queue() during early_boot_irqs_disabled, just
> like we have done for stop_machine.
> 
> Reported-by: Conor Dooley <conor@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Fixes: ab83647fadae ("riscv: Add qspinlock support")
> Link: https://lore.kernel.org/linux-riscv/CAJF2gTQwYTGinBmCSgVUoPv0_q4EPt_+WiyfUA1HViAKgUzxAg@mail.gmail.com/T/#mf488e6347817fca03bb93a7d34df33d8615b3775
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>

Tested-by: Nam Cao <namcao@linutronix.de>

Thanks for the fix,
Nam

