Return-Path: <linux-kernel+bounces-248508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4491992DE39
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9201B22848
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E89DF60;
	Thu, 11 Jul 2024 02:05:10 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57EDDA5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720663509; cv=none; b=sSsQv5lmf3ayZpmZ0MSAWqBy12ScHMVBWoTS4ayDOOqQF75KJwiyvQ/VcVi5UxKCZfQ7ZhO4ASP98GkY5Ahsxuz7wTBMYKuBGzebk0i0Ru0QIokPqsBlymRlio+2kUHOFp87KmZdTZvetcPdn02EwJhlLoU3yB1GJPeCcLH8H/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720663509; c=relaxed/simple;
	bh=dyxHA8vIQqwpmjbALUcOSCNOpXbpNBbQMPz9vki7kl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2ps1KvZ7Z8cRJ9Zh4Oi+ZR3nW/MC2XzND2pFGdcf6mHGYK9c4le7bnQuKWji1N3IPE04YE5HXLKXaf+Z3difs/GCc4SrYutQIcoT5Mfl8oTv6CGOR/YD4IG26IGSTU8aDDgTROfcgrqFNZfgDbSIdo6/nuJeO4O/TXL4S5StgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5d3113168so2612676d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720663507; x=1721268307;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyxHA8vIQqwpmjbALUcOSCNOpXbpNBbQMPz9vki7kl0=;
        b=Fyf/hME5zLFvDYVU/sasqVcvC14naP8Dlr9lu5in6fNRM3Q2vMvG75nkqMVLItWyVa
         6a2EkBnNinJiUNr0DxDEgzP54cxZE9lJvW6ju1cg5i8kpnkX6pyl3YEu3/v8dsjmtLvd
         onHv8v7Hof8y5KP0BJ7D0cO4wCPG2bgdxi55vVW3vbTTBoLINKIFi/7BjqI8FbyKs1RJ
         ajN3WpfKDQWgPzU6mVE4NLZOyPGgXPXWozqcR+BimmAuYU+wIKwrXRqQ5V4pWcLCwC1D
         iG52tfIfsEekM3W6yhEWVXDlZZVABp8tUgXvSZwjUjJ115CM21CoSp8Q4xOBVJ5jFe5A
         ZAcw==
X-Gm-Message-State: AOJu0YyVR/PmiadVtag0xtverL4SbubxOoBlh9I6ss60t00MnATGp7hw
	zGwCZ4gY7l0PuvQ8YSBT7XI14KubCQCFy4Wz8yK8KSNMlz1OeAzh
X-Google-Smtp-Source: AGHT+IFpeI9qCw31sP5J4g7ls/0xULlv+ebaBsjGIU8AUL5uMwEML2kHlV0/OX/A4WSmspM1er/xFA==
X-Received: by 2002:a05:6214:2a46:b0:6b5:12c:b345 with SMTP id 6a1803df08f44-6b61bca6ac2mr81934516d6.16.1720663507077;
        Wed, 10 Jul 2024 19:05:07 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8f11csm21241886d6.104.2024.07.10.19.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 19:05:06 -0700 (PDT)
Date: Wed, 10 Jul 2024 21:05:04 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCH 3/6] sched_ext: Unpin and repin rq lock from balance_scx()
Message-ID: <20240711020504.GG317151@maniforge>
References: <20240711011434.1421572-1-tj@kernel.org>
 <20240711011434.1421572-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3n6EcIUdnPjoyyJv"
Content-Disposition: inline
In-Reply-To: <20240711011434.1421572-4-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--3n6EcIUdnPjoyyJv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 03:14:00PM -1000, Tejun Heo wrote:
> sched_ext often needs to migrate tasks across CPUs right before execution
> and thus uses the balance path to dispatch tasks from the BPF scheduler.
> balance_scx() is called with rq locked and pinned but is passed @rf and t=
hus
> allowed to unpin and unlock. Currently, @rf is passed down the call stack=
 so
> the rq lock is unpinned just when double locking is needed.
>=20
> This creates unnecessary complications such as having to explicitly
> manipulate lock pinning for core scheduling. We also want to use
> dispatch_to_local_dsq_lock() from other paths which are called with rq
> locked but unpinned.
>=20
> rq lock handling in the dispatch path is straightforward outside the
> migration implementation and extending the pinning protection down the
> callstack doesn't add enough meaningful extra protection to justify the
> extra complexity.
>=20
> Unpin and repin rq lock from the outer balance_scx() and drop @rf passing
> and lock pinning handling from the inner functions. UP is updated to call
> balance_one() instead of balance_scx() to avoid adding NULL @rf handling =
to
> balance_scx(). AS this makes balance_scx() unused in UP, it's put inside a
> CONFIG_SMP block.
>=20
> No functional changes intended outside of lock annotation updates.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrea Righi <righi.andrea@gmail.com>
> Cc: David Vernet <void@manifault.com>

Acked-by: David Vernet <void@manifault.com>

--3n6EcIUdnPjoyyJv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZo890AAKCRBZ5LhpZcTz
ZG8sAPwM5ciMfOrwRrbOsgDRSwkmQOZIrlG0XzlF3g0l7DqB9QD+MnVZ/R4t3ise
kQm5kj4GUAoGwALhffmSbwkIMcmI9QQ=
=MBxA
-----END PGP SIGNATURE-----

--3n6EcIUdnPjoyyJv--

