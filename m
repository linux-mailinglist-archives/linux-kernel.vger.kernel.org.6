Return-Path: <linux-kernel+bounces-316495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F6D96D05C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4211F226F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC35B193075;
	Thu,  5 Sep 2024 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="00UeHK9S"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4671313D2A9;
	Thu,  5 Sep 2024 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521213; cv=none; b=iiHdEZQ+Q7usdQIVMjCTI+QEKvAFJGH5Sb1ajbGcOOwv9enAes9wy/n5Mip5owjhnt7tlenezBdBuGMPYwg5Qx2BztqjuSgCV5Mz7EeBiEFbVbESIM/LHj9UiAHva7G4Z4JIKlDTxPKGiUoYgJzW2G6cyry+YJYmAWgSP8uXci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521213; c=relaxed/simple;
	bh=J3h/pEXhWnamMRH/2xCgvLm05jD815BjkrZDVdDIF/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MulYAD5EG6nCT/Lb8j1n1FEHRTg5v73wmu9R6rMs0snaJmJBrzVfxCPVCFUaMVxa27ESrncz39mtjLdS8ei/7Op4LPKNbmP8eFUFfKgf7RPp6TlqKHzBeiTz8j/x8Sq8bS0VNE5dxc5wsex1O4h5f0K6LJCpYrV8fLYCS9lc33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=00UeHK9S; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=J3h/pEXhWnamMRH/2xCgvLm05jD815BjkrZDVdDIF/Q=; t=1725521211;
	x=1725953211; b=00UeHK9S67E3/dNl16dOs47NX2z6Kfa8G0Ur4b3GDxbl5J8v0FPPkAaF51tG1
	+vig3yScC62a5jAsT+qDtpcHmKjFwA3XKfmoEuS55xOnl/eGHmVBjpXH/vWRFNfOKg2LrLo9Xcb75
	jya9c9qwYaDJOKQ0NGiWXblPHdTHAt4bDCf7QJWHvPv14h3gXOMamOYvMJknlXMLF/oXgix+GXV23
	oZmfri+1NVnTBzGtvCE/M2pqFlgj6nN8hiPDT5jPdaBL8pIAM1J2/ZINmcZA6diMfQTmmdyc+1LYp
	GIHUjwX0SP4YFMwuAz1Uuf8XNvFC2KsdcyhFCITzoIvklEmmsg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sm6NQ-000111-FH; Thu, 05 Sep 2024 08:53:56 +0200
Message-ID: <d69cc5a5-ac69-4b43-82fa-391eb7a17cbd@leemhuis.info>
Date: Thu, 5 Sep 2024 08:53:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: vmscan.c: fix OOM on swap stress test
To: Yu Zhao <yuzhao@google.com>, Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, yangge <yangge1116@126.com>,
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 baolin.wang@linux.alibaba.com, Kairui Song <ryncsn@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240904-lru-flag-v1-1-36638d6a524c@kernel.org>
 <CAOUHufadyZBOifC8-ompzy4idEO9g-zipsSBrkWaoc=sWrk+Uw@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <CAOUHufadyZBOifC8-ompzy4idEO9g-zipsSBrkWaoc=sWrk+Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1725521211;96b34f3e;
X-HE-SMSGID: 1sm6NQ-000111-FH



On 05.09.24 08:42, Yu Zhao wrote:
> On Thu, Sep 5, 2024 at 12:21 AM Chris Li <chrisl@kernel.org> wrote:
>>
>> I found a regression on mm-unstable during my swap stress test,
>> using tmpfs to compile linux. The test OOM very soon after
>> the make spawns many cc processes.
>>
>> It bisects down to this change: 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9
>> (mm/gup: clear the LRU flag of a page before adding to LRU batch)
>>
>> Yu Zhao propose the fix: "I think this is one of the potential side
>> effects -- Huge mentioned earlier about isolate_lru_folios():"
>>
>> I test that with it the swap stress test no longer OOM.
>>
>> Link: https://lore.kernel.org/r/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com/
>> Fixes: 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding to LRU batch")
>> Suggested-by: Yu Zhao <yuzhao@google.com>
>> Suggested-by: Hugh Dickins <hughd@google.com>
>> Tested-by: Chris Li <chrisl@kernel.org>
>> Signed-off-by: Chris Li <chrisl@kernel.org>

Thx for taking care of this, Chris!

> Closes: https://lore.kernel.org/56651be8-1466-475f-b1c5-4087995cc5ae@leemhuis.info/

FWIW, no big deal, but that ideally should be (in general and for
regression tracking) the following instead, as that link above is just
at the end of the thread with the report, but not the report itself --
and that is what often needed when someone needs to look up the
backstory of this chance sooner or later:

Closes:
https://lore.kernel.org/all/CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com/

Ciao, Thorsten


