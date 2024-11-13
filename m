Return-Path: <linux-kernel+bounces-406987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67F89C671C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACBB283423
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 02:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D8D762D0;
	Wed, 13 Nov 2024 02:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b="H2f2josU"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456B433CB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463927; cv=none; b=cu5SIqxxzmi+TIXAZ8cOaSUs4piz0Hxp9bASWg92bYU0bI0VzmqEbjrqMwFptqfhj/u1UZ1erJ5payBfE9K42gVrJ5YmFs5xiPbzMZIZBETNXobHzBNLq7GF3RbWPeAbqpWGtRirHD+1DGbOeodoP2TLUWNByhJELnWuMZ+7GMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463927; c=relaxed/simple;
	bh=LPAFNR/5ZvSKqaLMt8rTiosnu4xB/7YjXsTMr1zPqOs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=tE+996SePCdCuTvKentvmIxCimVoz7dmoAoK7ZHtvJeFmRVZDrSYXi6rLwS+58R2BSBk4KZZRdMQqeMSqiiVfa9euilDLtTqSjiqQIN8j9yZyB5fQm0/hRl5BFoziHe1Th8Y0TQICY7IykpGt6RZDVkbI9iVYTv4jynxnSt70Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org; spf=pass smtp.mailfrom=vahedi.org; dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b=H2f2josU; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vahedi.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vahedi.org; s=key1;
	t=1731463920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPAFNR/5ZvSKqaLMt8rTiosnu4xB/7YjXsTMr1zPqOs=;
	b=H2f2josUl02/QYj8HZeK0rhfBW6wwfVszOKFy00+KMFCobNMnOgLX3ceyVgX5NmtlRw6zd
	8G8Xv2G+3sz83sam2oY8/QuiGn7+pZwBn1Chh8Vazt6mWq3fk9uAVEraWPhm7F2B47Q3Q8
	9lyp+fMnJIj8pgcBbJU7hUNVPHsjr2aDml1RU+nDl66E5eqVotaz/qY6ri6AOjjhuEg9km
	BUpn19H7FWrEPcslYwLfLL27hkE23aQK4D6pA+PF4WA0rNGates1me/kgFJUTdKDLF2b+j
	tQlbG7VpURI233Ox21yfSYt7Hk6TtsaFOglq+5akdVm7R9HghmdvpVs+xoJxVQ==
Date: Wed, 13 Nov 2024 02:11:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Shahab Vahedi" <list+bpf@vahedi.org>
Message-ID: <6454497ff35d2a534cd34b7635fb044e4033fe6b@vahedi.org>
TLS-Required: No
Subject: Re: [PATCH] ARC: bpf_jit_arcv2: Remove redundant condition check
To: "Vadim Fedorenko" <vadim.fedorenko@linux.dev>, "Hardevsinh Palaniya"
 <hardevsinh.palaniya@siliconsignals.io>, ast@kernel.org,
 andrii@kernel.org
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "John
 Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Vineet Gupta" <vgupta@kernel.org>,
 bpf@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <e6d27adb-151c-46c1-9668-1cd2b492321b@linux.dev>
References: <20241111142028.67708-1-hardevsinh.palaniya@siliconsignals.io>
 <e6d27adb-151c-46c1-9668-1cd2b492321b@linux.dev>
X-Migadu-Flow: FLOW_OUT

Vadim Fedorenko wrote:
=20
>=20The original code is obviously optimized out, but the intention, I
> believe, was to check if the jump is conditional or not.
> So the proper fix should change the code to check cond:
>=20
>=20- if (ARC_CC_AL)
> + if (cond =3D=3D ARC_CC_AL)

That is absolutely correct. If a new patch is not submitted soon
I'll try to fix it myself.

Cheers,
Shahab

