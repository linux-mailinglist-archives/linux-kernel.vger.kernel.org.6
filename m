Return-Path: <linux-kernel+bounces-564193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B804A64FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2EC188A5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3AA23E25F;
	Mon, 17 Mar 2025 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKnGsZeg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF823C8D6;
	Mon, 17 Mar 2025 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216325; cv=none; b=Nn3MFuCwpyH25qzMvEEW+ctbrBTrZvqNfVnDjwHmQr6YDudGGPVQCqEDi4mw01HPwpQJ4lGCA8Robo1qzUhoEUfhsm5FCzji/7E0X8UvCUO8d/HkbIY9NhxzTe0jf8QmkhZnhdlOtUGr50rSqwoTlL0c+wQJ9U65FGHlCOQwTiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216325; c=relaxed/simple;
	bh=nIxrkln4VTubkXhrnjQl3QY47IU5dzMgVJpZohDtQU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FMYH+FVPplsJ4Nl2Rbf5CgD30ifCs9s73Ddfu10upJCHdEqTX7P3I1aVh8WGq1GOlwCNECltX6w1009iJ+jrGfLvqyzO9PIM/iplplx9jwqci91TvRl4z9KfL0gY4jgBqzoyOswQWl8WyrWiulVjC09zLqWV/dal/BQTe5SKaJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKnGsZeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824E1C4CEE3;
	Mon, 17 Mar 2025 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742216325;
	bh=nIxrkln4VTubkXhrnjQl3QY47IU5dzMgVJpZohDtQU4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kKnGsZegWausXyUiP6EoFMkNeKYf7XIVSjkEWQYpJwJto3GPlQtxHwPgY48x+4IgG
	 90EuQ2etdjctcEmNYOs8aBgIfFgPWiMcZtgOZqGS1+91RqKfOV9+yYqtJWdxn7qH5B
	 jD9iEz9OyzoDxWIURsh1SLU3Dxvf+FjlVnxAFhurdm3u/6rCgThNdIGlI0NtJLoeHF
	 guHq2sysJ/eDMCb8dmTMCrRa01BtYGlB9Lw/9YOFXzG8hNj+Hq+GvJuCBVKY4QduLM
	 ehfcarmnM0D3XIVAH/MHt6ixE36u9ninrijib1/BwV3qJidWnMxMxbEHdS1f5+OT1K
	 5u7dRDpaEjcag==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, tiwai@suse.com, keenplify <keenplify@gmail.com>
Cc: mario.limonciello@amd.com, venkataprasad.potturu@amd.com, 
 lgirdwood@gmail.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250315111617.12194-1-keenplify@gmail.com>
References: <20250315111617.12194-1-keenplify@gmail.com>
Subject: Re: [PATCH] ASoC: amd: Add DMI quirk for ACP6X mic support
Message-Id: <174221632328.149281.304345487408521038.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 12:58:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sat, 15 Mar 2025 19:16:17 +0800, keenplify wrote:
> Some AMD laptops with ACP6X do not expose the DMIC properly on Linux.
> Adding a DMI quirk enables mic functionality.
> 
> Similar to Bugzilla #218402, this issue affects multiple users.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Add DMI quirk for ACP6X mic support
      commit: 309b367eafc8e162603cd29189da6db770411fea

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


