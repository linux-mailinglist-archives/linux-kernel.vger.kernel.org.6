Return-Path: <linux-kernel+bounces-545154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC165A4E9B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E58C420104
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24622BE7D7;
	Tue,  4 Mar 2025 17:17:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2F29DB7F;
	Tue,  4 Mar 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108654; cv=none; b=OQyYn6DhqxXtJebPSl+zYDZN9gCV/kqjX58y52wmTEtEppeP71ofE/8Llo7IY5IjHSuwaG3nv+ACbIAvF6J6gGj+tYlD42YfuXpMUcrP3KrU+ShM1f8JejvgCwvlh09JLaFDXhr0qarpuYkS5Ki1eRg4Yaq7IYMvCxAiAeNgVFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108654; c=relaxed/simple;
	bh=Cub2U67ysXpV9EHO8NacvujSGVQMPjHHYnRs/d2RJ2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdlDejynDT+/kIvHbhGfXYY7QZnx+DwnEObWEfdnd9VEygcm2UWd2vkPYkSD/6r9o5fSU6uBr9gqEMeWjRsmIIVDt+pLJpF7zA8OtyphIhWKvH5C4tG+GlETNtzhpkqmO+lcozlmFXhrL3fb8Pqt1OYw4XLQS39IPjmMDQeWbJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92327C4CEED;
	Tue,  4 Mar 2025 17:17:33 +0000 (UTC)
Date: Tue, 4 Mar 2025 12:18:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v4 02/11] rv: Add license identifiers to monitor files
Message-ID: <20250304121828.34006e00@gandalf.local.home>
In-Reply-To: <20250218123121.253551-3-gmonaco@redhat.com>
References: <20250218123121.253551-1-gmonaco@redhat.com>
	<20250218123121.253551-3-gmonaco@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 13:31:07 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> Some monitor files like the main header and the Kconfig are missing the
> license identifier.
> 
> Add it to those and make sure the automatic generation script includes
> the line in newly created monitors.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  kernel/trace/rv/monitors/wip/Kconfig            | 2 ++
>  kernel/trace/rv/monitors/wip/wip.h              | 1 +
>  kernel/trace/rv/monitors/wwnr/Kconfig           | 2 ++
>  kernel/trace/rv/monitors/wwnr/wwnr.h            | 1 +
>  tools/verification/dot2/dot2k.py                | 1 +
>  tools/verification/dot2/dot2k_templates/Kconfig | 2 ++
>  6 files changed, 9 insertions(+)

While I'm waiting for Peter's answer on the scheduler tracepoints, I'll
take these first two patches now, as they are agnostic to the rest of the
changes.

-- Steve

