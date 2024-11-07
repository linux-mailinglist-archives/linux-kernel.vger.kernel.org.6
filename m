Return-Path: <linux-kernel+bounces-400257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C848C9C0B14
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E7EB23D52
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE47217322;
	Thu,  7 Nov 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P03Vbxhr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C26217316;
	Thu,  7 Nov 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995921; cv=none; b=XCJet83dYItVIAZN1UKuOZ9sR0kglVS2Z8Nsby/yGHBXEt0AZaPqoogveIq6JcR2TK5j98/e2U1T+Mv7GV566TcawMkDWQRoHzqvapl3CxemQWuhOYJfNubZABdxN6c7RC4x6NDMV+p6LdpAB+0E/as0287wU9kytLcKDI4Cp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995921; c=relaxed/simple;
	bh=NfXPc0KoeadFdO2NlcX/HenhhfnnZL96KLA3VoTh+40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EstsvoNBU+FPy1OWHAfSb8CkwVx2NBCcO93dimw8OZcjSdgpnaQayBmD5g+CDaV4MrFN4xVIC3p58SO//LEEm4StNV1Cz+P0yBhlyChyVxLGbxlAAjP/3lb88Kyp44p36Eda1tO/ZWqQLIG6gvdev6fPFZjS6RVmxCD66JfgQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P03Vbxhr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=d3xSlIqNLv2BbfbJf9pBWeu+m2edFwZPJAVYYpuoIZ0=; b=P03VbxhrcsEfH1OfWf112PNvuo
	ba2WxcL4nnoJBm1F0memqsCnsLXkjsJErdoMV4bN6KQC8HvdsOSdiMIBuTOcSLFilnl8kFZ9LgJ1A
	2fYoaP2KwtXcPw2Ai145PEkvWxxHW3N8HBTJykwCWy2dZQLIgnh+mV0+cjMDthA+eoreDC3lJg1cl
	TTVQiACxzUpJYS69KeovrSNW0FzKlkl5i6jfUSM2p0wwf/l9V0af+QcvBSXmiapWcj1sE9b/MQNeG
	vu+wSFqjFwHxRMwwtwyfQBDtyhgUhMS1Fzr2anEVaxH6ES6jASPfyY2wCvASVhB6oYNfFrqTDwX48
	ZITi72pQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t956t-00000006wwX-3nJo;
	Thu, 07 Nov 2024 16:11:52 +0000
Message-ID: <464b1628-957a-485b-87d9-47636491de22@infradead.org>
Date: Thu, 7 Nov 2024 08:11:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation/mm: Fix spelling in hwpoison.rst
To: Abhinav Saxena <xandfury@gmail.com>,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Zhihao Cheng <chengzhihao1@huawei.com>, Richard Weinberger <richard@nod.at>
References: <20241107063042.106228-1-xandfury@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241107063042.106228-1-xandfury@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/6/24 10:30 PM, Abhinav Saxena wrote:
> Fix spelling of "focusses" to "focuses" to follow standard English usage.
> 

We accept British spellings.

internet says:
"Both spellings are acceptable in American and British English."

"Focused" is the past tense of the verb "focus" and can also be used as an adjective to mean clear. For example, "She had a focused approach in training". 
The plural of the noun "focus" can be either "foci" or "focuses". 

    FOCUS definition and meaning | Collins English Dictionary
    ), plural, 3rd person singular present tense focuses , focusing , past tense, past participle focused language note: The spellings...
    Collins Dictionary

Focussed vs Focused | Spelling, Explanation & Examples - QuillBot
Sep 10, 2024 — Published on September 10, 2024 by Trevor Marshall, MSc. Revised on October 29, 2024. Both focussed and focused are ac...
QuillBot
Spelling Tips: Focused or Focussed? | Australia's Best Writing Tips
May 7, 2020 — Summary: Focused or Focussed? 'Focused' and 'focussed' are two spellings of the same word: Focused (one 's') is the sta...
getproofed.com.au

    Show all

"
> Checkpatch.pl reported this issue.
> 
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
>  Documentation/mm/hwpoison.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/hwpoison.rst b/Documentation/mm/hwpoison.rst
> index 483b72aa7c11..dd02fae484dc 100644
> --- a/Documentation/mm/hwpoison.rst
> +++ b/Documentation/mm/hwpoison.rst
> @@ -17,7 +17,7 @@ To quote the overview comment::
>  	hardware as being corrupted usually due to a 2bit ECC memory or cache
>  	failure.
>  
> -	This focusses on pages detected as corrupted in the background.
> +	This focuses on pages detected as corrupted in the background.
>  	When the current CPU tries to consume corruption the currently
>  	running process can just be killed directly instead. This implies
>  	that if the error cannot be handled for some reason it's safe to

-- 
~Randy


