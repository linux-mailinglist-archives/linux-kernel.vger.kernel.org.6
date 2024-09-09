Return-Path: <linux-kernel+bounces-321845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDED972033
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE9CB23426
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D852416FF45;
	Mon,  9 Sep 2024 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoNfweyk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C716E89B;
	Mon,  9 Sep 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902335; cv=none; b=FRwrunV5Eu9LoafIkuDNP1eBqtLJRzfGKih+jt5+HgwhiSivocJoTMZfixBCU+QRj7Vp4xjAEbyY7u7MmED0XSNvgAkd8FOAh2nRBanmM5gUlv6+dH7oHr/V+KWnZCMK/iLsRF9d8Lwb51nDA+njfexx+bYvXyzJ2APhgwza5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902335; c=relaxed/simple;
	bh=EhoK4r8YL8dVYI1oM5qZI8MIrFWarHcSHL0ip3G9iw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Queu+ViNeLNo+P+ycOq+Ov8vAvey3u81aymrSgpEKIp6p0+sgbDuea75AsRSpgsXNRq+JMq0+fYr0/GcvW0h3MyRlTtU9oPk706QODetGOfOpVNdHhQ3G6y1EE5oXvJ+IWLXnE9Ex6T0f5pIPRV5Y8RJ7EcumhSwlV8jD37lB1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoNfweyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E5AC4CEC7;
	Mon,  9 Sep 2024 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725902334;
	bh=EhoK4r8YL8dVYI1oM5qZI8MIrFWarHcSHL0ip3G9iw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MoNfweyk+KZ23+E30IX43XB2oxHv24uNClsK9sCkJuO4txLMOOI6Ha0hjsDcoBPDW
	 y5JL3lbnUIwVyws1OWsNdPk56DtyJUTrql6OZNItZbjQrVmAtbv+xOknkYh58vYWZB
	 4s4M2w4t9MNvNgwDH10C4elbKGXgLqeEX1UrJSToovIka5MvJQQ0CZyc4Ydm0bXDz4
	 sFrLTKkI3rarbA7EfrMib08D/z7tKsYkD+bsAJpHWV9lL3riHR12HiA+h4X3wKpOQi
	 1hw4JwJIGkaxDcjX6nAoXq2v6DRkgaPThUvN71u2mxhO5davDqEdsZM7wmIaNYY9NL
	 y1QO5embhMS2Q==
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240908221754.2210857-1-arnd@kernel.org>
References: <20240908221754.2210857-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: mt8365: include linux/bitfield.h
Message-Id: <172590232922.1707146.8389752525404411197.b4-ty@kernel.org>
Date: Mon, 09 Sep 2024 18:18:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Sun, 08 Sep 2024 22:17:34 +0000, Arnd Bergmann wrote:
> On x86, the header is not already included implicitly,
> breaking compile-testing:
> 
> In file included from sound/soc/mediatek/mt8365/mt8365-afe-common.h:19,
>                  from sound/soc/mediatek/mt8365/mt8365-afe-pcm.c:18:
> sound/soc/mediatek/mt8365/mt8365-afe-pcm.c: In function 'mt8365_afe_cm2_mux_conn':
> sound/soc/mediatek/mt8365/mt8365-reg.h:952:41: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
>   952 | #define CM2_AFE_CM2_CONN_CFG1(x)        FIELD_PREP(CM2_AFE_CM2_CONN_CFG1_MASK, (x))
>       |                                         ^~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8365: include linux/bitfield.h
      commit: 6b31d6a4ca3b4d8abfb39127130889f9a9a38aa1

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


