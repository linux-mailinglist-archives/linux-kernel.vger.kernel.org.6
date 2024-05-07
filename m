Return-Path: <linux-kernel+bounces-170551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56DC8BD909
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C212838E1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B154436;
	Tue,  7 May 2024 01:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBz7L4vP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A1139F;
	Tue,  7 May 2024 01:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715045861; cv=none; b=NVNthuDQay40o2+1xgVK7mipTPVU17gOp8g83OISBLzvCOiX1E9olcwEpb2mDI6CQJw6XMCCn6LBnQ3s69FOjdrOv2lmVbfIWjtv6IxLXptrrAKm58VLlRyQkeDESh7dZ6IL4kaxAKoj+HdcypML7HJdOZn8mwFdeLZMwKgBWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715045861; c=relaxed/simple;
	bh=7T6mbhT6vl3m4fgPrZ7Q4EESsIvLkdSI1gi4g130v+A=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u2ZklVhD1OkMyXai/mZ/P0U0uQmBZ81KZJGTPWR5lHnySu27Z7fS1BrKyLkZRVZAckdO8m+Mkh4/PT9PZIv0snckYx2mx738lAKBOoTJZu1rLShijgjVyxF3ot8JBCprWdMUYon8zw0ssyEEHi/Y7UxstLd8O7bq+ND//GaHfQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBz7L4vP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72FBC116B1;
	Tue,  7 May 2024 01:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715045861;
	bh=7T6mbhT6vl3m4fgPrZ7Q4EESsIvLkdSI1gi4g130v+A=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=vBz7L4vP2Lq9kPOax3KC896V0R5+hpIpSoTkR3mAHMguXMEnuOoeq+5jq64VcKFu5
	 edcgLaJzuZOzmYGFNEL/oZFCkK2aA6iPnuBRizwZVMlB36FiWrSONg6n+571nUOAoC
	 xMv00XnGPzSoIBq/O5w6wJPf0s34K2Xh/Z5gHt2XyfzG0zK8DB5dGxwZj1YRYJJD+j
	 i+pEw6MCyiyiN+v5kxCSUr5pazs99ogdtqvunH/jUzsUNKHSBKTr2pW351cauOwoFb
	 aVH/k8S3TVhAc/pii7VtGW1UUVsdDYNiFFfmSANbV3xz5n1ZpAnj4VwsufKTE5MA5a
	 ihw1K14PpI8lQ==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240430140954.328127-1-krzysztof.kozlowski@linaro.org>
References: <20240430140954.328127-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: q6apm-dai: drop unused 'q6apm_dai_rtd'
 fields
Message-Id: <171504585856.1982545.5694703211311117079.b4-ty@kernel.org>
Date: Tue, 07 May 2024 10:37:38 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Tue, 30 Apr 2024 16:09:54 +0200, Krzysztof Kozlowski wrote:
> Remove few unused fields from 'struct q6apm_dai_rtd'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: q6apm-dai: drop unused 'q6apm_dai_rtd' fields
      commit: bd381c9d151467e784988bbacf22bd7ca02455d6

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


