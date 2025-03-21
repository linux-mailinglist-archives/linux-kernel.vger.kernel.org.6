Return-Path: <linux-kernel+bounces-571708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1B9A6C103
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F2E18938B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFDB22D792;
	Fri, 21 Mar 2025 17:12:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94121EEA42
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577174; cv=none; b=rTW2PTbBX+dBWanCF2s8Ak0UM73z690oSaTEaeARsc/a5QuV5zHwTFSVj20kgsxgrXDa0XufGN+xDMVKHX/oYDvqR44E7Oezblr95R9GOVfgxpqS47KThQOuMaIdOmgWneBfDIdgbeqWdYAMgDlbuTEtxxoXOSK601tAzqCTSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577174; c=relaxed/simple;
	bh=gWUo9mbBRdf1NZz/7I6aUhu04loF9Al21mJsllVHFqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muBqd1e78hLpeN1AeqE0mLhPDYxI7Lga3ijMAiWObqaxIDY9HkwPf1G2UlyD8w54UYv2RGI/dUnbRuUgO0Ff5/FPMxWolQtVC/j++A3++FTsdDI+j6HZqf0za6qEsfqJZBfGdfu0ArOL93f31shEYYx1SKMI5IuHvTqDOzAG54c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99908C4CEE3;
	Fri, 21 Mar 2025 17:12:52 +0000 (UTC)
Date: Fri, 21 Mar 2025 13:12:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing: Disable branch profiling in noinstr code
Message-ID: <20250321131248.02114dd7@batman.local.home>
In-Reply-To: <871puq2uop.ffs@tglx>
References: <52a664ec9e14ef53c39c3d4fa400c2f1d29348c0.1742537096.git.jpoimboe@kernel.org>
	<871puq2uop.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 17:51:50 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> Though the real fix would be to rip out this likely/unlikely tracer
> hackery all together.

If you want, you could just disable it for all of arch/x86

In my tests, I'm more interested in the generic code anyway.

-- Steve

