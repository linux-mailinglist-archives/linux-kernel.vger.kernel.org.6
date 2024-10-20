Return-Path: <linux-kernel+bounces-373339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42C99A556B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3203428290D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D28194C9D;
	Sun, 20 Oct 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vD5Sh0k9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B1A2207A;
	Sun, 20 Oct 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729446224; cv=none; b=iC2OZvTntJFGGYUfwXQEeKGxj+E7qIfVJgNYKH/H2fd2ieuQcia7T+4foPhjK5Oje2hw2JG5ZZJ+MZOhpvRgklzPZdLUhYjcw5rxbRA6aDEUa+hfhxCr2d/f3SL7Skq3M4MscDE1h7kK9z71/JWg1tC+eqch/W67xNnDO5q512I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729446224; c=relaxed/simple;
	bh=rSKhergmTxiaTs+on8QBlRykySO0cuwA7bzX5/lHqcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0speT+V5A5fcDlJbwqOV2Sj02aj378Ju60IJq154f+6kj0q0CRaFIZimcaWoS4b/xEpaEKvqKjNI2TIahc3GOBbiZeqz3L52bbiybdetbd42xH4YNT6xOtZTS0R21v9Zwu2BV01yBjCPlQ8laSSathj8YC1se5vuaMIWCHASgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vD5Sh0k9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=7E9G1zaPS95AdWepoGbHoRyoediBmoaJTcCkoigNEhQ=; b=vD5Sh0k9nRiVKjfJFemrwliq5Z
	9M/Ro/yJNzw+vTn0FLIi9lr2Aq8iTuFypBiAqb48e3GRP6IV7qwTkdtLMHhdlnGDp/3cgxV4L1XnT
	IwFg2lk3dvEJ7ZFEculWoxnm2R8L9WuQ5LBb9ZvXmLERAnqLTXrH6r3nzEFk4dqFwq3hDpxxpnVWS
	1yVR8GtfMAGtqrS6+P117WVAldhoPRQWDXlND/YH5LgnyGLAUbTqUR2kaM0lRNVx5aw7yTBD5BvSw
	j87haViCEHI3FqzMQsS31j+al08g/wM4k5PlRFX5HowtqA9qDVhyiUbNng/rA93nKZKKUQMg4NjVe
	KV9imWhw==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2Zxg-0000000FSRj-0szj;
	Sun, 20 Oct 2024 17:43:29 +0000
Message-ID: <6bf98bcd-19f0-4771-8ff9-18236efdf998@infradead.org>
Date: Sun, 20 Oct 2024 10:43:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V1 2/4] drivers pps/generators: add dummy PPS generator
To: Rodolfo Giometti <giometti@enneenne.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>,
 corbet@lwn.net, Hall Christopher S <christopher.s.hall@intel.com>,
 Mohan Subramanian <subramanian.mohan@intel.com>, tglx@linutronix.de,
 andriy.shevchenko@linux.intel.com, Dong Eddie <eddie.dong@intel.com>,
 N Pandith <pandith.n@intel.com>,
 T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
 Zage David <david.zage@intel.com>,
 Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>
References: <20241018143915.3877425-1-giometti@enneenne.com>
 <20241018143915.3877425-3-giometti@enneenne.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241018143915.3877425-3-giometti@enneenne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/18/24 7:39 AM, Rodolfo Giometti wrote:
> diff --git a/drivers/pps/generators/Kconfig b/drivers/pps/generators/Kconfig
> index 5edbfdb8bd92..0c70df454caa 100644
> --- a/drivers/pps/generators/Kconfig
> +++ b/drivers/pps/generators/Kconfig
> @@ -14,6 +14,15 @@ menuconfig PPS_GENERATOR
>  
>  if PPS_GENERATOR
>  
> +config PPS_GENERATOR_DUMMY
> +        tristate "Dummy PPS generator (Testing generator, use for debug)"
> +        help
> +          If you say yes here you get support for a PPS debugging generator
> +          (which actual generates no PPS signal at all).

Either	            actually
or drop that word completely.

> +
> +          This driver can also be built as a module.  If so, the module
> +          will be called pps_gen-dummy.

-- 
~Randy


