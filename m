Return-Path: <linux-kernel+bounces-229470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FC4916FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ECA1F21A14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2625017B514;
	Tue, 25 Jun 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gor8EwdE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D7143882;
	Tue, 25 Jun 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339148; cv=none; b=FTT5pXRvyVOhlCvacdoYkUZkWVznobYTgHrL27PIlC42Y9+Nr+eABgSzK9dEOyw16ST/vQe80xmJVSwcr1yb32TMl3vyQ7hIcfL5euRvLvoVmMVqRJ6giHQyzneHR1rR4AWa308CbVX+Bh3QBNWlLqhFg3AQbgJTiv7HZinATEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339148; c=relaxed/simple;
	bh=YBL54ASTB43Bb8xG1VpSbPugMuORK4VYkKVXySxi5Ds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sr5Tys7b5OQk5+AVNwfm9ygFOhDCd0+M4bSZPDCjCr1n3CtVE6VoN5Psqjls6//BK77YBfc0CJuAXKmQoqlP4nB91pA4c5FpqYYB5hUTgmTQEnbS+evxDvl/nUQDzAHfU07yj4ZQ8C37RT/Dlu3fYrSZB91e2SKP2jZIwlqQH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gor8EwdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC834C32781;
	Tue, 25 Jun 2024 18:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719339147;
	bh=YBL54ASTB43Bb8xG1VpSbPugMuORK4VYkKVXySxi5Ds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gor8EwdE/DHE0Gqd6niWzu4Y0BicfGjx3l1XaX6YzyD7GmbuyYLHWCmQBGrHY39XT
	 5Q1MBE+cd8qnYvlO9B6APgEL+b7/fAdvoO/LBvEURODsj8WihXBzPzYHwD5f/J8clz
	 HMj4oHl02meuTxqVu0da9sI6yftKwObQIzocIyu2ufRjnam9PzpdSbV08kJUn5+V/6
	 NwzG/p+9JsfZb9JrBCnR8B2I/Df57/m3jwTNjV7vHgHEq8WPsm0Q9UsLrTBWooxJio
	 yBGRXsGQaHJ+mI61jdrsOIH4vsBqPslzUQatNJocmMbyTmFfDaHNiO13wmXmAsUiUB
	 /BQq+GV7fuGGg==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240603-md-base-regmap-v1-1-ff7a2e5f990f@quicinc.com>
References: <20240603-md-base-regmap-v1-1-ff7a2e5f990f@quicinc.com>
Subject: Re: [PATCH] regmap: add missing MODULE_DESCRIPTION() macros
Message-Id: <171933914663.1078204.8928902900439459537.b4-ty@kernel.org>
Date: Tue, 25 Jun 2024 19:12:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 03 Jun 2024 08:45:08 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-ac97.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-ram.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-raw-ram.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-slimbus.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-spmi.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-w1.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-sccb.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-spi-avmm.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: add missing MODULE_DESCRIPTION() macros
      commit: 92955a25f77046c1900f95748f97bf77192e9fe8

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


