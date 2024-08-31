Return-Path: <linux-kernel+bounces-309700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D289966F71
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991EFB21BFD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A407149C70;
	Sat, 31 Aug 2024 05:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dutYilMY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE22820DC4
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 05:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725082685; cv=none; b=L/eSHSEFFCfa4siGwsH5NCRIGO33xzj8nMFVt8LT6pHzaE+QhlGBYB1tkIhM1YCW69MS+LB2zB7AEbwN82HibzfVHWRnkvR9fgXJSuOapaOoIRq/LcJ8M49tSe9WhTiBwtLhHX92KYsqcalHPOXRFK0mt1frC0C4TfK6ntoQhKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725082685; c=relaxed/simple;
	bh=0RSExdegZQtpR3rTTzogKjG9SHht639uE/v9d+g77nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubLp3vuMMIIrhF2Y6RKPELQVjB5KouUyAlKBM2d0M9zw+11O/BGDGqR5YhUfCumMfCqKNAIo0SD3GXEGKYf1OcF7MsdZtpPeheKCBrJhm9aNtdkMjmCZPCnN86MXX0PSU5ta5v9/Ix+ReniS0tTT4kX/hZe06Lw9tjXowBtkZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dutYilMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB37C4CEC0;
	Sat, 31 Aug 2024 05:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725082685;
	bh=0RSExdegZQtpR3rTTzogKjG9SHht639uE/v9d+g77nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dutYilMYbwp9m48uD2GxjTS4NpWWnmcdaLsBt2gFQD/qt1iOoSMOI089HnJ21ZYbd
	 qihpsoP5cAsFQvjVb8093zozgkQTZpD0TDm1Duz9PrU2MZ1Awh+oJWBEccIEyyWSZo
	 VNKPVZH2T3DZyRDlUSsY0MimYC0ktnIZWnAEwbKQ=
Date: Sat, 31 Aug 2024 07:38:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: REJECTED: CVE-2022-48936: gso: do not skip outer ip header in
 case of ipip and net_failover
Message-ID: <2024083133-shale-shush-19b8@gregkh>
References: <2024083059-REJECTED-7912@gregkh>
 <ZtIritQik7Gt1t2J@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtIritQik7Gt1t2J@eldamar.lan>

On Fri, Aug 30, 2024 at 10:28:58PM +0200, Salvatore Bonaccorso wrote:
> Hi Greg,
> 
> On Fri, Aug 30, 2024 at 12:43:58PM +0200, Greg Kroah-Hartman wrote:
> > 
> > CVE-2022-48936 has now been rejected and is no longer a valid CVE.
> 
> While the CVE was alrady announced and the commit present in the
> vuln.s git repository for the rejection, it looks that
> https://www.cve.org/CVERecord?id=CVE-2022-48936 is still valid.
> 
> Do you happen to know if this is only a temporary hickup on cve.org or
> is there still something missing for pushing it?

Odd, I don't know what went wrong.  I've pushed the "reject this cve"
command to cve.org again and now it looks like it "stuck" and all should
be good.

Thanks for checking and letting me know!

greg k-h

