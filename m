Return-Path: <linux-kernel+bounces-236629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5A091E522
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8207281307
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BBE16D9DD;
	Mon,  1 Jul 2024 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9YH8Quu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8856813C908
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850803; cv=none; b=BlZpX5+4DDRUhm/6no0DscCVqj7g+JDyvGHITqOdOv7KHJ6oknJfvnmiR3okXJbEDxV238qgR/D+2E68EmdVoqNmpqKonPlBEvtUK8hP0oXIzWDDHXQYAqL+P57Me5lux0TrRP2cpjhyoc5Te0+HgFlJ8mofLWqNxi+uXZOvrDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850803; c=relaxed/simple;
	bh=6v5gXKcxmjcxQ4439qKhy37oGLZvAmn2mPc6DIj+XTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdlSeu+4Z6iPmNnIThneH4YCWknbMq9BA9dszB6xaVFo/D+ARVDSsYM8fweWGEQRdrMS1ppUj58Em6pJZMdgQvCtKuXswTOScgzBl2dxAYIze1OaKkJzhkywsms60fdtQk98vrAUy+8jEdepT2K3iJy3hldlfbWz3otarMkCUwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9YH8Quu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22574C2BD10;
	Mon,  1 Jul 2024 16:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719850803;
	bh=6v5gXKcxmjcxQ4439qKhy37oGLZvAmn2mPc6DIj+XTk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=F9YH8Quuq0khYdkNJTxjDF/vRfVki8fcUL947x+poUBYjck3hqLKf3Majz4LDUnxv
	 LamBwmSkMqL9KujM5XsbOQ3MGdG1evCFAAqZnX08vnQNPONWLysVKr4dcE++gRBWtN
	 hC5NNant63Di7M3jYp8kKfiKTMHrr7rbCHYr5HIKz3bCvP40JJEmQi7n8jifTBL1rj
	 IVYufhKbwRKYsIC/6opqht2ERQ2YkyjmTVbGjoUgqHwXrwd9qKYl4F4Y1Ji/25UKpV
	 /TXZKifCl0XjHqLZu6DSl0FQ3QmI8Z+/bE3u+0ykdBXySmAvgYpXvgpqRkuZ2VIQ6o
	 Ccfjr9/UmhPUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C240CCE0AD3; Mon,  1 Jul 2024 09:20:02 -0700 (PDT)
Date: Mon, 1 Jul 2024 09:20:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: ahmed Ehab <bottaawesome633@gmail.com>
Cc: boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: lock classes
Message-ID: <6be3513e-67d8-4ead-b44a-e6dcdedfeaab@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+6bSauVVgprKxB3f=Dgo0p5ZN0cyRAYATzGOe6CgsJ=Ai0trA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+6bSauVVgprKxB3f=Dgo0p5ZN0cyRAYATzGOe6CgsJ=Ai0trA@mail.gmail.com>

On Mon, Jul 01, 2024 at 03:52:44AM +0300, ahmed Ehab wrote:
> Hello sir,
> I am working on a bug reported by syzkaller
> https://syzkaller.appspot.com/bug?extid=d4200fc83fa03a684c6e . I am getting
> 2 classes with the same key but different address for the name(different
> name pointer but same content). The problem is that this info seems to be
> persisted in the vmlinux itself. Is there any place where I can read about
> how lock classes are persisted or something?

Hello, Ahmed,

Adding Boqun and the list on CC in case others have better advice.

One possibility is that there is a lockdep_set_class_and_name() call
that is separating out locks that would by default be in the same
class.  See the use of this function in the rcu_init_one() function in
kernel/rcu/tree.c for one example use, in this case to create separate
lock classes for each level of the rcu_node tree.

There are a number of similar functions, including lockdep_set_class()
and lockdep_set_class_and_subclass().  These guys might well duplicate
the name, but I have never used them.  Me, I encode the level into
the name in order to have better lockdep diagnostics, but that is not
always practical.

							Thanx, Paul

