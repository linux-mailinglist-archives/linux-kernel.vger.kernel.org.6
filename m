Return-Path: <linux-kernel+bounces-203315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEDD8FD943
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B841C2562A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F400816A370;
	Wed,  5 Jun 2024 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba1Uv6C6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366215FA93;
	Wed,  5 Jun 2024 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623515; cv=none; b=O1B6ZN1B0uO5ay1CN+AFJEBrJgtl4pE1WxEppljy97oullmNthhr9qsvnwc8jxhpH33r6MC/djtRcu/fTJHrSZfkH8y7SXT+PjyCd4y7lZUdqXNYUbgBByGNTmgiimLSUvInKyt9gJsMJ7pCpuPnka0eT3DhNQAsXyL7SCWAJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623515; c=relaxed/simple;
	bh=p9ysuhtDc6Za4hy53vN+yiYwrcFOUP7O0U967fpC+i4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FBsf5Izm5SQS5wrJK7OU7e6gitEe+mozpst7yx74bs2fxtMMsZLyM6kDHTWGlr8VO5121lr22z1Q2eG77HrXm+vvmKoe49h+VaFovxZwriI4WvPcWDYcWrjKcHb+HrW0ysaXcMn9XSqylP5s77EPUt/IRJl4y79eWMjeB8ztu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba1Uv6C6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1837AC2BD11;
	Wed,  5 Jun 2024 21:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717623515;
	bh=p9ysuhtDc6Za4hy53vN+yiYwrcFOUP7O0U967fpC+i4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ba1Uv6C6furrcBWT3OJ4FRi8CkB/W1X/286xovks3GQWXk3esB9vJXTvRHW0+dkRN
	 SWFbSkU36zBYF8jjwa9qBTXzPWreFHY8BmryCL9Bs2VzpfazSCAiPORZU6Yvo+oFnC
	 aif58EhvaPx2MZRFc7BKpEiXpsv5TIdaOdQobYz/+PEtEh5wCoHv6qT0Hc7abDB9VL
	 lsucIGib1kF4RU9xcjYPWlE+7fSkcw+g/bNgjotMh2jRwFKDP27H0gYnuhcglZkL9K
	 AamOANkRB5Lm+Wqh6Q6p/RghaPRYq3yql5HdSK+bI4TgxNXRH7TKCX+s3SC8uhKgbB
	 MIHruYLGFtWCg==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20240530-md-regmap-kunit-v1-1-976c0f616751@quicinc.com>
References: <20240530-md-regmap-kunit-v1-1-976c0f616751@quicinc.com>
Subject: Re: [PATCH] regmap: kunit: add missing MODULE_DESCRIPTION()
Message-Id: <171762351381.565895.17813266773525763530.b4-ty@kernel.org>
Date: Wed, 05 Jun 2024 22:38:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 30 May 2024 22:42:09 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/base/regmap/regmap-kunit.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: kunit: add missing MODULE_DESCRIPTION()
      commit: a8bd778958eface44a4931b30f1db5c98c9e6f40

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


