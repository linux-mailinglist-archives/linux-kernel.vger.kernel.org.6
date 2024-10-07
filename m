Return-Path: <linux-kernel+bounces-353925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77781993486
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB951F24895
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FABC1DCB2D;
	Mon,  7 Oct 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="iavcBMRx"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0A1DC18F;
	Mon,  7 Oct 2024 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321188; cv=none; b=qrAuIoJ+pdFcHnSX/nghI/wc0HtN6ET6JjGaJ0UP/IBH+a9pb/rElN26xztuaGyW8Zgd4ySBugxWRc5bWiZIWeHC+K5QWC0cvKOuszYSZy9cek5KrmWANITboIh0TXjdUotEOciX1DtXVbFL7xwCvBu87KsmJQ9Zs2QAnL1LKXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321188; c=relaxed/simple;
	bh=tPuWQZb9Uudhvv0lmGKN/UPb9yurcbpTbE9L1CfpiqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V2s++0+VVGzj4DTqDbO9xZREO+X7/i/E7hjqGrf5O4yNgJn0Jzwa4S+sYYQY6S3CUuFI81BYliLv5Vm/HEnZqQS5c8AQcAX9M7i/Izw05ryG4SWqVcLeMqyKzrpJNSsCoxo5iLkL2gXOfjs6gDXHrKyF34JFx7cTiQS5Z+vDfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=iavcBMRx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9D30342C0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728321186; bh=tPuWQZb9Uudhvv0lmGKN/UPb9yurcbpTbE9L1CfpiqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iavcBMRxvF2CegKq5hiJDAzw3ETGVtzIdA72o/6LYux+xYhoCvLRlQc8aCKtjYG6u
	 DBKbRIKBmyw7/sAoG6uUfgTMmpkGqe+dZ0IuvYhpw5gPBW6F01F5h64wcn0ahWMm5s
	 UUiLn5bWfgFjUMpiL+mDVOlkwYuK1Ba6zb1STWeaDYoI6R3GytLbhIjClgYEWezHNS
	 L/YyCvaEYU9MsPHY+WloYZwxAeg+kUpcuUPu6Pf/hVEIKboD82k/6fwvDxD3WX92i0
	 5xtqEMkaeuIj8kk2PJpqc3v025rBUP/6yLy7qNPPL1+D7Ks4iL0pNysn3MSlI6JdnO
	 mM+W8thGUGKvQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9D30342C0D;
	Mon,  7 Oct 2024 17:13:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Federico Vaga
 <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH v3] doc:it_IT: update documents in process/
In-Reply-To: <20240930202433.37110-1-federico.vaga@vaga.pv.it>
References: <20240930202433.37110-1-federico.vaga@vaga.pv.it>
Date: Mon, 07 Oct 2024 11:13:05 -0600
Message-ID: <87a5ffkfa6.fsf@trenco.lwn.net>
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

This fails to apply to docs-next; care to respin?

Thanks,

jon

