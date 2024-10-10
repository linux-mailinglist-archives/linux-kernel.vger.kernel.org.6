Return-Path: <linux-kernel+bounces-359602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F6C998DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667D1282861
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6882219994D;
	Thu, 10 Oct 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UdBpcmcH"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7368719924E;
	Thu, 10 Oct 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579345; cv=none; b=Kil4bvkwuBHSXODVI1p7Evm+wt2JVjIUw2OCc3AQ5DRjbZrRkezXgOxqwk4IT+c4hPbpdFeQ9Nyy6m/2xUpKdXHeI4Ec9kKnxeceQjyvDOBR12cm0kmF/0e9RiusknbCGaYf9+T/svVySAookBF5kkCnRpP1X7IN+DF/tsBzjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579345; c=relaxed/simple;
	bh=jXgeeFd/l8SrKbOPXwTEPBZaNtNSE0z5v0EY1LXyEVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B003ErrRvdt0RHew/3rAOqlne4tkplBstmylsjMrTJ4twjTvw2YLzljijt+V1TOQjGL2bD7DiNyv7+s0F3IXZnODh7I1MVY3ZZoZkWd3yyhJ9NLJCQukgFbXGWHNGpR5+0Ar8MKJFS27CWIadd2/ib62kFiKBVg7QML6zqUO1jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=UdBpcmcH; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728579336; x=1729184136; i=wahrenst@gmx.net;
	bh=jXgeeFd/l8SrKbOPXwTEPBZaNtNSE0z5v0EY1LXyEVc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UdBpcmcH5FvNYm7GpaJAhiAn5IQi4QS1liHx6PMRdVV+AuF0fD4GuXm6OZ+K8B0x
	 ZJYG81GDQ+rB54WoWyoaE6v1Nef93FklqDcPvnh8SrbUwS2TUCGQDKmenXn0SZ2Sl
	 rVhCxYWBQw24Sfo8qNg5NMxsQPIDzZnnNqzVMJETTnURuyCLi1Nn0pcqo/rfmKFZk
	 K0rcKd+CdtTNWFIsgmUNMa9cau0be8R/ap2ZLJ4grSF9vKQm3LEg9d1TbQAuMQZqU
	 TN3VGMrBkcd41VXE5AE05iF3G7oKnuZqnyY9apORT2b83D7nreejFYQwUQF549/zy
	 akbcllepzYjT1NX7VA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mGB-1u1pJr0JB5-0134uJ; Thu, 10
 Oct 2024 18:55:36 +0200
Message-ID: <7ff068d6-dcf3-44a3-895b-2db713a08f45@gmx.net>
Date: Thu, 10 Oct 2024 18:55:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] staging: vchiq_core: Indent static_assert on single
 line
To: Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20241010102250.236545-1-umang.jain@ideasonboard.com>
 <20241010102250.236545-3-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241010102250.236545-3-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9kK3cj56LUbhohT0D/NWyMwK69NabAAbgPGQyes2mNjjRkAT4LR
 yb1mhIdFD8H04NXbW7eu9UlYohgThjlhAJ1SCIUlR3i+xj8qGVTxQEb3kYkBA5KBX76zwZN
 gljEzJZV6a2GEUJ2Dmt8HhCUgPbk12kOLjXn3LxRMWYvT0oeLv+rI+fO1dg3ijpg7r8HDsp
 hMgEByqBEpyX2yKkxuC7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BaBhNsfMP7E=;cap1PfBWWRqlrro2m1VJQH6QblY
 PA2EiId/2NEFv5aN0MQ+jaN0qW178DCFyvxn8FKuDE5QvXlOq03xllVYGtTn2YKyeve+I9WUY
 RzsMcR3EBJ+Tl2XVMsG+55p86ICR6r3jJJ+SL3uBsZo9F0vnHoGCvk33Ph6gqTht8FweDAbw5
 8xNI7G5/iZKNWnzKhvkh3NmDiAariV7SSZ8kugyIIWZYgzY7ibGCqxgEtyhxB/5cfA/3nZTUK
 LG5WI3ahSMgxGWtpDaRWq0lWVhOYpeqRe/E2rq7fsoHb4Lzw2WADhzw2FcIWXsA5p5TlFw2iS
 elV+fk7WMDwP6PQ76aeMozXJlJzxYjfqwHir/zgts2MwaWA6pVmNd94xb7GKl3sSR784uDS2l
 ib3gjdwdm62ly3kWDWQQml05ykwOCxl6+IiPAIkFXPAMVSG6JhzMgu4ZQdWAfRHdw+d9LFlF9
 hVzCuQQJ7wfsfizu0g8jEmTKVR8aAWQjKKxaM/59ljJXZX3WA1aagOjV/kz4mNXsRtwOHAEyr
 k0F4gSyrBF4R4Rsgl2C9O9zMJkEDP7XL2NeJeGPNyjXkwRcYwN9ulwFAtVYn4LCEWtj0oAvee
 qRMyLbYkixEVprvkXgGBSjvZZGee0+zp3Jpt1PzWenTjJiBeMKzy1Fncmr75opCemIJZ+lurC
 qrcMSu/X9AQ/Ab/deyQe+aYA5PoY1a8EHRc2FNcgIaY2k7isssrbhXmkDDBLtfSxmfIYC9q9q
 UU4n0ia4s8qSNX4p+WaHyhtslPj4EPwplybjK6KZL9Kq+GIyTBV626c6CJdE3QDOtXTsClCpS
 nETWXYyJUjFG5XwKpb91zhgg==

Am 10.10.24 um 12:22 schrieb Umang Jain:
> The two static asserts are under 80 columns width, hence indent them
> on the same line.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
Nice

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

