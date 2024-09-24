Return-Path: <linux-kernel+bounces-336901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FFC98424E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74FB1F21AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26DF156885;
	Tue, 24 Sep 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="WMpbZWqI"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D41422C7;
	Tue, 24 Sep 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170627; cv=none; b=lznvx5pz63/Vl661agcoUvMnA8gEMYFJbK/hs0KDVpGZYLijXTu87z3xgCvMGCGmYFHmgPetcUjHvfIiSM6tLejrIdYfx5x8fFu21B1tgug/Uwu2LElt451wY1BmLBMoV+1Lpb/71lplLTYhUaBaREh9Akno83kjuECEIh5eYHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170627; c=relaxed/simple;
	bh=vuDTpg6UMascH2rWGdBGzBTcGLiXrBPlpImeA3KxPss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxV5XMvan/QWg22d18uKPeqiOM7JeG6XDiziwdwxpYqf6TtEpkf8YlZVkVKCn+NjXsJ1toBn81jOGAUThm/wv0aTAEYeO9aJ20NZXVETKu6a1GqMH4j7F/PZjHmcrNyHkKCmfO4w486uXcvQjundoy2ZqKNW+B+wxFTWztmsRUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=WMpbZWqI; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1727170624;
	bh=TxQenD4CQSIAgF7/qgiB9E/eSJ/Cwpk9mCw/tDCSPvs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WMpbZWqI6G3prV5QbOOqjgdUAiCqZYloJK0vou7uaYJ11NLuUrT5bOysjtEIXLNkq
	 ACI9/06lyVXKKkfuU4dGhTU3jB0m/9ARtfc1MGdLsABJKTAgGVjpBZ3MvyI27LIVzW
	 bPAYrK4bdrL0GZ5dfTTznKMiKMmBEz0lCH3L1hBU=
Received: from [10.1.8.111] (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id B2830A0419;
	Tue, 24 Sep 2024 11:37:03 +0200 (CEST)
Message-ID: <40d982aa-79b9-49f7-b5d8-d7cc2510fe35@ysoft.com>
Date: Tue, 24 Sep 2024 11:37:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add support for new IMX8MP based board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Shawn Guo <shawnguo@kernel.org>, Petr Benes <petr.benes@ysoft.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Herburger <gregor.herburger@ew.tq-group.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Michael Walle <mwalle@kernel.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20240923151417.1665431-1-michal.vokac@ysoft.com>
 <vghktkih6pdjrui7sjs2gn2elfcdlplh37ahzcm2xnqin3rh4g@cck4xniyourm>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <vghktkih6pdjrui7sjs2gn2elfcdlplh37ahzcm2xnqin3rh4g@cck4xniyourm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24. 09. 24 10:22, Krzysztof Kozlowski wrote:
> On Mon, Sep 23, 2024 at 05:14:13PM +0200, Michal Vokáč wrote:
>> Hi,
>>
>> this series adds support for a new member in our IOTA platform.
>> The board is based on the i.MX8MP SoC. The first two patches
>> add support for most of the board functionality except USB Type-C
>> port and some other minor things.
>>
>> [PATCH 3] adds new device tree binding for a Diodes Incorporated
>> PI5USB30213A Type-C Controller and [PATCH 4] enables that port on
>> the IOTA2 Lumpy board.
>>
>> We also wrote a driver for that Type-C port controller. I would like
>> to get that driver upstream as well but I expect it will take much
>> more iterations and effort to get it into mainline-ready shape so
>> I intentionally excluded it from this series. AFAIK it should not
>> be a problem to accept a device tree binding for a HW that does not
>> have a driver in the kernel yet.
> 
> It's unusual but okay. It will be however more difficult for you - any
> changes in the binding in the future (when writing driver) will be
> rejected on basis of breaking ABI, even if Linux does not use that ABI.
OK, your argument is valid and I would be better on the safer side.
I will remove the binding for the Type-C controller from this series
and post it a bit later including the driver.

I will reduce this series to just add basic support for the board.
Can I keep your R-b tag for the Type-C dt-binding for the future
submission or should I better remove it?

Best regards,
Michal

