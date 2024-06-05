Return-Path: <linux-kernel+bounces-203309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C598FD938
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5CE8B27806
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAC73C28;
	Wed,  5 Jun 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLRhpOph"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6B15FA8F;
	Wed,  5 Jun 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623495; cv=none; b=GaTKPlg5z5weyip7tCpsEu74cxkUoVruvqnuPvKFpSJosT5uwNmcAk/t5C8QKvc3NlawSfyEnpb9vEt1qB9CezKt8Vdm3iw7eAGLvQ248bQ9btDRHHYYADN9T5nqrklxPcGxx7M9Mzd18LUSYTbj+oT2PTWQV+vl4YouBrK0AnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623495; c=relaxed/simple;
	bh=D+XNwiT5oc5Dm3t9kYZHsZnZ+hfVu8uRIo4dcxzvk7c=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ne8B6f4D/YJX4iOaXotCOjfbp1cz9NLcGr1VPDTSOW0M0gGUzkxA72yZkGP4l/G5727ZQ+NgI+ZGmt/kYQfqFOfdrkiIdyY5zKe5hMXTHls8h9spTajiLkEsWRETXdUFMI7MtNWXgB9kphaaQHiwOB3btntUhXZ9XsS9VpFkNbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLRhpOph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EC6C4AF1B;
	Wed,  5 Jun 2024 21:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623495;
	bh=D+XNwiT5oc5Dm3t9kYZHsZnZ+hfVu8uRIo4dcxzvk7c=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=vLRhpOphNGmBaQmxfLFjNesmRJ8CdhImZQC71upgsbQ9PPymnKlCzrlqFjLGIkzxY
	 FIV7raA/XCMVmU5o+l3I5StSQvgAOUajlN6bNfywQwvMrirXHu609WSmlsKD4wM/BT
	 MMxuQifeVDY7YfTfT0t28C7KmuTc3dUblWm+pkhhAiYha2eipBYX4fP1gE+E7wLHHn
	 24ed61T32aZ9YM92xUTb6Xs5bFpJb8Onne/DVujNek8MEgDREqJtKyKFKnDcTuUDoX
	 fm9vUtzVjbH0I2hRysdQTdmMrwMCnIUZgzEyk4o8mxNZyxqi55LcyecAw2wXk+2mIn
	 7k2nMmp+sQIaA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 shengjiu.wang@gmail.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1715656329-8061-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715656329-8061-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 0/2] ASoC: fsl_xcvr: Support i.MX95 platform
Message-Id: <171762349194.565712.7362032139063923896.b4-ty@kernel.org>
Date: Wed, 05 Jun 2024 22:38:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 14 May 2024 11:12:07 +0800, Shengjiu Wang wrote:
> On i.MX95 wakeup domain, there is one instance of Audio XCVR
> supporting SPDIF mode with a connection to the Audio XCVR physical
> interface.
> 
> changes in v2:
> - Merge patch 1&2, 3&4 from v1 together.
> - Add more comments in commit message
> - Add constaint for clocks used on i.mx95
> - Add 'select SND_SOC_FSL_UTILS' for compiling issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: fsl,xcvr: Add compatible string for i.MX95
      commit: fc1277335ffa0d180c76ddccf5fe27fc75674e67
[2/2] ASoC: fsl_xcvr: Add support for i.MX95 platform
      commit: f13b349e3c70320ef5a86edfc888a6feb612abb0

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


