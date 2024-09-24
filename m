Return-Path: <linux-kernel+bounces-336490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D72BA983B70
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678FCB22352
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 03:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D5517BA0;
	Tue, 24 Sep 2024 03:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="jvCf8PFi"
Received: from mail-m1973175.qiye.163.com (mail-m1973175.qiye.163.com [220.197.31.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A92D2FF;
	Tue, 24 Sep 2024 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146952; cv=none; b=DLRuzmOXuibcEGuIllDT6pKpyqETjlTv7NXwBS016BGbicBQLAp7YZ3YW749Op0VdDW0P/2b+VmFcqxG5QTEmoQfEcwAvLCfnyQ9deubaToQzS3STUaCFCjnhHHDscwHM1bzMbqMiWekAbkk9ET0L/lmqJGGdczY9DsIsx3+rUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146952; c=relaxed/simple;
	bh=pXwZnEqjGSb09lASMjE9q0+OExEmhL3BAWRc+GzL+5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjwTZGjfJuDcvWBy+I9s5PhfSirA1D9KsEX/q8q/zOffdyAFE5HE76qIO7nJEvw6nvTrQhC4PZ6tRbD+1e5kefBr654lageyuI6rzFW+CmIWoqS6ZmNuM3EZHz16MW3dVT456y7L7K3zKodigNOS/zBjnCbj5KWjIK1BtuPBysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=jvCf8PFi; arc=none smtp.client-ip=220.197.31.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=jvCf8PFie7Rv4vvgABNuw63KB4eqizQfTPWzFKAXlNhMTWshgMx75uGiMPAcHiTnBDrQu+MUZ7t/pD6/2Q50ryzpCdaV62WZnCl8jFkxXX5gi6YAVZXoOXKf8JTelVKC2pLC4x2QR2X18vN8Y8v9e3GYL7ZRJ/xBkplvC5LzSHk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=4VxoVrkVPVRnqDaq696soZpD1dpa/vvXgnZ7E6DnQJM=;
	h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.56] (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTPA id C6FB22803AA;
	Tue, 24 Sep 2024 10:24:15 +0800 (CST)
Message-ID: <1f996322-e6f6-4dd5-a1d7-c2bde92c876b@rock-chips.com>
Date: Tue, 24 Sep 2024 10:24:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, tim.chen@rock-chips.com, wmc@rock-chips.com
References: <20240923025326.10467-1-frank.wang@rock-chips.com>
 <snccizbw6thn3lhwad4xppp7vqii4p56ttl2gufwc3ke7vfckf@e4b7nvwwtdfr>
Content-Language: en-US
From: Frank Wang <frank.wang@rock-chips.com>
In-Reply-To: <snccizbw6thn3lhwad4xppp7vqii4p56ttl2gufwc3ke7vfckf@e4b7nvwwtdfr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDT00aVk9NSB8YGB5KTU8eTFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a9221d800c109d3kunmc6fb22803aa
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBQ6SBw5KjIzGUMvAQgXN0o0
	HjIaCTRVSlVKTElMSk9PTU5MQ0JDVTMWGhIXVR0JGhUQVQwaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9LSkI3Bg++

Hi Krzysztof,
On 2024/9/23 17:31, Krzysztof Kozlowski wrote:
> On Mon, Sep 23, 2024 at 10:53:25AM +0800, Frank Wang wrote:
>> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.
>>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>>   .../devicetree/bindings/phy/rockchip,inno-usb2phy.yaml | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>> index 5254413137c64..214917e55c0b6 100644
>> --- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>> @@ -20,6 +20,7 @@ properties:
>>         - rockchip,rk3366-usb2phy
>>         - rockchip,rk3399-usb2phy
>>         - rockchip,rk3568-usb2phy
>> +      - rockchip,rk3576-usb2phy
>>         - rockchip,rk3588-usb2phy
>>         - rockchip,rv1108-usb2phy
>>   
>> @@ -34,10 +35,16 @@ properties:
>>       const: 0
>>   
>>     clocks:
>> -    maxItems: 1
>> +    minItems: 1
>> +    items:
>> +      - description: phyclk - PHY input reference clocks.
>> +      - description: aclk and aclk_slv are optional and used for USB MMU.
>>   
>>     clock-names:
>> +    minItems: 1
>>       const: phyclk
>> +    const: aclk
>> +    const: aclk_slv
> Please test... Not sure what you wanted to achieve here, but maybe
> oneOf?

The "aclk" and "aclk_slv" clocks are new in RK3576, you mean the changes 
should be like the below?

@@ -34,10 +35,20 @@ properties:
      const: 0

    clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3

    clock-names:
-    const: phyclk
+    minItems: 1
+    maxItems: 3
+    items:
+      oneOf:
+        - description: PHY input reference clocks.
+          const: phyclk
+        - description: aclk for USB MMU.
+          const: aclk
+        - description: aclk_slv for USB MMU.
+          const: aclk_slv


BR.
Frank

> Best regards,
> Krzysztof
>


