Return-Path: <linux-kernel+bounces-446392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2E29F23C6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8082918858FE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03535186615;
	Sun, 15 Dec 2024 12:37:38 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114FF1FDD;
	Sun, 15 Dec 2024 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266257; cv=none; b=qnaYyqyhW7KxEZXEcBSFDlZzpJiR4398P/9v6Oq6R9vvEGQ5trevf0l3Xci3GG5t79Fli9ktGvRgPY+Am1qHGhJG7wZzg8DO/duEqQd5UQ8qCxPLurTNeIDuk3iRtrsZ44ShMO7nmYSNNqYRaTEqJFGlfxOfuX+HB23iPQ743qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266257; c=relaxed/simple;
	bh=OZpOkfbESxnu6d7Y0qFdRgxsq2S/Zp9YQON1u8H9tDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OQX73OhUTI0SVnRM5NaWgePaBSkUSQQdpNe9QfdOG5M9kiZE1qrhbS/Ny7uUQZZlyc7lAQ5nnf0Af8Sgf79HhgNfdpMfU/0gLzdy/T37rffMOnHNz6yTOh1qsIcKfvlCmMl61LBocIlSJSrvV+g62vmkSDMFnF3BHyIQRGhATig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip2t1734266185tpv9laj
X-QQ-Originating-IP: d332b3DxG987l6GYDxOOcjJsWdVTx4kwpSobtBpnukQ=
Received: from [IPV6:240f:10b:7440:1:1cfd:4ff6 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 15 Dec 2024 20:36:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14878551336961208358
Message-ID: <6EFDC4E74A617E25+ed534e8a-fef0-4f09-a24b-a536b7f2f13b@radxa.com>
Date: Sun, 15 Dec 2024 21:36:19 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: default to host mode for USB on
 Radxa E25
To: Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241215083805.1461902-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241215083805.1461902-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OTgEduJtQQndkcU1R+o3g675042xghib6DTX9Nu/sCqWU057Wim/pbvU
	ODnDKpfAUZACiWp3w4hOsDPtdWUzwgOpo1rNkI4rQu4/lI+GJpPYod13T85XzKHOTyruyIx
	hsmCcGvnyKxVbH2uFmhj50W7xNf61ER+x/SKWJ4if+ze6LKj4HttsgWY4BqbqQEtrONFtg4
	65PPnE15HU0UI7ILVLUWjZt5ah195RrJigU7iSq+ttzh9CFhYL83j4Rqi7IhZHoYUo0tzUH
	RvGfO0GnbE9se/6K9NRdqf9jaqkWpZ2mOVIy2Jy96E5d38ozmClUr3SEmFuKCQYk61FFHeT
	+tkq8vA4fiSWzCVRvB8ZaNnOwdUaz13/j99yXzUgoiUYZxG3lr4/0FzHlSfgikRmmUZ5Al/
	oM9APjxGq28094dl+SiqibDMC+IZDlcJA3hFnFApSGggCRu/jrF1+zuNvkHYT0cNgEtPJ/o
	u/8LAW9KhBrWaD4FI49IFBIASZ/Eld+3JY35cJyvxM5brb0McFIoT0n7e+tiQlVXHUZT4yA
	yC1nsCdVPgnt+yb3QOOERj9uBG7ZtughNgazn+0wVp1fONSTe8rWh7Oa2ud6mLrg8NAw3r3
	NcEju7kGq9cc2e5nPc0+gRO8EaFbUyPrNzXz8+TiMJ2xsNHwN0KSjU0amfyA+NfK9ZzRPYN
	cuCglVgEr3r7VUqbzpiUz0ahpJRHKVd4uRlUBrlmbe6YEOSdtqJp1e0ow580xgiLZRsfyGI
	iCz9UxDSeJfqAV8qPlPBCqdzyGSSVpHY6RJwQVxfM1flhJol3iFXjXPKyhg6zcxXxKme7qT
	4G5M99s4D0hJgm2a7fybVlQcWU9dz20cHpv52n2DMcBNpBib0TAP3nu95hMvMirvvQj3jzM
	jMErT79KjEpw93DTxutd2EUxTrx8lZCPSP+nFMXgDKEAjBvQXgCWNUnVjG8itjnadEaoo1Q
	6HHI=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Hi Chukun,

Could you check Product Brief P.4?

  https://dl.radxa.com/cm3i/e25/radxa_e25_product_brief.pdf

There is "USB3.0 OTG Switch".

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

On 12/15/24 17:38, Chukun Pan wrote:
> The Radxa E25 board has only one USB3.0 Type A connector,
> changing it to host mode is more appropriate.
> 
> Cc: FUKAUMI Naoki <naoki@radxa.com>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>   arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts b/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
> index 98cfa3abb809..90a3cb54fd47 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
> @@ -218,6 +218,7 @@ &usb_host0_ohci {
>   };
>   
>   &usb_host0_xhci {
> +	dr_mode = "host";
>   	status = "okay";
>   };
>   



