Return-Path: <linux-kernel+bounces-517847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D12A38672
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC23188A5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7349F2206A1;
	Mon, 17 Feb 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCGneQU0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8A21661B;
	Mon, 17 Feb 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802750; cv=none; b=XerffMDY5d5ooh6fwozSHf7CKyH6S5JKbOEBuMZdPb7goxl6ncxPsdGfHSYZebP7UW5Rlf5hiFcqnAgoa+3yHwXdUR1K6UArdDaVDc+BKvd6KTwIkW7UGCKSn5wIuXU6DPflHg/z8Y17J4MS8AJNv+1HuOw59zgv5K8sUXElEx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802750; c=relaxed/simple;
	bh=jCcmXqs/Ip5AGIQTtLpnwL3yfzlEvnYA9jP5FJuP8yo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vEYOmqCvitHvheuDiZWNu3zMSwSPbgublOEqGHTdyGH5b9sGGxEDx0mMq7H9Y9souWbZ0uk0EvyhgAekNPxR5bhT5bBBYs9OsqgFaOrw2k/8EaOUf+PrfkE+/6iQ928urI7N34MwxyiZ7cL1O5H3jIBJaeDrBUwJKGcp7PMHRSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCGneQU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC735C4CED1;
	Mon, 17 Feb 2025 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739802750;
	bh=jCcmXqs/Ip5AGIQTtLpnwL3yfzlEvnYA9jP5FJuP8yo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FCGneQU0vrVlsPPkUOOVGIWK3CoPGWxPXWC5f/U2Cna+BvRIMwkJsbVOxKe5AR6uH
	 CcBTlBozm7UqwsVVpMkI1Sx7DfSlNUqajS3+DmGbP0zhpFWXcUT9k11cl2dwXEkkuJ
	 NBGerJl4FeRQObMgXYbnAAvNdMsy9PZ4fnm+Uz71kXxMJ0DaRTlalo5rUDGuSwkkWT
	 k29or88p7d9/aD0GNbBjeiv1K80q2ZW1NUDh+KLzLRqlkuYx3Cdo4XDpyY18AtxCHC
	 f33oF4sAEaby58LQneVplfdV8aFjykH/hvipCKaVmXWUnvs4PeEE7ajq86upVQPlEo
	 +Bp2uU3q3gI/Q==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Dan Murphy <dmurphy@ti.com>, Hector Martin <marcan@marcan.st>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20250208-asoc-tas2764-v1-0-dbab892a69b5@kernel.org>
References: <20250208-asoc-tas2764-v1-0-dbab892a69b5@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: tas2764: Random patches from the Asahi Linux
 tree
Message-Id: <173980274756.49890.13014040253628029521.b4-ty@kernel.org>
Date: Mon, 17 Feb 2025 14:32:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Sat, 08 Feb 2025 01:03:23 +0000, broonie@kernel.org wrote:
> This is a random subset of the patches for the tas2764 driver that I
> found in the Asahi Linux tree which seemed to be clear fixes and
> improvements which apply easily to mainline without much effort, there's
> a bunch more work on the driver that should also be applicable.
> 
> I've only build tested this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: tas2764: Power up/down amp on mute ops
      commit: 1c3b5f37409682184669457a5bdf761268eafbe5
[2/4] ASoC: tas2764: Wait for ramp-down after shutdown
      commit: 08a66f55f7246d477b19620a953476dfc02beefc
[3/4] ASoC: tas2764: Mark SW_RESET as volatile
      commit: f37f1748564ac51d32f7588bd7bfc99913ccab8e
[4/4] ASoC: tas2764: Add reg defaults for TAS2764_INT_CLK_CFG
      commit: d64c4c3d1c578f98d70db1c5e2535b47adce9d07

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


