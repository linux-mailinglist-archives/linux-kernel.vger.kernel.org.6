Return-Path: <linux-kernel+bounces-407208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559019C6A33
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDBE28578D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BCF188706;
	Wed, 13 Nov 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Ieh6o/h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xd0ydk9x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9A1853
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731484725; cv=none; b=M3DsFcp6zwOGpgqIFePA7VHa/eSqzFL3pJp3A1JSNt7sD4hEn5q40RHE9LP8MmkntX3H9J3RsMdBO8oZ4i4epBjv7k3x3gmPbHzpNWMMsBM50oX4OuJqecjqtmRDYGvzPXv6YRhy13Gvz2VMoXAwALOmXVQDCzQbsSxlIZlABg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731484725; c=relaxed/simple;
	bh=eVH8TNUVQCswVZMKJ1e7yRYKLfcTq9UIUzUS/QvRpcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRS9pjNcwweqN/3HFoL1DF/tyZaDG4cUGrZNuZHMjly49e7ZNiTa9+LBDYi8ZXupSRPKp6gBBxuW7otpORlapZjL98o9oPtKcecDFTkp4wL4AYby+BHXrtSqtPwfru6Rq6p0N+mzbux51LDx3J9czsKKjt/PptmxjwB++fajUJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Ieh6o/h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xd0ydk9x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 08:58:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731484721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0A+0fm9Si2bwe6o5xFpnTSXz/f8jNKAgdVaRGvg/Ck=;
	b=3Ieh6o/hJ4oMZDUJFe/BBFioDCBGzFRwldi+f8j+1ClaZGeYgDy2K1K1apiIRFDLJuShd3
	Y7+NF2OExB5K4r9n0CQJjX4aCiDb0eIQmSnYMHKbLO7JORHYKpGDyiwhW9KFLp4JtgTtuT
	Xf5nY9ndofbauMZqq6a3FLjD4eRo7MtDoxR9K8OWb4iAb/OiN6APg3p91hebpouWm4EfHb
	JRsJs4bjRFqdP5hyVJIIOnQXsbr6N68gHqxLLJujSUmKpaC2O6CBGYxt3gHL3JqVtxr1bV
	MAd4JjH73PIxy2g9mcL+Gl0MbLfsQGQhN6cmADqislyZrn7zify7u5mxRfhGig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731484721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0A+0fm9Si2bwe6o5xFpnTSXz/f8jNKAgdVaRGvg/Ck=;
	b=xd0ydk9xmeQQadwHlp8t1Wg+4h9cq5PRDUo86b79BwGC5zqTnn2hbLiQCk1Ts/gW2KHXwW
	dgiD+waeEJJ7izCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de,
	syzbot <syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com>
Subject: Re: [PATCH] kernfs: Use RCU for kernfs_node::name lookup.
Message-ID: <20241113075840.q2ydNS-D@linutronix.de>
References: <66a745bb-d381-471c-aeee-3800a504f87d@paulmck-laptop>
 <20241102001224.2789-1-hdanton@sina.com>
 <ZyV2DfuIPsISds-1@Boquns-Mac-mini.local>
 <ZykNhbMOrlgCXFYJ@slm.duckdns.org>
 <20241108100503.H-__545n@linutronix.de>
 <Zy5EIHUwoXjK1sAJ@slm.duckdns.org>
 <20241108222406.n5azgO98@linutronix.de>
 <Zy6ROmfQhUvYK9YK@slm.duckdns.org>
 <20241111170450.mUxDpLiW@linutronix.de>
 <ZzOmXbpO3apRH0Cz@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZzOmXbpO3apRH0Cz@slm.duckdns.org>

On 2024-11-12 09:02:53 [-1000], Tejun Heo wrote:
> Hello, Sebastian.
Hi Tejun,

> Sorry about late reply. Have been sick for a bit.

No worries, hopefully you are getting better.

> On Mon, Nov 11, 2024 at 06:04:50PM +0100, Sebastian Andrzej Siewior wrote:
> ...
> > Let me check if I understood. We have three users of kernfs:
> >=20
> > - cgroup
> >   cgroup1_rename(): parent check (would get the new KERNFS_ROOT flag)
> >=20
> > - resctrl
> >   rdtgroup_rename(): seems to allow any "mon group" directory
> >   different parent possible.
> >=20
> > - sysfs
> >   sysfs_move_dir_ns(): reame to a different parent
>=20
> I'm not sure about resctrl but here we just need to add that flag to cgro=
up,
> right?

Correct. I was just puzzling your answer together ;)

> > That new RCU interface would be used by cgroup only and sysfs/ resctrl
> > would remain using the "old" code?
> > If so, would you  prefer=20
> > |struct kernfs_node {
> > |	=E2=80=A6
> > |	union {
> > |		const char              name;
> > |		const char              __rcu *name_rcu;
> > |	}
> >=20
> > to avoid patching resctrl + sysfs for for the rcu_derference name
> > lookup?
>=20
> As replied on the patches, it probably is cleaner to always use __rcu and
> apply the additional locking on the reader side if renaming across differ=
ent
> parents is allowed.

Yes, on it.

> Thanks.

Sebastian

