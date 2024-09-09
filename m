Return-Path: <linux-kernel+bounces-321186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FA097159E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310B71F23E64
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B68D1B4C5B;
	Mon,  9 Sep 2024 10:46:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362FE191;
	Mon,  9 Sep 2024 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878776; cv=none; b=r7xONBjsYzd6O9BYFw7Bbnaq2P4UQsvQPf2vs6j0KV2hW7NPlZ5YhZsXYE0noNVBR83wLW6f43uHQA10cbfkeeuMs3KgTlDoyIZLlNsbJge3Aat+YSCHzYWDrtSCfkstXJK3LNw0NAlPYlP4ivnTFSs1Y6TbDlORbTtYXnYwEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878776; c=relaxed/simple;
	bh=QmlBIFpFsQ98urNXZuP2OSPX7p9ga2galSnpHluKEs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlvggMG0aDYFHSFd3DHiUNq6cjczrGMj9SKcnRrJvqFDwY/45k8fjSuycUDpF3WJSn7jbl/XUJGmQYL5hHQ9Wm5a35euYQLHi1qBZg4S/NpzbTihsmdyGwUbH8HqUMTeMXOZ/0RRnUFPv1dnKIz6TNNQe5HOBv/JZhvL8apff5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ECBFFEC;
	Mon,  9 Sep 2024 03:46:42 -0700 (PDT)
Received: from [10.162.43.35] (e116581.arm.com [10.162.43.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEDF23F66E;
	Mon,  9 Sep 2024 03:46:08 -0700 (PDT)
Message-ID: <af0ca290-82bd-44b7-b66f-f05a91e7afff@arm.com>
Date: Mon, 9 Sep 2024 16:16:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/mm: fix typos
To: Andrew Kreimer <algonell@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Russell King <rmk+kernel@armlinux.org.uk>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Sami Tolvanen <samitolvanen@google.com>, Peter Xu <peterx@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20240909102907.9187-1-algonell@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240909102907.9187-1-algonell@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/24 15:58, Andrew Kreimer wrote:
> Fix typos in comments.
>
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>

Reviewed-by: Dev Jain <dev.jain@arm.com>


