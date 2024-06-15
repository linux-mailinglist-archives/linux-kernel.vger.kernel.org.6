Return-Path: <linux-kernel+bounces-215924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FD49098E7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231011F22237
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988634E1D1;
	Sat, 15 Jun 2024 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGHhU+eY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AC94C622;
	Sat, 15 Jun 2024 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718465067; cv=none; b=ojkBKTyVI0HhpJ71C/Ji+S0CiRVkwYK3OhLSpn+xCr71uhDZiVckz5WmcSquj9HCpEh97dGU/sH5+bz1TQRJ67Wwx2hCe+sf2wcIaENtdhgTXw4hcQBkXWcDfj6JJTqg6dkafGliffcUsfWA+I+w9pE52vOExDmtoNck2OZwZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718465067; c=relaxed/simple;
	bh=39IhOv1g0B3rh0LTqn1n/5d4N1bcXOo4D9fjKDG2cLM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Frhs/FsD243UBgoB9743lwvTPBE+i17UYQwm80dZ0bD9on097JihWf99xgqUUj2Gg2JIkTXwThrdR8txmaCX2oFg2LWibdBkJcjWq5p4LwsFavszQND8qcAzFmeEwVZS2caN0cIA0oSxELxuFoJGzrKdGNpfxLIk7lFsIAgfV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGHhU+eY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A255CC4AF1A;
	Sat, 15 Jun 2024 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718465066;
	bh=39IhOv1g0B3rh0LTqn1n/5d4N1bcXOo4D9fjKDG2cLM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PGHhU+eYEFcZxr6GYro8q2Y5PAJojAY0HY5hpspKzbRLZS47vzVKiKi74EvoFfKSb
	 MUyaaG40amewSXDzcYqx8XjVeMLCZKF8sILLZkQXWx5N6xtC8dAWp3sZ+qFbFsePhy
	 Uo0Fml5UMj/sh5m4I5OaovCsb7BEE4zN6BLiVrSiDbZbm8EXHoj/tfqST5Vk3/d6vO
	 LcrqbhxDnaqqza1BDn0MAmKF6RAgoyYWCV+z5Fh10GPe1uEMeAJDgS7RBZfCc/vsbM
	 w5zGMq2C79YNbKMQjVNBFcGnxtPfhEZ/ftzILZ9NzPDOs9DelzWzADVJkf76ENJgpL
	 9Q36Grh30kAnw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240611-topic-amlogic-upstream-bindings-convert-tas57xx-v2-1-38269edc1d95@linaro.org>
References: <20240611-topic-amlogic-upstream-bindings-convert-tas57xx-v2-1-38269edc1d95@linaro.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: convert tas571x.txt to dt-schema
Message-Id: <171846506635.317831.8153225167597997134.b4-ty@kernel.org>
Date: Sat, 15 Jun 2024 16:24:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-0bd45

On Tue, 11 Jun 2024 09:30:04 +0200, Neil Armstrong wrote:
> Convert the text bindings for the Texas Instruments
> TAS5711/TAS5717/TAS5719/TAS5721 stereo power amplifiers to
> dt-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: convert tas571x.txt to dt-schema
      commit: a9c8ca5d5d8452ca38300c7fb74bf8735d08f43b

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


