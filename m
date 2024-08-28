Return-Path: <linux-kernel+bounces-304240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6467961C71
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145161C214AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9090F12EBDB;
	Wed, 28 Aug 2024 03:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hHPuqjjw"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F1288B1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814075; cv=none; b=lZho9EeqfSGDOknD7FpiZWlPn6s37Kqc6uBdgKnad6kXxN0XGalETBbbBuxgvnn+zNQLQ51iz9MZMs95WlARa0m5LJBRm9MSow54qbvVxBdqNGBPmHFn88QDUua8WLFAjpAc4x7I/AZcOJKRubE8hXXuS37S+JMf6OCPxJmn2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814075; c=relaxed/simple;
	bh=d+uUfx7E7QGXzIMrzijdkoukkdREaIXEc8D6JYUK0y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OW7hGmMJhdmlRB9vR0O4iCYB52/Yoz5e2F9wKZ+/5JmpnZZHupUrM3X4fdY9PqdOIaKflExYSVTrMnTWzOaRHTFIW4vVgA8WTe66HVgFNSVxwOyVNArRv6+3U+7yWWejVeOlp2SEHRA/VAeLK1JZbpPlrMlTCpo+GX9fwRwfAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hHPuqjjw; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3b37ff6-6049-4c7c-a00d-93e739836d37@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724814072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0lAJv6ln7pv6tibnmlRss1E2Pgnyr5DFpnvWqE40jE=;
	b=hHPuqjjwjhRfPhonI8k66ypWrpe2p5UBEgLQ0JXP4ZvT9MNZxTukCFF8eqacxB9ZXViiLx
	wQxj6W9JnqT02UkTTJxOPasyTaGo6hhA7u7dMIVUh6VUobYKxZtrU8CZMve8JNq7vhoX8a
	R3mez82qKvtV532NzIOutIZoByPu994=
Date: Wed, 28 Aug 2024 11:00:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] amba: make amba_bustype constant
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: krzk@kernel.org, andi.shyti@kernel.org,
 andriy.shevchenko@linux.intel.com, robh@kernel.org,
 gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
 linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
References: <20240823064203.119284-1-kunwu.chan@linux.dev>
 <Zs3YsjunDlGSaW4c@shell.armlinux.org.uk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <Zs3YsjunDlGSaW4c@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/8/27 21:46, Russell King (Oracle) wrote:
> On Fri, Aug 23, 2024 at 02:42:03PM +0800, Kunwu Chan wrote:
>> From: Kunwu Chan <chentao@kylinos.cn>
>>
>> Since commit d492cc2573a0 ("driver core: device.h: make struct
>> bus_type a const *"), the driver core can properly handle constant
>> struct bus_type, move the amba_bustype variable to be a constant
>> structure as well, placing it into read-only memory which can not be
>> modified at runtime.
> I'm happy with this, but as AMBA bus maintainer, it needs to go to
> my patch system. Please see details in my signature. Please also
> note that I'm limited in terms of my time in front of the screen at
> the moment, so I'm not very responsive at the moment. Thanks.
>
Thank you very much for your reply.

  I will follow your suggestion and submit the patch to the 
https://www.armlinux.org.uk/,

I have already created an account.

-- 
Thanks,
   Kunwu.Chan


