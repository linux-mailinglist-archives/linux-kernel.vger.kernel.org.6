Return-Path: <linux-kernel+bounces-406367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8499C5E04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734A4281B13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC3E2123F7;
	Tue, 12 Nov 2024 16:56:41 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2FB2076B8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430600; cv=none; b=VeOB7s2RcEWkM4uwB0a7u3vHNTr1nhcxGZrPcSag6vN7ZHFSiZf1GzbR0kOrss7j17g8L62gX761MsFBCI0U2faa1DZhDokQUhjV622vsorpW/BYiL1Ufma+D90ZRT8PpM7N3z9XWp/ALF+mvBrzUsoaZZr4fACOeBwGum97SIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430600; c=relaxed/simple;
	bh=AZAyd888CaVI/hWCfxpfWtwQhNdtnbeu/KHkfe6Fy2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUlPOdAIHClftR6RxZ6OVFZ4FhuRo6DP6Xa3SoybMZ9XMSQtHDneWerzPp7m0fpVVsGGVUZpDbO5B2r3y/5oJ2K2WPs4k3JaHr4N2t+WNm5dnfViaW5sSLsv5bnvPC1F1gUvKIaAulG5QV1v1HjzjeQE8OFLAEGyL528PsdaEPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83abcfb9f37so242293639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430598; x=1732035398;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOoxm9nH6PgsTy9peDwvJKMuwpkqC3ZDwuWiN1r5ckM=;
        b=okiT3xxfsl0I8jgAUnss3GQhI0+hy3u+omlNo/W8H0yJ4T7YLA5a0xCnxzybtBwFy8
         KXB1x3e0xSxvUV+oIzS3timLUOtrjN/VEnuD7Dap//59ZtRcVmi1901z6Whx5oJ+fGyL
         VUJVCEzTG9E1kbWSBq5FvRUoPlpJVW6spIfTLon6alsvp6BmCGFBawPUDyl4WmVl/Zpi
         AwcRIeH05DDhoiHmugOttLFyNlTmjb6U7UM4Z4j/wBQ3Qzr2a1VxPxSk3D9rN1WOpRaR
         a/z7k7+cjdeQJRPQKjy3KLPLQRrxW4BSBaEi58mIvmTyM0SF2sqEFsBinO/S3UlmmJUh
         cj7w==
X-Gm-Message-State: AOJu0YwWw5D0YQlphSBzXjMvYBJcSoEkF8Wvyu7I5wZWhRaZ+v7Mxkbo
	d8BTs2tktcSl2AP1xUWpxG7a3SfruMlBZ1wqgiRoGHbgArLvpysZ
X-Google-Smtp-Source: AGHT+IFun1lKDy5sRAHTVSzMw5nkAe47G6o8fCUo4rsk2rp7tVp4/3MPXhXR5qgJP7e5vE1MjMfK2w==
X-Received: by 2002:a05:6602:134b:b0:82c:f85a:4dcb with SMTP id ca18e2360f4ac-83e032b0ae8mr1903201439f.6.1731430598158;
        Tue, 12 Nov 2024 08:56:38 -0800 (PST)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787d707fsm2142224173.97.2024.11.12.08.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:56:37 -0800 (PST)
Date: Tue, 12 Nov 2024 10:56:35 -0600
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
	arighi@nvidia.com, multics69@gmail.com, me@mostlynerdless.de,
	ggherdovich@suse.com, dschatzberg@meta.com, yougmark94@gmail.com
Subject: Re: [PATCHSET sched_ext/for-6.13] sched_ext: Rename dispatch and
 consume kfuncs
Message-ID: <20241112165635.GB9031@maniforge>
References: <20241110200308.103681-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3AGKltVMP+r9nrYq"
Content-Disposition: inline
In-Reply-To: <20241110200308.103681-1-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--3AGKltVMP+r9nrYq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 10:02:50AM -1000, Tejun Heo wrote:
> Hello,
>=20
> [v1] -> v2: Comment and documentation updates.
>=20
> In sched_ext API, a repeatedly reported pain point is the overuse of the
> verb "dispatch" and confusion around "consume":
>=20
> - ops.dispatch()
> - scx_bpf_dispatch[_vtime]()
> - scx_bpf_consume()
> - scx_bpf_dispatch[_vtime]_from_dsq*()
>=20
> This overloading of the term is historical. Originally, there were only
> built-in DSQs and moving a task into a DSQ always dispatched it for
> execution. Using the verb "dispatch" for the kfuncs to move tasks into th=
ese
> DSQs made sense.
>=20
> Later, user DSQs were added and scx_bpf_dispatch[_vtime]() updated to be
> able to insert tasks into any DSQ. The only allowed DSQ to DSQ transfer w=
as
> from a non-local DSQ to a local DSQ and this operation was named "consume=
".
> This was already confusing as a task could be dispatched to a user DSQ fr=
om
> ops.enqueue() and then the DSQ would have to be consumed in ops.dispatch(=
).
> Later addition of scx_bpf_dispatch_from_dsq*() made the confusion even wo=
rse
> as "dispatch" in this context meant moving a task to an arbitrary DSQ fro=
m a
> user DSQ.
>=20
> Clean up the API with the following renames:
>=20
> 1. scx_bpf_dispatch[_vtime]()		-> scx_bpf_dsq_insert[_vtime]()
> 2. scx_bpf_consume()			-> scx_bpf_dsq_move_to_local()
> 3. scx_bpf_dispatch[_vtime]_from_dsq*()	-> scx_bpf_dsq_move[_vtime]*()
>=20
> This patchset is on top of sched_ext/for-6.13 72b85bf6a7f6 ("sched_ext:
> scx_bpf_dispatch_from_dsq_set_*() are allowed from unlocked context") and
> contains the following patches:
>=20
>  0001-sched_ext-Rename-scx_bpf_dispatch-_vtime-to-scx_bpf_.patch
>  0002-sched_ext-Rename-scx_bpf_consume-to-scx_bpf_dsq_move.patch
>  0003-sched_ext-Rename-scx_bpf_dispatch-_vtime-_from_dsq-s.patch

For the series:

Acked-by: David Vernet <void@manifault.com>

--3AGKltVMP+r9nrYq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZzOIwwAKCRBZ5LhpZcTz
ZMf3APkBgWxQ1yuOZiudiBo+mN4ndNFsCNcwaJQ2VME0K5+dhwD9ETKzoJ64Udw3
g4pslMyH5XbLJiFqY1F+LEgW/SoL+AY=
=N2Wt
-----END PGP SIGNATURE-----

--3AGKltVMP+r9nrYq--

