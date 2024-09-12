Return-Path: <linux-kernel+bounces-326972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE351976F44
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D76B285012
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD31BF7E3;
	Thu, 12 Sep 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyuyVELg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C61BDA91;
	Thu, 12 Sep 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726160717; cv=none; b=INU4wqtMx5+A0UbRJZEFYdlFW+J2QOaNc06NC7FFN6BwqIFu7DxgYezCsbRk6ieKK45+R+CDaqaFtqGyr65ofJXR1blXbTEAwfo7fBKeKAsPi1JpJb463G3y2FDn/6kYaEMeMJZDqWMCka2bHuYtHvb4FFT+pBIVVTLQGaKxzcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726160717; c=relaxed/simple;
	bh=Jn+D3Ldn3xXWF87flG57S+s2cGeeN6zBdVn7hWJkyhI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NduypcM3XenyNEYJSw8Lji4tr0EA/o/mX2bBafBFwV8OvCbFhwq7eECYJSGrtL2pApArZkj4KQ5SrvD04pvGDF+2PQ+EAKRe7SdsWq0SKBb2ZTrFZQi7WC2TqbjFNsVYI1yCSWzBocqP781/CyeBXots/B5z1zdfQsU7qCqiDIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyuyVELg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44938C4CEC4;
	Thu, 12 Sep 2024 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726160717;
	bh=Jn+D3Ldn3xXWF87flG57S+s2cGeeN6zBdVn7hWJkyhI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TyuyVELgN12TDDomQTcsuk0TYow8KnxpOq3PzmdVvokNIyhoCAJQ7xDJmQL5Slu59
	 WMyQyaIgHncTo8y35lymIgT8mJG1TQyiZWQ5fe8MvShwRtOUuixHANcGUNT+01zla2
	 uKYPkqiWHO89YUnv/GBLy11prPheXSfloiAnCh76Q4jN1E6GHHKXO8rQmx8tHWpBeU
	 R/SWDke4OFbHWQwJl6mh9cEXZ+LnqZq/pL+HuqiO1GwzzC9CTVHRzAIDUTho5aujdb
	 7OxQcwea3IYmy1/XP6Htw5snZQWVaVA3B4lh3k3/K1CJJQLxUGb6/EWJGsdpOkjTN2
	 I9V5tNOsGe9IQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Belin <nbelin@baylibre.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20240911123629.125686-1-usama.anjum@collabora.com>
References: <20240911123629.125686-1-usama.anjum@collabora.com>
Subject: Re: [PATCH v2] ASoc: mediatek: mt8365: Remove unneeded assignment
Message-Id: <172616071500.69425.1928964300196117932.b4-ty@kernel.org>
Date: Thu, 12 Sep 2024 18:05:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 11 Sep 2024 17:36:22 +0500, Muhammad Usama Anjum wrote:
> The ret is being assigned, but not being used. Remove the assignment.
> One of the reviewer mentioned that dev_warn should be replaced with
> dev_info. Make this change as well.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: mediatek: mt8365: Remove unneeded assignment
      commit: d69f11e8c57e9459c9e60bffc0f2c6c3aa02f4b1

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


