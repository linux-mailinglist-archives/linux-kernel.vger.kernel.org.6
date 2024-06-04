Return-Path: <linux-kernel+bounces-200543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1518D8FB175
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9F5283486
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C020146005;
	Tue,  4 Jun 2024 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS5bejvK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F422145A11;
	Tue,  4 Jun 2024 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502076; cv=none; b=kuohgcy5mIEV4nBQ9fTooq2eYwBnEHzwWmykTRtMJxtrYK4rIZzFrxNCmA0fpgbGDuth07KCmkTeQFY54CC0OkyGL6SMz0jxX6ggtNssRWi1Wi0l+I3+uoQD0OgCWjj6Ka7xemhSHhDMfZY9JkmfLPb4X2N1GnjzJ+jiORibOhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502076; c=relaxed/simple;
	bh=Fw125Fv8BUu4VjIONs7xSGbA/2D/uZyDTi0Qr8VorkI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=po9GRAwFrThYfbkPrn8XrX5MAipFpH2VaUiY22ECRPuhHoVHEdfWLWF2Tt4tbqGM5dKfA90DG4ctIyqoLYroBA/p5nMKsNuP+I+GDS1ApDXimSLqC43+xQhSEwNnBk/vr7mrCZ5F+wMXv6PKBcBiU8B++ev/LUZptTcv2HxzO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS5bejvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5991C2BBFC;
	Tue,  4 Jun 2024 11:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717502075;
	bh=Fw125Fv8BUu4VjIONs7xSGbA/2D/uZyDTi0Qr8VorkI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fS5bejvKJFdpLJFZC1jx2+BOunA1DFW3OO+khV8QsNRlH6te0E4Pa+VlhlOwrd9UJ
	 DUdXBTdJGyKlHaEZEQUwsH6cdNhIu+4XLAAQm8/U3lxokMkBIZftuXT3Zprjuv1LXs
	 TgNlaCo8zb126iOp6/sFN/gDeX0Hh6TgzildkvMwVmOEpSeCvf1dx+x7brNbyIf+Hd
	 L/S+kOAFsid+qeftrvqfO/rVbiJPPV38yBUfnGKt0T4ZXHc7FIo8QTobf/RteBHPQz
	 icTocNUOoT5IqwUBvm9xCAaLSOdpwvTXRLaLdsvzk1j9ETqQ51YuZDdGrSV38Hqvag
	 GziK294NpzXoA==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240603-md-base-regmap-v1-1-ff7a2e5f990f@quicinc.com>
References: <20240603-md-base-regmap-v1-1-ff7a2e5f990f@quicinc.com>
Subject: Re: [PATCH] regmap: add missing MODULE_DESCRIPTION() macros
Message-Id: <171750207453.25016.16929145350125287224.b4-ty@kernel.org>
Date: Tue, 04 Jun 2024 12:54:34 +0100
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
      commit: 76f19626bd35a1791faeb75264d358256ebc544c

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


