Return-Path: <linux-kernel+bounces-263751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA95A93DA24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510FB1F214DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878B5149C41;
	Fri, 26 Jul 2024 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb7ibLiS"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2B748A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722029102; cv=none; b=Fb5iUdA4lhuoM9fU2cTAMZtyO7agyz3t0kdomH0giasRHNgzThE+ffS9JxXe/PcNCKwROyg56IlNPz/ednmERLPwLstI7WAx+0dagujj+Ckroh2FrmJJ8UjhzGV7pTCg3Fe+w9paURXfvU4jib9gwdGFOunj/tP0nlLN+UrsJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722029102; c=relaxed/simple;
	bh=ZIsi9zKUW0swovYksBJ3n4LUFhUgXGOSqxH5Nra2W2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqGdtSm2eww6WNojEnYi+ARbK0ABdQ4JyC2OqeuL6IcP6NaVFQv5qudff+8nYsnzY78+Q307k4xLmprTdl13bEt+UoMoGgViS0qk1X66tlfFBk1AjwrFgYCksnKa4Ef9gHqH3C5UdE2Vn3bMY+BmnwKxncdgvpKI3PDXcyQINJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bb7ibLiS; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44f6700addcso5497121cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722029100; x=1722633900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYAG56EeDuTzWOBxNnhp7lsUOtWcviTpONBZz7FeVRQ=;
        b=Bb7ibLiSFzUceLHp2D2Ag01lokEGmWSNfsuujjgZlUtvBjoaNRcpyJ3IqCSg1ydeZS
         fQamDlw9EeHCwWK9qn15/5wSlpprnmDhWAMopLFfFFqHjF6XS88h1O1DIvO5OU/zRHjR
         SosAG3j3WOLg0fUTXepBFsamATNu6jAG+f3uPxhGVvdMftQC7wP/WipNUgMRe5jhQPrE
         rjqMgWbqPxf6NYX8Oq6FJ6LRCJ4eFrA72zlXFWy1CUxQ3TyxJZYA5mrWG3tgryLwu3mc
         R9zcf8femt3UXPpLoapXMHNVzXPtTsagQWEWkjYfbCFTeLT1dwgSgAgdMAaBXJmKpn62
         51JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722029100; x=1722633900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYAG56EeDuTzWOBxNnhp7lsUOtWcviTpONBZz7FeVRQ=;
        b=C9YQiNjpVv89JX43EOf38y6bbCWon5xrfrR4QNz0WmIK//MwrTMBhrmkTThEqppWVn
         cYweHC2+v2GV0K6lSjNvUGoCieiDxVyYGBmiegYp4u5YQnCFv8/w8KzS232n8LWRZaFh
         NqBksRphWDXtiV77KVkIAZWqk+5LqNM2Ce2pP3kBY73HXM/dN/HqUZxlU3wi2xWRA5xB
         tj1NrQ2Up0wlcsvUoTYvKgEYZtezwqvBhtTfu82B6x31JRm3wUrnImdx5ibpZfUdGNGE
         PybXKbYW7MeNTpqCxgYq7e0g8XKHUcVeyWyCeo1/04NfRn7uefZQ6mMyaHCKfL5ZliLN
         rYIg==
X-Forwarded-Encrypted: i=1; AJvYcCWHSTVwt52hlJvrCTXMAZSWZy1yKaWwn8vmpxfYxT0MQZ/kJPNftKz48snNmsni114j6gMgklI1zY75PspHWWLpMxh1dSfOGmuYZW1N
X-Gm-Message-State: AOJu0Yyxz1YyQ81m2yRF6ibEudPTVyj7ZzmIQaW8oc7NiaFaLui1dwEF
	3Ku1tcMEsSSgzj2C7aqA7zdHAzUQWms6SOqRU+wgIiDyxfXcA469
X-Google-Smtp-Source: AGHT+IFr+4hy8UwdnPfUekrUnC1wzSXVer2SYhrAwdMapwg5W23k1nkpRSmyOBwEGOQDTUdA8pUfQQ==
X-Received: by 2002:ac8:588c:0:b0:44f:e92f:ff09 with SMTP id d75a77b69052e-45004db313fmr11613611cf.28.1722029100247;
        Fri, 26 Jul 2024 14:25:00 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8208549sm16192031cf.59.2024.07.26.14.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 14:24:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 344F0120006B;
	Fri, 26 Jul 2024 17:24:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 26 Jul 2024 17:24:59 -0400
X-ME-Sender: <xms:KxSkZisOdVsriN7hxFSgKIN9xuYrYb2MO53-sC6ieEouXKn61CzmjA>
    <xme:KxSkZnfGK71SVsUQ0TW3HMOI6ddvfFM9q_F021vpNjjTD-80IvGKRNO6e3nf0mgv2
    8MDdlXv9W5gOX8FjA>
X-ME-Received: <xmr:KxSkZtzCBv9K6twLgAXJVGZQnvZNl9ERAYuVkU7TI50RS-slp14raD12G-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdduieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:KxSkZtMLpljWsUWQN3fvlF0uA63y3wkS-NiWjoplm9QOk-7DHT30Fw>
    <xmx:KxSkZi9fGgpKPMJBPPXf42bldlq9Juf7_miwOb6TtWoXVIT5Kszkrg>
    <xmx:KxSkZlVd-QCfaixyMfzO5O4JJbhehJ4dkbGnnUx-OfC68rNBpFrYZQ>
    <xmx:KxSkZresAKdjml2wpnhpeOxba42-6jzjLmPR5syJ-sbrR9eDfkXR4Q>
    <xmx:KxSkZsfA2qlSbnUT78koJT32m-bhHG1glPBaJebmw_sNbJ9kxJLf0OkV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 17:24:58 -0400 (EDT)
Date: Fri, 26 Jul 2024 14:24:28 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: suggest the fix for "lockdep bfs error:-1" on
 print_bfs_bug
Message-ID: <ZqQUDI3Ai9GP9hUO@boqun-archlinux>
References: <ZqKdZZp7TI69DWRE@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqKdZZp7TI69DWRE@uudg.org>

On Thu, Jul 25, 2024 at 03:45:57PM -0300, Luis Claudio R. Goncalves wrote:
> When lockdep fails while performing the Breadth-first-search operation
> due to lack of memory, hint that increasing the value of the configuration
> switch LOCKDEP_CIRCULAR_QUEUE_BITS should fix the warning.
> 
> Preface the scary bactrace with the suggestion:
> 
>     [  163.849242] Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:
>     [  163.849248] ------------[ cut here ]------------
>     [  163.849250] lockdep bfs error:-1
>     [  163.849263] WARNING: CPU: 24 PID: 2454 at kernel/locking/lockdep.c:2091 print_bfs_bug+0x27/0x40
>     ...
> 
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
>  kernel/locking/lockdep.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 58c88220a478a..1cf6d9fdddc9c 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2067,6 +2067,9 @@ static noinline void print_bfs_bug(int ret)
>  	/*
>  	 * Breadth-first-search failed, graph got corrupted?
>  	 */
> +	if (ret  == BFS_EQUEUEFULL)

This line has an extra space after "ret", but otherwise it looks fine.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> +		pr_warn("Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:\n");
> +
>  	WARN(1, "lockdep bfs error:%d\n", ret);
>  }
>  
> -- 
> 2.45.2
> 

