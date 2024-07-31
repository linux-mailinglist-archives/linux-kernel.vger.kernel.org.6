Return-Path: <linux-kernel+bounces-269651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9659F943563
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16809B2321C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDB244C86;
	Wed, 31 Jul 2024 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn9jpnbp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC71805E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722448832; cv=none; b=WmayaGRVQflcx71oC+noCi+JW90ppbh/GPK62qe6UkRBwgcTfFBQtRu0WOQ/2ixQAR5vLMDRFf7CZPNi60ACh4kTeQwUvcw/TF3N3ODwLN3ss8gH1kVw7g/9sVb8+KP0Nu6HPf7QgA3AiSdGnZnl1zlZJYYbKILYiyzWwm4I9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722448832; c=relaxed/simple;
	bh=QlnmxtwAARTZlkJz+Yt/175l065sJ6S1HGtyh0yi5yA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ui6bCOWfSXC2xe4Oq+Gs2GH0hgC6dB8UBusAn8wJfvVLHfRuZkoF63IwYQZ+ASQiIZ91qVTKSilSv4rb7OmJTWFvdZdHH9ZkkuDpZJsQf+2r7vdlE/Bc2EF3o05urS9wOHkIv+/yQdnVsEcbSm3ahXRxiWJzGlusMnVPVlG/P+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn9jpnbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C347C4AF09;
	Wed, 31 Jul 2024 18:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722448832;
	bh=QlnmxtwAARTZlkJz+Yt/175l065sJ6S1HGtyh0yi5yA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nn9jpnbpXSa6uOd5lzxbOqS22J8i017YYLVR6zp7IM1INroQ70xe3KRwbZXIuV+xx
	 HxlQQQWWG1wt9NG2BLaDbrg4RycPvdVfyR1eMZpEiLs0QkIw9LULbo1WDCwzji2Lg8
	 06NPTJayVe1vXo0dlUACGVkY07TWzdiatSmvoGLXSV3Qg4KB7nx0L5UDdmuwjEBggU
	 ZsNfkLJLaHkfLPIQey2J2Sd2ZOHGbpGm9TTEZ1TUfV+nR6+bL7V3/sb3PJnpKwkNIP
	 atV5SQc+vt6b98pNhA6/6QWkPHahyItcbLsnDQBSSUfAFEshW8AlpsGJkkyYtIKZkh
	 McgBPaFrfh7vA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF4B1C6E398;
	Wed, 31 Jul 2024 18:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: cpufeature: Do not drop Linux-internal
 extensions
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172244883197.728.4079912694148388299.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 18:00:31 +0000
References: <20240718213011.2600150-1-samuel.holland@sifive.com>
In-Reply-To: <20240718213011.2600150-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, ajones@ventanamicro.com, andy.chiu@sifive.com,
 charlie@rivosinc.com, cleger@rivosinc.com, conor@kernel.org,
 evan@rivosinc.com, paul.walmsley@sifive.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 18 Jul 2024 14:29:59 -0700 you wrote:
> The Linux-internal Xlinuxenvcfg ISA extension is omitted from the
> riscv_isa_ext array because it has no DT binding and should not appear
> in /proc/cpuinfo. The logic added in commit 625034abd52a ("riscv: add
> ISA extensions validation callback") assumes all extensions are included
> in riscv_isa_ext, and so riscv_resolve_isa() wrongly drops Xlinuxenvcfg
> from the final ISA string. Instead, accept such Linux-internal ISA
> extensions as if they have no validation callback.
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: cpufeature: Do not drop Linux-internal extensions
    https://git.kernel.org/riscv/c/b75a22e7d4f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



