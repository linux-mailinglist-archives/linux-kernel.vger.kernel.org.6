Return-Path: <linux-kernel+bounces-372363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDAF9A47AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A52B251E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9BA206941;
	Fri, 18 Oct 2024 20:07:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE00205ABA
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282052; cv=none; b=eTB8UurxD4QX8QHSeL+rA7CuIwlhHhApKgaj1uh+bQeDFlQRP2JjcRNINBJXCHZQYJiQB8ino7IizcmYvOe+CwsM4GRi/hstZ82Oh+z+XYwBBxYcN6xF0x4Zm+sOkcHjWI249p0YP5agGNtru/m9TM8YUFG7tJ95p1V0uPRPF/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282052; c=relaxed/simple;
	bh=RGO6OEHIuswcIR56IbAUE5Z10gkWfl1hIWGObojACzA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ihJ4gbMiGq2F6Er2A7FnGciWGWUv5nTWHtKhpSW33YpJj+tpz/AJ5iTyR67DvIviaWXKHFNaUwVvDgVI7B+F0lQAmYzhz8iqRY/O+AVHBF9fLvIoMEc1o/uRUQFUkOXBgIvItbRCnnuj3NBZtvTEq5NRmmaaYoa/M4/2OioJ17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E060C4CED2;
	Fri, 18 Oct 2024 20:07:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t1tGR-00000004Exo-00wl;
	Fri, 18 Oct 2024 16:07:59 -0400
Message-ID: <20241018200758.870680323@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 18 Oct 2024 16:07:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Julia Lawall <Julia.Lawall@inria.fr>
Subject: [for-next][PATCH 2/3] ring-buffer: Reorganize kerneldoc parameter names
References: <20241018200746.849970367@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Julia Lawall <Julia.Lawall@inria.fr>

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20240930112121.95324-22-Julia.Lawall@inria.fr
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a6a1c26ea2e3..696d422d5b35 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2437,9 +2437,9 @@ EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
  * __ring_buffer_alloc_range - allocate a new ring_buffer from existing memory
  * @size: the size in bytes per cpu that is needed.
  * @flags: attributes to set for the ring buffer.
+ * @order: sub-buffer order
  * @start: start of allocated range
  * @range_size: size of allocated range
- * @order: sub-buffer order
  * @key: ring buffer reader_lock_key.
  *
  * Currently the only flag that is available is the RB_FL_OVERWRITE
-- 
2.45.2



