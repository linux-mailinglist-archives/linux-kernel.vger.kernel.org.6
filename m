Return-Path: <linux-kernel+bounces-228739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA6916645
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FBA1C21B34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522F154C12;
	Tue, 25 Jun 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oROhn3xk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B215250F;
	Tue, 25 Jun 2024 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315239; cv=none; b=ipclvyk0CdOF1JGB0PK525cVXHQOClLErqKQTJvtDvK58X0gkP3vvOc8nDlos1Xr78zU5HXBZRrutSUWruo2ZH8LVr88eqYcfyNfG1y5Rl1A+w5yVTnqIBshkvRYftPgAyqoNjDIrsLh+9t09pV/47/CFUsC/lO5/BSrp/KoSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315239; c=relaxed/simple;
	bh=POLNQtzyiFdfDZHg+15z+oQL9f1wyzLbbFrSGtcTas8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YLRMFOmgg4CyJYXuAin/CjheIAQJKymcphiVmEBTT6R0kr037l8OgyfmypDSO3H0nElSGtGL5d39L7IXAOFNSxTIuTZWt/RDZFKQikjhDxR+GJh0R8Psf+P7V1MlJdR85SZySzVzcmz8OtIev4WAKv4OwjIHPHadkEwWxkOjOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oROhn3xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4387DC32781;
	Tue, 25 Jun 2024 11:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719315239;
	bh=POLNQtzyiFdfDZHg+15z+oQL9f1wyzLbbFrSGtcTas8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oROhn3xk6yl2yx3SWMZlu+wq2wf1jN9UjC/ac/ON/5I9jvMfhlJeiYrzhIGsjWyPi
	 27gsYWOjuiSZecuL1SnY7ToEtAkOJOLiMJS5ofAiDxazmczz9Ekz9Ls1PZQEVsv9vC
	 YchB2yMBu7/yIuzQvwrVWn2eFVLOolOdVGD1j/H+FFjqE6XORawNUwvvutTGCI3I+U
	 NN2WDyHHP8diGj4+UOs31O8gGlByJ91MbX1c05XHM7iuPb2JJxBmbRBuHBW3nXZsXM
	 96LAPF2wkfPsDFaJKy4gGG5uUztE6yDskTcuTroVu+yrbVS5kip3zbeEXykg71FFBD
	 EcUi6Hm9x7a8g==
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Trevor Wu <trevor.wu@mediatek.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20240624061257.3115467-1-wenst@chromium.org>
References: <20240624061257.3115467-1-wenst@chromium.org>
Subject: Re: [PATCH v2] ASoC: mediatek: mt8195: Add platform entry for
 ETDM1_OUT_BE dai link
Message-Id: <171931523799.64144.6880619543186232885.b4-ty@kernel.org>
Date: Tue, 25 Jun 2024 12:33:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 24 Jun 2024 14:12:56 +0800, Chen-Yu Tsai wrote:
> Commit e70b8dd26711 ("ASoC: mediatek: mt8195: Remove afe-dai component
> and rework codec link") removed the codec entry for the ETDM1_OUT_BE
> dai link entirely instead of replacing it with COMP_EMPTY(). This worked
> by accident as the remaining COMP_EMPTY() platform entry became the codec
> entry, and the platform entry became completely empty, effectively the
> same as COMP_DUMMY() since snd_soc_fill_dummy_dai() doesn't do anything
> for platform entries.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Add platform entry for ETDM1_OUT_BE dai link
      commit: 282a4482e198e03781c152c88aac8aa382ef9a55

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


