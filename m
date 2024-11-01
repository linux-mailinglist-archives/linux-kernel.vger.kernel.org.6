Return-Path: <linux-kernel+bounces-392743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49679B97A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995E62812F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7736C1CEAA2;
	Fri,  1 Nov 2024 18:35:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB3C1CDFD2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486142; cv=none; b=Y/UbKfJk5fHrPYP0lll7Tvaw0zEkA57cRSckD5vdxzwhMQiOnMKZNnNjWv0T6rY7T/jDdZHvmA8Ev7lObedbw1ekJLWq9q/N046EQuoOig5aAutUKi3FH23WWseqfnzIxr9bdVFwx6a1bc4MXBiXXd1KnMt3Dnu/rCQ64F2qwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486142; c=relaxed/simple;
	bh=kgz6VgkCAwActRkxJvYJD+M3mPkqlbGEEtvn5Wxj3uA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEzs6YDch1JsPXzdX6VOCUvBIPhR1/JEES/y07Yyhrq++FthEfb2O19OVmWRXsplTQWlXzkYSgbrFhGD0/+sOSVO5JaqRWxuy8rYA+PXFDZD+bAettVGjLEfcpU9/UARQKFmgZAD1U+X0trkivsnbivi8dkT7PT1yRtfC/zPPNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA42AC4CECD;
	Fri,  1 Nov 2024 18:35:40 +0000 (UTC)
Date: Fri, 1 Nov 2024 14:36:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yuran Pereira
 <yuran.pereira@hotmail.com>, Nir Lichtman <nir@lichtman.org>
Subject: Re: [for-next][PATCH 03/11] kdb: Replace the use of simple_strto
 with safer kstrto in kdb_main
Message-ID: <20241101143638.1eb0bb5a@gandalf.local.home>
In-Reply-To: <20241101182204.GA752705@aspen.lan>
References: <20241101103647.011707614@goodmis.org>
	<20241101103707.290109005@goodmis.org>
	<CAD=FV=Uha5xwZJtdqirJtv27ZUBz7OP5oEnYg56v2i2mn0TrLw@mail.gmail.com>
	<20241101103128.46faf14d@gandalf.local.home>
	<20241101182204.GA752705@aspen.lan>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 18:22:04 +0000
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> I presume the tracing tree is involved because one of them changes the
> kdb ftrace command? Are there dependencies between that and other
> patches in the seriesm?

Nope, I'll drop them from my queue.

You can add to the tracing patch:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

