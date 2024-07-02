Return-Path: <linux-kernel+bounces-238212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB69246E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B961F26795
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D6D1C9EBB;
	Tue,  2 Jul 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0s4h+AD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C02F4A;
	Tue,  2 Jul 2024 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943392; cv=none; b=DKx6Cbgn4DV0++svCefNB/rAb9Cqwl5c6zitc+KvLcZU0pflKpgMI0V/qApdh7Jl33hD5HGNh+k1cKy9jKKFJsh9pEsYOuTRZGvrw0gqXVL4wKzk1CoNIwAV+wxK1/9xktUZ+ypP4IHXSbB++3tPqDo+i8+Nouzf/xlfXXiI7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943392; c=relaxed/simple;
	bh=+V/1vASOgtMkSpHriCblfChzgeI4EF0vyr4JiB9hAdo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jP/d9UFbolH7MirZernk2ZN5vTa1ft2duF5bJoGODXEqyHmCMTaKSTGvLv+881Xrw6TDA6tbJapXZYR927i0Xph+gEty7pt6S6V/dmsGl8PI9vSq7ZVevPaJTQ5sLuZ3MpL+y+07C+mF9LiqGE3e1kIfhMmWC2g7V7DeJKnr36U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0s4h+AD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969C1C116B1;
	Tue,  2 Jul 2024 18:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719943392;
	bh=+V/1vASOgtMkSpHriCblfChzgeI4EF0vyr4JiB9hAdo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=U0s4h+ADasx4Ery8ujuVrP5yR4QxNj749vMxx2KNEajkFWhOxtWRjJiUCzSosWwXe
	 I6VjYo6i9NB166vNlH1YDgpQcTHYjt1WnJnHDSMmyXrTw192F8Tdt/ko1A94u2SXp7
	 wkG/ja9BVv3fGnXhB2A71Bm+90ITeFSrsGMJdvzTO0mteUJhtpESi+EaaWekqzni5L
	 pxUmrOyeovbp4RQ8JVoJkIXkPVh7prwVEDhBV29ee7FieYLO5y5kyXmscXxzxkyf5z
	 7IdHM9gorzoA4HE9dvR2TM+9+omrwn1Z26hu3hOGIevuwAMhotRRoqAgf5SF2MXAsA
	 2VCm1TXNRLjNQ==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
In-Reply-To: <20240701104444.172556-1-rf@opensource.cirrus.com>
References: <20240701104444.172556-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/3] ASoC: cs35l56: Remove obsolete and redundant code
Message-Id: <171994339125.996226.7675778991183465328.b4-ty@kernel.org>
Date: Tue, 02 Jul 2024 19:03:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 01 Jul 2024 11:44:41 +0100, Richard Fitzgerald wrote:
> These commits remove various code that is either no longer needed,
> or is redundant.
> 
> Richard Fitzgerald (3):
>   ASoC: cs35l56: Revert support for dual-ownership of ASP registers
>   ASoC: cs35l56: Remove support for A1 silicon
>   ASoC: cs35l56: Remove redundant clearing of clk_stop_mode1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: cs35l56: Revert support for dual-ownership of ASP registers
      commit: 5d7e328e20b3d2bd3e1e8bea7a868ab8892aeed1
[2/3] ASoC: cs35l56: Remove support for A1 silicon
      commit: e2996141d6db0d8b353e1c221a37c8e1be109d4a
[3/3] ASoC: cs35l56: Remove redundant clearing of clk_stop_mode1
      commit: e5524e3316ac54ca04dde3bfef4565bacf72c594

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


