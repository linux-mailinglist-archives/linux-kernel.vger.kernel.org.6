Return-Path: <linux-kernel+bounces-346447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB55E98C4D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A41F24023
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FA61CCB31;
	Tue,  1 Oct 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9w/F4MB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7C1BF7E7;
	Tue,  1 Oct 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805191; cv=none; b=Tn80gflvJia0yFqgK353V4k7F7n8Z6AWtrH8QwKkwVsqVDO/mK0T7ND82bd4tZ91lUZsLXZeYQXq4olKkIkxPFdzb0O24T/CjZ+rh2MYQF56y4VRqEfYuDXH+it9ocxdqOUJT8M8rRoQgF1wwX0YHXNDXzeGsgJ/cV8OQD+/s1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805191; c=relaxed/simple;
	bh=0SWHZTJdAhiLPUvzHOvSqw2UJF1x1fKsi6AB2LSEXbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=asLPZR5IpO/v6LGq+V3Z98Ru2JTM/VxmxRnCy7d17MG5JvcheSyMXWp4yLFsFBo149OYg9AvGJs3gOq6vjcy6BbvZvCFDdbVt/uZqqmJhZvHdrePZ8Nuslqw/BoAmvhuecMmwrLJ9tEha5uXxjUZ8VWppRMa07XGBmvZ1wnU9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9w/F4MB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25257C4CEC7;
	Tue,  1 Oct 2024 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727805191;
	bh=0SWHZTJdAhiLPUvzHOvSqw2UJF1x1fKsi6AB2LSEXbQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n9w/F4MBxMT3GaR/HfURAWq46JlgX1v1M7uYU5mbZ3D7FIHCghINi5crPPvV6F0es
	 KWDaMwFW6fIC1p70XsuT2NNyZRCqeFSWlh0hcRhj4N1T4H9aof5ocoY0vqt6fnnhFo
	 MonrINkC5KlSLWPF1H/a2ZhuqXPVElIlxbr9NwQKgU3YyYP+eLE6X5J5s0cMcrm06r
	 euyyN5DyLE6YTZUVWNXCv34z4pkKr4QcUXvJsFfa2NAjvdTtFMX0p/vonLNRwyV03e
	 N5obilYyO6417ME7c5sZ7jEcQoM981yznLn3hcs9/v6+ptGXc1HEcBTmd1IsI80uex
	 E7H/L5KmBfJpA==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 Andrei Simion <andrei.simion@microchip.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240916091056.11910-1-andrei.simion@microchip.com>
References: <20240916091056.11910-1-andrei.simion@microchip.com>
Subject: Re: [PATCH 0/2] Updates for mchp-spdif(tx/rx)
Message-Id: <172780518782.2298697.5345133650915671833.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 18:53:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 16 Sep 2024 12:10:55 +0300, Andrei Simion wrote:
> This patch set includes two updates for the MCHP SPDIF RX and TX drivers.
> The patches remove the interface name from the stream_name, allowing the
> interface name and index to be set in the Device Tree (DT) using the
> sound-name-prefix string property.
> 
> Codrin Ciubotariu (2):
>   ASoC: atmel: mchp-spdiftx: Remove interface name from stream_name
>   ASoC: atmel: mchp-spdifrx: Remove interface name from stream_name
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: atmel: mchp-spdiftx: Remove interface name from stream_name
      commit: a6ae5845f0231fb1b3e9bf591b237d99d1a077c0
[2/2] ASoC: atmel: mchp-spdifrx: Remove interface name from stream_name
      commit: 3c44a715e389929b8243d6a0545992d78cff6cba

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


