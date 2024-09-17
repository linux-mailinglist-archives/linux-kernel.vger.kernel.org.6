Return-Path: <linux-kernel+bounces-331922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FBE97B300
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9691F22A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A972D185B52;
	Tue, 17 Sep 2024 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qfgt2Dga"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464017C990
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590636; cv=none; b=lUpzTf3E8EUpmyf6yt4NyXJERy731McOyLG9FT8D2SNpGSVOG7yEOi24Xjj6FsqKiSGESNSZtC4UTmKV6wuBbbPacVtpPNmGMq9n52w2ZxAuWh/xECs325RQwab3fwr7hKdGfFGqyUNrVE+BjTr7yI4HiU8g2TjPCk2JIBCQ6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590636; c=relaxed/simple;
	bh=lp76d/TPZKlYblD+Lxh9elSyGKFOamh6gIPS5YpuIy4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GivEGbhJOtLkj9RsTfU8kPei2qOff9atkAr9dvGLkzuys7ptqpksYiHbz9v6PVE3CZZip7a7ryBnVAA54CbjQsHaSoG8aXT8om/OiC3UmKp84YHw07dIs+z4aNOZgUlZm0VzsfjVRXclqs7tFj1/rD8PgUqwCC1AEUdjk4NSGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qfgt2Dga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90503C4CEC7;
	Tue, 17 Sep 2024 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726590635;
	bh=lp76d/TPZKlYblD+Lxh9elSyGKFOamh6gIPS5YpuIy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qfgt2Dga75Wfn+yRt1adZC6YxdGF+wInN9mL1ME/yzDxdzrcAAOdey9LI6jP0VPpp
	 WRgNqsbQdGhsxlQDK5NfJAHLLJTEzj3SirpwqtPGQFu1Js7idYEUSDjjVBeldoDdDE
	 kwv78ql2Mlc5+969vuuxCMTYQOaQuB3V/JMNtwfjrnXNj5vgMVQODy+u6VataYemES
	 Q7GcBIgTWQAvfmvs33VLqNN/av6bqx28vrNJkf9JSbERz9/pDGP7DYiHPiQ58GslFE
	 mDQcIDXmb02xjJarhD2GYbFrIaLHIMa8NCGnfIBbaQUsRx0rGZEZ7lpau6J9H8oHdX
	 V94OHERudae4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7119E3809A80;
	Tue, 17 Sep 2024 16:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] RISC-V: Implement kgdb_roundup_cpus() to enable future NMI
 Roundup
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172659063700.214459.15823238572969686332.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 16:30:37 +0000
References: <20240727063438.886155-1-ruanjinjie@huawei.com>
In-Reply-To: <20240727063438.886155-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, samuel.holland@sifive.com,
 conor.dooley@microchip.com, takakura@valinux.co.jp,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 27 Jul 2024 14:34:38 +0800 you wrote:
> Until now, the generic weak kgdb_roundup_cpus() has been used for kgdb on
> RISCV. A custom one allows to debug CPUs that are stuck with interrupts
> disabled with NMI support in the future. And using an IPI is better than
> the generic one since it avoids the potential situation described in the
> generic kgdb_call_nmi_hook(). As Andrew pointed out, once there is NMI
> support, we can easily extend this and the CPU backtrace support
> to use NMIs.
> 
> [...]

Here is the summary with links:
  - [v2] RISC-V: Implement kgdb_roundup_cpus() to enable future NMI Roundup
    https://git.kernel.org/riscv/c/983f12149942

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



