Return-Path: <linux-kernel+bounces-376675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A237C9AB4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97FC1C2276A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882691BC9FB;
	Tue, 22 Oct 2024 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="m5hyNAMj"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C45256D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616887; cv=none; b=eKnSNYLCeYjFn0qeKmnZAxHGW9+zgyS+EkDrRMrYK1YXpEVVd0YjrHLjsWeTj/kb/rlAqG0/JvGO6rRlLYH4wJZddcJyxaS/vgKWd4p8V4PMtZCyYxtYx3WkID2VPxm4a111/5qZl+KTcMYZjjgs8JaVqGYTtNXsYPog0f9Bj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616887; c=relaxed/simple;
	bh=uSy5WCLE3OegrQ3JlMATraKL0cSEF+fEASJ7MnB23gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAm+OUd6hvxnj9A4XkCTI1OmyGrcyCyflI3uqlPPjINv6sHggeu0m1rAVzkNG3SihIrY69sb1kela7v1CsZvd9JonB9IPw4MClRYGqsvMF1e0I81ggpBZ3UfhL3nc5KeBwNVanaWRycR9iLeSta62+Je2f21i1DXFlOjiEH4XLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=m5hyNAMj; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1729616873;
 bh=ntkSVzAxzy7Rcn6JfP4Oqh1kowFYoM8B0tHurfPeglY=;
 b=m5hyNAMjwa70CvaWQEotpSxEueKum3p5Yt1QpLlXCEkH8BKJ5ihKAOIZ1uRZyHYMpSvgQFaAp
 HpMcspcmFfbNp+ks94WdXvoIY3UXbrGfz+O7UCmGvwBlANplK+kLQJsLfvleRqe6rbCEhogRXOP
 5UPCse+RuMyxbGT2yxwaxertiqIjK0pMRkHqzMROqQr97yemBYiw1iuRP4F4iAaEfcCP4dfEkNG
 9u1QXk+AdZkXqHJXx7V/JQwiLCl2TZ2PkgWZxCLSR0gYQjMWCRUZc8uI83kqBNzphAdWOZ/5hzU
 MBEpjYCstTurkah+03snITDIonr0zWJEcFjFmxoq4GQw==
Message-ID: <8684a5a3-48d0-4acf-9ed7-a035fca15119@kwiboo.se>
Date: Tue, 22 Oct 2024 19:07:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi
 R3S
To: Heiko Stuebner <heiko@sntech.de>, Tianling Shen <cnsztl@gmail.com>
Cc: Jagan Teki <jagan@edgeble.ai>, Rob Herring <robh@kernel.org>,
 Andy Yan <andyshrk@163.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20241020173946.225960-1-cnsztl@gmail.com>
 <172960632903.1476617.9941592027677995572.b4-ty@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <172960632903.1476617.9941592027677995572.b4-ty@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6717dbe4289888ca1b5a2b67

Hi Heiko,

On 2024-10-22 16:12, Heiko Stuebner wrote:
> On Mon, 21 Oct 2024 01:39:45 +0800, Tianling Shen wrote:
>> Add devicetree binding for FriendlyARM NanoPi R3S.
>>
>>
> 
> Applied, thanks!
> 
> [1/2] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi R3S
>       commit: 1e94bfea52bee081c42ab922c19156dd3d2bade8
> [2/2] arm64: dts: rockchip: Add FriendlyARM NanoPi R3S board
>       commit: 50decd493c8394c52d04561fe4ede34df27a46ba

I just sent out a review on this patch [1], please leave more then a day
or two to finish up a review ;-)

[1] https://lore.kernel.org/r/13bb8657-f048-4f79-a2c1-3680445f2bef@kwiboo.se/

Regards,
Jonas

> 
> Best regards,


