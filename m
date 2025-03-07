Return-Path: <linux-kernel+bounces-550733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F352AA56363
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AAA171750
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B531E1E1E;
	Fri,  7 Mar 2025 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="fcEe3OsR"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6341B0F0B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338994; cv=none; b=Fbq2w0M+nl7rQJ7L8HV7znYQWbtpYCCmd+5RDP7KY+Gps3MGNPSu6x7mRuT46xHxLb5fJta2jnZJzsKwb0HwUEom7+ZKh/iW9tYGeBEnoVj8q7Oq2bPJILNJCH92LX6WSH4PdHgtXXd34TnW6omaxeMWjDsQRaNANXJzmNXekr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338994; c=relaxed/simple;
	bh=9B1x7tm7VGsWqJAdosAMjavJ8BGidB6ECj8LF+UqJ58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjwebSRUql2r4aDUCAu2CCEIK8wMpcXDmXLwGYG/CY8z0i/BsrQiTWtb2JFovHITbcnJTpVL2AFiQ7T9TT3jLwfAOcSJaDPJR7cSUoSKa0mSgOMxqWeJvKqRnY7Vka64I2DxbcP699g71vT2nBbVrm+DhxVpwU4E+/hrbPywzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=fcEe3OsR; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1741338992;
 bh=l7Bmpx1B1OFaUSgPQarXLFPl0uH+PohveX2hywvmfnE=;
 b=fcEe3OsRc7xbae5CqgyyySEBIQUuFBYWHER8WkWgvDT4/DWf4+lIdZUy4FMJgXgGRvP6zIMYA
 hcOXWzKa/dNJQR+8BPgiVZKRhRFPlRdsnBws+fLjIy5AS4cNTPmD3SwWTqPYTX90A6IgigJDX9q
 ZSm4lFHWaW/EXCvwyNqZcKq0o8MuV2ZZHnNNNXyeia1ziAubX5o1I578VdXsTrJr10lBdRt2cYx
 POvMLLlKxS/FPxWmpj76TVnljW5yFl/ORE67T4C2WUzjFcSuWzfss6lHdbhob1DgWnnqwSc/GHK
 RMaEs0NZlz+TZ9tOz9DW0/V1sraNgrk/0oYJ5mjQc/Qw==
X-Forward-Email-ID: 67cab95fd992817a57e35d57
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <cbd6d3ee-8ad1-443f-9506-e28240ffb09e@kwiboo.se>
Date: Fri, 7 Mar 2025 10:16:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Enable Ethernet controller on
 Radxa E20C
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
 linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250306221402.1704196-1-jonas@kwiboo.se>
 <20250306221402.1704196-5-jonas@kwiboo.se>
 <e0e8fa5e-07a2-4f4f-80b9-ddb2332c27ea@lunn.ch>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e0e8fa5e-07a2-4f4f-80b9-ddb2332c27ea@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2025-03-06 23:49, Andrew Lunn wrote:
>> +&mdio1 {
>> +	rgmii_phy: ethernet-phy@1 {
>> +		compatible = "ethernet-phy-ieee802.3-c22";
> 
> The compatible is not needed. That is the default.

Interesting, however I rather be explicit to not cause any issue for
U-Boot or any other user of the device trees beside Linux kernel.

Regards,
Jonas

> 
> 	Andrew


