Return-Path: <linux-kernel+bounces-187645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4415C8CD5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75ECE1C2168E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29E412B16E;
	Thu, 23 May 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHg+mVoH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044701EB27
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474635; cv=none; b=DezRHB9u9SzFkVtMs1ECKTu9kWjUrIRJYeAWqG4HxWUKCMLWzdOfbuLQzgeoj+qmGihNY3Z/VFSPK6CZHWIlv2FwqZrS+ViQuqESMHtNWGoBur5FLw+M30Ey18Tsx6dn/B51B+ODvOZvGCg1m2AwsweWTktOfsce1zrrYM0qt3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474635; c=relaxed/simple;
	bh=kyEDd/AlBKPnFpb2BVcpuawq/vb0mkkfXT6dC2QAPMk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mV1Yn7zMdh0hG97dMx6LOukLZxn/fZpm5RcpsvbSkHlw2gmVuwPWeE44KZ01lxlarwIytJ+OBAYMvT4hJkcbUSiDcKLIj/RDe9509Ogq6RNxWEiNyJ5NqarrwelH4GQw8q0DQn75wbpH6v7WEdIM5HGQ6E87dGemr6XArKXJOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHg+mVoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A4C7C32781;
	Thu, 23 May 2024 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716474634;
	bh=kyEDd/AlBKPnFpb2BVcpuawq/vb0mkkfXT6dC2QAPMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DHg+mVoH1RuAbp9QivsAdXMZdA20VtYjZ2mPRRd9IRY0+pUtTbotRgZxPR7rgenp8
	 FiiI6i/u70WmaiBsygzHh+nePJmGuQJnyEE4+xXCKCInas/RsjcEnKRMkqE+rofVIs
	 N/m4IGCNbN1vb2D6uWw4eXBMGC1LBVajIh4qo9TWzr6uhBEzGTGj/ksO/fVfzKrRya
	 6XClpKzjF4fV83kaTnSiAaljr+GusgJnJpmOj8ncm8+MT9FZ2vVxyEZ+JN9ue55nGK
	 yl9R7pWQKkygal0ytNMyf5lPIy+rJL/HRgoibVIoIzeSbuSEZOc0ftghSZ8hwQN+FY
	 TWE4rey6O41dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 602B2C43617;
	Thu, 23 May 2024 14:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] irqchip: riscv-imsic: Fixup riscv_ipi_set_virq_range()
 conflict
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171647463438.13050.6219786365640043025.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 14:30:34 +0000
References: <20240522184953.28531-3-palmer@rivosinc.com>
In-Reply-To: <20240522184953.28531-3-palmer@rivosinc.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, tglx@linutronix.de, anup@brainfault.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-kernel@vger.kernel.org, tjeznach@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 22 May 2024 11:49:55 -0700 you wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> There was a semantic conflict between 21a8f8a0eb35 ("irqchip: Add RISC-V
> incoming MSI controller early driver") and dc892fb44322 ("riscv: Use
> IPIs for remote cache/TLB flushes by default") due to an API change.
> This manifests as a build failure post-merge.
> 
> [...]

Here is the summary with links:
  - irqchip: riscv-imsic: Fixup riscv_ipi_set_virq_range() conflict
    https://git.kernel.org/riscv/c/46cad6cd9b10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



