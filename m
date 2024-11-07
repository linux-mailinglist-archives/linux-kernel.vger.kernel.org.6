Return-Path: <linux-kernel+bounces-400608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFA09C0FDA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B041F23AB4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433F217F4E;
	Thu,  7 Nov 2024 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0IhXNUa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C92170C0;
	Thu,  7 Nov 2024 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011831; cv=none; b=NBjMEZ5shU/51sF9s2SpAKwvfvjWQ35QxX4xg/BXmxZ5Oxf9Cf613pVL+D3tnftb5BY/5xQMU0+5x2tBVHieu8j/tG+K6SJ31pcSIgnwYhnvEH1/P9v2liQ8wYjBXLtp0YLWYuPLaUGFfKqOfq4388oB+pogh0mF5eqcbf56V/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011831; c=relaxed/simple;
	bh=rub3oLZQNtnOdz/P12PwKjUUiaDdvSq1AfEULziS85I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qakHneWJhw194NVpS11NJvqhuwBSZr44VJjiqq+0grE5zOMbcFbxh6x3qgrVl3H2mx484+i7Eggs2ErPPIleP10wWq+RZ1/X7MJr3Pq4tt0RCp49ozEc3RDKW3eeLZr1PFMXt+UCyANNfdPQsYSX3T3eg9Sbm8+fMZuEKGD9MJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0IhXNUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C65C4CECC;
	Thu,  7 Nov 2024 20:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731011830;
	bh=rub3oLZQNtnOdz/P12PwKjUUiaDdvSq1AfEULziS85I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D0IhXNUajUjZbIFESthwQe6Unk+E4oCpRecMauktJRHpIe4/5RGYkT6HCWpra8Dv8
	 fMgI4i2+nnAIqOzXFeyTohUW0FgZpbmqRC6wE/8a5iYIYdIzvPbugi83znsLT16FzX
	 a/p0n8mjxEjtC1OFWEVrJWnD8qiSEzjFO/O8ayWuds0Vth0RLIJtdGNxBE9RLpGOxG
	 +x3LjAAP9DBH2P50FTyji54fjBQvYZR7Q5t1mULJepH5eGhMdN29RWshwzRTqQd5Nh
	 LMMKRhMGC0RwaSxJ6tPahkcH+jgCRCYXDyT5dcVrL+AIm1bm30LcLZQjZ/r0Vft17q
	 cFGTS5rkFljqA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241107075440.2770-1-tangbin@cmss.chinamobile.com>
References: <20241107075440.2770-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: ux500: Remove redundant casts
Message-Id: <173101182935.257604.16434756309882094543.b4-ty@kernel.org>
Date: Thu, 07 Nov 2024 20:37:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 07 Nov 2024 15:54:40 +0800, Tang Bin wrote:
> In the function ux500_msp_drv_probe, the 'int' type cast
> in front of the PTR_ERR() macro is redundant, thus remove
> it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ux500: Remove redundant casts
      commit: fa24fdc8ae9e6f6fe7a4f7676a4d8c14433a86c0

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


