Return-Path: <linux-kernel+bounces-193914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C58D3403
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A46285CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50CE17B400;
	Wed, 29 May 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1wqL0Xd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34989179970;
	Wed, 29 May 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977238; cv=none; b=Wi7ups7K7IeNE4d9/LZPEUnOHanMsl8nXV3iLfUdfqa6EhXeMP92jPgn3PdfcO4V+Kvs9nj4iejaKN2wIIITgdppfopKvOY72mOJCgbg49C3ZjnIUbEcJLpWS0jbDo4Sz0QXji7MVTh2uIQ6TEH0jDU705C4c/ssrYEgAXWu8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977238; c=relaxed/simple;
	bh=jU0NjnEWLZP7qMvgt67CMX8Qo17uw3DQgTOfVNjliyg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dcVZmeqVeDYUb1qx/XLKHkeiADuZHB0Jx7kNQ69qPZTeo4n4BDUzChoBIbqJy3+jdIwnnlxaLNZcNueVOvtHwI+ODUxcWZUvcSe5we4WvVSd95BD24tXsXA2uUwX1L5ZqrBY6FiKeAx4h2QC0sAQ/br0WrQb98PaoRMNmUp3L/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1wqL0Xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7B5C32781;
	Wed, 29 May 2024 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716977238;
	bh=jU0NjnEWLZP7qMvgt67CMX8Qo17uw3DQgTOfVNjliyg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A1wqL0XdX9wMCS4dsyySs/MmlTc8LI7t28AKGgVfnjqyPYxeQZUnZfo1iv75TUihk
	 Q7cwplSpI/GTrmX/IvZUbOZydfdu0wEi3yGdAnr8TtkL6FGvMbmgv6s47t2v/aYXo/
	 YZzCxR7Zz0E2zu208LfNQ36vxtpquue8S1E15kI68DeWPxFTGONQ/+JOArTV6P3zip
	 zPudOozPxuUDOFN3DEEaeiZxpNgJAEs1+IVRu7iZd8HhzBJ2TFAyyECdZh7sXfm0U3
	 jZRYwHt5P5VVnt/NoJxPbpjSGDO4pge66uWb94Y/OOpVWb5twItFtzbiQTfs0DsOHI
	 on9WnEwc6NW7A==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20240527101326.440345-1-ckeepax@opensource.cirrus.com>
References: <20240527101326.440345-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] MAINTAINERS: Remove James Schulman from Cirrus audio
 maintainers
Message-Id: <171697723476.23184.7362558841511719141.b4-ty@kernel.org>
Date: Wed, 29 May 2024 11:07:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-2ee9f

On Mon, 27 May 2024 11:13:26 +0100, Charles Keepax wrote:
> James no longer works for Cirrus Logic, remove him from the list of
> maintainers for the Cirrus audio CODEC drivers.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Remove James Schulman from Cirrus audio maintainers
      commit: d5d2a5dacbc8ea4386071ce243c43ea0dac23cb8

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


