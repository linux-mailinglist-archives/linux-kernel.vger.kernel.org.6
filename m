Return-Path: <linux-kernel+bounces-392372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B0F9B933C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E90B23305
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4031A4F19;
	Fri,  1 Nov 2024 14:30:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C760DCF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471432; cv=none; b=nuoJqGLP9pbM9Y7CunXiyP8kR79NN5AvMgve77ldIiCo81vaQ21dUQp+KWAz+pGxbEILnywdVxo8OcjlFvN6UcXv01AgtvCnfzSilkgkhZzVQmgBNLU22WKWoll3p0s7jI5+Se3gPdfELdLhustX9HskObK61vqR3xMs7fV8LcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471432; c=relaxed/simple;
	bh=PK6IHE9Avlw3op6raiygKrlA+ZzjEx9KRjFYZUkG7yE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5v+mWTRLa3jfQVBUZd/vwSyE9KnpmpZRqKjesqTVs9F5uOt1lqLln3ZwAfq+b+35ht1s0wPGHTlroPPQNbJdClY2Dil/5XpQu2YR+05lKxhzZAm5Tk5z9L45H6AawjZ/oZqM2izH2aiFdSbDW7yV+geyPO13yXH2LTDHpmfMl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103FAC4CECD;
	Fri,  1 Nov 2024 14:30:30 +0000 (UTC)
Date: Fri, 1 Nov 2024 10:31:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yuran Pereira <yuran.pereira@hotmail.com>, Nir
 Lichtman <nir@lichtman.org>
Subject: Re: [for-next][PATCH 03/11] kdb: Replace the use of simple_strto
 with safer kstrto in kdb_main
Message-ID: <20241101103128.46faf14d@gandalf.local.home>
In-Reply-To: <CAD=FV=Uha5xwZJtdqirJtv27ZUBz7OP5oEnYg56v2i2mn0TrLw@mail.gmail.com>
References: <20241101103647.011707614@goodmis.org>
	<20241101103707.290109005@goodmis.org>
	<CAD=FV=Uha5xwZJtdqirJtv27ZUBz7OP5oEnYg56v2i2mn0TrLw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 07:21:05 -0700
Doug Anderson <dianders@chromium.org> wrote:

> FWIW, I personally have no objection to this patch and patch #3/3 in
> Nir's series (#5/11 in your email thread) going through the ftrace
> tree, I'm not actually the maintainer of kdb/kgdb. I'm a reviewer and
> I try my best to help, but officially you should probably have Daniel
> Thompson's Ack for them. ...or at least make sure he's CCed here
> saying that you've picked them up.
> 
> I've added him to the conversation here.

Sure, I can even drop this patch if need be. Thanks for adding Daniel to
the Cc. I probably should have run these patches through get maintainers to
make sure everyone was accounted for.

-- Steve

