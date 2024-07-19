Return-Path: <linux-kernel+bounces-257364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C030937913
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC661F22EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD351459FD;
	Fri, 19 Jul 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2/ceORH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4F91DFCF;
	Fri, 19 Jul 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398665; cv=none; b=ZK4ESQDVetdPPOPdAOwk+LyOHNTMVvYtFBwdIURMWBN6FqpJ0kUcaremghNRzftJtJvLqhD1ADDnA40BH4L+JVHdYVEDJAjadjqHp4qGqwHN9B/f6rulRt9XjvVL0jb+2qAMN0WbDqxs1vvnExcCZEImPGJ99hUx8K5tvoW308I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398665; c=relaxed/simple;
	bh=Ut4xJGgBxh3iieppbyZRMpYk4TtvlneYmX7qcNK+sLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ulkk2vv9dMTu2PHC+wNksIGlSi2Dg4P0/iD/BHklmmvwRGNLzr8llHMSVNuUQPxd734bsrJgMhnTsECVk1A3igue3/X2PZAd7hf6bCCP17sx8ze7VFYUANRA1Mly4tzHsJmQW+X+YBf0y7hmjC6qHPXrXF8/s42hlLXyS7VzyIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2/ceORH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B886C4AF0F;
	Fri, 19 Jul 2024 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721398665;
	bh=Ut4xJGgBxh3iieppbyZRMpYk4TtvlneYmX7qcNK+sLg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Y2/ceORHodio7oV9WhkR+jBmMPluxzGw421lIlMI7/DRijceIWdEbXmCHP87X/NiI
	 q6kmtcvUqg4H1KbtDPFojosaSOgLHxv6NYV7ZvMQdA9sYb5cDqQDVl2R2vbQzU53xK
	 XqnhDZ/EEnjneyTlsXN3qxWnJaFWL4MbCR0Ln7fd5udDwkvzTEjNq+88mZcMnJ6rAb
	 Jk+JkHvrbfnGadaHmbGDmRUuE+jO8Dtaaf1VbqNSlXuSTc7qhSJUXQvFcKy2FL1E5H
	 Mib6RDlcE8tQHdnafxzNDJCKnP9YEZhAGiga5ClLdsaQ00QYgdy+POLHjT68Rv7rLd
	 mm6jhjkRCbqTw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE3EC3DA59;
	Fri, 19 Jul 2024 14:17:45 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Date: Fri, 19 Jul 2024 17:17:38 +0300
Subject: [PATCH] workqueue: doc: Fix function name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-fix_doc-v1-1-9d176e38ba98@yadro.com>
X-B4-Tracking: v=1; b=H4sIAIF1mmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0NL3bTMiviU/GRdk9TkFHOjpDRLS2MTJaDqgqJUoBTYpOjY2loAeap
 64VkAAAA=
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: nikita.shubin@maquefel.me, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@yadro.com, 
 Nikita Shubin <n.shubin@yadro.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721398668; l=1021;
 i=n.shubin@yadro.com; s=20230718; h=from:subject:message-id;
 bh=6/ib8dGatUxNJG05zdhXdZ6AZtRqyM3pThPJjlGkNx4=;
 b=cRAqQq5yIutUty/S5LFaNNALEemsa2GMaE7bcvIREB7a+QH+jWdV0HWSn1WcK8HJtofYCtPStjOf
 pwbD37WFDYGkuWv43RJQHnqG8SQJ3rvz4JK2+m0QFSCME1jQTWW1
X-Developer-Key: i=n.shubin@yadro.com; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for n.shubin@yadro.com/20230718 with
 auth_id=161
X-Original-From: Nikita Shubin <n.shubin@yadro.com>
Reply-To: n.shubin@yadro.com

From: Nikita Shubin <n.shubin@yadro.com>

s/alloc_ordered_queue()/alloc_ordered_workqueue()/

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
 Documentation/core-api/workqueue.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index bcc370c876be..f28d7a1ab4b1 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -260,7 +260,7 @@ Some users depend on strict execution ordering where only one work item
 is in flight at any given time and the work items are processed in
 queueing order. While the combination of ``@max_active`` of 1 and
 ``WQ_UNBOUND`` used to achieve this behavior, this is no longer the
-case. Use ``alloc_ordered_queue()`` instead.
+case. Use ``alloc_ordered_workqueue()`` instead.
 
 
 Example Execution Scenarios

---
base-commit: 080402007007ca1bed8bcb103625137a5c8446c6
change-id: 20240719-fix_doc-4ecd72bf9934

Best regards,
-- 
Nikita Shubin <n.shubin@yadro.com>



