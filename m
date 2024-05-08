Return-Path: <linux-kernel+bounces-172737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DC48BF5F5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63149B21D1C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35614273;
	Wed,  8 May 2024 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="awMSAFf4"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0B21803A;
	Wed,  8 May 2024 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715148985; cv=none; b=T80iKMWpZ4YOam+wKhD5UGe3PR4TCkpH3Rk/MGhlM7/nxSYc3M8fSehI476T+H4NtdLXJVKmidnsachmGoX9QW0nekwoCv54WaPowkz3DtEoPnM4pHLcpDQ06quQ7/mLcRh55T50/QWCKWAC05JG4EkHVQP7GrWYx3nk65JKPwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715148985; c=relaxed/simple;
	bh=QC5Thq9srz5G9jQykIi/plq13UhWWO3cREN9A1t5BmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmzuyAi8wv+ZBmV6tnEu3a5hR2LYIYu3fENwEz7kOJdCKweyDt4znRlGqt8A4BQoXeSJQU6zplv2UXtDYhtxmlyKXVJxC2r1XuWduEe6tMME/oMPSkv7vAWPkEFi/e54hH5mI/aAYiBszu3qfNUUshGg8tfqPEbROai6viWR5jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=awMSAFf4; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715148932; x=1715753732; i=markus.elfring@web.de;
	bh=QC5Thq9srz5G9jQykIi/plq13UhWWO3cREN9A1t5BmU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=awMSAFf4OdfehQFVbXUvgwM/I0QWafDexZx8dK+IrkofR4bbJGOpS5HmWQlRQ8AO
	 nwG1VfvF1G+Kzol7He0s2KX8duUgm5a7kGOwpPkMdk1+VyNPpl8FINX5CD9DiQoFM
	 JJiJYSHwm6Vhos1v4pA5BUtpYRop9QQMVHszeNrIMw4GXhcOsKbFAmbUh1rNsqEi0
	 4NkiMEC/Gz5y8Icbw/RYzrfrBqR1xmBsjOnESdhTIqyA9yOikTL0hKU4Lp67OGTL2
	 xGnG+Z1Tf1u44ioyuiH9YAuGMScjnzcURj7Yjb/e72oJyrcBv9k6IM3iiQG8yI416
	 is9Y4H7sNvUpcJFElw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MXoYS-1s7yGW0iqq-00KrEi; Wed, 08
 May 2024 08:15:32 +0200
Message-ID: <78d7c0bd-172e-4049-8c6d-3f438f6cf40d@web.de>
Date: Wed, 8 May 2024 08:15:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5] LoongArch: KVM: Add PMU support
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 loongarch@lists.linux.dev, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Wang Xuerui <kernel@xen0n.name>
References: <20240507120140.3119714-1-gaosong@loongson.cn>
 <bcb7baef-6042-8e3f-dda5-69084274a0de@loongson.cn>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bcb7baef-6042-8e3f-dda5-69084274a0de@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iGtb2zn36MxZ7vfbF9REWRDWCL8zDuOUhZrKQCbAcqwdZxB9Q8p
 2URD7gOfWa1f2mSUIwdhbFlbxodEA/+HHkuTwzk/F8A7S/golylHKXFnsIEvcbn3wkqAweu
 AsWGrGp347Jx7ccP7nOvX8lPeU0u8JJVvPWJ8sn4jTFt4Ph740ECVOw3iVjxRqfPYbeBPsP
 nXcCErru2fVJimGNSaM6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Bamw8UZIMhw=;b3D+mSHsc9GTYB8gDG7hiq/HZHd
 2Mb/vcArTkb+0dKQXhCXSYLlS/rWgTBq9qGnkjJducVrk4h6d8almVfrMDv642jLfZz0Y+m1+
 nVOD3y2o4OfVi3YBoYaWLVuu1XHBCoyvq5FfYBSTVTWUSW5svAM07jRIg5Mb85QlKh+2yAPRN
 wUOGk2E2VX6yJtX83bzJ0MY76/ntIV7IMuM9i4yyQjiYyOwhAHiEFPS3K4ikWNznmhMXqvVbB
 OItn/1nYv+6uSXKlMXfNjRQ3CFeCFVt8emRrMMp/1EVNzNQKQutNfcNX2E56X/mcZiEnvN0B5
 AXElR8Q3/7uXjVFGVebaiQpKlBiQlA9naJGnGKpC5t8rIEFgYfghHsE59H75CdjKBch2diwtc
 B8G4mFQZkLiAorbafLn60d1DS6IJpml5syStzPwWC2kLyU32JmvCttTJfWr8C8/t7R859xrQB
 lKUillHxmEqHIsogdow/zh5WwiiOo/DNEe4/sSCG4NPRkPk2MtPr2wvxdiYB6k16WtgRzeQfN
 K4yTsqP/FhDRTxn9UWg5DJ0WWlv1WuYXiQBxtrtMg2ZTgWemGmw/gLwSCITXefmUSriEFWswO
 OI4++LFK2N80BoR5H2GXt8cNt9JlccU4hEphihVuRm7aWwfqqStw0U/t3C2Xv56nzAPzA/NJr
 E211hnRau3D/4ICRwz/Mb4seoa2i8Tl5wFpnT60QF9JbntyBp/j/AEhGQNhfM2lKeNaS4ngbF
 dZMLj/tw8Kg1oa3NTTfiIC/UTmugJBKN/i84rdQoVQM91ElhOyrq/qz52TUwm8ZTjLXENjal8
 prqLxZnyZRh0Akv7Zg/vTQ3/XzDzDTwmHTLJSPhj1kEig=

> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
=E2=80=A6
>> - we save the host PMU CSRs into structure kvm_context.
>> - If the host supports the PMU feature.
>> =C2=A0=C2=A0 - When entering guest mode. we save the host PMU CSRs and =
restore the guest PMU CSRs.
>> =C2=A0=C2=A0 - When exiting guest mode, we save the guest PMU CSRs and =
restore the host PMU CSRs.

Do you find remaining wording concerns less relevant fur such a changelog?
https://lore.kernel.org/lkml/c4ff2987-df22-4338-8a78-5efa2c7c23d6@web.de/
https://lkml.org/lkml/2024/5/7/800

Regards,
Markus

