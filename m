Return-Path: <linux-kernel+bounces-438559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D059EA2B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559351883995
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CE41FD782;
	Mon,  9 Dec 2024 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3q4TMlf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE181FCD11
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786683; cv=none; b=sOZgKHFyiJe8PlFaOMfz1mq4JR/67cXXLBydirbz99LKAjLGdD0DA0aZw9u+8o16Y2MquXKuddx/UJGG0DOsoZJMKmBsL/sk5/aBMjEktwb5+rM2+HBna1pXLGKh1q5+s+douK58OgOZ5NcMPn/zcY6Zb5VdgBuR7rlkbL+I21o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786683; c=relaxed/simple;
	bh=HCl9CQKqzLGCyTG/r0rBsXdnktrhwHnMfR0L7ej+Yuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ll7mJErptzAd2TybNrt3TNqHdyXNjUoYF7hFV6JvpqpjvmUruXcqcmIi4CIQ/CkwMs2HRqrdTVIPePEDF05iuDIFeo1S5gKfE2xMEVRT2OothxRBEJQjSdS0A82rYJMTJKr4wzwqw+a9b4XoLhrEdi9Z8TUQGOHFWjSbJQr7ZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3q4TMlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A44CC4CED1;
	Mon,  9 Dec 2024 23:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733786683;
	bh=HCl9CQKqzLGCyTG/r0rBsXdnktrhwHnMfR0L7ej+Yuw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f3q4TMlfmcz951YekDF2kEMzDtrgwjs93/cTtvAEnGaeGzpjDJI8R35JVNtDWE29F
	 Pr+MitvBGCOQL0Xr0HkubNVtKg7kJPLH6jCijCsEzEg92aN8qNdnom2T+12fKb6+1W
	 NiqQ4buB7recloePp9GXqTyPf0VMu34ERLdIhBmjPaeEek16FCvRP0qbbAOzRf+vEn
	 5qCMeLcQgLclBJp0ulr1Rtb/TcK9IbrquHp/NWkt+ddJ3KUoQ3ObKhBxbkbTk6CEC5
	 JMzhqH2QOtPwgot993YKZHJZOG2SLwQE7DLhirHLATkxRg02B7f1wPuL4XB/vAkk1K
	 1NeIGDbI1tCYg==
Message-ID: <ffa9aa21-deed-440c-872f-69090fad06c1@kernel.org>
Date: Mon, 9 Dec 2024 16:24:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: media_tests: fix trivial UAF typo
To: Carlos Llamas <cmllamas@google.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20241205194829.3449669-1-cmllamas@google.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20241205194829.3449669-1-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/5/24 12:48, Carlos Llamas wrote:
> Stumbled upon this typo while looking for something else.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Fixes: fe8777a8a0a1 ("selftests: add media controller regression test scripts and document")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>   tools/testing/selftests/media_tests/regression_test.txt | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 

Thank you for the patch. Applied to linux-kselftest next
for Linux 6.14-rc1.

Please cc linux-kselftest mailing list when you send kselftest
patches.

thanks,
-- Shuah


