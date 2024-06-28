Return-Path: <linux-kernel+bounces-234266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFB191C478
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A711F227FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F921CD5C3;
	Fri, 28 Jun 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7asmIaE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A31CD5A5;
	Fri, 28 Jun 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719594418; cv=none; b=Rb6cyFVawuzbs5lRma+rSWrt06Ji5X0iu6O1nX8sNmQvmcxHj2m54LDfJsH+ciXEverT6U7b/YZdnEy+8lKIiwgJfpYYiqXH06ytGGe4fEmt/P6fXjJvMOYbdoBDu7BZJx0BE938BUCLdshQlkA5CsxhIOr+mPulamMhREvXi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719594418; c=relaxed/simple;
	bh=FLvzsmSVYtxKYCvxSYbbMmjSnvCBJqxijePBR9qQvxY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ijhSPJS+nb0rCoNmrQ53YikUBVWtTcQagU2wiJieHDPDQqZBTR7pAsWy0bepEa1B+DCLvtwq29u13emwdLqZIcmZdzZ+lC7JoYiDTnfkac0oGNYWxAAZZqneFbP9N8eVeTzp03e9vUNz0tvoIJEYlHUupobLt+YNiqDdPcHQTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7asmIaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5B2C4AF0A;
	Fri, 28 Jun 2024 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594418;
	bh=FLvzsmSVYtxKYCvxSYbbMmjSnvCBJqxijePBR9qQvxY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o7asmIaEUPOesOCMludz+mLoMclDx4MuJ/OLu2NQ5KSBjmkcUj8ZRJTYMmCFxP5gT
	 JUGvRWMuwxKZav9ASu2dSb1jQzjpgNGU+GJtZpwe/5yjVMCCUb+HfZ2bWnHoq1p4gi
	 y5NDt/uyBzF91z0vqVlN0z4RJCB+w9sXcWtdwNG9BZiW9LFz9tPRupOFG7HYCvL4G5
	 SbNhdrocPf06HkdOdYGBX9OoYasK78/HJsSK2AkA9hNalRonLjv/vep7Tik8qRPgBV
	 INqQSOfjtkuR74+YtVkgjC00RNHgVmQRy0u6w5MXHpqiCNcpaurUPZomylBQQ5iTmi
	 BIqRueIBRfFkg==
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, Yang Li <yang.lee@linux.alibaba.com>
Cc: tiwai@suse.com, lgirdwood@gmail.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
In-Reply-To: <20240628052406.36644-1-yang.lee@linux.alibaba.com>
References: <20240628052406.36644-1-yang.lee@linux.alibaba.com>
Subject: Re: [PATCH -next] ASoC: Remove unneeded semicolon
Message-Id: <171959441642.130075.5565173810248944116.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 18:06:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Fri, 28 Jun 2024 13:24:06 +0800, Yang Li wrote:
> ./sound/soc/codecs/ak4619.c:757:2-3: Unneeded semicolon
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Remove unneeded semicolon
      commit: 061505a1a61169bd25dd908f95ba22f33dffdd69

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


