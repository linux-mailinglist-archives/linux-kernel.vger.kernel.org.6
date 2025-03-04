Return-Path: <linux-kernel+bounces-544549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0DBA4E28F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56FB881961
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C1620DD4C;
	Tue,  4 Mar 2025 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wKGCzoC/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TGyHv++q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574B2080E3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100322; cv=none; b=Bt3epNBL8xVsKQm2MmO78wj7drC3+JYElAP7o94Re+bvKKjrM3RJSxHObOL9/M2RkK8+QvEJ1R3WpfSoK9hXG04c2LgsJasin0nKTtpastN9DAxXa2Nt+HsuR9YlFbS0UXBEmzs37Z6OGfZmdODtccQQs2knJU0NBxF95xAJMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100322; c=relaxed/simple;
	bh=g2WQummvgm7z/KzihCuHyzo4A7wP35dg/zA1X0EGEK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m31Wg6n9uKDXqRFuk5GpvBFbVHhbKOEIm1GR0BG/Bjdk9Fjx6CjewkUb8JuZmgYqta4ifEtp1AeS8anRlM0Ouh+b79ZxQT4t8SpsvJFmi7yYd8wg0G1jl/O5vAEofAiRtGFv0et+RJPGh82XXnbeF7epvg5T2iRm0YsCNwUFx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wKGCzoC/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TGyHv++q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 4 Mar 2025 15:58:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741100319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cNAQCS4+kzR8Yg3DHNHimQfhzkBr+hE1muDTQw+QL8=;
	b=wKGCzoC/2fEvOpaZ82ieJIxdwSZGMTOVuCvbm9r6nzvj0ZmdtuA3Gh4ruzDYvLjJUgryXV
	Y1Ath/CTMXfjD+5U8wdsYlS02oePJBv+ecgwyGjBOyV9bE9jRDDM25upDv/hvxXGps9vR1
	itJ7jJ5END79rog/9czwOoT9huXyZP4jXgwugu6CPt5FxkNuXsmQ3fweQKPO2ZztN/J4AT
	739zcze7mrZC6NPWySuvpEKmflpsdMXUTV7ptdvchxJGFi5iIo1+DKrXnXWxy2Yj25vXpE
	unsrqIHPnHVIImwmsxs778xFw4pd6X/hmKY0HPeanfaUjoAaY1dzTonh65jowA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741100319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5cNAQCS4+kzR8Yg3DHNHimQfhzkBr+hE1muDTQw+QL8=;
	b=TGyHv++q2+hQOILE8WlVbui8L4yySKRRFuGScIh0hVxn/8/RtWCgYvkt4CfEpqwArj/jcK
	9JiCUqxG0t7kZwAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v9 00/11] futex: Add support task local hash maps.
Message-ID: <20250304145837.a8g07J-k@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
 <20250303105416.GY11590@noisy.programming.kicks-ass.net>
 <20250303141753.tF-FoCm1@linutronix.de>
 <20250303164015.HHfy1Ibj@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250303164015.HHfy1Ibj@linutronix.de>

On 2025-03-03 17:40:16 [+0100], To Peter Zijlstra wrote:
=E2=80=A6
> You avoided the two states by dropping refcount only there is no !new
> pointer. That should work.
=E2=80=A6
> My first few tests succeeded. And I have a few RCU annotations, which I
> post once I complete them and finish my requeue-pi tests.

get_futex_key() has this:
|=E2=80=A6
|         if (!fshared) {
|=E2=80=A6
|                 if (IS_ENABLED(CONFIG_MMU))
|                         key->private.mm =3D mm;
|                 else
|                         key->private.mm =3D NULL;
|
|                 key->private.address =3D address;
|

and now __futex_hash_private() has this:
| {
|         if (!futex_key_is_private(key))
|                 return NULL;
|
|         if (!fph)
|                 fph =3D rcu_dereference(key->private.mm->futex_phash);

Dereferencing mm won't work on !CONFIG_MMU. We could limit private hash
to !CONFIG_BASE_SMALL && CONFIG_MMU.

Ignoring this, I managed to crash the box on top of 49fd6b8f5d59
("futex: Implement FUTEX2_MPOL"). I had one commit on top to make the
prctl not blocking (make futex_hash_allocate(, false)). This is simulate
the fork resize. The backtrace:
| [   T8658] BUG: unable to handle page fault for address: fffffffffffffff0
| [   T8658] #PF: supervisor read access in kernel mode
| [   T8658] #PF: error_code(0x0000) - not-present page
| [   T8658] PGD 2c5a067 P4D 2c5a067 PUD 2c5c067 PMD 0
| [   T8658] Oops: Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
| [   T8658] CPU: 6 UID: 1001 PID: 8658 Comm: thread-create-l Not tainted 6=
=2E14.0-rc4+ #188 676565269ee73396c27dead3a66b3f774bd9af57
| [   T8658] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600=
=2E86B.02.03.0003.041920141333 04/19/2014
| [   T8658] RIP: 0010:plist_check_list+0xb/0xa0
| [   T8658] Code: cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90=
 90 90 90 90 90 90 90 90 90 90 90 90 41 54 49 89 fc 55 53 48 83 ec 10 <48> =
8b 1f 48 8b 43 08 48 39 c7  74 27 48 8b 4f 08 50 49 89 f8 48 89
| [   T8658] RSP: 0018:ffffc90022e27c90 EFLAGS: 00010286
| [   T8658] RAX: 0000000000000000 RBX: ffffc90022e27e00 RCX: 0000000000000=
000
| [   T8658] RDX: ffff888558da02a8 RSI: ffff888558da02a8 RDI: fffffffffffff=
ff0
| [   T8658] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8885680dc=
980
| [   T8658] R10: 0000031e8e1a7200 R11: ffff888574990028 R12: fffffffffffff=
ff0
| [   T8658] R13: ffff888558da02a8 R14: ffffc90022e27e48 R15: ffffc90022e27=
d38
| [   T8658] FS:  00007f741af9e6c0(0000) GS:ffff8885a7c2b000(0000) knlGS:00=
00000000000000
| [   T8658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
| [   T8658] CR2: fffffffffffffff0 CR3: 00000006d7aca005 CR4: 0000000000062=
6f0
| [   T8658] Call Trace:
| [   T8658]  <TASK>
| [   T8658]  plist_del+0x28/0x100
| [   T8658]  __futex_unqueue+0x29/0x40
| [   T8658]  futex_unqueue_pi+0x1f/0x40
| [   T8658]  futex_lock_pi+0x24d/0x420
| [   T8658]  do_futex+0x57/0x190
| [   T8658]  __x64_sys_futex+0xfe/0x1a0

It takes about 1h+ to reproduce. And only on one particular stubborn
box. This originates from futex_unqueue_pi() after
futex_q_lockptr_lock(). I have another crash within
futex_q_lockptr_lock() (in spin_lock()).

This looks like the locking task was not enqueued in the hash bucket
during the resize. This means there was a timeout and the unlocking task
removed it while looking for the next owner. But the unlocking part
acquired an additional reference to avoid a resize in that case. So,
confused I am.
I reverted to 50ca0ec83226 ("futex: Resize local futex hash table based
on number of threads."), have the another "always resize hack" and so
far it looks good.
Looking at __futex_pivot_hash() there is this:
|         if (fph) {
|                 if (rcuref_read(&fph->users) !=3D 0) {
|                         mm->futex_phash_new =3D new;
|                         return false;
|                 }
|
|                 futex_rehash_private(fph, new);
|         }

So we stash the new pointer as long as rcuref_read() does not return 0.
How stable is rcuref_read()'s 0 return actually? The code says:

| static inline unsigned int rcuref_read(rcuref_t *ref)
| {
|         unsigned int c =3D atomic_read(&ref->refcnt);
|
|         /* Return 0 if within the DEAD zone. */
|         return c >=3D RCUREF_RELEASED ? 0 : c + 1;
| }

so if it got negative on its final put, the c becomes -1/ 0xff=E2=80=A6ff. =
This
+1 will be 0 and we do a resize. But it is negative and did not reach
RCUREF_DEAD yet so it can be bumbed back to positive. It will not be
deconstructed because the cmpxchg in rcuref_put_slowpath() fails. So it
will remains active. But we do a resize here and end up with to private
hash. That is why I had the `released' member.

Sebastian

