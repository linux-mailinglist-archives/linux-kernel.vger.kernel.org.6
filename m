Return-Path: <linux-kernel+bounces-413764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D93B9D1E57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27860B242EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884CF13A868;
	Tue, 19 Nov 2024 02:36:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA327A13A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983765; cv=none; b=gUWvV6VS3VRpyDDLopu7ucCl7UggyA8sm8wnEVHCudxKGBrdrT0MnFaOIt2IBY4hGm+CTPfPuU6NRO3vz7LL6kgTRpzERJsV/o1Hs1aRuJNmFl9PNi1vFxUzr6sximdy09XTwlk2h603b7XwNJVoZMVDti6z+Jjj3Qds25dUNbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983765; c=relaxed/simple;
	bh=Ai1q3LYaU1SaRCDfRg5B9X58Tvf5AvQpnd/sIJez+IU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tKCWzBCIoh1+Gzg9zN+1/LW7dou3eqBqGIrclQkbW9dtJAzRc1i6DfS0/11YvyYqbD3Ri+SQvuHvl4Fr6hddPdZ1pgqruZUHbq7r0BH644+gmL72IpOb3N/TFlleYFjSZp5P2zHUAoPZAEmyRYRbg1ssxmF+ZprDi8SNp39odp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CADC4CECC;
	Tue, 19 Nov 2024 02:36:03 +0000 (UTC)
Date: Mon, 18 Nov 2024 21:36:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, liujing <liujing@cmss.chinamobile.com>
Subject: [for-next][PATCH] ring-buffer: Correct a grammatical error in a
 comment
Message-ID: <20241118213635.029970b8@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: 537affea1672a841cd5b87b208c193a3a542c7cf


liujing (1):
      ring-buffer: Correct a grammatical error in a comment

----
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 537affea1672a841cd5b87b208c193a3a542c7cf
Author: liujing <liujing@cmss.chinamobile.com>
Date:   Thu Nov 7 17:53:27 2024 +0800

    ring-buffer: Correct a grammatical error in a comment
    
    The word "trace" begins with a consonant sound,
    so "a" should be used instead of "an".
    
    Link: https://lore.kernel.org/20241107095327.6390-1-liujing@cmss.chinamobile.com
    Signed-off-by: liujing <liujing@cmss.chinamobile.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index db3bf6a1b536..d6100a7da483 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4060,7 +4060,7 @@ static const char *show_irq_str(int bits)
 	return type[bits];
 }
 
-/* Assume this is an trace event */
+/* Assume this is a trace event */
 static const char *show_flags(struct ring_buffer_event *event)
 {
 	struct trace_entry *entry;

