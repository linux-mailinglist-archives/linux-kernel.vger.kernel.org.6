Return-Path: <linux-kernel+bounces-286577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740DB951CB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4331C24F83
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6C1B3725;
	Wed, 14 Aug 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exksjn/E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5721B374B;
	Wed, 14 Aug 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644633; cv=none; b=VLkcATL5/rh8TZ779LH1U27GUUVWnoypux1RnOnMsy9U3L6yx/6s74oVSrrTSFBO0jMxn932SQ0KpDDml/zDlTbigYGi2uZGTpv0j1KB6DpzZmOE9zuDZ+k6tQ9QlzPCuDUDtpHPCMNGATfcU5bC1eaXr96PJ/MSfkMoNDRjKm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644633; c=relaxed/simple;
	bh=KdgwpVZN4uMBbr71j9vE0petOsSpXyckYOOAL7K8sQ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l4wNav0BkBYEWcPyNZgwtZJVuCNmgPfJKsjvvhATxEystf2ldCvqSZWUgI8LSh6r1pfDradAU5KtkfhfnZbT6/oO5Ai8kI6pbgT+WwMuBymyiJoC9Qz8XcZ0WMMZdU22L/zLrjR/hw8QlRd7jYFYiPHZlAf/T4g8Mn+gXusi0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exksjn/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1472DC4AF11;
	Wed, 14 Aug 2024 14:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723644633;
	bh=KdgwpVZN4uMBbr71j9vE0petOsSpXyckYOOAL7K8sQ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=exksjn/Enaqn+WwSi1BZlTscDfpk98P3YHgxVXlHEQa83TlfoYkiYsdAHid2XdVVA
	 QIgEGMuoySCw69KG+0LfeZCem8NspAHXtUw6G4S3F9s6BeEA+xOPgWf0XMhfrgX3Zb
	 dSbPiituiEm127KRnrdO2JhJPMPoEgcP6l4cGItVJCbroNVD3ASDTNPkCO7TZVk7AC
	 MenuL1z2ndl5AKRGeg0+TMNnrY4U60ocblER3+OojkFAa02v6QHrBv99Y0ux0N7HvX
	 Dgeoqb5ZFzlTxgRnnyBxDBXZI3mWxGMeaeIlwXnimAqU3LbcPcyxQu4p6KFkTueof7
	 J7YIjOSnOpanQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EB138232A8;
	Wed, 14 Aug 2024 14:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] RISC-V: Parse DT for Zkr to seed KASLR
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172364463227.2278280.4833968885789479932.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 14:10:32 +0000
References: <20240709173937.510084-1-jesse@rivosinc.com>
In-Reply-To: <20240709173937.510084-1-jesse@rivosinc.com>
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, ardb@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, alexghiti@rivosinc.com, conor.dooley@microchip.com,
 masahiroy@kernel.org, twd2.me@gmail.com, christophe.jaillet@wanadoo.fr,
 samitolvanen@google.com, akpm@linux-foundation.org, bhe@redhat.com,
 rppt@kernel.org, vishal.moola@gmail.com, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  9 Jul 2024 13:39:33 -0400 you wrote:
> Add functions to pi/fdt_early.c to help parse the FDT to check if
> the isa string has the Zkr extension. Then use the Zkr extension to
> seed the KASLR base address.
> 
> The first two patches fix the visibility of symbols.
> 
> V1 -> V2:
>  - Add RISC-V: pi: Force hidden visibility for all symbol references
>  - Add RISC-V: pi: Add kernel/pi/pi.h
>  - Rewrite archrandom_early.c to parse DT over checking the csr
> V2 -> V3:
>  - Add RISC-V: lib: Add pi aliases for string functions
>  - Rewrite isa_string_contains in third patch
> 
> [...]

Here is the summary with links:
  - [v4,1/4] RISC-V: pi: Force hidden visibility for all symbol references
    https://git.kernel.org/riscv/c/14c3ec67236b
  - [v4,2/4] RISC-V: lib: Add pi aliases for string functions
    https://git.kernel.org/riscv/c/d57e19fcbf3f
  - [v4,3/4] RISC-V: pi: Add kernel/pi/pi.h
    https://git.kernel.org/riscv/c/b3311827155a
  - [v4,4/4] RISC-V: Use Zkr to seed KASLR base address
    https://git.kernel.org/riscv/c/945302df3de1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



