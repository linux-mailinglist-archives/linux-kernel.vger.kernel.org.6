Return-Path: <linux-kernel+bounces-228788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A80D9166C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9D91C237FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A48614D2BD;
	Tue, 25 Jun 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sFBk7ez+"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530F44C9E;
	Tue, 25 Jun 2024 12:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316858; cv=none; b=Nkv5oSsqeT853cYjUuKRVogrLL6lQGH2I2aNYBIWG3EopJDqXFren28fFtNvnTDIIUAkGYn1V4QHIAFo7MRCR5N0g52xbYm0jHY8m983j8kcvaYQIMt9A4nQP9pTd2iVOMzElPQ+ktiIMqEVS+DtR8nqdQgY1PshxaZsjUPpOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316858; c=relaxed/simple;
	bh=nV8EQhdVfjwA7JCFBgocPJknEFZBPmI8Rb4r1ePjiDE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GBXZzS/xD8iCDATs8blApcNMdZXWzByFLPSLwA6ukUUnjA7+w0+zB/NKWTpaoYPyhJyvpHnXcf3V09K0MVjQWovRjhQlqoz3P0Ts/SgGw2iMFKHgNg4L1ODvsCqH9MOon21zIcaT7GNdyAVlyCzLB/OyytpMUnl7pYJgMepE/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sFBk7ez+; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719316820; x=1719921620; i=markus.elfring@web.de;
	bh=nV8EQhdVfjwA7JCFBgocPJknEFZBPmI8Rb4r1ePjiDE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sFBk7ez+UH1rLu5gwotCV36zUpmzQDQm/amBjsErRIlbuQQVbxmAXUU7PXVb2xKf
	 Ofj+x/BYAo2gNc0Y2r3HqgfdbgbzkLQ1NtIFnwtL0LR1T2gK/saI5Wv0vaxJZ8AEu
	 IX7P+lOQtr+4ECDgR1p7/Advch3l8qEcIs03Gf6AVCSEeTdIxRmJHp9DR9u9QDFFN
	 gwctNoIo/eBngu3ioKjwretwW8tFJ4IMUbhKcutb1z2RfNcMY4yAh6vMH2+h3ndbR
	 P8VAexRePjAH2G+MsqHT8SxgAOE31rnXKakFgKnObWhmcqznwvPdE7cPjA7/6Ud5Q
	 /G7TKXS0hCw0tJrNMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLmo-1rqkSH3yJ0-00OW46; Tue, 25
 Jun 2024 14:00:20 +0200
Message-ID: <edeaa699-7cfe-44ed-abde-7cf3d3efe3bf@web.de>
Date: Tue, 25 Jun 2024 14:00:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, linux-aspeed@lists.ozlabs.org,
 linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joel Stanley <joel@jms.id.au>, Neal Liu <neal_liu@aspeedtech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240625022306.2568122-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v4] usb: gadget: aspeed_udc: validate endpoint index for
 ast udc
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240625022306.2568122-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WVa6AenrwtXGDQwCcWoxbgw+LKV4V+A6XRWd/cms6/7gM3UruC2
 W55cgmEsHf7rJ1egtv/DYzxyxmf+mpE8zVssjVA8cWkJFSGeJ3PJn6wgm3LE7L2TtykeJ0V
 qXFcrr192CZEI7PseoDPhr7Bb0KI4eo7LboXxYefkvv8YJyHngnLmFnxdDdKMk5uHoSesPx
 f87llrL1qknVoUE5h52FA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:d0DxsRFHnpM=;39WEZlnVUSXcpVzJf2TNAjcfdTC
 qneCOiATJ2Eo+K8g5pM0CXNFoJlCvei3fCDXmuQdnaw8nZo+SToG5+j2wm7ZBApJ/V0QX64j0
 InGaZZVLjL85xlguXXTMxenwE3fs8mGQLbRaZLqHG1OxAhODpY1mTSUaiOFLEapoL94Xhj20l
 T+ngoClCO3fKRCxHuDKmVJfgvll+Cd62pdwsZdtqpbZ7pv5Qz2b1gWgJWaUJOaOFgoL5ESBkV
 NCC5o5NWSBcFJDzmMuY2MY1SR7Sr+xQpFcdNNj5Jyh/sd64NFPB9kOfscGPr5E7OFG3XVW2My
 /9LWVu5IxyB3Mh0aWAeB8ZXHxVHfl15pHXrbQOrqSw7MLsrgL5q3WqgO6mnI+1cL5EGLQ1nyf
 jMv5aFHf6YDc5N4bZS6h4Azl4i3Fzj+dWisc2adb7tHkNjYtM/EbsxQ56+NeSJsZVypqb7MhA
 Ad1nPkUhiHV0OVwGm0s6ZlDsFwNB0ImN6Jr9VrPWFfbIOu3Jdb6sLA+RxAD+kCCH3AW9vVfEp
 dAr8B+ciUWVn5/tfSCO19EBQYzcEdQr3RtntscSmW6ZEjn6r71H+udqcMLTXr+4Fw9Wx/PWrf
 ezvN8Crzo4DPMd0ZPqmIIadSMd98mFokyZk2u1ORjcdyUA5uK1tWGX7YsGvnbuq5KBkSfusUr
 qKHrwelFrpRFqXzJYA3KrhMguT8trK4/nc3LsiaDjqxjj6MdwfOXAyQ8HLz1xJ5r5OgNa/svI
 WzsnjC2cFnWxnK+tQ2y+nhJaQA9eICw56MTmjgK7fze611FTkBd+qm7G9K3gvT4RypL2K4LRP
 S3KMvS6na6fjJlVDncunwRs+UsWouhnyEImat1RWXmayc=

> We should verify the bound of the array to assure that host
> may not manipulate the index to point past endpoint array.

Why did you not choose an imperative wording for your change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n94


> Found by static analysis.

Were any special tools involved?


How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

Regards,
Markus

