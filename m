Return-Path: <linux-kernel+bounces-250524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DC192F8D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C6C1C2149A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE3815957E;
	Fri, 12 Jul 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuCJckfV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9DF152500;
	Fri, 12 Jul 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779633; cv=none; b=GyngVUEuWDwdcW1ReeiMcAjwg3gmoiyAaFZSPu2NfSAhjIAdi5+/l+rYHnlaLmyIz+4/e4utlJ3+brpjlL8BrAvLWwyxsU5SGc084KP4m1Q8YmnD7DVpzYvbxZ7OlZdpMQ1CzZ31z4Q3jon8fjSAOEMSp68YvUvRv5R0FF1cUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779633; c=relaxed/simple;
	bh=VVoIxpcBpsu5DTyIieNUadbasv+xGN5WhTLbUa6mR/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lZ1lqtg80/x17W1ZwNJNVOyja4jYyr8DW88RUW/jLl9db/cSheCF6h/Cwd7tb/xfaeD0TTIHKXrN8DRPVEvmC2qKp7MYY3Lq3iS8i6Lr3Cc6XhKu+D51xOPJZkMK5i3S661lkZopq3ZXjWOkw8+3d5TI3CDcvcu5mffA3DF1n/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuCJckfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3984C4AF0B;
	Fri, 12 Jul 2024 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720779632;
	bh=VVoIxpcBpsu5DTyIieNUadbasv+xGN5WhTLbUa6mR/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HuCJckfV+Y2YomYDLLyNFm4QYZDL+JVt6WlrvWFNYv6yVHh+6d8bHsc2cHao9BEVH
	 7+E5qsJrddW46aPiQAOXRfzEHH1QqtIIybderNU55GqK6rQJTon8+Zx/clW7BIkc1m
	 b5VBcEAyekiCYDfxuO662s8FQXmWEecRNfBw9b63v2EiczLsNSsrsaatrWkwY3RWFZ
	 AXhm4TZtuLKSkDy/3obgSBFF/UuPVIfScVJggzpu3/xoTWaV450mdXkWhUppfUQJfF
	 SrWD0hBQ7HXir7SIl28OHO2epJ8m/fkNAZEV20EujfQPjAF/A1C7Gu0JV6flCEimTN
	 j/JbUo4xYZn+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90E99C43468;
	Fri, 12 Jul 2024 10:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] riscv: hwprobe: export highest virtual userspace address
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172077963258.4770.205626830375405089.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 10:20:32 +0000
References: <20240410144558.1104006-1-cleger@rivosinc.com>
In-Reply-To: <20240410144558.1104006-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rehn@rivosinc.com, charlie@rivosinc.com,
 sorear@fastmail.com, jrtc27@jrtc27.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 10 Apr 2024 16:45:57 +0200 you wrote:
> Some userspace applications (OpenJDK for instance) uses the free MSBs
> in pointers to insert additional information for their own logic and
> need to get this information from somewhere. Currently they rely on
> parsing /proc/cpuinfo "mmu=svxx" string to obtain the current value of
> virtual address usable bits [1]. Since this reflect the raw supported
> MMU mode, it might differ from the logical one used internally which is
> why arch_get_mmap_end() is used. Exporting the highest mmapable address
> through hwprobe will allow a more stable interface to be used. For that
> purpose, add a new hwprobe key named
> RISCV_HWPROBE_KEY_HIGHEST_VIRT_ADDRESS which will export the highest
> userspace virtual address.
> 
> [...]

Here is the summary with links:
  - [v5] riscv: hwprobe: export highest virtual userspace address
    https://git.kernel.org/riscv/c/c9b8cd139c1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



