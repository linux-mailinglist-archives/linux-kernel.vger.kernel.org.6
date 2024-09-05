Return-Path: <linux-kernel+bounces-317906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4F496E54B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2284A1C211DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFE21AB6CE;
	Thu,  5 Sep 2024 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5ycgSkX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5F19409A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 21:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573080; cv=none; b=RSAUELv3RpxWQKPEoIEVQwoz8/kKRroCzdz3iKKDDwznupAgcZHXIs14839PGcDxHwSzfbSL1Lclm/WKa4U3/YjqRTW0Csze5FslBzmyf+8qW71kuhaqnBtwUiq78bYZGg0T35+UGV6CtQqTHP6IA6x26TKm9okdyueIIU8vDkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573080; c=relaxed/simple;
	bh=Xjl+UI0HvZtep+WFpHKINNNzU33P0JHEaIx47J3frw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E6qTzzgZbRmKCv8Nau/CbawXr8+RlCAv7aUT0RioFGjvH4qQR49TB4VTnxmPS+J6ukU9hH/+OzCP73m2YCbmH8MJDGic7d00865TRB5SoBMx2QAAinowL+qXzsTng3CZIQ4n+ZlzHYCo4QH7a6TNjSvi2A6LEooMS4haUvx9C48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5ycgSkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D92C4CEC3;
	Thu,  5 Sep 2024 21:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725573079;
	bh=Xjl+UI0HvZtep+WFpHKINNNzU33P0JHEaIx47J3frw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=f5ycgSkXv5xCBPCopJn0QDZga2g5RP7PxDRWE291nfmAdbPgL2to1jHl8DPQIDTZ7
	 3iFagW62LR/SR62WelQ7vVUTgqQrnBlO5JGdSH+i3W1wo5oJ29CIJi1xxACJVA6Bok
	 Xqxr9RyX2wCSLghCtPamjxUeeKt18XnYvUSpBzdzONAqSUdpYue0PRNc7vRZ6oFqls
	 Mbd+sgRJZwOuDjcBAVQMJLcHwY0jRFb3qNQpDLrReXgs4zWKO2CSv3NzdgR/QKap8A
	 5sP4VUPdNRJUTZAoOQCCWbf1iEHctD/WMoCH5HeIy3mx5aeSI1QRxo+HQa1YHhmZ5D
	 jTYeJRaX2pSUA==
From: Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20240904190856.1221459-1-andy.shevchenko@gmail.com>
References: <20240904190856.1221459-1-andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/1] regulator: of: Refactor of_get_*regulator() to
 decrease indentation
Message-Id: <172557307796.131732.5317450199702474356.b4-ty@kernel.org>
Date: Thu, 05 Sep 2024 22:51:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 04 Sep 2024 22:08:56 +0300, Andy Shevchenko wrote:
> Refactor of_get_*regulator() to decrease indentation and increase readability.
> No functional changes intended.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: of: Refactor of_get_*regulator() to decrease indentation
      commit: 401d078eaf2edd605c9121741e166d9326c63677

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


