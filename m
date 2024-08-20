Return-Path: <linux-kernel+bounces-293986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE80B95873E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B231F21EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABD518FDA7;
	Tue, 20 Aug 2024 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ic7HFVhP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1301370;
	Tue, 20 Aug 2024 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157852; cv=none; b=Qo+62pmPZzo9CnlLq/+Kk5cG045tUXkmoJiyQBgaTmGZP3w5cPdrqLBK9dDuMR/8DCljCsoJfkl8JAQNCbywhIVFAtySHhSsX+p3UpsMj0YwE0KQukW6OpsHzbg8RhlGtCqE1BWtkE/WLUi8p7fYuyduT2NLFOsx6atWguQhSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157852; c=relaxed/simple;
	bh=N6NJra3qTWP82d4w1TUB4ewYS9wHRZSWb7IewvGtwiE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gwb6G66bPUWcg+nND6QhZDoDMtoML+xm+KoiQwkvBK3tpHpKVY51OQ0mVqnKpDTcTYVmnuZkzeeVcmMxp2ENUCHHYKgfpjyVaJt4e6ZsRqfg3RpcJrEnr0jCaO+5rOmOdNbhOH/aaFDsJoWqmAyjDQdXPw+adZ4ACyhnqhTTLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ic7HFVhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FECEC4AF10;
	Tue, 20 Aug 2024 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724157852;
	bh=N6NJra3qTWP82d4w1TUB4ewYS9wHRZSWb7IewvGtwiE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ic7HFVhPRnV2JzY7oMFp6K97mjnzFH7n3OKm4J6BPxGjAWD4Hg1oYjSaUc4DyBZY8
	 KPOExZrtOJ1USixmTJMgpoRz15q2j225CQaB6L5C1rtuP8yyGyEsm0q2afiQpSyx20
	 TwsG+Odr2ON7EF2nRZECUF1CsrQf85vbSQgdmTVdSxiVg/0yAJfB9myD1cLQWXvF+s
	 pXfD3rbP+vPYqIqeJI40nGmYBcKONM6JEfk3V96HTtwccuddd6c6/H6Fh3ZpJfZQLs
	 n+xe+jgGqGBqTOOcz4xWzLXlDuw490XI8xKIbx8crQe7xVnMiAJVVFmIHSrwUttMOc
	 OShs1+4dRnFGw==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, vkoul@kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
References: <20240816023331.6565-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/3] ALSA/ASoC/SoundWire: Intel: update maximum number
 of links
Message-Id: <172415785031.39606.3510314770676160948.b4-ty@kernel.org>
Date: Tue, 20 Aug 2024 13:44:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 16 Aug 2024 10:33:28 +0800, Bard Liao wrote:
> Intel new platforms can have up to 5 SoundWire links.
> This series does not apply to SoundWire tree due to recent changes in
> machine driver. Can we go via ASoC tree with Vinod's Acked-by tag?
> 
> Pierre-Louis Bossart (3):
>   ALSA/ASoC/SoundWire: Intel: use single definition for
>     SDW_INTEL_MAX_LINKS
>   soundwire: intel: increase maximum number of links
>   soundwire: intel: add probe-time check on link id
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ALSA/ASoC/SoundWire: Intel: use single definition for SDW_INTEL_MAX_LINKS
      commit: b27404b2bbf951a11500525dea15681cc970226c
[2/3] soundwire: intel: increase maximum number of links
      commit: 1f3662838a05f1ab6af89a417f6f252d91d0806b
[3/3] soundwire: intel: add probe-time check on link id
      commit: d2234596be2192d9c1ae34f8c7534531191bc433

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


