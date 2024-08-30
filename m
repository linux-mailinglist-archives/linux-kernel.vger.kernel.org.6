Return-Path: <linux-kernel+bounces-308864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F59F9662D9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28C81C22546
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573881A7AD0;
	Fri, 30 Aug 2024 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI+ILC2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D89179652;
	Fri, 30 Aug 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024360; cv=none; b=j90rRXl1xjsU1YKk3kg7rS5XYguGWsq0m4BS0aqxquYb/3NdcPY918Az2njM0wN3yyVmbW7QiziRB7ckVUFSeox+ADMVhEP8A0ycSC/0q5OS0+MB52bNrmPt0QSH+/M7+SzUFM8JJjHV/Y90isnModtwgLt210NLylDH54HtVqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024360; c=relaxed/simple;
	bh=yNTgcxt0Jvmr1cytFFcqGGu1C6A7n+7i6AMHuwra94s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=msOhP/gMgYbJ/R00kMgllF8T9supJRg6RfIOnnIAfX2CiMtBYFfKLXLc3B3UzI55P/jNMXytjCOG0r9Slx2RKDzjh9j9LvUqJlxqSF//SBOhxM7arWDHTUvFs9T1UY569VLxg7h7hfPdNn/LC6/vEjcxTsuDSY0FcV5/JEccR0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI+ILC2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73574C4CEC2;
	Fri, 30 Aug 2024 13:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725024360;
	bh=yNTgcxt0Jvmr1cytFFcqGGu1C6A7n+7i6AMHuwra94s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BI+ILC2WBeJTDWqQrcORGhSJsg6K2Pz+RbA7txVBNCZbIFbJGr1sLhCKonLQQsV9L
	 VvITUft3oYcXxBAYx158mDpAeIJW1LzwZeXXDjLwltTWiLfAAj28T9sJo3vXsG4ZiI
	 TPxCvcnL4dwMiVPDPcFIZKyWXgSpEqQ1RdArVD/Y1JOh6uPrgIlEBvI9pCTsMW5vuf
	 P+8dAXUHiBMNlDsNZphv+FSnM+U9s0vEkLCaAr6bIYV9plDFnVsUZbEu60htGMAcnY
	 wTOtyqUK4vXhSIO1g8dlRiNt4JNg7YiNYa1hgKGKLucL90XuPxT321iwazF/agsdeI
	 lJa6oh9ZKcY2A==
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
In-Reply-To: <20240828-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v2-0-58159abf0779@linaro.org>
References: <20240828-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v2-0-58159abf0779@linaro.org>
Subject: Re: (subset) [PATCH v2 0/3] ASoC: dt-bindings:
 amlogic-sound-cards: document clocks property
Message-Id: <172502435719.145062.8812088921353096920.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 14:25:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 28 Aug 2024 15:53:53 +0200, Neil Armstrong wrote:
> Following an off-list discution with Jerome about fixing the following
> DTBs check errors:
>     sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/amlogic,axg-sound-card.yaml#
>     sound: Unevaluated properties are not allowed ('assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' were unexpected)
>         from schema $id: http://devicetree.org/schemas/sound/amlogic,gx-sound-card.yaml#
>     sound: 'anyOf' conditional failed, one must be fixed:
>         'clocks' is a required property
>         '#clock-cells' is a required property
>         from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: amlogic,axg-sound-card: document clocks property
      commit: 4b1d9019b26fd654ebc2d0d2e100ed56ef1821f0
[2/3] ASoC: dt-bindings: amlogic,gx-sound-card: document clocks property
      commit: f189c972f86b00318cf2547b62e461cb98374e34

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


