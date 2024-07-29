Return-Path: <linux-kernel+bounces-266038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFD993F9B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DDB1F2311C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1FD15B13C;
	Mon, 29 Jul 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJe4xVli"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A213BC3F;
	Mon, 29 Jul 2024 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267595; cv=none; b=cPykrTah94pFZ1YOssWm20jpc9/CzxbVK1ZbxNdEUlPd+63YIoTw2KVkjdaSY0sPTtkpH5hISoSiTkPHtz+q5DAqojflcUUvYm0oB4l4M3cR9NZX2U07enH0uCTRo80iA98rJMdQlUO40lyGO2D568gv+VMn148aLpSAYmmgkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267595; c=relaxed/simple;
	bh=K+U+ukLLGofE8RKAubw7jEBjbXKbiovuoprK5fuPjMo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vCsLllO8o/yGiVE8dThZ7YmXmDDrqETQHJglAFjV2d5gVs+Bi/Ufto1ztco+Bp4iX4NxfOuY0BJy01JxF3i2J2odhdrVT+1aYP2hvMveclvRp6jaUoGQfnaMzDEywLgO6Zy8uyNRtUpzoFP+7e0a3rqTXTTHblBdxjeCdYmGOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJe4xVli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7397DC32786;
	Mon, 29 Jul 2024 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722267594;
	bh=K+U+ukLLGofE8RKAubw7jEBjbXKbiovuoprK5fuPjMo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MJe4xVliQcg1OMzLaP2iV6BNXgnVcSTowb7fPEHbxDwyUChVxhKh//ZtO7NWXs6BH
	 ROCn6LvRSgXAplmj9kuFjowLIbMG3UOs/NFcvTtqaqEPVhr3roYQ9G7czJk4z7xm4Y
	 ja6ULKNElT3rSM8w6NJvpHOcrZoBylt0MGqwZQOeO0AqXouAEJNyVbEEskDjEiJrWM
	 3N9URy9zSYDxwvS+i08WlGjXGnzFRM06rRcO1Ve+EJleyRuA6xzsMLGf53yia4kSIE
	 exxewgAjM58d9GZS6UtO6QfgJyL9/FGlxzMMCJqEpfE6iVVOnUG81d7JCs8O0sO8DM
	 ZRFe10cny87oQ==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <01cd578f-127b-4c8b-a8c6-5e11a0a2555c@stanley.mountain>
References: <01cd578f-127b-4c8b-a8c6-5e11a0a2555c@stanley.mountain>
Subject: Re: [PATCH] regulator: bd96801: Delete unnecessary check in
 probe()
Message-Id: <172226759317.71083.8993251392928777169.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 16:39:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Fri, 12 Jul 2024 09:05:39 -0500, Dan Carpenter wrote:
> The "idesc" pointer points to the middle of rdesc[] array so it can't be
> NULL.  Also rdesc isn't NULL.  Delete the check.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd96801: Delete unnecessary check in probe()
      commit: f0aaae1a5827c916f2d66e4392726c0c43d0479c

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


