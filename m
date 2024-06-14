Return-Path: <linux-kernel+bounces-215103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D4B908E34
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F0B1C22401
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B2B18130E;
	Fri, 14 Jun 2024 15:03:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DFE16B73A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377388; cv=none; b=nQbKaf9nlxPrZJtTT6Z4WwZhD4DLiczRqZ222Tb2Ml0vjUEhHVfGfx0+1WntvKeIr62JmPsbe2zma54DODfJXnrAzmTfDWJW+oWSruRfdQM10r5FRNM3/b4/8CDObRm7pn/AXekMSBQoc/qlAOKm49F9lrCi5CsCoKOrFxpN3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377388; c=relaxed/simple;
	bh=rE1r9FoHA7AlxYiMFNpcjGUolLlR1G3IH+9oFtwrOU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+RY3dDAc25ClllrnuC2gyOuCXYAlomWm9p2yM+PuiC6pJrww9fG2aoaPr5g8XGtuJiT0YuJy5PPJ42e1q2kBHI8W3ZUhtCvNXUyQ5jlSqf7ScFgNzWyCCeDPqm3tCYkrY0NYw7Rpr2AqlA8+DnqTcA/kOJ7ZD733eJ2u5fNGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90BC91C01;
	Fri, 14 Jun 2024 08:03:30 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1C0E3F5A1;
	Fri, 14 Jun 2024 08:03:02 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v3 35/38] x86/resctrl: Remove a newline to avoid confusing the code move script
Date: Fri, 14 Jun 2024 15:00:30 +0000
Message-Id: <20240614150033.10454-36-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240614150033.10454-1-james.morse@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resctrl filesystem code will shortly be moved to /fs/. This involves
splitting all the existing files, with some functions remaining under
arch/x86, and others moving to fs/resctrl.

To make this reproducible, a python script does the heavy lif^W
copy-and-paste. This involves some clunky parsing of C code.

The parser gets confused by the newline after this #ifdef.
Just remove it.

Signed-off-by: James Morse <james.morse@arm.com>
---
This patch, and the post-move cleanup could all be merged together.
It's included like this to make the move script easier to work with.

Changes since v2:
 * This patch is new.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f13b5b0404e4..969c454b67f1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -880,7 +880,6 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
 }
 
 #ifdef CONFIG_PROC_CPU_RESCTRL
-
 /*
  * A task can only be part of one resctrl control group and of one monitor
  * group which is associated to that control group.
-- 
2.39.2


