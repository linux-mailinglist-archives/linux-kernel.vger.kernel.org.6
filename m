Return-Path: <linux-kernel+bounces-359960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7033099930B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A03ED1C23DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4751CF5C5;
	Thu, 10 Oct 2024 19:47:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737E6188A08;
	Thu, 10 Oct 2024 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589622; cv=none; b=CJGQRO3XVyo4l4uX5gqawDBYwj6WVac/UWQ/i3IMBWok+cayOBfg+YbeM5yj+D1f0REs02yjhwKdMwTt5SoDrXQx2Nni2Td9eyGrjgRwmuMCHmVRmssJALlIrS5CngmF5k9XxB5Xf7VbxwS3LhBYnkV5NMFytvCtKUBbLVageZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589622; c=relaxed/simple;
	bh=0g6m73T0hJa5hZI3IQpeokaC+/DYe4Y8vBDk9aKE+9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0sLMNCwv4KQA/r+HswJdJsOFCYAPkKUO6y21uQGh/C/n4sqgKcS3J/PC2Njd0/JG95Lz+MFxHMIA6mewRlyzYa+d5b+i/EDrbCJoJTbI99xTHqnysG7Tir1JkTJCa4EXU9z5iUKFPMmW05fxBkihiaKqGFWbx7mbJY31NOUEc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2588BC4CED0;
	Thu, 10 Oct 2024 19:47:01 +0000 (UTC)
Date: Thu, 10 Oct 2024 15:47:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: fix WARNING document not included in any toctree
Message-ID: <20241010154708.0bf658a3@gandalf.local.home>
In-Reply-To: <20241002195817.22972-1-surajsonawane0215@gmail.com>
References: <20241002195817.22972-1-surajsonawane0215@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 01:28:17 +0530
SurajSonawane2415 <surajsonawane0215@gmail.com> wrote:

> Add debugging.rst to the relevant toctree to fix warning
> about missing documentation inclusion in toctree.
> 
> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
> ---
>  Documentation/trace/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index 0b300901f..2c991dc96 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -24,6 +24,7 @@ Linux Tracing Technologies
>     histogram
>     histogram-design
>     boottime-trace
> +   debugging

If order matters here, I'd like the debugging to be at the top. As I plan
on it being more of a tutorial for using tracing, and should be the first
document people see.

I need to take some time out and start filling it up!

-- Steve


>     hwlat_detector
>     osnoise-tracer
>     timerlat-tracer


