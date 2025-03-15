Return-Path: <linux-kernel+bounces-562570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BFCA62C99
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 13:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9DC1655A9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 12:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F5C1DF969;
	Sat, 15 Mar 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="lcEMBs7h"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846661F5847
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742041322; cv=none; b=YRNoicEc30bL2qTAcxRyvqMz0eNygZwLyOBANPFq4hbt/Hv5KkpCYTUo9bMnyEk7R65QfQLURONcq8kiLtlAgDcCURfUMnEdNrEVldIpLRF4LiQETnF1xqVXPns8hQqdlHB3t59tWYQrf45CXKnejknx6RKtVLJLo/mAilXcRjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742041322; c=relaxed/simple;
	bh=wy6c20spWXmcS2DWIuXkVaGyvR3S8hTMEupyMxN48h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSNaklKdm6vonz/PxNGSEBW6FbuXHsMBNpRxFfDA3wGgvE4tCa/gjywE/v/9I6gLMgA9QtD2sfCQGj5fdwRExTUXfYYEi6h93ymnRxLbjqgf26hR1vAzGtOrq6ds7NbMNoJkndUoyhWVtfjq9+yuXhpsDJU7niPZ5+k0Fnn8MLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=lcEMBs7h; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <9c6298a2-4efa-4f77-81c0-b2132f48c1b0@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1742041308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pHhzfXW24TF1t1FOgMUb4yg/TvgoSuq5by1lc39Sis=;
	b=lcEMBs7hDHnSc0+QfxLmeZDIERK/dJY68x+llhQSLKp9G00S01R84WKw83XJyuvTMYeLMB
	8DF9YfNP5+MXAwlcgypmjk+GSuo93jaqX21XnnJ5xxx00ldRX8dqrFfwQK9NM0DJM2m0Mj
	DeygCKkWiBcK7/TouZY26iJWUm139hA1mbL9gi4YCxjIw4W0pz7kaE09y+KhAMebA1qPli
	2IWYBaEHlNcZBkuFC53V0susnEgNklY23VZgOffvT+FXiLUGSZfp+WIJhesX2iBbGCEPcH
	OlutoqHPbk9V0BZZtlNBrNLpKkywoHqByp09B6sMGS2jY7PU2iVNl63jS1ZLtg==
Date: Sat, 15 Mar 2025 13:21:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Documentation: kcsan: fix "Plain Accesses and Data Races"
 URL in kcsan.rst
To: Akira Yokosawa <akiyks@gmail.com>
Cc: corbet@lwn.net, dvyukov@google.com, elver@google.com,
 kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, workflows@vger.kernel.org
References: <1d66a62e-faee-4604-9136-f90eddcfa7c0@iencinas.com>
 <c6a697af-281a-4a91-8885-a4478dfe2cef@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <c6a697af-281a-4a91-8885-a4478dfe2cef@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/3/25 3:41, Akira Yokosawa wrote:
> This might be something Jon would like to keep secret, but ...
> 
> See the message and the thread it belongs at:
> 
>     https://lore.kernel.org/lkml/Pine.LNX.4.44L0.1907310947340.1497-100000@iolanthe.rowland.org/
> 
> It happened in 2019 responding to Mauro's attempt to conversion of
> LKMM docs.
> 
> I haven't see any change in sentiment among LKMM maintainers since.

Thanks for the information!

> Your way forward would be to keep those .txt files *pure plain text"
> and to convert them on-the-fly into reST.  Of course only if such an
> effort sounds worthwhile to you.

With this you mean producing a .rst from the original .txt file using an 
script before building the documentation, right? I'm not sure how hard 
this is, but I can look into it.

> Another approach might be to include those docs literally.
> Similar approach has applied to
> 
>     Documentation/
> 	atomic_t.txt
> 	atomic_bitops.txt
>         memory-barriers.txt

Right, I got to [1]. 

It looks like there are several options here:

  A) Include the text files like in [1]
  B) Explore the "on-the-fly" translation
  C) Do A) and then B)

Does any of the above sound good, Jon?

Thank you both for your time

[1] https://lore.kernel.org/all/20220927160559.97154-7-corbet@lwn.net/

