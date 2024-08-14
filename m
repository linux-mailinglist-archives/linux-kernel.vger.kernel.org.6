Return-Path: <linux-kernel+bounces-286580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 650EA951CB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6929B23E48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB861B4C46;
	Wed, 14 Aug 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjmJ2jaL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10091B4C34
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644637; cv=none; b=trnlyALY1FVGQyHpXjiWs1SO+bzM1wZH0huJTWQu5UBWqG3FPct3RR7JGRf0W9A3CQzuQXz2LyyljjFqWFeqw1CQ6gk3I2VcYdpVM0bQ9NPIF2b7mPSL7MJGt4KfgPfJxpwBoJPHQuRck1oEJYU9WgsU/Z/biXB4412OfIDEN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644637; c=relaxed/simple;
	bh=YwGJUc3Z94a2A/QpganPxW/sR2FdyfIWklhxVLiY1pc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qfAgHUAUzXOQN/vuxt/Kpj1DD6h+1ozblpdt0vpW2vthPen1oE2X7+b/6yOdRSbJhit6FCNB2xBNltsBWkfAghQeR+B4Vx167+bPl4L1pFddIjQtLtgRDzIRH9XFK4YtwarRn7b8n5dlTqEMWleCnMcKOGPHp+ZvDFva9ayGui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjmJ2jaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7E3C4AF11;
	Wed, 14 Aug 2024 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723644637;
	bh=YwGJUc3Z94a2A/QpganPxW/sR2FdyfIWklhxVLiY1pc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MjmJ2jaLU84+pDD5IquIjGIfwNDdEU8xQNthDY2vnRfi24oF1gp+NukNp8OoXfuDV
	 jD4dcWuqouGxtetTgAtDRqHWkXrIHiWK3mj20cSttAKzc+QEanUl9RASmAaSU4j5cm
	 /rPXK5XUc+mZZWxM9QK9nwsYxlq9BZQqu2OfESgcYfu+ZlLuRqYGG59EzHClrHTUL9
	 KfH2EEFnQv8S3uRtDTkSICuDAUHSTtsdlUOrlXUTahgxNWDH1wYlg7QDvpbBYU1JPW
	 tvmyjna3P1J7jY0wsOJtm7cdt0tVw3HkSzBQb2p5zra/2Vhq6O++y51raBEco1Tz59
	 WaAcp1FoDYP+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF338232A8;
	Wed, 14 Aug 2024 14:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH] riscv: Enable generic CPU vulnerabilites support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172364463625.2278280.12786224959163993278.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 14:10:36 +0000
References: <20240703022732.2068316-1-ruanjinjie@huawei.com>
In-Reply-To: <20240703022732.2068316-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, samuel.holland@sifive.com,
 tglx@linutronix.de, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 3 Jul 2024 10:27:32 +0800 you wrote:
> Currently x86, ARM and ARM64 support generic CPU vulnerabilites, but
> RISC-V not, such as:
> 
> 	# cd /sys/devices/system/cpu/vulnerabilities/
> x86:
> 	# cat spec_store_bypass
> 		Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> 	# cat meltdown
> 		Not affected
> 
> [...]

Here is the summary with links:
  - [RFC] riscv: Enable generic CPU vulnerabilites support
    https://git.kernel.org/riscv/c/63dd775cc050

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



