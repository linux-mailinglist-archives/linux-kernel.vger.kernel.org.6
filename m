Return-Path: <linux-kernel+bounces-225978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6479C9138A4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDD61F217C4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223EE26AF2;
	Sun, 23 Jun 2024 07:16:29 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5CB18E20
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719126988; cv=none; b=NCQR6oIdbJF0fBdws9oy0pIpE5bpW/sBEgvc+7fCbaX3qUznhm56CN7yFvobS142rd0Cz2/aOrICeID+YOfyYs93WzZf9H4t2RRWVMjkEeMAXTDt7VbCvy0xx9C/kyob9yPAeCBBBjNKhoNSUIZCb+MD/MsFGLuhsk50PDBDcRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719126988; c=relaxed/simple;
	bh=QaT2SwKi+0WIcEutbVW84EEJUcASSf+hE4zm4JdMwwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDkR4UhRH/z3Tq6iAAJ8h1Cqiizd3FFz8YbVFxUSio8dtVJ2iA6s/ryRcwWDqTJiWvpEkdQEP3qxK07rpsqJuxlwC9rSYnz4T4ZRnQHjy4Uw3JEBRAxGnWNOdNrQ7lm/pO46MxCJ+iXVBwfYnB7/pVywySv6ctTlUdgtnvKnDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b4fced5999so16212566d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 00:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719126984; x=1719731784;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LL7DP8nqv/wQ2K5W6XDyGXYgPiDFNiXNYMNh/yFH1lM=;
        b=DOmulsxBPkGxqZ374xlYw43MVSO9QGtCZdLXHrfgk2nUPW3JR6rNhzdjxPoCdZZ/Y2
         Xrf9ap0wgC6akf20cIJUmEKzhUe9AOLGAN3w3XM7z8WprLuw0V1thAc11ix1pvh/Grnc
         IXMHRY6vNXTs3aNVGeN1F7YYsd2h/sAXBKGa7XVfRkYYPzWXIfJpwPY0kpydkUR+dWyM
         O1Nsd/oWFlmIj5+IbDYMlyUTaG1TROuTRpRWH3nJN6MNJ65g1AsvnAU62zVUNfCw5d/X
         IMI8S7LWWv2glWBfLGjCSoadpG14zt9jdu44XQgznUPSMJH6XMM3GrLh+v84BQ8QQYJs
         Vh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXz5AvxaJ94GRkP+5gKTDNZMNg2KlijDi8INQfnJDf/VYKc6FBZWOVlc/zkI+FzkhkNBzTtTuxSv3R7JM6axcnH5mhZK/ugSInpb2k
X-Gm-Message-State: AOJu0YzFBcoZnPVGg3ETKnMuOeQNNXqDqyYOyLyNTHOp8EPN652x09FH
	wDw9MbT45sfjmfxEC4S2HcJqs9IDsZxjqT3qgidSamplf2nX5RrKxd8ywQ==
X-Google-Smtp-Source: AGHT+IGNZWr36h1pbU/Sd1+58W1GNFHFkujl00tHy8ZMjj+41yFQ7Hd9Dvk/mSLC8yy02NgcwyDlzw==
X-Received: by 2002:a0c:9ccd:0:b0:6b0:90d8:b698 with SMTP id 6a1803df08f44-6b540aaa89cmr17172816d6.45.1719126983921;
        Sun, 23 Jun 2024 00:16:23 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed6a283sm23049256d6.60.2024.06.23.00.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:16:23 -0700 (PDT)
Date: Sun, 23 Jun 2024 02:16:21 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 1/3] sched_ext: Minor cleanups in kernel/sched/ext.h
Message-ID: <20240623071621.GB6519@maniforge>
References: <20240623015057.3383223-1-tj@kernel.org>
 <20240623015057.3383223-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6moLWgU8aOnCSPdk"
Content-Disposition: inline
In-Reply-To: <20240623015057.3383223-2-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--6moLWgU8aOnCSPdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 03:50:20PM -1000, Tejun Heo wrote:
> - scx_ops_cpu_preempt is only used in kernel/sched/ext.c and doesn't need=
 to
>   be global. Make it static.
>=20
> - Relocate task_on_scx() so that the inline functions are located togethe=
r.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>

Acked-by: David Vernet <void@manifault.com>

> ---
>  kernel/sched/ext.c |  2 +-
>  kernel/sched/ext.h | 12 +++++-------
>  2 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 28f7a4266fde..d4c645f9e031 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -771,7 +771,7 @@ static bool scx_warned_zero_slice;
> =20
>  static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
>  static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
> -DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
> +static DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
>  static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
> =20
>  struct static_key_false scx_has_op[SCX_OPI_END] =3D
> diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
> index 0a7b9a34b18f..229007693504 100644
> --- a/kernel/sched/ext.h
> +++ b/kernel/sched/ext.h
> @@ -26,13 +26,6 @@ DECLARE_STATIC_KEY_FALSE(__scx_switched_all);
>  #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
>  #define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
> =20
> -DECLARE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
> -
> -static inline bool task_on_scx(const struct task_struct *p)
> -{
> -	return scx_enabled() && p->sched_class =3D=3D &ext_sched_class;
> -}
> -
>  void scx_tick(struct rq *rq);
>  void init_scx_entity(struct sched_ext_entity *scx);
>  void scx_pre_fork(struct task_struct *p);
> @@ -54,6 +47,11 @@ static inline u32 scx_cpuperf_target(s32 cpu)
>  		return 0;
>  }
> =20
> +static inline bool task_on_scx(const struct task_struct *p)
> +{
> +	return scx_enabled() && p->sched_class =3D=3D &ext_sched_class;
> +}
> +
>  static inline const struct sched_class *next_active_class(const struct s=
ched_class *class)
>  {
>  	class++;
> --=20
> 2.45.2
>=20

--6moLWgU8aOnCSPdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZnfLxAAKCRBZ5LhpZcTz
ZPzEAQCStdeYRfGgUTJSWk5OAJcBF0LhoE0yUwMRrjLG5ye3wgD/aWo7wDc7ZhdV
eLRS4d8o5i/NlQt5P1rkgYbPKKAmBQo=
=r6K5
-----END PGP SIGNATURE-----

--6moLWgU8aOnCSPdk--

