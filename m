Return-Path: <linux-kernel+bounces-392268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3927B9B91B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1241C2328B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E2F1A0704;
	Fri,  1 Nov 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c23MXuWd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940719AD5C;
	Fri,  1 Nov 2024 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466942; cv=none; b=vBjrqK1xwYjswnwBajZ0SVTg/yaw8b4tqrwCkWOqGoR5ooW2G5TogCXA/wHjted5ZM0EVk6v8xBTS8KWWNmcj7Q47idCEmA6P+SnYpJb1QkRo/gijtkwg79ffiabnnGytArphLecZBlhRuICDFogdk2bRItOaU4XrY1DjbuwAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466942; c=relaxed/simple;
	bh=hl6MlpzKati/Jn4Aw8tL7tSGlAUzEKqO/lzOh03DLMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kbl0tM8pzObVuR96EOWD2T/bf9EMbhSVVg/CCuODCs1n/COWZBgLLT7CQNw+LWm/5ds7o6v4tgyrxjniI6CUcAtRFe1mCilj+of+FgG2rPTHAB8nyEgJXEsvJa2i07qcdxKuclfsmJmY7/kcYimm3HcSJMSFJ17meB+6+zmHjfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c23MXuWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AE5C4CECE;
	Fri,  1 Nov 2024 13:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730466941;
	bh=hl6MlpzKati/Jn4Aw8tL7tSGlAUzEKqO/lzOh03DLMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c23MXuWd5Rehqd9H1D+3mZ3LcLufGl3JlsqN1UOtSgKAflRB78wLfmPLwEs4Kr2R7
	 aeHdYhQ8xfSD5LiGXa2JxOXdnODNuzmSDMFrGbpbnrnWC7TY1RFe2gCuKMtFJ07jJs
	 GxBV8Uz4C1M44tkTJpWZILV5XV3EMhU8ZQejkXIaqev4Ml+Z5IGXV6PnRrHq5XRMw5
	 wwFqha0CC2yEj1Yup7qoyR0s2a+gu+fMyhF8Uk34mDCL+WWd8B2UjNdAOOM4WpJDow
	 Mot65ZmBXt4DJ2rDqyJ+RqMfu34KeuJwnm+KrYFTPm3GoVXsGwBCNcMldJ33NBmU1G
	 392w4sW2RhyrQ==
From: Mark Brown <broonie@kernel.org>
To: Prasad Kumpatla <quic_pkumpatl@quicinc.com>, 
 Mohammad Rafi Shaik <quic_mohs@quicinc.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20241031103302.2450830-1-andriy.shevchenko@linux.intel.com>
References: <20241031103302.2450830-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: codecs: wcd937x: Remove unused of_gpio.h
Message-Id: <173046694000.38444.9992428018228971667.b4-ty@kernel.org>
Date: Fri, 01 Nov 2024 13:15:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 31 Oct 2024 12:33:02 +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove. The drivers in question
> don't use it, simply remove the unused header.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wcd937x: Remove unused of_gpio.h
      commit: bd0aff85d5f3f3fc22735ab5869008dfd8ab4867

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


