Return-Path: <linux-kernel+bounces-544390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A62CA4E09F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7CEC7A2AE3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4354B205E3F;
	Tue,  4 Mar 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6IrCMXj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC6205AC0;
	Tue,  4 Mar 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098051; cv=none; b=i5323iTL+X/4LuDmWdKt9bR/fYBaRPUC9kWFMDDhjZqCcopEbtADuDJFqyvypduEvwmGao4bZ285WClyy3IIRjWo4MC8pxQWTkQSqI+QbxwdRX27FdJ5rERIqB0DqSdoICH51/E4h1vHJVX7ALWD5qP4eBgfdGoNO4nYpwQx6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098051; c=relaxed/simple;
	bh=+pBXOayyf9BNqhs5spCaxkRNmpKnPL7e7EGZZvlk7HM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UaNOKjhUUN7hoCEMzee+0umlpemD//690xl6SMf0nc4OdPaPMyVCTHKiLU/m5rdnW43uUfx5WLeS+kDzeucUsI77AgjtYbM3hdjcClHq+XkBoEnz/irIt00DscrUrUqqeZyGjWHaqTWdWmysHRtEFT9h+O9CiE1F9S4koWwOwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6IrCMXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAF5C4CEE7;
	Tue,  4 Mar 2025 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098051;
	bh=+pBXOayyf9BNqhs5spCaxkRNmpKnPL7e7EGZZvlk7HM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=A6IrCMXjZWg/IUAoMqmhAKlvFgbE9GqTK+bAh56u8k4L1M8HvRC2PnOON/LFMAkRs
	 87DYhnv4d21WqPNrCGgI0KiGanS822+3b/vU5TU6THeIBYJD7SUDWbyXtVHSasssv/
	 Ruh3/4wCz4s46e4JZuaAfIOuCRRmJOl/obrA1ju3Y8krxJvmNqU7AeGIWMvRFi5uh4
	 POucKMsbJdZHxtJ2mQW1wR8XfuHZfZK36wLjCH8oGR/YuYwvLO9iQF0BkACXNOrFMz
	 OV2k+xBR+AqJvO2gdopXtQHb++eLTWBTQGsN0pqawV6Hc/1QvBmrW/FVFg6yKxMfxD
	 vb4Kqo+CB5/rg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 David Yang <yangxiaohua@everest-semi.com>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250304103808.75236-1-krzysztof.kozlowski@linaro.org>
References: <20250304103808.75236-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: everest,es8328: Mark ES8388
 compatible with ES8328
Message-Id: <174109804942.69310.5970184751465149594.b4-ty@kernel.org>
Date: Tue, 04 Mar 2025 14:20:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Tue, 04 Mar 2025 11:38:07 +0100, Krzysztof Kozlowski wrote:
> Based on Linux driver, the ES8388 looks fully compatible with ES8328.
> One upstream DTS (ARM rk3288-rock2-square.dts) already uses ES8328
> fallback, so mark the devices as compatible in the binding.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: everest,es8328: Mark ES8388 compatible with ES8328
      commit: 1d251a7adc5b720a71641c758a45b8a119971d80
[2/2] ASoC: dt-bindings: everest,es8328: Require reg property
      commit: 8243a49145e59f19032b86b20d8906f05e31bdcc

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


