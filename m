Return-Path: <linux-kernel+bounces-241290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73574927969
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6281F2192A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8324A1B1205;
	Thu,  4 Jul 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+CqAF47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23531B0117;
	Thu,  4 Jul 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105318; cv=none; b=hCoS+ZH5m7UN5Y4BVDo1QeDHRZ+DQHx/3XIDlXrg4TV8Aa6ygqEHcRW/gYnG0rC5rvOfhSfrlzpVgKf2me9/1kXw8FtqqQN6cBRPH/eTrHjjj+GEhKAfUkEl1CO/7Ud54FKRi2ZVj/4VbvmG1aaCZPE+WSiR5ueAEsk7e4j9cZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105318; c=relaxed/simple;
	bh=GD38v98uEi0utGYisW2QYjJqD4Hgh4wQJEQUjjOKZFA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jRypIRGoJQ+xMSChO//smGvpkwMY8vwhoDxLTCXpDsfGgUYl95SzhKr1or5lCQNET2p9s7ljyEHjnVTCFBbf7VghsS9NJMTQrEBxOhYteioXhxBCz+bE6IKBpfW/U18QttKLXQq8RX8OY0GtHGwPTi4uJoGpSiflhoHx8TjZLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+CqAF47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696E0C4AF0A;
	Thu,  4 Jul 2024 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720105318;
	bh=GD38v98uEi0utGYisW2QYjJqD4Hgh4wQJEQUjjOKZFA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=F+CqAF47A923IQmQNjQ27xkQ6SW5Zd2kFaXfJDvsChXEnG6+0TBrRkKyWN7V6HLu0
	 ziDESXcO/N/NBHgGsH8SkO9y9KIk+zJsXkjIgT6DK0Dh6nUF4FppPDlcqY6BQd6fNp
	 6RHM2vQzcrtWMHPMe2QOBSpkyvbnoe+2VNu1w+4qUSr9Gqbdd/Hcis/zFs03iV/uEs
	 5rTic+ZvEoyhaPMhVVi8OZxsUPHoWOOrSaurXeYvRfEcZusPCoHiohG5ezJ0uTkpDJ
	 u2GntCvu/fhem6l1AZSfYwNPqQCD/umaDvon5wFBMXFM9xzEnFhzk/+r+fiyhXt+2I
	 ly7YBQ497pejg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 ckeepax@opensource.cirrus.com, andriy.shevchenko@linux.intel.com, 
 heiko@sntech.de, robh@kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1720009575-11677-1-git-send-email-shengjiu.wang@nxp.com>
References: <1720009575-11677-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: ak4458: remove "reset-gpios" property handler
Message-Id: <172010531616.64240.2044968074924246988.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 16:01:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Wed, 03 Jul 2024 20:26:15 +0800, Shengjiu Wang wrote:
> commit c721f189e89c0 ("reset: Instantiate reset GPIO controller for
> shared reset-gpios") check if there is no "resets" property
> will fallback to "reset-gpios".
> 
> So don't need to handle "reset-gpios" separately in the driver,
> the "reset-gpios" handler is duplicated with "resets" control handler,
> remove it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4458: remove "reset-gpios" property handler
      commit: 1e0dff741b0a8af35645e5c3ffc4050893002a9c

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


