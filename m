Return-Path: <linux-kernel+bounces-227888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634BD9157B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D6D1F213DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A551A01B7;
	Mon, 24 Jun 2024 20:16:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0981CFBC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260218; cv=none; b=QqEfg2AM/xbHzWDbQxYaAyYyuGidNjV5JuICzcwK4QIr+punOgBoTlTNtfjOZgXf4MWOPImvkPo5bL6MTAjTlPAdK6+jVVWBlxNjl9CkEp4YFb3ddr7b8b8aTErTwmWKc35MUg/a+NgeuAmLRJjSvFPW0iq/7iW91oPszdDIVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260218; c=relaxed/simple;
	bh=XTI/FVMx8GFMcjGcOqQfFMRSXXYMMS4KKSZk0E0FAv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEMMJESFILKxkkYQ7aC9kK7vMCrFlSPDldIrsXJxoxW7qtEnKglfWP9a1GTpiTOuFCEA2AfciRmEhPi05cFQXeLU7uH0slhhARmCYrzNr02Ra/dRk1+G4tCXR+c3nbcePqWcur19kEjdCYJDNz5rClRNxNlGkBMJCjqMLLHgYJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC986C2BBFC;
	Mon, 24 Jun 2024 20:16:56 +0000 (UTC)
Date: Mon, 24 Jun 2024 16:17:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Puranjay Mohan
 <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, "Madhavan
 T. Venkataraman" <madvenka@linux.microsoft.com>, Kalesh Singh
 <kaleshsingh@google.com>, chenqiwu <qiwuchen55@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 puranjay12@gmail.com
Subject: Re: [PATCH] arm64: stacktrace: fix the usage of
 ftrace_graph_ret_addr()
Message-ID: <20240624161741.2a16d904@gandalf.local.home>
In-Reply-To: <20240619124318.GA3410@willie-the-truck>
References: <20240618162342.28275-1-puranjay@kernel.org>
	<ZnHHHmEv-oqaXmq0@J2N7QTR9R3>
	<20240619124318.GA3410@willie-the-truck>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 13:43:18 +0100
Will Deacon <will@kernel.org> wrote:

> > Catalin, Will, do you have any preference?  
> 
> I think it makes most sense if this patch travels together with
> 29c1c24a2707 ("function_graph: Fix up ftrace_graph_ret_addr()"), so that
> would be via Steve's tree. In which case:

That makes sense to me. I'll go around pulling in all the updates to the
arch code here (with the respective acks).


> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks,

-- Steve

