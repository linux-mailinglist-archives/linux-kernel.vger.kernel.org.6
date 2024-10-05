Return-Path: <linux-kernel+bounces-351732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501A0991575
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E73B209D7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD4F135A53;
	Sat,  5 Oct 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="CU5xOHno"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885A2595
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728118848; cv=none; b=d+tbENkkqTbGKJx5DgNnlrUtwhjgwsMyEwWKRlRybLG83dfEz72rw/0gzkGApB2ciVogvbTNdM8mkYCqoNfvhHIb3HRkXClbmvzvn7Ff9qwN+tRRsxzBMxaQ70KemtUtlFCDHRVq15/rM8/Laq+hYa0VsuV+iuT1u8PJoiX0ilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728118848; c=relaxed/simple;
	bh=i+Hl2jkW0Y80sNTYZ+yeU/B1CMw0zF82pmSdZ8KEpgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7NTS3u5IvQPhXse46EH2KieiagcGs0bsQX/Sqgr9/YZwAGXvY9y4Et5MtWjPczqjpyjNV+xv1vLFwPhUPsC1QIjJfqBs7PiNfdur6uRDwRPvenQi4qyJAsgO39lpQYbt+413ZYmkgF4qGpGNJ3eSMnpLHfdGevJYMRMbWaT2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=CU5xOHno; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2CDA01C0082; Sat,  5 Oct 2024 11:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1728118844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVW3O9XSyifx9yjtLAWEuzOWnRs2kMMJwhsGLsus/PI=;
	b=CU5xOHno9A7mxa95u6GPpq1aZX/t93QGzYQy2ub/3r53f96yzeeTl6kXt4Qr7dyVT6P5dw
	ljRluz90oGLXT+kj2mIbVMV2fAxwkLRmdQweu9UTzsxEBTZLaRkjnRa9dCa0GgvnR8R591
	+pLZ178UFwWogdxOi+KdrMoPqV3tpog=
Date: Sat, 5 Oct 2024 11:00:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] MAINTAINERS: Add an entry for PREEMPT_RT.
Message-ID: <ZwEAO75epgLQ5YZg@duo.ucw.cz>
References: <20241002154639.89wWS_OU@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhN1KJmQKV9ebzzT"
Content-Disposition: inline
In-Reply-To: <20241002154639.89wWS_OU@linutronix.de>


--mhN1KJmQKV9ebzzT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add a maintainers entry now that the PREEMPT_RT bits are merged. Steven
> volunteered and asked for the list.
> There are no files associated with this entry since it is spread over
> the kernel. It serves as entry for people knowing what they look for.
> There is a keyword added so if PREEMPT_RT is mentioned somewhere, then
> the entry will be picked up.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Pavel Machek <pavel@denx.de>

I wonder how this should be merged. Send it directly to Linus? Make it
part of next rt patchset?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--mhN1KJmQKV9ebzzT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwEAOwAKCRAw5/Bqldv6
8swaAJ0aBekp7Vbvwciq7Sv8VxbJChB4RACghCP0GEieBsd+abOH76w/Y4Cshbw=
=kz72
-----END PGP SIGNATURE-----

--mhN1KJmQKV9ebzzT--

