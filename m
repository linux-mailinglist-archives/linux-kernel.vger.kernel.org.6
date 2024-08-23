Return-Path: <linux-kernel+bounces-299687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD3795D8AD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A614628482D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826C11C825B;
	Fri, 23 Aug 2024 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="WUeLhkAr"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AC01922E0;
	Fri, 23 Aug 2024 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724449855; cv=none; b=UgOzfNt+Q8QI4vYuw8+FoXRX+nb3k6+hsddGqkfufD/+z6oDUbMnaeJ8Ir9mYp5DUFRfnwt69jUM0Rd8lkyt3mnadgzkbA7wPW38ckwW4/r5Zjlp82MJvzxwVOblRfiCyWOPfS+6gH0oKU1zB2kJ1INeFuDqTP7buzly+LSibq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724449855; c=relaxed/simple;
	bh=Duob4DARHudu9UffvC2e4VH9jt+adZqFzJCl+uR0RHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fy8U6MuKKPXA6mkja2In/Tf5gI8xbkdD4JnGqmYLUoTtchW9yvjQytF0LynD7ojfzwBZb+XfaQ5lJbpncpChnh+EZL43Vt4E7g7KTn6Z5VqHrF98poi63MtBDqKrX7MryFwVinRKmYDBeBmEDipyIbHCvmFm2LMovRYpQjaPrb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=WUeLhkAr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1724449842; x=1725054642; i=wahrenst@gmx.net;
	bh=Duob4DARHudu9UffvC2e4VH9jt+adZqFzJCl+uR0RHs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WUeLhkAr/oB5PKZm94D9JGfGKRykPg9DZX0EhMwHFzcakrbKKjB73QI6c5EeWQtZ
	 rIztmMaKyIeA2MnvcMCIdzeJfqX9TwKbLwPpedPS2ed0+JNXkFhnkTq/eRm8GZUaf
	 T47kSJ6tB6BjAeW6D9wofNus/FoMtx1QHmH6Yj8Hn/k1KRuhB44xn3jxuPQ2nuzQC
	 L3h5gYpB4kuAhfplmQNi5LaV/m/milU9aKjZvffTHKJnKc3UfqQyV1IYwn/HAY0mH
	 Ajo4iGYj/y3knppTAR8+vrurACpiRS2c0e8umASmy0sNygqHjwRhQKIycRnuS6T0N
	 M47V6aj+A3xoeiCYcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mBQ-1rylO225rI-011DOI; Fri, 23
 Aug 2024 23:50:42 +0200
Message-ID: <0a32d686-80e3-4c59-b0d9-3bfd15964ecc@gmx.net>
Date: Fri, 23 Aug 2024 23:50:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] staging: vchiq_core: Pass enumerated flag instead of
 int
To: Umang Jain <umang.jain@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>
References: <20240823-to_sent2-v1-0-8bc182a0adaf@ideasonboard.com>
 <20240823-to_sent2-v1-7-8bc182a0adaf@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240823-to_sent2-v1-7-8bc182a0adaf@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uO6QyX2U4G+XdUvjQKDHLWdCtBQkwcLYOZEDGUP2vi4QPbmRgJx
 euP9vtDduE88bIRv9tWS13ptUS/yi2OOrt4SNINYPNLtDXpzs/VNy+0ksBqZiDC9/f7Ep36
 lYq97B/l4hXKgcFZh2yeYNdQsrVY2fMNvUvLUQ9QK2SZjlMytlLPa+Yzr6CuHgvvqChPiTu
 5Ztdgzd6ZQWlfMWQ3zbuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hkQxNndVZYE=;4t5D+eqxrDN0nBpGbiQyYnVb7ne
 Xic4vGq7g2kSzt6syVkIMjw61DyC6Eqoiz4e0bbEx39rZc3P/+BOkIrqPb0dJJLPuz/IWoPjZ
 vPkEadh7433KdRQUYC7XH5bcgMNKAKSR2vc+iBFV46EWQQknKf/XVQK96lNKVdoO79cvBqDNJ
 ZucW/mdZOehazrjeX+SFB90H/CZnyxZWPLYxbKHIJ4P4v8uUUWTzqI11LhULM1/IV6FaR0Fye
 mj/pbhCz45oriMF7CwAMXW3eLetCzxEPmZHaYr5aUqZ8AQCWY9XcHR9gN0Nzg6A5rZpi4GLSO
 pJVbZPqP66PIgwP52CKvBlV/HxRNperIXGxJFQzBjVjQwm6fxkXOCrLzKTKIK7GykaFsLnpkd
 wAGmffXXjU2dXCSOcDWvSI2uSAGBdv6DgiZpJS8Ja/yUMSGHiBPnNhoG8ynse/YUW6s4MWzZB
 CalJHXRBkNXk4TMSnJZDQt0VLv0Bt6MXifgrZuBoy/cPmMDEbZtbfcwkD4pGlCKU/FRMSJhIs
 5Qj8sYsgYGUC7ZCPaX/rkRsWMPYgIvR8d5mvFeFZ6DcLOD9v6NW7sYV/GTvz3s6/XvgTc7JtR
 8fbhqFVSLHQbiimkDWVr5yxws2p/kO1OarMGSyU8mfiixCxbydlNzu9v+FgykCNk7aF4EhmN7
 LWyTAxLz5PPXYh4mTcxiPdH2cozbUhZlwTzlZk1ws/LBDzIKgbjYO2gB5AsipUuHU9fkZ3Q0z
 BNR0y1ziCDgOK+M36+EzsZDPuei+bLx4jbKTLNwlnMR4Pp2udWg1M3R1pebpiaLUQRuHcShog
 cMplX+M/onLr8JwMGvofXKyQ==

Am 23.08.24 um 17:14 schrieb Umang Jain:
> Pass proper enumerated flag which exists, instead of an integer while
> calling queue_message(). It helps with readability of the code.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

