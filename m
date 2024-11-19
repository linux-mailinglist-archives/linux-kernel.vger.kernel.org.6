Return-Path: <linux-kernel+bounces-414931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4909D2F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E72C6B24787
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B711D2F6A;
	Tue, 19 Nov 2024 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnutCmNf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B014A098;
	Tue, 19 Nov 2024 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048122; cv=none; b=Y+CxtLg33XgtM3bDRlxDEkCTMedqJ0RV7ixr0GyAKLnEGHo7aW+OQHxx2L2pbFHcZIO6CEJPVBf//n6K/q2G1LdB/qv3KfaL0QhzNViW/1sTd+qc9jHLMqx0JWsMvyIAgejvFvWYA77EarG/xEEqCtYvQHAetittQETZ0y3nVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048122; c=relaxed/simple;
	bh=D/TUDSGFaaECMmzNkEOiI0Kb4tsy5Vzy8OBgXOmcC6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A6hYeHt1ijzSue4H7lL+EWEg8Ci90Gi3ShK3/eaVvjgY6TwQRxnbLZ24hWAErtVqeoPIHHiV+kD+hrYOGq6ZUttYjEd1aqiZ46rfqGUZBdZNEytKwDsVlLiFmgX+paqBbExaaxeical4E+e8OujJlU6ffb3Bos2h/66JceJjcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnutCmNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF306C4CECF;
	Tue, 19 Nov 2024 20:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732048122;
	bh=D/TUDSGFaaECMmzNkEOiI0Kb4tsy5Vzy8OBgXOmcC6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZnutCmNfRHFBoB6DkDF8pgv0RsXdRP+BHCEIX8LMJpm9WAlTxh0OKWykNty5cJZ7A
	 2gz+HgjJcqAVKZZ//+OkxNAFTOKTEEeMN5uPXOWQPY1JB07Hm03jfvO44Kcgbk+J0g
	 P/fEJ7OzBMKw+pD/h8hPLrXVWbDiTE+q/adGG/DtNnn/ILVk8FUlyCsP1Ig3qTpOrB
	 EzLcmEOdEw91TvuQmXl067lNCYYLIHlWFAoG/X+coQ4BggdSBa3V0ibXy71ZYoPm96
	 eYcRp88dOXYEA/G7eDgbvaw6gHMz/bDA5t6rFQ8vBQ4tvYIz68imy11Dlu2K5DZnEY
	 JvdFcBemX4Z9g==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Mario Limonciello <superm1@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20241118025527.3318493-1-superm1@kernel.org>
References: <20241118025527.3318493-1-superm1@kernel.org>
Subject: Re: [PATCH] ASoC: amd: Fix build dependencies for `SND_SOC_AMD_PS`
Message-Id: <173204812069.81544.393632760053179230.b4-ty@kernel.org>
Date: Tue, 19 Nov 2024 20:28:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Sun, 17 Nov 2024 20:55:27 -0600, Mario Limonciello wrote:
> The pci-ps module now must have `SND_SOC_ACPI_AMD_MATCH` selected
> to reference the `snd_soc_acpi_amd_acp63_sdw_machines` symbol.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Fix build dependencies for `SND_SOC_AMD_PS`
      commit: 0109ee00788e0ad7b888a799c26b5a93b343876b

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


