Return-Path: <linux-kernel+bounces-197201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703428D6779
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9B4282B35
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AA16D304;
	Fri, 31 May 2024 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYPRqj0E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9D5381A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174531; cv=none; b=NT1EcKn2tvCs5ANfGX4DPUgbhwSIfloTdpw0BsWdxNETpAbRARTILlXWHB9+ROsQpmriHyDORAqu8yF2oB8jGLpp5FtdaaulefT5CYT+9pS1cc252AQGLB1L3t8+46Q+qrlg+qHtgXxDxAMiFE73nAkiVmfIcZKn42sheSqPt3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174531; c=relaxed/simple;
	bh=F/A2CW4eAiRKXDns0StAoqcIqApQXGBpkU8uTJ1NG4E=;
	h=Message-ID:From:To:Cc:Subject:Date; b=sOgapTRCmIK/qLxeoS6hudYMgz4G0lPp6UFIs+A3f/yQeM6ftFgyZiqarOQS0ZQPM5XwxMjmpC4c6qmFP3TWBW/BuEUZrubX6pZtjWM0qYxc2s9Tq/WwIfUFnGWPMgnlWzR0dN/PayatG5LWT1NDyEmQGmjZ2L9V766woM8zk50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYPRqj0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DCDC116B1;
	Fri, 31 May 2024 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717174530;
	bh=F/A2CW4eAiRKXDns0StAoqcIqApQXGBpkU8uTJ1NG4E=;
	h=From:To:Cc:Subject:Date:From;
	b=fYPRqj0E85ra55+GGQNiHKTTwCeXXFdB0iadsQH1Mw+RUv7O+ECiuiCwa80fHFEji
	 mVcqhqYkRmpS9Usce6E9zJVPUNZOlKUcOEZiPBrzCxs4yIkEFxpYo7slEZkgk1cOdf
	 Gxw51rbK9jqNgK4eYDj9NkxkKfACYRuKv27C9/zKQWEiQmfsqiTCvc8OxF09GKiPj9
	 uv4H4yxUtigq/N9tjpgUlBCMBtAN+GdPv8YEJgjFKPnL1M7sGHnPE21cQQDM4cTqR/
	 8UPtBzeZRXgMJZipcL4c4ZRIpfw+I50OPgRNIx4hg6j1b42anqtCCafss+4j+14sa1
	 FUoEkQ/C0NLhw==
Message-ID: <95218454cfe88d47c47e2440865d09a8.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.10-rc1
Date: Fri, 31 May 2024 17:55:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.10-rc1

for you to fetch changes up to 611b7eb19d0a305d4de00280e4a71a1b15c507fc:

  regmap-i2c: Subtract reg size from max_write (2024-05-27 01:30:33 +0100)

----------------------------------------------------------------
regmap: Fix for v6.10

The I2C bus was not taking account of the register and any padding bytes
when handling maximum write sizes supported by an I2C adaptor, this
patch from Jim Wylder fixes that.

----------------------------------------------------------------
Jim Wylder (1):
      regmap-i2c: Subtract reg size from max_write

 drivers/base/regmap/regmap-i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

