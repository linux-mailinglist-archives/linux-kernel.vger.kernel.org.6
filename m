Return-Path: <linux-kernel+bounces-376809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D36CA9AB614
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DD51F22EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E721C9DC5;
	Tue, 22 Oct 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPmdHK8o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D8319E838
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622724; cv=none; b=X7FJimCBrEVIP8PiKdsgBfE7ylNoaM1z6b+A78NdQOZ/v2rwVubRElx7yuEiRk/dHia7ChLUPwkpt9u9sag6sdTf+npTmzQXQNFONwcILWofjVxTxBmhzC/8U/gFVYECLUku/NSQF4oDRx65wfvdEciM6SJjW0tJie6YonEn1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622724; c=relaxed/simple;
	bh=63jRCFSINOUOWDp6i5kP/8DY5ALnwwB08Ddv3eMY1v0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UCfVX3HsjvvTV0hUk325b1yI4Hl2m3YQPY+0uAjeCjNkRJYwj5kQeI6X+Q3cJvH5Cxtfrr4sp2gNi6S95iEpjUl4fXxJDBEVDFi4wq91MoKh3JNoEsQ4iFPYdkmod6vxybBUqUiF8t+qE8znpPnRJGFLubdcsjWj1pZ+UdUJH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPmdHK8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868DFC4CEE3;
	Tue, 22 Oct 2024 18:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729622723;
	bh=63jRCFSINOUOWDp6i5kP/8DY5ALnwwB08Ddv3eMY1v0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EPmdHK8oLSLZ8dj7SPd0SpI4R3MJkzsm6VEauHC7iP3fsx/4Jyo9OALeJRF8JiDpE
	 BL23JRKF3jjzjBiOQ4qeyFA2l8Y6UnnSHiJlT60BYFKzH5gqJbKouapHvOoG0Mr3Wg
	 1zMNqQnq1VcIGx53upYDWjFO+9XoS0ZEXJ7vYCS7wd62plul55b4ZKs6Zcw4hJ9PkA
	 vyLCJxJUBxBp72lG0rYkTQ5GZw8LKkOSEeu5w0xjIvYooR1WuHvgVGwOBW1/w4uU3+
	 wMzN2GhD5G+z7Pjbn3CppPrdqb0+lG03XcHOAsEgUJ89v9elMV0e4lps+8C2IX9pZp
	 OMT9bwoeRYmIg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1728902488.git.dsimic@manjaro.org>
References: <cover.1728902488.git.dsimic@manjaro.org>
Subject: Re: [PATCH 0/3] Allow use of DVS GPIOs on the RK808 PMIC variant
 only
Message-Id: <172962272118.122698.2211173167773675100.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 19:45:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 14 Oct 2024 12:43:38 +0200, Dragan Simic wrote:
> This is a small series that primarily makes the rk808-regulator driver
> more compliant to the DT bindings, by allowing use of DVS GPIOs on the
> RK808 variant only.  There's no point in allowing that on the other PMIC
> variants, because they don't support the DVS GPIOs, and it goes against
> the DT bindings to allow a possibly misplaced "dvs-gpios" property to
> actually be handled in the rk808-regulator driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: rk808: Perform trivial code cleanups
      commit: 1bc3f0e9868929211c6abeb7e79b566c27fe9bb4
[2/3] regulator: rk808: Use dev_err_probe() in the probe path
      commit: fde993ae0b6e5edab0563897e232b94d1d2165a4
[3/3] regulator: rk808: Restrict DVS GPIOs to the RK808 variant only
      commit: 33a846e88481cc4659c6d670759b6295903e43b9

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


