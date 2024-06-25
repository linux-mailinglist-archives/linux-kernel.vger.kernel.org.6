Return-Path: <linux-kernel+bounces-229469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C958916FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD7A1C21C49
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA86179956;
	Tue, 25 Jun 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEgZFudx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AD1448D9;
	Tue, 25 Jun 2024 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339142; cv=none; b=Dtk+0c0nlB7QDTsYO56MrxowYpLxW/iiva8DNlqU0gRJLJGnLQOsu7b6Qhv1Tk9z+/51r4TMz/tBSTspQS5DdPoNJf6I4NWnFX9peAaj+hHp/bR7dZ/LpVqFHCR4n1FME6/c8z2EibXSqTR6qiqY3zKn1CLO7SIEcbeAMg7ijvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339142; c=relaxed/simple;
	bh=xyvICa2oeI1Am2uQgSUf7rCUh93mw89ll8DkY9ZU0hg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HhpIH/mAzUGz25okE3B3mAwtYcd47AjmHgbNmVh/foxG8cXfRanTXxjWDXjQpclbudx2YS9VaXwQQY6lxnbY8X4KfsxxLZJmaIFbFLVSPB8oBvpVRiHDP9SIIe8GRFUBuu0VuQfRwyoEwDut7CCntn/8HXFD93uXvXnN1lPnTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEgZFudx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CD2C32782;
	Tue, 25 Jun 2024 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719339141;
	bh=xyvICa2oeI1Am2uQgSUf7rCUh93mw89ll8DkY9ZU0hg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OEgZFudx5UJb/BTxHgKcJIWVpsitDDFGH+XeD7njhUXjqbCX0AWZFrG3d8yre+BNR
	 rn2N4gSpGpMITjMQRUrLfsddiwGTqaksc1fgBsy0eraHQxKhBER6xV7WpKxz4OmlFC
	 gtgQkwyxNQdsewjQU82orhmuqxLxCbT1qlNZNp98ChWTccWXHdf7gSe4ePRWwX/1c0
	 Dawgo1fJCZatDfqJLwkdmSyc9NbuQBaW4HqVAj7T0kvlW6RTMggUd47BAwwIA6lvtk
	 WErmfYmuDJBuZODBojpGTTbHoeorkK2DSGc5VbQMPvRYsGlQ3cE2P9dQGhhPhOhX6G
	 L19cnY6MsTmXA==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org, 
 Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20240625033419.149775-1-lukas.bulwahn@redhat.com>
References: <20240625033419.149775-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entries after adding vendor
 prefix in sound dtbs
Message-Id: <171933913995.1078071.14226785405365723718.b4-ty@kernel.org>
Date: Tue, 25 Jun 2024 19:12:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Tue, 25 Jun 2024 05:34:19 +0200, Lukas Bulwahn wrote:
> Commit ae8fc2948b48 ("ASoC: dt-bindings: add missing vender prefix on
> filename") renames a few files in Documentation/devicetree/bindings/sound/,
> but misses to adjust the file entries pointing to those files in
> MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
> broken references.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: adjust file entries after adding vendor prefix in sound dtbs
      commit: 15c99e7fa9e2bb536e813478250d2a609863dcfb

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


