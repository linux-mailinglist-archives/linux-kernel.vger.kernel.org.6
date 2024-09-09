Return-Path: <linux-kernel+bounces-321844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1518B972031
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DAF9B22F5D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52813176AB6;
	Mon,  9 Sep 2024 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAh2/l39"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1FF175D4C;
	Mon,  9 Sep 2024 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902331; cv=none; b=t4JtMBxDSF+8OUU3M4yQxZpa4aVQDIFrrSFHiNiWwVBE8CqfeCV/sWSTYe97mtoAUHOpg0zh/P9HQQRClNoQyIh+aWEldULST+qXKn1bNZ0Oka98NFU5eNydQsLQIJY4ntHzoW4nJuJySGp7Hf2ildHjbOY35MMKda5r5Q+cS+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902331; c=relaxed/simple;
	bh=0my6CiCfO1YSLi/x8EJebBhnlxug1KH7Le/Dp6Hn1rI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CWgzMqy7a9Jbg7ShjQ9MFw3aqwAmarGuQhnq1wM903f1MiINIeYhwpfBRk2t3MaP824nYSv5clkQaBBJc5LSjSJ5lhH1XIApsgZgVV9gmgFdBZYwO+gZOLGQpl34I7yDR9knAvigS1Kj+diDGGYdBSSdgxWpFlJ9ZVCaKhcIGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAh2/l39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE17C4CEC8;
	Mon,  9 Sep 2024 17:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725902331;
	bh=0my6CiCfO1YSLi/x8EJebBhnlxug1KH7Le/Dp6Hn1rI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jAh2/l396k5GbqfjNSaQBy3Jg/M415D6WaNic28NqN6ztZY8NtKkWpPtdeuUSedUt
	 dqkxeuQytTySmAQGoW2SS4Uy3WoBhaavUZP4QaZtEjGeGMLPkR8BClNcFuhH2wJ4vH
	 bdfTI4rv626NwLhGgae9ILHX85IGVthJ0E6EY1ICS/lQ0Eyg9wNFyVGfiTFsRdwFQ9
	 99VzDnoAaa4/FzpNhPL7jz+hk6p2PoCfu8sPBYtpcrjFoNTudw4/tcVkW/91zmwiDL
	 uK57Q/UWQ6MoAS/z8OMre954Of2e2QSOJoFb1pY5z67geJu2IWWc5nvzRVUJ6cb1kH
	 UvLW8+V0HRcJA==
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240907200053.3027553-1-arnd@kernel.org>
References: <20240907200053.3027553-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: mt8365: remove unused
 mt8365_i2s_hd_str
Message-Id: <172590232608.1707146.10719220040805343879.b4-ty@kernel.org>
Date: Mon, 09 Sep 2024 18:18:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Sat, 07 Sep 2024 20:00:38 +0000, Arnd Bergmann wrote:
> The mt8365_i2s_enum and mt8365_i2s_hd_str variables are not
> used anywhere, but cause a warning when building with C=1
> or when enabling -Wunused-const-variable:
> 
> sound/soc/mediatek/mt8365/mt8365-dai-i2s.c:781:27: error: 'mt8365_i2s_hd_str' defined but not used [-Werror=unused-const-variable=]
>   781 | static const char * const mt8365_i2s_hd_str[] = {
>       |                           ^~~~~~~~~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8365: remove unused mt8365_i2s_hd_str
      commit: 876dec03fdfb7eeb592d01a95ba292c9e53b324b

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


