Return-Path: <linux-kernel+bounces-266201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EB993FC47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B77BD281E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BFF18A943;
	Mon, 29 Jul 2024 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+VWSTCR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DAF189F5C;
	Mon, 29 Jul 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273468; cv=none; b=GYQHuyzm90qc40sQmF+jXlMkYRyxX9yoxebbovRCvuBrOiAja8loZp/6Y8dRZ2x+6giuQFoqM4zgRJKrOMOQje6qZAQ4qtHwjuHtvZ0H4Kl211PEKXHvu/xyo5s0TiXANFesFmQHeo1Aiadhigct7V+rKwJm+sLSxXnYZaVJHps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273468; c=relaxed/simple;
	bh=1AXx8rFJNUqsR/rjr9CYdYIKj9bw+WWAX5/bRoey6RQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=idwLnzLaSSuMAcHGnCGvfnDTfvSCmS9zEBz9GV5cV/GjeyC+H9xDccKjqPSzrTqXxlvZ5SUtU8nTNj3bZeleKtLME1c7QtvL6oix99xWtNfbJAH4VO/yMru5yCmU6lz56Ku+YpcUO9e3W6b0sz0p1aHWu8JRv2MP7ON7j5rsLN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+VWSTCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8862C32786;
	Mon, 29 Jul 2024 17:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722273467;
	bh=1AXx8rFJNUqsR/rjr9CYdYIKj9bw+WWAX5/bRoey6RQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=e+VWSTCRS67QyjbZBYjVn6C40m0wjdti4hEASGwPlWj8h6esj3dGVDP3NVflNHa0e
	 2o7vHEPspJR9BvmM0wCH7n3OfswLwO+NpuQEjIdkDHOUOKe1F4/yl4BPmABC02MlI4
	 FJg6MIM6CJjVIrRf3EgRKDwcOyzCZKOcexLADO+a5EcD0aYq6rJcgRoq1JfvhcmWAk
	 vaJDsEr9uuL8g/ZQD3qOU4W0hxnTDv3teoR6sXVN3AVTlM/wYqVdGOatqBaOI+Fo0k
	 Ah0VWAUO9wU8OyiAIJlnSF1GFS6hdieowZsOb8qHLZ2QojqbcE2oqhlQy20e9m0BtN
	 UR4EDg+Qey/Dw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 mario.limonciello@amd.com, end.to.start@mail.ru, me@jwang.link, 
 git@augustwikerfors.se, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bruno Ancona <brunoanconasala@gmail.com>
In-Reply-To: <20240729045032.223230-1-brunoanconasala@gmail.com>
References: <20240729045032.223230-1-brunoanconasala@gmail.com>
Subject: Re: [PATCH] ASoC: amd: yc: Support mic on HP 14-em0002la
Message-Id: <172227346561.109775.3534143218713152764.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 18:17:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Sun, 28 Jul 2024 22:50:32 -0600, Bruno Ancona wrote:
> Add support for the internal microphone for HP 14-em0002la laptop using
> a quirk entry.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Support mic on HP 14-em0002la
      commit: c118478665f467e57d06b2354de65974b246b82b

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


