Return-Path: <linux-kernel+bounces-280155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8979B94C66D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC4D1F22221
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF715ADA7;
	Thu,  8 Aug 2024 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGBcc8DD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863A8827;
	Thu,  8 Aug 2024 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723153608; cv=none; b=jMNryTlFnUqW78xhW29r3S2lTwcjaWrMU+YkNYCiFxCj9s1uJAoyShR8UAm2ES4m/Sm61KTaFK3j07/N2xThA0cjDjH40YWVQ5Dno93WEpIhVyKwhrTe/ZbOpM7DC8hidUXvZN99Lq/sXjldJGSvTDwlFYSbFcGsTvPkXySOWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723153608; c=relaxed/simple;
	bh=UpzHpIfcYmMp41faoq+QJCrKELTb/ypQPzxLGZjUpn8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iNXh8FqfIqB1QI/wl6yqtX0AfZFFuLXXVGtLIame4JTcXBtiZZGo1LXUmVFuzztWKbAJDyLSGRT2WtZdvAvQrJ6qGep1qxdCV3+F1zGEDvoqkSIv01kwnMSGAnf+2Y6EJOFYq1t8lfFbPED+ZNzZB4UgxMZ6t3fo2L2QKyoixQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGBcc8DD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A80C32782;
	Thu,  8 Aug 2024 21:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723153608;
	bh=UpzHpIfcYmMp41faoq+QJCrKELTb/ypQPzxLGZjUpn8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rGBcc8DD8QthfTx/CRgWwHDg9eXjKbsCK18+GHlpVSvNSuTj4sUdxEUVnLgcSO73H
	 qn7rUE7PDUlhdbmQpyJJpMmgKqMDc4g0TNk9QYCncyTg2j36fW1SquWGnOxP4eD9tG
	 gBmqwkGotCIcu4fbYukGirkeyWZ7oTm2u+sq4flT5bNLZ6dWfgAtpZXKCkV3WSakcL
	 6lHdliN54vUsgvwTQa9U5DbHCQmEPjzQ233Dhr4oAFT5mmORP4vxfSAZzBJc1YniJU
	 8nQrOphCS+GjUGCYyNzgKFWhd4i8qSTnsHXG4LX3tXgc6uQMhcWfPwiG35zIuuXYgb
	 4oLu1DUF+LASg==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240807140140.421359-1-ckeepax@opensource.cirrus.com>
References: <20240807140140.421359-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] MAINTAINERS: Update Cirrus Logic parts to linux-sound
 mailing list
Message-Id: <172315360675.480667.8763800346086861897.b4-ty@kernel.org>
Date: Thu, 08 Aug 2024 22:46:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 07 Aug 2024 15:01:40 +0100, Charles Keepax wrote:
> Now that most kernel work on sound has moved over to the linux-sound
> mailing list so should the Cirrus Logic audio parts.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Update Cirrus Logic parts to linux-sound mailing list
      commit: 2f11f61f9d4d5692bcebb9d089429ee0c046e08a

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


