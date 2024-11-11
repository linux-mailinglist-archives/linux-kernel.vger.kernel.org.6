Return-Path: <linux-kernel+bounces-403748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB49C3A13
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D0B1F222E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE6170A15;
	Mon, 11 Nov 2024 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=mostlynerdless.de header.i=@mostlynerdless.de header.b="shAKSmBl"
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is [185.26.156.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF916DC3C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315118; cv=none; b=eUIzrSIPA4IzKxKiTBx5jiWhpzji6ARx/gsSuIunFD6iJGkYsU7yFCIdAnDhSTVzBYI6e+rnbreaM69yyrdeMYFk8FjjRu0ZpEkHmHNgetG/0HLMz2AdSQANac2qKO54Gph9vQGR3n6gQ4KXSITjXeQCluzZBgfBTrJX0HPvBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315118; c=relaxed/simple;
	bh=ZAruG1dn6wf0qzT++9fTeRtU4hywe5ESJURD69UEBA0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=riv3TmOvxvP2ql0bqatR2eW2UHBmC9ZwvQMkU+O04fhbUbAxSk3Mj0TqrhNoV6DxS5hiW3a3ojuqYgzF82/zeUfqF1VgILu+IDjXfkFUnsygtfUTd1dRQkkKoh60Z8GzK1zLTwD3FgFM5FPuoe5XmbmRVL0Z8sFmfFUNCP0dock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mostlynerdless.de; spf=pass smtp.mailfrom=mostlynerdless.de; dkim=pass (4096-bit key) header.d=mostlynerdless.de header.i=@mostlynerdless.de header.b=shAKSmBl; arc=none smtp.client-ip=185.26.156.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mostlynerdless.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mostlynerdless.de
Received: from helike.uberspace.de (helike.uberspace.de [185.26.156.135])
	by mailgate02.uberspace.is (Postfix) with ESMTPS id 54B82180BEE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:51:52 +0100 (CET)
Received: (qmail 11240 invoked by uid 988); 11 Nov 2024 08:51:52 -0000
Authentication-Results: helike.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by helike.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 11 Nov 2024 09:51:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Nov 2024 08:51:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Johannes Bechberger" <me@mostlynerdless.de>
Message-ID: <02cb4b69c76871c8f14be10d53d37f1285ce41c1@mostlynerdless.de>
TLS-Required: No
Subject: Re: [PATCHSET sched_ext/for-6.13] sched_ext: Rename dispatch and
 consume kfuncs
To: "Changwoo Min" <multics69@gmail.com>, tj@kernel.org, void@manifault.com
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
 arighi@nvidia.com, ggherdovich@suse.com, dschatzberg@meta.com,
 yougmark94@gmail.com, changwoo@igalia.com, kernel-dev@igalia.com
In-Reply-To: <69a3473d-2923-45a9-b38e-0121544f0303@gmail.com>
References: <20241110200308.103681-1-tj@kernel.org>
 <69a3473d-2923-45a9-b38e-0121544f0303@gmail.com>
X-Rspamd-Bar: ---
X-Rspamd-Report: BAYES_HAM(-2.999999) MIME_GOOD(-0.1)
X-Rspamd-Score: -3.099999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=mostlynerdless.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=ZAruG1dn6wf0qzT++9fTeRtU4hywe5ESJURD69UEBA0=;
	b=shAKSmBlT0r0aumGZ040F+AUYMWkJHAjMMJ/9PmUYO64NJU6moRrvGB2ylwHl2kZZYPthuu91v
	Ffjuc7mhnQHgaW+ctQSL/dbiGZaQC4bCu5zsxBLMFoIMIt4bhc5k+PufssaFGV9Mma3X56trcdf3
	qLevxX6wZzVu0uOb64mlWZJB8BozHeR2HXh0dw8ttCpoXl8D6/hGGgwybgGBNzr+E97dXMc3lNz7
	qSqbJW/kToopTX2Hn67n03XR+lshresENmUoR+i1Gzph4p4dIeMViwBGm5YTyVhY1KF5ha+5+9jR
	n3Brqsfj7DMv0cO23WdhwGIIAx0/Nl5XDMMm6cB55/EjRmEZlxzYxPIGUTr/PBooRZ5aXR9rZmar
	ub/+HX+ilD6LoFowOzctJnMoBez+vFBLCi9bYKm5qiu7b7R2yJ1JGqjqcznGaEXGHDEAalfIYMYk
	0z9WVwlYdY8ucsALP8KG04BhaqNiZLqgsrrs7BQHJUo1cokkYhDqJGngyUnoJT5GhfpAXxuKLh7L
	+5GdAHYxHbAsGEDMPm1SJH7ywtd3w7Wc6Su+i7BGyxF9QUldaLOEYEnkXw0kBROkeGHU20rwo4X9
	orDYrno9cQ2EbvpgELWths7i3wtUH8oyDpsmuBQIoVwyhueYVM9sFx647MoUEBP+Y8POtVU8oY4Y
	Q=

Hello,

On 24. 11. 11. 05:02, Tejun Heo wrote:
=E2=80=A2=E2=80=A2=E2=80=A2

>=20
>=20Hello,
>  [v1] -> v2: Comment and documentation updates.
>  In sched_ext API, a repeatedly reported pain point is the overuse of t=
he
>  verb "dispatch" and confusion around "consume":
>  - ops.dispatch()
>  - scx_bpf_dispatch[_vtime]()
>  - scx_bpf_consume()
>  - scx_bpf_dispatch[_vtime]_from_dsq*()
>  This overloading of the term is historical. Originally, there were onl=
y
>  built-in DSQs and moving a task into a DSQ always dispatched it for
>  execution. Using the verb "dispatch" for the kfuncs to move tasks into=
 these
>  DSQs made sense.
>  Later, user DSQs were added and scx_bpf_dispatch[_vtime]() updated to =
be
>  able to insert tasks into any DSQ. The only allowed DSQ to DSQ transfe=
r was
>  from a non-local DSQ to a local DSQ and this operation was named "cons=
ume".
>  This was already confusing as a task could be dispatched to a user DSQ=
 from
>  ops.enqueue() and then the DSQ would have to be consumed in ops.dispat=
ch().
>  Later addition of scx_bpf_dispatch_from_dsq*() made the confusion even=
 worse
>  as "dispatch" in this context meant moving a task to an arbitrary DSQ =
from a
>  user DSQ.
>  Clean up the API with the following renames:
>  1. scx_bpf_dispatch[_vtime]() -> scx_bpf_dsq_insert[_vtime]()
>  2. scx_bpf_consume() -> scx_bpf_dsq_move_to_local()
>  3. scx_bpf_dispatch[_vtime]_from_dsq*() -> scx_bpf_dsq_move[_vtime]*()
>  This patchset is on top of sched_ext/for-6.13 72b85bf6a7f6 ("sched_ext=
:
>  scx_bpf_dispatch_from_dsq_set_*() are allowed from unlocked context") =
and
>  contains the following patches:
>  0001-sched_ext-Rename-scx_bpf_dispatch-_vtime-to-scx_bpf_.patch
>  0002-sched_ext-Rename-scx_bpf_consume-to-scx_bpf_dsq_move.patch
>  0003-sched_ext-Rename-scx_bpf_dispatch-_vtime-_from_dsq-s.patch
>  and is always available in the following git branch:
>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git http://=
git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git  scx-api-rename-=
dispatch-v2
>  diffstat follows. Thanks.
>=20

Looks=20good to me too. Thanks for your effort :)

Acked-by: Johannes Bechberger <me@mostlynerdless.de mailto:me@mostlynerdl=
ess.de >

Regards
Johannes Bechberger

