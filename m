Return-Path: <linux-kernel+bounces-536977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D928A48690
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41EC47A2CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7511DE3A4;
	Thu, 27 Feb 2025 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCSrc9wY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC741DE2A7;
	Thu, 27 Feb 2025 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677240; cv=none; b=M8WpeoANxzBn/vvT9RP8DBPtdKeVfxH1L0X1wIlIjMH9WUlD4g6YN+nx+3p2fg74OKARvsnZ8Jg0p0tnYs1oOOzD/4EkC3wf/uUrYTGehk8Ny69vk4jaBnQ8Q0v2PT2aqxCBYti561Jtvuuv+bHWHmRDh1smw7lYCfg/RaNIm2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677240; c=relaxed/simple;
	bh=krunXr5w8ZQ2DT47MBNeiyRY+vqHzT6dlAWTnz9cDh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TwiE7bc0OInN9wOGbCiLa6EU/8Sfb1nDj3zaU4YwfFxBVGvtlhrjUEpBm07D94rJLoPPp2VZ34N1kzmkVYrAanHwRQ5Qsg4Mk40m0AYH6TQ3AX/EUrnBZN+IXnY1IHH+gIg5Sj46+POgVLizrAHEVTssrrjywusjIepR8cefQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCSrc9wY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A47BC4CEDD;
	Thu, 27 Feb 2025 17:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740677240;
	bh=krunXr5w8ZQ2DT47MBNeiyRY+vqHzT6dlAWTnz9cDh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cCSrc9wYu5ICYApSHYsALJbFjD73ZCkPDinzcfu6xp/mEL0fXgEbFmYrZfwSbpiu+
	 xZ4fcUsRRPPy+A8J4P5u4R4cRv7gi9RzR+HpL8lh0RDQWwr2jQS8olIXzosV+/X/oi
	 yMyUJZz41NGibTX2yEaY8x1060MMKo197laumUc2UN1IXrRj3U+kmqymNMW9KU/ylG
	 UJ4WroMXDylHZdxO3O6ebEhulChc/GBo2vX4qasYG4CJlaFMHc8Hs9M0b9SNXnXyMd
	 GsPkQgtFrnh4HXdVu6Y0Gf+mIKaJbn2rpx2DjfdwljRmPx7aRwo08IMr5WdQgp30Wi
	 ESpzFPhdM/0ww==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <20250217140159.2288784-1-ckeepax@opensource.cirrus.com>
References: <20250217140159.2288784-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 0/4] Add SDCA register map support
Message-Id: <174067723773.191869.7077783208967189821.b4-ty@kernel.org>
Date: Thu, 27 Feb 2025 17:27:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 17 Feb 2025 14:01:55 +0000, Charles Keepax wrote:
> This series is the next step of adding SDCA support. Here we add
> helper functions to allow drivers to easily use the SDCA DisCo
> information to create a register map for the device.
> 
> The basic idea here is the code takes the list of SDCA controls parsed
> from DisCo and uses primarily the Access Mode to determine if the
> register should be marked as readable/writable etc. Further more
> some additional concepts such as DisCo Constants and Defaults are
> handled. There is some potential confusion, as DisCo Constants are
> handled as an entry in the regmap defaults table, whereas a DisCo
> Default is simply handled as a write to the register. Alas the naming
> confusion is an unavoidable result of the slight impedance mismatch
> between the two systems.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] regcache: Add support for sorting defaults arrays
      commit: fd80df352ba1884ce2b62dd8d9495582308101b7
[2/4] ASoC: SDCA: Add generic regmap SDCA helpers
      commit: e3f7caf74b795621252e3c25b4a9fb6888336ef1
[3/4] ASoC: SDCA: Add regmap helpers for parsing for DisCo Constant values
      commit: 28c12866c22c2826ccbd8c82dc353f02ab2deea5
[4/4] ASoC: SDCA: Add helper to write out defaults and fixed values
      commit: c143755d8cce31e770234732ff23134993b0550f

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


