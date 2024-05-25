Return-Path: <linux-kernel+bounces-189501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8858CF0EC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 20:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08725B223F6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A1C128393;
	Sat, 25 May 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NOOxKcKh"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2188F9F8;
	Sat, 25 May 2024 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716660035; cv=none; b=AnneYvQ9BWxaE3v8Ybabzxw0oLOWxlnWBn6oL5zt8BEq112cw62lH6K2C9gKWO50m3iq94N7c/kBuYRAccYA0Ft+/sGS6Pw3Ex/7czjd/B2eq+X3J0WPjo4RzOTEBbtaqPcaPDDa9iYWLi1fh/Ox4gDTtYNl6b/LX55j7cS988Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716660035; c=relaxed/simple;
	bh=4p+EeENtrNBhk+BdqQn7xAY7/P5w0W1qsA3OlgQYGGA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hU/efklqHsXUASGyRlH8PjKT8i3gm23/7qA+YxDlf4urFFdq83/cxrHvKRVqWYoqHQkbV5nWRgJHJ6h6nsOuDqkr8olJIRN+ZmXJCIfGv78mNFOUaz2EN7u2VU9Jp03k4KN52iRbsIrdn0wwn8lU+uPfEyub8t7omtiUZ21S5XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NOOxKcKh; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716660028; x=1717264828; i=markus.elfring@web.de;
	bh=4p+EeENtrNBhk+BdqQn7xAY7/P5w0W1qsA3OlgQYGGA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NOOxKcKh7hMBGZYJhXb0JttxmWERmptV2LsfYdRIWIGNDbOBDeolIFnUaLxyV6KP
	 NxVtLZIpyNp3trpwyL4ImjjQ5Md31M7Gu3iS56JNkfFBYUFjYDVlV7EAByfK2WgvO
	 qgTTKPzswqNvVQTyv2eCx/Q8UMJpTXrC/b6FAJ6WAB8QswcDeHMecTFSuVnDDsdHt
	 UNQR0gGEgNEo6Q7z2ikxnw4ScKMCm84+3xZEqNh3yuY8LLtZwMJTrf36MEyF9hQkZ
	 wbFdwdiRrPDLJ7bguCUuo3sBNy6L3uWUY8v0n09vYcqizb6uufqAxtdN9cu/qV9Cl
	 VSeMDCN6A4JYE/2jLg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRMB-1siuOJ0G9n-00hjap; Sat, 25
 May 2024 20:00:28 +0200
Message-ID: <7721c32f-06ea-4e8c-894b-cdfb4f6270b4@web.de>
Date: Sat, 25 May 2024 20:00:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shichao Lai <shichaorai@gmail.com>, usb-storage@lists.one-eyed-alien.net,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>,
 Xingwei Lee <xrivendell7@gmail.com>, Yue Sun <samsun1006219@gmail.com>
References: <20240525141020.2520942-1-shichaorai@gmail.com>
Subject: Re: [PATCH v5] usb-storage: Check whether the media is initialized
 successfully
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240525141020.2520942-1-shichaorai@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q2jtdCbdvwkFxXuO0488+GAQQIdetaKP637x3VlWViN3e+5OOgB
 w66bNNcVqgIm0sFx+N0lIc5D6/qZ7Ib0UVrIZ2KA5JQ5RwS6WLVz4ax7m8ynj5f7Gk+hyvo
 YnN/nn0ESPBQTP9BwZ+lknUROPvztDI2cAyH/iG4FMA8vkNr7LXtVHM4YfsvJaEvyif3etA
 s0tK6mcv9r4d8HoIHrvHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lDKllwEVkwk=;V4laeXtw9iFysfIld77f31ySKbk
 IaJwFmlUVUQFce6bkVWJNwW+pUZhYzir4QyPcjye4LMympoV7sJYWURhOzB2KsiWNtLPlk+fO
 +MCfDz/LUT73j+EcS+5aasejPDf+OzCIwUIN0yp59vFTYueHZQbovS/zBg4IUxjhEhaVVhhr/
 QuA1p2hoeVpOJHeH+u+bfFgU6b0urLQ8UBeSt2rwxk82TYosX5ok35YU7icDhIGsr+kr1oujK
 FLUkhyKsuxNeOFTLw/PITM+6VdqloH5dqRNxYe2CnBrHSmLfWSspIl1YzSiD4+0buTQhskSrx
 VVG4d+4s+ofBxbk1yN73mxXiEkIGJefOi5OSO6rjg20zKEOGAofw1qIlFzg153cWYBP/usUio
 ota0pug/hcgCniNrHRuvl+KzAHCVRTCl/6JyGjaDA1sT3YVrGLRk4x2vHzbV8DqxMGy/vbMZg
 R5z5Eg0G6FIbLfRojMxaFLQ3Mc20xUBN3OX2Xw6xtMpDsx4U1qANviktLG+pbWO8jMIhm9VwO
 kUwVW3w5CokYVWZhO0WiUUT5rjBqAyC6THCZ5ixGOQK75DF9FeT2OiuYPlRhzgcOMqaG6Z3cu
 /6tCxckN4OHGocohWpwMZRB+iVCta4fXXVuyYCW7UnL5AJ2Qb7BxDBA8wainRpUh3ORcwyxZg
 D7U8ZJMNMBEFD+2g9OsfJRiBjAklD89EQbZlvqjMD4Q5Z2bot9+CGm//94PJNKk8wuQ1s9csX
 9nx/OcDuwnhiUPDp1sw9QKd331+tIYRV+BCTMbe1b/Cj0aau1LMXQrrQaf/ZRt3fEMpND+jBu
 EswABUsVrCVte8AzNZ0OLTEf/v+08RCO8/mdhvrax7Bbs=

=E2=80=A6
> - Add an error check for the return value of alauda_init_media().

Does such information indicate a need for the tag =E2=80=9CFixes=E2=80=9D?

Regards,
Markus

