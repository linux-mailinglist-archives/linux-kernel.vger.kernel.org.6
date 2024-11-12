Return-Path: <linux-kernel+bounces-405105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70279C4D09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A648287172
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E191205E07;
	Tue, 12 Nov 2024 03:08:50 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8F31B6525;
	Tue, 12 Nov 2024 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731380930; cv=none; b=do1zuumwYZvyzc+RDAmGFeP+ch/JYWHhIE/4f+NjdynkGZk1SO3Yrn2oF/XIE1IpIPyuqgjmN+R+9W0PU90mqNwwr5h/rr+JrhbZKTS5wZlcXWpMkmLPFnWA+H8h1Eq0q4v88E8r73Y2S3eCK6koPpfDK7pUhZ1ubxb6U08jLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731380930; c=relaxed/simple;
	bh=C57Eg147c9BHu8+LFHpTE8LpIa4Dq+f0HtSO3R0n6xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c/qGK+poFwrAEjCjeiHnBguLKVY78OGL93X4F1J6BpxgavEo2PYOELqTf5Kb946+cRuH3L+pz1sHv01cBo+PBWCiTtVK3Dq0Roc4N3446fMiMNF7L7ORTiQ/+wFwcf0vIukRZSNp82Dkppei/EyLt2qI9c3tFsd42pMgL3a2Uwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XnWZW624vz4f3jXn;
	Tue, 12 Nov 2024 11:08:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 09F831A0196;
	Tue, 12 Nov 2024 11:08:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP4 (Coremail) with SMTP id gCh0CgDnwoa0xjJnvTEqBg--.2387S2;
	Tue, 12 Nov 2024 11:08:37 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH -next] docs/locking: Fix grammar in percpu-rw-semaphore.rst
Date: Tue, 12 Nov 2024 02:57:24 +0000
Message-Id: <20241112025724.474881-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnwoa0xjJnvTEqBg--.2387S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurykWr48Aw1rurWUXF4UXFb_yoWkGFgEya
	4Yqay5Xr4rXws7KFyUCF10qasYkr1Utr4F9343tFsxX340ya98J3Z7CF15Zr4UWF4a9rZ8
	uFZ8uFWa9w17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

s/'is initialized'/'is initialized with'

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 Documentation/locking/percpu-rw-semaphore.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/locking/percpu-rw-semaphore.rst b/Documentation/locking/percpu-rw-semaphore.rst
index 247de6410855..a105bf2dd812 100644
--- a/Documentation/locking/percpu-rw-semaphore.rst
+++ b/Documentation/locking/percpu-rw-semaphore.rst
@@ -16,8 +16,8 @@ writing is very expensive, it calls synchronize_rcu() that can take
 hundreds of milliseconds.
 
 The lock is declared with "struct percpu_rw_semaphore" type.
-The lock is initialized percpu_init_rwsem, it returns 0 on success and
--ENOMEM on allocation failure.
+The lock is initialized with percpu_init_rwsem, it returns 0 on success
+and -ENOMEM on allocation failure.
 The lock must be freed with percpu_free_rwsem to avoid memory leak.
 
 The lock is locked for read with percpu_down_read, percpu_up_read and
-- 
2.34.1


