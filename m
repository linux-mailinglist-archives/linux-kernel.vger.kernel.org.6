Return-Path: <linux-kernel+bounces-269521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFCC9433C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868481C2342B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4751BBBE4;
	Wed, 31 Jul 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO+Yrb6I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E521168B8;
	Wed, 31 Jul 2024 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441526; cv=none; b=p2r+tFjFw+mHggYq2Y6JCmeiB+f2mlbBvkWYXAkGyvoSWEKdtbCTdHo8CZpgJnnjw3+jzmFMaYQ1Q7UJlDueXXJSWqUfD2+FdnKAP/M00OeTyh2m9ozDiasRHE8v700vBrUevUiTjqHXr2/n6CHD93WS5qL3aXzbnFwlrS+PPGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441526; c=relaxed/simple;
	bh=qDoXou29+NUWsMU0NBDLCdWagg3XYB8XWnBd+w7WNwk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GMD3RtG/v546VRdZw4WJ1Hf+dWLn03MSwtn879lwwFmKco1Y+qWSBz2D7wpVOnBUbWkH5ZzxJJ9k7GOLK2dHc6BXFFSHsUwbItPj+OC69sk9t2OsYEByZ5sy3O9oTkr62Gnlnp6MS7qtW+3DoGo+5TPJfQvXrz+RwX7gw+RF4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO+Yrb6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E0FC116B1;
	Wed, 31 Jul 2024 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722441526;
	bh=qDoXou29+NUWsMU0NBDLCdWagg3XYB8XWnBd+w7WNwk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RO+Yrb6IwlfZeVRXNNnwAfXtGMTVUUS4iEwahaTpN6rde/Me/QogLL7lyNIceTuq0
	 0lnFBE1IysYKc20Y6G/NltEV1SgUK/c0rOP1rP3D0hL1yF4ag3sMyuPF96sIFNUi60
	 LNL1GiiXiZ1L4/1J00RW76gmcjzuFUAXLZC0j1PUdyLkDrm/5NW2vKX7zlaKZ3jYEw
	 VebJ6aG5WG/KGPzUr8ehH8EIvIAYnFiRoJ6fCMaX5EIoUjCDDJzyjS9PggJ3tAoXVy
	 VsD/7QzzTtSl4WChvymh+n/hqvoWpaU7WiY9mtvgrbj+AcCELs6HfPkVifD5wuNIBe
	 Ew3XXpWfKc/gg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240731114828.61238-1-francesco@dolcini.it>
References: <20240731114828.61238-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] ASoC: nau8822: Lower debug print priority
Message-Id: <172244152437.93887.4552177353304992709.b4-ty@kernel.org>
Date: Wed, 31 Jul 2024 16:58:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 31 Jul 2024 13:48:28 +0200, Francesco Dolcini wrote:
> NAU8822 codec PLL parameters are not an information that the general
> user should care about, this print is supposed to be used for debugging,
> adjust the debug print priority accordingly.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8822: Lower debug print priority
      commit: 9da8aa3b3ca05b22be5ba312771e6df4366e56cc

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


