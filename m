Return-Path: <linux-kernel+bounces-331724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F7D97B079
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D49289FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4E4188A2C;
	Tue, 17 Sep 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMzTIpXb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2D917278D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578051; cv=none; b=pz2s+keGfDfrNMayAB2x/QkpnPsbK99d/YLFiJpfrPDxGSLlwmidnc7oRRm7MExOOFNHk0IcCgxNa+9B5gxGFIyU2amDftTdf/qe9puO46mgR2FD5NtP1R08QsLqD0mK4lSNidj+SJvfEG8MhQ6q9OvqJhHoF6wY5k+5mGrmyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578051; c=relaxed/simple;
	bh=Q6+9RPMnWXw7ty1d3wppsdJNDMw93d6I2iASc3TKGVs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qak0szYVDPD9TcJOQA9s3uBcvVC4AmsgU0AqyaRTi4s9C32AQC8AudxaMD2zyLtZmXk3vr/c0/IztJH8BnU0JFssYWW1Ip7FAkwDFXx9dp7KptmmMdglRqQBbS5Eu6fpxi1n1L+iFXUbL8XAF4VZYeW2yVvbZZz5eRW4ZJ52wJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMzTIpXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1EFC4CEC5;
	Tue, 17 Sep 2024 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726578051;
	bh=Q6+9RPMnWXw7ty1d3wppsdJNDMw93d6I2iASc3TKGVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CMzTIpXbmef+awfETv2iG2KiMB2Sb45MD9fjKeISVtRC0qQy1aD+sRJ60m3VRHL46
	 8IU9uf1YXHLUkpTmMkLTP72J6OGvisiwgEeBcQrSKfYs6tuyh55t8dSw9ZWAGb271N
	 xEet0IOPgoPEPFw/lPyMgusl5IAKVj87iFcHIgTR0DyZ0PXCBf1TQ8UwC8b2jdiZPE
	 6zMPLVmGjLVHKzk+KQfyfFo78nZCY8iCrtxKhzi/pkiZp33CFSsvpzqIfTMv2x0K38
	 8lNZ2AH5gJ+9ZZvwmWk2A2eiVzK+tm5fxK7T569IjBjlO1oYVGtMD1uZiJu3fii6sA
	 6mzcKhnYFLSOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFE63809A80;
	Tue, 17 Sep 2024 13:00:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] riscv: select ARCH_USE_SYM_ANNOTATIONS
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172657805249.126252.16379053409750992964.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 13:00:52 +0000
References: <20240709160536.3690-1-jszhang@kernel.org>
In-Reply-To: <20240709160536.3690-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, cleger@rivosinc.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 10 Jul 2024 00:05:20 +0800 you wrote:
> commit 76329c693924 ("riscv: Use SYM_*() assembly macros instead
> of deprecated ones"), most riscv has been to converted the new style
> SYM_ assembler annotations. The remaining one is sifive's
> errata_cip_453.S, so convert to new style SYM_ annotations as well.
> After that select ARCH_USE_SYM_ANNOTATIONS.
> 
> 
> [...]

Here is the summary with links:
  - [v2,1/2] riscv: errata: sifive: Use SYM_*() assembly macros
    https://git.kernel.org/riscv/c/6868d12e0205
  - [v2,2/2] riscv: select ARCH_USE_SYM_ANNOTATIONS
    https://git.kernel.org/riscv/c/7c9d980e4670

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



