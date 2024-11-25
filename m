Return-Path: <linux-kernel+bounces-420754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3805B9D82D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB1A163F72
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803FA194A65;
	Mon, 25 Nov 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZIGvJkMl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41C193070;
	Mon, 25 Nov 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528116; cv=none; b=P0IETgIwY0t03zE3No7qCPNghq/ZtYT4xuJB7YqAsnDZP+I1vYfGrzbCd/6YRfy7YQ6J9mnJkLWHJDKqnZiUk2Qu7ESOWoumCzxx1gke6szalNUZezubITONmC5htchxuezR+EfAW+tk1b7uidslkcpgpvhbIepIsbeRX1elAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528116; c=relaxed/simple;
	bh=xjFVmTiejNfLGymZmTJjeWiE7RMUlR67+u0DzoVZfkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kmdyx3mmgPNCo56Qqel3oIyx6O6rIkykgszY1YZAZ2q2U4rZGW7NAUCzkQoEju7Z+mDH1pEutAif4mHpM5u+MmVzQxINSUsZtsiRXB4fVNXin/Y6nTCXPH1QmaqM8NF1H2JkUCdEpZS04K7zAax5mX4soQZHdYs8CkhBsnCDR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZIGvJkMl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732528113;
	bh=xjFVmTiejNfLGymZmTJjeWiE7RMUlR67+u0DzoVZfkw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZIGvJkMl8FjWlk3eJDolvdTpNwKQ0/BnFOvz+lMKWSNIMVRRFBaar1ie/pXq4ywHZ
	 QlTf+DwWC+l8aIk2UvDDZKQznxUos8a1yHkDVGX0+W76Fzcn8ExVqZTgGEwraPsZut
	 530FEn+vrgmPdbDWhNT1DFotLfIpndUGS1Av2FBmPiHd5jkZdXSgEvowoyd75C8vp5
	 oa2AMiWA6lvYvPQJb8xapxL5g6Fs5YrYIKzFr+VpWcuyTAmx3DDnuPGm1I/qiWArp5
	 53i6mMzmRRLjKo48Tbx4/BtJyWjs66uQhyAvBVcBHH9yNhXsujTLF9yuZu9Fn/wG0g
	 jzd0+JVWoV86A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9620717E1437;
	Mon, 25 Nov 2024 10:48:32 +0100 (CET)
Message-ID: <936bf452-3d1f-4940-9a91-69efcdc6985e@collabora.com>
Date: Mon, 25 Nov 2024 10:48:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Devicetree updates for v6.13
To: Sasha Levin <sashal@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Saravana Kannan <saravanak@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20241118210730.GA3331421-robh@kernel.org>
 <Z0NUdoG17EwuCigT@sashalap> <c25e6a80-f6dc-4ef9-a90d-0fa09cbbc217@linaro.org>
 <Z0NbeyTwxo-M4Lgi@sashalap>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <Z0NbeyTwxo-M4Lgi@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 24/11/24 17:59, Sasha Levin ha scritto:
> On Sun, Nov 24, 2024 at 05:47:33PM +0100, Krzysztof Kozlowski wrote:
>> On 24/11/2024 17:29, Sasha Levin wrote:
>>> Hi Rob,
>>>
>>> On Mon, Nov 18, 2024 at 03:07:30PM -0600, Rob Herring wrote:
>>>>      of: WARN on deprecated #address-cells/#size-cells handling
>>>
>>> With the commit above, I've started seeing boot warnings on a few
>>
>> And same boards do not report problems on the next?
> 
> Looks like they do. I haven't checked it previously, but I see that we
> have similar warnings on a few boards that KernelCI is testing -next on.
> 

That's... horrendous.

I hope that we can get a proper fix with a bootloader update on these (now very
old) devices... Adding a Google engineer to the loop so that he can follow up
internally.

The alternative would be to hack-in a firmware node to mt8183-kukui.dtsi, but....
...ugh. That'd be indeed a hack for the sole purpose of fixing a bootloader that
is acting in a broken way, and I don't like that at all (...and I'm sure I'm not
alone!).

Thanks,
Angelo

