Return-Path: <linux-kernel+bounces-228358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1846915EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7961C21678
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E243145FEB;
	Tue, 25 Jun 2024 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="gottfuXy"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0C143889;
	Tue, 25 Jun 2024 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296238; cv=none; b=BYct9S4yQEMe9nLni0m67lJborAiX6IEjBmcIbrZgXn6KIDnVikwubrNvbGSHjmctykLWe8GW0KhLNVvmRuNwYkcxBp3MdtI5G9+HHxAnTCxb/1bh+NLMGYOMIKu3uHqP7XkovBr3i/RzkepRkBXh2gRcCoN3QJNpL94TWO7h6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296238; c=relaxed/simple;
	bh=L8zEZGlYA7775lSVBXfsdb08FWIrc0UKVLyrg5iti+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Prl2nI187GM7T0dxfU0TxtAFgxu3NCyKcb/JacU6Wk8JGFcniF0tUe+5TfQOqy+UsXZV+eU9tw+aN2ZKNmx0R2RVFXy43gk7uOOFIzUNCj/WH8tDqp3ONwfZlx4PuaZQmqDw7stShzMo827MntHzUIsE9SUzKyGuFyBkVv9Fi/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=gottfuXy; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EFA3E0007;
	Tue, 25 Jun 2024 06:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1719296234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lUfaaGjmkEsv8TO+/zIvt/jIaH/4czGbfBiNdDpBPnU=;
	b=gottfuXyiDMseBTnGspopuXIw9529/9Sg8tVXkB/CfX+qkFNzuNLD3y0yeBtuhKxNBAkNe
	ZK5m650lLIhx+QPEZIDBbbwDMsqsxTiecOt3ksKVFyPts+2z8TiWsCmNQYVWFzymGIRTaX
	ahbVGJDQ3Z0cpMZg7en5CRA6laI8pgztW5RsyUdeskY58RAjMeGiQiKEYyXhwLFPen/f7k
	T6LiwaW6m4tAC7Xm2gazxlRsD3SV+CqggSC1Nt/R3OC2k1RNfvPbuPZtBUOY8WtllyfGri
	7Zkj2qEE5eYrmT8yZ1HWrJwS53nlyKa5iXgjb9IGSyDoZrV83rr0CioXdd9y1A==
Message-ID: <7a2ea06b-ae4e-4374-82c2-4de4184e06c3@arinc9.com>
Date: Tue, 25 Jun 2024 09:17:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, frank-w@public-files.de,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20240516204847.171029-1-linux@fw-web.de>
 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
 <43aacd9d-b851-4100-8ccc-878ac6ae10f8@leemhuis.info>
 <698cf562-1ca9-4aa3-be7e-a1474b612c5b@leemhuis.info>
 <0cba095c-3d55-416a-a7ad-b359129731cf@arinc9.com>
 <714da201-654b-4183-8e5e-8ff0b64fe621@leemhuis.info>
 <2cac4cf68304e81abffbd9ff0387ee100323c2b7.camel@redhat.com>
 <b49c801c-6628-40a6-8294-0876d8871ba7@leemhuis.info>
 <e92c3ca0-c9be-44ac-a4fc-57ca5ebedbc5@leemhuis.info>
 <1807a142-1534-4fa4-ad4b-d1c03af014c2@arinc9.com>
 <58d8ddea-71cc-427a-94cc-a95f6bce61d2@collabora.com>
 <16e9c06e-9908-455d-a387-614fefe5bcf8@arinc9.com>
 <5e87d31c-b059-4f9a-93f7-dc87465ed14a@collabora.com>
 <4416ef22-78cc-4ce5-b61d-69ff0903811e@arinc9.com>
 <bd6b6929-d34d-4bd5-9cb0-bc8fe850ee46@leemhuis.info>
 <af561268-9793-4b5d-aa0f-d09698fd6fb0@arinc9.com>
 <750a60a6-4585-4bd2-97be-cf944e51fbdb@leemhuis.info>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <750a60a6-4585-4bd2-97be-cf944e51fbdb@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 25/06/2024 08.56, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 17.06.24 13:08, Arınç ÜNAL wrote:
>> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [...]
>> I've submitted a patch series that fixes the regression. Angelo argued
>> against the way the regression is fixed. I've very clearly argued back why
>> I find Angelo's approach wrong. There's been no response back. I don't
>> understand why reverting the patch is the likely outcome
> 
> Long story short: because that how things like that are handled in the
> Linux kernel project, as Linus wants it like that. See some of the
> quotes from https://docs.kernel.org/process/handling-regressions.html
> for details.
> 
>> whilst the
>> standing argument points towards applying the said patch series. If a
>> revert happens before this discussion with Angelo finalises, this will set
>> a precedent that will tell maintainers that they can have their way by just
>> not replying to the ongoing discussions.
>>
>> That said, the decision of resolving the regression by either reverting the
>> patch or applying the patch series shall not depend on whether or not
>> Angelo is pleased but rather there're no counter-arguments left on the
>> points brought, meaning the decision shall be made depending on the
>> argument that stands.
>>
>> Therefore, I suggest that unless Angelo responds back with a
>> counter-argument in the window of a week or two, as you've described, my
>> patch series shall be applied.
> 
> It looks more and more like we are stuck here (or was there progress and
> I just missed it?) while the 6.10 final is slowly getting closer. Hence:

There hasn't been progress at all. I believe I have clearly described the
way out of this issue.

> 
> AngeloGioacchino, should we ask the net maintainers to revert
> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
> device tree") for now to resolve this regression? Reminder, there is
> nothing wrong with that commit per se afaik, it just exposes a problem
> that needs to be fixed first before it can be reapplied.

Are you suggesting the patch shall be reverted first, then the DT patch
applied, then the reverted patch applied back? If only one of the first two
steps were done, it would fix the regression so I don't understand why go
through this tedious process when we can quite simply apply the DT patch to
resolve the regression.

Keep in mind that I maintain the MT7530 DSA subdriver and the company I
work with has got boards that uses the functionality the commit
868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
device tree") brings.

Arınç

