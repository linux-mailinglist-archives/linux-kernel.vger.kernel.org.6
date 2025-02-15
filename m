Return-Path: <linux-kernel+bounces-516412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1273A370FE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 23:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE5A1893820
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 22:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2101A5B84;
	Sat, 15 Feb 2025 22:21:16 +0000 (UTC)
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3351925B8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739658075; cv=none; b=lWHNQOwmkDwC4ifJQt5TcCGePbN0z1SGPPiBRk1Uim7GeyAHeRsfX5819QJDgP55Q3z34+OPnUKDG6tOZYZKXCmBfTVQ0XQ4wE1T2zGhXP+LvZPenXHC5BJjw+ftBIdIXHthaGjUi74mN+ws59dV4pDosEddpMXrI91e3Lh7Mnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739658075; c=relaxed/simple;
	bh=7YBl0rJiPKdcMLSsC2tAHvhe5cuQvgT6BVtCUfuga4Q=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=hq+pB75LQXeJjK/umFQFxNJEV12bhZoOKJppdpxo18CN1cFdZlVw5edxDgMqfn6vwS7fxbVTPKR0hT2Himt0TdJ14cfzNuOnzwAtoAs5uIgOTvftDWrYuGqi8duU6CgIg9TyUqj1Sy3rF4RGzsJ91KxLRCDA6pec7bWu0u+ut2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3B83D2F332B;
	Sat, 15 Feb 2025 23:21:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id LVFoHIv9BJ5s; Sat, 15 Feb 2025 23:21:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E4B912B4F6A;
	Sat, 15 Feb 2025 23:21:03 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WNNxbRAQ5ZXY; Sat, 15 Feb 2025 23:21:03 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id CD1132B03C5;
	Sat, 15 Feb 2025 23:21:03 +0100 (CET)
Date: Sat, 15 Feb 2025 23:21:03 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <153400218.11019314.1739658063786.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fixes for v6.14-rc3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF135 (Linux)/8.8.12_GA_3809)
Thread-Index: Py+j5YggKIhDLYY1onwnBXiaHHPABg==
Thread-Topic: UML fixes for v6.14-rc3

Linus,

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.14-rc3

for you to fetch changes up to 96178631c3f53398044ed437010f7632ad764bf8:

  um: convert irq_lock to raw spinlock (2025-02-12 23:40:59 +0100)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- Align signal stack correctly
- Convert to raw spinlocks where needed (irq and virtio)
- FPU related fixes

----------------------------------------------------------------
Benjamin Berg (4):
      um: add back support for FXSAVE registers
      um: avoid copying FP state from init_task
      um: properly align signal stack on x86_64
      um: fix execve stub execution on old host OSs

Johannes Berg (3):
      um: virt-pci: don't use kmalloc()
      um: virtio_uml: use raw spinlock
      um: convert irq_lock to raw spinlock

 arch/um/drivers/virt-pci.c       | 198 ++++++++++++++++++++-------------------
 arch/um/drivers/virtio_uml.c     |   8 +-
 arch/um/kernel/irq.c             |  79 +++++++++-------
 arch/um/kernel/process.c         |  10 +-
 arch/um/os-Linux/skas/process.c  |  16 +++-
 arch/x86/um/os-Linux/registers.c |  21 ++++-
 arch/x86/um/signal.c             |  13 ++-
 7 files changed, 203 insertions(+), 142 deletions(-)

