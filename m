Return-Path: <linux-kernel+bounces-402317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 584369C2641
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A2C284C0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDB61D0F4F;
	Fri,  8 Nov 2024 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WPii5cto"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E81C1F08;
	Fri,  8 Nov 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731096518; cv=none; b=PJZA/w2oNNSc6eBtM7QgcJRNHcUWJol3MtdFFncn8BtgIN2sWE4OtHpUmgj4UQ/v5Q/55CDOKHJzvHeAK3azyTVUeaOxVISwpAQ/c9WiJY/u9WUgSXMzm0Y9qw4JXHv08Mon4U02kHleYBu1aO9HcUep6vnttGHLRQlsOFS2heY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731096518; c=relaxed/simple;
	bh=BAtIgroBAlsvoKNehcDGJXbrxqEbn0HAAWSSvFkJwWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V74unjROtoJe/S0j+hNA5g9aQ6g6ixq8h3UzC5oRqv3ntaqKmbj9cdu2pgQrSRn9Dq0xE2Huyh4B24frqy9iGqcFwsoOXZyFiNtk3aaCWITBhdEBjubOGQtYdP/2zGQEzZxjexTlBQzP+WNv9/3at8bF7XIBDwCTELhDmd7CWX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WPii5cto; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=/ek8CdD57enc0HssxhsqMq6TsdAatE+3OGsK8sqC6bc=; b=WPii5ctojURmzr6uwYdS8rCYAk
	JluRwP6YHU8SDiadXuPFkUCVIaRspsijUapWPDn5uUivOv4CYU3Lkz8gDicjbYH4mVCH796zx8ijh
	FbVj8hIJtGIeWzqhcr56QHCMDVCrSroJ5JuEf/cXgzf6ardsjBuZpe9pI9T0Ce8gFbPcmcP3c+m1D
	clWz5Y3Zqm0INiYHewIRBvm9j3UWlVBF19Bx+xwqQUc8b+hGctj12m1C91SvX6VL25+9n1iq+wJzL
	v4g4jv1z7uu5Mmva6/bk45xHqzBNPD654WP00nhqynISpzAK39RyMNvkZxTfddX7XV16t25dWqBeU
	XEQjancw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9VHL-00000009GU9-0wga;
	Fri, 08 Nov 2024 20:08:24 +0000
Message-ID: <2b1f6b86-0d56-445e-bed0-1e33b9882d48@infradead.org>
Date: Fri, 8 Nov 2024 12:08:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/CoC: spell out enforcement for unacceptable
 behaviors
To: Shuah Khan <skhan@linuxfoundation.org>, gregkh@linuxfoundation.org,
 corbet@lwn.net
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Dan Williams <dan.j.williams@intel.com>
References: <20241108161853.12325-1-skhan@linuxfoundation.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241108161853.12325-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 11/8/24 8:18 AM, Shuah Khan wrote:
> The Code of Conduct committee's goal first and foremost is to bring about
> change to ensure our community continues to foster respectful discussions.
> 
> In the interest of transparency, the CoC enforcement policy is formalized
> for unacceptable behaviors.
> 
> Update the Code of Conduct Interpretation document with the enforcement
> information.
> 
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Jonathan Corbet <corbet@lwn.net>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  .../code-of-conduct-interpretation.rst        | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
> index 66b07f14714c..21dd1cd871d2 100644
> --- a/Documentation/process/code-of-conduct-interpretation.rst
> +++ b/Documentation/process/code-of-conduct-interpretation.rst
> @@ -156,3 +156,55 @@ overridden decisions including complete and identifiable voting details.
>  Because how we interpret and enforce the Code of Conduct will evolve over
>  time, this document will be updated when necessary to reflect any
>  changes.
> +
> +Enforcement for Unacceptable Behavior Code of Conduct Violations
> +----------------------------------------------------------------
> +
> +The Code of Conduct committee works to ensure that our community continues
> +to be inclusive and fosters diverse discussions and viewpoints, and works
> +to improve those characteristics over time. The Code of Conduct committee
> +takes measures to restore productive and respectful collaboration when an
> +unacceptable behavior has negatively impacted that relationship.
> +
> +Seek public apology for the violation
> +*************************************
> +

According to Documentation/doc-guide/sphinx.rst, kernel documentation tries to
use "~~~~~~~~~~~~~~~~~~~" for subsections (not "******************").

This is not enforced -- it's more of a guideline.

Thanks.

-- 
~Randy


