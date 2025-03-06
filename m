Return-Path: <linux-kernel+bounces-549641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8FBA554E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489FD167A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706425CC96;
	Thu,  6 Mar 2025 18:26:06 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151913D509
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285566; cv=none; b=p52iQ/e2fCDG8J05q3YpAU50u2JL3mR4QRElDUxV6/NlO5NmW5syfEyTZcBPSIAlDPC7fupGXH1TfkpkCOY+C1DYPdFxiVIdQDn0OK2IGrvHmOIIQ4mqqyVkQyyeJRN5ZAkeZungLaghmHD+np5z0Vw0J7Dh68eT9KK4kxwqVgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285566; c=relaxed/simple;
	bh=BkibElEiOWuR0hTTh6VYRN1SX9HUX6x4eWUjtp46PYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJj2TgwTR9Asu8VbjDYNpA082pZe/ZA278jZXPdrgf2YaG+aHyWGvEdKAt9KgonRzRmhUq2j10UFjYHVVUNRskMLEYTQB2ALosKroFiYuQnGoe6uqhaDsC/Ekz6Pv1QZUgyRS6+Lnjs03Q+hu/rTuYpBWMDmkNjiYCeXdkYpOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4404C4CEE0;
	Thu,  6 Mar 2025 18:26:04 +0000 (UTC)
Date: Thu, 6 Mar 2025 13:26:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 0/3] tracing: Updates for v6.15
Message-ID: <20250306132605.4cc45349@gandalf.local.home>
In-Reply-To: <20250227001235.355892523@goodmis.org>
References: <20250227001235.355892523@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 19:12:35 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Masami Hiramatsu (Google) (2):
>       mm/memblock: Add reserved memory release function
>       tracing: Freeable reserved ring buffer

Masami,

I'm going to revert these two patches from the trace/for-next tree and
rebase them on top of the ring-buffer/for-next, as they conflict, and I
rather not send Linus a pull request that has conflicts between two of my
topic branches.

-- Steve

