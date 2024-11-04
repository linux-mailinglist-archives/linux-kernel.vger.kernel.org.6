Return-Path: <linux-kernel+bounces-394803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113109BB42D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E5BB244DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEDA1B4F15;
	Mon,  4 Nov 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Iaj/wtND"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8725E188700;
	Mon,  4 Nov 2024 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721853; cv=none; b=Dt0Y7mUE99lOsfj3UfoBuTt5DBRcEKljlDL7ab9FCgX82S0A9edYIEuLBV+LhxU0vvE633Z1aCmuanhd361VN0Ozt8XhIYp0dBgM76jhEnb6sAY+NuEaqmZZEE8hVgkdhR4W8bBI+jFg9BIOglr+Tya3vLBuf8rSomewtRFaSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721853; c=relaxed/simple;
	bh=5V3k7t/BD3t++beRovDo9rbK7RVpmurTwzAlsqQ9dCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BVyYTxyoHrrjIXT1TrP4o17szTmYIu0Fk84HoKcEV7IF9ek+1xvOZ8I5ZdQnqXe3ODy4gp6l1AycF+fBoopn32NPnwb5sSaJFZIOqT6ffzfd0yI68YotQ7aXk2wI2xCYaCR3hKfgWdGM4leJS1bIM9FIJnusQsEGlueBD4tIcKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Iaj/wtND; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [192.168.1.107] (87-97-112-21.pool.digikabel.hu [87.97.112.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: hs@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 48E0088113;
	Mon,  4 Nov 2024 13:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730721849;
	bh=wF15CK3q+ocViJhOms9ADFB9q0mQckeGq5fArBdv+lo=;
	h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
	b=Iaj/wtNDV1SD0/BijQwuDtssB1toG2nFV66NzthHlMHhmYB25iVlCF1meuY18lgET
	 uvP963YFf7wAYnCpvZeUx8iDCC3wT5rPBV1jdavV2u9t3tibTM8gCUJNyv/7HOFL5o
	 BkT7nY+s5GznUpkJwD6+VrV4ih1cP/2b5jaMma7ksv7+fmR1odoEBI6q9KHa7qg0tE
	 kX7Ub9zA7jVmA4gJIV6omTECtT6isvAouDxrNKTA3V0irX7WoYpriScMRsu1RG3csC
	 ompLI0tA9KsXNZRaSxzMiJsBbTNFDOlQhBs/tQTKU0h+GlcE9m9vCFulAnh6l+AOok
	 25Bx6jlNbBH9A==
Message-ID: <3214def1-4669-79ed-36c2-e19a119aabeb@denx.de>
Date: Mon, 4 Nov 2024 13:01:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] arm64: dts: imx8mp: add aristainetos3 board
 support
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20241031151238.67753-1-hs@denx.de>
 <20241031151238.67753-4-hs@denx.de>
 <CAOMZO5ACMGbhySUbR8r1UUimc53YDaRbfEObyUrf0GLYZcQfjg@mail.gmail.com>
Reply-To: hs@denx.de
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <CAOMZO5ACMGbhySUbR8r1UUimc53YDaRbfEObyUrf0GLYZcQfjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Fabio,

On 04.11.24 12:15, Fabio Estevam wrote:
> Hi Heiko,
> 
> On Thu, Oct 31, 2024 at 12:12 PM Heiko Schocher <hs@denx.de> wrote:
> 
>> +               brightness-levels = < 0  1  2  3  4  5  6  7  8  9
>> +                                    10 11 12 13 14 15 16 17 18 19
>> +                                    20 21 22 23 24 25 26 27 28 29
>> +                                    30 31 32 33 34 35 36 37 38 39
>> +                                    40 41 42 43 44 45 46 47 48 49
>> +                                    50 51 52 53 54 55 56 57 58 59
>> +                                    60 61 62 63 64 65 66 67 68 69
>> +                                    70 71 72 73 74 75 76 77 78 79
>> +                                    80 81 82 83 84 85 86 87 88 89
>> +                                    90 91 92 93 94 95 96 97 98 99
>> +                                   100>;
>> +               default-brightness-level = <80>;
> 
> One suggestion: a more succinct way to represent this would be:
> 
> brightness-levels = <0 100>;
> num-interpolated-steps = <100>;

Thanks for the suggestion!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

