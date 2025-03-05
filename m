Return-Path: <linux-kernel+bounces-547151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D71A5037B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92AB3A2144
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D810D2505BF;
	Wed,  5 Mar 2025 15:30:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88424A067;
	Wed,  5 Mar 2025 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188613; cv=none; b=dCmzJx4x0f7ycMbSZZUMLOMwns+ftOrQMFPJ7fd48BbMzEGsZ6x5x+jMxMoOT8qkyGjV1BrO2DgR3fqFr1qDPxE65O6+S5x+xYS6z3gSVcj7y8Gku7Eqht1Qb+1WzZ845QFvhamBg1YoNqMWgl73/tMMiILEo+xR74yXzRiQ1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188613; c=relaxed/simple;
	bh=/C+McU4v1umcl0Ys6cBPzqL+uPU8wosa8nl6yfiPRZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Moejf1snI+tLEUc8K1dCfnIH0V5W4/AOSJPVn4WCHm69nU2unCT2U6g/ivqifgnl12AsIRf+pufPPaGIuWbShNdilf/tg0VmLQnV5wm1Ab9Rys174WBCm7uCqBiTUIjmCZKJ2Vb3vgYa6rSQD2hb3NrflRvfiVvVM/9vjCzXrOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DE4C4CED1;
	Wed,  5 Mar 2025 15:30:11 +0000 (UTC)
Date: Wed, 5 Mar 2025 10:31:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: Shuah Khan <shuah@kernel.org>, gregkh@linuxfoundation.org,
 corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, conduct@kernel.org, tab@lists.linux.dev,
 Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH] Documentation/CoC: Spell out the TAB role in
 enforcement decisions
Message-ID: <20250305103108.4943e301@gandalf.local.home>
In-Reply-To: <87h647yf8r.fsf@intel.com>
References: <20250304194813.11049-1-shuah@kernel.org>
	<87h647yf8r.fsf@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Mar 2025 11:54:28 +0200
Jani Nikula <jani.nikula@intel.com> wrote:

> 2/3 actually means 7/10 for the TAB.
> 
> Except two of the CoC committee members currently serve on the TAB, and
> will not vote. Assuming they will also not count for the total, 2/3
> means 6/8 = 75%.
> 
> All of a sudden you actually need 3/4 majority in the TAB to approve any
> CoC measures.
> 
> Perhaps consider using a simple majority instead? The numbers become
> 6/10 and 5/8.

I'm a TAB member but I'm speaking for myself and not on behalf of the TAB.

I rather keep it as is and not move it to a simple majority. If the TAB is
going to make a decision that may affect the ability of a developer to get
their work done, the issue had better be substantial where it should have no
problem getting to 75%. Ideally, it should even be unanimous, but there are
cases where a member may be involved, and decides to abstain.

-- Steve

