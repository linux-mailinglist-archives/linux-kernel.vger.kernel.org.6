Return-Path: <linux-kernel+bounces-215905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C929098A9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 16:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD921C20F3E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8949631;
	Sat, 15 Jun 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzV+klCJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3DA45030;
	Sat, 15 Jun 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718461723; cv=none; b=M+QEfnhNSbsa37TVS6KPd1RzmFY6bYnpcObBQjUMQL0GZvw3nmxog1RfsgLUZGspBNHznY1dmFbdPxAqftzc8AhEB7AS7RS4fbcvcR2xQAIT42X/JU5xYQkv/R1vRGJu97buCY+KkkM1RA6fe7j/V5kmC+kGfXcvLURseYDGU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718461723; c=relaxed/simple;
	bh=ImhCtEWLBwtWTSaKi+IX+aQ1Arndqt0zvB4GTE47T4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=efXfwWLlKG0bE6vvVZVpGdtggEIXfFiK/BzkCsH9NZGbtVrg1CMiyDnuWfllofhjBhmkjzbq+AKRBdUg1v1E9Podggdphe73h+wIAHFfsLfGBp444HVI78U1gBXd26B+mPcDVddq0FYQixLlB5neyugSJaHKYJ0lbqShWjU9l8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzV+klCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A0AC116B1;
	Sat, 15 Jun 2024 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718461723;
	bh=ImhCtEWLBwtWTSaKi+IX+aQ1Arndqt0zvB4GTE47T4E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UzV+klCJR4jqHdsWf1Igp/S3xaOHkRTpev1IuRZboj6CtZEKf8CUbnm0mEfIttwCt
	 zkTUoTAiwUawvq+5s7Pw0e3e7+F3o55B7B5+s8YALQl0tf626n7tUyvXa73y3/rEGd
	 TT+b/oat6RgGnpkvLqL7Jyr5lXlRpUCjXKsXDBLaMI7Si4i+WmG3kZhr1ElMZGEqx3
	 XWLkhCMC/VISRAjjhGSl5G/3aN4HZdIm5dYjoPiFwVaCg8+R+AJEsm/ac4o9R4eF7/
	 UJ/lDeBz7XZtAW99xdS8H5P4Cm8cKPZe36Ep4gu/KnFv/YoQypY0TP/LAsXZ1Lsb1U
	 5VU00+0QfuWgg==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240613-md-arm64-drivers-base-regmap-v1-1-222be554d520@quicinc.com>
References: <20240613-md-arm64-drivers-base-regmap-v1-1-222be554d520@quicinc.com>
Subject: Re: [PATCH] regmap-i2c: add missing MODULE_DESCRIPTION() macro
Message-Id: <171846172275.314843.10603557257116385150.b4-ty@kernel.org>
Date: Sat, 15 Jun 2024 15:28:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-0bd45

On Thu, 13 Jun 2024 12:59:59 -0700, Jeff Johnson wrote:
> With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-i2c.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap-i2c: add missing MODULE_DESCRIPTION() macro
      commit: 48c1a30bf160117080b48589641f91eae9492207

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


