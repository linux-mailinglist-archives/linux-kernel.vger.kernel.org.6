Return-Path: <linux-kernel+bounces-266191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB37A93FC31
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193021C2205C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4425E1586DB;
	Mon, 29 Jul 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvqqIwhF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8702815F3EE;
	Mon, 29 Jul 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273435; cv=none; b=F8fHISnb9RhNTE4FE61KwaliP1SNgoOs4lpx5TKpV2YZusUdj+lZnz+XVwlaZdYgP6RpPfDUMJ/PU83wtNf7YHq2vIfkYBNQuFlqZqfW7aYigM9DM/TW9twIDIyN4KxSDqnkDVk2oSOXDvj5Psji43Kf8kEPycKrCLFtscUnNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273435; c=relaxed/simple;
	bh=WZi2WB+ezf+8ZuZSA/9WSVZyOflnes8c4WhG9OHbKSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eE6YiKQUYM5Myayj/1c3MiuoM81shuXgL35QpMXDCZnq5JGsyx/flvdBoPOykVV3VxCxvvWh5ipYeGRiOtg/D4uQ4rWu6SGzYjBJ2EmSi/vik2lCgvoZViNeV8BeUItc4XBbFQeRezDLXNtoYeqll2Pu5S9wBfFU5MdE/zHc7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvqqIwhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1495C4AF09;
	Mon, 29 Jul 2024 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722273435;
	bh=WZi2WB+ezf+8ZuZSA/9WSVZyOflnes8c4WhG9OHbKSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HvqqIwhFTPi/2O2OcCDM+0ICAi+5ega/pV8ivBwWyVQAvqULngMmL+0Jp6OA6eAJX
	 ecQgYDz7sA1s5YSFLJzzH8+/otov1OWXkn0aMHdhGlrj67W1jT3tUobdI3mE/nJitn
	 BI1VoAnnkbq+UFgGDM2jkYPocf3Rllps4xZgyMYxDMB5qesIXqU8dZqgfRY2qwj4Ya
	 vjiJuNhzLaBQJMjTFcOy98KqyVq6QqoeMfaEXPYg3J3hojPHPiiMX6RItZwhX9saI1
	 HWI4O9UYjL7oa96DdmiFuDESsEz6MQvbX1Xn4oke/VwuYpWAbpPEKB94ytNkMKVGTg
	 3nLBALZiJ7rtg==
From: Mark Brown <broonie@kernel.org>
To: david.rhodes@cirrus.com, rf@opensource.cirrus.com, lgirdwood@gmail.com, 
 perex@perex.cz, tiwai@suse.com, pierre-louis.bossart@linux.intel.com, 
 sbinding@opensource.cirrus.com, Chen Ni <nichen@iscas.ac.cn>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240716025307.400156-1-nichen@iscas.ac.cn>
References: <20240716025307.400156-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: cs42l42: Convert comma to semicolon
Message-Id: <172227343251.109775.8280078818149425619.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 18:17:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 16 Jul 2024 10:53:07 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Convert comma to semicolon
      commit: 275d57ae441f34749cbf8621441ce2148f83d5e6

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


