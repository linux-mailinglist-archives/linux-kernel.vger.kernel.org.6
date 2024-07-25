Return-Path: <linux-kernel+bounces-262233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD17093C2D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6AB1C2141F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392819B5B2;
	Thu, 25 Jul 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS8Ydb5D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A91F19B3C1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913639; cv=none; b=OO2weVuRCSt1fGrfxdFfgtjaFuimaexL2FeR/o942G+TBSbcQazXY1kAR+ojj1JVR0B50fRCLHdQ/Gx2IeKh89X1s3VP2NO0ySrAnxXKoP95w4KbuCVSAq02Fb17EriLXWDxnPkuWVUMe1qGr2GU6CB5dasUJ1lBBAdij/R00uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913639; c=relaxed/simple;
	bh=hoQiJY9BOtutRnP8ZDMMRSTBIBRxgWMbA8kX5W35XC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XKrLQxKKGPS8ZLQzFF2kxHu4FuSpv/VZZQMGuCPI4/93d+7volk8ffSioY8BEE4b7MMGlLyISHTs1HvXJzLWV4gJ/e8Qde942tSKSFQEzR86WRtSmQaVZrcWzoAHhrDy0BG/7flcvQSA/tNsWk5RXuc5m9TJN24IS8L8POpSnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS8Ydb5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B5A4C116B1;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721913639;
	bh=hoQiJY9BOtutRnP8ZDMMRSTBIBRxgWMbA8kX5W35XC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OS8Ydb5DlSPEE9Y9icrNPqRCwLigh1hRBDg0V8XYTqZFmjqt/vZyZUTLpJny5GMxD
	 p1pg3Vf6woqO3DMZPCiE2flqQTN3R0h7ly7z8kPAb8u16TigUW0+IXlF4B/IgiQYwu
	 5LQ/l1VP6ilYKgLp6Ydbck0jmuOCKUUpgOQHlb3KyGfKqh03huwmkfD+D89J+DOZP4
	 FNKLFnrwt9NoARtb2K0fnBQRB6vCJdAGP4DtBKOCLzjWH59LjiByDDFrhJx04FPWwD
	 dTMIOLV9FUmC3nI6aPFyLNHtSdUeHCX5EK2y2KucYnOKk6ldmt42OgXREVvOfBvfaX
	 0bsYGV6wsIgEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F023C54BB5;
	Thu, 25 Jul 2024 13:20:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] irqchip/riscv-intc: Remove asmlinkage
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172191363918.6240.8119408289460257884.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 13:20:39 +0000
References: <20240614151955.1949-1-jszhang@kernel.org>
In-Reply-To: <20240614151955.1949-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, anup@brainfault.org, tglx@linutronix.de,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 14 Jun 2024 23:19:55 +0800 you wrote:
> The two functions riscv_intc_aia_irq() and riscv_intc_irq()
> are only called by C functions.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> 
> Hi riscv maintainers and all,
> 
> [...]

Here is the summary with links:
  - irqchip/riscv-intc: Remove asmlinkage
    https://git.kernel.org/riscv/c/96333a020615

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



