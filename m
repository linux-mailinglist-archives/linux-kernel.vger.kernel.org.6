Return-Path: <linux-kernel+bounces-412992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48EE9D120B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3EB28452D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C201AE016;
	Mon, 18 Nov 2024 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXV7Mxyo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178919E993
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936764; cv=none; b=JzbA9ktzYPx4s+kZbJkRxgssePmxPbjxLE+lDuhim8UIEq1OUIkBHSi9TJYgcYQCr3kZe1DRdZzEERLzo9lpC52zuLTdK1hd7i6sCEisbAle53yaOZrQEJA1eKmcEqWKw0fr5XImY3rC2LKZNOGREYGUCG0iEDWiBwPoavhG6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936764; c=relaxed/simple;
	bh=aJd26H5CoefHCDVqNQEDXHTAGKtIu1SGszUKTk5I/xQ=;
	h=Message-ID:From:To:Cc:Subject:Date; b=jz5Tr0P/X+emlMF4dIgYfaaNdofwkcES90ADFc8xKw+MsRFxnsaZwbYLXbN1nvR/FI5o7sIxsFeYFX3f8q8kEvWZ2ju2ZyOlumD/iUxkGYD7pNr4mNk9F8Hl5ypRz9hISwtWEgAzaA4aXE/tYZZXAlXxJiXWVlVytZ859TGSoQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXV7Mxyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CF0C4CECC;
	Mon, 18 Nov 2024 13:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731936763;
	bh=aJd26H5CoefHCDVqNQEDXHTAGKtIu1SGszUKTk5I/xQ=;
	h=From:To:Cc:Subject:Date:From;
	b=SXV7MxyoxRfHozBfvShEu/83dqTwFmBs7yOLJGwADyKEZNa7CWOizosZuVnaeZHBN
	 P9ujByUDQkZLg1CufUqzZQgf2U6fnaOnqCPFB1UztdsAZdJ/k6QBJXDEGdKdgGmBHC
	 n6QTZZh6gIatHeNdhz6m11UmNd/C6sP6FiPoCJ5M18iaDa6ywZLJxjINl4X2EyQPwj
	 8moSiwUN0pzyhYJDhRG+WMyGGpyJqqLPSFzKUYFMoON27Ao2aaU5AmVFiilkZkSmEC
	 gfLJZ1Rlw47jTsxU7fbH45f4MslfLMKhkuVfA5hda5IeMD8+jC8SSKQbNYy6E1ai37
	 7iWI+kb7rsYWw==
Message-ID: <4aa156874403b74722254e1e25ead0e5.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.13
Date: Mon, 18 Nov 2024 13:32:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.13

for you to fetch changes up to d1f4390dd28ba110f232615dc4610ac1bb2f39f2:

  regmap: provide regmap_assign_bits() (2024-11-08 15:39:31 +0000)

----------------------------------------------------------------
regmap: Updates for v6.13

The main thing for regmap this time around is some improvements of the
lockdep annotations which stop some false positives.  We also have one
new helper for setting a bitmask to the same value, and several test
improvements.

----------------------------------------------------------------
Andy Shevchenko (2):
      regmap-irq: Consistently use memset32() in regmap_irq_thread()
      regmap: irq: Set lockdep class for hierarchical IRQ domains

Bartosz Golaszewski (1):
      regmap: provide regmap_assign_bits()

Cheng-Cheng Lo (1):
      regmap: kunit: Fix repeated test param

Cristian Ciocaltea (1):
      regmap: maple: Provide lockdep (sub)class for maple tree's internal lock

Mark Brown (3):
      regmap: Specifically test writing 0 as a value to sparse caches
      regcache: Improve documentation of available cache types
      regmap: Merge up fixes from v6.12-rc3

 drivers/base/regmap/internal.h       |  1 +
 drivers/base/regmap/regcache-maple.c |  3 +++
 drivers/base/regmap/regmap-irq.c     |  9 ++++----
 drivers/base/regmap/regmap-kunit.c   | 45 +++++++++++++++++++++++++++++++++++-
 drivers/base/regmap/regmap.c         |  1 +
 include/linux/regmap.h               | 25 +++++++++++++++++++-
 6 files changed, 78 insertions(+), 6 deletions(-)

