Return-Path: <linux-kernel+bounces-411340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 526729CF66B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48441B252A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B3153800;
	Fri, 15 Nov 2024 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SivHPTv7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D176F1DA23
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704105; cv=none; b=SWynVTgyaTpgD8OBaDQqSWcz0ISix9LinRDHweL2pP63kI8eosAx8yW3t/igsW2qO62tJPwj6ffbRp+wtfzZshDCYkewdjyjQ6t8JfYzVq6410pFn7tuhdbGd/80NUa83oW9ygJ25+zHqcHeXYivCYbOspz1Mp54B1lZW3DVvco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704105; c=relaxed/simple;
	bh=JqaGaa4vu+2We5DLOwGHmvuDksUulja8ThUNLcvTB4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azHx40bWR/upZypU7gieKArUJcGVycKSmogHhfRuvL4OOvLaMQ+TjX3Ygzs8eRvvhZr/MR4NM20IyfSn5UUF/1D224Vkj3XpNa2mcMlVFsDcQcTQoriGsjkIOAOiaXOo87xuYYZAZIn7ZyqYjn4cCc2blPLvwfe92jeVZcuZUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SivHPTv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FDDC4CECF;
	Fri, 15 Nov 2024 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731704105;
	bh=JqaGaa4vu+2We5DLOwGHmvuDksUulja8ThUNLcvTB4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SivHPTv7lgVNbV/6iOwRXTiGVxmRYmgVlWu2IvNM7DdqmQHApOB6b2t42gb+ku3FV
	 riNGW9glvQITZpvthdBckCDi1jz954ZqJdcLRkS2IImCNjbcJMWHgD8JeqVP5NOXvk
	 BEPdsZYNA7gXV4Lbk6QBaqtZcHEwhmpN+DK4GknYBPe+usagAF2KkhI1IdmUZsPRLy
	 qXOjfiJjkZ0zYwmvRfrlDOvfIrvxuZ85rF0OsuMl6OYFIO5wneqZs+11fLqjTMfq3u
	 gqmwhYttJ6CmoTIKxCUyrn8ZeUIMO9vCYVDGEu0I4PF316JlEEalWmVOPKXA7G2VgL
	 n5zmSHoq0d3bg==
Date: Fri, 15 Nov 2024 21:55:02 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: syzbot <syzbot+852e935b899bde73626e@syzkaller.appspotmail.com>
Cc: hdanton@sina.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] WARNING in posixtimer_send_sigqueue
Message-ID: <Zze1Jj4_pzOL1bzp@pavilion.home>
References: <20241115115401.3701-1-hdanton@sina.com>
 <673738b2.050a0220.1324f8.00ac.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <673738b2.050a0220.1324f8.00ac.GAE@google.com>

Le Fri, Nov 15, 2024 at 04:04:02AM -0800, syzbot a écrit :
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> security/apparmor/domain.c:695:3: error: expected expression
> security/apparmor/domain.c:697:3: error: use of undeclared identifier 'new_profile'
> security/apparmor/domain.c:699:8: error: use of undeclared identifier 'new_profile'
> security/apparmor/domain.c:704:11: error: use of undeclared identifier 'new_profile'
> 
> Tested on:
> 
> commit:         744cf71b Add linux-next specific files for 20241115
> git tree:       linux-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
> dashboard link: https://syzkaller.appspot.com/bug?extid=852e935b899bde73626e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c582e8580000
> 

Can you test on git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
timers/core instead?

