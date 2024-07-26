Return-Path: <linux-kernel+bounces-263371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EB393D502
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B9B21AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5D4101C8;
	Fri, 26 Jul 2024 14:22:12 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C1DDBB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003732; cv=none; b=qY8/ori0URHfi0NBx2JbAmo5zN9JZsZdmULhPitTI75Q8s1We37BP0PmBnjGuJkkoQuDYOehKrkBZ8l8QAkDBK6a3hKPM3NZCs+H0YBqrXvY0A2rgXosXQaYWh1Od18GAYZpDg99SmqsQ64XPmhtAPR+rT+JAnj/D/zWxO1rLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003732; c=relaxed/simple;
	bh=tGLHNnN6IdLwZnlIqK023gc1zoqJMBpLcZvPUU+oVUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMxPrzps6GUEh8N3me+uJ9APbPiSSYwm1gvSd22Y0hOt6FbvkNLsg5LoNEdmHptXOh07gsJIYvSj+l65qBXRhcRyGXiZ61Pg2SodpZZWDkE+jfkNqVUkJbIwtLdWxhlbJ0tT0eEsh3QB7wGyMKZp73bOdnYnQvzVgwnH4LCH1OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2CDC32782;
	Fri, 26 Jul 2024 14:22:10 +0000 (UTC)
Date: Fri, 26 Jul 2024 10:22:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: remove tracing_is_on export
Message-ID: <20240726102208.41996fbf@rorschach.local.home>
In-Reply-To: <2024072611-unrelated-aflame-bf41@gregkh>
References: <2024072508-freefall-headstand-7d47@gregkh>
	<20240725083102.38950c1c@gandalf.local.home>
	<2024072506-aghast-appointee-7f83@gregkh>
	<20240725092609.1441788d@gandalf.local.home>
	<2024072525-declared-yam-0cad@gregkh>
	<20240725095307.3067329f@gandalf.local.home>
	<2024072526-manned-ludicrous-1ce2@gregkh>
	<20240725121745.787c5b33@gandalf.local.home>
	<2024072611-unrelated-aflame-bf41@gregkh>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 10:15:14 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > This has been exported since 2008. Has it ever been a problem in the last
> > 16 years?  
> 
> As I am finding out, yes, external modules are "abusing" this to do
> different types of logic depending on if tracing is enabled or not for
> various unknown reasons.  As there was no in-kernel user of this symbol,
> I assumed it was just an oversight and should be removed.
> 
> I'll go ask the distro involved to just remove the symbol from their
> kernels instead, but that feels like the wrong thing to do to me.

Interesting as I was unaware of this. I'm not against removing the
"is_on" from being exported, as that really was only there to be
consistent with the others.

-- Steve

