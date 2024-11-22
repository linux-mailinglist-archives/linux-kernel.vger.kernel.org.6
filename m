Return-Path: <linux-kernel+bounces-418778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F19D6590
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AFB7B226DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D785518B47C;
	Fri, 22 Nov 2024 22:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PlfiMO1q"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D21DA5E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313627; cv=none; b=iLLn2y3kgn851Zr5AQqcXc21GCpzb5+SYW1wTnOfG8cofiz/RPWDatwaomdprU4R0UYYhPEvMpJGSnIeqa2FLeKtrq8brEKSlQTIiZSGFC41ZFGV84s71ut35Q1QjrK0Zt0XeHhWp90on1ejzwwTHdnklyLL1as744Clbulp4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313627; c=relaxed/simple;
	bh=pN0AD3uucd3wOWsi9N89e2QMgVvHMUueVhvR2ZxEeBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+M3R64Bj3gfjPC+7lwWDmJh29sOiEHWo987Fk3hSFr+GT11RHTnuM6a6quaPLNfMBGw+bujBngABWGZj3RNhpTGnqT2bQHbiMEY5vfjzD2wrm69lFNJ17M1hE/V6N8/zV0370e3cu7/xhiISFSRHo2L8htjTg10yt9h/mBc5GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PlfiMO1q; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732313622;
	bh=pN0AD3uucd3wOWsi9N89e2QMgVvHMUueVhvR2ZxEeBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PlfiMO1qKQRjiez9yoXl9n2pUInkMwkzgAe1jupW6WAdFk+ku2IbcDL/kVDRo6Map
	 7iFRwngiu4hI7RakYKbARD8WDEJR8bGCgq+/jr7XP0FAXE7abJCx3JkqT7u+3uDOUH
	 TxszKEx0I73BJpyjaqoAb5mroIECIL2dj+LSsYW2ahhY/rbaYlVY4Dr5EeBZq1tqP4
	 2bDtjvHA2DT/XIRk+o5I4o+bd1rJZx6w1VmCzBE9zu44yR8Q04XUyQ5xK1/aiZqyPt
	 iuCdXrjFJXhqFKqds3rHO3nFc67yP8CQwvtLFZq+TnbNIUgb0yBP6VORf1TRIRVbFZ
	 wpmi9NflpwIxA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Xw8WV33J1zMcv;
	Fri, 22 Nov 2024 17:13:42 -0500 (EST)
Message-ID: <5f8d128b-9007-4eff-bf98-e56603469130@efficios.com>
Date: Fri, 22 Nov 2024 17:13:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tracing: Updates for v6.13
To: Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Colin Ian King <colin.i.king@gmail.com>, Jeff Xie <jeff.xie@linux.dev>,
 Jinjie Ruan <ruanjinjie@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Justin Stitt <justinstitt@google.com>, Levi Yun <yeoreum.yun@arm.com>,
 Li Chen <chenl311@chinatelecom.cn>, Ryan Roberts <ryan.roberts@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tatsuya S <tatsuya.s2862@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
 Zheng Yejian <zhengyejian@huaweicloud.com>,
 guoweikang <guoweikang.kernel@gmail.com>
References: <20241120214531.45d75a60@gandalf.local.home>
 <CAHk-=witPrLcu22dZ93VCyRQonS7+-dFYhQbna=KBa-TAhayMw@mail.gmail.com>
 <20241122170057.051b754f@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241122170057.051b754f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-22 17:00, Steven Rostedt wrote:
> On Fri, 22 Nov 2024 13:54:49 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> I have pulled this, but I expect this horror to be fixed.
> 
> Thanks.
> 
> Mathieu,
> 
> Care to send a patch to address Linus's concerns.

Sure, I will prepare a fix.

Linus's concerns are clearly expressed and I missed that they applied
to __DO_TRACE() as well the last time.

Sorry about that!

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


