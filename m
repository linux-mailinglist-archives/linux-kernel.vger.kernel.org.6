Return-Path: <linux-kernel+bounces-531486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FC3A44112
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D407AE0B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E4F2698AE;
	Tue, 25 Feb 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuVH1J1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7B26A1C1;
	Tue, 25 Feb 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490736; cv=none; b=gfaV0AVRPHFVHyzb/CZlOt3ZFq+zgGBveaQ9yW2Pp9/uUkI46gCVcpOXjjjprioKHalQhPQaQFbvOmmYodMFSOEHkYcvAK6GuHLNU+DPKA9FqFQBzTU7LjdVeCC3p1hAonO1xb9IzV+ZqUwMVAatadmoI+NVqeTZakJzr9xJh9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490736; c=relaxed/simple;
	bh=w7BtHlDsE/wNj/6FsWMNUTOpXSl/xAGx5czTS7gbsro=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=buV8SmdS8d+A3q8zMd6VYl5AaE9md92lQTuZSZjawSHmYPXAwHzF3ZfZu+OJ1o4G50du9V688AxRQxg/cvvazw3YNKbuDBS8HHaIQGVOcR8h0sUZQ2nJDxFC/9HNs5Z4So267RJMCSR0BMywPWuzeWHzWHoe2mMPW9Ks90lAxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuVH1J1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFBDC4CEEA;
	Tue, 25 Feb 2025 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740490735;
	bh=w7BtHlDsE/wNj/6FsWMNUTOpXSl/xAGx5czTS7gbsro=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=AuVH1J1i9uyNpC5b4VeLzwaHmMLldiBmSCC+XM4hylJmAvWmBRRxMG/rZdTTy1mFo
	 pjQQteuXqSRlEL+q4WaijfPkoSOmsVTMjZfGh/keTQ+rG3M95RIDCTd2mpsr1HyqWN
	 FpUpMYqcJ1RflInsQvQIQdFLmwEhgHlWr3algs8xZzUOWyy/RNDVUbw82fZtwzMFci
	 l1UaRLq9tjSm7m4XzZE25WzL6jtlUf7Xcq2KgA5dHRRmltm+tpLbhcxYO0MWFx78MU
	 qT2pEbjXbhRJFKwnPZ7YgBYINfqizVk8XYQuyMDAleCxcUHbvImltKmuYWXb42CVqs
	 tFtP2v1jzEabA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20250217010437.258621-1-chancel.liu@nxp.com>
References: <20250217010437.258621-1-chancel.liu@nxp.com>
Subject: Re: [PATCH v3] ASoC: fsl: Rename stream name of SAI DAI driver
Message-Id: <174049073341.42497.16361417560871466113.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 13:38:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 17 Feb 2025 10:04:37 +0900, Chancel Liu wrote:
> If stream names of DAI driver are duplicated there'll be warnings when
> machine driver tries to add widgets on a route:
> 
> [    8.831335] fsl-asoc-card sound-wm8960: ASoC: sink widget CPU-Playback overwritten
> [    8.839917] fsl-asoc-card sound-wm8960: ASoC: source widget CPU-Capture overwritten
> 
> Use different stream names to avoid such warnings.
> DAI names in AUDMIX are also updated accordingly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: Rename stream name of SAI DAI driver
      commit: 0da83ab025bc45e9742e87c2cce19bff423377c8

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


