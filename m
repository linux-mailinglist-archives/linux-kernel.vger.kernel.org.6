Return-Path: <linux-kernel+bounces-232815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A621A91AE8D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA321C21344
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4A219F477;
	Thu, 27 Jun 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGnPyufg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4419B3DC;
	Thu, 27 Jun 2024 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510657; cv=none; b=V+k62c9Os+iPOfVePgEb93PLfRJEet8MkvrM9BbQD2OA8eTCSiVOsjEDyw0iDf0Ze5NivfRPlUFrTSSwTEp69Lbc/W/5JAxB2xMP6s10NEQN2jK158B1nNDwLeU5B0+T80ISjclkahKtth8lAJzoc/7DaeYRKVxlwwggeLsTzaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510657; c=relaxed/simple;
	bh=aEmY+usoEI0JCLbYcZGViK6r8rPMlyAeGBCWtdOs+Ig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gvn0PIZno6auBrqdybHIGpt/sIjTmEI+wUd8yeTeRmuW9s+BKSSPt5BtfiONuqbbxln6+XT0sI1v2yGdJtEFNFkczgoeqSB+O7GxbAED4yJAMiSRI5BLP3vGZFbf5lw4Wu8f+C/XNleut00OyVrx/+ioZUjsHVDaQdEy7fqhOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGnPyufg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD36EC4AF14;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719510656;
	bh=aEmY+usoEI0JCLbYcZGViK6r8rPMlyAeGBCWtdOs+Ig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EGnPyufgOJ4Y9Rs8F7kwwOdwhS+bQgguOfKrrJIZBbTa5uxnvZqznlBjrRpBCGBnV
	 k5XP/3S35nI0Wu8/9U7JxPdgtTuf1vlM5OVvb5X/1u5ieZcOkP2Bz3LCE7q8wIDgdu
	 YIZ5YJobggGuX84AsT/quvLa85blZ6oTzHmrltROmVr5jgyAJgamuJ5/2uT2dhfDFj
	 Wb7KI9XgzhzRK0XLS9BngyYu3ww6sJM5iZFMqs8goXWI7Q92l2djZDm7UepQUnsJAq
	 QmYWEBGfnUkv6ywkj7Ym5Nj7k4Gjb7Mzez0LwhNI3t0x/P60l9ybF4C7n0OAdpB/OM
	 wdzAryF8DZTUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B415AC43443;
	Thu, 27 Jun 2024 17:50:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND v4 0/2] dt-bindings: interrupt-controller: riscv,cpu-intc
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171951065673.6762.2519132722674117186.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 17:50:56 +0000
References: <20240615021507.122035-1-kanakshilledar@gmail.com>
In-Reply-To: <20240615021507.122035-1-kanakshilledar@gmail.com>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: linux-riscv@lists.infradead.org, kanakshilledar111@protonmail.com,
 tglx@linutronix.de, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, samuel.holland@sifive.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 conor.dooley@microchip.com

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 15 Jun 2024 07:45:02 +0530 you wrote:
> This series of patches converts the RISC-V CPU interrupt controller to
> the newer dt-schema binding.
> 
> Patch 1:
> This patch is currently at v4 as it has been previously rolled out.
> Contains the bindings for the interrupt controller.
> 
> [...]

Here is the summary with links:
  - [RESEND,v4,1/2] dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dtschema
    https://git.kernel.org/riscv/c/9ff141042a62
  - [RESEND,v4,2/2] dt-bindings: riscv: cpus: add ref to interrupt-controller
    https://git.kernel.org/riscv/c/1f6e218859f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



