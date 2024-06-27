Return-Path: <linux-kernel+bounces-232693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAD091AD15
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9405A28324D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CDB1991A9;
	Thu, 27 Jun 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbuUJ1Pl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D3E56A;
	Thu, 27 Jun 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719506748; cv=none; b=a8IYQMZrZ83M+fAu1UkxP055ThVreObb2sq+gpqFTY2AhKeH9ZJP7qwAyV5egjRC99XhXL/Mv9KZFRAukjYCxagw0ws8D1dn3t5zX1GMdmNmx+2jVlaBnQSXNTZ3Uv1TqhFSxpVkS7bEoOR/kNgiUXapwuwRnKgvOLS4/A3B5yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719506748; c=relaxed/simple;
	bh=ehLBHgvsMjTLKrA3lXsAqbSSXkOgpaBtl+CYynRuFlA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KByiqk8r36Ln1bqbF71pVidA+dDrg/79/FCiWGkoWvoNWD3vX/a3KfohrrvYiGNJhkH0wcX5OBrjz1FXO8HKmdKjGJYd8n4pFe8j72DNSHpCZeOdEKYxtDOCA6G8g4Qos0KxG/3Mu9puu1/whujDfX4TVBF6AclMmQruyGz5MH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbuUJ1Pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C67DC2BD10;
	Thu, 27 Jun 2024 16:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719506748;
	bh=ehLBHgvsMjTLKrA3lXsAqbSSXkOgpaBtl+CYynRuFlA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DbuUJ1PlPIIoo+Ox/XQ3LxKNfHNeNaeqoZkEuN1kb9pGpETQn4Xnz1vQBv1mg9WTY
	 C87F0PYkVWt3lmpMuDJJeoJ2SxbQXmFDpytTbNZP+Z9q1buiqCsnalkBa9gP/JeZvy
	 Y5piS1uTNxStYgawXieNEadJiYKkVAVcPeO7BKAcWruiGgoukD1bBRFbq3c4/slN4b
	 ghhycZpWpl/zsXILJsMWbtsJ0IAoGa/q5mIvn8+LhbtfoFKrd36oCZtdzanVslkfsi
	 DKjPK1gBveECNutZMcVUt1ucHpZlMD/9Z5R9KKRHpHIOyCO0dEW3L4VTyCGzjCYk5V
	 WZIuYOfSvH9sg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel test robot <lkp@intel.com>
In-Reply-To: <20240627125203.171048-1-krzysztof.kozlowski@linaro.org>
References: <20240627125203.171048-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: lpass-wsa-macro: add missing select of
 common code
Message-Id: <171950674603.332147.2643144849799962522.b4-ty@kernel.org>
Date: Thu, 27 Jun 2024 17:45:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 27 Jun 2024 14:52:03 +0200, Krzysztof Kozlowski wrote:
> The Qualcomm LPASS WSA macro codec driver uses now parts of common
> module, so it has to select SND_SOC_LPASS_MACRO_COMMON.
> 
>   sound/soc/codecs/lpass-wsa-macro.o: in function `wsa_macro_probe':
>   sound/soc/codecs/lpass-wsa-macro.c:2767:(.text+0x1c9c): undefined reference to `lpass_macro_get_codec_version'
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-wsa-macro: add missing select of common code
      commit: 36ac1e29f49ff4cbf1500465db311b17d8ba9213

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


