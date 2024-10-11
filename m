Return-Path: <linux-kernel+bounces-361018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF7399A26B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94CE1F27ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E78B2141B9;
	Fri, 11 Oct 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UDiJDVgA"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7F19F110;
	Fri, 11 Oct 2024 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644884; cv=none; b=RKy1JU6HONE9Rrt4sNhwbHubqopIp6/tyvafjSm6k7LW34vBFBX2spOSZsPnX21D6ekn3/GWFBRV0LVIsCvBqnwiG4HVyrCX1MJKhu3yeHErQZsp3hvcgfjh9atqagNOPK4Rv8zxKaZYzZD6wn9mBoEw2vAIaG01Ck/voCJty+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644884; c=relaxed/simple;
	bh=oWSw+wKUbit3CmaNAU5GuI1z72G7uE5sGpOnxC+YQEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FbAb6O1A5kh/qi5ojXc+7oqyGfl+AnwkXcuoOqvBP7Ex0U3R3bCdnVA5DlLhEYt3kryipjlmn+xE7PTIdFJBP8+iSm15iMGI7NItC/znt7/TRXLgWNxOoX+fnc9EFHdnIic2uXkRJLPXnrQ9VOs+kBVUuoOPkNHPXPszg6O5zLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=UDiJDVgA; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728644872; x=1729249672; i=wahrenst@gmx.net;
	bh=Z4nVWdimm296LbZbrWBO63D2qrXcdso6zag9Pk1TLqY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UDiJDVgAMG2UeHaNcKWXYrH3A1gkERVSXMfaS0LyHaDM/MMdGaVpzzNN/QaqSWad
	 ++ci0LZ3pspc//B56bfUuuCl8owLUCCSsGEUjGgn96mX+ibV23iFrpC+38H2c6+EU
	 y9HwsynK4wajJ4Sxymt70vsqhLq1/eDr7mdfH+O3OHV3SKolz25VuERIUJDKDyOpX
	 IcFylUu39EGFml9WEI79aoGdEbwBigGVZ54QTCWQ+Ihfhsqixko7cwt9YEDy+0SLj
	 iNxafgpBk6kHfs0p2pljT1e7jZnHghzbdVnmcz4QfCsvX86t/+F5RvEAGYNzqpKNR
	 AB3YEBhy0+fp117Y0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9T7-1t7m5R2y13-00Ey0o; Fri, 11
 Oct 2024 13:07:52 +0200
Message-ID: <6e57a187-acf1-40fc-a81b-5f90a12b9658@gmx.net>
Date: Fri, 11 Oct 2024 13:07:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] staging: vchiq_core: Lower indentation in
 parse_open()
To: Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20241011072210.494672-1-umang.jain@ideasonboard.com>
 <20241011072210.494672-8-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241011072210.494672-8-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qiQ+jC0jvAWUfcEhweTUAU5bR9M/1DlrovEtBgyC7HFIftPwoSC
 bpbpLcIMYWGnfaP0ZmYtyu8khDMJYYB6u0iayGX99xC+YbsyY+qAShf5aWt07EEtWdsfaQe
 uxyBq1Z4DnfmX45k2ubkCoFYTiv9mpqnU5oNSTKXl9trv0ABK/n6Wdl7KSDAIv/aLOeCIcn
 4gKFOWUHVBYkOyRO0VXWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S8Jp8p5bm3A=;4rEMfo+fUVlraaC0LCLmLWGWghr
 pthzjqZIp3Crc+tsla+Dq6QeG4OHD7fP6Kc8xY7L26zrW0lzuIKKbL+++BhqlLwlkRxkuTjz8
 ArpvvUfszw2pSoXc5S2mwXKasDu/XQ5dxdErGSrgyMFZkPg41DdTwK99XpsBTOpfz+88s+Ivh
 L97XVn1YKJYoQn9+6r78JmXtL9Xql9Z+tK0b8k4b0fK3SDTBVBjcQUjjPohLlb/472lnOsc6b
 QlOWOakjDuQoNB+aV7hvvm3H0PPuj7g59hwGhLBjiXXmALDWDVyv+RwJk9qX5/tWFxDTfeYvI
 xDBxZdBAGmeDUJihVr9db0q8d3Op8Sag1lVVleQh8dZcOTE4Btef+t8vGnnEDcIZ1v6hxlciF
 SoeG1py8x7K9DbTHEcDQYVW4CNP3S6T5jMM+a9yZbdbMbQ7tAcyLPZwDwnGRfeOH0iiZVLMSk
 IYQHZj5FQa/kvnPGgcLMEwjat32FYcjdqG7l1urPI9VW4OuD86gkfVYDjOSOTBY6cqAg58KXU
 n6NDSl/JJ7oZSf+Rp1F7yJFm0i/F71747kUXDZhtjHWki9qdLxGUw5LJgh3KE4PQPYSrYLJtY
 qhQcnGtittjJw2s0JQajjRcHzO3rUIVRT567UDV18PgmkAQe246MPMt7+vm3e0NeNW0hyHG2Z
 j9B5mWKFQZzsaE3UMnNjDxHHZDfS1AIW4yHC/d/PoXJY4DrrTypz5w/CdnviEkPtNiepOZ9tP
 3NTbqJDN52FE5HgCexgjrg6g2zRO+HYQwQyO/bK/xfxs7o2VyxCjfDpRInz0NEFQ/wLCxY7G9
 YSUlxdYQd6YS+6fs+ojmqWUQ==

Am 11.10.24 um 09:22 schrieb Umang Jain:
> If the service is not in VCHIQ_SRVSTATE_LISTENING state, it is
> implied that the message is dealt with and parse_open() should return.
> If this is the case, simply jump the code flow to return site using
> 'goto done;' statement.
>
> This helps to lower the indentation of
> 	if (service->srvstate == VCHIQ_SRVSTATE_LISTENING)
> conditional branch.
>
> No functional changes intended in this patch.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

