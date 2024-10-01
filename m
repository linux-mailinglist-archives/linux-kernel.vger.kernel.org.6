Return-Path: <linux-kernel+bounces-346452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5589F98C4E3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF9B284201
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B091CDFAF;
	Tue,  1 Oct 2024 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijeBwhoN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE771CB534;
	Tue,  1 Oct 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805204; cv=none; b=qNSZkqWmVs5ZeOj9I7dVCirppKXnbZsq+UPVKzNo9FBniay2FD/LSIj8qT9UrcyhchMiPjZ+6vRc8ywUjo0RgB11Na1giDEwQsTu0VBiG3g854JHjaqvfxs5Vh2/rn8cOtXG+xPYzeuIJ6+bRmq2l8qjzHKfbteesksKKvpQpf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805204; c=relaxed/simple;
	bh=EpCIJHF8WYIhXubstEdsps8ND5AisiZx4uTrVG3sHfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kv49jBtnQqPPZCatv/JdAtBeC7jWxw92pp73JujkgDMzGlUslk0v5nT/BI/3GtS9k+5XGkZS9wSV+MuVtFTWToqS61v74CfrLxXrt6HoaEay0/2MMvEWwRNyK5SYYhFj8BNi3OOExTe8AricRjUq3qMUb2h6DT85+0BCUt4Nwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijeBwhoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8EFC4CED3;
	Tue,  1 Oct 2024 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727805204;
	bh=EpCIJHF8WYIhXubstEdsps8ND5AisiZx4uTrVG3sHfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ijeBwhoN9h5cFUiI0KEGcgxWWPSypnENSqWxZoqKG9xZX6LHogseIppLyiA0TegGD
	 tn7o1kliCZzAslvmvplyX09NEGJzUeXlL816upiUOT0+etbLe3/WQIWFjcmGG+j81t
	 Ek1IwCBnLB47BefZmzy2Pde5uSoTfXzxk4Pq6666DvU8VdDkXB9aU+XpCswHpQjgmo
	 TBz6o+BTIUwuej9wCAbBKDaJgMjtzP+o+idVFgx/aF0wdISFIiq8EwWSF1ATH6tpx7
	 81QDMVHFADb6TxP3kLT4Hs3Q7QTvI5FvkaVRac6eVFdOHpAAu/dFqZohjsExyyg3FU
	 Zrc4GiB2sWlXQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Igor Prusov <ivprusov@salutedevices.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, kernel@salutedevices.com, prusovigor@gmail.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
References: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
Subject: Re: [PATCH v3 0/6] ASoC: Add NTP8918 and NTP8835 codecs support
Message-Id: <172780520098.2298697.10488363021323219650.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 18:53:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 25 Sep 2024 17:52:38 +0300, Igor Prusov wrote:
> This series adds support for two NeoFidelity amplifiers. For both
> amplifiers vendor provides software for equalizer and filters
> configuration, which generates firmware files with registers values.
> Since in both cases those files have same encoding, a common helper
> module is added to get firmware via request_firmware() API and set
> registers values.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] dt-bindings: vendor-prefixes: Add NeoFidelity, Inc
      commit: 5d9e6d6fc1b98c8c22d110ee931b3b233d43cd13
[2/6] ASoC: codecs: Add NeoFidelity Firmware helpers
      commit: ba1850dc0f2b5638a4a6aa16905c1856dc17587b
[3/6] ASoC: dt-bindings: Add NeoFidelity NTP8918
      commit: 64fbb6bdd45b8953fcad5c4ec648f74c96aec5f3
[4/6] ASoC: codecs: Add NeoFidelity NTP8918 codec
      commit: 2bd61fff3e93b93a20f618028433bcbe8329a6db
[5/6] ASoC: dt-bindings: Add NeoFidelity NTP8835
      commit: 3e2aba5f0b0cafad44c2f635dc19d7bf3f54b978
[6/6] ASoC: codecs: Add NeoFidelity NTP8835 codec
      commit: dc9004ea273a9141c16b90a687da70b77f5a640a

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


