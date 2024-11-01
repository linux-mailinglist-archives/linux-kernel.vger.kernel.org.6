Return-Path: <linux-kernel+bounces-392772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B6A9B97F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775E41C21604
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833751CEAA2;
	Fri,  1 Nov 2024 18:53:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADBF14F132
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487223; cv=none; b=dzHV4Ed6XGur+xwFZh0FiT1rgzlxuQb+EtXd43ERO6VnFXQr4TAFd23ijt+uh8JCiIcDNuuXgHWO0aNZb7fCrsd+ASY1WRCkbf1P4hZq3R6lah2NTcjD103usYxxvGVCgKQFSaxSEjEoFYdq4fKc70Zllbtrcp+EuEv8lOCGfss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487223; c=relaxed/simple;
	bh=ro5wUeeojSQyOrMtQSQiv/1J9dU72ZHlyMkY8wZshiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaEmVQkp8c/BReE9DRGwDhKHsC+KI7EGDI0GqLEBK9+DgDXxQzADl6gWH2n0b/YMVh9MzynkHZtZo9pS6yPiXPwUeEOUhfSpU7dZzslsT84OHIQhPPr7bzTW8BkpQm4G7DjTpAvc5KJdOesh3AuJEYOJwHSxcPuKjRSUHdI4Zl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67996C4CECD;
	Fri,  1 Nov 2024 18:53:41 +0000 (UTC)
Date: Fri, 1 Nov 2024 14:54:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nir Lichtman <nir@lichtman.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Doug Anderson
 <dianders@chromium.org>, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yuran Pereira <yuran.pereira@hotmail.com>
Subject: Re: [for-next][PATCH 03/11] kdb: Replace the use of simple_strto
 with safer kstrto in kdb_main
Message-ID: <20241101145439.634f444f@gandalf.local.home>
In-Reply-To: <20241101184228.GA38763@lichtman.org>
References: <20241101103647.011707614@goodmis.org>
	<20241101103707.290109005@goodmis.org>
	<CAD=FV=Uha5xwZJtdqirJtv27ZUBz7OP5oEnYg56v2i2mn0TrLw@mail.gmail.com>
	<20241101103128.46faf14d@gandalf.local.home>
	<20241101182204.GA752705@aspen.lan>
	<20241101184228.GA38763@lichtman.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 18:42:28 +0000
Nir Lichtman <nir@lichtman.org> wrote:

> I assume that is the reason, I just used the same recipient list that
> the original author of the patch series used a couple of months ago.
> The patch series is mostly around migrating to usage of better string
> to int conversion functions, so technically each change is not really
> dependant on the others.
> 
> BTW, Thanks for the reviews Doug and for applying Steven.

Note, it's now in Daniel's court. I dropped the patches from linux-next.

I took Doug's Reviewed-by tags as saying it can go through my tree. But
that was jumping the gun.

Sorry for the confusion.

-- Steve

