Return-Path: <linux-kernel+bounces-510522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67B6A31E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9199C3A1162
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF161FBC83;
	Wed, 12 Feb 2025 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7/ZTpgj"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035601FAC4B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339127; cv=none; b=Nky4sQNzbPl3opReBfoapL9ks4hbzgclNkOCs9uVALuNwGydcy6iSn8Ud1Gxku9XJIoEbyX5+ZjTg7jhXhygtFeSMWRXLLpTAB6W8R3nQhadD2sgsUPslAtjzvwwWuHMfLS2NwFeCW7irDRwKfLZ0uPf0+bjfa3Ljo+QMFRFJGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339127; c=relaxed/simple;
	bh=0erNw4/4R2bdatqcXrGiAP5czX5vCScackTkm2MaP/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re7GDJsdkS1mvoWJLlW8V9DrbP9WvnE4nNi7NJQrVfmow4t1iMM+IjkIiZ9HoeWdfnwXs6jrhrZdaaynItZCG2OVvGtyxM6MmWwxwtB62nxHIedmXjeKXrXGSPUencxr6ZkDre4++suxdh6EuAxgh7uwmfHWEM/ACcI5rpDpDBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7/ZTpgj; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c060568959so267594485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739339125; x=1739943925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzYdPXEU4nGM5ORSSxZmtjePOxG0VJkczaj5UCJINf4=;
        b=S7/ZTpgjp10zUPbb8yyYqxxoPr6rTZHpkW7oYAtaLSTH+BXYxpGyjDzdb/NXdr2gDB
         CP9uf6bW1XYGcSOvd6wPuEqvm4SxsDdFAWb/MQRMyGWysefERnHUD7077c4HnDKcYS7i
         gIp08oYN0W9KL1ySzD1euZXTBXIUgdIRJ8xzLydmfV0EkiBPcRMvq0rbuH5/gz8LwOe7
         kxdRzOwbPgu7oRFf1X5IcYp+YEr/rXw7cC9J0gknxJTkhILBLrIVE2d7QMSWQIix05ft
         IIjHt3Tus7973L0OXjtvvhDXjMsqHMHDTEA2pRb+TCIxvh09EzdLSqH72p1z3RydBGvo
         hOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739339125; x=1739943925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzYdPXEU4nGM5ORSSxZmtjePOxG0VJkczaj5UCJINf4=;
        b=ZYmn/67Wj61fJSfK933c84tHR5rb035cfUD2Y6VGAIPCW1kuK/u7D67q5ib8iXu8fX
         Q9645K2rgLZIpt+7ebnEJcJpJ6sxaMQsMku1HkNp2/DVrgHGnRr0EQTb3pDcShHzbKAt
         cyR3DsEr1ckAPRlN6ShwjlSCqCFqrCM9uoxpYHl5Ko4z7TzYi56FvCzZLBWB+8/WEHw7
         3dVND5dU4jmSGwwTMrF1lXnGIea/BMzbrh1HniOIZsEK2BnxqNGYBeO3Cs2qpZWik5Pz
         0IrvNWxqJzdJa3ms+66kOXx2R4uoVO8yJkt9lvPsoC0iRgTFd64kwooF+WYK721bIti0
         UENw==
X-Forwarded-Encrypted: i=1; AJvYcCVIuAX7K2ZpDP/OSGp1jrmLK2H6BoPFoPTuVIBjCSk3L6pNmUoOA+hw6i51vKmW2bVJsTrL+JrI0pPnGw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+iabSGmHdIbtyG5MGxQBNHI2SPeGZNh+WYIUuHIFh/rBcjWos
	Ovjww5aaNR+ZOGxFLgHhC57uTdrF6v8BdRwa9bZxnFbNt9T5dA+n
X-Gm-Gg: ASbGnctHuB+Sq1oSFYczSmqxnGyG1vUlkvQvt0EQI1YdNEH1FI0D7Sz2FUMDJ8hfOjq
	C9L2YKzN3KXw7qOWyY0nguSwtMbfCdq9Lj8Y19UI+MZ7wUm5k5DOhzQ7EJ7BGqasdMMmUMH4TZE
	fB9etWn1XPZtpuX/nJGqBBuC/yY45zFYfwPI4eBv0WT00iQY2QC6qF9QxWXNFNyPulyQUAoPaAH
	qdznoVbk5DJhVPOkf4DXkWruarZGKjj+Er95i5mfKF6rpPhq6iaRMiqeoY/ICk7bUXE9e7t0i8q
	ICbNMnzsbGXm342qHCu8F6Yohf7JcLvoyBX3FboAAL9mbFo7/bkvvEe7V4NcpdNUbRU/rtlCz8d
	IKOVa2A==
X-Google-Smtp-Source: AGHT+IHsuGUCSKL1fBmcup8r5YAPnn9ycUIxlaeRMeaoZtAndO96dzHNWp/bb/aIbo/rb7TPVeT4TQ==
X-Received: by 2002:a05:620a:294a:b0:7c0:660d:2144 with SMTP id af79cd13be357-7c06fcc50fbmr332405885a.40.1739339124757;
        Tue, 11 Feb 2025 21:45:24 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c058adee6csm479270285a.42.2025.02.11.21.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 21:45:24 -0800 (PST)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id CB40F1200043;
	Wed, 12 Feb 2025 00:45:23 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 12 Feb 2025 00:45:23 -0500
X-ME-Sender: <xms:czWsZ7aOeDoSgopzPTqtRV8eyIB6sYnFO2LrkQZI9tPaMupamXRRwQ>
    <xme:czWsZ6ZjSuES3NAgBe67P9WwA9iP0EqtdlH8OwgxC9THq9PynRDdvqnIcVIbD4wUV
    fygh4PFBCviGJYSKw>
X-ME-Received: <xmr:czWsZ9_pm4qx0KBsALM7fxy_Wuas5C5cO2tZFAzhdd-GAi_BJWj0T9kvOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehllhhonhhgsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehm
    ihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllhdruggvrggtohhnse
    grrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:czWsZxpa-FitgqBxxJ2ZxTmwnMhFEzdKefe-rAbhN7NUmHgd6nj_gg>
    <xmx:czWsZ2p97dpbWDicuzPRfn0CJh5oN8WQFDer06hJC5i50SQphf9ZMA>
    <xmx:czWsZ3Q-aqCmi5lq8DUFJZw5DFiT-u1c1IGkEdAuGCdxf42pbq_mUg>
    <xmx:czWsZ-pg5l69LT9uez_mzKU2FM9srQY5GxL4ac9ApwFlkI6btzwUcA>
    <xmx:czWsZ35Mkq-YSBzJA3N7seAz3zD412ISeIqHprfEut68T4j7tDHqAfEF>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 00:45:23 -0500 (EST)
Date: Tue, 11 Feb 2025 21:45:22 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Message-ID: <Z6w1cvz29NkMZh9b@Mac.home>
References: <20250127013127.3913153-1-longman@redhat.com>
 <3e45144d-d147-4431-91be-63d0817fa2ce@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e45144d-d147-4431-91be-63d0817fa2ce@redhat.com>

On Tue, Feb 11, 2025 at 09:18:56PM -0500, Waiman Long wrote:
> 
> On 1/26/25 8:31 PM, Waiman Long wrote:
> > A circular lock dependency splat has been seen involving down_trylock().
> > 
> > [ 4011.795602] ======================================================
> > [ 4011.795603] WARNING: possible circular locking dependency detected
> > [ 4011.795607] 6.12.0-41.el10.s390x+debug
> > [ 4011.795612] ------------------------------------------------------
> > [ 4011.795613] dd/32479 is trying to acquire lock:
> > [ 4011.795617] 0015a20accd0d4f8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x26/0x90
> > [ 4011.795636]
> > [ 4011.795636] but task is already holding lock:
> > [ 4011.795637] 000000017e461698 (&zone->lock){-.-.}-{2:2}, at: rmqueue_bulk+0xac/0x8f0
> > 
> >    the existing dependency chain (in reverse order) is:
> >    -> #4 (&zone->lock){-.-.}-{2:2}:
> >    -> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
> >    -> #2 (&rq->__lock){-.-.}-{2:2}:
> >    -> #1 (&p->pi_lock){-.-.}-{2:2}:
> >    -> #0 ((console_sem).lock){-.-.}-{2:2}:
> > 
> > The console_sem -> pi_lock dependency is due to calling try_to_wake_up()
> > while holding the console.sem raw_spinlock. This dependency can be broken
> > by using wake_q to do the wakeup instead of calling try_to_wake_up()
> > under the console_sem lock. This will also make the semaphore's
> > raw_spinlock become a terminal lock without taking any further locks
> > underneath it.
> > 
> > The hrtimer_bases.lock is a raw_spinlock while zone->lock is a
> > spinlock. The hrtimer_bases.lock -> zone->lock dependency happens via
> > the debug_objects_fill_pool() helper function in the debugobjects code.
> > 
> > [ 4011.795646] -> #4 (&zone->lock){-.-.}-{2:2}:
> > [ 4011.795650]        __lock_acquire+0xe86/0x1cc0
> > [ 4011.795655]        lock_acquire.part.0+0x258/0x630
> > [ 4011.795657]        lock_acquire+0xb8/0xe0
> > [ 4011.795659]        _raw_spin_lock_irqsave+0xb4/0x120
> > [ 4011.795663]        rmqueue_bulk+0xac/0x8f0
> > [ 4011.795665]        __rmqueue_pcplist+0x580/0x830
> > [ 4011.795667]        rmqueue_pcplist+0xfc/0x470
> > [ 4011.795669]        rmqueue.isra.0+0xdec/0x11b0
> > [ 4011.795671]        get_page_from_freelist+0x2ee/0xeb0
> > [ 4011.795673]        __alloc_pages_noprof+0x2c2/0x520
> > [ 4011.795676]        alloc_pages_mpol_noprof+0x1fc/0x4d0
> > [ 4011.795681]        alloc_pages_noprof+0x8c/0xe0
> > [ 4011.795684]        allocate_slab+0x320/0x460
> > [ 4011.795686]        ___slab_alloc+0xa58/0x12b0
> > [ 4011.795688]        __slab_alloc.isra.0+0x42/0x60
> > [ 4011.795690]        kmem_cache_alloc_noprof+0x304/0x350
> > [ 4011.795692]        fill_pool+0xf6/0x450
> > [ 4011.795697]        debug_object_activate+0xfe/0x360
> > [ 4011.795700]        enqueue_hrtimer+0x34/0x190
> > [ 4011.795703]        __run_hrtimer+0x3c8/0x4c0
> > [ 4011.795705]        __hrtimer_run_queues+0x1b2/0x260
> > [ 4011.795707]        hrtimer_interrupt+0x316/0x760
> > [ 4011.795709]        do_IRQ+0x9a/0xe0
> > [ 4011.795712]        do_irq_async+0xf6/0x160
> > 
> > Normally raw_spinlock to spinlock dependency is not legit
> > and will be warned if PROVE_RAW_LOCK_NESTING is enabled,
> > but debug_objects_fill_pool() is an exception as it explicitly
> > allows this dependency for non-PREEMPT_RT kernel without causing
> > PROVE_RAW_LOCK_NESTING lockdep splat. As a result, this dependency is
> > legit and not a bug.
> > 
> > Anyway, semaphore is the only locking primitive left that is still
> > using try_to_wake_up() to do wakeup inside critical section, all the
> > other locking primitives had been migrated to use wake_q to do wakeup
> > outside of the critical section. It is also possible that there are
> > other circular locking dependencies involving printk/console_sem or
> > other existing/new semaphores lurking somewhere which may show up in
> > the future. Let just do the migration now to wake_q to avoid headache
> > like this.
> 
> I can also add the following as another instance where deadlock can happen.
> 
> Reported-by:syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com
> 

FWIW, I already queued in my lockdep-for-tip branch, will send it in a
PR to Peter in one or two weeks (in case he hasn't taken it before
then).

BTW, do we need a "Fixes" tag for stable kernels?

Regards,
Boqun

> Cheers,
> Longman
> 
[...]

