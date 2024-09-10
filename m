Return-Path: <linux-kernel+bounces-323498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D891973DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3AB1F274F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C01A2643;
	Tue, 10 Sep 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl6d1kqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211411A01B7;
	Tue, 10 Sep 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987748; cv=none; b=rCWalaRMpx1DjDm4mLbg/9b4aAAovdInDV25IPu/OuI6x2lRaDBOhuWAjQ9JbXUiIP03wk87J4anQEmlBQI0zZswCCEaj8KqnueJqRqsLA3i/gP+VS16yS8X0LXecoOZhx5J7DNtBERh89FgbnID0C/v7DSgqPPmyHAfimwq4cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987748; c=relaxed/simple;
	bh=24f1krsmyaFW2imbIpWYRK4/sAIUdmGGu7enhVKJ2rE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AniYX1VD/Rz7yupWtvDndkmVKlGQn6DKsK+UKShsc57dCFmddB+mUBQ79QrBSCED4M4Nx8QyIVT4i1tcP+oe/Qg5gFgpTlQbvDxnF1VsyUfH1MBy1K96TNkSQNqbUYWS8/HVu3OyUHrQpRaHyRMHP0ToMtUPO8LHpMOEQZdoH68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl6d1kqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEA5C4CEC3;
	Tue, 10 Sep 2024 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725987747;
	bh=24f1krsmyaFW2imbIpWYRK4/sAIUdmGGu7enhVKJ2rE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Yl6d1kqKRlImSAcRJo1FrXcY2bgNw4Gjr8w+nnUmn897MQ4f1/8RDZIcMMafFl4+B
	 /dam3990agUSZh0c6jR6DRQ+G/5A/cMdWxVqC0vose/6pieOAUiST2crq8v18SuKhO
	 j8Cf790eWdp6UX9QzT+FR0+wj/TQtYNQDubf5g5/cmKnhl4wwK5U4YSM93cBk7cUbG
	 SwXJ/SPzeKL5LmK2iZ+/J7MntaSijXhPoscbClMz8qAxBGuK0uuprY6yY1NuXLr02n
	 dZdaqm+vOKBji88IY+WP+q+KJV19J5xsLeCR7ts6jJ+LtHQZewlv8whebfeXMwKO22
	 Duij9sSuu5Rwg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Tang Bin <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240910013303.2044-1-tangbin@cmss.chinamobile.com>
References: <20240910013303.2044-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH v2] ASoC: soc-ac97: Fix the incorrect description
Message-Id: <172598774616.662466.5725639909959691580.b4-ty@kernel.org>
Date: Tue, 10 Sep 2024 18:02:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 10 Sep 2024 09:33:03 +0800, Tang Bin wrote:
> In the function snd_soc_alloc_ac97_component &
> snd_soc_new_ac97_component, the error return is
> ERR_PTR, so fix the incorrect description.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-ac97: Fix the incorrect description
      commit: 86a7f453e99c3c202ac1623557e4f57bd73fc88c

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


