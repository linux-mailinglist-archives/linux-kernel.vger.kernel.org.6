Return-Path: <linux-kernel+bounces-301252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6113495EE37
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A011F220F4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC891487D5;
	Mon, 26 Aug 2024 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="PJsmi1pt"
Received: from out0-218.mail.aliyun.com (out0-218.mail.aliyun.com [140.205.0.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C8146A6C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667232; cv=none; b=A823eox4CRLEW6hluTgTT5fW7DkP61eqWY1vCeYeF+7OAOKBWyvAxgl+8fvyCdCwaduFGSV9sTBOow4WvHd84EnMnnyRUnyicDKF3JlCngBddR48cXaSO3ehETJjcCLJfyhPgIKSZ+fpyS3pd93KOmc/cLaoDgmapWz5aKq5xx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667232; c=relaxed/simple;
	bh=SQNdLkkMBCyO8nS1N2MduN2dTu/4Tiqn6PdfMwyVkvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nqs7r1t6iOHfdMf9E1Av9B2g5PecYNdh6BpxrNKMPhzto+Odjwy/lKukr1adseBx2PzutQmhcUP40SChKYdDgkEMG689BcEr6JyPTitxTKUlwF7qyWINboaz97KuUX1uKdvf97jmzcRbPfh42BYeWGJ68AtTnlTyJ2qaSeqcEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=PJsmi1pt; arc=none smtp.client-ip=140.205.0.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724667221; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gV4YuhNr3rLW09QhC/TCMiLgjL0RM1UYr/GPl7N5E/g=;
	b=PJsmi1ptNXE0vhhlGoCYDUJC/OYoPxPaGvQERmDUXg0RN4+AucIfOlBP/XhbqpR7a0muwNY9s8flEGeTceGfHcqKnBgzAOrqZUzV7L7uZQbgs4C6mmcOfo+2+aKB1lf/f0TU5S7DCrvUhnNxRQpTczqsZkixvDksmWLp0uCuh/g=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z2YRsYx_1724666898)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 18:08:25 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 0/7] Some minor cleanups for UML
Date: Mon, 26 Aug 2024 18:08:08 +0800
Message-Id: <20240826100815.904430-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:

- Remove "um: Remove declarations of undefined functions";
- Add "um: Remove the declaration of user_thread function";
- Add "um: Remove outdated asm/sysrq.h header";
- Minor tweaks on commit log;

Changes in v2 (https://lore.kernel.org/linux-um/20240816095953.638401-1-tiwei.btw@antgroup.com/):

- Remove the pointless union (suggested by Benjamin Berg);
- Minor tweaks on coding style;

v1: https://lore.kernel.org/linux-um/20240816015447.320394-1-tiwei.btw@antgroup.com/

Tiwei Bie (7):
  um: Remove unused kpte_clear_flush macro
  um: Remove the redundant newpage check in update_pte_range
  um: Remove unused fields from thread_struct
  um: Remove unused mm_fd field from mm_id
  um: Remove the call to SUBARCH_EXECVE1 macro
  um: Remove the declaration of user_thread function
  um: Remove outdated asm/sysrq.h header

 arch/um/include/asm/pgtable.h           |  7 -------
 arch/um/include/asm/processor-generic.h | 20 +++++---------------
 arch/um/include/asm/sysrq.h             |  8 --------
 arch/um/include/shared/skas/mm_id.h     |  5 +----
 arch/um/include/shared/skas/skas.h      |  1 -
 arch/um/kernel/exec.c                   |  3 ---
 arch/um/kernel/process.c                |  8 ++++----
 arch/um/kernel/reboot.c                 |  2 +-
 arch/um/kernel/skas/mmu.c               | 12 ++++++------
 arch/um/kernel/skas/process.c           |  4 ++--
 arch/um/kernel/sysrq.c                  |  1 -
 arch/um/kernel/time.c                   |  2 +-
 arch/um/kernel/tlb.c                    | 16 ++++++----------
 arch/um/os-Linux/skas/mem.c             |  2 +-
 arch/um/os-Linux/skas/process.c         |  2 +-
 arch/x86/um/sysrq_32.c                  |  1 -
 arch/x86/um/sysrq_64.c                  |  1 -
 17 files changed, 28 insertions(+), 67 deletions(-)
 delete mode 100644 arch/um/include/asm/sysrq.h

-- 
2.34.1


