Return-Path: <linux-kernel+bounces-566440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69037A67808
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC23189C24C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC020FAA0;
	Tue, 18 Mar 2025 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlLL+TSl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0035520F08A;
	Tue, 18 Mar 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312059; cv=none; b=JZQRwz+o141YKs3+jwwKNGhA8jlBQHv278XhyCVN64VyChL58X0DCaYAtUz3XeBfnP0NhkmYKEy7xzubrWYHbwNgZzSEKTgcLxW1yRjD7pSRsC0MwJ6D8R/65CVdNALHFb4v43goEOsQA5dx4ycZTVIgBlvEIzQgnwyVNsfmRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312059; c=relaxed/simple;
	bh=FomFCw0zAmCRuXTRyuhex/vAVJdRq1ZZMCpn4ZfmrBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OuepFA/cWdw9Kk0XSNVm3lS4es52cXaRmCcWJQMux39qrfq64GFjBXGrV9Of2HQAQdMfoYU5Mb/pO0oQjKzO00Vz3tL5pEz/E2j5woXyrYEAl8KVJh9Gk41HRby3N+h1KRRL2bz1vfkfR5Uv0I6tOOiU22os19NFV/nFBMKR2A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlLL+TSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033A1C4CEEA;
	Tue, 18 Mar 2025 15:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742312057;
	bh=FomFCw0zAmCRuXTRyuhex/vAVJdRq1ZZMCpn4ZfmrBw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hlLL+TSlZ8zSbstHJa8o1RHzfwaROpZlvHpq5DRKXJdCN9aNj+oDciRM7CWZfJE7C
	 /41eBJjHAi2bUijT6YcrY3QFyfisx/bXeXzf/v9sD6qWWL234RYGyz8jIzrNeEUKf/
	 Cka4WTRYd2DhRhb8ImMFKsLGGaDLjh1fuQvryso4PpgRgdYDgSCeB0lliKXthtHcB8
	 WGWkUNfB3IzSQfEF8RQ58lthV8akLPKQm+uvvjSw6ggYXMhtAqW6RZufB/KySUQqT0
	 tL86k9aKz9pctHJWI/ZZE9OzHVyLRc5a6KnlEFAxI0sjvBM1wys/Ehsosr1oiWW+c+
	 UnS9SSFcK2VqA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 ivprusov@salutedevices.com, u.kleine-koenig@baylibre.com, 
 Chen Ni <nichen@iscas.ac.cn>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250318081043.2870229-1-nichen@iscas.ac.cn>
References: <20250318081043.2870229-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: codecs: ntp8918: Remove duplicate clk.h header
Message-Id: <174231205574.165223.12161617500908492912.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 15:34:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 18 Mar 2025 16:10:43 +0800, Chen Ni wrote:
> Remove duplicate header which is included twice.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: ntp8918: Remove duplicate clk.h header
      commit: 1822c4484efeb8056de53bf4edfca377d2939418

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


