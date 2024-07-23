Return-Path: <linux-kernel+bounces-260357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1384593A7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2630B22E21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42621419A9;
	Tue, 23 Jul 2024 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XlBep9ip"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0713C8F9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764090; cv=none; b=frOSy/+SdhmGQMsY0pAURSsE4zKeAs1FtItI3+jMpq24qgvooJcgzbbMcqJm2z/G12qpN24qv99Tfgye2DgSFt0yInWmJp+NnMD6Fr9fr+Ous61YeLtfAEDyTWkefa4cccTCyAjqPwA14qJ48QlnJULiBQqAPNOnxfDIU6rsJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764090; c=relaxed/simple;
	bh=fRQbHY/CEBYo8thDShk/wUU82ic923xk+yF7jnonAyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtzc3q9rqEnrQEQRm/xMgxVi6HyA+xYL/gF1xXEHY5LrSmjXU8d1PAS1K06UNsfC4ddXUmGbyDMaSw+GN5AbKfRRyqpGQQJR7Nmt9SDBpdj6yJQVFCpgmZics/UJ+BieFLOA/wW3+PowyD3EvEqBMSFtBm8fJZZ3tv04xZGm9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XlBep9ip; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721764066; x=1722368866; i=markus.elfring@web.de;
	bh=/DlLWB2Hi8qg00Gcs+GhwwxplxmqxKt2SOLUkNJ2Jf0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XlBep9ipTOVtvILAo5sGcLrF4x9FILgxzGeHxYPKdRgHUhrZZcbkSXryFwLI8c90
	 Dzx6nZN6phJWS+FyzhW8HnIqvfnENwRI9lKmakXWmjAOAouSl2wc8Bd2Tm31WydyT
	 dmrlI7z6bQEUqlNJXfV0Y57kqgXuHyJmmsy0hWW/wrKS9fhUX4u8rvO4VICTXhldr
	 qExThizW6T9dTJgYfq4Ior+lmTADyL2ASKJlfDvCb4w9vI5QlAoBTYWwIkmoq8tV4
	 /HueSvGbSxm5bH+CQRviBSU0I0NCfxwBGnBXlw5FyY44F+wQBjLDQznGKY5707Txw
	 1mhRuQ82w08ElCY9iw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MODiN-1sutgp1uhN-00Nz1V; Tue, 23
 Jul 2024 21:47:46 +0200
Message-ID: <5d2c6818-ed05-4e89-9405-859af5f3ede9@web.de>
Date: Tue, 23 Jul 2024 21:47:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/1] drm/loongson: Introduce component framework
 support
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240723183436.216670-1-sui.jingfeng@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240723183436.216670-1-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zi2dm3AwXyUPaRu3uzc/eWVXzSxbBhQH3Q9FWetpLiBu40som/F
 KomC+HH1opSplbkNM7rjlPJfjop0gIMSV1tO7Z5wRJpLj6esQLpEQwYZtJtnQqGfozfSOMY
 74IAJI1/fJDqz1pMLuiqZ5wvtRruxJHy4hTJfk1+kcv3jB1OJFQUFxcSQ/+ACKycmT4PAr8
 aRCipQ7z/wdbMiH82EgoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W8ntKnAQjxw=;pxlaryYF1akGHYlc4KvPIkDIS80
 hfPb20gWE8TaUqi1oQzGQVafxaeeWX/C8M9crjh7XLLXwxzsbSC4A8sUdURIGdbJM/qmHjcVv
 009rsNprDN+i+qZ3jm8GSLpSzL9D/4f7vzjN0f7XNcXaCn2VHtyjqRjTj3HXkLJ1tDlz5Alym
 yGal4xR/+aFDeBPajN6cg52xfDvD7qKt1mfNodoXqnNR7fE0UrCwd0Tadg4stwe8rI2EyRowt
 ZQuVOIFg0I3D+dSBx7UcjTgN0mK2yOdDP1JSX+5H+7fL3AAghLIbXBj6vAK5oZjVWhFr1mATS
 5Q8uXfHFVEFsI5zm2nVJqYQg076pU5kx0rrI6XBl84Gif8MDpEglBFCNXSuVfRYyn3m1u20+e
 PX/uaCF2ptHhyT0GwcyfCEaNg8J0OUq2lDyDGtwb/SFJDj+hw6aTnXIJzxuy/LqW2wOeXg3Zx
 nBPtLEflkWCcl6PrnlR5FQF+mGFebMQx33XXginNq8hri3jf4oXp/QzdmVDuPFUgGLpL0xJVg
 j2TgyWIuda6egU0HWR76balP/bIPEmEI0cvWwCQLsWlYTwbhU3e8hIAqWyDW7vre72kLp0Um7
 ADXHGFwtCpBjyVP0HfDhlZVL4K9r+j11zpVDPPx+0O8fNpaymNimXUOSWNwyYjas/yQtq4hWf
 Rb10gBcHPOCtnH6ZwdAMbKIyr/N/UM6R0zO+J2BCrJ4Uyzmr2nCX7MqydnhGryULDWf4JC3ET
 nEn92YNYf0mmdcHW77p3IC3ydhteHdfnItd7lo6cuIt2NaE1fm+0OkaLEG+R4ttd/HGAPdJg0
 LaSCwePvRKZoEzZHLAiDcIEQ==

=E2=80=A6
> v3 -> v4:
> 	* Tiny refinement and clean up.

I suggest to reconsider the need for a cover letter according to a single =
patch.

Regards,
Markus

