Return-Path: <linux-kernel+bounces-181752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B7E8C80B8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 07:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C4DB21829
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 05:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783DC1119B;
	Fri, 17 May 2024 05:51:08 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BBA10A31
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 05:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715925068; cv=none; b=D8dpW5v6gBcSHnAmdv85BKziiPdRh9KlFemhY/3M/Q/LPL9A2BNBFy77NStaxt0zeH5eM5+FY0TH4Q6jLRtIwPQ5NUpKwx+VG12HD4lvYpDy6VnBvvkxlf778U9/k3sZXu+XbpOuxEJuWF+Nc3uvI1+mCKe5gAVTs4ri9OfXreU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715925068; c=relaxed/simple;
	bh=1V9KwXZVBVV4tYU3t4qCzKQshOQfTy6cWBv/7kCv1e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxucImctvlBTGiilcyor2QjQ6RlGfg2Lq2FFuJZaggZv3zOfjTTCUTGRywwBI/msqr82frdibSWaQN4a5kuv36VG3ptu5isKGKHOkypu0aZnfpAWKg7xhSv2QbfZuzPo8G0iYfAuZH4n7vStDnWrrwnGaXlyWlJa3ljzuWBjxfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aef9a.dynamic.kabel-deutschland.de [95.90.239.154])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5BF1E61E5FE05;
	Fri, 17 May 2024 07:50:33 +0200 (CEST)
Message-ID: <51c51cb7-db66-4187-a7e4-6dd3044579b7@molgen.mpg.de>
Date: Fri, 17 May 2024 07:50:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [linus:master] [e1000e] 861e808602:
 suspend-stress.fail (e1000e: move force SMBUS from enable ulp function to
 avoid PHY loss issue)
To: Rui Zhang <rui.zhang@intel.com>, Oliver Sang <oliver.sang@intel.com>
Cc: Yu C Chen <yu.c.chen@intel.com>, Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Naamax Meir <naamax.meir@linux.intel.com>, intel-wired-lan@lists.osuosl.org,
 oe-lkp@lists.linux.dev, linux-kernel@vger.kernel.org,
 Anthony L Nguyen <anthony.l.nguyen@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Hui Wang <hui.wang@canonical.com>
References: <202405150942.f9b873b1-oliver.sang@intel.com>
 <23f86436-cd8a-45b0-9378-1ec3adecfc82@molgen.mpg.de>
 <7ef3669807799a83aa40e94e2bdd21a11dbe393b.camel@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <7ef3669807799a83aa40e94e2bdd21a11dbe393b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Rui,


Thank you for your quick reply.


Am 15.05.24 um 11:29 schrieb Zhang, Rui:

> On Wed, 2024-05-15 at 06:57 +0200, Paul Menzel wrote:
>>
>> Can you please share on what test system this fails, and provide the
>> hardware information?
> 
> This is an Intel BroadWell NUC.
> The problem is reproduced on this platform only, we have 20+ other
> platforms but doesn't see this issue.
> 
> lspci output attached, any other info needed?

The `-nn` to show PCI vendor and device codes also as numbers would be nice.

>> Also, do you have Linux logs until starting the tests?
>
> dmesg after boot attached.
> After that I run "rtcwake -m freeze -s 30" and system freezes.

Just as a heads-up, that the referenced commit also caused regression on 
another system [1]. Would you be able to test that patch?


Kind regards,

Paul


[1]: 
https://lore.kernel.org/intel-wired-lan/20240413092743.1548310-1-hui.wang@canonical.com/

