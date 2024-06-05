Return-Path: <linux-kernel+bounces-203314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836468FD941
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF471C255E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A0415FA73;
	Wed,  5 Jun 2024 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQxwQXuR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68215FA8B;
	Wed,  5 Jun 2024 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623510; cv=none; b=E/dYLk2903CjeDixjp6gcPlxmVXm4AMKX+d2nWW8NO7H4NrrNOi216sIxdpqxKG2Eyr0W9VWBhptBbIlV7+1G2Hck9vkesAloVhnqqoncJ13gKf/SFm894V2ec3n0lvP+lsTxr7oh/dbtQbsJXkZ98nLFwHhT19Idhlp/wQM1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623510; c=relaxed/simple;
	bh=yrMbNY2Gr7i5mUw30Jlna/5JAKzdrHFu4hvA2gyNBkg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xql8XFTcHMmVIbenZSOopDpYmWmVjBir7fbPLdE8VzXtilmWmG9RLI/5mvzACQTr+vcfLAUqWS1s4hBfZ9tQQPtaG2mXwEVib7Fd5YAM3Fh+/1CX7F3sIwSJpeiY1jvcv4Ubs9/MJqIglK0q8Ec5Ol66UPwqBy1dyZ/624ZThtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQxwQXuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B38C4AF09;
	Wed,  5 Jun 2024 21:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623509;
	bh=yrMbNY2Gr7i5mUw30Jlna/5JAKzdrHFu4hvA2gyNBkg=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=lQxwQXuRvfm9OWCFsbHuZEiWtVU5w6nccY6yS+rlo0rS2J+6lU3V/M6LSrtC2U0NK
	 l9brby4WmHNVoLDfTQn/MnwGvLoeFge6FjifxDqZTg3+7dw2P42pu3rwCcnk0Fo8LR
	 djuvepdmdBlyxG0uerykdOmWo4+bePL3hzmdc8Ei4+0mU7ry8ttbAhtWAxpKXQLLgB
	 Uu+PWn93L1CKJR4v/j05j+462Wa74MvY6sfGYtzT0dzNImxNELgR00pFp1Tt/7C7Zb
	 yS8YotY8URtKUMYU24Enw0Fugh7uPxyYALCETLFebOTPKfkjyghDGIAufUNb5sMnB1
	 Nkj1PnPb5aKLg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 shengjiu.wang@gmail.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1716972002-2315-1-git-send-email-shengjiu.wang@nxp.com>
References: <1716972002-2315-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v4 0/2] ASoC: fsl_xcvr: Support i.MX95 platform
Message-Id: <171762350655.565712.3068600680938105880.b4-ty@kernel.org>
Date: Wed, 05 Jun 2024 22:38:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 29 May 2024 16:40:00 +0800, Shengjiu Wang wrote:
> On i.MX95 wakeup domain, there is one instance of Audio XCVR
> supporting SPDIF mode with a connection to the Audio XCVR physical
> interface.
> 
> changes in v4:
> - refine the constarint for 'clocks' according to Rob's comments
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


