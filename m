Return-Path: <linux-kernel+bounces-361576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5BC99AA01
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521501F247B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DAF1C2DC8;
	Fri, 11 Oct 2024 17:30:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283811BE251
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667818; cv=none; b=AI2133/agUyitZOCS6pGNjgbplGehoows9GXCXpge6pWk3jE9GCpZJkffOMAbW/tkBUXdUbUo+o2j1UA+HfVayAg477I+pyy+z5gYd+oaxVkk/4LYhYyhB2LY4ODbOAIYnbMc+OKnMx7j+XP2I02sDTJlcBUTojk/pQ01iMBg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667818; c=relaxed/simple;
	bh=PlkEiro4w2gZi89wqc1QOC1Lc+OcpeuLucwn2WycTqc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VFOMsP8TKfx8zEKzLFGtw739iV8y8sUvjzUYxx26MO21p9ozagGliRSTap0i4EdVsr64T4iqxig/nDeh/K48BdjXeeE37Qc+N5qTVSpDxC3koxevxCknwPJYOWwVO4w/f7MavYfRZkczT2vz4DmAlIV0ZdjYqM5p4/PGLUaR17w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA85C4CECF;
	Fri, 11 Oct 2024 17:30:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1szJTA-00000001TzL-1XjL;
	Fri, 11 Oct 2024 13:30:28 -0400
Message-ID: <20241011173028.229805053@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 11 Oct 2024 13:30:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Ba Jing <bajing@cmss.chinamobile.com>
Subject: [for-next][PATCH 3/9] tools/rv: Correct the grammatical errors in the comments[2]
References: <20241011173010.441043942@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Ba Jing <bajing@cmss.chinamobile.com>

The word "trace" begins with a consonant sound,
so "a" should be used instead of "an".

Link: https://lore.kernel.org/20240903003019.8969-1-bajing@cmss.chinamobile.com
Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/rv/src/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/trace.c b/tools/verification/rv/src/trace.c
index 2c7deed47f8d..1b9f9bfa1893 100644
--- a/tools/verification/rv/src/trace.c
+++ b/tools/verification/rv/src/trace.c
@@ -81,7 +81,7 @@ void trace_instance_destroy(struct trace_instance *trace)
 }
 
 /**
- * trace_instance_init - create an trace instance
+ * trace_instance_init - create a trace instance
  *
  * It is more than the tracefs instance, as it contains other
  * things required for the tracing, such as the local events and
-- 
2.45.2



