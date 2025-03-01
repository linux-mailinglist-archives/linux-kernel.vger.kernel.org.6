Return-Path: <linux-kernel+bounces-540038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADABA4ACD5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900EE7A60B8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7C31E51F2;
	Sat,  1 Mar 2025 16:22:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A172CA8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740846153; cv=none; b=LtLrzYpi/04mJ2/pQUzvWoAaTYb/42+aQ3nLPOxdg0HcN71MoDxiqEs8yYr9I6F4khMW7FDzo4JGKVkeQLGIXKybCaKmBQWKSrNGcVAsGC1rvlXoFBFoA/jPGrlwn0PMHDkWM36azNC2UCw+UrZHiEALauKH2p6RpAgQ8ScL4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740846153; c=relaxed/simple;
	bh=7GLwPeu5KSxEZPPg2F64+CLNB9yhb7jzmU+0aH6L6aQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tQfueGRM4J0PYj8zrGA1UmmIr6aneILOXBk4nweAMfs7l9kAJFHpuH+bzCyhAM2znmDIl7MfViF/TJE83I2uJb/D7Iz3sA4iNTrAj0bKvtOj2bSqxJ9ZEHldDKk0DU/7d0MN+k3dTX+AdKi6o7bs5qxacVxv5Mw8XSd9Vrlbo28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCD7C4CEE6;
	Sat,  1 Mar 2025 16:22:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1toPcW-0000000AgxA-3lG9;
	Sat, 01 Mar 2025 11:23:20 -0500
Message-ID: <20250301162320.748095061@goodmis.org>
User-Agent: quilt/0.68
Date: Sat, 01 Mar 2025 11:22:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [for-next][PATCH 1/3] ring-buffer: Fix typo in comment about header page pointer
References: <20250301162258.654648143@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

Fix typo in comment about header page pointer in function
rb_get_reader_page.

Link: https://lore.kernel.org/20250118012352.3430519-1-zhouzhouyi@gmail.com
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bb6089c2951e..9d4d951090d3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5318,7 +5318,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	 * moving it. The page before the header page has the
 	 * flag bit '1' set if it is pointing to the page we want.
 	 * but if the writer is in the process of moving it
-	 * than it will be '2' or already moved '0'.
+	 * then it will be '2' or already moved '0'.
 	 */
 
 	ret = rb_head_page_replace(reader, cpu_buffer->reader_page);
-- 
2.47.2



