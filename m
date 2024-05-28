Return-Path: <linux-kernel+bounces-192786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E78D220F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC021C22B07
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FAF174ED4;
	Tue, 28 May 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="M3zXF7sY"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24C173320;
	Tue, 28 May 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716915351; cv=none; b=TZWnI7BAOEY3crnaM3L1HyfR7gO6QIGMKz7ic0Q1yYhdjyi7zsBJpAYsha32w/o2iX1sMu/KqYxFi2iH1Yd3KKYvqw9fHBThCTWzKIbGXGco9xzz0vs5sDpixD1PaVfOBaJYYabeWWBI3Ub0zAIqfp0UJYMDHM2w4qmt/932b9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716915351; c=relaxed/simple;
	bh=SLA6eZHc2BvDClBaKtUk96/I9vW/SG2jv7T2+rM/9UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opYei56lz/GT2Nkt50DZseA18wx3cW1+8GAtpCMNk0VdJ75zNkB01Y3KRwNAoFtaUHr+2p8j0ZP+bPtkIISe34xND29210dlGyW6YgGspbiyp8XwoxKbBrPqHx/80y/TnSnTr7XffsJNFbVJ8Xe6tVr1F0iFSJdCHWhTKAoa7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=M3zXF7sY; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716915336; x=1717520136; i=markus.elfring@web.de;
	bh=SLA6eZHc2BvDClBaKtUk96/I9vW/SG2jv7T2+rM/9UM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=M3zXF7sYSMvz/FIr/X99rNiBzhaNdX5l85aTETvdtocFHVVprpEfNBSUbjX14aJq
	 oml54UH37UeG2BZ/P895FAzCUW2IeF0A2K2fQ0j+pszPLjaSCp19VjLg+ngM0ialZ
	 1vTs20qWzLnRZoPauP2vRffM/NrAZDWXR8UigFjU7BC6dOPopScQNYSHuey+ysI69
	 eeXWN+QxZfwkJE23LVUVK+ZicqNK2vxEHGchObdzPCPeISSfysTqaYt3DfeCdUDFI
	 IhXOquKSGcrRdLSCJUZwxKocEfBG1lUROp/JFSNnjXz+iuOMK93L1Np5+qn+ariK5
	 uxqMbSstUIQMu8usuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MtPvm-1sULRO0Htu-00ukS7; Tue, 28
 May 2024 18:55:36 +0200
Message-ID: <f47d2cce-d955-4e2a-af5c-d6d9a73f85b3@web.de>
Date: Tue, 28 May 2024 18:55:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: soundwire: fix usages of device_get_named_child_node()
To: Vinod Koul <vkoul@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, linux-sound@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Bard Liao <bard.liao@intel.com>
References: <20240528063533.26723-1-yung-chuan.liao@linux.intel.com>
 <0080bd18-58e1-4e82-96e0-e64d2fa978c9@web.de>
 <9d5f2625-f3e7-4212-8c9a-c22f137f39d9@linux.intel.com>
 <a2036c46-0527-4ac3-a40b-c9c2cd3e185e@web.de> <ZlYKVtymA3zNe7VQ@matsya>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZlYKVtymA3zNe7VQ@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vjbGgrgEO17m1KpRt/7p7h7JOKdIpmpH2ThC2hYA3V98P8mS0Iy
 M0+eEQR7Arl3USdjIJ1VHSYjEqf8184pgj02+3NySBhsxln140mm9lenTnZgAHtWUk0Q6gJ
 opBFhiH6StReB7hui3lCvO5lMIj4V3hCk0APCKT8hbLPFfea5WmUB9UfMA0lN/yo647bByq
 2CfkdvqURX/yq0P6bzFDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xb6ziLytc6M=;9oKgqGAL5OTGMkyxV4qJ57TE1OJ
 VggpzxFsAQOhxFMwZNJF8R1XM23cIlcXxxRsbjfk90eKWOSPmKyqkHsy58cgPZrjBOlfh5wc4
 xHP+buP1BZBsJd96uyYBtGCScT4nC2LpOpD/Sw75lGs0atJsYekrFDWShx+EENw+3mJywLN2u
 OOLCQ9N4FE6zYwGPCTnFHjMYxz7JlC0DxXMQLrA3WgAW/MX9eDi6G6YYhY6hXbHg1DUq0GJcw
 cb/zVCStVi5URLs3fnka2dJ5ViVAhDx8Sk/RfUYZCBGiHv8Mx6bSFXJBR/5kzVZ/NWWWD5CM1
 n81lB/F412qjmdbemh3kbhe/XJBOmGUNA+Zk9CuGRSz/RP0LDPsppSdxxMlaVbkzs0udfZWJP
 WnygWXKfPn13ve2TRin0tsc/XM3/BqdoyTB7NphcvE3A9VY24FTiDATQSHcWmSjQDfpMoGZlh
 D8dKTv7psXCANUuZaSjGvhF7QlzOvngMuDeJK9xYo6RouVZhyCKZgy4HDrJQ8E7xRBGfUPoGi
 jGMYLhxJNY9kPdV5G/pjPP3HOpbYW8yZjf770fqw/v+K5ud1K5d1lKhZBOoJ9MwiJIwP03D+7
 9JBdtPQxazIfR7SPrU17No/dyOK6o5vW5lguC2X4y7/GnhlhI8orJQzyU/O42BUV+cqeJPrd+
 Z4ogBhxQ8f4CKfl9hwv4HRl04g8k0RxV+X0nscksY2AxHv8OBC4ovJlqJiRJCUY7aYZDYfly/
 UUa9ARnZ256Rj+qrXwzS2zAhizePD6D5ioObo5DSoa4ceQMn8nadzrM7GwYQnChmTyuqI3xic
 wX2gYGQmjNMfF/i6qESXXKjWtcmkkxQ9jQ+KvOO3drBUc=

>>>>> Add fwnode_handle_put() to avoid leaked references.
>>>>
>>>> Are you going to respond also to my previous patch review
>>>> in more constructive ways?
>>>> https://lore.kernel.org/lkml/eb15ab0a-e416-4ae9-98bb-610fdc04492c@web=
de/
>>>> https://lkml.org/lkml/2024/4/29/493
>>>
>>> Sorry about that, both Bard and I missed your comments.
>>
>> How could this happen?
>
> Becuase your emails go to dev/null for most of people!

I am aware of some communication challenges.

Is it interesting that my enquiry for this =E2=80=9CPATCH RESEND=E2=80=9D =
triggered
a constructive response finally?

Regards,
Markus

