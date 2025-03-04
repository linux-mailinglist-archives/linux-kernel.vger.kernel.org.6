Return-Path: <linux-kernel+bounces-545290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60F9A4EB48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EAA17C1A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12E294F2D;
	Tue,  4 Mar 2025 18:03:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C427BF94;
	Tue,  4 Mar 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111404; cv=none; b=RcvAbIxB41mPql7J+XX/nQv5loVmZBqcdL8twlMf4rIjZ2e8ouyTq0OgaVo5KXQ+PDukzPn27NOT+T99CsIHTA5srJmAS4ys7v9LqtGjE7jqlSqqcRMgI3HOglXnlY/SbbIO4CFZJHAt/nhjfBq934drc62wX3/8DaDXZTxdMGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111404; c=relaxed/simple;
	bh=5FYXKy8jmyYUm2mDXzCgpfiwupitBejNaBYbizYrEZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kV3MKUeXyiCp3oazbf38rfvdgh9E6YspSytNudVylLxtRgqqpV2NbyBcoNr8JZPQUj7g6JziWWZXTKrPVO2dVLKkKVCwWA9C4pyzZyQzsTKlXtrr1psqIrm0B7p5CJwQQ/E1xh45xk1xdkLKNj1NPn6rjG66MNY8yA2L5S7ajbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5755CC4CEE5;
	Tue,  4 Mar 2025 18:03:23 +0000 (UTC)
Date: Tue, 4 Mar 2025 13:04:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Bharadwaj Raju <bharadwaj.raju777@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] selftests/ftrace: add 'poll' binary to gitignore
Message-ID: <20250304130418.31c32841@gandalf.local.home>
In-Reply-To: <a9628a00-2bf3-4d86-8e41-c596079cd8f0@linuxfoundation.org>
References: <20250210160138.4745-1-bharadwaj.raju777@gmail.com>
	<20250303183625.5acc59ec@gandalf.local.home>
	<a9628a00-2bf3-4d86-8e41-c596079cd8f0@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 10:49:12 -0700
Shuah Khan <skhan@linuxfoundation.org> wrote:

> > So it should go into this rc release.
> >   
> 
> Ooos - I applied it for next for Linux 6.15-rc1 since it is just
> a gitignore change and not critical.
> 
> If you think it should go into this rc, I can apply to fixes and
> send it for this rc.

No, it's not that critical. So either is fine.

-- Steve


