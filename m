Return-Path: <linux-kernel+bounces-561146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60637A60E10
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A518717D71D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98D21F1523;
	Fri, 14 Mar 2025 10:00:49 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7189843AA4;
	Fri, 14 Mar 2025 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946449; cv=none; b=FJHna90/NwUbdIMsLmQvAN/zAiSNBL/JpQc/KbKf5vSE1jvXKGS9MtvLKcALGes1tNSJdGBNhnbTUmYZphO5QCHeC/8R9t9XjaRHjR58VOfApyZcqMhXuh7GTtYcb+zJaOLd6H9gDOCsNxy1Eaz8Uj7usA5qtp0Zixy1PXx1dew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946449; c=relaxed/simple;
	bh=GdESKsEThHWi8RI/NzB7X2l1IwaahumOi4NCgWF/v/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=g8ljPAonRn17vjJ7uzlwOOcx5apeYoqV3XiHAfb5if4WNsJx8lzlDkfNoFh/9dCmjHDJwwQBjnoy6gkTUmUlpXkSy2TckgXqKMWLNuIxxHaSo/lWLY3KYCzjyCHctzc1gKkSoorTsGEapNKduoiFandIVQ72SQXvc5nTeYvhehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.100] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 7583D606F3122;
	Fri, 14 Mar 2025 18:00:34 +0800 (CST)
Message-ID: <426dd1a1-ec02-4eeb-9db8-1b6c33d83082@nfschina.com>
Date: Fri, 14 Mar 2025 18:00:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] usb: cdns3: Remove the invalid comment
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Roger Quadros <rogerq@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Language: en-US
X-MD-Sfrom: liqiong@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: liqiong <liqiong@nfschina.com>
In-Reply-To: <2025031435-candy-tacking-1c7a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/3/14 16:19, Greg Kroah-Hartman 写道:
> On Fri, Mar 14, 2025 at 04:02:48PM +0800, Li Qiong wrote:
>> The function don't return value, remove the invalid comment.
>>
>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
>> ---
>>  drivers/usb/cdns3/cdns3-plat.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
>> index 59ec505e198a..735df88774e4 100644
>> --- a/drivers/usb/cdns3/cdns3-plat.c
>> +++ b/drivers/usb/cdns3/cdns3-plat.c
>> @@ -179,8 +179,6 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>>  /**
>>   * cdns3_plat_remove() - unbind drd driver and clean up
>>   * @pdev: Pointer to Linux platform device
>> - *
>> - * Returns 0 on success otherwise negative errno
>>   */
>>  static void cdns3_plat_remove(struct platform_device *pdev)
>>  {
>> -- 
>> 2.30.2
>>
>>
> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot

Thanks, I will  resend v3 patch.



