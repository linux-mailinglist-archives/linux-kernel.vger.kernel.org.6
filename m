Return-Path: <linux-kernel+bounces-276735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96F89497B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3511C220F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54980136330;
	Tue,  6 Aug 2024 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR3SyHsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194B76035;
	Tue,  6 Aug 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969878; cv=none; b=X0evJtkzTaElSjqsiR/9VyX3WqOI8syi51SzoGh6J1vxSLdiKGKL77fxrg3Kdva2gmSNUPJq8FU3v+7gsLZW19ew6jk0sluwxdIOFxyWpG5umuDwxTAGCg1Ge6FBJsXW818D39ST/8deWu7qs5ywdmYsT9DEZgSWMfavXlRboH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969878; c=relaxed/simple;
	bh=J9Gw7X/LLxKmQtGKAo0wwHQ+EilerhzQIkIQaw9Uj3U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jIwntmlJerNhO63uVBeU4OUo+onmLE827gOksUaSpPYmHYI/2op+Y+AV/w3CJSD1j66i63DJDE/RtToki2YTWpgcHhra7HZhJu2kTAbO3ULAFjHB806GW/7eRLe5X40HgPS5fIQnfF4VVNBkEJqfuO0iLusSyu4kiOZ65RgL+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR3SyHsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF28C32786;
	Tue,  6 Aug 2024 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722969878;
	bh=J9Gw7X/LLxKmQtGKAo0wwHQ+EilerhzQIkIQaw9Uj3U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JR3SyHsSlHwPE5NaXK75ofhOBgNo3DjJ2zoJxZlA+38TA0aBAFVRbZU9s8XhnhQWB
	 5MwGaY3+q9iXReJ49nnJF8N4XT0HQ4fkj3ezQCuRGQWYf1nZGmWv8BIRrfmqOaX4iZ
	 jKFwTFVCxa/XhyHreekGHBgeri7cLRC8JWWcBIVmwfN+0wIGsTb4VQJgbq5IR5aI+e
	 582kl7mtl5Hozk5Rltdxw6eJ1POdlCRZ+19NqgkPi6/oz1fBYwBib/fbOlvzBFk3LR
	 QcWe3Da2bSKZ5m4+VCK3of9Y7IXf6oSPp21o3ojBcJgqziqyBCd6cg8eO2Tf0XPzl2
	 aoJmy4wNJQPYg==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <a4e37991ea7b47145ab033128c8dd49f73a983e6.1722949232.git.christophe.jaillet@wanadoo.fr>
References: <a4e37991ea7b47145ab033128c8dd49f73a983e6.1722949232.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] regulator: bd9576: Constify struct linear_range
Message-Id: <172296987684.432612.15051225787613847728.b4-ty@kernel.org>
Date: Tue, 06 Aug 2024 19:44:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 06 Aug 2024 15:01:04 +0200, Christophe JAILLET wrote:
> 'struct linear_range' are not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> This is also more consistent with the other struct linear_range declaration
> above.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd9576: Constify struct linear_range
      commit: 08b856b38c257bc23f208ef165816d7e710574e0

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


