Return-Path: <linux-kernel+bounces-287988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF11952F03
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58D41F21AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6B19DFA6;
	Thu, 15 Aug 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="jXC+39dj"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FBF1DDF5;
	Thu, 15 Aug 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728434; cv=none; b=r6icEquL8ZO1gFfwXW0VPzASTYJHjeoI0CpcR9EIzRmT2UDWJSDMwwJb9ytip2gaUx2NWwLmVTbcjAEvcblX9m09TNihJxtIW46w1ccqerW0R4kwil6u9K3xXkkh3ZXQAnz7GIFy1RZ+fjGP9CzFY/NEJWgP3vBhuBPdMDv9tkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728434; c=relaxed/simple;
	bh=rvjTc/V+WC8MQxt5c2VWNDmHQVX8nkxIBdiXAj6NHco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLw7QFqAf2hx7UaOotSGlxTc6Z68EDu3RbOnSuIktQpVq6vjRHqHG+h+NCrJ+Oj6DMD/IkksWwsaSHQKeKRjpRc763T+l+YRaTUhnFIc8h6puSvnAQI4unrMyzsihMKbunhQ63lVNEY6BxXOGD0XMPTmvAv+xTEfgvVMzgRwdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=jXC+39dj; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=cxEWD0e0QZ9HFrd/OmZU464Gkp7yr4zIzG+4PJ+YvQs=; t=1723728432;
	x=1724160432; b=jXC+39dj2pUYDQRYg9Id8C6Ag3WpYpcfpc0308Z0UaihcAV5LdlBwtJcW7rdn
	e9ZgXk59IiEXmmDMWy5YxmG/GjDr4MTGuK+GTlasQDiw3LZbeMAP3dsKL+jn8u/NkgDRCfuFcOG+C
	KA7Gs4Sukj+caqAXKZAzO2xxyEgdf1hQF93kIx2FgU7vYfZ/2SnU9h0AacSeR446RkIl5RCCucJNe
	igMFNzAHoNgnt945wSR2RBpCGR27yZl7GPOVqVLZ4lr1SHBkNzA9BmF+mOvaaHjrlbX1dXAAnS8cQ
	iKYzawcIxTJzZ0qY0Hg5V2NkytnDMdyV9d3cpuL/Z06NBRE+Fw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1seaVI-0002M3-TU; Thu, 15 Aug 2024 15:27:00 +0200
Message-ID: <3716b1d7-71d5-4e53-9004-c75fc9424a57@leemhuis.info>
Date: Thu, 15 Aug 2024 15:27:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Fix grammar and phrasing errors in
 reporting-issues.rst
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815103114.10461-1-surajsonawane0215@gmail.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20240815103114.10461-1-surajsonawane0215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1723728432;3ba6dea3;
X-HE-SMSGID: 1seaVI-0002M3-TU

Lo! Thx again for doing this. 

You might want to add a version to the subject (see the -v option for
'git format-patch', which I assume you used to prepare the mail), it
helps to avoid confusion and some maintainers are picky there -- but I
guess Jonathan might not care too much for a simple patch like this.
Some maintainers also would have insisted on a changelog below the
 "---" line; again, for a simple patch like this it likely is not
important.

On 15.08.24 12:31, SurajSonawane2415 wrote:
> This patch corrects some grammatical errors in the `reporting-issues.rst` 
> documentation file. These changes improve the readability and accuracy of 
> the instructions provided in the documentation.

Please use imperative mood, which
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
describes better then I can do that quickly here.

> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
> ---
>  Documentation/admin-guide/reporting-issues.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
> index 2fd5a0302..61de4454b 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -56,7 +56,7 @@ developers. It might be all that's needed for people already familiar with
>  reporting issues to Free/Libre & Open Source Software (FLOSS) projects. For
>  everyone else there is this section. It is more detailed and uses a
>  step-by-step approach. It still tries to be brief for readability and leaves
> -out a lot of details; those are described below the step-by-step guide in a
> +out a lot of details; those are described below in the step-by-step guide in a
>  reference section, which explains each of the steps in more detail.
>  
>  Note: this section covers a few more aspects than the TL;DR and does things in
> @@ -299,7 +299,7 @@ face, even if they look small or totally unrelated. That's why you should report
>  issues with these kernels to the vendor. Its developers should look into the
>  report and, in case it turns out to be an upstream issue, fix it directly
>  upstream or forward the report there. In practice that often does not work out
> -or might not what you want. You thus might want to consider circumventing the
> +or might not be what you want. You thus might want to consider circumventing the
>  vendor by installing the very latest Linux kernel core yourself. If that's an
>  option for you move ahead in this process, as a later step in this guide will
>  explain how to do that once it rules out other potential causes for your issue.

Looks fine. But you dropped this change from your earlier patch
afaics:

-module not part of the Linux kernel. That why your might need to uninstall the
+module not part of the Linux kernel. That's why you might be need to uninstall the
 packages with such software to get rid of any 3rd party kernel module.

Sorry, guess I was not clear enough what I wanted in my last mail.
Please re-add that change, but this time keep the line wrapping
intact -- which most likely will mean that the "the" and the end
of the changed line needs to go to the beginning of the next line.

Ciao, Thorsten

