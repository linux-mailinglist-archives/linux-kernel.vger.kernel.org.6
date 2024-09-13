Return-Path: <linux-kernel+bounces-328234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAD79780E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB492882AF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6301DB52E;
	Fri, 13 Sep 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb1wk9wP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590FF1DA60C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233412; cv=none; b=a/DMrxRxJvU4ywiykHMLdeu9U7v5sXje4iJX9NT925/FYTOIZ1w/06sSfJ1SvyFstPPR/Jk6NUzfdCXWlkDs/KVj+sEuRMv93N6l4PqO+iWyOe2l79rQKP6jn9aeJnrQjbDzfqo09PF03+g3QL5qpX8sDXiXzWvgd/xwdlzRTCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233412; c=relaxed/simple;
	bh=1y+VxVlynQudx+ZTkKGfRlyrSPiuJAale0I5ihsuKFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFr7ipDuPm+DbbtDeHG/uETIIajoq7PYqEkkoQBsvJ6I3iH3EU6IN8jmxVzCTkLVDzpcFFT+Eu/p08v+WOBxnCnA7oThOvsINoTCXLrxBcPI15JO5drxKq4HqVAHPrNvt5btfGTqjjPvM3cZahJ0LmnoZ1r/WzMLVxyZYkcDsAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb1wk9wP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E395C4CECC;
	Fri, 13 Sep 2024 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726233411;
	bh=1y+VxVlynQudx+ZTkKGfRlyrSPiuJAale0I5ihsuKFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sb1wk9wPyVF+Fo1L8VBPbojal2vU8uPnUB6Ys9oKSqWloDDiVf9iYDD0bf3oEYaKO
	 rzPt2cPQArE4jonEKj1eGDGXgamj6camckS0Zl7bl4AY8wgHqgZ5BDcyOimSDtDGCr
	 cp4cRT/8I5ed9F/JHLD/YBl+tgmDRagWOmLlwHOsJOfgLlUv0Du9kxz4wQk8hFE+bu
	 nZquA36osAdcROsJxBI9TIEvmyXCt7IZjWLXzJ3TELW5EyMTPWwMryHlC9HdSvCuXw
	 o00v/k6rlWWDEJ/8+iwRPHFnjh+M7bwhb838iaofZgfmTQTVadhflVimpR6qYOJh0A
	 TbcSmTJvOfy6Q==
Date: Fri, 13 Sep 2024 15:16:48 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
Cc: hdanton@sina.com, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org
Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
Message-ID: <ZuQ7QIgAV2VkYjA-@localhost.localdomain>
References: <20240913121109.289-1-hdanton@sina.com>
 <0000000000007999780621ff7e3b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0000000000007999780621ff7e3b@google.com>

Le Fri, Sep 13, 2024 at 05:38:02AM -0700, syzbot a écrit :
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> 
> Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
> Tested-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com

Thanks! I'm cooking an updated patch with those tags.

> 
> Tested on:
> 
> commit:         196145c6 Merge tag 'clk-fixes-for-linus' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11ce10a9980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9e236c2f9e028b26
> dashboard link: https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=126610a9980000
> 
> Note: testing is done by a robot and is best-effort only.

