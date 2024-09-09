Return-Path: <linux-kernel+bounces-322039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9CF972327
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A8A1F259B9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F087189F58;
	Mon,  9 Sep 2024 20:06:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A226189F33
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912402; cv=none; b=FBIQffnSZM+5g5jQMFXW2X2nYxv8kKHOTkXwkvb5gLZFC6CbBZEGZbyG12sYeBW+yWrerTc/MjDP//RIECjo7/4NE+GKkWeaUyGb6cXMg+KKqXmuf6fvX4CKxf27C+7EOajcvD40g1ochnWiApKH9fkHO7axIx9SmsMMDCdaEVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912402; c=relaxed/simple;
	bh=5H678IL5QNH4ewNzDLJrDTWhigMMpNFk3rOWSurRlus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H9z5ikuQAmeMHzyXkBbBL1BF2C+ZXLJ/sFUM6+y8gP0dA51PscLeF7Z6ot9Mgko9QBcDR29r4RYjYj20NuICr44qzI8PHEg8/0nb1PGe8p4mBHqGjIQ40qqCRTy3/PQDSdh0vjTvHFmO8raAfHOLJRPs3gC5ZV3gnQfnATChE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBB0C4CECA;
	Mon,  9 Sep 2024 20:06:41 +0000 (UTC)
Date: Mon, 9 Sep 2024 16:06:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-linus][PATCH 0/2] tracing: A couple more fixes for 6.11
Message-ID: <20240909160640.45be50df@gandalf.local.home>
In-Reply-To: <20240909155537.7de3ed82@gandalf.local.home>
References: <20240909195035.533786334@goodmis.org>
	<20240909155537.7de3ed82@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Sep 2024 15:55:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Looks like my system upgrade broke quilt, or at least the send mail portion
> of it. It went into an infinite loop sending this, and I had to kill it :-p
> and it didn't send any of the patches.
> 
> I'll go and see what broke.

Although this is the first quilt sendmail I did after an upgrade, it wasn't
the cause of the breakage. One of my Cc's was missing a '"' where the email
only had one of them and that confused quilt.

Will send again. Stay tuned.

-- Steve

