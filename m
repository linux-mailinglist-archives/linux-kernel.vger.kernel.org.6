Return-Path: <linux-kernel+bounces-534409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3918FA466A9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7028E19C73C9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A85F220694;
	Wed, 26 Feb 2025 16:17:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B319C553;
	Wed, 26 Feb 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586665; cv=none; b=Dr/tEJkahVlP73VNE2HrtvffvNUGhsSwBSLlTJTAhxTdumMpyCMVShCq8gXqshcvJILaJCnjNsjq1nSC01XlJIIVCCSUx5FmxyPyaRsyXBuOx2ECG3CocC1xFiXKZYFdlPkfnwrr92miLCdXfCqnime2+ydbJrrkqDOwGWEyb8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586665; c=relaxed/simple;
	bh=oUZVwerF3Yu+pIG9rrybgaeLtE9QzuQTG3STnbWgJtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLG37pHzf4hC4F5PspISZQpwu4Cy7o5/FmfXpnNeGgtTk9rg53JctSrvGBfUS2qe/2MRS54vAE2An0s7ORnWxzVXuN0D7Z8rEqWq658QEmeXIsL9yIq8ILM6JhRh+OE/8LzrNpWh5UN+t4pnZCPw+ZKADBP2eFCgX2wr19xvZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587C9C4CEEA;
	Wed, 26 Feb 2025 16:17:42 +0000 (UTC)
Date: Wed, 26 Feb 2025 11:18:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sven Schnelle
 <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Let fprobe test consider already
 enabled functions
Message-ID: <20250226111822.2445bb1f@gandalf.local.home>
In-Reply-To: <20250226152835.23133Bd0-hca@linux.ibm.com>
References: <20250226142703.910860-1-hca@linux.ibm.com>
	<20250226235447.7fab8051b2968277ce6920db@kernel.org>
	<20250226152835.23133Bd0-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 16:28:35 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> That is of course except for the "add/remove/test uprobe events" test
> where I sent a patch. Not sure what will happen with that one:
> 
> https://lore.kernel.org/all/20250220130102.2079179-1-hca@linux.ibm.com/

Shuah's kernel.org emails seem to be bouncing. I'll try her Linux
Foundation one for that.

-- Steve

