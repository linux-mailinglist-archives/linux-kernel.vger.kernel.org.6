Return-Path: <linux-kernel+bounces-534400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B04A466AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D2917E97B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C0721CC50;
	Wed, 26 Feb 2025 16:12:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA421CA00;
	Wed, 26 Feb 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586341; cv=none; b=bghO+2pZqb27R2jSud1qVNic/2IDhxAEwvxJbGlc4/m8EZaM4+ZPHVRuVLWkFOsNt2T/J4plriCfL34Y9+3XDRA16hHLehCpoE6GApIK5MKL+skhdRdrn1IPdWhx94HizXZ64P9kD1mZfxjFgL5p71q6Iyfnw/7ODuUrkhm6iuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586341; c=relaxed/simple;
	bh=ezZVDVPoqD1CODDNsl3QxjZWV9xXC08SKtHunsM9KEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtpOd0siA3Cg8eBIx5ve3yrZ6MRB5xsaWT4DHFvhmu4LM6QAMdFP6Xl5ASnI0pgNfApsB/uLPXHg0Pr+3BIIkxXPOkg+7cqkziw9Hdn5gdZgfy0m5mJUjQvdaU+DOUC550d6t5NrwlPastH5L0v10v91d005u8h1+N8n5yb/yD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B57C4CED6;
	Wed, 26 Feb 2025 16:12:19 +0000 (UTC)
Date: Wed, 26 Feb 2025 11:13:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Sven Schnelle <svens@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Let fprobe test consider already
 enabled functions
Message-ID: <20250226111300.5140fa9e@gandalf.local.home>
In-Reply-To: <20250226235447.7fab8051b2968277ce6920db@kernel.org>
References: <20250226142703.910860-1-hca@linux.ibm.com>
	<20250226235447.7fab8051b2968277ce6920db@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 23:54:47 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hmm, this ftrace selftests has been expected to be run without 
> any BPF programs... Is there any other issue on other test cases?

Unfortunately, systemd is starting to add BPF programs :-p

I noticed that my laptop has users.

-- Steve

