Return-Path: <linux-kernel+bounces-266040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608B793F9B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 17:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D3E2830FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D181615F303;
	Mon, 29 Jul 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amAp3hGJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533E15EFA0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267598; cv=none; b=JjV5GP3I4lLGawsF47UfXYiLr4PMGGi3BmpYOTkGgSMyYdeQUzmPqX5K6YYbsOdSc+6kqrwqcoLsZkR5bMx50bimZEFksrhB7HxjECpZ0jGTgVMEtMygM3HQUZMrVlHefD6N6OGw2l0r0FEW6PfH1Qdl9rSmcsNGCrFr2EUiYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267598; c=relaxed/simple;
	bh=znPs4v7LHA66SRhF/8XsrPtbtwrRzqodWkRhP/5vy/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DbbOruHFeEHqUv7PbRqR0yHctx1JlAUZzjhrc2vptwcQzw81RsayxADQszXd9OFkfVHWo1e/JEpSSeZFg/+pBs4+lvgtDkX0KVw/mq23moUyA95JLqBEuzq3FY7K7ReZj2rNFEM3P0pR+YhJqtCB4Ev+4Ipcft2e9jOYW7UFHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amAp3hGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594A8C4AF0A;
	Mon, 29 Jul 2024 15:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722267597;
	bh=znPs4v7LHA66SRhF/8XsrPtbtwrRzqodWkRhP/5vy/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=amAp3hGJbtZozQO0cZPd59+uLC4DobsVbO3toCbuGyAPv10oHXuG65bAxlZ2zDt2r
	 40WjN5i88u8D5EyuCZ7F0ukmHOuzNustFCIQmvE0WD0gqE3YX/ruq5JG2XOjR3LmKV
	 G78GYH8PRxUJXWvPyLTToxAydk8XMPXzNRIo4vU09qiQynbg4tmSmNknU4gIjLUJxG
	 M49BKDN0UAb5Q6FvYp8GkyLKNcTpvylO2IF0KrEqUuwMsVIeEzu3QOabIjJ+fZVsyG
	 TwNxWDS7QpEXHR33/4K7sIyf0ZDc1/Yr40mzRxGRxe+biW+d8GseBAJi4h8JYjLzv8
	 c5Z5Y7tww2CLw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, axel.lin@ingics.com, ckeepax@opensource.cirrus.com, 
 Chen Ni <nichen@iscas.ac.cn>
Cc: patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20240716085115.1252817-1-nichen@iscas.ac.cn>
References: <20240716085115.1252817-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] regulator: wm831x-isink: Convert comma to semicolon
Message-Id: <172226759609.71083.2271751842186568292.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 16:39:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 16 Jul 2024 16:51:15 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: wm831x-isink: Convert comma to semicolon
      commit: 291f854ecadeb275e5e586001963950341d85e7a

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


