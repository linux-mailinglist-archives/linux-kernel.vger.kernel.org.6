Return-Path: <linux-kernel+bounces-436090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8679E810E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1031615D4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45942A81;
	Sat,  7 Dec 2024 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="J9COU4A9"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412F71DFE1;
	Sat,  7 Dec 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733590038; cv=none; b=LWNZnL5KpG58HkCFr0+tvUbb8gNhozC7fAytPiCrKvzhhJUN/ERw1ZeLMfiVeCjdaonLNzz4YJgpv1ceodZ7/Pa0cEdlHCHc1sAmTEidV+OKlsNE/ZN35iz23kpkkI62SBl7FmhJjnni9G1RvNRW9LRWDmiOBWmFGkj8wS89G+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733590038; c=relaxed/simple;
	bh=H+Oh+SQ9e/k9ZZoRCvgRqjhy7xrEIfEvrzhnw7EXGfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBmNTB9m4jKW9MvOR7uV0Hr5mM5O5tdFHvK6U9bdVNI/jW7S+cg2PK4e7A+t5jUZBaw9+lnCFn0bBOr3NokbcONEdPgDLEp7yonzDVqbwsZtWIm677Y4hnsqfsPTBeF/XB6TR4rWQ4GyVgSQ7oz9rA7nHLxm3sqKaDS3DaZ4WtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=J9COU4A9; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733590028; x=1734194828; i=deller@gmx.de;
	bh=EwKG2uRwCNwfaTZvSODhSFMPBFVyXrtT4p1b2jNEAEI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J9COU4A9Kl/e1k9WNyOlFpWsZfzFk6eQHknopjOdKrU7RPXUPWpTivoqMry8TphF
	 3kE2k/j25UR5zljj6zmEtnHDxOAh9wjrxaowm8GiX6Knd6mVp0aB8aTqb0HNxvm3x
	 m1p16hHRkO3Vr3V4/xyBgLbYLpMM1dGMobrfxpRZgdsyWcSPpfCarRDsoABRCi25+
	 ajVMT7pnB1C7C3JUBFoB3dDBmY3CZ17PufcMbfSBD0Wr7iELOAkC+Ri6zVdXo5iub
	 UH9JOaXjLba7Q1t0gIEQRE8Atk3zG9x22D3pzysJULvHk6Pkc3dmS+tV8ppVl0njd
	 WT6K+7XWZ8mjKzWaHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpDJd-1tzZ7E3sOl-00cppM; Sat, 07
 Dec 2024 17:47:07 +0100
Message-ID: <a56f3125-eb95-4996-b807-7e8855228bfe@gmx.de>
Date: Sat, 7 Dec 2024 17:47:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] parisc: Remove memcpy_toio and memset_io
To: Julian Vetter <julian@outer-limits.org>, Arnd Bergmann <arnd@arndb.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241204080440.3721170-1-julian@outer-limits.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20241204080440.3721170-1-julian@outer-limits.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x653DcPLm8i0Qbh3y5GP1PV/UGRsWcOWSNRcxjITBxydkloKjhI
 IJOsWGw6ZOLl9K8/hU0kePzIhHMb5TNBMs9vzlV/laUcXU3F/bBcohslAPfHp1BW1QNiezv
 2gMVRF9ZlPUi3ebo2G94ksj0U/RWWUMosn0miLAYwRRwU42vLyr3mVmQVcdRWr2gCXgzoTV
 g5+w1baq+CjbxtaoKI80g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:30cyCkH/85w=;ZBEFq/W5CI/aIK554vsXyN8wOr2
 Db7gwFny3znRdAMN8M6ZtcLIPFhrbP6WBgz8iZ4rlBq/4S2q5/VxE7GSVmkx2Iyg0+/FbyT+K
 Q2ZihQIjmT0Y3epV23/a09/Fw3q86/2XreEgD7a1ZWDVZFejJKFaT0my+F3b8zOHthmZTeJaa
 JmPYv8x7DoBqEtoGMIHo/yfHX+KmYqY5BN7r8XDjWmuKoTDrQ8dYGrCKYt18tagVg/PaWuj5W
 gMR0xWyVVqII+d1GttPoK6Lu9FLx0OQAAE2VRqzq1pQiaG0To4f8/K7m6IqjBS0f1vkzQgGAk
 Jz8udPmU/gs/2H5eRIugIHvdNeQrx6Fy9jcIzVSCUYEvEcabH6JzVHbhGspDOQnmGqNV5ttQ+
 G51c2kNdH6oiPabDcqwKzgE+GZnYs4L5jpaM4fosHIGk2OyoBRQB+MR9+wiF79Cy8YycNMlzi
 5LtNccvEkNJ3PdT+u3Q2sSTW4GSxsQmbU4DnT/5cLPnt+luLoSuRNdsc2R6cIJxrcTAy1OhmM
 MHcH9IPObL0gAOmV3MOX/w7LOLUlD7q8YEwgJObX9FQ7EWayey2ZZRXh3xLglq5GoThli31v8
 3kLaDNNM9eZBESG/+RBl/e5kgZihohwqCZSUvjPeitoLNOuw87WC73AEIQsyMkYoe6BXDZUXW
 fg71hsjW6CxohXzkkrQ8uPtA8f3Or5963qkgBzsxBXyiFmIpnxRd8Ge1He/3dPxbOAbci4pKD
 8VwR4qeuVM9RMRbOdagXaL8TUikSRAH+RW4jGmDWDZarTOhtM2dWGTZci+aMULZkr0Eg7Qide
 oJ+dEWTHNYDYbq5M/n2U/DXXIjl2P/HB+T21Be0qSR18hl7pth6TMPnq80i5wu4vBakQ/+1kK
 gDbXCyLqGqXSMp5DIKB2nutZ3fgCRtwLjZpyfRGg5WsMqlhW+oHSq0WXCTnCrAo0JpZUmAOIu
 EJeTvkWh66nvNymXX4aJSvrjUbCwEJuNbUQ/icZY3mihidvit0ZarDzsqNE4bzznInrVNU8KF
 v18g9ORm6Sgy5m8d5wY4f/L86mIWDoLBpG6rR+bpDoFHLhVx5ushbQfwASS2MaZ1lUe//nuza
 uLMDK4Q+du2CzhKzsKHPTMd7VRT3UA

On 12/4/24 09:04, Julian Vetter wrote:
> Recently new functions for IO memcpy and IO memset were added in
> libs/iomem_copy.c. So, remove the arch specific implementations, to fall
> back to the generic ones which do exactly the same. Keep memcpy_fromio
> for now, because it's slight more optimized by doing 'u16' accesses if
> the buffer is aligned this way.
>
> Signed-off-by: Julian Vetter <julian@outer-limits.org>
> ---
>   arch/parisc/include/asm/io.h      |  4 ---
>   arch/parisc/kernel/parisc_ksyms.c |  2 --
>   arch/parisc/lib/io.c              | 47 -------------------------------
>   3 files changed, 53 deletions(-)

applied.

Thanks!
Helge

