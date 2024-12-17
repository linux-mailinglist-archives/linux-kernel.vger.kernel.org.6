Return-Path: <linux-kernel+bounces-449929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D9E9F582C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5C97A5B91
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC811F9EB1;
	Tue, 17 Dec 2024 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFMg1VRp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B21D89EC;
	Tue, 17 Dec 2024 20:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468776; cv=none; b=khXFKqLBDoyVBmGXNYeDt73OW5da0Rusnskm/N3vkn3aeuALaQVy+CqQhRAENTNomI8NmFnfXpgbPRgGSj55Sl+7LXQEj9EatukU/rPhKqdk2wdsARZYjOV1AUZyvEere6Xed1VG6g7RraiiS4/KsXzSWs7s6OfsHk17UzUaB5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468776; c=relaxed/simple;
	bh=NOgi4KqsXyLcK7GtFbxMpFylcjH9Zb2R4fGBxCWPk9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AwX5DNTyDqM5/kC/gLlsKml3iNHzezQdErnEzaITkWY/TdvDw5HLX/JI+rtpmW+AZghHZo1Ym1UX+hQ38EF05ky2e/3NvFHFD9k9hX59GZt8NlQwxcARFsgq+HlOWKsK21ZACaUBu9d2eJiYfk7nPKD6v78rfkdImCAaVVoUDac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFMg1VRp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D58AC4CED3;
	Tue, 17 Dec 2024 20:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734468776;
	bh=NOgi4KqsXyLcK7GtFbxMpFylcjH9Zb2R4fGBxCWPk9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SFMg1VRpUwGfXxOJTsg1kaMEbyHT6CfGiMLffAU+Hog5B1gP6oVTqg500VKwVg0Zr
	 yMpuBX/uQeub+rPNX0VZZFjMrlfb2JR8QknGS/LLDkx44sX9vvucIXAta72s5AYZU9
	 u3qYWUegDRp2T3WzcDwnbwd50TP8WxfpwUI5ov9h3OYFSi2X85VknuoBHQYhFVZAG7
	 yxML6XdjdYzwnG+SwniWXnHojD6Y6mcYbfKOPLz5+YDxXD2Ziq7onZJCKoQdBgMbit
	 Jjnyw3ud8gU+roEFbJxo5o8ITVZnk6jwyoAkzCIfT1Q/tkEjTx/MeLxloufwqb2o65
	 52XplhCvp8epA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241217171151.354550-1-colin.i.king@gmail.com>
References: <20241217171151.354550-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: soc-core: remove redundant assignment to
 variable ret
Message-Id: <173446877495.182159.14408273032161993161.b4-ty@kernel.org>
Date: Tue, 17 Dec 2024 20:52:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 17 Dec 2024 17:11:51 +0000, Colin Ian King wrote:
> The variable ret is being assigned a zero value that is never read,
> it is being re-assigned a new value from the return value from the
> call to snd_soc_dapm_add_routes. The assignment is redundant and can
> be removed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core: remove redundant assignment to variable ret
      commit: d349fd151f1aeb0d8aea4a2f0fe9ba24309609ed

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


