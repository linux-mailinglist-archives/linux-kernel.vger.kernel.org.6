Return-Path: <linux-kernel+bounces-261340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5554793B610
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2161F21C88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB0215FA9E;
	Wed, 24 Jul 2024 17:38:33 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D517200DE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721842712; cv=none; b=Ubbsboa1+BvC/TMTup7rdcOTQkO16D+WD/jGPitjj0D9usPAuwxtBPEfH1+Y0JiWy1MCdAnRHkuLAeYZqH7R5WVviMLTy2mlGNahYvuZILjeADDdd0k6Fc0r5YQ1ithlvF4ArjOxYsoas1L5qHF1SXnfJsPZI7tqljHCw/hgMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721842712; c=relaxed/simple;
	bh=Rirg2ICU3jTfnQ4ZgkPaRwnI9/HuF34OkOU5FLVMUWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxHSDCMKLb7oYUykBaX4PkKP7DJ9e6tFLzw8vBINNFPod3tEqYOIara+gLdcVFHrZruA1ooPvM6cWP4kUyzMgMTasmZdyIXof7mH44NH6kg5t0DCeD95vwzN4G1byhLoh63TnGtq5XOdvkGKaRRNLhLV8vYR0+PHgq4w9gDLQiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b7aed340daso511246d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 10:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721842710; x=1722447510;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxB+01Z3h5Smk6Z0I6GRZa4EoMycQj8TkjK07oFMkVk=;
        b=syY3RtaTpALMMsAamL290bxjd2W562zJcgEUmj/QO0RT7GjFeDJxRfG1pXlDo4NWW3
         o2xNiiDtDp6W0+8tA4t4Jf5NZ6uRuo0QKOWelv33V72uWLsrb7dyjL5kwKp5VTu9zxmD
         /QXKpaGXvOVbSaR5nQehrXzOsuDUFwaVOaC1xXyyO7gGaoK6PwKNmf6kDUdUQRXhPiE9
         zxzxseGxhfPd7Nq0pn9Uc3KjdJTdBm9YAKIWEOOOUeAYiLJs2Zvvhm5VK6k3DZ2+Iavw
         7YsXthTAO1YU+P6ljJ4yoh6Tgrq76hLHRUmNWcJOlsm+CBpHelo13Q6appq0sdqp9eje
         VHNw==
X-Forwarded-Encrypted: i=1; AJvYcCWa8JDqhH6dgbGylaHnBRPnJwAaZEUFTw0onYDcnBWDKZh7aoC8Y8C+k+/pnbbuq0luGpEgpLibu9ls2WU+aSK4Qqf3+MDJ7CaYyEyt
X-Gm-Message-State: AOJu0Yygd2l2MBnDXvFZJIt+3XjzGVj8BOjtfFprzP9yAuAZHzE458ud
	k2shiEcOGZAejSBcwMKTAOcwRSYRWcFjm0GKF4JUBg57vgCnF6Qe
X-Google-Smtp-Source: AGHT+IEHJIWEI3jYB3uOny0/O/03ghk2T3UvDpf3FYtsH6bJoHEFdfpqzJM8m5a5wK6SeiPBLqVEhA==
X-Received: by 2002:ad4:4ea3:0:b0:6b5:65ab:e860 with SMTP id 6a1803df08f44-6bb3ca14968mr4571116d6.20.1721842710132;
        Wed, 24 Jul 2024 10:38:30 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b9625f84d0sm46449586d6.45.2024.07.24.10.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 10:38:29 -0700 (PDT)
Date: Wed, 24 Jul 2024 12:38:27 -0500
From: David Vernet <void@manifault.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] sched_ext: Initial pull request for v6.11
Message-ID: <20240724173827.GA281347@maniforge>
References: <ZpWjbCQPtuUcvo8r@slm.duckdns.org>
 <20240723163358.GM26750@noisy.programming.kicks-ass.net>
 <ZqAFtfSijJ-KMVHo@slm.duckdns.org>
 <20240724085221.GO26750@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0hVpz++H0BDlulKU"
Content-Disposition: inline
In-Reply-To: <20240724085221.GO26750@noisy.programming.kicks-ass.net>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--0hVpz++H0BDlulKU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:52:21AM +0200, Peter Zijlstra wrote:

[...]

> > > Also, why does that thing hard depend on DEBUG_BTF? (at least having
> > > that option enabled no longer explodes build times like it used to)
> >=20
> > That's necessary for building the schedulers, at least, I think. We did=
n't
> > have that earlier and people were getting confused.
>=20
> It's what made it difficult for me to even build this stuff, simple
> things like:
>=20
>   cd foo-build; ../scipts/config --enable CONFIG_SCHED_CLASS_EXT; cd -
>=20
> don't work (nor error out on the lack of dependencies), and my build
> scripts were force disabling the BTF crud -- and thus silently also the
> scx thing.
>=20
> It looks like I can change my builds scripts, because the reason I did
> that was that BTF made the build times explode and that is no longer the
> case.

Yeah so to clarify the situation here -- BTF is a hard requirement for
sched_ext because BPF requires it in order to call kfuncs [0] (note that
the APIs have changed significantly since that article was written). The
reason it's required, among other things, is so that the verifier can
check that a BPF prog is safely invoking a kernel function with the
proper types.

[0]: https://lwn.net/Articles/856005/

--0hVpz++H0BDlulKU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZqE8EwAKCRBZ5LhpZcTz
ZCqOAP9LiaxIMZ+n824HtZp0/SDiV1zApJQsEIY13FiJcanHtQD/TMLZ4Rsz5gTS
/HuQWhjmw2P8YLcA9gqsomZlxnBZzQ0=
=GIVF
-----END PGP SIGNATURE-----

--0hVpz++H0BDlulKU--

