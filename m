Return-Path: <linux-kernel+bounces-248124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C57E92D89E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A370AB21144
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3DA195FE6;
	Wed, 10 Jul 2024 18:51:42 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE186F31C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637501; cv=none; b=r6YU/ytHgSL285B+g90xf9jkEXzyvdTzIkY3Cn0qkHnkcTrhW/PIoqDzA007wZ8c7plR3VXxp88mAs9Pr3p+y69TpZhfsHKk0knNAu2xQfBanDf7ab5Dze22/B+wVpW9WLenqSkrkCgfQ7p0kW3EOKe8eongrUQrQ+iXZ3stTX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637501; c=relaxed/simple;
	bh=lyfrb2ktZgr7mTwi5/71xMip/g3FrYS3VMd4qK4xuXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBp8kylleFqD+Yf/Cz0PbUDRfdOb4w8YPsS8jzF4brK2SXuKpjRLZ4Y9KGtNdkHh4g9c0f5zqI6w+95+XagXZxyTqSvi43Ozfa3NstHmQvsUphrv+oIsoAo8a926hbdEX9zVNa7NeOsQgcfdb5FwcHdXQvuGP4wpUhk1saZGETc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-447fd75f9aeso438501cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720637499; x=1721242299;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6hb5jyVuB9iyljyxx1UxsUB/igp8zpzVIhx84F8ULg=;
        b=he59bU5/kj4A+XITRSdTL7rxeMVR8vDfm9wKsqFABOCaNn76WLPG5hUzqG4vipuqxf
         qtNPoG0C2Jb4AO3bSH1/8WDyrR+t3LGGZTZjJHHU1ZsWLSxUXSe1EcILMnopFyg7qwOP
         xlvA6G4zJaYjHpIr/bKrymHUkQYtjoItCjFF91JZsffFJoWGNDeyr06tdALdSHQ+zflS
         DdCTip9nZl4delT3oZCmdGAs6IZtb8XNV08IYaQ/kGDBeL16hY5krEK6OlWYuqa6WFDM
         wV9mw7ZWFfRnFQfAWjp+Y7yddNgORlkvVV/rpB0ZAh75/OkFUsLwgrvtHgWJI9zJCZNA
         qyWQ==
X-Gm-Message-State: AOJu0Yze3Jv5/a9rCayiw75qnmd/rL9Sc9p5p6jzyEdlWHs/33yixIeT
	6YrT87ZLPmIPnQvfPdGrTVXIYa4nymHiYjvwyYeMsyAqDstAECWt
X-Google-Smtp-Source: AGHT+IGz2lwvYwPICLKE/6Zflee1M3q3uBb8ONGfb6kWaP+ILVMWSbrc1x1UjfpdIngGBGhnzprR8g==
X-Received: by 2002:a05:622a:ce:b0:446:5f64:3fcf with SMTP id d75a77b69052e-447fa89e89dmr83070001cf.34.1720637498527;
        Wed, 10 Jul 2024 11:51:38 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bd2649sm22717451cf.68.2024.07.10.11.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 11:51:38 -0700 (PDT)
Date: Wed, 10 Jul 2024 13:51:35 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCH 5/6] sched_ext: Allow SCX_DSQ_LOCAL_ON for direct
 dispatches
Message-ID: <20240710185135.GB317151@maniforge>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ppW3oYkCzO0B8ev8"
Content-Disposition: inline
In-Reply-To: <20240709212137.1199269-6-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--ppW3oYkCzO0B8ev8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 11:21:11AM -1000, Tejun Heo wrote:
> In ops.dispatch(), SCX_DSQ_LOCAL_ON can be used to dispatch the task to t=
he
> local DSQ of any CPU. However, during direct dispatch from ops.select_cpu=
()
> and ops.enqueue(), this isn't allowed. This is because dispatching to the
> local DSQ of a remote CPU requires locking both the task's current and new
> rq's and such double locking can't be done directly from ops.enqueue().
>=20
> While waking up a task, as ops.select_cpu() can pick any CPU and both
> ops.select_cpu() and ops.enqueue() can use SCX_DSQ_LOCAL as the dispatch
> target to dispatch to the DSQ of the picked CPU, the BPF scheduler can st=
ill
> do whatever it wants to do. However, while a task is being enqueued for a
> different reason, e.g. after its slice expiration, only ops.enqueue() is
> called and there's no way for the BPF scheduler to directly dispatch to t=
he
> local DSQ of a remote CPU. This gap in API forces schedulers into
> work-arounds which are not straightforward or optimal such as skipping
> direct dispatches in such cases.
>=20
> Implement deferred enqueueing to allow directly dispatching to the local =
DSQ
> of a remote CPU from ops.select_cpu() and ops.enqueue(). Such tasks are
> temporarily queued on rq->scx.ddsp_deferred_locals. When the rq lock can =
be
> safely released, the tasks are taken off the list and queued on the target
> local DSQs using dispatch_to_local_dsq().
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Changwoo Min <changwoo@igalia.com>
> Cc: Andrea Righi <righi.andrea@gmail.com>

Hi Tejun,

Overall this looks great. It's really not very complicated at all which is
great to see, but will be a big usability improvement for schedulers so it'=
s a
clear win. Just left a couple comments below.

> ---
>  kernel/sched/ext.c   | 164 ++++++++++++++++++++++++++++++++++++++-----
>  kernel/sched/sched.h |   3 +
>  2 files changed, 149 insertions(+), 18 deletions(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index a88c51ce63a5..f4edc37bf89b 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -889,6 +889,7 @@ static struct kobject *scx_root_kobj;
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/sched_ext.h>
> =20
> +static void process_ddsp_deferred_locals(struct rq *rq);
>  static void scx_bpf_kick_cpu(s32 cpu, u64 flags);
>  static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
>  					     s64 exit_code,
> @@ -1363,6 +1364,63 @@ static int ops_sanitize_err(const char *ops_name, =
s32 err)
>  	return -EPROTO;
>  }
> =20
> +static void run_deferred(struct rq *rq)
> +{
> +	process_ddsp_deferred_locals(rq);
> +}
> +
> +static void deferred_bal_cb_workfn(struct rq *rq)
> +{
> +	run_deferred(rq);
> +}
> +
> +static void deferred_irq_workfn(struct irq_work *irq_work)
> +{
> +	struct rq *rq =3D container_of(irq_work, struct rq, scx.deferred_irq_wo=
rk);
> +
> +	raw_spin_rq_lock(rq);
> +	run_deferred(rq);
> +	raw_spin_rq_unlock(rq);
> +}
> +
> +/**
> + * schedule_deferred - Schedule execution of deferred actions on an rq
> + * @rq: target rq
> + *
> + * Schedule execution of deferred actions on @rq. Must be called with @rq
> + * locked. Deferred actions are executed with @rq locked but unpinned, a=
nd thus
> + * can unlock @rq to e.g. migrate tasks to other rqs.
> + */
> +static void schedule_deferred(struct rq *rq)
> +{
> +	lockdep_assert_rq_held(rq);
> +
> +#ifdef CONFIG_SMP
> +	/*
> +	 * If in the middle of waking up a task, task_woken_scx() will be called
> +	 * afterwards which will then run the deferred actions, no need to
> +	 * schedule anything.
> +	 */
> +	if (rq->scx.flags & SCX_RQ_IN_WAKEUP)
> +		return;
> +
> +	/*
> +	 * If in balance, the balance callbacks will be called before rq lock is
> +	 * released. Schedule one.
> +	 */
> +	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
> +		queue_balance_callback(rq, &rq->scx.deferred_bal_cb,
> +				       deferred_bal_cb_workfn);

Should we be returning above if we're able to use a balance cb?

Also, should we maybe add a WARN_ON_ONCE(rq->balance_callback =3D=3D
&balance_push_callback)? I could see that being unnecessary given that we
should never be hitting this path when the CPU is deactivated anyways, but =
the
push callback thing is a kindn extraneous implementation detail so might be
worth guarding against it just in case.

> +#endif
> +	/*
> +	 * No scheduler hooks available. Queue an irq work. They are executed on
> +	 * IRQ re-enable which may take a bit longer than the scheduler hooks.
> +	 * The above WAKEUP and BALANCE paths should cover most of the cases and
> +	 * the time to IRQ re-enable shouldn't be long.
> +	 */
> +	irq_work_queue(&rq->scx.deferred_irq_work);
> +}
> +
>  /**
>   * touch_core_sched - Update timestamp used for core-sched task ordering
>   * @rq: rq to read clock from, must be locked
> @@ -1578,7 +1636,13 @@ static void dispatch_dequeue(struct rq *rq, struct=
 task_struct *p)
>  	bool is_local =3D dsq =3D=3D &rq->scx.local_dsq;
> =20
>  	if (!dsq) {
> -		WARN_ON_ONCE(!list_empty(&p->scx.dsq_list.node));
> +		/*
> +		 * If !dsq && on-list, @p is on @rq's ddsp_deferred_locals.
> +		 * Unlinking is all that's needed to cancel.
> +		 */
> +		if (unlikely(!list_empty(&p->scx.dsq_list.node)))
> +			list_del_init(&p->scx.dsq_list.node);
> +
>  		/*
>  		 * When dispatching directly from the BPF scheduler to a local
>  		 * DSQ, the task isn't associated with any DSQ but
> @@ -1587,6 +1651,7 @@ static void dispatch_dequeue(struct rq *rq, struct =
task_struct *p)
>  		 */
>  		if (p->scx.holding_cpu >=3D 0)
>  			p->scx.holding_cpu =3D -1;
> +
>  		return;
>  	}
> =20
> @@ -1674,17 +1739,6 @@ static void mark_direct_dispatch(struct task_struc=
t *ddsp_task,
>  		return;
>  	}
> =20
> -	/*
> -	 * %SCX_DSQ_LOCAL_ON is not supported during direct dispatch because
> -	 * dispatching to the local DSQ of a different CPU requires unlocking
> -	 * the current rq which isn't allowed in the enqueue path. Use
> -	 * ops.select_cpu() to be on the target CPU and then %SCX_DSQ_LOCAL.
> -	 */
> -	if (unlikely((dsq_id & SCX_DSQ_LOCAL_ON) =3D=3D SCX_DSQ_LOCAL_ON)) {
> -		scx_ops_error("SCX_DSQ_LOCAL_ON can't be used for direct-dispatch");
> -		return;
> -	}
> -
>  	WARN_ON_ONCE(p->scx.ddsp_dsq_id !=3D SCX_DSQ_INVALID);
>  	WARN_ON_ONCE(p->scx.ddsp_enq_flags);
> =20
> @@ -1694,13 +1748,58 @@ static void mark_direct_dispatch(struct task_stru=
ct *ddsp_task,
> =20
>  static void direct_dispatch(struct task_struct *p, u64 enq_flags)
>  {
> +	struct rq *rq =3D task_rq(p);
>  	struct scx_dispatch_q *dsq;
> +	u64 dsq_id =3D p->scx.ddsp_dsq_id;
> +
> +	touch_core_sched_dispatch(rq, p);
> +
> +	p->scx.ddsp_enq_flags |=3D enq_flags;
> +
> +	/*
> +	 * We are in the enqueue path with @rq locked and pinned, and thus can't
> +	 * double lock a remote rq and enqueue to its local DSQ. For
> +	 * DSQ_LOCAL_ON verdicts targeting the local DSQ of a remote CPU, defer
> +	 * the enqueue so that it's executed when @rq can be unlocked.
> +	 */
> +	if ((dsq_id & SCX_DSQ_LOCAL_ON) =3D=3D SCX_DSQ_LOCAL_ON) {
> +		s32 cpu =3D dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
> +		unsigned long opss;
> +
> +		if (cpu =3D=3D cpu_of(rq)) {
> +			dsq_id =3D SCX_DSQ_LOCAL;
> +			goto dispatch;
> +		}
> +
> +		opss =3D atomic_long_read(&p->scx.ops_state) & SCX_OPSS_STATE_MASK;
> +
> +		switch (opss & SCX_OPSS_STATE_MASK) {
> +		case SCX_OPSS_NONE:
> +			break;
> +		case SCX_OPSS_QUEUEING:
> +			/*
> +			 * As @p was never passed to the BPF side, _release is
> +			 * not strictly necessary. Still do it for consistency.
> +			 */
> +			atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
> +			break;
> +		default:
> +			WARN_ONCE(true, "sched_ext: %s[%d] has invalid ops state 0x%lx in dir=
ect_dispatch()",
> +				  p->comm, p->pid, opss);
> +			atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_NONE);
> +			break;
> +		}
> =20
> -	touch_core_sched_dispatch(task_rq(p), p);
> +		WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_list.node));
> +		list_add_tail(&p->scx.dsq_list.node,
> +			      &rq->scx.ddsp_deferred_locals);
> +		schedule_deferred(rq);
> +		return;
> +	}
> =20
> -	enq_flags |=3D (p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
> -	dsq =3D find_dsq_for_dispatch(task_rq(p), p->scx.ddsp_dsq_id, p);
> -	dispatch_enqueue(dsq, p, enq_flags);
> +dispatch:
> +	dsq =3D find_dsq_for_dispatch(rq, dsq_id, p);
> +	dispatch_enqueue(dsq, p, p->scx.ddsp_enq_flags | SCX_ENQ_CLEAR_OPSS);
>  }
> =20
>  static bool scx_rq_online(struct rq *rq)
> @@ -2631,6 +2730,29 @@ static void set_next_task_scx(struct rq *rq, struc=
t task_struct *p, bool first)
>  	}
>  }
> =20
> +static void process_ddsp_deferred_locals(struct rq *rq)
> +{
> +	struct task_struct *p, *tmp;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	/*
> +	 * Now that @rq can be unlocked, execute the deferred enqueueing of
> +	 * tasks directly dispatched to the local DSQs of other CPUs. See
> +	 * direct_dispatch().
> +	 */
> +	list_for_each_entry_safe(p, tmp, &rq->scx.ddsp_deferred_locals,
> +				 scx.dsq_list.node) {
> +		s32 ret;
> +
> +		list_del_init(&p->scx.dsq_list.node);
> +
> +		ret =3D dispatch_to_local_dsq(rq, NULL, p->scx.ddsp_dsq_id, p,
> +					    p->scx.ddsp_enq_flags);
> +		WARN_ON_ONCE(ret =3D=3D DTL_NOT_LOCAL);
> +	}

As mentioned in the other thread, it might be simplest to just pin and unpin
around this loop here to keep the logic simpler in the callee.

> +}
> +
>  static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
>  {
>  #ifndef CONFIG_SMP
> @@ -3052,6 +3174,11 @@ static int select_task_rq_scx(struct task_struct *=
p, int prev_cpu, int wake_flag
>  	}
>  }
> =20
> +static void task_woken_scx(struct rq *rq, struct task_struct *p)
> +{
> +	run_deferred(rq);
> +}
> +
>  static void set_cpus_allowed_scx(struct task_struct *p,
>  				 struct affinity_context *ac)
>  {
> @@ -3568,8 +3695,6 @@ bool scx_can_stop_tick(struct rq *rq)
>   *
>   * - task_fork/dead: We need fork/dead notifications for all tasks regar=
dless of
>   *   their current sched_class. Call them directly from sched core inste=
ad.
> - *
> - * - task_woken: Unnecessary.
>   */
>  DEFINE_SCHED_CLASS(ext) =3D {
>  	.enqueue_task		=3D enqueue_task_scx,
> @@ -3589,6 +3714,7 @@ DEFINE_SCHED_CLASS(ext) =3D {
>  #ifdef CONFIG_SMP
>  	.balance		=3D balance_scx,
>  	.select_task_rq		=3D select_task_rq_scx,
> +	.task_woken		=3D task_woken_scx,

Should we update the comment in the caller in core.c given that rq is no lo=
nger
only used for statistics tracking?

>  	.set_cpus_allowed	=3D set_cpus_allowed_scx,
> =20
>  	.rq_online		=3D rq_online_scx,

[...]

Thanks,
David

--ppW3oYkCzO0B8ev8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZo7YNwAKCRBZ5LhpZcTz
ZGa7AQD+9UBxvMvId8A/Rs6YHtNfKNm8PbvQr1UdVd96Ru0tYwD+PtExZ0ulU9Eb
3W9mWhtfIQG3Z81A8+NHc13k4NSA9QU=
=r8Ym
-----END PGP SIGNATURE-----

--ppW3oYkCzO0B8ev8--

