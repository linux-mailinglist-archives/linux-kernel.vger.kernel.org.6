Return-Path: <linux-kernel+bounces-238338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153ED924883
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A2A1C22664
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C27D1CE094;
	Tue,  2 Jul 2024 19:41:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F696E5ED;
	Tue,  2 Jul 2024 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719949309; cv=none; b=rHVL7t1GhUFottjhom7jf794lUlgiUnBsaLfZL24umbibOxQzHeIKVVPopbqa0YyyaynMo2VZgxGV4nKiI/sSRSuVhTdUVoI+jJK1sydozt/+pMAsUPuNtCPDkUJnraBAWSr5fvr5h9GM43orCF+M+H+pmh/16euLknwXHkvYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719949309; c=relaxed/simple;
	bh=quOm75f4d0jmhzpI2KIY6f6RpCy8CjJ0XUfSDP/koc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DV7Bjqz+o8t7CyBeSId2dVVud5wXfZb8nInGpTjBZKzl5AhX8eSZrqQYDE3oVGMNGJRxJqcYMeWyUqsXdFeEGWzOkZieWEa+NMeWtD3hOkjMqkqtaYFM5IOSppl+5OVNY7Ui7gFRnJjDuUMcytMqtF6QYeNouxiN3yTov8BGMHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8212AC116B1;
	Tue,  2 Jul 2024 19:41:48 +0000 (UTC)
Date: Tue, 2 Jul 2024 15:41:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, "Dmitry V. Levin" <ldv@strace.io>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: Have memmapped ring buffer use ioctl of "R"
 range 0x20-2F
Message-ID: <20240702154146.754e2ad5@rorschach.local.home>
In-Reply-To: <2227082b-381d-40bf-a106-eb789e433215@efficios.com>
References: <20240702153354.367861db@rorschach.local.home>
	<2227082b-381d-40bf-a106-eb789e433215@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 15:38:10 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-07-02 15:33, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > To prevent conflicts with other ioctl numbers to allow strace to have an
> > idea of what is happening, add the rang of ioctls for the trace buffer

Hmm, someone "rang an ioctl" ;-)

I'll update the change log before pulling this in.

> > mapping from _IO("T", 0x1) to the range of "R" 0x20 - 0x2F.
> > 
> > Link: https://lore.kernel.org/linux-trace-kernel/20240630105322.GA17573@altlinux.org/
> > 
> > Reported-by: "Dmitry V. Levin" <ldv@strace.io>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

-- Steve

