Return-Path: <linux-kernel+bounces-330083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F14F979983
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 01:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DBB1F22A62
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 23:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D6A12C80F;
	Sun, 15 Sep 2024 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JziDtYEv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A8425760
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726442782; cv=none; b=Wu6199zSYhiM+p5598v5gGJjZZ1vnmJPnYOHHihUqDZVtwx7xhdrSZSXBTz49zB4ELJGUevNn7cp2qBvZGI4s9snHIBNwqLsW1tQ7B7G3PtXvOMdsTcjliABKMqe7l2HtCQ7fvhAfhmHr5lSc2BPigLu5MQhTu1ruUb+JXwW82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726442782; c=relaxed/simple;
	bh=Lj9XyOmgNdmPaKjhnyWJQ0xqjhKWamglPR+CQHzYOOo=;
	h=Message-ID:From:To:Cc:Subject:Date; b=jpxsFyXnsP6GHS5SnOjCbHW0Se/ty4j4TQLrpWijS67UC5pdRF6STVpePHEkNiX5QONYnIPPxy+Gl53QfoW0oE8kaFsZtyCi2/edbW6J1pXYBTciGA0FndukaVGwZdXa3wOz9mHrJ04MXndwpPSdZDAsWD5zEojYFJTOItt0UHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JziDtYEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE030C4CEC3;
	Sun, 15 Sep 2024 23:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726442782;
	bh=Lj9XyOmgNdmPaKjhnyWJQ0xqjhKWamglPR+CQHzYOOo=;
	h=From:To:Cc:Subject:Date:From;
	b=JziDtYEv9niE2nvDroW9Mo1sop4E4Jh5FznOO9SqIU5QI9VoUgbWMyTkk3fT7zDbm
	 nd84zxD/AYA4VBnC5q34S7MVHYp9DaSnZilz9B0fPtweeBrv7Y3AyxE2UWUPcuCx1t
	 kUk7FxqLXf7iNkfTW8LtU2OGQL7XFIXSeQLMIGhxzyz86uCt/B8JthapBIUoR+P34k
	 M6A5wQrXmu7dPOLLg9mjxdD5JMUJSysUEDZruE0U9ReNWB3PEnBsfqLJdofTZ1FlGp
	 SkNZz8wSmfQk1zmmwgdhpDGt2zRPz+mLnQX0O/G4HAYtfZyR/vl4Q/8uI79Gknp2jU
	 EMN2PipnDcLPQ==
Message-ID: <43d1b7d25ce662bedb2438b6d0614a77.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.12
Date: Mon, 16 Sep 2024 00:26:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 7c626ce4bae1ac14f60076d00eafe71af30450ba:

  Linux 6.11-rc3 (2024-08-11 14:27:14 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.12

for you to fetch changes up to c7edb7ac8472a57e0c56a3a95796db3af98b2383:

  regmap: kunit: Add coverage of spinlocked regmaps (2024-09-02 12:56:16 +0100)

----------------------------------------------------------------
regmap: Updates for v6.12

The main update here is Matti's work allowing regmap irqdomains to be
given custom names (allowing multiple interrupt controllers associatd
with a single struct device), this pulls in some commits from Thomas'
tree which it depends on.  Otherwise there's a bit of work on improving
handling of regmaps protected with spinlocks when used with complex
cache types, fixing some valid but harmless lockdep reports seen with
some new driver work.

----------------------------------------------------------------
Marek Szyprowski (1):
      regcache: use map->alloc_flags also for allocating cache

Mark Brown (4):
      regmap IRQ support for devices with multiple IRQs
      regmap: Hold the regmap lock when allocating and freeing the cache
      regmap: Use locking during kunit tests
      regmap: kunit: Add coverage of spinlocked regmaps

Matti Vaittinen (3):
      irqdomain: Simplify simple and legacy domain creation
      irqdomain: Allow giving name suffix for domain
      regmap: Allow setting IRQ domain name suffix

Thomas Gleixner (1):
      irqdomain: Cleanup domain name allocation

 drivers/base/regmap/regcache-flat.c   |   2 +-
 drivers/base/regmap/regcache-maple.c  |   2 +-
 drivers/base/regmap/regcache-rbtree.c |   2 +-
 drivers/base/regmap/regcache.c        |   4 +
 drivers/base/regmap/regmap-irq.c      |  37 +++++--
 drivers/base/regmap/regmap-kunit.c    |  19 +++-
 drivers/base/regmap/regmap.c          |   1 +
 include/linux/irqdomain.h             |   8 ++
 include/linux/regmap.h                |   4 +
 kernel/irq/irqdomain.c                | 198 +++++++++++++++++++---------------
 10 files changed, 175 insertions(+), 102 deletions(-)

