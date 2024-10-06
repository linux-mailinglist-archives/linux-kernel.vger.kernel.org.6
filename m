Return-Path: <linux-kernel+bounces-352395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD35991E7F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B9F1C20B43
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0808C176FDB;
	Sun,  6 Oct 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPSwuRJC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E77170A3F
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221355; cv=none; b=FmGWdW8jivHU5aSppPcv+i6LHZMbA3yyy1NvI69CBpioNqPI2O7Sm/hZbWF8bwvn5HUSqgrdzffVj1/8nZTTbFaBnEP1DR9SF0fGFxoXwVk4orLCu24tm8hKf7A7Qy6TIiVi8bTqJD7eNNDHKF1xMhZn8yrhulo5JIcXTsVCSjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221355; c=relaxed/simple;
	bh=JkezCXci0FhDh/r6gOCJZzc3+278ITOevezbT4aBxLU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z/o03HwxqB/EmMNxm2orHilXiA+22BmgPywjYf1QaXxARuoODDIH61rvijlv0XOF2rj6TNRYvocjlx59+dWjSkbln1/QK0t2yNNniPor3j0oz2+HOysKtIlTc568qVkRc7SZSjYWXaqcsycv47P3kGYqaxOfuulawu1Nmpg/Yv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPSwuRJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EABC4CEC5;
	Sun,  6 Oct 2024 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728221354;
	bh=JkezCXci0FhDh/r6gOCJZzc3+278ITOevezbT4aBxLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EPSwuRJCldO53+ZotSJ3frgqm8YOBG30DJus2fiLurymQr4dhYZl9VUR/0PoxELZQ
	 +Y6yhHBrOufmMbDA6Xu7OlzpcEfbqXZHKOXA1PYEx8aSWyOtGSiJw0l5e2IElOm+e+
	 LXeb+5hxb9/M9FndLt4g3+eJJJKJXdzNXNjCyWDLwIIEMo86R+UHmVThAMI25lP4oR
	 LlZAg6wSxIDSuB5KUVnW0ap661Hg4hTqIDRQD3twoLKm/j1/AtOW5+EWHKUBa5jtyf
	 PJB6FPVoIjR1jBFhObcGVeZD+eaO0lsmqbkfbGRK3u527RFzoFV4Oduz7hdj7gY+GW
	 /t1pYQlmLsUUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC43806656;
	Sun,  6 Oct 2024 13:29:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] riscv: Per-thread envcfg CSR support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172822135876.3395169.3761438771827436861.git-patchwork-notify@kernel.org>
Date: Sun, 06 Oct 2024 13:29:18 +0000
References: <20240814081126.956287-1-samuel.holland@sifive.com>
In-Reply-To: <20240814081126.956287-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com, leobras@redhat.com,
 aou@eecs.berkeley.edu, xiao.w.wang@intel.com, paul.walmsley@sifive.com,
 charlie@rivosinc.com, linux-kernel@vger.kernel.org, conor@kernel.org,
 conor.dooley@microchip.com, evan@rivosinc.com, guoren@kernel.org,
 andy.chiu@sifive.com, greentime.hu@sifive.com, cleger@rivosinc.com,
 tglx@linutronix.de, ajones@ventanamicro.com, ke.zhao@shingroup.cn,
 debug@rivosinc.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 14 Aug 2024 01:10:53 -0700 you wrote:
> This series (or equivalent) is a prerequisite for both user-mode pointer
> masking and CFI support, as both of those are per-thread features and
> are controlled by fields in the envcfg CSR. These patches are based on
> v1 of the pointer masking series[1], with significant input from both
> Deepak and Andrew.
> 
> [1]: https://lore.kernel.org/linux-riscv/20240319215915.832127-6-samuel.holland@sifive.com/
> 
> [...]

Here is the summary with links:
  - [v4,1/3] riscv: Enable cbo.zero only when all harts support Zicboz
    https://git.kernel.org/riscv/c/1b57747e978f
  - [v4,2/3] riscv: Add support for per-thread envcfg CSR values
    https://git.kernel.org/riscv/c/5fc7355f0137
  - [v4,3/3] riscv: Call riscv_user_isa_enable() only on the boot hart
    https://git.kernel.org/riscv/c/368546ebe7e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



