Return-Path: <linux-kernel+bounces-182275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7282F8C891D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A1B1F22222
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5A412CDB6;
	Fri, 17 May 2024 15:15:36 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CFD1F93E;
	Fri, 17 May 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958936; cv=none; b=Z3rEy1bJri2zaQqsMJpU5drb4fJbW1w7DUOVk7dwTDyxC+7EX19bGE7BmLvSX91j3+TrwSsUmmGB2iZL3GNkc2z8LTp56+TQgYUMn2w0sufOfObfgn+Gt9W02WI/JuqeqOPM1CO8XMY6RrAz63ytxKsuHfHvLIqKqT4Ch9wM2E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958936; c=relaxed/simple;
	bh=tzkeAutgHKDvtezMaRFIFQ1vOKGxq4NGB23kr6qrPCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NI4PbtxFjKBzBBKfazPnlMDCjISSNrRK3l8PhRF0KKoo/FCxjwor8agjswJtkcvS9R3+TI7MGCuu/1GVheHznJMBLIP5EA6K7hOd+SxVldsET6OHJUs4mlGtyEV+OVfKQbFl7pVw5WCVN7mnzpfidRyYm6KNNOXwGGvH6Oq2OwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=link.tyut.edu.cn; spf=pass smtp.mailfrom=link.tyut.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=link.tyut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=link.tyut.edu.cn
Received: from localhost.localdomain (unknown [120.208.127.153])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 2CDA0920119;
	Fri, 17 May 2024 23:05:50 +0800 (CST)
From: Hu Haowen <2023002089@link.tyut.edu.cn>
To: corbet@lwn.net
Cc: Hu Haowen <2023002089@link.tyut.edu.cn>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_TW: add translation for glossary
Date: Fri, 17 May 2024 23:05:28 +0800
Message-ID: <20240517150529.102958-1-2023002089@link.tyut.edu.cn>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHx4dVh5LGU0dTxgZQx8ZSVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpJS1VJS0NVSklMVUpOSFlXWRYaDxIVHRRZQVlPS0hVSk1DTExPVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8f8716f93303a1kunm2cda0920119
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MU06Cio4MzMMOTQUMQ46MAoB
	DxYwCQxVSlVKTEpOQk5DSENDS09PVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
	V1kSC1lBWUpJS1VJS0NVSklMVUpOSFlXWQgBWUFITUxJNwY+

Add translation for glossary and add it to index according to commit
cac02cbb91f31e28 ("docs/zh_CN: Add a glossary of Chinese translation
terms").

Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
---
 Documentation/translations/zh_TW/glossary.rst | 36 +++++++++++++++++++
 Documentation/translations/zh_TW/index.rst    |  5 +--
 2 files changed, 39 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/translations/zh_TW/glossary.rst

diff --git a/Documentation/translations/zh_TW/glossary.rst b/Documentation/translations/zh_TW/glossary.rst
new file mode 100644
index 000000000000..6ff2a5a460ea
--- /dev/null
+++ b/Documentation/translations/zh_TW/glossary.rst
@@ -0,0 +1,36 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+術語表
+======
+
+這不是一個完善的術語表，我們只是將有爭議的和陌生的翻譯詞彙記錄於此，
+它的篇幅應該根據內核文檔翻譯的需求而增加。新詞條最好隨翻譯補丁一起
+提交，且僅在以下情況下收錄新詞條：
+
+        - 在翻譯過程中遇到陌生詞彙，且尚無翻譯先例的；
+        - 在審閱過程中，針對某詞條出現了不同的翻譯意見；
+        - 使用頻率不高的詞條和首字母縮寫類型的詞條；
+        - 已經存在且有歧義的詞條翻譯。
+
+
+* atomic: 原子的，一般指不可中斷的極小的臨界區操作。
+* DVFS: 動態電壓頻率升降。（Dynamic Voltage and Frequency Scaling）
+* EAS: 能耗感知調度。（Energy Aware Scheduling）
+* flush: 刷新，一般指對cache的沖洗操作。
+* fork: 創建, 通常指父進程創建子進程。
+* futex: 快速用戶互斥鎖。（fast user mutex）
+* guest halt polling: 客戶機停機輪詢機制。
+* HugePage: 巨頁。
+* hypervisor: 虛擬機超級管理器。
+* memory barriers: 內存屏障。
+* MIPS: 每秒百萬指令。（Millions of Instructions Per Second）,注意與mips指令集區分開。
+* mutex: 互斥鎖。
+* NUMA: 非統一內存訪問。
+* OpenCAPI: 開放相干加速器處理器接口。（Open Coherent Accelerator Processor Interface）
+* OPP: 操作性能值。
+* overhead: 開銷，一般指需要消耗的計算機資源。
+* PELT: 實體負載跟蹤。（Per-Entity Load Tracking）
+* sched domain: 調度域。
+* semaphores: 信號量。
+* spinlock: 自旋鎖。
+* watermark: 水位，一般指頁表的消耗水平。
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index 660a74d2023c..95809012a9ef 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -119,9 +119,10 @@ TODOList:
 術語表
 ------
 
-TODOList:
+.. toctree::
+   :maxdepth: 1
 
-* glossary
+   glossary
 
 
 索引和表格
-- 
2.45.0


