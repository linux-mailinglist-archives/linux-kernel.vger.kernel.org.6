Return-Path: <linux-kernel+bounces-389115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0693E9B68C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3912B21F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B82213ED7;
	Wed, 30 Oct 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INk/yM5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F436126;
	Wed, 30 Oct 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304143; cv=none; b=t0lddDHTOfDIspE5VNB3M4vNeq3VVPXzC+LuQeUu/cwRiW8gjHfYYCvnmvvvIHg3P05HBq4fV0XuBwICc71ICgsCD+E214BKrMMhBGfgQqhX2OgKJlr5hKtNa5+WrvuzGk9EzR87I94ppMdqcaP4bPq0vOPRr2lBgdlduEzY8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304143; c=relaxed/simple;
	bh=YIULgKbhVLl2KEUkjm5ebB+z6v8KNB9tZvb34/55RMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NokSxImVb+sV54q97H8FlQyXitksucIefQLcBu9Lz0XBGj5Wnu9ZAdcL9kUkP2skWkkBTeMW5FWX5HHk6RoUVogdqF/Z1p0S/kMBihJi7ompRavi+NuifxL3OC8ZdoS68yq+KK5JWPS2d6U+bBf1MMo+LbVDyhKLqRvRF7x2RzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INk/yM5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1982FC4CED0;
	Wed, 30 Oct 2024 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730304143;
	bh=YIULgKbhVLl2KEUkjm5ebB+z6v8KNB9tZvb34/55RMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=INk/yM5lxlbPlzB5uUxspssKfu+Dzl+tM/QbkEjKZ6GWe7NxgZrhK7cg61luWkP+t
	 LVmOW0Me6esngVwbOHmGIgsxMj/4kD7ALzCHB+Puew05h1mlT/9F8mKaeKyResrSJH
	 HzBDtu8YDBKiY23rHCU5ZY1fDplTfJ2ME1ZWjZST18nU9buM59n9d8vKICVu0vwIPu
	 iMMqhdecBbhAU5rZndJFnhEscuy0kHFI/JTs6wkBc7lCXaf7d+zfryhnu3OFRJOEBB
	 +FeX5kSqEvJjZynt/MVdz7/mwAx6l4LgXguRuHrd5nwvCYmoY6tchvm+9eVjSPftML
	 +O61Y7Uanib1g==
From: Mark Brown <broonie@kernel.org>
To: david.rhodes@cirrus.com, 
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: rf@opensource.cirrus.com, povik+lin@cutebit.org, lgirdwood@gmail.com, 
 perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, asahi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20241030021047.70543-1-jiapeng.chong@linux.alibaba.com>
References: <20241030021047.70543-1-jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: cs42l84: Remove unused including
 <linux/version.h>
Message-Id: <173030414082.39784.12603422768068027639.b4-ty@kernel.org>
Date: Wed, 30 Oct 2024 16:02:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 30 Oct 2024 10:10:47 +0800, Jiapeng Chong wrote:
> ./sound/soc/codecs/cs42l84.c: 15 linux/version.h not needed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l84: Remove unused including <linux/version.h>
      commit: 334d538e176ce0c70bea5321d067432df2299bca

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


