Return-Path: <linux-kernel+bounces-558993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10AAA5EE1C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201543BC81F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F430260A53;
	Thu, 13 Mar 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="J7uDMJrM";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="AFuXUWzv"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7BB1F9A86;
	Thu, 13 Mar 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854899; cv=pass; b=S/VrLQ+xtOpxb8h3p/Kq/HxAbsyuH0uuc8gppItsghPJp0jtgxR8H3NpF6ztSgFcsoQhpYiFzXdMXNwtWDwSZxKJYgTZPpXXkJKUMIo4Gk1XTydvyzwVrICdsnNLWnPyzc4ovsQ2qfl4pM0gI6A7KZ/pPthZopV9iOY2fUZ/y30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854899; c=relaxed/simple;
	bh=TvPgfQVJdTV+mJrbL/dhgnG112bfurG5AbBdaQkNOyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwBXgzPQ48/BhptuH7fCSlUKXKJjl765JqbqdStJ6/ds+V7yahjoma0+Wa2jd8W/0cF+JvC5ORCQdgRFkHaMsqFwLQImjPNW2Dv92brB/1q/aOpdGlE6fb5ajfJYcOTLslE8JZdQmJTmThElEL7BMnFLYOJPEyTmtNhFBGKWQdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=fossekall.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=J7uDMJrM; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=AFuXUWzv; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fossekall.de
ARC-Seal: i=1; a=rsa-sha256; t=1741854893; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KEPvXMGotsjK1iqztyIGMqzbe7HTl1dCtkOsT4nwTU8gfy3AK18fa8KnOYFe/zHOWO
    LaAZm21k+aZQkn2Fy8zZybyB7AUQwsj9BiNBqpAQyDEb7NQ+Zrumpl0yBYzHVIvCKnD0
    GDl4jZvrMx1w4ppFIg3+zduE6YmvZPcVk22+6y58E1QaI+Eyky+Vslsl2W1ESbJxWnmt
    YSiydrp+Bg8mUJ1mvTZ+/DDLiKzD1eZIWUK0C/9OGM93AQQtdTdWPLfF5oK63TCVYIX5
    kRkHqfbjAmKbLEQssz4ULvbtl6mmJC4l1HZBK4kutedpQHRzKUdiCBOYavXvmR5Q3K81
    EDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1741854893;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=l/+YQAaORtFq72+AzSNa9rIFM3dYh93tUAjVQzN5T9E=;
    b=Em3ok13s7CI8A1KZ1jqKtbzBsqCm075PymQoL7ryL6ql/1HmxzsK5Pzl/gSrHLrlNm
    6Cbrsu/SVT443nCbliuTEfBrJeaG61K9646/KEWftnwdEswO4sXjpnIUAygNumF6pdtP
    6Qll38h/M0mKqO6z/GkhSFH5HbO0B2Ir0i6O4nFvooGZFEHAeovi20JsI8+CgCQhVIU9
    8IFdCv8VCiOwo+cAyKdmYIwaZickrpGsH/B4NwTpjarfm8r5F3/m19PaCRJii0uX1xnm
    UPX+dOliYwWYUMB7QAVIqKb74w/dFBGyvQH4RNF12CWeDXEPeD6GEnqAokXNndkiOsv9
    COzQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1741854893;
    s=strato-dkim-0002; d=fossekall.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=l/+YQAaORtFq72+AzSNa9rIFM3dYh93tUAjVQzN5T9E=;
    b=J7uDMJrMZaUVnc4m8KoVFsFeclWLcdEbf3jACE+SezKqMZVnhLFEaAWdaqcEai6Bis
    rrO5sEK9is/KLys6ZvUsf1N3DW+/Dj33vET+8lB9S4/2fAJJw3qmjmiNZzbA5s2Mkcef
    qbC2+8Xr98DhVwnfOHz23r82XHovdxnGhCiH0CiV+RJrZQ31A0g5QoQgLm9d+Kf4ZHgb
    3IpOqgIZ7nPjMQvqT5Onge3VsspaYZSj1SRKq+TTXiJ+QyTEyVkICqFSYjDTiwBe/vs3
    X+I9LjrerSXcc3MSaTwpE6UM3sAz5RbywAbIvX/ZWsfdE9WZ4Z+nmWjW9s0qVYO6GC45
    wX1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1741854893;
    s=strato-dkim-0003; d=fossekall.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=l/+YQAaORtFq72+AzSNa9rIFM3dYh93tUAjVQzN5T9E=;
    b=AFuXUWzvpfTYjw7mJqf1HU03u5VMueFtVE1i4UtZqI5Y+XepqOYT52R5M9JjqI+pnn
    x1bDI6X0O8i9XlqPkaDA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512D8Yqmsr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 13 Mar 2025 09:34:52 +0100 (CET)
Received: from aerfugl.home ([192.168.1.2] helo=a98shuttle.de)
	by aerfugl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <michael@fossekall.de>)
	id 1tse1j-0006BM-27;
	Thu, 13 Mar 2025 09:34:51 +0100
Date: Thu, 13 Mar 2025 09:34:50 +0100
From: Michael Klein <michael@fossekall.de>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: bananapi: add support for PHY LEDs
Message-ID: <Z9KYqlfUYxRaWnGQ@a98shuttle.de>
References: <20250312193629.85417-1-michael@fossekall.de>
 <20250312193629.85417-2-michael@fossekall.de>
 <4637912.LvFx2qVVIh@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4637912.LvFx2qVVIh@jernej-laptop>

Hi,

On Thu, Mar 13, 2025 at 07:07:24AM +0100, Jernej Škrabec wrote:
>Dne sreda, 12. marec 2025 ob 20:36:28 Srednjeevropski standardni čas je Michael Klein napisal(a):
>> The Bananapi M1 has three LEDs connected to the RTL8211E ethernet PHY.
>> Add the corresponding nodes to the device tree.
>>
>> Signed-off-by: Michael Klein <michael@fossekall.de>
>
>This is patch 2/2. Which one is patch 1/2? I got only one.

https://patchwork.kernel.org/project/netdevbpf/patch/20250312193629.85417-1-michael@fossekall.de/

Sorry for any inconvenience in case I messed up the patch submission.

I made two commits for this change and submitted them via `git send-email 
HEAD^^`. The first patch went to netdev@vger.kernel.org, the second 
to linux-arm-kernel@lists.infradead.org, which seems logical. Have I 
done something wrong?

>Best regards,
>Jernej

Michael

>
>> ---
>>  .../boot/dts/allwinner/sun7i-a20-bananapi.dts | 27 +++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
>> index 46ecf9db2324..4976453ed192 100644
>> --- a/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
>> +++ b/arch/arm/boot/dts/allwinner/sun7i-a20-bananapi.dts
>> @@ -48,6 +48,7 @@
>>
>>  #include <dt-bindings/gpio/gpio.h>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/leds/common.h>
>>
>>  / {
>>  	model = "LeMaker Banana Pi";
>> @@ -169,6 +170,32 @@ &ir0 {
>>  &gmac_mdio {
>>  	phy1: ethernet-phy@1 {
>>  		reg = <1>;
>> +
>> +		leds {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			led@0 {
>> +				reg = <0>;
>> +				color = <LED_COLOR_ID_GREEN>;
>> +				default-state = "keep";
>> +				linux,default-trigger = "netdev";
>> +			};
>> +
>> +			led@1 {
>> +				reg = <1>;
>> +				color = <LED_COLOR_ID_AMBER>;
>> +				default-state = "keep";
>> +				linux,default-trigger = "netdev";
>> +			};
>> +
>> +			led@2 {
>> +				reg = <2>;
>> +				color = <LED_COLOR_ID_BLUE>;
>> +				default-state = "keep";
>> +				linux,default-trigger = "netdev";
>> +			};
>> +		};
>>  	};
>>  };
>>
>>
>
>
>
>
>

-- 

