Return-Path: <linux-kernel+bounces-385385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5282E9B368C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8361E1C2185C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAF21DED7B;
	Mon, 28 Oct 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQDd0Gua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0641DED67;
	Mon, 28 Oct 2024 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133206; cv=none; b=Cvgw5oaaddsi3W4kB8Xb1iz5mFMIk6Py5W3k3wfOJm79OvIo+HOKi2NY8UbyiHMawYq4RWrpC8ZHHlCg4skij5u9sfhaLfitDtniPHTSuwtm81zcU9ABj+Zd937RC5vW9aYVew4RMEXKZZJvJRQiM6N/wkbnlkkTfkikVJCcWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133206; c=relaxed/simple;
	bh=S91M8ypzp/zcYlMWhW5ocjNcjVixVQtBVDCTW1REdwU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l5ZbFIOqJMn410Z3I/dXWChnrdrzwa+5btPE2oPBoyxl0/WM4PgsgTwLhMFEFnxKABg1t56SkXTrRcxSwmn3agqQXPPgTAjBBVkP+eJk5ZozkrS6sOZ5ILbbLGzqQvBTXEylfOZ+97of9JOtUUa2FBKsA/ntDMKlexlgwCf9Ho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQDd0Gua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C13C4CEC3;
	Mon, 28 Oct 2024 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730133206;
	bh=S91M8ypzp/zcYlMWhW5ocjNcjVixVQtBVDCTW1REdwU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZQDd0GuaUbbgh0rmYIVDqEpzXBZHmxwoz6g0cnWRkntmLl45twSV/uYkz7KgGnOS9
	 oznKvJacNxPUh+9ia0wZUQ+qhe5vYqhAxD/qWy8Ks1O4j+utDckut+aZzTKmuNYBgP
	 h+vtcZZ/dogX3Fcw8kYdTrF21hK+winV1ugSHf1qfJI+4z2dN7RMjBATWvrwIQqC0N
	 VLrhJFmlJUtbM9lWjuUF6/FrYC8WKfmZ43NjDKS4adwBuf2YDZNxcZV08VJcjlTHbE
	 9LEPLLKALfQD9lPdvHYdT3GREyFaReABJ97NOf/sOXvbxx9D5Wcfo122zBSO/5fG42
	 W1ZwCjRID+DBg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, linux@treblig.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241028021226.477909-1-linux@treblig.org>
References: <20241028021226.477909-1-linux@treblig.org>
Subject: Re: [PATCH] ASoC: soc-devres: Remove unused
 devm_snd_soc_register_dai
Message-Id: <173013320514.78752.17890412410852640368.b4-ty@kernel.org>
Date: Mon, 28 Oct 2024 16:33:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 28 Oct 2024 02:12:26 +0000, linux@treblig.org wrote:
> The last use of devm_snd_soc_register_dai() was removed by
> commit fc4cb1e15f0c ("ASoC: topology: Properly unregister DAI on removal")
> in 2021.
> 
> Remove it, and the helper it used.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-devres: Remove unused devm_snd_soc_register_dai
      commit: dea15b2abdb09608af5909ed7d168ec20f36a81a

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


