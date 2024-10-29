Return-Path: <linux-kernel+bounces-387635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BD69B53E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F1F1C22230
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA42420B1F7;
	Tue, 29 Oct 2024 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXiSNg6U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D8020B1EA;
	Tue, 29 Oct 2024 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234144; cv=none; b=ko1fQDPV4BW4R1a3F8ycKpWOn9S6ub67+dX7dGE7l4nQAoFi78fvHHmHOhqs459kqZeEgUtVdZgUiM3NwZA06EGKoDlF9421AEgIxGSwwwl/Ru33MQhwSVddkbKnaP5isD8Lw+Y6jlRyDWtodrxTMSSNt6yVcH6hcga3FqQImFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234144; c=relaxed/simple;
	bh=ONGKXVSgZrrRY5M9vuQpxWfzUreR6foBojSBdMgOX6A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UtbloGkRRYcEfPM/wpuOclY449zUcuqgiCzoEFkwRPRgiDqk+wWYAIQpcGFYCycHUlH3D4axwqmHXVyRAv7ztxNZ5+yS1tn25xz2msGxY+jatz2oyEYUBvIgXD/kIirbAUwrlXmDRhScjYWKsk9RsixQ1FCg0GMMQ0pkmbdYis8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXiSNg6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B12FC4CECD;
	Tue, 29 Oct 2024 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730234143;
	bh=ONGKXVSgZrrRY5M9vuQpxWfzUreR6foBojSBdMgOX6A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fXiSNg6UIHx5ipnEYaIG5nYWtF/u4BasUHfGE9KW4yov9NRbOTNpy6BFnv4B0SWV0
	 9q0Av1OhfI/lqVhnpHi03LTPi18MdAWVfNkM7piftbWTPMfflCy+AVBmNLsZs+aWBZ
	 z5G71IVkDGohEDx4i88v67vZ6PRdkm8/u38YDTjf3qAVJjORbi9woNAFA1IWUhuy+B
	 vPn5oca0Fy4pRfmzQu3C4zyURAzt/zopOfK6pakbKZpWeUCqFQhckrwID+S4kUceY/
	 xpMna8K979bP5VZ0pxgkAen17Edb6B6EqW1sSNBtJx6bZwJj/QjRkXChwCik4E+7ni
	 r229INsC0ap9A==
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org, quic_pkumpatl@quicinc.com, 
 a39.skl@gmail.com, quic_mohs@quicinc.com, 
 Alexey Klimov <alexey.klimov@linaro.org>
Cc: linux-sound@vger.kernel.org, krzysztof.kozlowski@linaro.org, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 dmitry.baryshkov@linaro.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241022033132.787416-1-alexey.klimov@linaro.org>
References: <20241022033132.787416-1-alexey.klimov@linaro.org>
Subject: Re: [RFC PATCH 0/2] wcd937x codec fixes
Message-Id: <173023414119.174179.9413439029785380150.b4-ty@kernel.org>
Date: Tue, 29 Oct 2024 20:35:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 22 Oct 2024 04:31:29 +0100, Alexey Klimov wrote:
> This sent as RFC because of the following:
> 
> - regarding the LO switch patch. I've got info about that from two persons
> independently hence not sure what tags to put there and who should be
> the author. Please let me know if that needs to be corrected.
> 
> - the wcd937x pdm watchdog is a problem for audio playback and needs to be
> fixed. The minimal fix would be to at least increase timeout value but
> it will still trigger in case of plenty of dbg messages or other
> delay-generating things. Unfortunately, I can't test HPHL/R outputs hence
> the patch is only for AUX. The other options would be introducing
> module parameter for debugging and using HOLD_OFF bit for that or
> adding Kconfig option.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: wcd937x: add missing LO Switch control
      commit: 041db4bbe04e8e0b48350b3bbbd9a799794d5c1e
[2/2] ASoC: codecs: wcd937x: relax the AUX PDM watchdog
      commit: 107a5c853eef5336a9846e7dd2f9184b6e3c07c7

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


