Return-Path: <linux-kernel+bounces-426535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF09DF484
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 04:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052ABB210E4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 03:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF861CD3F;
	Sun,  1 Dec 2024 03:39:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF6F23A0;
	Sun,  1 Dec 2024 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733024380; cv=none; b=LoxpFTnpujYG2Zbl3d61irbu0q4tAeAMGPaQnu+i6J5H3HQlz2RMoTEP8378k6jO/Lyjpt0DkhA0dx0UVboDxsEtuC9+YHk0vJlc2zHHV8dFQ96paaPHgsHHAcdljpzKd3BtAj50HyOiiM8u92VSBYa5Yv7hIbxOXCsxc1TCLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733024380; c=relaxed/simple;
	bh=pJeWjRH3V5ACGqvk72629eM8VNaK09pQPsE6GGX38lU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=msQnAdLk/Uyt/9hNQHt66C9nz6AfDZHmwGH/myxBPppBsJb414XOBvdYSqNCkOCv3FqvRg2F+fcvWKJWWIN35bgDBLLExt9vpEFk70U1qhXyNwXgSjAEfyg6fmGkTqeQUhCB/oNm0g6+rshFLIRuVs3ikarKRG2RmmiSc6CCrBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A25C4CED8;
	Sun,  1 Dec 2024 03:39:37 +0000 (UTC)
Date: Sat, 30 Nov 2024 22:39:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Petr Mladek <pmladek@suse.com>, kees@kernel.org, andy@kernel.org,
 akpm@linux-foundation.org, linux@rasmusvillemoes.dk,
 senozhatsky@chromium.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printf: Remove unused 'bprintf'
Message-ID: <20241130223936.136b2f1c@rorschach.local.home>
In-Reply-To: <Z0vOVRcZQir0cjjo@gallifrey>
References: <20241002173147.210107-1-linux@treblig.org>
	<Zv5SLrKeQIpWnhsS@pathway.suse.cz>
	<20241003111346.0654f1ac@gandalf.local.home>
	<Z0vOVRcZQir0cjjo@gallifrey>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Dec 2024 02:47:49 +0000
"Dr. David Alan Gilbert" <linux@treblig.org> wrote:

> > > suggested at https://lore.kernel.org/r/20241002104807.42b4b64e@gandalf.local.home  
> > 
> > Yeah, since I'm basically the only user of it, it's best it goes through my
> > testing.  
> 
> Hmm, did you pick this one up?

Sorry, it wasn't in my patchwork and was missed. I can add it and Linus
may even take it after -rc1. Or I'll have it in iinux-next for the next
merge window.

-- Steve

