Return-Path: <linux-kernel+bounces-254390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21979332AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96741283A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B886A1A0AF8;
	Tue, 16 Jul 2024 20:11:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BDF1A0AE8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160668; cv=none; b=qjiEcDCOr+y1OPm1lAHyhIZZlT3QShovmDf+dV9Z8IFsq4qhEcFWhr5CJJEWsyS4ZWFzCIF/UoQVTCyqZtIU4rMjsBD6O63q944gqmBqEhhCQCQU/QzjD1uf8VlQlyzfptm7pcPM51P/jYLYKnZqAaSUBlL1/znQffVoIPBuhTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160668; c=relaxed/simple;
	bh=u0ghT8dU1S07tbbl3Ihco2OikKAPp33hAhpPhYhVY0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEv0lyecMz4NX/93j/Tts1gvE7J7JeSOU0nMPj/No2lEXtvvhVzPSWPWkIBef8tjQSK09lo0fcdMk6zIKV8Vpdf7xTngu0Lrj6nn0FQlOxp+MbnsHfQk027jYKEOUzBGnPPYBYuMRED2W7oFYsvrwWG0A31SGwurD2kO/dw8/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B22C116B1;
	Tue, 16 Jul 2024 20:11:06 +0000 (UTC)
Date: Tue, 16 Jul 2024 16:11:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Dan
 Carpenter <dan.carpenter@linaro.org>, Thorsten Blum
 <thorsten.blum@toblux.com>
Subject: Re: [GIT PULL] ring-buffer: Updates for 6.11
Message-ID: <20240716161105.0aa6bfe1@rorschach.local.home>
In-Reply-To: <a71100aa-ffe4-477e-814a-1564e00cb067@efficios.com>
References: <20240716155118.152dea35@rorschach.local.home>
	<a71100aa-ffe4-477e-814a-1564e00cb067@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jul 2024 16:05:26 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-07-16 15:51, Steven Rostedt wrote:
> > 
> > 
> > Linus,
> > 
> > tracing/ring-buffer: Have persistent buffer across reboots  
> 
> Hi Steven,
> 
> Perhaps I'm missing something here, but we discussed previously that
> you would document the fact that users of this feature are expected
> to run the same kernel before/after reboot.
> 
> Looking at this PR, I fail to find that documentation, or in fact
> any documentation at all. Is this something that was overlooked ?

Hmm, was that for this code, or the one that used the reserved_mem
change, which isn't in this pull request, as it depends on the code
that is going through the mm tree.

Technically it can work with different kernels (I have even done that).
But yeah, it isn't guaranteed to work in such cases. But that is just a
documentation update.

-- Steve

