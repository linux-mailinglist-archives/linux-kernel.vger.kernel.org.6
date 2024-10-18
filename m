Return-Path: <linux-kernel+bounces-372165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D10A9A4530
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BF42834E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035292040B1;
	Fri, 18 Oct 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGB6Q8eD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B924204096;
	Fri, 18 Oct 2024 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273432; cv=none; b=nnJmHGOWngiueFlSededM3rG+RcQm0UbZmYp3msCQ2JzxDjNgAQe0NYN2Ei6uuWtdcvdYpjepOOjMPr9U0KwBWdrhjHlOivQJRTAufiQOiZj2WXM0GzUTiszIOuJSJDufpXrMNx97HStpxTsSFz48KneuO7D8GjeoERT0apTJhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273432; c=relaxed/simple;
	bh=xdUkpNbsXIftYmDuBxwVxqaJGiPled/NQghV+P1CJqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K8ODnP7d/tELrVmwa++wRGW6pTCWNrWtIrBoFdIxu/KgNAtVrRe8FJWkn5zbcAd8Lk3ZZM8NSvKCNv3iZTqlFaFGWXmNkJATeGhnMpReNsOiU0dwxx47PQyG3lmOHwP7GQm6piHb5zgZFJCEyBKt3okoRW24inPOQS4M1vzei3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGB6Q8eD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0640BC4CEC3;
	Fri, 18 Oct 2024 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729273431;
	bh=xdUkpNbsXIftYmDuBxwVxqaJGiPled/NQghV+P1CJqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JGB6Q8eDHiwgM1cl9rbenBvhJvN4oq52SiR7zMHcV9PoyAF7o5hYREOeSckXfyS6r
	 YUAnypxdYUQrPo/d5fvGVg3o/ASeyUfWzNRyC6r4njkTT2lFCZRvjwZ8opV1NEyJwl
	 3jNxHxCjtyb3pfAi+3UQdogsjmyKdbu02s2BoSiBC7Tr14NPAa1XIjkyp7HGsqvp5+
	 yjLy3TxWiEFyqYBFkOOz4gkdAfiYbBl/uGnQCjOXK9Q6G16CHQ6UjBooiTVRXefjmv
	 Wg3+vMq5Ig8qUHT18DusxBIHdT4rggqdRSdBYyM1c0HMCkhcI8gmbHAZW4JwGQiJbR
	 Vml9Mk/UbVz0g==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Kirill Marinushkin <kmarinushkin@birdec.com>
In-Reply-To: <20241016215810.1544222-1-k.marinushkin@gmail.com>
References: <20241016215810.1544222-1-k.marinushkin@gmail.com>
Subject: Re: [PATCH] ASoC: Change my e-mail to gmail
Message-Id: <172927342875.163659.18067087420482049462.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 18:43:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 16 Oct 2024 23:58:10 +0200, Kirill Marinushkin wrote:
> Change my contact e-mail in pcm3060 driver and MAINTAINERS
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Change my e-mail to gmail
      commit: 740883fa6c7262036769aa54b50609c8043977e0

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


