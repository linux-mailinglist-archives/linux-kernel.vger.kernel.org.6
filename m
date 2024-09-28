Return-Path: <linux-kernel+bounces-342633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E32989115
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 21:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510D31F21B46
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162E815B54F;
	Sat, 28 Sep 2024 19:12:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138F143895;
	Sat, 28 Sep 2024 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727550736; cv=none; b=gqG9zn/ssvC8WUE9FXyImyu1CPwM/gFcwcBFhWZCqmHhO39+EBmSma9NTy3xSXDSpNZC5Yq4llYUDkyrj1p/FvfLrZ+FpuLFrL2JAbgQVpiYlDkE/vn7frjgJ0CSiKMQj+IdVRfhsNIp1vAMqeB2oa48vEFEJPRbfZ2z7cOgBJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727550736; c=relaxed/simple;
	bh=TLKcgzzq0TVPXoReh6ESHDGOK/RIg7QAiXOs4lVUKrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uV4BoIuJ5yC3o7x3fz0a1u93HeqXLIwe2snvgNNTRtiRIrV5tNRB3lUg5uWSIcJZyIDRYD+MuG/n2238HbfX1rpkvsXhugr/1y+Alf+PJILiG4isqU2IaNJYcCfKQ6PtnO6TE0WznNZQnCD8/V3atWxDJbYSBekw+M22TGano3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1505FC4CEC3;
	Sat, 28 Sep 2024 19:12:12 +0000 (UTC)
Date: Sat, 28 Sep 2024 15:12:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: tech-board-discuss@lists.linux.dev, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev, tab-elections@lists.linux.dev, Kees Cook
 <kees@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Dave Hansen <dave.hansen@intel.com>,
 Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Jiri
 Kosina <jikos@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Lorenzo
 Pieralisi <lorenzo.pieralisi@gmail.com>, Amit Shah <amit@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: Results of the 2024 TAB election
Message-ID: <20240928151210.3aa59173@rorschach.local.home>
In-Reply-To: <87y13bc05z.fsf@trenco.lwn.net>
References: <87y13bc05z.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Sep 2024 08:39:36 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> There were 934 eligible voters in this year's TAB election; 229 of them
> cast ballots.  The results were (with the top five winning seats):
> 
>   1 Kees Cook
>   2 Dan Williams

>   3 Miguel Ojeda

I'm so glad I pointed out Miguel to run in the TAB AMA session ;-)

-- Steve


>   4 Dave Hansen
>   5 Shuah Khan
>  ------------------
>   6 Jakub Kicinski
>   7 Jiri Kosina
>   8 Daniel Borkmann
>   9 Lorenzo Pieralisi
>  10 Amit Shah
>  11 Ricardo Neri
> 
> Thanks to everybody who participated.
> 
> jon


