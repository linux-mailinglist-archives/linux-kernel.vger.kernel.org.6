Return-Path: <linux-kernel+bounces-289452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4B695465F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F81C20E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9460016F900;
	Fri, 16 Aug 2024 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="1cfjsmkd"
Received: from out187-23.us.a.mail.aliyun.com (out187-23.us.a.mail.aliyun.com [47.90.187.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E3A176248
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802416; cv=none; b=g0Rw96YYYscVtU6oE3lAN+Y5LIm/CT5seJeOren6nLQm5mPyW+WEFDl+bFa+lWr/i1JLMx5kK6MHQIevUGqu2FQSl82UInWHmRABwqbYQKlDAOb765DzWUKq4k7qcr4gQ4NukkdHpfpTwkL9Z6ONjXtfVmeEpbD9HHJUDMbANsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802416; c=relaxed/simple;
	bh=zckmBa7rqDBbuGuKmBWcIrZ/ZAZUNwhfYdVJFWuY1JI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b7Oc6qCFZ1d0y7FjDYyq9TKUTUOqtct51Kx3eSn2Uw7pHWxUVERK5t1ONpDwc+NZNLP82PDS0qLVhdUkFh/ogNgRFhCObEHo7ZSjm2udtrO83Z+yiqYOrPRndKWWh0npZH1FIySc9yYtyVU/CvvE8nQIBRblfHegrYO7qRugDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=1cfjsmkd; arc=none smtp.client-ip=47.90.187.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723802403; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lQzoUbWA0uPjbm9HtmRPATyMTXIf86gHTMmcjgrN4O8=;
	b=1cfjsmkdIXcAuZtYUsVo3XntSNfAxaiXdB1EU50bBqvSNVfXw3oJf8+qN64RRD+wb+6ZvmAyt7yYeGwtx+Cka9NBLFHPqg1TWpyGxtTpDfvX1hWaF9iU5SfW0LX2EJ1wuf3jABFmj+l/2ojEO6BZJdW9XiFhRbF9798LjxnWnlo=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtmFE-Y_1723802396)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:00:03 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 0/6] Some minor cleanups for UML
Date: Fri, 16 Aug 2024 17:59:47 +0800
Message-Id: <20240816095953.638401-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:

- Remove the pointless union (suggested by Benjamin Berg);
- Minor tweaks on coding style;

v1: https://lore.kernel.org/linux-um/20240816015447.320394-1-tiwei.btw@antgroup.com/

Tiwei Bie (6):
  um: Remove unused kpte_clear_flush macro
  um: Remove the redundant newpage check in update_pte_range
  um: Remove unused fields from thread_struct
  um: Remove unused mm_fd field from mm_id
  um: Remove the call to SUBARCH_EXECVE1 macro
  um: Remove declarations of undefined functions

 arch/um/include/asm/pgtable.h           |  7 -------
 arch/um/include/asm/processor-generic.h | 20 +++++---------------
 arch/um/include/shared/skas/mm_id.h     |  5 +----
 arch/um/include/shared/skas/skas.h      |  2 --
 arch/um/kernel/exec.c                   |  3 ---
 arch/um/kernel/process.c                |  8 ++++----
 arch/um/kernel/reboot.c                 |  2 +-
 arch/um/kernel/skas/mmu.c               | 12 ++++++------
 arch/um/kernel/skas/process.c           |  4 ++--
 arch/um/kernel/time.c                   |  2 +-
 arch/um/kernel/tlb.c                    | 16 ++++++----------
 arch/um/os-Linux/skas/mem.c             |  2 +-
 arch/um/os-Linux/skas/process.c         |  2 +-
 13 files changed, 28 insertions(+), 57 deletions(-)

-- 
2.34.1


