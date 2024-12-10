Return-Path: <linux-kernel+bounces-439632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE959EB207
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96347169951
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6181AA7BF;
	Tue, 10 Dec 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0j65nno"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94E519DF4B;
	Tue, 10 Dec 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733837763; cv=none; b=Gd4Jhr9idVe0MWGDjTcPILFgXoht7bJ0McWnJaUvOT5jh5VaJk6e5qULqSHmpzeu8PxGU6DAvvDbeldzK61JCxktuzJl02nSWwSM7wWDWbaqhCqXyjxK8DY7iefIGKMXuoyUkWl2b9R1YA4Be39qC6Fu7PmEwL9muSvCiJB6jSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733837763; c=relaxed/simple;
	bh=s2tWExV+CNbckvtXA8OAEn8h1cvGzaeoygyrproyKQA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jN1x5m5u0tFc6GSaiM7GEuaJ2tOTNRChmzGc4zIK4p2nTociLqqNZd5GlXr+EEM3aZu8RJmtbBMJ5BlbwVm9aAIyd+pRuS0hctMncceMZNIM4+Ji446pmD4pEhLNKdF4avO3ynfcGy2iNruTjV/mTp4OKADXgKwc251bzPgiX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0j65nno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A8DC4CED6;
	Tue, 10 Dec 2024 13:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733837763;
	bh=s2tWExV+CNbckvtXA8OAEn8h1cvGzaeoygyrproyKQA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=N0j65nnoW5difpZWYNUr+Cs8NT76udNun7Mq+hRCK7fBs3RaOnrmGvKj9jsuJawip
	 6VdcTLjsJS2bPYHl6LMtRxjRC0D5fc17SglMOrggFOp8rYnnQQDlLv3QXrbzC0+ua6
	 G8D4d04M2HTmXcmvcDm295mN3PCrxGXNnLg8hBHRqSuEgEf4OriR72gQIX+GYPA/+b
	 Gs/7EmvB2kEXskSCunigRkIRYfZ9JEE78BEUlqgrK5OBoRGWLC9OWhcDQb288zZo2+
	 QMpcib7tHY3jVLMG7aMAHBBj3L5GpDxq9Kdga2Ij5JU7iF9dFFOmmYdaTnzZExrKmj
	 tWmeG3wRW+T2A==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org, 
 linux-sunxi@googlegroups.com, linux-sunxi@lists.linux.dev, 
 linux-sound@vger.kernel.org, lander@jagmn.com, codekipper@gmail.com
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 jernej.skrabec@gmail.com, samuel@sholland.org, andre.przywara@arm.com, 
 wens@csie.org, u.kleine-koenig@baylibre.com
In-Reply-To: <20241111165600.57219-1-codekipper@gmail.com>
References: <20241111165600.57219-1-codekipper@gmail.com>
Subject: Re: [PATCH 0/3] ASoC: sun4i-spdif: Add 24bit support
Message-Id: <173383776048.46965.5173929465030260982.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:36:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 11 Nov 2024 17:55:28 +0100, codekipper@gmail.com wrote:
> I've tested this patch series on the Allwinner H3, A64, H6 and H313 SoCs
> up to 192KHz.
> 24bit support is working on my H313 board but 16bit plays a bit slow and
> I suspect that there is an issue with the clock setups. This is even
> present without this patch stack. I would look to address this asap,
> but for now can you please review what's here.
> BR,
> CK
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: sun4i-spdif: Add clock multiplier settings
      commit: 0a2319308de88b9e819c0b43d0fccd857123eb31
[2/3] ASoC: sun4i-spdif: Always set the valid data to be the MSB
      commit: 80ac12ffb3a9e19a2f11eb1975ed31c9a39183c8
[3/3] ASoC: sun4i-spdif: Add working 24bit audio support
      commit: 6e750d3ec7410c8d3aa6a006d37142eb837b3c03

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


