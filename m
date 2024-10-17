Return-Path: <linux-kernel+bounces-370647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FC39A3010
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A5B289613
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E041D7984;
	Thu, 17 Oct 2024 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQZe+uS3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4C1D040B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201823; cv=none; b=sPYsf7jHkhu62eY1r/vZIO19zKNNKoMdMrjt5k4jiWwuMjnQ4w7e9yAEX343Oa6I3x4YN5diwpWpcoNLAnmy18ssIh/frJ8N54KRIGpMf+hE06vgnCL+ktAm14uqSTJIPjkCy11nSHENI3qg8jap1OnOJNg0bicTywAzu0b6rlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201823; c=relaxed/simple;
	bh=aeO5mqalDieTy07wPVN1K2wEr9dfLnNXATvctaHt+UY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZBmwecZKrJBo0njxx+CL4NoSltyGnpGb0KkERnK5jDW+AjPRJ88dKacte0LFNpuAMMwCzCrpjnKKfN4jmWa/ctGGPxAkL8w6rADXmJTvh+++zZ/jc3RmiAuQ835Um0G8LEaK/Fn7EiFkMSnV6x7QDUpNvhl5NJVNwlcDh5Noasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQZe+uS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4154CC4CEC3;
	Thu, 17 Oct 2024 21:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729201823;
	bh=aeO5mqalDieTy07wPVN1K2wEr9dfLnNXATvctaHt+UY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sQZe+uS33wAnjFiNSuQyi6HRtmK46li8pwEbOkAciHQq+NdyLt7VaVy2kzPpoxJAk
	 WWMQkUe5NCN7QQ1N9Sjh3ijrWSvy7HzTQEjo6f1+WIhT4ehzs3nSmzpPtqaHlWvh5L
	 MCg6HVoStLCSHfe0eWpGNZZr/l4OrxtjgJUi0uHRQot5zaskb/fnRN8FxZ5Nn/560C
	 Bf2Oj2kuuc+8FGAYZopWoMyeq5hiC0eTnCNQexQsGu8eNKOCLFoMiD5o+49yBmuMBj
	 ld+u+6vxIWQs27L6st3aEauJCuIArF1FV2Td6ebrwENy2pUuEmyRofrAPmFn3/Ofrx
	 o79T5JOHbBhug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECE3809A8A;
	Thu, 17 Oct 2024 21:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND. PATCH v2] riscv: Use '%u' to format the output of 'cpu'
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172920182876.2615893.11531053005712444726.git-patchwork-notify@kernel.org>
Date: Thu, 17 Oct 2024 21:50:28 +0000
References: <4C127DEECDA287C8+20241017032010.96772-1-wangyuli@uniontech.com>
In-Reply-To: <4C127DEECDA287C8+20241017032010.96772-1-wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, samuel.holland@sifive.com,
 conor.dooley@microchip.com, charlie@rivosinc.com, macro@orcam.me.uk,
 palmer@rivosinc.com, linux-kernel@vger.kernel.org, atish.patra@wdc.com,
 anup@brainfault.org, guanwentao@uniontech.com, zhanjun@uniontech.com,
 tglx@linutronix.de, peterz@infradead.org, mikelley@microsoft.com,
 oleksandr@natalenko.name, deller@gmx.de, gpiccoli@igalia.com,
 apatel@ventanamicro.com, maz@kernel.org, kernelfans@gmail.com,
 jszhang@kernel.org, daniel.lezcano@linaro.org, Alistair.Francis@wdc.com,
 atishp@atishpatra.org, dwmw2@infradead.org, mark.rutland@arm.com,
 sabrapan@amazon.com, ross.philipson@oracle.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 17 Oct 2024 11:20:10 +0800 you wrote:
> 'cpu' is an unsigned integer, so its conversion specifier should
> be %u, not %d.
> 
> Suggested-by: Wentao Guan <guanwentao@uniontech.com>
> Suggested-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Link: https://lore.kernel.org/all/alpine.DEB.2.21.2409122309090.40372@angie.orcam.me.uk/
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Tested-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [RESEND.,v2] riscv: Use '%u' to format the output of 'cpu'
    https://git.kernel.org/riscv/c/c05ad457ce8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



