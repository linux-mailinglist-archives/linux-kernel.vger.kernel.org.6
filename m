Return-Path: <linux-kernel+bounces-547022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A894AA501CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2817A7A2629
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AB124BC0B;
	Wed,  5 Mar 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="w0UB8plp"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B424E007
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184684; cv=none; b=h25exFM19mIW1zs/b6dcMFwIXRvQAHC3FM6Lj5HN/v0Xd+h+LpTPA1DUE1dE3xPuYlbd4e7iJeNX9gyuxJDnZ9H2o4S0iDIV8HuplL3oHyjs6fy4upui+NRT3eP54a1jIyakmLgvLZ4GQme7zyceY5c7XzA9cyuP+CGG4KLx90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184684; c=relaxed/simple;
	bh=BqMEpbPQmLcKaKREsa5bVUsulTFripMCTlkvOQf7/jk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SShii2lrs9EWJAsiP5C21X+TqGvonVfa5l/r7lBMnMZ7W1Wz3KqN/NSMgHmSWEyCifnKZ0QPI6YHCHms6jWWJBXb3my7TQTtvvhybzLkkBcRgJ9SFpNV7uk5AxYa6OooCmmn4DO7DTlVZJLKwUMT3CkoAQ03w0qS3rNWAKcywWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=w0UB8plp; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Z7FDd3f5Gz9tSK;
	Wed,  5 Mar 2025 15:24:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741184673; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2q8nN7MJqKtl0tkmVtTko+Pdx9YkiqMB2pBCshcSF8=;
	b=w0UB8plpsorn3H+FrZOy8xDThKUE2U/4U1gEWfHRW4c3kUg6sC9+TO3LA7nExq+r5cCS3a
	TRgCq336KD75Ygv1iI2vM/sBvPIdmAVgarB8UFzauPkqyPZOlCFrL9ar8KJK2BVG3+AN/Q
	Q0Xqw8L7VvnsJOrHDcMZHv4FS3ytXhP7BOAhU2ATJu7g4ms2WpOHKYv7hf2osI4t7aO+ya
	lBjyk0NyfUGSd78dubk67BH8ODwVPOHwql/DZcjq7zH48WkOjEy3N7dusLL841LId4Pus1
	2NjDtmMwTJLAaccnMYBOejbnanEnXQpEr37fAeXVAs6Rpb3wQk65itDy/YOdTQ==
Message-ID: <063480578505f633baf9025348c7ca96a4816602.camel@mailbox.org>
Subject: Re: [PATCH v7 1/3] drm/sched: Adjust outdated docu for run_job()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Bagas Sanjaya <bagasdotme@gmail.com>, Philipp Stanner
 <phasta@kernel.org>,  Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 05 Mar 2025 15:24:29 +0100
In-Reply-To: <Z8hVlc0AgQkNqSGL@archie.me>
References: <20250305130551.136682-2-phasta@kernel.org>
	 <20250305130551.136682-3-phasta@kernel.org> <Z8hVlc0AgQkNqSGL@archie.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: 919b855d1da4a7cc1d9
X-MBO-RS-META: nj16m44ourjngaxxn1ekcaky1yq917s1

On Wed, 2025-03-05 at 20:45 +0700, Bagas Sanjaya wrote:
> On Wed, Mar 05, 2025 at 02:05:50PM +0100, Philipp Stanner wrote:
> > =C2=A0	/**
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @run_job: Called to=
 execute the job once all of the
> > dependencies
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * have been resolved.=
=C2=A0 This may be called multiple times,
> > if
> > -	 * timedout_job() has happened and
> > drm_sched_job_recovery()
> > -	 * decides to try it again.
> > +	 * @run_job: Called to execute the job once all of the
> > dependencies
> > +	 * have been resolved.
> > +	 *
> > +	 * @sched_job: the job to run
> > +	 *
> > +	 * The deprecated drm_sched_resubmit_jobs() (called by
> > &struct
> > +	 * drm_sched_backend_ops.timedout_job) can invoke this
> > again with the
> > +	 * same parameters. Using this is discouraged because it
> > violates
> > +	 * dma_fence rules, notably dma_fence_init() has to be
> > called on
> > +	 * already initialized fences for a second time. Moreover,
> > this is
> > +	 * dangerous because attempts to allocate memory might
> > deadlock with
> > +	 * memory management code waiting for the reset to
> > complete.
> > +	 *
> > +	 * TODO: Document what drivers should do / use instead.
>=20
> No replacement? Or bespoke/roll-your-own functionality as a must?
>=20
> Confused...

We will document this in a follow-up. I'm trying for 2 months now [1]
just to fix up some broken, outdated documentation =E2=80=93 and that in a
component that *I* am maintaining.

It's very difficult to reach the relevant stakeholders, and I really
want to unblock this series.

Feel free to provide a proposal for the TODO based on this series or
jump into the discussion here [2].

Otherwise I will propose a fix for the TODO some time the next weeks.

P.


[1] https://lore.kernel.org/dri-devel/20250109133710.39404-2-phasta@kernel.=
org/
[2] https://lore.kernel.org/dri-devel/688b5665-496d-470d-9835-0c6eadfa5569@=
gmail.com/



