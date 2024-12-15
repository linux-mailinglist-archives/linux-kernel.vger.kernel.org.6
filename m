Return-Path: <linux-kernel+bounces-446249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 069FF9F21B1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 02:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2121886EFC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 01:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D534C83;
	Sun, 15 Dec 2024 01:45:40 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CCAA23;
	Sun, 15 Dec 2024 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734227140; cv=none; b=IoomBJWbL7JADDurFIbZYVPRBBh7Uz7zXDcf44l/vy9aB3xXTqKkQYxiB50uoGP+/W/cTsuqXzgFBG2xiJeHAWhfsh4UTOdlZT2Y6H+FNPEhDUpnwoAe/aaQvQX0CZKx99g6ezMQ2iJNua95No4SFIlkLH9jx/rIXuIUOgIkU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734227140; c=relaxed/simple;
	bh=eSE0SaSP+Wqx2w4qAMF4TCtwlsWQNERN9Wf0nIOxbhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZeiYyZttkAuu6vQyDvkWGZ+xV/cEbTdEJMAs7s9JRTqFYqeZ5b9BLggiwik0bifw71YWwbKtB93ZhjID7QmO6Mr7Ytqwg2VR0uCaR4EO6SqlzscyztzNtXq26yCjWsTOjhB72mmO+9DIo3CKHdCJV//zJ6ZMhz4kRauK8b5HK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip4t1734227058t6vbjsi
X-QQ-Originating-IP: zPcfSi9qkyqfIgt55XHkoey8oDBUbe7YixRuGvw4LeU=
Received: from [IPV6:240f:10b:7440:1:95e0:ea9a ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 15 Dec 2024 09:44:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16386420016045931350
Message-ID: <93E0AA29EA05399F+f0e8d224-c30d-4190-9649-413c00e8f2fa@radxa.com>
Date: Sun, 15 Dec 2024 10:44:12 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: dts: rockchip: Add USB-C support to ROCK 5B
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20241210163615.120594-1-sebastian.reichel@collabora.com>
 <FFD6E87BED20DB1B+38b8064e-9945-4cd8-a30e-7800a8c6f37b@radxa.com>
 <3D830E407DCD15A2+de00ea1d-96d5-4766-9dc5-616fc76f404b@radxa.com>
 <iloxbrj7ktqto5yphr7i3tioq3cbecqwu4ovxmezovux3nw7t3@j2siyintvy7j>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <iloxbrj7ktqto5yphr7i3tioq3cbecqwu4ovxmezovux3nw7t3@j2siyintvy7j>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NH+zXwSPp+6sJ61pZ9SF4Si9iMMzaL0h7ncSntkoIIuRpexfrCvDLnqo
	JwDhUr9yXtv04+FWj8/+xT+Ca0bvee+qQILbYdHSVfzRjWr3c3Id4xJXSSBKYGAW3wqtDLM
	IM6BZXvtzoqKnKdGWa7PWFIKbdf1EPwuUWVMEyuoswNsvU7MQ7LZk440cEyiQ8z5YdyVMgO
	IC4w6q9eUgEqztvJ8MjVosksoHSRJjTijJmXIJ3UjKrCLq5IQX9HGOrKR+S+8GGCwPGVWa+
	bCRmdmAMwtef9XKqTi4/4HxjC1PWcsKwBZAosFQnjo2rKPnsID1Oqg/4mfl1RdbQ1hJHrH1
	fJq2A/Z7PWMMVaTuV6LVajeGPcft8lzmWRtfR/ojF5tSVq4wN6gvsHDmeAYfjKeoeSfLNWm
	sVve4ybVFDhQG9FIxMF82Xg28MTDOPl74nftRmJQqRzevp3hQuQ8tcY0ZBJB9xQKMUFlKXC
	UQXelT81CFw8JQXLbo7tbqo3yoJd0dudYXzzTCrJtBep41GoWpic+5ZvSHVq7v6RMai61K0
	CDL0EtIfm6nl+0FFvoQ+QAQuNOFcQky7BRflAjrzFHlmdATCT2mVponUDiaDWIkAvRQsEll
	T4y7dIPlx6u3zH7cmjIdrHz7NfPlUH0mVa4ZDxdl91wWG7IU8OApOoL7W7CBlQltNMOCcPc
	F52wQeT30OWpsLHNAEousrN0xx2RwOgdGjEv2YWkxOOKkyjKfUCRwnx5oRIu1Te6ym7HJu7
	79D2C09+W3d3g9KSAXSyRYzwXpXxV1RE7IS+BlWpgfLeNiWuuoWgJ6n3sFQBkYb6N84F5W/
	kigP4D3yN8MZlY/6nEIwb3qR9PLrVzD26i8CjypJf7ujPah8DEfr3oSchwkxiDbOsR+tfDO
	asDb9F26UdIdzelb88JgSqVob/weMflPEtV5bx4sNxs=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hi Sebastian,

On 12/13/24 04:20, Sebastian Reichel wrote:
> Hi Naoki,
> 
> On Wed, Dec 11, 2024 at 09:40:13AM +0900, FUKAUMI Naoki wrote:
>> I got random reboot during booting kernel/userland...
> 
> That is probably related to USB-C PD communication resulting in
> another hard reset :( Can you try to get some tcpm_log() data
> from debugfs while the board is powered from the GPIO header or
> PoE?

Unfortunately I don't have such a tool...

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Greetings,
> 
> -- Sebastian



