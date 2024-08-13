Return-Path: <linux-kernel+bounces-285156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39CE9509EE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8594A28444F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341341A0AFF;
	Tue, 13 Aug 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDv/+DQj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571621E4A4;
	Tue, 13 Aug 2024 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565609; cv=none; b=AD0Z6/3tghtZ682jhjE1gpe0G1+pfnjwdRJrQ+0L0RfgkFKg4eaDq3VvwiY5vHOO6/u8VX3tu4TEyl1xBnA+hsYDGqry6XZeplsH97rH5Ged491qOrEyyyjbkOKfaiwz3k6ebLA6mjNorYlyzNujYZ6PA15lEdKY8QFGxkdW1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565609; c=relaxed/simple;
	bh=h2BeFQK3DLcs/Jg9Vk0JShwrd1NezEHeMiQ/ep02v2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCDhDKGrMUlMcBlRYhIMIMndvx5BKhQXuYDuHcdJQUk2tiEHE8lgOcxQMFoVJS22EfdXxNg+7xjFynLPz1luhneVUdXp1LVYsfvqQ21EBhkTaik9810lOrSY9y2AdAdqa4Xl1k/V2TRcFVcC7BRr45mAj44GzgCPkelB1+ttlag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDv/+DQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337CAC4AF09;
	Tue, 13 Aug 2024 16:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723565609;
	bh=h2BeFQK3DLcs/Jg9Vk0JShwrd1NezEHeMiQ/ep02v2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BDv/+DQjCxjr2puq9Q7MwTV3rHZjhrL65scHfUeykCnHDoR1zos9MBfesWEW82yMF
	 slqsHb56s4HWatg/OEJK62WR/NC/DZpAqO+MytVcTay0rbHyY++e6n/1LZWMjnEomy
	 /c+D6xvBiWT3QJRakET4hzXMOGtxXUxJcqJwPev34fD3XJ0j8xNMmsiul2WHBqrUWe
	 0Tki9Rv21jTW17JkZXC/ESqgqLlOrIPHPkmCt9elaC1W7yZMy6vPvr9JoMwNvJOkqn
	 62viS4pBKu0GZgiqRu1shFB2ykNH+NGD2kB94gelVgcFJRkvVi+UTHgIxon6YaK8bx
	 J/e4321XFIvcA==
Message-ID: <0ef4d4ee-f8b7-4fca-b382-ebaa6b7ee050@kernel.org>
Date: Tue, 13 Aug 2024 18:13:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ARM: dts: imx6qdl: Rename USB hub node name
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux@ew.tq-group.com
References: <20240812143431.98323-1-Markus.Niebel@ew.tq-group.com>
 <1901821.CQOukoFCf9@steina-w>
 <82ee2be2-366e-40b2-ac95-e755443032be@kernel.org>
 <2621134.Lt9SDvczpP@steina-w>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <2621134.Lt9SDvczpP@steina-w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2024 13:02, Alexander Stein wrote:
> Am Dienstag, 13. August 2024, 11:44:28 CEST schrieb Krzysztof Kozlowski:
>> On 13/08/2024 11:27, Alexander Stein wrote:
>>> Am Dienstag, 13. August 2024, 11:20:08 CEST schrieb Krzysztof Kozlowski:
>>>> On 12/08/2024 16:34, Markus Niebel wrote:
>>>>> From: Alexander Stein <alexander.stein@ew.tq-group.com>
>>>>>
>>>>> According to microchip,usb2514.yaml the node name shall be usb-hub.
>>>>
>>>> That's not true. The schema does not say anything like this. Old name is
>>>> correct. NAK.
>>>
>>> So, is the schema incorrect? There is the dtbs_check warning:
>>> arch/arm/boot/dts/nxp/imx/imx6q-mba6b.dtb: hub@1: $nodename:0: 'hub@1' does not match '^usb(@.*)?'
>>>         from schema $id: http://devicetree.org/schemas/usb/microchip,usb2514.yaml#
>>
>> If you have a warning, shorten it and paste it so this will be obvious.
>> If you look at several bindings, the hub is widely used name. I think
>> the schema is not correct here - I do not see any properties from
>> usb.yaml being used here (for usb2514). What's more, if you compare
>> usb2514 with any other on-board HUB representations (because that's the
>> only point why we have it in bindings, right?), none of them reference
>> usb(-hcd)?.yaml.
>>
>> These are not USB controllers, IMO.
> 
> I raised that concern in [1] already, but nobody commented.

With 200 new emails in my inbox every day, I bet I miss many threads...

The nodes could be named usb-hub, makes sense, but:
1. Several bindings examples have hub, so we would need to correct all
of them for consistency?

2. For me hub is generic and obvious enough. Just like "phy", even
though DT spec has "usb-phy".

3. Renaming nodes to fix issues is very good. Renaming just to make
things more readable is also good or because coding style asks for it.
Renaming just because one person likes hub, other likes usb-hub, so just
personal preference, is for me churn. Considering it sometimes breaks
some users (it is not ABI... till it is), personal preference is poor
reason.

I think the schema should be fixed, because this is not an USB
controller, in terms how we call things which are "USB controllers". On
the bus it is USB device and USB hub. For USB device we have schema. For
USB hub we don't, so it does not matter.

Best regards,
Krzysztof


