Return-Path: <linux-kernel+bounces-318913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E4A96F505
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB12E1F22A23
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BC81CEAA2;
	Fri,  6 Sep 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSSdplk9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F31CE706;
	Fri,  6 Sep 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627966; cv=none; b=X4uJEBfvCW1WbKcb0U4sJ9ysrUeqIW0ozP6U8PDXgvYwLGrlgBm7A8m015t7WjEJH90O3U6or2+OWKGqdMGUbxs2DRbgQMhOaPyi3eBXDZ6TPvIovlz4QwfzvuOswJmJrVxoE7iyQexOD0IPsM4NaIq9KDQHy8EaG7z0eYkRtfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627966; c=relaxed/simple;
	bh=PzQtuj58s1m6hfHiyF9Oj2TCTBi4ABvLhfkuhzcvK6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Jll05bYqToaMiI+wItmI8PvwTAufDNWvVxE9gawgFmQPIROtcM8KpKiHw6fr9y9I/3PO2N2BkP/jJQNXLsEqsjJqFP3o1/o8dRHrS3VYQtw20d4REUfLPOSSiFGOw9cDEOhw8Nq3AZb4jioH5xplc7VUXVuYnxb6ZtR4JbGMf+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSSdplk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2167C4CEC4;
	Fri,  6 Sep 2024 13:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725627966;
	bh=PzQtuj58s1m6hfHiyF9Oj2TCTBi4ABvLhfkuhzcvK6s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RSSdplk98Es/e0Iy6R6OkRmgpUgC0deitakX/yxShqoGCzJrEctYhLSvKo7Hipd5U
	 bN02BEH/96c1FO9XAxzrurMKPlU3WKgNPpxVWnY+q7Ylq6hwWPiBIqrQ3PtNqbRP5D
	 q7a7/JtUIuUvltcwoyZqcSeLMi8B/wGI8y4jzapLZ0YqK+BhM1ykZaHLThTGLmQfey
	 XPH4PivvEMUU77igb5G1Ec67hYJU+ptoSfYhW6f4qEOem8hvL6I7DcpcvfbWHCLz/D
	 hSRvzDCcftRQFq+p0PDf9szbIyIQwRtlEdX0sjpV6aqgduYLC7y3Rmv9zJJwxsXM4o
	 6XquD9mrC+KEQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240906100523.2142-1-tangbin@cmss.chinamobile.com>
References: <20240906100523.2142-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: loongson: remove redundant variable assignments
Message-Id: <172562796127.927452.244425997808347061.b4-ty@kernel.org>
Date: Fri, 06 Sep 2024 14:06:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 06 Sep 2024 18:05:23 +0800, Tang Bin wrote:
> In the function loongson_asoc_card_probe, it is simpler
> to return the value of function devm_snd_soc_register_card
> directly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: loongson: remove redundant variable assignments
      commit: 1798acef8f50af59abaa0ff4775e7a79a68db671

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


