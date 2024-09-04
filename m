Return-Path: <linux-kernel+bounces-315579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C8A96C465
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E831C21BAD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D4B1CEE89;
	Wed,  4 Sep 2024 16:50:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD401DCB26
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468647; cv=none; b=Pq3AHX9BCYeXQrYZ6tJZtMD43G3peKc2ZSumY+PZ6WBQtBvffPDoGg4QFiaer+jjtfr3A4AaSUyFaNDC+5Aid314SoenwHOFNRcnfE/DPKYkw/kzcShqAFaBekfO121SDE4ye0Gl5qdWdZsh7zivbNt3tacVUxdWMWt/+dBNH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468647; c=relaxed/simple;
	bh=yOlvHXg4ZRl6OUgb3cfXljZuc3mFCsLbFV8ItrDuyLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXHTL4g6z1UTO8g8wP+/WLMN7L9cZL7gTpqEJBeB6k2+eckdippHJeUuwzgPgQkQCzjYd/yHAB/gEYsYHMEh7aA3ufMuxT33ZOnoyP7p/Cz9X8sjYQ2wUObNF97RLuzI8tXr9PF4Rei0d0v+bUi7c/L5YMKDtFQWBSd2VXrZeww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD619C4CEC2;
	Wed,  4 Sep 2024 16:50:45 +0000 (UTC)
Date: Wed, 4 Sep 2024 12:51:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, "Madhavan T. Venkataraman"
 <madvenka@linux.microsoft.com>, Kalesh Singh <kaleshsingh@google.com>,
 chenqiwu <qiwuchen55@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, puranjay12@gmail.com
Subject: Re: [PATCH] arm64: stacktrace: fix the usage of
 ftrace_graph_ret_addr()
Message-ID: <20240904125146.79859e7f@gandalf.local.home>
In-Reply-To: <20240904125000.4261b234@gandalf.local.home>
References: <20240618162342.28275-1-puranjay@kernel.org>
	<ZnHHHmEv-oqaXmq0@J2N7QTR9R3>
	<20240619124318.GA3410@willie-the-truck>
	<20240624161741.2a16d904@gandalf.local.home>
	<ZtCz2IiskUTVu6Xu@J2N7QTR9R3>
	<20240903160751.702f1f91@gandalf.local.home>
	<20240904125000.4261b234@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Sep 2024 12:50:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Ah, I didn't check to see if it was sent to linux-trace-kernel, so it
> > wasn't in patchwork, hence I forgot :-p
> > 
> > I can add it this week.
> >   
> 
> Actually, the code is in Linus's tree now, so it's probably better if it
> goes through your tree.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 

And you may want to add:

Fixes: 29c1c24a2707 ("function_graph: Fix up ftrace_graph_ret_addr()")

so that it gets backported with if that change gets backported.

-- Steve

