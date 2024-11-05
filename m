Return-Path: <linux-kernel+bounces-397228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65EF9BD80A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F2B22BFC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CAA215C7D;
	Tue,  5 Nov 2024 22:03:53 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA39433B5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730844233; cv=none; b=ID9qzwsNFEv5xFj9Lsi7Pl/1RI9mwa433ZazTv98FhxdBuKb2ujkqjiqRV06uF+1Q4f12qqjnAnTIJ7FiAZqFIU5w4V5HcIBn7J5O3yI8itBEmSbHkGPuRwYcLMeyxXC/gatJSCR8/7UttQFEs3+B1B5G0yx0CQiAtNsUA51fmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730844233; c=relaxed/simple;
	bh=XcGSm6M3TPDnLYuqYwLO7CBLsO80KCd48eZ7BHf0TIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoGbNarUrQw/+fcmYMdP+Z3qd0I14hQXQpw1igWPGV+Ix7hpEDl7mpCd8/dtJ1xjhE4h50JtrjyvcblG+7atz21OvKeMPv1LmCKJSxCm0jv7DDu2adroorV2rnBWBjG+Yo+Q0v0Loni+I4NXGp061YM4KWm7m39EnK98+NzEXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbe3e99680so32399086d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 14:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730844230; x=1731449030;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQdQIbUCv/Ck+KpMz/zk039wO/ITDgNjnRVmkaE7Ung=;
        b=rOTDJhixWh478CaPvhSHaJT5Gv96N4XR8lB35j16yKjrAi0P4ECsBjkiG5x6JjUVGo
         CF0fXgwaWalmNPoTREBxkY1iAX/0jrdMqU5f3DD4ZRvNmB2BafxZEtMabEghAKLk2Kts
         wp+m14V4EWxWvMgQGWpCl58zmwpdPsX+22vN0V2UPkl81un4vb1yztAhU4irOWY83wbO
         RpoogmBVO2HR1O4AjFFxmouqS2zkv/+IUcR1TfTdfOkpeD7rZe4ITDcxMwkJNtYkr1xZ
         SWiIedv040X2Axg8hCyqeUvu4eY+Mn7mKT+kjMgV/tsAJvU8W6xFtjcAtOp829Fo10yE
         PtzQ==
X-Gm-Message-State: AOJu0YxD0CyXSKuf7gwcg8W4hKxTVFa8rmXa44WSNz0ltWqcKx0aYtam
	zG36LvwH7mAcqclqM+/fdVXbUBiESSRnI1zLFfMyZpFtwA1B6dvb
X-Google-Smtp-Source: AGHT+IH22W3A2csI+Pamgl8riIk9mgPvYoWW2NqqsiqX4gbtXcCA8CptL0LHNgaHpt+I7nvLS7jOJg==
X-Received: by 2002:a05:6214:498f:b0:6d3:5ca6:b3f6 with SMTP id 6a1803df08f44-6d35ca6b434mr235498766d6.45.1730844230471;
        Tue, 05 Nov 2024 14:03:50 -0800 (PST)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353febef8sm64317146d6.68.2024.11.05.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 14:03:49 -0800 (PST)
Date: Tue, 5 Nov 2024 16:03:46 -0600
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <multics69@gmail.com>
Subject: Re: [PATCH sched_ext/for-6.13 1/2] sched_ext: Avoid live-locking
 bypass mode switching
Message-ID: <20241105220346.GA64119@maniforge>
References: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2cUISxqPsxwSZCuF"
Content-Disposition: inline
In-Reply-To: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--2cUISxqPsxwSZCuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 05, 2024 at 11:48:11AM -1000, Tejun Heo wrote:

[...]

>  static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
>  {
>  	struct task_struct *p;
>  retry:
>  	/*
> +	 * This retry loop can repeatedly race against scx_ops_bypass()
> +	 * dequeueing tasks from @dsq trying to put the system into the bypass
> +	 * mode. On some multi-socket machines (e.g. 2x Intel 8480c), this can
> +	 * live-lock the machine into soft lockups. Give a breather.
> +	 */
> +	scx_ops_breather(rq);

Should we move this to after the list_empty() check? Or before the goto ret=
ry
below so we can avoid having to do the atomic read on the typical hotpath?

> +
> +	/*
>  	 * The caller can't expect to successfully consume a task if the task's
>  	 * addition to @dsq isn't guaranteed to be visible somehow. Test
>  	 * @dsq->list without locking and skip if it seems empty.
> @@ -4550,10 +4587,11 @@ bool task_should_scx(struct task_struct
>   */
>  static void scx_ops_bypass(bool bypass)
>  {
> +	static DEFINE_RAW_SPINLOCK(bypass_lock);
>  	int cpu;
>  	unsigned long flags;
> =20
> -	raw_spin_lock_irqsave(&__scx_ops_bypass_lock, flags);
> +	raw_spin_lock_irqsave(&bypass_lock, flags);
>  	if (bypass) {
>  		scx_ops_bypass_depth++;
>  		WARN_ON_ONCE(scx_ops_bypass_depth <=3D 0);
> @@ -4566,6 +4604,8 @@ static void scx_ops_bypass(bool bypass)
>  			goto unlock;
>  	}
> =20
> +	atomic_inc(&scx_ops_breather_depth);
> +
>  	/*
>  	 * No task property is changing. We just need to make sure all currently
>  	 * queued tasks are re-queued according to the new scx_rq_bypassing()
> @@ -4621,8 +4661,10 @@ static void scx_ops_bypass(bool bypass)
>  		/* resched to restore ticks and idle state */
>  		resched_cpu(cpu);
>  	}
> +
> +	atomic_dec(&scx_ops_breather_depth);
>  unlock:
> -	raw_spin_unlock_irqrestore(&__scx_ops_bypass_lock, flags);
> +	raw_spin_unlock_irqrestore(&bypass_lock, flags);
>  }
> =20
>  static void free_exit_info(struct scx_exit_info *ei)
> @@ -6275,6 +6317,13 @@ static bool scx_dispatch_from_dsq(struct
>  		raw_spin_rq_lock(src_rq);
>  	}
> =20
> +	/*
> +	 * If the BPF scheduler keeps calling this function repeatedly, it can
> +	 * cause similar live-lock conditions as consume_dispatch_q(). Insert a
> +	 * breather if necessary.
> +	 */
> +	scx_ops_breather(src_rq);
> +
>  	locked_rq =3D src_rq;
>  	raw_spin_lock(&src_dsq->lock);
> =20
>=20

--2cUISxqPsxwSZCuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZyqWQgAKCRBZ5LhpZcTz
ZAjoAQCsyK1nLO5+w8xQmYgN2ozK8kNOLm1wSgMNorAZ+jmG9gD+MjSjNvsky8MB
QjuApc+ib5Dl0Vi/4K4BOzZQrZspOA0=
=OoMg
-----END PGP SIGNATURE-----

--2cUISxqPsxwSZCuF--

