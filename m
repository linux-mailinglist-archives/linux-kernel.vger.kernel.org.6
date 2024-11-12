Return-Path: <linux-kernel+bounces-406818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644399C6487
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281BD28570E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 22:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E221B436;
	Tue, 12 Nov 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze7rsffx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCED21A704
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 22:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451980; cv=none; b=YPQLnCUIVR+nWyql9Zl2/EvmdrpHTkTF8II8A0fRaf73OlEBrh+DnMzL0LFgKdeihougbMGVRoJSZroAWdlKYPn9SHG4Qx87gGBZnbiAe1F2PrfheB0ma3bU4DQ/1u5ro9bpIM+EI2x8SJXWtUMqodrkGm/SW9yIO6ItPVCQCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451980; c=relaxed/simple;
	bh=gPrcbKEkR5xI3fKzMDfEfxbVhXi4GE3kfIX4m7/OQRY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dnQwAuC3FD1P/qIRAFfHU4qaHBnNlac6dUAioabS3NxAynvft4HFKWw9fLSz1NLHCBPjs+8aqYIMVKTxiPTIjYCIoc1LKZ1zqBvnZB7YFb5EV4qazkuN9Pk6cQh94/F1h72NZ0cLZFbLmUNzQ0b9st7k9BSbrmrXP1FKzQ1/8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze7rsffx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73584C4CED5;
	Tue, 12 Nov 2024 22:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731451980;
	bh=gPrcbKEkR5xI3fKzMDfEfxbVhXi4GE3kfIX4m7/OQRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ze7rsffxypXgJtwH605Oegc5j1gP/qGYYO0jhNzjzv+Xcf0vIr+DjheOZKxqCfs4S
	 zE05OemsjPMg23jDtBy+/tNguk037Lk4UQ4VVGa75q7GCtrmxvxEf3Yt5rMmtzdWXW
	 yJiudyXUq5LeEntD+wTMYNe+WXygGac0Wa4bWz4VeYLA9bDQ0B6jmGnA3roet6HThO
	 tDEIxHhrqrf8MsspVvtMaa1ZvZHNFDOsqWf+NHw+YFydhoytExXxxIt1RhSjypY8Lg
	 SzDcosKDNjx/idPing5yKU5O7upE2JcKwqD4qpWKtz02OdajNpE66qP340E3fxQbKT
	 V+EYMqJKHseCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACF23809A80;
	Tue, 12 Nov 2024 22:53:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] irqchip/riscv-imsic: Fix output text of base address
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173145199075.701548.7255466685517081428.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 22:53:10 +0000
References: <20240909085610.46625-2-ajones@ventanamicro.com>
In-Reply-To: <20240909085610.46625-2-ajones@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 anup@brainfault.org, tglx@linutronix.de, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu

Hello:

This patch was applied to riscv/linux.git (fixes)
by Thomas Gleixner <tglx@linutronix.de>:

On Mon,  9 Sep 2024 10:56:11 +0200 you wrote:
> The "per-CPU IDs ... at base ..." info log is outputting a physical
> address, not a PPN.
> 
> Fixes: 027e125acdba ("irqchip/riscv-imsic: Add device MSI domain support for platform devices")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/irqchip/irq-riscv-imsic-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - irqchip/riscv-imsic: Fix output text of base address
    https://git.kernel.org/riscv/c/4a1361e9a5c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



