Return-Path: <linux-kernel+bounces-254459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5F693337E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86EF281806
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4917C79952;
	Tue, 16 Jul 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yqk9WCqv"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849751DDCE;
	Tue, 16 Jul 2024 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721164832; cv=none; b=a7IK+myJ0PzrWYR63I6m1tO1LWHio0m0HL/J2EF4dqKcjsW0yqN0pmQwWet/hwrZ/hcZCuAKwqkLFlTP8wjD02OwVRs6KTvx4+Gj7S4+bvyyINccoyefqLQcP5QG7i+O7oG/VPnki+qDL92xm/wzI7RzpEJN1ZSHxe6zUcdT0hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721164832; c=relaxed/simple;
	bh=BiIEMnt3VLJ8mhdACxgk/r6mWtVLFHNRdt9CT6QnSI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/Faz4jiNjS67LHM7pPg5b0BxZLzCPRORiuOJ8fhJWrThOIsZsLOVZRF51ggv7u9lyFiQitR3YMUFH3JsDNJMeyexniYTDCXA59OtYU/bf72+Vu4ebjk2D1yP37Xv6fQPqoSg7C7jjYwKCCM7dSaaMBJCsWFczNCLWpV6IzZfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yqk9WCqv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Qcrz6OS3najszlPDYkCVo47XTxdWQRpn0VG/UoztZD0=; b=Yqk9WCqvBf9XyguN8OmLaQE2yp
	u5PFgSs5SfoxOGvMSmtXqfNYGbCBrKMRZCMe27dWUWHrWig/kz9+xjkpTrngqaGWcFCW9zk3wPlLm
	TkOjDTtZYBRloZB95yXsf0+t0idFpZH91NfGje/4bl1yViGjAq/QlfUvRL6t/9/h7F0p4WDHufd4R
	MSDtiCMjJ8E33NEVdupz206CuTAvAASnp9f/EFEvEB8SDcN6rFs3Z+ZErulo5ilX8M8zI2rkER41y
	Q+AVYWpOhif66XaynXKbIqrUDB3VkWTASlnxaK2lB1XknLybidBzlzWrc6zSrkltw4gNVA/c7nRkW
	PewW2tJQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTpb1-0000000Bnj2-3Rtk;
	Tue, 16 Jul 2024 21:20:27 +0000
Message-ID: <f7b0b9e1-22b8-4b43-858d-4023eef602db@infradead.org>
Date: Tue, 16 Jul 2024 14:20:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: document: add gpd-fan
To: Cryolitia@gmail.com, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>
References: <20240717-gpd_fan-v2-0-f7b7e6b9f21b@gmail.com>
 <20240717-gpd_fan-v2-2-f7b7e6b9f21b@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240717-gpd_fan-v2-2-f7b7e6b9f21b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/24 9:58 AM, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <Cryolitia@gmail.com>
> 
> Add GPD fan driver document
> 
> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
> ---
>  Documentation/hwmon/gpd-fan.rst | 69 +++++++++++++++++++++++++++++++++++++++++
>  Documentation/hwmon/index.rst   |  1 +
>  MAINTAINERS                     |  1 +
>  3 files changed, 71 insertions(+)
> 

Hi,
The issues that I had with v1 are now fixed.
I can't really comment on the hwmon-related contents of the file.

Thanks.
~Randy

