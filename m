Return-Path: <linux-kernel+bounces-376367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB69AB065
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B7D1F231C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B829C19FA8D;
	Tue, 22 Oct 2024 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuNQhZ+0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80619D88F;
	Tue, 22 Oct 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606058; cv=none; b=cTfeUVBhPeWnjo0Ko9duzDA5N0tXyk1HPzLlEylRdGilhP5vBFcHWEa/Rh+Tx+DUiwDmr2vht7Qx2CIpdA9FK9hYn1rAzC4UBWJ87Qj0lTT6R35OfWejbv+GR1XI3/zwfESFEVpH9guJPMjOKXsFhtPYRAMz5VUnDNJkzix0WJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606058; c=relaxed/simple;
	bh=nE99iModeW89lNsWiK+9LumvbIMcQgQJxkg/6DSWG1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UjCJC+4m9DVvLFZ/6aYv9Pst4hcYPOQ+jCnlX8uSUxZMQsx9SCV5qNeu8QH1O4DPfYwcftT9viFoWB4Dddzfv9yLwbQm/aTaWmuV1kdOt2VRQV1fnrtbgqekmtjy0ODuCt7nDXQjydV+yzwJz5QboKYctMcLLQ10lnahDrcHyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuNQhZ+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F3BC4CEE6;
	Tue, 22 Oct 2024 14:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729606057;
	bh=nE99iModeW89lNsWiK+9LumvbIMcQgQJxkg/6DSWG1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iuNQhZ+0zO+BtdYdxmtPJTvw2kCskxbWnd4qO093Pf2BOOxseHlVIuSprOW2468SJ
	 VoiukHPrnYoALtql/o+yejCyB5scsHEsCmi1fVI7FQ4ex81MCrNOHe/ZCz5rAgzzrT
	 3DIGN2F4RbIGOm738Zx9L3kikKVo3haU1qbabRnUVQv7psNoQdD3y2nKKlsMF3+pZc
	 zY5Ox0dwa1hnf9Te+czDDR3U4FXHWsOXZ+AsxyApHNB4kWGcUi8TfLgYSYuqATTP9c
	 y8lVQ47Z+/CoCIk2m8L70smVVStoW0OWA1tBXm0uHD+10Jn7RuuHQWXP6MU1q/8xAp
	 BcljCpL9OfydQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 David Yang <yangxiaohua@everest-semi.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241019-es8328-doc-port-v1-1-25c1d1b5c65c@collabora.com>
References: <20241019-es8328-doc-port-v1-1-25c1d1b5c65c@collabora.com>
Subject: Re: [PATCH] ASoC: dt-bindings: everest,es8328: Document audio
 graph port
Message-Id: <172960605518.41803.10563200262175057259.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 15:07:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Sat, 19 Oct 2024 03:43:14 +0300, Cristian Ciocaltea wrote:
> The ES8328/ES8388 audio codec is currently used in conjunction with
> audio-graph-card to provide an endpoint for binding with the other side
> of the audio link.
> 
> This is achieved via the 'port' property, which is not supported by the
> binding:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: everest,es8328: Document audio graph port
      commit: e6d20a9b0f376fda3e3c3709a59cefa6c0021784

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


