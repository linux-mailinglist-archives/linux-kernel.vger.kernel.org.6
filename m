Return-Path: <linux-kernel+bounces-217981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6086190B746
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BD6281C29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C11168490;
	Mon, 17 Jun 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KM4OWEYX"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD034157A41;
	Mon, 17 Jun 2024 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643720; cv=none; b=guP0OBykLZ/Ne7maQSwYTjRkxt1jSf6uZRuYrqo46AXW5/zlSFgFqOH14EQguB9vTJ16ZoDoVcYUTHBc1m+UD9MRry8CBzpPakgyU2mljso84iNtM4V//ilNTf0A9aD+4fHFIaJDy8RhARVWrldZQ+ylNnU638xhtXZIBGCVRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643720; c=relaxed/simple;
	bh=wtL6BUiOyxgQMb6ipUZusWcyMpN5m6U1Y2uACLuLyJs=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=VKJySc6SVLYNIaMIViI9Qf06huD28Pj/cCBdJs4X1/AYN/avTZFEIas6BJOczw5+x6wJQckst+P2LI3gIPiXv4757BTSIe2m2oDWOb8plYnBesHScs6+H9RK/m51eQlZNQt7lBIxrfPq/s16n/Xmy0O6WbYjiiL65hA9TRoo65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KM4OWEYX; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718643708; bh=ptOjrwdiruXfiPRbkPbyESZEkYeF5JqwOz+w8fsnr24=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=KM4OWEYXz2pBIQ0/Jx6HuePCjow4lZ4OFfv106kYW+ESlxRbiMlsMkaQ/NFnjA4CS
	 iV2gIx3qJXvdKlQACJu32IHCV5bpZskrDzoASv4zaQ0uB7vsHYYvUqPVVWWdq/s944
	 licaDwYHex6zsB1bGRw9vpu3KPe8R1iai6JUtg5U=
Received: from smtpclient.apple ([2408:8207:18a1:9700:9c85:7ae:3ee:45fe])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 6DA4896; Tue, 18 Jun 2024 01:01:45 +0800
X-QQ-mid: xmsmtpt1718643705t949zch05
Message-ID: <tencent_296E424C52C850A3095F8CA0B07698E30D06@qq.com>
X-QQ-XMAILINFO: MziGzrjZeogZA2yb15PwWH+GJ01zzp4/qBKBYADeYSFB8UC7ogZnJZFUk1XMIj
	 fih8FkF7TT7M+PokWHjQ+iIhxR/+qoTffjDIEMjMoEzqo7jGzuqdabu0VDlSAPnGqhHExikl/WJm
	 RHdW9NR2HI89ird6Ekd9TDkVw5zR4OptUmXIG0PJ9lBT2OcVnLKVYRMbapT3rvkR2jhGDCWn7cnf
	 ooZX4xHSJP9fNRxJ/hE9ya7YZD+U4oz6MR1H1juPcqubzrqfTUMdaWHSuh+nkmShdxmtxDtkDSSw
	 si5vSgZMtHK/DhN3fbDzD4eG/mj0f53Xq2phMP7KJXTQnXa/rl15fXH/lvPmagjfuqRVXfRwl/Ok
	 +VDn/ISoVl04oW6uawIujzNLWptS1tIjchCy7d5su8KCUnPAofKUw3AdHfXZMINibQiWSFm7BVjx
	 qXQj09HHv4FNFcZTRzfce0FWsawWaz7KQEpVrNpESJDk9nLCIVvbMxu7Cl6IutueRxoJls1thVqw
	 lF9gyHeP6qFZzFzkEACeVDtP4KEu//50fhpDEDrw8Q/BM9C4N/d0tTJTiYCgGSUfasR2zBR/Gm6d
	 hWAKZpJfSTCc5XqWjTctvYXLwOv18ZUQou2WOEZ99BZhaKEcPtimU67T1B0rW7BJUayuG/tbN/3u
	 mrz7OZdG94YDFlTbJ8+EQG5zOW/EDwaHlO5u9SIo3d0134R+sZkh3FyhhwCFo1dpBeOYnBXu5ood
	 G6F3xy4GLIyzFTawgNCm7Rm7axjRGjodn3ZdZyMEuvn7nRGhvQ/ewQnkvPe53rVRs1WVnY20w0NP
	 oqautRdBiA5t0kxF++fr2XyfLLn6MKdhuyNkMh6W7dLb7lO0+deYAQCqOGWFg9avHVOHCt8d808s
	 n6bBVtLtTsl6lVuSt+ty/TJ4vXve1BHiMaYWqr3xmWDaacT9od3aNfizhr5koBU7CamalxoMmnwN
	 aArNIcH6DDhWDYMNzIFu2ZdODtE72Ed8N+7b5sCjpuAm+P3RHwPetpK7WwDqzWqy4Bxs0gPgo=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1 7/9] riscv: dts: add initial SpacemiT K1 SoC device
 tree
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <ZnA6pZLkI2StP8Hh@xhacker>
Date: Tue, 18 Jun 2024 01:01:32 +0800
Cc: Conor Dooley <conor.dooley@microchip.com>,
 linux-riscv@lists.infradead.org,
 Conor Dooley <conor+dt@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>,
 Anup Patel <anup.patel@wdc.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <BD2E7EB4-6525-4274-88D0-35005AFB32B1@cyyself.name>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <tencent_701082E2DAE48E2FB857316321778D737C08@qq.com>
 <ZnAw9QrSD-svYqQ5@xhacker> <20240617-carat-poise-ee63ed6a224e@wendy>
 <ZnA6pZLkI2StP8Hh@xhacker>
To: Jisheng Zhang <jszhang@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jun 17, 2024, at 21:31, Jisheng Zhang <jszhang@kernel.org> wrote:
>=20
> On Mon, Jun 17, 2024 at 02:29:46PM +0100, Conor Dooley wrote:
>> On Mon, Jun 17, 2024 at 08:49:57PM +0800, Jisheng Zhang wrote:
>>> On Mon, Jun 17, 2024 at 01:20:52AM +0800, Yangyu Chen wrote:
>>>> Banana Pi BPI-F3 motherboard is powered by SpacemiT K1[1].
>>>>=20
>>>> Key features:
>>>> - 4 cores per cluster, 2 clusters on chip
>>>> - UART IP is Intel XScale UART
>>>>=20
>>>> Some key considerations:
>>>> - ISA string is inferred from vendor documentation[2]
>>>> - Cluster topology is inferred from datasheet[1] and L2 in vendor =
dts[3]
>>>> - No coherent DMA on this board
>>>>    Inferred by taking vendor ethernet and MMC drivers to the =
mainline
>>>>    kernel. Without dma-noncoherent in soc node, the driver fails.
>>>> - No cache nodes now
>>>>    The parameters from vendor dts are likely to be wrong. It has =
512
>>>>    sets for a 32KiB L1 Cache. In this case, each set is 64B in =
size.
>>>>    When the size of the cache line is 64B, it is a directly mapped
>>>>    cache rather than a set-associative cache, the latter is =
commonly
>>>>    used. Thus, I didn't use the parameters from vendor dts.
>>>>=20
>>>> Currently only support booting into console with only uart, other
>>>> features will be added soon later.
>>>=20
>>> Hi Yangyu,
>>>=20
>>> Per recent practice of cv1800b and th1520 upstream, I think a =
complete
>>> initial support would include pinctrl, clk and reset, I have =
received
>>> the complains from the community. So can you please bring the =
pinctrl
>>> clk  and reset at the same time?
>>=20
>> What sort of complaints have you got? That the support is too minimal =
to
>> be useful?
>=20
> For example =
https://lore.kernel.org/linux-riscv/95c20c6c-66cd-4f87-920b-5da766317e19@s=
ifive.com/
>=20
> Now, I think it's better to "model the clocks/resets/other =
dependencies"
> in the initial support. So lacking of pinctrl, clk and reset doesn't
> fully describe the hardware.

Sound like a good idea. In this case, we don't need to change the
dts repeatedly after a new soc driver is supported.=


