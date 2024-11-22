Return-Path: <linux-kernel+bounces-418771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED99D6580
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86A5B21E76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B23F18DF92;
	Fri, 22 Nov 2024 22:00:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753318BC13
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732312821; cv=none; b=DeH5rHaLYnjVquZucu+rmPZKLL/tKfRNvvVltHy3AeNT5pskmc9yABre5x2+SpFx8ecNWs+4dVcfjYhr7b3TRdW0GHPnrWKWfccy3AFDIdfakw6fDVz0V3I8fWTLR+wYEtWF0khzXDew1YvjTKhergF48Oidy3ouYZX8BzIbnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732312821; c=relaxed/simple;
	bh=mXykb8t25IkU381GDlxJFurBUSYDvghpm0nZ+9EqVcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+Eh+SGmDTmkbqciLzQQ906h7OFSxIaTyjDt+K7Lt2NR8TklxMKUJO0FbSLnjeyMofJMpq4mI4jGTTvlZwbh5p3y1RWBu15Mokdk44QVj8inKbC0+EeOXCZjrSlBlQZ61T/vbtIVw0jFPb1fIp/01qozlSp+blP1K+9JaMXzUd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5126EC4CECE;
	Fri, 22 Nov 2024 22:00:18 +0000 (UTC)
Date: Fri, 22 Nov 2024 17:00:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Colin Ian King
 <colin.i.king@gmail.com>, Jeff Xie <jeff.xie@linux.dev>, Jinjie Ruan
 <ruanjinjie@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Justin Stitt
 <justinstitt@google.com>, Levi Yun <yeoreum.yun@arm.com>, Li Chen
 <chenl311@chinatelecom.cn>, Ryan Roberts <ryan.roberts@arm.com>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Tatsuya S
 <tatsuya.s2862@gmail.com>, Uros Bizjak <ubizjak@gmail.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>, guoweikang <guoweikang.kernel@gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.13
Message-ID: <20241122170057.051b754f@gandalf.local.home>
In-Reply-To: <CAHk-=witPrLcu22dZ93VCyRQonS7+-dFYhQbna=KBa-TAhayMw@mail.gmail.com>
References: <20241120214531.45d75a60@gandalf.local.home>
	<CAHk-=witPrLcu22dZ93VCyRQonS7+-dFYhQbna=KBa-TAhayMw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 13:54:49 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I have pulled this, but I expect this horror to be fixed.

Thanks.

Mathieu,

Care to send a patch to address Linus's concerns.

-- Steve

