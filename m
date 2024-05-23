Return-Path: <linux-kernel+bounces-187650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08938CD5DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B5C1F21425
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2925012B177;
	Thu, 23 May 2024 14:33:05 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CD81DDC5
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716474784; cv=none; b=q8no9cZbwICsLnK1kUWqeAKAPvnohwYyiQdrA3z+5K9r2Fy45PAjveQamE0SfUPyrCKZCJQBXAxBafZkH5Azmj+7PNaqSMEB+8TVrNDvOXChb1SQjIMIiUmGFl78BclQniaUl6n67vatU8UVG6KOxahjJ+Q6zU1oQ0w3zxlTlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716474784; c=relaxed/simple;
	bh=wm+MfmttqMO7R9cZbo54oiGasVEBNy92p/KPfK5pibY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvoXXnXL3b8NO6TQ85L+YRv7IW0GB9kOYAne/bqmmsKGRHrH38M3F5x6gzCpVkEJ1AC5b+O7ncdqaUoFLn7vAGne/5vG+9axL9sniBNLxfpsKpRisGNYDji+3myeCc9xg1s2g69bacgQJM5NN0iIxmmqnxiXiqsaFTiKPlW1xSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78ABC2BD10;
	Thu, 23 May 2024 14:33:03 +0000 (UTC)
Date: Thu, 23 May 2024 10:33:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [GIT PULL] tracing/treewide: Remove second parameter of
 __assign_str()
Message-ID: <20240523103348.07295492@gandalf.local.home>
In-Reply-To: <20240523103204.7c50b070@gandalf.local.home>
References: <20240523103204.7c50b070@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 May 2024 10:32:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> [
>   I'm sending this now, near the end of the merge window. As it touches over
>   140 files and makes over 700 updates, adding it before -rc1 would help
>   prevent conflicts. I did a diff between the commit I based this off of and
>   linux-next and I don't see any new __assign_str()s added. I'm doing an
>   allmodconfig build of this merged with linux-next just to make sure.

And just after hitting send, the allmodconfig build with this merged with
linux-next finished with success. :-)

-- Steve


