Return-Path: <linux-kernel+bounces-179593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBFA8C61DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0C31C20DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B899C446A9;
	Wed, 15 May 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="foaKI6IM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xXNGajDr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F13399B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758795; cv=none; b=XliyMdD+XUfcRcCNvfUVpFfcnjyelDVT1De9Qe16GWI1RfR1sH8dI52OWsbCfaOxLPu5JxHsOFCxaoMLnMed5MhXykXMAY4Ka2CfhtrU5Q6m85Ev5bxAT2KEGZKBMKoFx2hHMbaafR5HdIve0/TmxkLrUAcfDaM267kRnRlXWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758795; c=relaxed/simple;
	bh=RaOpZmyuZCvew3C+tFdenDOz9gNjEenzeNPPt+NNmBM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1rmCKfINxUAXqcKrSfXN+ftFGzo+4htavO249MEP4kwKlPG/Egez2sVQscEIhEbLrPcTwNn7htK7XpDnkSr6ZrjTsogZSRti5uhCBTcvvehS1RI3PETtrzQoAOaYHJC4nlNi8W2H462d9q0NLTitizCIIavCwS/ca2GtBLzNoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=foaKI6IM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xXNGajDr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 May 2024 09:39:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715758792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0mk9oc6DES1RAS2h7quf07H1P5S+bDmfrogk/iErpU4=;
	b=foaKI6IM5Xwm9ZUGZuaCITCkR/q/NCFdyim4nGlyEX0OPDr6sHSjZK3ucwmd6L1NosZTYj
	2oLGZfUsyGLkFHsNwhd5rUMi8Y57qVQVotlcuT+VkuLGfsUiqZ45Lbkhb4K5rLHFNvUCh1
	wlitQS1/9RLhLkWHB37bBxiybQy+NFDssrLh/jq3S0L4tUTrG3HpveOZ0HDxgTDhw1fDO1
	UO8WcjcsZC/DHUD9FwpUnVjwVIBvhcSDjyzJXlI2HD5GtMVE9A7GEhmvczw3zBeRnNQH1B
	OUdRt7gxm0uc28n3RJmRMtN2Jq8BVyotcfnM+lcJQMWk2UagW/AQ/Hj/1Tj8NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715758792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0mk9oc6DES1RAS2h7quf07H1P5S+bDmfrogk/iErpU4=;
	b=xXNGajDr+Xr0xqNRVyHIIoN1Nn4grCsCaNVO0gjxipKBlAOvGt/B8LYAnwpdIFmkoaNzhF
	RTa8/aKddsbswlDw==
From: Nam Cao <namcao@linutronix.de>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH 0/2] riscv: fix debug_pagealloc
Message-ID: <20240515073947.J1Hzlsm5@linutronix.de>
References: <cover.1715750938.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715750938.git.namcao@linutronix.de>

Forgot to Cc the original author.
+Cc: Zong Li <zong.li@sifive.com>

On Wed, May 15, 2024 at 07:50:38AM +0200, Nam Cao wrote:
> The debug_pagealloc feature is not functional on RISCV. With this feature
> enabled (CONFIG_DEBUG_PAGEALLOC=y and debug_pagealloc=on), kernel crashes
> early during boot.
> 
> QEMU command that can reproduce this problem:
>    qemu-system-riscv64 -machine virt \
>    -kernel Image \
>    -append "console=ttyS0 root=/dev/vda debug_pagealloc=on" \
>    -nographic \
>    -drive "file=root.img,format=raw,id=hd0" \
>    -device virtio-blk-device,drive=hd0 \
>    -m 4G \
> 
> This series makes debug_pagealloc functional.
> 
> Nam Cao (2):
>   riscv: force PAGE_SIZE linear mapping if debug_pagealloc is enabled
>   riscv: rewrite __kernel_map_pages() to fix sleeping in invalid context
> 
>  arch/riscv/mm/init.c     |  3 +++
>  arch/riscv/mm/pageattr.c | 28 ++++++++++++++++++++++------
>  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> -- 
> 2.39.2
> 

