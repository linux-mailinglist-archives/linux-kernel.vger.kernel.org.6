Return-Path: <linux-kernel+bounces-421187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2AE9D87BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999FA169B06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3341AC453;
	Mon, 25 Nov 2024 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxW45hCk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853191B0F26;
	Mon, 25 Nov 2024 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544062; cv=none; b=TKJ35bB6GfPsEj+OiRWlcdpoULYT1JeGjzl5wz18iIl5h41JdI1lbLrgyQMeAGCywjaQbEsxaaW63NkEO/SZ4rtfMTuPdHbJe7FS8IW3gyazmiCvtc+37jue7UX+1Wl8hao2tbfmWe3/aXBJg/kBtptzzisxqbLeXi/wKP7MEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544062; c=relaxed/simple;
	bh=c1AaJIkC5ANteto4EmoCZndiq49Malo4c5lEUbHKku4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e8ZD//IPruPYTk8HqPtU+TiTcLdfwVafGp6dy9ypDUaVHK5lvuPS9pK6kioRGsJbeYElZVpURmGDsecPa+GU8co+9hxJBvOmFs0LK1u0f9L02XsZjKB4gN7E8VLgjGzu9fAg3D/gSqIeEG5DA9nYZ3ZtW7yBo4nTEx4oroMdiyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxW45hCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2918C4CECF;
	Mon, 25 Nov 2024 14:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732544062;
	bh=c1AaJIkC5ANteto4EmoCZndiq49Malo4c5lEUbHKku4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HxW45hCkVzQ8R8r544s4eAYLSN3QZ4zejuTcTRZpo0ON5SVh4r68qzvtZ2YIgst7K
	 WwBo/3Yrq92F8Mu8RFx0SZ1o3tPBb33yjhvN5z4m7U6pBd/HCFGcNnIjpf+Faalv90
	 Zbj9sp4Rb0f5G/VNFDvNRetZkZjZonynrCJrldJ+svVpCRYwX4Qg1skuA7o7Vez3//
	 cEGBme5jcV4u4An0m+3+ExcBKbPzzqFnNEKM0LfyumHm5dwvJlCUcDuCetZ9PudjW+
	 p2q4/4ruK8WHGz0MmaoICHfIde4E6YF3W+qvThAQ5T3knJyv1qRFXndXkuxh0zRxwD
	 D+hYFus2F2DEQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, corbet@lwn.net, 
 anish kumar <yesanishhere@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-sound@vger.kernel.org
In-Reply-To: <20241121232958.46179-1-yesanishhere@gmail.com>
References: <20241121232958.46179-1-yesanishhere@gmail.com>
Subject: Re: [PATCH] ASoC: doc: dapm: Add location information for
 dapm-graph tool
Message-Id: <173254406059.44664.4605735086287465083.b4-ty@kernel.org>
Date: Mon, 25 Nov 2024 14:14:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 21 Nov 2024 15:29:58 -0800, anish kumar wrote:
> To help developers debug DAPM issues and visualize widget connectivity,
> the dapm-graph tool provides a graphical representation of how widgets
> and routes are connected. This commit adds the location information for
> the tool to the documentation, making it easier for users to find and
> use it for troubleshooting DAPM-related problems.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: doc: dapm: Add location information for dapm-graph tool
      commit: 8697ecc3274214c65ff271a58e7abb601216f2a8

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


