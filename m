Return-Path: <linux-kernel+bounces-563951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FADA64AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C35172C59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807F8233720;
	Mon, 17 Mar 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hhk3kSc7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+3D+tPM+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hhk3kSc7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+3D+tPM+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663CE1C6FF0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208450; cv=none; b=LhjlIbO8e5tDQddi0/swMVNHAnIYnC3PpXZrOYf9zOPdV/FmZ/nm6onYx1+q4XSzw6/6c2SysQwc2gLiCRHZ/w574iZ5NpbSMbqqOQjcF/4o7/iNwR7J1qyH7Q3XPwzF/Enk2UxAl3Na2tWkFyClQ0cefhdldwUfYNQ8GUOX50E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208450; c=relaxed/simple;
	bh=/OuUF7rJmyCOHVd//50NuL2eJpKoPuIOA06s+X8Ybzw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sGMvKJpdyubc0KGQOWKeBLintpWebUPm7zQaGV1DMx9bkHvshM9U81T0jQIs6eyWP+iro+7A2xLve/jA59Araz2TSeXChKwKTb/X/gTq5akAIFr+pMQo0TujcIiV/ver6Vy73jDd49oNpk/uyPFZ2LKTELcJx3EnpqZ5dU1hDOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hhk3kSc7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+3D+tPM+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hhk3kSc7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+3D+tPM+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6523521242;
	Mon, 17 Mar 2025 10:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742208447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p7eSlEMeY+VEfLS6gjYkEltEQIBcRRAhJM3thCxjM+E=;
	b=Hhk3kSc7/j34UEDCEwalseHIxcuHNpa+eZFz3tHf+Y5EOU2WH4yHpHQEoTC7ITdhqXRvGE
	SjntIoaZBC1xIo4tWSWRMPO7UDfK1RabHMKxcr9gX29ggJB1VG7pM7vdHY6WCjUrZDXRMH
	ZZzZMqaqBdJEn4BPw5vl23uUL4850Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742208447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p7eSlEMeY+VEfLS6gjYkEltEQIBcRRAhJM3thCxjM+E=;
	b=+3D+tPM+vE9HP4J8GIMoxDYgjCSgknsIqgffo60K8cfEbPzU+w6LkXUyOSpw5W0yvVNDdJ
	3awsinsPxRXZHNCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742208447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p7eSlEMeY+VEfLS6gjYkEltEQIBcRRAhJM3thCxjM+E=;
	b=Hhk3kSc7/j34UEDCEwalseHIxcuHNpa+eZFz3tHf+Y5EOU2WH4yHpHQEoTC7ITdhqXRvGE
	SjntIoaZBC1xIo4tWSWRMPO7UDfK1RabHMKxcr9gX29ggJB1VG7pM7vdHY6WCjUrZDXRMH
	ZZzZMqaqBdJEn4BPw5vl23uUL4850Ug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742208447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p7eSlEMeY+VEfLS6gjYkEltEQIBcRRAhJM3thCxjM+E=;
	b=+3D+tPM+vE9HP4J8GIMoxDYgjCSgknsIqgffo60K8cfEbPzU+w6LkXUyOSpw5W0yvVNDdJ
	3awsinsPxRXZHNCg==
Date: Mon, 17 Mar 2025 11:47:27 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, 
    Brendan Jackman <jackmanb@google.com>, 
    Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 01/13] x86/traps: Make exc_double_fault() consistently
 noreturn
In-Reply-To: <d1f4026f8dc35d0de6cc61f2684e0cb6484009d1.1741975349.git.jpoimboe@kernel.org>
Message-ID: <alpine.LSU.2.21.2503171147090.4236@pobox.suse.cz>
References: <cover.1741975349.git.jpoimboe@kernel.org> <d1f4026f8dc35d0de6cc61f2684e0cb6484009d1.1741975349.git.jpoimboe@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.978];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 14 Mar 2025, Josh Poimboeuf wrote:

> The CONFIG_X86_ESPFIX64 version of exc_double_fault() can return to its
> caller, but the !CONFIG_X86_ESPFIX64 version never does.  In the latter
> case the compiler and/or objtool may consider it to be implicitly
> noreturn.
> 
> However, due to the currently inflexible way objtool detects noreturns,
> a function's noreturn status needs to be consistent across configs.
> 
> The current workaround for this issue is to suppress unreachable
> warnings for exc_double_fault()'s callers.  Unfortunately that can
> result in ORC coverage gaps and potentially worse issues like inert
> static calls and silently disabled CPU mitigations.
> 
> Instead, prevent exc_double_fault() from ever being implicitly marked
> noreturn by forcing a return behind a never-taken conditional.
> 
> Until a more integrated noreturn detection method exists, this is likely
> the least objectionable workaround.
> 
> Fixes: 55eeab2a8a11 ("objtool: Ignore exc_double_fault() __noreturn warnings")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M

