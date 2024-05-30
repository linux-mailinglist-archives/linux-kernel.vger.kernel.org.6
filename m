Return-Path: <linux-kernel+bounces-195843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1A08D52B1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904DA1F212C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAD0142E6F;
	Thu, 30 May 2024 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="b+Dspvvn"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA9433CA;
	Thu, 30 May 2024 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717098912; cv=none; b=chBxXxjhDFz4NSkPaEq97dY51/QA81iW7TdxSAoMKv9pu0O9qd6s+i9wsAf7XVaMygJvNnLIb9JRQ2XErQOOPs6DSfOZQiMZNU4LXDs+pflI248jJNDArDJ9k9LqaQY7Jc5fFwYkB/P3dF71UlgRDuW9sAPnI6Zwh+vSwaR5JQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717098912; c=relaxed/simple;
	bh=azrTX9ToTxexbacEULU0HPBpD9tKCxSjdzlW784xaBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iM92XFihidqUwqR7mM6YQJMrEcnLi1Y4NYci5AjIrz4hg+YAGxRPV5kx8Eh+79RoU1Pz3Mq8y3b0D+czxt1J87kK1Bq7x1itHaRhhEUlVi8ojY0qWE7DDH2m9JLwV3TuBzJAFEFUm1w+ciQ5h0EfVWnZFEGYs/BjsuGy5+3rMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=b+Dspvvn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F40AC47C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1717098909; bh=azrTX9ToTxexbacEULU0HPBpD9tKCxSjdzlW784xaBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b+Dspvvn4aAhfddEyoTguolXdc+pOtCvXw1ouA6SkcxKCsM2tZ72oTqs02Cl/L0px
	 VZnypTjf496zyViliCyUcd3a1voW7jGXSKrnfx9vRR51n0mODbhe1ypRx5Wo0G8Fb/
	 R9wvY3ogykNRIXv13YsBDQZqsJF039YgXIS/6vvAjKpQDwFJUhBU7ETnzUc8+bjNgD
	 qapbulGvLmj6H6/6hJKc4Mu0Q+mkHz5DR770181RJzbXlHaVhmQ0JGXOV+xtgEtTjE
	 WYZ1bKJybeOn9WBR3Jrs3dJ82pTeIkLJjk6p7oiJuB6TkU/EINj1C+MwUIvaAtDLp1
	 JnYucEOPIVjcQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F40AC47C39;
	Thu, 30 May 2024 19:55:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Federico Vaga
 <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: align Italian documentation
In-Reply-To: <20240513210510.10929-1-federico.vaga@vaga.pv.it>
References: <20240513210510.10929-1-federico.vaga@vaga.pv.it>
Date: Thu, 30 May 2024 13:55:08 -0600
Message-ID: <875xuvcbxf.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> This commit translats in Italian the following changes:
>
> commit 5db34f5bfd78 ("docs: stable-kernel-rules: remove code-labels tags and a indention level")
> commit 2263c40e6525 ("docs: stable-kernel-rules: call mainline by its name and change example")
> commit db483303b58f ("docs: stable-kernel-rules: reduce redundancy")
> commit af3e4a5ab9a0 ("docs: stable-kernel-rules: create special tag to flag 'no backporting'"")
> commit 91a3d6be99e6 ("doc-guide: kernel-doc: tell about object-like macros")
> commit b104dbedbe61 ("Documentation: RISC-V: patch-acceptance: mention patchwork's role")
> commit ed843ae947f8 ("docs: move riscv under arch")
> commit b45d8f387157 ("docs: remove the tips on how to submit patches from MAINTAINERS")
> commit 0d828200ad56 ("docs: process: allow Closes tags with links")
> commit c23f28975abc ("Merge tag 'docs-6.4' of git://git.lwn.net/linux")
> commit 329ac9af902e ("docs: submitting-patches: Discuss interleaved replies")
> commit 02f9998754b0 ("docs: submitting-patches: Suggest a longer expected time for responses")
> commit 1fae02e7eb99 ("docs: submitting-patches: encourage direct notifications to commenters")
> commit d254d263f6c8 ("docs: submitting-patches: improve the base commit explanation")
> commit 0d828200ad56 ("docs: process: allow Closes tags with links")
> commit 9c1b86f8ce04 ("kbuild: raise the minimum supported version of LLVM to 13.0.1")
> commit 768409cff6cc ("rust: upgrade to Rust 1.76.0")
> commit 23bfb947eb0a ("doc: fix spelling about ReStructured Text")
> commit d0bde9ca0ecf ("docs: stable-kernel-rules: mention other usages for stable tag comments")
> commit 33568553b3fc ("docs: stable-kernel-rules: make rule section more straight forward")
> commit 3feb21bb0bb4 ("docs: stable-kernel-rules: move text around to improve flow")
> commit 0f11447d9fcc ("docs: stable-kernel-rules: improve structure by changing headlines")
> commit 189057a1b61b ("docs: stable-kernel-rules: make the examples for option 1 a proper list")
> commit 6e160d29f654 ("docs: stable-kernel-rules: fine-tune various details")
> commit bbaee49cce7c ("docs: stable-kernel-rules: mention that regressions must be prevented")
> commit 4f01342464a8 ("Documentation: stable: clarify patch series prerequisites")
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

Applied, thanks.

jon

