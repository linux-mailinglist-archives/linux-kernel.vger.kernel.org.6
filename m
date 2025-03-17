Return-Path: <linux-kernel+bounces-564192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEF4A64FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C455D18899FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5775C23C8A7;
	Mon, 17 Mar 2025 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJnGlp3Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA48723BCF9;
	Mon, 17 Mar 2025 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216323; cv=none; b=QoGiuddFiWAjmIAxGkSZwahi4FjLEOqtXDKNfoPZs4ZDVegG8KdMn4lEmye7dDQrDnEms2meiAVcTF6ZAoxBlZHvnGad5vdABQZHWNUmWbmbb4u332lJk+F0UWPFw5R2qq/eOZGlTq/LEFklEUaQpA79M0AkIqvSP8HJtE6N2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216323; c=relaxed/simple;
	bh=apIi+GmSdHpHPkEvnekuCpfR4oYNKEF4st/R+ECvEi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kLkZTaFs0/py+UQMHnGlhrfe9LOWjUsKG3cEl7bf+lkL64NELtFvOzYqM0glwsVsGwVZahLJCE6W0diIx+EUgwlerORHiq/c+ZB13oIXe1YDBUo3AgpIrmYo+lSrpmXPcu44PZK1onHleX6bUlI3GC0DKyWGz2hHTqn7PX7R5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJnGlp3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3942BC4CEE9;
	Mon, 17 Mar 2025 12:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742216323;
	bh=apIi+GmSdHpHPkEvnekuCpfR4oYNKEF4st/R+ECvEi8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MJnGlp3QEm+aQ/YnDc6GeAkwPX+G7IuOeW4PzNKIk7OuZdmzwxws3+HY+xSN2aua0
	 SBxE9zgLLjDcEI5VYUiGLUjY3Fx60UvV3+DYr7AvtDjDlyz4yfz8wOy10S8dKGT+Ee
	 8T552ufjGSHTuP0uQZhIrTCf4vCoXQOw62Hd//E9/R7icpcT7919BXvk0UzQW1mgnX
	 wPG8TT5ZS/W1O+fs51FOBg8barS6J3tkvHWd9HMumFu1s39elb1t4KYQ0wmYfl+IHg
	 aoJoKPZnp8rxM44w0WRXlhPj5z3TisRMoWAAd226Y+kCHe4+UjUHPo7MgzegRB0sML
	 SEAGQwpdSCg2w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20250306171013.243332-1-Frank.Li@nxp.com>
References: <20250306171013.243332-1-Frank.Li@nxp.com>
Subject: Re: [PATCH] ASoC: dt-bindings: fsl,sai: Add i.MX94 support
Message-Id: <174221632097.149281.199367388355109922.b4-ty@kernel.org>
Date: Mon, 17 Mar 2025 12:58:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 06 Mar 2025 12:10:13 -0500, Frank Li wrote:
> Add compatible string "fsl,imx94-sai" for the i.MX94 chip, which is
> backward compatible with i.MX95. Set it to fall back to "fsl,imx95-sai".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl,sai: Add i.MX94 support
      commit: 3c423a68643cceb69c4e4244b5b4d09df2a19c79

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


