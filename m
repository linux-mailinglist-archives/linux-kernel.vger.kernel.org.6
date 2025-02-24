Return-Path: <linux-kernel+bounces-529772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4A6A42ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A4E189B112
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFCA264FA4;
	Mon, 24 Feb 2025 18:10:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A17BAEC;
	Mon, 24 Feb 2025 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420617; cv=none; b=nJjFgZKHlb3pVOMVzSk0dhmTdrxP6v6ki+NxMsixQE8mV++gp4JQgZ6UTNZh5E3EyMFP7nCzHUD1L5t0hwl4JEvT3B+hOlKPKbVY1y4gwUJog/2xukpBLkFFoLmQNPv3GDkQT+fL+BWJxDUrqR0iVoFJpZaALBVR4q6r/o6zO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420617; c=relaxed/simple;
	bh=OqKqBHmdPsL821TINa8fHGXo/VWyezhWxXOYmuTumSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRzvpEiTYBEWNysk+TRPX2eWM3GXoBPbBWyDdsFh2Ii/ZXy5u6YWNoH+HDh8V3ifuqsR9bX30fnpj76ZOz2engzMcS79J4lgEUFB2Lu8VrMVRGpQP5/dZL6Pp/Dsp4P0h6dAjUxTWcYvvPOnwONAscYmKt0nWth6b8b9+BZD+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E07C4CED6;
	Mon, 24 Feb 2025 18:10:13 +0000 (UTC)
Date: Mon, 24 Feb 2025 13:10:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Crash on named histogram trigger with invalid onmax
 variable
Message-ID: <20250224131049.3a4d8945@gandalf.local.home>
In-Reply-To: <CAP4=nvTsxjckSBTz=Oe_UYh8keD9_sZC4i++4h72mJLic4_W4A@mail.gmail.com>
References: <CAP4=nvTsxjckSBTz=Oe_UYh8keD9_sZC4i++4h72mJLic4_W4A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 16:22:39 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

Thanks for the report.

> I'm not familiar with the trigger implementation. Do you have any
> ideas on why the hist_unregister_trigger fails and/or a fix?

One day I would love to rewrite the trigger code. It's really convoluted
and not easy to follow. I'm constantly trying to remember the workflow of
it.

Anyway, I'll dig into this.

-- Steve

