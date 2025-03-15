Return-Path: <linux-kernel+bounces-562413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF16A626A4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 06:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0884017F7AA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 05:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE5E18FC89;
	Sat, 15 Mar 2025 05:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="StHdj31s"
Received: from mail-40138.protonmail.ch (mail-40138.protonmail.ch [185.70.40.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAFD78F2D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 05:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742017058; cv=none; b=bje4rJUWj1+9dNSoiQOlby8mL5N9EMfnBXy1T+oqwAb83alOLwkuS8tkbp0b8o84/YkFFh4v/nD1/q14e8Q3YO9s5eE+YPuW85wuLzqEPHlCuYobEV9J710rhYdpvHIcz0CXaATleybkxigs9v8qitp2E8nOhDAgFGtz7EuuEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742017058; c=relaxed/simple;
	bh=5/yrLiB/r6wFXSPSNvWh4a1rLK76on7CtsQzhmZxeHQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lKrQcULEv2GEX1lavMpJGsw+dBY7BaMEwMhkMfYfeFfWVlTcIUyYF77Xzj1ppPPDjvB9JBHAD0qEuqfgs+V/JsB+l23mks+NECGZTMUpU7GuInduzcexLReZxYe5Kf4kDhsO3Oz8Hw4Fy+g6vILFc1dn6hJ92/3dWARChinR8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=StHdj31s; arc=none smtp.client-ip=185.70.40.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1742017048; x=1742276248;
	bh=5/yrLiB/r6wFXSPSNvWh4a1rLK76on7CtsQzhmZxeHQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=StHdj31sfEPe89NEnpOrKYg2+yXFra733NWTVDR6TXD9vDPHtRgMKBWvKNkDSqydI
	 pU/fAJLIXoMbeSdSfSvdIIz0dSRDfSXsT57YJX79qhIAMkoQh2HezQoOWIZQUx25Xs
	 xb91lhqGwYElPm66Qr3uqefUOpBw56/i/mjwpmX4qN+IXT44cHIoCpcULob+lJs/CS
	 hjGpMsWV4oXJbbxOEoyMy9dIwFQSdr+FcM9uZW7hDqC3aWW1ao0HAXy3lXwTwVrNIX
	 mDKkDHFEpk0YbQGPOI0PswVhYINFVdeG+1DK7nIHq2SepnCT6A6u/rhf9m/DnNscYe
	 gNhO+hKBAsmBw==
Date: Sat, 15 Mar 2025 05:37:24 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Singapore Government hackers have absolute control over Teo En Ming's Android/Linux/BSD/Windows devices and online internet accounts for the past 18 years
Message-ID: <FVGSxd1MnXRpE-pFRUfir1aDE-OhtwQdkv9vkiVh2814rWpmpa1GTNSqiLNd9cRoqCRC5zlj1cIynt6wGbgZ8rz5rJP6aPtDPSHIcZVuU7E=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: fdb33a11717b43067bb772e5fefd3ac012bd0a05
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Subject: Singapore Government hackers have absolute control over Teo En Min=
g's Android/Linux/BSD/Windows devices and online internet accounts for the =
past 18 years

For Immediate World Wide Release
15 March 2025 Saturday

Good day from Singapore,

Singapore Government hackers have absolute control over Mr. Turritopsis Doh=
rnii Teo En Ming's Android/Linux/BSD/Windows laptops, desktop computers, se=
rvers (collectively known as "devices") and online internet accounts for th=
e past 18 years or more.

Singapore Government hackers have persistently hacked into my devices and o=
nline internet accounts and doing whatever they want for the past 18 years =
or more.

Do Android/Linux/BSD/Windows and all the other operating systems in the wor=
ld have Backdoors for governments in every country to come in uninvited?

Singapore Government hackers also have absolute control over my online inte=
rnet accounts. Is it because the Singapore Government is using Government M=
ind Control Technology (GMCT) to read my mind and thoughts without my permi=
ssion, and hence the Singapore Government is able to know all of my passwor=
ds by mind reading?

Dear Singapore Government, please stop hacking into, stop controlling, and =
stop doing whatever you want in my devices and online internet accounts. Yo=
u are encroaching on and violating my human rights.

I tried suing the Singapore Government repeatedly at various and numerous I=
nternational Law Courts more than 10 years ago but they say they have no ju=
risdiction. What can I do?

Thank you very march.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals in Singapore
GIMP =3D Government-Induced Medical Problems






