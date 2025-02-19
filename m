Return-Path: <linux-kernel+bounces-522283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6515EA3C840
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79AF9189754C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACAF215052;
	Wed, 19 Feb 2025 19:07:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31101BC099;
	Wed, 19 Feb 2025 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992078; cv=none; b=QtnsJUuVK/lkDv6XPKrhfhnSY5S44Cv/07eYNy6KKe027h4au7pSvv4p7bX3gWJUzZ2ZzUnzUt2a6PIrvsBXz6AU8q1xjsJkPSSyg7/4EKfJVNYq1szft2FxryFf/5lRi7Y8Eq0r+7vL/Qxs/NG0N6l95wRbzMXkbOEX/sU9fhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992078; c=relaxed/simple;
	bh=IB6R0kSolfUFF74TX4+haMwCWlvitsr3jKi1oIc0R0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ftgqbz3r7HU88glEQRdsBKNC6wfdEJRR1L30zOlgks8QXxE8TjxTyxKp9+dA6dH/WpXB4zqtSz3RIP0RRiRAXgTMuZhSFPmuJknZG70wuG7K/OJCu8y+1VbGt6tL1HFXdskG1eop/FnNNYEnpgCgPVOh/N1Sb6aGQhZtPjljxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7CDC4CED1;
	Wed, 19 Feb 2025 19:07:56 +0000 (UTC)
Date: Wed, 19 Feb 2025 14:08:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Greg KH
 <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250219140821.27fa1e8a@gandalf.local.home>
In-Reply-To: <202502191026.8B6FD47A1@keescook>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	<Z7SwcnUzjZYfuJ4-@infradead.org>
	<CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	<202502191026.8B6FD47A1@keescook>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 10:52:37 -0800
Kees Cook <kees@kernel.org> wrote:

> In other words, I don't see any reason to focus on replacing existing
> code -- doing so would actually carry a lot of risk. But writing *new*
> stuff in Rust is very effective. Old code is more stable and has fewer
> bugs already, and yet, we're still going to continue the work of hardening
> C, because we still need to shake those bugs out. But *new* code can be
> written in Rust, and not have any of these classes of bugs at all from
> day one.

I would say *new drivers* than say *new code*. A lot of new code is written
in existing infrastructure that doesn't mean it needs to be converted over
to rust.

But that does show why enhancements to C like the guard() code is still
very important.

-- Steve

