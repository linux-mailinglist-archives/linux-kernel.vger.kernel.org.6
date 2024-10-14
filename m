Return-Path: <linux-kernel+bounces-364415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE8799D45F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C4C1F22101
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8001AD3F6;
	Mon, 14 Oct 2024 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="H6cvm9N6"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFFC1ADFE4;
	Mon, 14 Oct 2024 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728922292; cv=none; b=Z+h1UI1dplME5FGHNruoO5igc1yDf6LVV9p7agUIbW4p9W/zW7ULWCumbe8SBsmQOayzlv0FYiEfElG6XzvQ9ADh9ZS+QfVlMpKpXHB0gPKEnS4nEEmXwQ3m4NXYIcHCBggfFjGLo9fdju0aI8MsRmEcXwSlMqG2vmhhPPNK0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728922292; c=relaxed/simple;
	bh=X04CgbsKnEf5k7gPV0kKZtO3uqy9eqHoDkY8UtmDlQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ome70hoYkXcjoX0PCkivVOZNYDLJ48EbpDo198wPaU+Nafi4c+Zhy9Qq61ew6TLUCjFIzGybyoPV265YfZXcP/B3VhaOrM2WkzBl1Ei+uj48jrLHsqMAhpEVekDcMzz4SGu7xj5Zwg6wZaTBChve1VD8lDhvsUe697072F4hY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=H6cvm9N6; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7D50F42BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728922289; bh=58XodVU9xhNpYVpwW+isngR1UYFCt+rFNnYAhOrKQI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H6cvm9N6QljaTG5lLWejb3YSBNPlK2Vy+7hc+0g5/Md1aSNv03eh/KQJlf1vAUM1+
	 Q8l5hHATI+qRmA1iw0NK6KNax7dO4scPkcroztwKEMFP5sa0hYAr0tpJvG2z8FScUv
	 d40vbA1Oqg8e12wCyoJysIxzH/qMGfda1/Lc6QcLm003KdGzAhlZQwiSa38Win/YrC
	 VbaLLKUpYlrKLJ2WIJhyIvi/yXIyMynaR1LBpoh1gFbI63IiaZBjiYituV+UmO9IKm
	 tEF2THwUpEf2vjoz0c0dAC0SMyniyzqNZw+T7e0B0q3boFceaPIpM0WOSTbj3nrFlT
	 HzvI2hpPHF2VA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7D50F42BFE;
	Mon, 14 Oct 2024 16:11:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Federico Vaga
 <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH v4] doc:it_IT: update documents in process/
In-Reply-To: <20241009224518.15585-1-federico.vaga@vaga.pv.it>
References: <20241009224518.15585-1-federico.vaga@vaga.pv.it>
Date: Mon, 14 Oct 2024 10:11:28 -0600
Message-ID: <87zfn6slzj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> Update Italian translation following these changes under Documentation/process
>
> commit eb5ed2fae197 ("docs: submitting-patches: Advertise b4")
> commit 413e775efaec ("Documentation: fix links to mailing list services")
> commit 47c67ec1e8ef ("docs: submit-checklist: use subheadings")
> commit 5969fbf30274 ("docs: submit-checklist: structure by category")
> commit 5f99665ee8f4 ("kbuild: raise the minimum GNU Make requirement to 4.0")
> commit 627395716cc3 ("docs: document python version used for compilation")
> commit 7a23b027ec17 ("arm64: boot: Support Flat Image Tree")
> commit 56f64b370612 ("rust: upgrade to Rust 1.78.0")
> commit 82b8000c28b5 ("net: drop special comment style")
> commit 6813216bbdba ("Documentation: coding-style: ask function-like macros to evaluate parameters")
> commit 91031ca349ee ("docs: improve comment consistency in .muttrc example configuration")
> commit 7fe7de7be828 ("Docs/process/email-clients: Document HacKerMaiL")
> commit 9c03bc90c065 ("Documentation: process: Revert "Document suitability of Proton Mail for kernel development"")
> commit f9a4f4a0e1f5 ("Docs: Move magic-number from process to staging")
> commit 7400d25a0a5c ("Docs/process/index: Remove riscv/patch-acceptance from 'Other materi
> al' section")
>
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  .../{process => dev-tools}/clang-format.rst   |   0
>  .../translations/it_IT/dev-tools/index.rst    |  17 ++
>  Documentation/translations/it_IT/index.rst    |   8 +-
>  .../translations/it_IT/process/2.Process.rst  |   6 +-
>  .../translations/it_IT/process/4.Coding.rst   |   2 +-
>  .../translations/it_IT/process/changes.rst    |  33 +++-
>  .../it_IT/process/coding-style.rst            |  37 ++--
>  .../it_IT/process/email-clients.rst           |  33 +---
>  .../translations/it_IT/process/howto.rst      |  10 +-
>  .../translations/it_IT/process/index.rst      |  10 --
>  .../it_IT/process/submit-checklist.rst        | 167 +++++++++---------
>  .../it_IT/process/submitting-patches.rst      |  23 +--
>  .../translations/it_IT/staging/index.rst      |  13 ++
>  .../{process => staging}/magic-number.rst     |   0
>  14 files changed, 208 insertions(+), 151 deletions(-)
>  rename Documentation/translations/it_IT/{process => dev-tools}/clang-format.rst (100%)
>  create mode 100644 Documentation/translations/it_IT/dev-tools/index.rst
>  create mode 100644 Documentation/translations/it_IT/staging/index.rst
>  rename Documentation/translations/it_IT/{process => staging}/magic-number.rst (100%)

Applied, thanks.

jon

