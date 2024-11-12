Return-Path: <linux-kernel+bounces-405156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E29C4DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62094B22946
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C69F209F4A;
	Tue, 12 Nov 2024 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRTmibdt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74945208223;
	Tue, 12 Nov 2024 04:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731384624; cv=none; b=XwaBA0UNSj6wv91vhDs7OTGWXneFCYnffIRuunuW9zJODFFi5u+60JsOdnPZYff4KhFz8+0xNja6lS3KdjuzT4lsUu5J6Gb8y2/d+k+fZpD74EbPL71yah5WxVU824czIIAoWq/aTiU2lHnGaETXxVhUHbIgALwTne4cbbQfkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731384624; c=relaxed/simple;
	bh=lh0xRs7IM3ezSxOus7pb8rK+VwGfDLnRgzdslYSlvBE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N9osk+3DdiFtqzBgW8f/FjwBFtOJ8cBqP5k70cRLpKHEWY0aXoMaZMF7zN5vBzK7Q77z0vyd44S1GZzkzZXzy7Cp7doLdwuW5qdghxeDtyyrf6fHHoiBELy4CF48PErjKuZylrBgHxRqxzNYr2GOT6M5nf8kRciI2/NjwTJspp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRTmibdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C2CC4CED5;
	Tue, 12 Nov 2024 04:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731384623;
	bh=lh0xRs7IM3ezSxOus7pb8rK+VwGfDLnRgzdslYSlvBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aRTmibdtpojwdLtCkc4yeHwB4D23oN0urmuLL9JArdc9llfbDrsfGTc+6hJnCHBO0
	 HkmO6dV4gkL6qCVs+RZswr16LrXdakxia4CfCuRgnTMIsPnWrs13NaHtvQY1yuppRT
	 Gpz/7NBXbjJPnc3ATR1sW8rqnE50xGqUJPYpCb8/CL1dFHph9HztPEzx6Wosvs7lBz
	 tCm+kuKtDzbSIiD4T4ujYdF0j9xNaN2p9DL1qYKG+wFZAamESOnkc0yTFhVNq/4t/t
	 D6siog6ZtKWf2LT7TaJTZIK16sasuugYbw437f3c0PzggkFDTYy6XcHzv1aLPqUdyx
	 gC+NIv1Ter6yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA93809A80;
	Tue, 12 Nov 2024 04:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools/bpf_jit_disasm: Fix the wrong format specifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173138463374.76505.6826665797481169881.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 04:10:33 +0000
References: <20241111021004.272293-1-luoyifan@cmss.chinamobile.com>
In-Reply-To: <20241111021004.272293-1-luoyifan@cmss.chinamobile.com>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 11 Nov 2024 10:10:04 +0800 you wrote:
> There is a static checker warning that the %d in format string is
> mismatch with the corresponding argument type, which could result in
> incorrect data print. This patch fixes it.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> ---
>  tools/bpf/bpf_jit_disasm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - tools/bpf_jit_disasm: Fix the wrong format specifier
    https://git.kernel.org/bpf/bpf-next/c/4b1535420133

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



