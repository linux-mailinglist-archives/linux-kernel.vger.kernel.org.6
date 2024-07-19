Return-Path: <linux-kernel+bounces-257377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D76937931
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF07A1F23174
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2F1B86DD;
	Fri, 19 Jul 2024 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmH7rFo7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8D1B86D3;
	Fri, 19 Jul 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399415; cv=none; b=S0u0fQoexuCpBerdX8hSiYuhHxAq2fW5kx2QmK+OI4CnZJg1YEyqX4ll5xH7LMBl01+KeMerZnhuADaFiBU8POVnLk1iK5sZJ9lHoLUuvzu2vsIjOiD/QYpbYamO1IYZEAo/rzJV2ino28ECP48ysdnp2bDkl1D085pg4VvAA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399415; c=relaxed/simple;
	bh=aj1KRRyV+w/R5nRB18d4Jl7irUsZTzLb0TZ50Ul/0mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gsH41TrBW/kXBLlPtNrV25wQLePpRzAZ8XQmUe+ZmMqyrWBC7iGNar6TbfH1CyLX1lO3MWEVZ3TSr/4P2Hfj3aQ+VxRSxRizpzuYIQFSJIowuecAoKSLupFDFT1KvGk/wwljnXNa/40t74SPxJmN1JHg8R0qyZiCYQFmiKnrhTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmH7rFo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E863C32782;
	Fri, 19 Jul 2024 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721399414;
	bh=aj1KRRyV+w/R5nRB18d4Jl7irUsZTzLb0TZ50Ul/0mE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=TmH7rFo7S+6gBqNSejWRSqQaitkuFLMBctgeYXDSa2eFgOgeaFJJ8xa6pCzHNTgRu
	 xB0n7rjItBHhyl7kSqgN4IvuqnWAiYihttpslLHw+CM1OsFF8Dqqih3weAU9iu+Z9z
	 MGm34AgYsv70O85MfV9y5zEj6xcA709zX6USTE2SUxEm7I/0xLXLkTHepUCeLn013w
	 ZxAVMVXkW+2u479H04Urpzr7bbdjBgYHOhHKyTLf1EkWV1N1fJvBSGWq/aNXTM0RBf
	 DHod++umBnGQa+8poccsxvg84JKTd1uvEDDuoI7z7kyBeB8ZjnmQwkM3vLa3VWyjHB
	 BHUWsLDF2jXJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A066C3DA5D;
	Fri, 19 Jul 2024 14:30:14 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Date: Fri, 19 Jul 2024 17:30:16 +0300
Subject: [PATCH v2] workqueue: doc: Fix function name, remove markers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-fix_doc-v2-1-a5cbeb46e0cc@yadro.com>
X-B4-Tracking: v=1; b=H4sIAHd4mmYC/2WMQQ7CIBBFr9LMWkyHEimuvIdpDIWpnYWlAUNsG
 u4uduvy/f/ydkgUmRJcmx0iZU4clgry1ICb7fIkwb4yyFaqVqMRE38ePjihyHktx8mYTkG110j
 1Okr3ofLM6R3idoQz/tb/RkaBwnjUF+r60Zr+tlkfw9mFFwyllC/7FNp3ngAAAA==
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: nikita.shubin@maquefel.me, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux@yadro.com, 
 Nikita Shubin <n.shubin@yadro.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721399417; l=1221;
 i=n.shubin@yadro.com; s=20230718; h=from:subject:message-id;
 bh=J54vi+EARiXY1qbZRDNxODuY2S1a3C8+8h3B7EsXh9E=;
 b=3zYY9q2uPCLsBhaWI1jbMjaRHDeT4Bbh0astcXoZ+T7SGfSAWvSKMXhN3YShfyYZfo9YtoIHL3BH
 6oJnv1TLAyrLZyIJunvLThv2KCGVWoBUVx2ziTpD/VvytzlVx+S4
X-Developer-Key: i=n.shubin@yadro.com; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for n.shubin@yadro.com/20230718 with
 auth_id=161
X-Original-From: Nikita Shubin <n.shubin@yadro.com>
Reply-To: n.shubin@yadro.com

From: Nikita Shubin <n.shubin@yadro.com>

- s/alloc_ordered_queue()/alloc_ordered_workqueue()/
- remove markers to convert it into a link.

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
Changes in v2:
Matthew Wilcox:
- No problem removed `` markers
- Link to v1: https://lore.kernel.org/r/20240719-fix_doc-v1-1-9d176e38ba98@yadro.com
---
 Documentation/core-api/workqueue.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index bcc370c876be..16f861c9791e 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -260,7 +260,7 @@ Some users depend on strict execution ordering where only one work item
 is in flight at any given time and the work items are processed in
 queueing order. While the combination of ``@max_active`` of 1 and
 ``WQ_UNBOUND`` used to achieve this behavior, this is no longer the
-case. Use ``alloc_ordered_queue()`` instead.
+case. Use alloc_ordered_workqueue() instead.
 
 
 Example Execution Scenarios

---
base-commit: 080402007007ca1bed8bcb103625137a5c8446c6
change-id: 20240719-fix_doc-4ecd72bf9934

Best regards,
-- 
Nikita Shubin <n.shubin@yadro.com>



