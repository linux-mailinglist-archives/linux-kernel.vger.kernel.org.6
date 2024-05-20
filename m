Return-Path: <linux-kernel+bounces-184026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536B68CA193
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E604C1F21758
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7531C137C3F;
	Mon, 20 May 2024 17:52:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135913792E
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227579; cv=none; b=okGMDQSmwwDlorQ4HSxmcIW9BmYXc0ch/U3NaoVyC27mtK5UlklWwC6NCZJNXRbnu6hgWFm+xoUo5ueoCXuYfyFv+gAdzuctdYNnPOz1FOVjKPxFMhl1bfZQvw6p8f5pczybhD03ic1dkqCqntI0pEeIVtET7X7AxOZHYaHpAsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227579; c=relaxed/simple;
	bh=mALLh0cw442D6YySuumo4IOn32uNttmO/eVKSmIJsHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kED7MGiIMca8Hjy0f4Z8UeuSf2vZrUfuyspEe1GTW+DDMssmL/3DnE6j6ugDsDjuC/DQGfAs0HJrSMijpKMiYUB3hVIhJ9aehFhek1YoFOrz81a6xHv5c9SZaDdF9OQid/Z/BH+fg8JCtjtCANw3eT/AKWv4NRwaYQmr9YZRbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5F9C2BD10;
	Mon, 20 May 2024 17:52:58 +0000 (UTC)
Date: Mon, 20 May 2024 13:53:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ftrace/test_ownership kselftest fails in the second run
Message-ID: <20240520135336.73d40c8a@gandalf.local.home>
In-Reply-To: <CAK7LNARXgaWw3kH9JgrnH4vK6fr8LDkNKf3wq8NhMWJrVwJyVQ@mail.gmail.com>
References: <CAK7LNARXgaWw3kH9JgrnH4vK6fr8LDkNKf3wq8NhMWJrVwJyVQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 May 2024 02:34:50 +0900
Masahiro Yamada <masahiroy@kernel.org> wrote:

> Hi Steven,
> 
> 
> 
> If I execute test.d/00basic/test_ownership.tc in a row,
> it passes in the first run, and fails in the second run.
> 
> 
> I observe this on the Ubuntu 24.04 (6.8 kernel),
> and also on the latest linux-next (next-20240520).
> 
> 
> Is this a limitation of the test or a kernel bug?

Hmm, that should have been fixed with this pull request:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e92b99ae8216dec2566711dae0a9b7b47591e315

Let me know if you have that, and if so, please send me your config.

Oh, and make sure that you have the latest selftests running too.

Thanks,

-- Steve

