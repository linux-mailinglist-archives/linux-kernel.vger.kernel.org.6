Return-Path: <linux-kernel+bounces-560843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C7CA60A12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789AF17D933
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2536D170A2C;
	Fri, 14 Mar 2025 07:32:33 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id F3F861547FE;
	Fri, 14 Mar 2025 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741937552; cv=none; b=ADD2roZI7Wc2Dnf71FjCAPLPQKPmSRpatyhsZKBGpBTlq6jgWeziGDwWOs67vNgAw5Iq3OlYFUXX+BlmGP4iwJ6B6Gs9lqxa+otwAI0TWcK00VJDalwwmQtpwVoMMcr+EMA4G/5jzOQrE5hwXT/b4yCR+RkeKhZxDzgh8HoSpTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741937552; c=relaxed/simple;
	bh=4+pfU638D48FU26m3cPCpULW+afosPLPOQoa3lAjbjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=SAz2lJMZO13CucLS7hhSXU+zS52YTUcVD+tu/3IexSJJtQ7NhPuZjRQoJsrG6LktVAWhPf90DehRHSylieG/v9Mpck57f44o/nP4+5gdvp2HK/26zuVXlrBhaI56t7c0TmRJ9ESMG18poRtj1HcXvAjJoDW6hxkcFFeODpQOWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.100] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 1D694606A5D33;
	Fri, 14 Mar 2025 15:32:26 +0800 (CST)
Message-ID: <57885b0a-eb21-4eea-9b85-71a1fd8cd6a0@nfschina.com>
Date: Fri, 14 Mar 2025 15:32:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: remove the invalid comments
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Roger Quadros <rogerq@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
X-MD-Sfrom: liqiong@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: liqiong <liqiong@nfschina.com>
In-Reply-To: <2025031430-poncho-aviator-8131@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/3/14 15:12, Greg Kroah-Hartman 写道:
> On Fri, Mar 14, 2025 at 03:09:21PM +0800, Li Qiong wrote:
>> These function don't return value, remove the invalid comments.
>>
>> Signed-off-by: Li Qiong <liqiong@nfschina.com>
>> ---
>>  drivers/usb/cdns3/cdns3-plat.c      | 2 --
>>  drivers/usb/gadget/udc/udc-xilinx.c | 2 --
> This should be 2 different patches, right?
Yeah, I will split this patch and send again.
thanks.



>
> thanks,
>
> greg k-h


