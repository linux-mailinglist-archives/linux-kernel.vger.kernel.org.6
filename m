Return-Path: <linux-kernel+bounces-394834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9779BB4A3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222A41F210DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24271B6CE2;
	Mon,  4 Nov 2024 12:25:01 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118F1B0F2B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723101; cv=none; b=eovp8WTWcKDOkyHK+nM/48rGUm1woI/1dfNzRIz0MgAI3gEV6J5aGGcZ8M/u0GApDaF78LPvVUnSf704/ZHMEh8fDXYA+JvbZhgSTINt7zgj2n4+NVUUOSunaphMj2o7jgyEDzi+ct8gAi4wv3sIOO2Dt1c9M/Be8/Nh/G5GLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723101; c=relaxed/simple;
	bh=hMnNvV795UWRRyeGynz3zzxGFDq7gm4n+LsNUESRa5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mQA2CZVztXF0WQoT0FT1+ezVJVmM5QprNfRIv1We/xotG4LO0HwSoPgf9DxRs9TKIP237YG/YOlH4HAUEkCrRihRQIv9Ui/OFxHqx/CKH1FKDiamraZcL76NBVnD8d+My86660F7WlUcOyR9QabMzEO/eXPMzeG59BeIKn2LPxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso699148766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:24:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730723098; x=1731327898;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noss4JzKSmsBngEFnQJcUyJxc5mA+0TM8Vx3hh7eYas=;
        b=dIH7oWMuWiRj2BchRx1gjjQBjyfXYODTAsKywvbyXOFPqjZaozzsCn7pNkIf8Lkv5M
         MPa7mn/5vG0plSi6s113YFzhst7mTfV55NhkDUXQIMot2xQWHMD3bJUlUc0sCssAn7rx
         9yDtinLfUi7+cojPpxtbPn4UIcKjDbVahPT32rf2NaFx2B1lugYzbFmgESKQxYI088lv
         +4rAd1rXEOgmPqTISryMJhydVxWaznChN2+K3AktjlhuP0Go+I7CoLKX+WeDNMyyBYXD
         L82txvOMgORd8gMAyTNHTg2Nt2mP3RgVfko+Cp5JzpV5FYcBX7ypY04K8nOuzBP7ZqjX
         axCw==
X-Forwarded-Encrypted: i=1; AJvYcCWhHuLVioTY0AKmQ40IPgRPY4VVhbtU8r0dwSPI9t6HIHxefiSSYxmwRudMB5o1AChQdE0XdARLz0kpjeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWFHGzPRIpdbC2hN/vjULFSiHsKod91LGnJKxOAH8g6iXvtqm
	+Ekpll+wfUnRL6eQyqSuxVgXlNSi5Dg+2OuCmodx93yILVGMntv/
X-Google-Smtp-Source: AGHT+IGom24GOsnZKz6VayrnkwHTK9IsOyw+hmLZpO+PThRjb8M4Xrqczs2ChZQUUPF5sy3LVE9DRw==
X-Received: by 2002:a17:907:ea0:b0:a99:f9d6:5590 with SMTP id a640c23a62f3a-a9de6331185mr3195394366b.60.1730723097614;
        Mon, 04 Nov 2024 04:24:57 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e5668491esm544932466b.204.2024.11.04.04.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:24:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 04 Nov 2024 04:24:40 -0800
Subject: [PATCH] nvme/host: Fix RCU list traversal to use SRCU primitive
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-nvme_rcu-v1-1-ecb19f5c95fa@debian.org>
X-B4-Tracking: v=1; b=H4sIAAe9KGcC/x3MWwqAIBAF0K0M9ztBpYe4lYgIm2o+slCKINx70
 FnAeZE5CWd4epH4lixHhCdTEcI2xZWVzPAEq21tjK5VvHceU7iUs40Orbad4xYV4Uy8yPNX/VD
 KB4+D6dZaAAAA
X-Change-ID: 20241104-nvme_rcu-8250c60278e6
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3965; i=leitao@debian.org;
 h=from:subject:message-id; bh=hMnNvV795UWRRyeGynz3zzxGFDq7gm4n+LsNUESRa5g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnKL0YI6M+hK8w7iHenAB5FxQUv8SBDtrAwnrZd
 cX6CyvRLfaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZyi9GAAKCRA1o5Of/Hh3
 bTBMD/9aSUmUCp5S0ckOCcGfb13sTp7X8To3/7fBfml9HauKYJF5l+04zV3EU9vEDMIGpW/YxWN
 K75B9DO3tVEk2bIzdI3mq458dtXmfJ7MEs5MeYDkJSNFih7PssJ+qtWGcB222O7e0OuWjv3B2l9
 D+EK52k/y41/pxi5XFoQkHRgf7qWfZRa5FcvZ3YYzE3w9vkPU5wxmFNJN0nVfl74PQ/buB0G+vo
 e0XLkTqOywNwUxU8qfHc6GrR2AjupqjF1muCJDzZ5jkwnD65cKZeOyUXCC/bqGRw9P65Xm9d2NX
 EBUqak2rA0B2QHIjhV9qFXKXlkiD1neAN+jrLfhgXaZt73ENOqWNvu7tsdUIFjuOkDRXtJoiH8x
 QvAhww0YRT8YuynBi3LFlVS9mUAXkkjD5Eq4dscIMatNDKGkER/kJhwRqaUoWEHgwXpghoTKcbw
 S7ae4s+JdtrPDNPBt2+MYvCdmpgh14uesrZBKNFm4P1bJ2QdsTNWG27coH4c+VEE3L1cOlswvzA
 A+2ZHapIxMwVLLUQ7JqA/aX9wki/7Yv3ktBVhJpN6MVsBOQsaDehlrfkJqwDeEH47Uisv9ZzZBk
 YiSvLao6RDFPk2mJEqdrs1v7xw9rxNhw7E42BluOgB9WV86KJSuPlifQndHpYBA7eaQ7ktNV43I
 LWUJkkFCPFqio9g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The code currently uses list_for_each_entry_rcu() while holding an SRCU
lock, triggering false positive warnings with CONFIG_PROVE_RCU=y
enabled:

  drivers/nvme/host/core.c:3770 RCU-list traversed in non-reader section!!

While the list is properly protected by SRCU lock, the code uses the wrong
list traversal primitive. Replace list_for_each_entry_rcu() with
list_for_each_entry_srcu() to correctly indicate SRCU-based protection
and eliminate the false warning.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: be647e2c76b2 ("nvme: use srcu for iterating namespace list")
---
Something similar will need to be done for multipath. I will get it done
once I get some feedback about this patch first.
---
 drivers/nvme/host/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 84cb859a911d09dbe71b2f1ac473ae687c4dc687..3583bae69ef74c6f1fe6d465531a9a09512a6f13 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3767,7 +3767,8 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu)) {
 		if (ns->head->ns_id == nsid) {
 			if (!nvme_get_ns(ns))
 				continue;
@@ -4851,7 +4852,8 @@ void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu))
 		blk_mark_disk_dead(ns->disk);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
@@ -4863,7 +4865,8 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu))
 		blk_mq_unfreeze_queue(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 	clear_bit(NVME_CTRL_FROZEN, &ctrl->flags);
@@ -4876,7 +4879,8 @@ int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list) {
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu)) {
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
 		if (timeout <= 0)
 			break;
@@ -4892,7 +4896,8 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu))
 		blk_mq_freeze_queue_wait(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
@@ -4905,7 +4910,8 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 
 	set_bit(NVME_CTRL_FROZEN, &ctrl->flags);
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu))
 		blk_freeze_queue_start(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
@@ -4953,7 +4959,8 @@ void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&ctrl->srcu);
-	list_for_each_entry_rcu(ns, &ctrl->namespaces, list)
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu))
 		blk_sync_queue(ns->queue);
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }

---
base-commit: f488649e40f8900d23b86afeab7d4b78c063d5d1
change-id: 20241104-nvme_rcu-8250c60278e6

Best regards,
-- 
Breno Leitao <leitao@debian.org>


