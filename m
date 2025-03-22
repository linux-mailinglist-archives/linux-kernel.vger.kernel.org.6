Return-Path: <linux-kernel+bounces-572318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB957A6C905
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 11:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A566E1B6279B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 10:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEB31F5830;
	Sat, 22 Mar 2025 10:14:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DC51F5438
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638469; cv=none; b=QAAFlre6Ha3Xutl5vuS+rCI1d6gdfxikBuCdQ5e2/ckM68d8hIJUNahTjFUJheLM4OtXPyDtYGjO41yAwxUitoqDj7ZOc3bJGPD+Oy4W7Qs7v0v5/Wvya1J/4oUIU786MOmvYgdLlhgMz3GzksaM8K2Egju8qS/hrDUyuVw8MQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638469; c=relaxed/simple;
	bh=mZi8xDtj9Ulb2p6EqnPEnR1PSP099gr/qXbaJZ1EUZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKZm1jOwDCjyzqxe9GcJ58VyL0nikPm1J7xXTgI82DKCVkQ6doiXCSZeqxUf+u1iEac62vl+4J3H+bMq6v8xwjgTgJhLW98wi5CfmFHUq6rnPYILPzcflbfRFzVIUNG80w9uYIN1rFV3JebEt4388nXfIeiDVwW+HDEBgAKtrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F786C4CEE9;
	Sat, 22 Mar 2025 10:14:27 +0000 (UTC)
Date: Sat, 22 Mar 2025 06:14:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] Scheduler time extension
Message-ID: <20250322061422.2b24f021@batman.local.home>
In-Reply-To: <821926D8-ABED-4B66-9E2D-39594DB82FA1@oracle.com>
References: <20250215005414.224409-1-prakash.sangappa@oracle.com>
	<20250217120000.5ae1201a@gandalf.local.home>
	<821926D8-ABED-4B66-9E2D-39594DB82FA1@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 16:10:09 +0000
Prakash Sangappa <prakash.sangappa@oracle.com> wrote:

> How do we proceed on this feature? 
> Are we leaning towards enabling this feature for SCHED_OTHER only under PREEMPT_LAZY?

The merge window is about to open and I'm way behind in what needs to go in.

Let's continue this discussion after rc1 comes out.

-- Steve

