Return-Path: <linux-kernel+bounces-189348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ADB8CEEDE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35ED5B21075
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8D143AD1;
	Sat, 25 May 2024 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YjqQFezl"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CB418044;
	Sat, 25 May 2024 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716639086; cv=none; b=rETHzG8ZjfH0BeKqm8Y5fmTDVDh+2s82x0b0OYC1haCnS+ibu1SmvzLqYdxCdiEnKrdvz9pxb/YDmTUT+G4SvTc5gG/np0s+zSb/wep52qgPxWCVkp+Unae2b/X9oGHo1MpCP7Nb6WMY/4/WIpkVK3AY+A8kfJb5v+WnIiu+uN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716639086; c=relaxed/simple;
	bh=SxftTkzCLcAGk9saIdSAhL17nW8OhfGIhUmBh8dwrNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtwaPGSLRopr40g2Lh/8Xcf6LhHNC6p2cGOftWQxUN20EQpuNiN3hqzVVy5C0LVuh2miWt7dK7Cp0ZAJ5fYhZJ9JOG8ZYTE207+ia7w/8d9jkLTF0Mo8A5XvVn9yZstdaFv8ACSuEvVvgS+W591J7y4s17T0gqSGnwm8UduGQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YjqQFezl; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716639066; x=1717243866; i=markus.elfring@web.de;
	bh=oGuyy/VHQckd3cRSTJawLRY3MC0H+b0W1sAThyAgWmE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YjqQFezlxATkBtOxcUIHEn1v+9tJ9LJbSOl7dRHIdy7HoFSGeXuPxnphG74VEHII
	 6ZhJyBgo4ReHn4zdD/Uj+XERhLsW/1DDGwrifZcSzxklmfV9BpVFnv6Xk9qgOpOvW
	 WpD7YAjgLa2b7+mqcgctmArLxiwFlHyC1E5yORXOrgJ+J2uSE2/yMSbRIsd7HXzIH
	 nn8bfCwhv7MNs9Hl4P2kWh4itS0zTl8BkHcc+AULeoU3sIH5Xt10UDYju9QOTdn8z
	 FxabmID7uYAT/atJoZng+6IngrSSr4SesC/SD/It404RERt+8LLpKkC/aNvgdmYkW
	 QRXA/sCYtIg50Rgnww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP384-1rs3pW03Q4-00XcIJ; Sat, 25
 May 2024 14:11:06 +0200
Message-ID: <b52685a3-127a-4367-b11a-54ab88467dcf@web.de>
Date: Sat, 25 May 2024 14:11:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RISC-V: add Star64 board devicetree
To: Conor Dooley <conor@kernel.org>, Henry Bell <dmoo_dv@protonmail.com>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <IPHlm5mOKUzYfwGy0auyufx-oPkSrtQjUjiQLbtvspD69UPX9O98iB8P2mqM8ahNaerz0yUa009f4XABRniq7aj2PUp83hbRVVhhKmqT0Ss=@protonmail.com>
 <1b55aad1-1442-41a5-acc6-16baab90c021@web.de>
 <caCBlFpvjmhO9G1A1_2qHImmuoGai2NoPYonB5RCVftq4zIrSxlP8Msh9z_FX9GwQXzfSrB40dRxy1zfxZesOJENeebWQsERa03sDvArzec=@protonmail.com>
 <20240525-dumpster-bootlace-10123081a6f2@spud>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240525-dumpster-bootlace-10123081a6f2@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KB0lVXM+MsqV8BunvAuq/CNlANGmoJmtaXNBiUIOvgIcUA1zhMU
 Nas5nCALipDqrdlMZm2Hj5qz2plBIF/oI2iMCtsbycKkvWGXDtrAbr6BtWRzretNVYsgBlz
 +R4QCTMl/5UEng1DnVVZ1R5PCNlA5vQShmmZP5LHbhxXDklciosgM6EGOavkhmScBKlO75Y
 2ynSEMGrAEdkaq9FX88pA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c14ACTMRubY=;QJC4K/TMIoXaAoncU4CL816gqhq
 nXFgHOR0cu9Vc1GFRSUqiRTgo703b7+M4GiAnsjRr8GsU/vMXCGwPqfk9G9Hi/jjUclsBLt+Z
 Xba2bdLgeDA0O/Nfyzt1rXY+OCeQhmCCEVJY3neJp09TOWzaQKCLUPodSBX/0axmFrTR06a2D
 C/7Mn2XlvHiVKcDirqIymb7Ebh5MbxIB1fVhkK3odjGzV2MUferGpp89W8FPRH+bMA2ok0mgd
 x5/oKhVHHrLCpeqHjgkOPIq6swuKHnWDyPOjNFdCj8YXQghsLTAHKzbkl84FEiQtEGqsKDHET
 R2kZarnVO/KC/jTVjfKp/xKvDwep7Q0N0kbrjyqWW5bi21ZCHtZW4N37+sHJKUNQZ3hWSeCnz
 a/c3jENLXrNv0pIu4zN6KhGB0m/grDBg92pz4CjU2GjsZMfQbxdncz5erBy7S/5aj/LZZ027s
 MB3CXarVc+CAKkIsMNK2HZPgdvdXoyAvM7lzIx+4TwEnBI/2SwndBD0VedGvrl6PtivLbWHTM
 TR4f/nALz1nVHJjOqDdf5eeDg+RULTYLU6nRYySIK3AEIWwAHX2lX82n0ygBLEwouTWl2QDEV
 2gK/McUNqErZ/d7ftbgA+cUPn+KSgD3PCpUXMwtbqvSb3HS6OWMz481IY2z3GqNadN9qqskUg
 WwrooZhw8KqZI0i69TYk1fyipThGSnRJwh+wP2L+TUdmRNjOGwrp6J2IofHEKWZoFVOTloxIj
 s58FUdd9ODsSrIxRJjtRwD/9GeIUOJcwBAmLVf+ODmY9iNP6jBU7ldw7P47aoIQCUfARAIYLf
 snm5H+0pMhv8AEfrlcBB640n85wsSiNnJhrKnO6CYwWSg=

>>> Would you like to add an imperative wording for an improved change des=
cription?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.9#n94
=E2=80=A6
>> I'm happy to change it, but was going off the format used in Conor's  M=
ilkv Mars commit
>> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/=
?id=3D04a228aadb84d894721b13197649ca741f3018bc
>
> Don't worry about Markus, most maintainers (myself included) ignore his
> comments on patches. The commit message here is fine.

Would such a response mean also that you are occasionally ignoring require=
ments
from a referenced Linux development guideline?

Regards,
Markus

