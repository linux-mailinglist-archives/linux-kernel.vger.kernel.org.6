Return-Path: <linux-kernel+bounces-555841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6D2A5BD54
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EDF3AAA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5797E231C8D;
	Tue, 11 Mar 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8d/uXix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8967236A73
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687919; cv=none; b=IAxujvtyJWoq9NYbFxbZpzCjn7w1WzL59z8qs62oAL4B3hd8t+zcZVoxgc7hxYbUA51bgI+KUgcUPTWDloosWie30/D+PJUWzEhwgOTIf27eJGrLE0Dl9X6FKgdmzpWAwXuZcR9J+9SnV80cMZkfkdezbkntgm+Q+gRZhowj7fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687919; c=relaxed/simple;
	bh=wI6rm3kgmO+4Czqw6r4G9A3rll5Hy0paO6uSe/x9Deo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8US90aEeQCtwZIJMAbQmoQmQS/ocPKtq2pNYQRhWR9uCek1RHiYmJJb/Qu82mCT7J82+B1EQIOD1xzOev8s4628Mva421AY0qYsrV5qzRzdrYAKJSOL8T9ajcwFApJGi+Woms2axDufySbnd1sH8rRjT7akLBz9N/nJPJz2vGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8d/uXix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC07C4CEE9;
	Tue, 11 Mar 2025 10:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687919;
	bh=wI6rm3kgmO+4Czqw6r4G9A3rll5Hy0paO6uSe/x9Deo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B8d/uXixxiXUse3CbEAsQptoblBgmPDG7/LJYRPSNh9/NK80MWN0enP3PW3o5RuUj
	 m8FNX5TRXyN77/sQgjpW2v9oprwGTy1GfmHjFDQi0zRKeCrgJ5MDJy6+wOnfBcAFye
	 haHF7FIW/ZhfpQ6CUxHtBlLb5GMC2rXzO6ysmOlaBl7nXxUZgssAMTR+wmKD8nT8Rz
	 O2N6/05T701y/ETgTHvB2VVO4ZqUS4mVNZII+1mex5FGA4+GQX7x3R3pcMIJNmo3p6
	 S9NbGtLEqYYLoAPFTaqRChVvX186znv1+Ur9ROo+nXaKT8dv+G6e50rdUMgoKgpLC6
	 0uJay7Pif72Bg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:33 +0100
Subject: [PATCH v2 07/15] nvmet-fcloop: update refs on tfcp_req
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-7-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Track the lifetime of the in-flight tfcp_req to ensure
the object is not freed too early.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 2ad213c9041ee19893b2f7e8d8c82119ba412a46..4ba75f7f51e0bd95ab806b6e82452e75593ff0cf 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -567,7 +567,8 @@ fcloop_call_host_done(struct nvmefc_fcp_req *fcpreq,
 	}
 
 	/* release original io reference on tgt struct */
-	fcloop_tfcp_req_put(tfcp_req);
+	if (tfcp_req)
+		fcloop_tfcp_req_put(tfcp_req);
 }
 
 static bool drop_fabric_opcode;
@@ -672,6 +673,7 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		break;
 	default:
 		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
+		fcloop_tfcp_req_put(tfcp_req);
 		WARN_ON(1);
 		return;
 	}
@@ -930,6 +932,8 @@ fcloop_fcp_req_release(struct nvmet_fc_target_port *tgtport,
 {
 	struct fcloop_fcpreq *tfcp_req = tgt_fcp_req_to_fcpreq(tgt_fcpreq);
 
+	if (!fcloop_tfcp_req_get(tfcp_req))
+		return;
 	queue_work(nvmet_wq, &tfcp_req->tio_done_work);
 }
 
@@ -959,8 +963,10 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 
 	spin_lock(&inireq->inilock);
 	tfcp_req = inireq->tfcp_req;
-	if (tfcp_req)
-		fcloop_tfcp_req_get(tfcp_req);
+	if (tfcp_req) {
+		if (!fcloop_tfcp_req_get(tfcp_req))
+			tfcp_req = NULL;
+	}
 	spin_unlock(&inireq->inilock);
 
 	if (!tfcp_req)

-- 
2.48.1


