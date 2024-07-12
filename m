Return-Path: <linux-kernel+bounces-250523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CCF92F8D2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87581C215D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC3E1591FC;
	Fri, 12 Jul 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxBirr1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B99514F109
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779633; cv=none; b=HF9iFMeQxGecunD9FxgCzwNwKiyaI5IaKZbVF5OgVmjODJVR67ZDzMnRnLYo6XgRgEmDhVkov/uE1yrtipxP11dreovZxEFcmE6ainiysDwhlUjdbeHbmcBeknb0NJGe5+gitQkM5WvaTfs9HmGoCxFOXHcWWvHzzClDRL4Q6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779633; c=relaxed/simple;
	bh=z7JPQE37pSyjNSZtNlu6IO/vJDtKDa4C76kcC+2CYrY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jlX31PamWLIuCV2StQ7FbpMi+F1pA/ECVP0aYpAAvcTStGBT3IFJMBX8zM/c2rg7UX1AzhgZswKTmtf75J42sR4b3CTVdXiVuqHOJslTBMimSkqZqMkA04+LOXfp7sSCHMD4F2z7T0xsAvET6slr6+g39XvWhwYWwTztEQnEIFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxBirr1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA387C4AF0C;
	Fri, 12 Jul 2024 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720779632;
	bh=z7JPQE37pSyjNSZtNlu6IO/vJDtKDa4C76kcC+2CYrY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YxBirr1AcJPqVOzgNyhbrxe24kATHJg7cbH0n9efMvsjs0paONyjWv5pJRr7xNUMz
	 k4UBUKOjDFc+uzvFUglhrYkgxOYpPO56lNn9DS1Mp8JQphIrMg2OBpuDnYwLLEipAw
	 27WA0QdOfeE8hXXfl0RVr8HZx4JY4lhEJbupgmePTIGGev0i/rEAXkZX0LjwCJANkc
	 96NzZnO/RXH7MDUtMhzH1tb3a0oQdfxi7QSInwKpuM8s94N0fomduHQT4bEiy/+OgG
	 c6d/RWd6L6I2V7TOXOF0ur1dY0G9dKbXdddowSgd1ST49WKnjkm5MddDpBOeb9iyL/
	 VExc6Yi03xa9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F0A5C433E9;
	Fri, 12 Jul 2024 10:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: Add tracepoints for SBI calls and returns
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172077963264.4770.1010194114117186773.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 10:20:32 +0000
References: <20240321230131.1838105-1-samuel.holland@sifive.com>
In-Reply-To: <20240321230131.1838105-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 ajones@ventanamicro.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
 apatel@ventanamicro.com, maz@kernel.org, paul.walmsley@sifive.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 21 Mar 2024 16:01:25 -0700 you wrote:
> These are useful for measuring the latency of SBI calls. The SBI HSM
> extension is excluded because those functions are called from contexts
> such as cpuidle where instrumentation is not allowed.
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> [...]

Here is the summary with links:
  - [v2] riscv: Add tracepoints for SBI calls and returns
    https://git.kernel.org/riscv/c/56c1c1a09ab9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



