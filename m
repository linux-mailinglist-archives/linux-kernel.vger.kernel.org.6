Return-Path: <linux-kernel+bounces-560968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA06A60BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DAA169925
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BBA1C84BA;
	Fri, 14 Mar 2025 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="wzlQM/r4"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50F91AAA1B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941214; cv=none; b=a4Ohs1d9mo4jJ2+pHjvDoZMFNRrdobYFjmBflMpaM4bd6O22iBEQjjkxeLTCwAsOaA/JbQ0+NjAsxX4a63GVpqpvnaAeb0DEaz0q+ibKY8syM074sqzKPYD5Atw0Wx02fNtKJTl8cX8I68g5xuplixwCuJldaRottTEzCXQX7V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941214; c=relaxed/simple;
	bh=MGJdDMkD6/gz2VLWUBnuEe0WVufidACgUTjTQja/X6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lb2aA23arxWx4MoMAcuUCQKbB04/a3GcXJSu1onh9kjkZBe7Yc19OAm8CGwQwIxMwcLFNkahJZjULh4kFYTckUjRTeu5Jo4Mw9N4+UoJ8jctGCCAZ9SArrWR/stlTAOxTdQ8/zgNK0aBSnbVQWyYc2CUGaXU0oAawOFPBiXQ6sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=wzlQM/r4; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id saoUtKYWIAfjwt0TutrDBY; Fri, 14 Mar 2025 08:33:26 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id t0TttayluhQ6tt0TttItYo; Fri, 14 Mar 2025 08:33:25 +0000
X-Authority-Analysis: v=2.4 cv=WpgtM8fv c=1 sm=1 tr=0 ts=67d3e9d5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=dkecWN29NwlNYE_-JqQA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l62YLbyLOHyKJhy5MddIlMXG8M11WTu9emmcANot26w=; b=wzlQM/r4FXzRdifNBt+SsYjSBo
	V+3YuS5TdLG2Jmflg3MsnHzZ+3Ywa/mQ7hgfv75zMfPNWQyLMZrnRgNERRiPgkzkEoMhWmBZrQYqF
	8EV+RMpT9sQJcmDms++y3rQbCjb06HpFwyJuew4QXmDup4sp9P5YWf3Xk5+UqHApF46gofIM1g0HS
	1U0+y8uA2k7jCJnmU/bHXpc7EsZBQo/jxznUM6xJlRaKo8Ii6HKfEXICnEwZbScv5s8E/pUH0WM5z
	rU4v4Gs3N2WukFOGP5ZcTy02xeK1TbwXm1W6TkcjmuBIvIHu3eS7Iwz35D13VDE5ub5GFWgxoMCO9
	JFrqoI5w==;
Received: from [45.124.203.140] (port=53657 helo=[192.168.0.159])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tt0Tr-000000045Ms-2aDv;
	Fri, 14 Mar 2025 03:33:24 -0500
Message-ID: <5cb4bca3-da10-4434-a90d-f752d8f1ab1c@embeddedor.com>
Date: Fri, 14 Mar 2025 19:03:13 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] rtc: Avoid a couple of
 -Wflex-array-member-not-at-end warnings
To: Tzung-Bi Shih <tzungbi@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-rtc@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z9N8BsVJF-s6Hcvd@kspp> <Z9PmC4lExxDMusf3@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Z9PmC4lExxDMusf3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tt0Tr-000000045Ms-2aDv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.159]) [45.124.203.140]:53657
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGGIyF1FEZ6QiVMRYLzOi2WVnwsUyru/wwqT+nO7ppp6MCFqVJPYzC4oGFWnKxOqtlfkKIRtb4qhX37myLrNCp7nGPSfdFIgMwSmOGo7bT1Zy9fR7/PV
 7W1OUmMb5jaAyzPjA5NsXIYBNL07in63IJzviye6L3XexDPTOQ05Th1seo1trhR+QfiFPSVw3idilNzZOl+kEGajo9DQf2jPwfWrXPra8P9I+2NxHENPLOKw


> Same here, how about:
> 
> ((struct ec_response_rtc *)msg->data)->time = param;

Yeah, let's go with that then :)

https://lore.kernel.org/linux-hardening/Z9PpPg06OK8ghNvm@kspp/

Thanks!
--
Gustavo


