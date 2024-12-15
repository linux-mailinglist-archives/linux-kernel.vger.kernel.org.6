Return-Path: <linux-kernel+bounces-446294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3E59F223D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C237A1109
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC16C8FE;
	Sun, 15 Dec 2024 05:11:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749138BE5
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734239471; cv=none; b=gaw+aNUZ3aGtBSdeUbE3nLcnjyaHkXffFxNEXULp2GboRNssN8L75q2L49Qp8zV9NsynRle+RsNS/zBCtbJFYjdE8JlQJsu6Qo4obobojfwQ/O7dLW8+5A2A0eSD2XGQuD2yWfotz/F+Bk+wL7HrFM4HnGprJaH+HcjFcKe75Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734239471; c=relaxed/simple;
	bh=V+PePkb/CaRfyobXVftA63QVt26Bvv+5zHHr5zAMowQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5A5I9WE/19iSPlSV86MeOuLbYV0MCXMFUI6ZJN1iFBY3ymMxarAF6Z0d/BQU489Hz+9T9JIJttjgii47CEc3QpiZ2EJvulMhxKjb3SKgxmwaZaVSzIwxNKp1pOcn5wITSWfVHv4K5R0mJdnpRnhMVPOVaeytehTWSOgdNuua+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2E3C4CECE;
	Sun, 15 Dec 2024 05:11:09 +0000 (UTC)
Date: Sun, 15 Dec 2024 00:11:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241215001139.06434987@gandalf.local.home>
In-Reply-To: <20241215000522.227f26de@gandalf.local.home>
References: <20241214182138.4e7984a2@batman.local.home>
	<20241215044843.GC1977892@ZenIV>
	<20241215000522.227f26de@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 00:05:22 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'll have to resend this pull request anyway depending on the outcome of
> the first commit.

Which will likely have to wait till Monday. I'm going to bed now and
tomorrow's my wife's birthday. We are going to do some wine touring.

-- Steve

