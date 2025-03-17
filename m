Return-Path: <linux-kernel+bounces-565109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD19EA66107
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB573189DA21
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2F20468E;
	Mon, 17 Mar 2025 21:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM4WS+uR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEDE1FDE2E;
	Mon, 17 Mar 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248463; cv=none; b=YO5jt9Sg81CcsGMq02e7AjTjWfgO15Xdv6G44Wh7wcYMu91NW27oho3CR7X9p5byJICBmWTGnZo+H18f8YuKDyDnmVUYUy8QiHsQOPuP5yPixVqZXQVEq5jOuuG25Zfhosvq0jEBmaD3igyySek118BcbmfeBCHL3g17OiMrjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248463; c=relaxed/simple;
	bh=zTbeWGdSHyIJeAA0Dt9en3vnvP8aLL2sNpiCUWFVtFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=krJ97HawMKP8srrjDgAE87K/5Fo5zkxV9V8NnN2s0h/UIa9IpZMsWWTooZlmfjxyqOl5S4OCfHw4uafxo/MeW8vy97HXYHP/wNS53zS0rVn8tHEokQflPGc93Dnlo01BuFOXpnQWIhLPW/vUip1cGvHnVP50Trbkh0zxmqrKGIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM4WS+uR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3E7C4CEEE;
	Mon, 17 Mar 2025 21:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742248462;
	bh=zTbeWGdSHyIJeAA0Dt9en3vnvP8aLL2sNpiCUWFVtFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YM4WS+uRqacjtRVr2tCY1VJBl5GXKQPV/88Cww4FcOiVgvZEcCMLhN0Dml0vLMNpE
	 Z1/gNQZtjNNw8FLMyVNNE+ECG6sEni5zEkgSwdOr6rFX/NT/ws511Kvaa/RZmauvd5
	 nDTrBRvmmMrAgNssZgRlGa3yOjkyY4xEKFvAWz7Bkkyccy2ZaJ/o80WoeNA5koHeck
	 9PAUOWJKiaaKBPk3uhWXqHck3Y++sa4DTgl5RScUi9Tf8AosjbfQG9BUrQw3LtRzac
	 zgKBO3nUkADkpyFgDQxeot5Eveec3oUiKWCsL0vuimYMZy0XSPjyxc95+0yRPxWNuG
	 Pbo4kwRbBDjrw==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, pierre-louis.bossart@linux.dev, 
 yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20250312172205.4152686-1-ckeepax@opensource.cirrus.com>
References: <20250312172205.4152686-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 0/6] Some minor SDCA preparation
Message-Id: <174224846096.355189.1645947084379331716.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 21:54:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 12 Mar 2025 17:21:59 +0000, Charles Keepax wrote:
> Make some small fixups and add some minor missing features that will be
> needed for the next major part of the SDCA work. This series doesn't do
> a lot on its own, but as the next series will add all the ALSA control
> and DAPM graph creation it's probably best to get these minor things out
> of the way to simplify review on the bigger stuff.
> 
> Thanks,
> Charles
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: SDCA: Tidy up initialization write parsing
      commit: 988adcb73669a4015974da9057d43226ddc1aa9d
[2/6] ASoC: SDCA: Use __free() to manage local buffers
      commit: 0d16daa9405ef7de5c278183d4079013f39a51ac
[3/6] ASoC: SDCA: Allow naming of imp def controls
      commit: 49680c9f13b64c13e79e1312c7616d0ab9775e4a
[4/6] ASoC: SDCA: Add type flag for Controls
      commit: 2a4667f3d589524bd2fbfe4f7dc0e2f12b832e10
[5/6] ASoC: SDCA: Add SDCA Control Range data access helper
      commit: 1bcbb88bedb17804491e692a3f1a38223e09152c
[6/6] ASoC: SDCA: Add support for GE Entity properties
      commit: d1cd13f80dc6c8525c539a28d4eb1df913d542de

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


