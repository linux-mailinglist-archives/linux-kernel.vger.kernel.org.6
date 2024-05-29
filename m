Return-Path: <linux-kernel+bounces-194613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4678D3EE6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0219E1C232ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F871649C2;
	Wed, 29 May 2024 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Kf5vGIBc"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCD1C2334
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011042; cv=none; b=BHZGLq160HUzW6HA+L02G8wVP1B/infBZdAQIsuD3h3g+aawJ+cL1w0TLlPtyla7qh88SAmpOi/2n/E4zuFru/KlAcgNgjea2xibGy0S+T0PFF+guhPY8nFyMMDijW8AjtOaslhPdHt+ARgO03EVMwQXkcXlCoL3VLfSyN3u5Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011042; c=relaxed/simple;
	bh=0hEWMpNxOOb9mPZgiAwdAjipoVqzznaIJ89tGawa4RU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FImc9h1mCcWWI4ZDqwbi8PDuzjIxsAdKASo/J/rcQqViBlZL02NEvX/ojWty9lsru60jtPG73yzWCHLvdBLhLdSSN8Yoo4TcpHjBf3RvHgsr2gzmAUrYP0shWdEQM1ZsO3vE/n76mH3Xyk0iWhOwdI4qi7JGHAeBaOep1kiGpKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Kf5vGIBc; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717011015; x=1717615815; i=markus.elfring@web.de;
	bh=bbzX1MxWjpxxbJ+sOkPy+gRbuUmxAhLOgZU4L9ad+/s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kf5vGIBctDLSQ7Mpc+xcmnT/N8EA7+wFvcpqQqIimTRlxKpKed/n4iggPOmo2QNA
	 Qe824PD4p6NjZda/qi5akUk+Oa4V7FgMmbj6DZf1SM4p/vHaPbldpJ8BV1K+QL9dq
	 FdLxJ+O9QY6Dp2PZRS19BmGaa500/ZHt+8hib9Ys/e6tYQiJzwcG5dU4jtSQVK7zm
	 kFz7wDJu28ZxWwaA87LflBOCTXjd3JR7xkLwC3t7VtNK7wrnvlI+i7a2XDx36c8y8
	 nqffnTx/FO3tTgsCglHQphTmqT7NpylRxlaDTIyolfUd/jMhA0u6VQVAE5l2S/3H8
	 n0eLMAlsp3dIsZYARg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3m5B-1sBZmm1Iup-000qHH; Wed, 29
 May 2024 21:30:15 +0200
Message-ID: <ce2530fd-d91b-4629-944f-9d7c6826aaa9@web.de>
Date: Wed, 29 May 2024 21:30:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Mike Leach <mike.leach@linaro.org>
References: <20240529133626.90080-1-james.clark@arm.com>
Subject: Re: [PATCH] coresight: Fix ref leak when
 of_coresight_parse_endpoint() fails
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240529133626.90080-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TlCo3Nipf1nsBBvuDJcjM5JNj1as0ULcgEX82rLAWNdp/JUjfi8
 HtcSHnEB1eUBRgAfonooeBoTAuFUCkozPWrwGtVa7c0+K10jrG+sonWtwadANClCDJxn/nI
 BfrRQ2gNjSP9lBLcWjzsoqVvSqZ8Rzc7B8Rv9mcKn2Y0yv/1GaXk2ZR2teZ+60FWxKi1tqT
 WkAMF+xc0bj1biOH9aj4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RRdKGRk+uH0=;Y7BP0pnVlWt4PQIkw44SvmbFAE1
 PNVGEFdO+sadg22ru2yPRSGgr4j5coRnCrjX80hnzWsSRMJj0lT2P2AILP5qyqHpeOO2AjFkA
 5QYmj7HiKPLgR82BFDx5t5zKq8qlLo0XuZUO3JUF6xOJww/qIqVw7sbQE4+f6KhURtglImh4c
 AOOKF88TiCvO2wyI/PGJpspu2enK29mZUNClI9HnjUuKCPHPzP6d7B1j19smEMU+hB13iZYfL
 CxDrYq8iJeOD6+Aw0ZWZFUxdp9dRjlFv7tRaz7t0vDLll7rjKqiSKkc7JWVOF8CKUj268Hy72
 NzpI62WT+lFhi3ll7sViIfpINnF+DbmH+PIFH7Kr6Xp+UXDBX0CDX2NQh6ZVo6di4EPmQXsuo
 yKVbCYFTYukxkSu9Y10V6y1ERzvR6EzXqQNLwi18nl5goSydgphSp7Lcu/KGKP3XKAzGh2/6N
 Cba2SRLzTDBFgMvpngwTiYgwjHRTP/7zNBO1Nph7bst6OBxIJcb0hzrFD7fFPehcONWIx1rzk
 8b50ueW/sJNAGUYERQupbwjQS5o9993awnoUqMCteCJJPJwJv7VUzZeXwsKvct0P4JLzK7Pu3
 z6UvtkHwJik/9kzlyCi/MXZl1/+wy/mNScq9HV8VnsqRCikuV850hmNjLRX5OzekfQMFOCtNy
 5wCMFErRmCa2V8eXBLqFhwX8Z6qkszvJNPOjZVmPeNwN6L8Tm9ERaVwn0MdH2Xxktk8VY9whb
 6Qc3iN++U9AgQ8b7N12eugwSqbHcrxsnwvZKU+4sQLDbgRNCnZFLIRWzjw+afbWCLGt69ayM8
 MYtIgSIMOsSpHTdESjE414IigUdm4RoSxXlmuAS1uFa/k=

=E2=80=A6
> Fix it by dropping the refcount in the exit condition.

                         reference counter?

How do you think about to use the summary phrase
=E2=80=9CFix reference counting leak in of_get_coresight_platform_data()=
=E2=80=9D?

Regards,
Markus

